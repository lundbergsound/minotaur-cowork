-- =====================================================================
-- APPLIED 2026-09-11 16:55 UTC to main as migration ledger 58 -> 59,
-- version 20260911165516 (verhist_timer_schedule_and_retention).
--
-- ⚠ This file is the DESIGN OF RECORD. The executed text is in the database
--    ledger and differs from it in COMMENT WORDING ONLY - every statement,
--    identifier and literal is the same. Stated rather than glossed.
--
-- VERIFIED AFTER APPLY, by running each check and not by reading it:
--   * ledger 59, both jobs active in cron.job, owned by postgres
--   * eight privilege attacks - three functions and the log table, as
--     `authenticated` and as `anon` - ALL DENIED 42501
--   * the hourly job fired ON ITS OWN at 17:00:00 UTC: 26 written, 0 failed,
--     2,523 ms; 26 rows carry a NULL created_by, as designed
--   * a second sweep with nothing changed: 0 written, 26 SKIPPED, 1,329 ms
--   * retention proved on a planted 12-row, two-month fixture before apply:
--     5 deleted exactly as predicted, the manual save survived, a production
--     whose only backups were 60 days old kept its newest, blobs untouched
--   * storage after the first full sweep: 7,312 kB for version history,
--     database 43 -> 49 MB. (Arch's pre-apply expectation was ~12 MB - high.)
-- =====================================================================

-- =====================================================================
-- VERHIST-TIMER — the hourly snapshot schedule and the retention rule
-- Migration 59.  Retires nothing; extends migration 58
-- (20260911002959_verhist_mig_project_snapshots_and_blobs).
--
-- SCOPE, from Daniel's rulings:
--   * hourly snapshot of every production, with skip-if-unchanged  (2026-09-10)
--   * retention 48h hourly / 30d daily / weekly after              (2026-09-10)
--   * a manually named Save Version is NEVER auto-cleaned          (2026-09-11)
--   * the retention delete is DATE-ONLY on project_snapshots and
--     NEVER touches project_blobs                                  (2026-09-10)
--   * the retention delete never runs inside a user request        (2026-09-10)
--
-- MEASURED AT SOURCE 2026-09-11, in a rolled-back rehearsal on production:
--   * a full sweep of all 26 productions costs 2,813 ms; worst single
--     production 698 ms.  No pre-filter is needed or wanted.
--   * pg_cron 1.6.4 is already in shared_preload_libraries; the extension
--     registers in pg_catalog and creates schema `cron` carrying
--     cron.schedule(name, schedule, command), cron.job, cron.job_run_details.
--
-- ⚠ pg_cron runs as a superuser, so RLS does NOT apply inside these jobs and
--   auth.uid() is NULL.  An hourly snapshot therefore lands with a NULL
--   created_by.  That is deliberate — nobody pressed anything — and the
--   History screen must render it as "Automatic", never as a blank operator.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. The scheduler
-- ---------------------------------------------------------------------
create extension if not exists pg_cron;

-- ---------------------------------------------------------------------
-- 2. The run log
--    A silently failing backup is this unit's worst failure mode, and
--    cron.job_run_details records only that the command succeeded — not
--    that a production inside it was skipped by an error.  One row per run.
-- ---------------------------------------------------------------------
create table if not exists public.verhist_sweep_log (
  id          bigint generated always as identity primary key,
  ran_at      timestamptz not null default now(),
  kind        text        not null check (kind in ('hourly', 'prune')),
  written     integer     not null default 0,
  skipped     integer     not null default 0,
  failed      integer     not null default 0,
  deleted     integer     not null default 0,
  elapsed_ms  integer     not null default 0,
  failures    jsonb       not null default '[]'::jsonb
);

create index if not exists verhist_sweep_log_ran_at_idx
  on public.verhist_sweep_log (ran_at desc);

alter table public.verhist_sweep_log enable row level security;
-- No policies: with RLS on and no policy, no signed-in user can read or write
-- it.  The jobs run as superuser and bypass RLS.  Revoked as well as unpolicied,
-- because a grant is not narrowed by RLS — the TRUNCATE lesson of migration 58.

revoke all on table public.verhist_sweep_log from public, anon, authenticated, service_role;

-- ---------------------------------------------------------------------
-- 3. The hourly sweep
--    Per-production error isolation is the point of the loop: without the
--    inner begin/exception, one bad production loses the backup of all 26.
-- ---------------------------------------------------------------------
create or replace function public.snapshot_all_projects_v1()
returns jsonb
language plpgsql
security invoker
set search_path to 'public'
set statement_timeout to '5min'
as $fn$
declare
  r          record;
  v_id       uuid;
  v_written  integer := 0;
  v_skipped  integer := 0;
  v_failed   integer := 0;
  v_failures jsonb   := '[]'::jsonb;
  t0         timestamptz := clock_timestamp();
  v_ms       integer;
begin
  -- Transaction-scoped: released automatically however this function exits,
  -- so a crashed sweep cannot wedge every later one.
  if not pg_try_advisory_xact_lock(hashtext('verhist_hourly_sweep')) then
    return jsonb_build_object('status', 'skipped_locked');
  end if;

  for r in select id from projects order by id loop
    begin
      v_id := snapshot_project_v1(r.id, 'hourly', null);
      if v_id is null then
        v_skipped := v_skipped + 1;     -- unchanged since the last snapshot
      else
        v_written := v_written + 1;
      end if;
    exception when others then
      v_failed   := v_failed + 1;
      v_failures := v_failures || jsonb_build_object(
        'project_id', r.id, 'sqlstate', SQLSTATE, 'message', SQLERRM);
    end;
  end loop;

  v_ms := round(extract(epoch from (clock_timestamp() - t0)) * 1000);

  insert into public.verhist_sweep_log (kind, written, skipped, failed, elapsed_ms, failures)
  values ('hourly', v_written, v_skipped, v_failed, v_ms, v_failures);

  return jsonb_build_object(
    'status', 'ok', 'written', v_written, 'skipped', v_skipped,
    'failed', v_failed, 'elapsed_ms', v_ms, 'failures', v_failures);
end;
$fn$;

-- ---------------------------------------------------------------------
-- 4. The retention rule
--    Date-only.  Tiers, per production:
--      age <= 48h  — keep everything
--      48h to 30d  — keep the newest of each calendar day
--      over 30d    — keep the newest of each calendar week
--    Never deleted, at any age: reason = 'manual', and a production's own
--    newest snapshot whatever its reason.
--
--    The two invariants are ASSERTED, not documented: the function counts
--    blobs and manual rows either side of the delete and raises — rolling the
--    delete back — if either moved.  Test the guard, do not read it.
-- ---------------------------------------------------------------------
create or replace function public.prune_project_snapshots_v1()
returns jsonb
language plpgsql
security invoker
set search_path to 'public'
set statement_timeout to '5min'
as $fn$
declare
  v_blobs_before  bigint;
  v_blobs_after   bigint;
  v_manual_before bigint;
  v_manual_after  bigint;
  v_deleted       integer := 0;
  t0              timestamptz := clock_timestamp();
  v_ms            integer;
begin
  if not pg_try_advisory_xact_lock(hashtext('verhist_prune')) then
    return jsonb_build_object('status', 'skipped_locked');
  end if;

  select count(*) into v_blobs_before  from project_blobs;
  select count(*) into v_manual_before from project_snapshots where reason = 'manual';

  with newest as (
    select project_id, max(created_at) as newest_at
      from project_snapshots
     group by project_id
  ),
  tiered as (
    select s.id,
           s.project_id,
           s.created_at,
           case
             when s.created_at > now() - interval '48 hours' then 'live'
             when s.created_at > now() - interval '30 days'  then 'daily'
             else 'weekly'
           end as tier,
           case
             when s.created_at > now() - interval '48 hours' then null::timestamptz
             when s.created_at > now() - interval '30 days'  then date_trunc('day',  s.created_at)
             else date_trunc('week', s.created_at)
           end as bucket
      from project_snapshots s
     where s.reason <> 'manual'          -- Daniel, 2026-09-11
  ),
  ranked as (
    select t.id,
           t.project_id,
           t.created_at,
           row_number() over (partition by t.project_id, t.bucket
                              order by t.created_at desc) as rn
      from tiered t
     where t.tier <> 'live'
  )
  delete from project_snapshots d
   using ranked r, newest n
   where d.id         = r.id
     and r.project_id = n.project_id
     and r.rn         > 1                -- not the survivor of its day or week
     and d.created_at < n.newest_at;     -- never the production's newest

  get diagnostics v_deleted = row_count;

  select count(*) into v_blobs_after  from project_blobs;
  select count(*) into v_manual_after from project_snapshots where reason = 'manual';

  if v_blobs_after <> v_blobs_before then
    raise exception
      'prune_project_snapshots_v1: blob count moved % -> %. The retention delete must never touch project_blobs. Rolled back.',
      v_blobs_before, v_blobs_after;
  end if;

  if v_manual_after <> v_manual_before then
    raise exception
      'prune_project_snapshots_v1: manual snapshot count moved % -> %. Manual saves are exempt from retention (Daniel, 2026-09-11). Rolled back.',
      v_manual_before, v_manual_after;
  end if;

  v_ms := round(extract(epoch from (clock_timestamp() - t0)) * 1000);

  insert into public.verhist_sweep_log (kind, deleted, elapsed_ms)
  values ('prune', v_deleted, v_ms);

  return jsonb_build_object('status', 'ok', 'deleted', v_deleted, 'elapsed_ms', v_ms);
end;
$fn$;

-- ---------------------------------------------------------------------
-- 5. Housekeeping on the two run histories
--    pg_cron writes one cron.job_run_details row per run and prunes none:
--    25 runs a day is ~9,100 rows a year.  Neither history is version
--    history and neither is ever read after 90 days.
-- ---------------------------------------------------------------------
create or replace function public.prune_verhist_housekeeping_v1()
returns jsonb
language plpgsql
security invoker
set search_path to 'public'
set statement_timeout to '5min'
as $fn$
declare
  v_cron_deleted integer := 0;
  v_log_deleted  integer := 0;
begin
  delete from cron.job_run_details
   where end_time < now() - interval '30 days';
  get diagnostics v_cron_deleted = row_count;

  delete from public.verhist_sweep_log
   where ran_at < now() - interval '90 days';
  get diagnostics v_log_deleted = row_count;

  return jsonb_build_object('cron_run_details_deleted', v_cron_deleted,
                            'sweep_log_deleted', v_log_deleted);
end;
$fn$;

-- ---------------------------------------------------------------------
-- 6. Grants — REVOKE FIRST, THEN GRANT.
--    Supabase's default privileges hand EXECUTE on new public functions to
--    PUBLIC and to the Supabase roles; a grant ADDS to that, it does not
--    narrow it.  This is migration 58's TRUNCATE lesson applied ahead of the
--    incident instead of after it.  None of these three is callable by a
--    signed-in user: two of them delete rows, and the third is the timer.
-- ---------------------------------------------------------------------
revoke all on function public.snapshot_all_projects_v1()        from public, anon, authenticated, service_role;
revoke all on function public.prune_project_snapshots_v1()      from public, anon, authenticated, service_role;
revoke all on function public.prune_verhist_housekeeping_v1()   from public, anon, authenticated, service_role;

grant execute on function public.snapshot_all_projects_v1()      to postgres;
grant execute on function public.prune_project_snapshots_v1()    to postgres;
grant execute on function public.prune_verhist_housekeeping_v1() to postgres;

-- ---------------------------------------------------------------------
-- 7. The schedule.  Times are UTC.
--    Hourly on the hour; the prune at 09:00 UTC — 05:00 New York — which is
--    the one hour a theatrical production is reliably not in a tech.
-- ---------------------------------------------------------------------
select cron.schedule(
  'verhist-hourly-snapshot',
  '0 * * * *',
  $job$select public.snapshot_all_projects_v1();$job$
);

select cron.schedule(
  'verhist-daily-prune',
  '0 9 * * *',
  $job$select public.prune_project_snapshots_v1(); select public.prune_verhist_housekeeping_v1();$job$
);

-- =====================================================================
-- End VERHIST-TIMER.  Post-apply verification is in the proof script:
-- both jobs present and active in cron.job, the three functions callable by
-- postgres and by nobody else — proven by RUNNING the call as authenticated
-- and catching the denial, never by reading the grant table.
-- =====================================================================
