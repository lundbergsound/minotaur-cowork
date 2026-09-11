-- VERHIST-MIG — durable per-production version history: the schema
-- Arch, 2026-09-11. Trigger B. Rehearsal-first.
--
-- Creates:
--   project_blobs      — content-hash deduped store for the large NEAR-STATIC
--                        components of a production (the equipment library and
--                        the import identity map). Written once per distinct
--                        content, referenced by every snapshot that shares it,
--                        and NEVER EXPIRED (VERHIST-LIBDEDUP, Daniel 2026-09-11).
--   project_snapshots  — one row per snapshot: the spine payload inline, plus
--                        hashes pointing at the blobs above.
--   snapshot_project_v1 — builds and writes a snapshot; skips when nothing changed.
--
-- Does NOT create: the hourly timer or the retention delete. Those are a second,
-- small migration, gated on one ruling from Daniel about whether a manually
-- named "Save Version" is exempt from retention (user-visible => Parity Rule).
--
-- Measured before writing (2026-09-11, live, as `authenticated` with RLS on and
-- statement_timeout armed at 8s, BVSC US Tour 57874c69 — the largest production):
--   build 20-table spine payload ......... 239 ms   3,679,921 B text -> 605,294 B stored (16.4%)
--   build equipment library .............. 067 ms   1,712,688 B text -> 310,714 B stored (18.1%)
--   build import identity map ............ 083 ms   1,583,434 B text -> 593,066 B stored (37.5%)
--   sha256 both hashes ................... ~30 ms
--   writes ............................... 068 ms
--   TOTAL ................................ ~400 ms against an 8,000 ms budget
--   four repeat runs: 383 / 323 / 315 / 318 ms
--
-- Standards applied: SECURITY INVOKER; search_path=public; EXECUTE to
-- authenticated and postgres only, anon never granted; RLS on both tables with
-- auth.uid() WRAPPED as (select auth.uid()) per RLS-INITPLAN, which the 53
-- existing tables do not do and which is free correctness on new objects.

-- ---------------------------------------------------------------- project_blobs

create table public.project_blobs (
  project_id    uuid        not null references public.projects(id) on delete cascade,
  kind          text        not null,
  content_hash  text        not null,
  payload       jsonb       not null,
  created_at    timestamptz not null default now(),
  constraint project_blobs_pkey primary key (project_id, kind, content_hash),
  constraint project_blobs_kind_check check (kind in ('library','identity_map'))
);

comment on table public.project_blobs is
  'Content-hash deduped store for large near-static components of a production. '
  'Rows are NEVER deleted by retention: reference-counted expiry was declined on '
  'measurement (VERHIST-LIBDEDUP, 2026-09-11) because its failure mode — deleting '
  'a blob a live snapshot still needs — sits in the path a restore depends on.';

alter table public.project_blobs enable row level security;

create policy project_blobs_read on public.project_blobs
  for select to authenticated
  using (
    project_id in (select id from public.projects where owner_id = (select auth.uid()))
    or project_id in (select project_id from public.project_members
                       where user_id = (select auth.uid()) and accepted_at is not null)
  );

create policy project_blobs_write on public.project_blobs
  for all to authenticated
  using (
    project_id in (select id from public.projects where owner_id = (select auth.uid()))
    or project_id in (select project_id from public.project_members
                       where user_id = (select auth.uid()) and accepted_at is not null
                         and role = any (array['editor','owner']))
  )
  with check (
    project_id in (select id from public.projects where owner_id = (select auth.uid()))
    or project_id in (select project_id from public.project_members
                       where user_id = (select auth.uid()) and accepted_at is not null
                         and role = any (array['editor','owner']))
  );

-- ------------------------------------------------------------ project_snapshots

create table public.project_snapshots (
  id                  uuid        primary key default gen_random_uuid(),
  project_id          uuid        not null references public.projects(id) on delete cascade,
  payload             jsonb       not null,
  payload_hash        text        not null,
  library_hash        text,
  identity_map_hash   text,
  reason              text        not null,
  label               text,
  created_by          uuid        references public.profiles(id),
  created_at          timestamptz not null default now(),
  constraint project_snapshots_reason_check check (
    reason in ('hourly','manual','change_all','delete_found','delete_all','import_apply')
  )
);

comment on table public.project_snapshots is
  'One row per version-history snapshot. payload holds the production spine '
  '(20 tables) inline; the equipment library and import identity map are held by '
  'reference in project_blobs, because both change only on import and would '
  'otherwise be copied into every hourly snapshot.';

alter table public.project_snapshots enable row level security;

create index project_snapshots_project_created_idx
  on public.project_snapshots (project_id, created_at desc);

create index project_snapshots_project_hash_idx
  on public.project_snapshots (project_id, payload_hash);

create policy project_snapshots_read on public.project_snapshots
  for select to authenticated
  using (
    project_id in (select id from public.projects where owner_id = (select auth.uid()))
    or project_id in (select project_id from public.project_members
                       where user_id = (select auth.uid()) and accepted_at is not null)
  );

create policy project_snapshots_write on public.project_snapshots
  for all to authenticated
  using (
    project_id in (select id from public.projects where owner_id = (select auth.uid()))
    or project_id in (select project_id from public.project_members
                       where user_id = (select auth.uid()) and accepted_at is not null
                         and role = any (array['editor','owner']))
  )
  with check (
    project_id in (select id from public.projects where owner_id = (select auth.uid()))
    or project_id in (select project_id from public.project_members
                       where user_id = (select auth.uid()) and accepted_at is not null
                         and role = any (array['editor','owner']))
  );

-- ------------------------------------------------------------------- the grants
-- Matches ledger 57's four RPCs: authenticated and postgres, anon never.
--
-- ⚠ REVOKE FIRST, AND THIS IS NOT BOILERPLATE — the proof run of 2026-09-11
-- caught it. Supabase's default privileges grant TRUNCATE, REFERENCES and
-- TRIGGER on every new table in `public` to BOTH `authenticated` and
-- `service_role`. A bare `grant select, insert` does not narrow that; it adds to
-- it. TRUNCATE IS NOT FILTERED BY RLS, so shipping the defaults would let any
-- signed-in user empty version history for every production in the database —
-- and would add two more objects to the ten GRANT-TRUNCATE already records.
-- The first proof run of this migration granted exactly what was intended and
-- the privilege-level check still showed TRUNCATE on both new tables.

revoke all on public.project_snapshots from public, anon, authenticated, service_role;
revoke all on public.project_blobs      from public, anon, authenticated, service_role;

grant select, insert, update, delete on public.project_snapshots to authenticated;
grant select, insert                 on public.project_blobs      to authenticated;
-- deliberately NO delete/update on project_blobs for authenticated: blobs are
-- append-only and never expired. Retention touches snapshots only.

-- -------------------------------------------------------- snapshot_project_v1

create or replace function public.snapshot_project_v1(
  p_project_id uuid,
  p_reason     text,
  p_label      text default null
) returns uuid
language plpgsql
security invoker
set search_path = public
as $fn$
declare
  v_payload    jsonb;
  v_library    jsonb;
  v_identity   jsonb;
  v_p_hash     text;
  v_lib_hash   text;
  v_idm_hash   text;
  v_prev       record;
  v_id         uuid;
begin
  if p_reason is null or p_reason not in
     ('hourly','manual','change_all','delete_found','delete_all','import_apply') then
    raise exception 'snapshot_project_v1: unknown reason %', p_reason;
  end if;

  -- 1. the production spine, 20 tables.
  --    box_details and rf_device_details carry NO project_id — they are keyed on
  --    the equipment spine id — so they are reached by join. A snapshot that
  --    filtered on project_id alone would silently capture no boxes.
  select jsonb_build_object(
    'schema_version',     1,
    'project',            (select to_jsonb(t) from projects t where t.id = p_project_id),
    'equipment_items',    (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from equipment_items t where t.project_id = p_project_id),
    'cable_details',      (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from cable_details t where t.project_id = p_project_id),
    'cable_mult_lines',   (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from cable_mult_lines t where t.project_id = p_project_id),
    'tail_details',       (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from tail_details t where t.project_id = p_project_id),
    'box_details',        (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from box_details t where t.id in (select e.id from equipment_items e where e.project_id = p_project_id)),
    'rf_device_details',  (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from rf_device_details t where t.id in (select e.id from equipment_items e where e.project_id = p_project_id)),
    'box_types',          (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from box_types t where t.project_id = p_project_id),
    'bundles',            (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from bundles t where t.project_id = p_project_id),
    'categories',         (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from categories t where t.project_id = p_project_id),
    'methods',            (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from methods t where t.project_id = p_project_id),
    'cable_types',        (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from cable_types t where t.project_id = p_project_id),
    'link_groups',        (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from link_groups t where t.project_id = p_project_id),
    'link_group_members', (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from link_group_members t where t.project_id = p_project_id),
    'cover_letters',      (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from cover_letters t where t.project_id = p_project_id),
    'cast_members',       (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from cast_members t where t.project_id = p_project_id),
    'circuits',           (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from circuits t where t.project_id = p_project_id),
    'walkie_channels',    (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from walkie_channels t where t.project_id = p_project_id),
    'walkie_assignments', (select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from walkie_assignments t where t.project_id = p_project_id),
    'maintenance_history',(select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) from maintenance_history t where t.project_id = p_project_id)
  ) into v_payload;

  if v_payload -> 'project' is null or v_payload -> 'project' = 'null'::jsonb then
    raise exception 'snapshot_project_v1: project % not visible', p_project_id;
  end if;

  -- 2. the two near-static components, held by reference.
  select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) into v_library
    from equipment_library_items t where t.project_id = p_project_id;
  select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) into v_identity
    from import_identity_map t where t.project_id = p_project_id;

  v_p_hash   := encode(sha256(convert_to(v_payload::text,  'UTF8')), 'hex');
  v_lib_hash := encode(sha256(convert_to(v_library::text,  'UTF8')), 'hex');
  v_idm_hash := encode(sha256(convert_to(v_identity::text, 'UTF8')), 'hex');

  -- 3. skip-if-unchanged. A manual Save Version always writes: the operator
  --    pressed a button and expects a row to appear.
  if p_reason <> 'manual' then
    select payload_hash, library_hash, identity_map_hash into v_prev
      from project_snapshots
     where project_id = p_project_id
     order by created_at desc
     limit 1;

    if found
       and v_prev.payload_hash      = v_p_hash
       and v_prev.library_hash      is not distinct from v_lib_hash
       and v_prev.identity_map_hash is not distinct from v_idm_hash then
      return null;                    -- nothing changed; not a failure
    end if;
  end if;

  -- 4. the blobs. ON CONFLICT DO NOTHING: the same content is stored once.
  insert into project_blobs (project_id, kind, content_hash, payload)
  values (p_project_id, 'library', v_lib_hash, v_library)
  on conflict (project_id, kind, content_hash) do nothing;

  insert into project_blobs (project_id, kind, content_hash, payload)
  values (p_project_id, 'identity_map', v_idm_hash, v_identity)
  on conflict (project_id, kind, content_hash) do nothing;

  -- 5. the snapshot row.
  insert into project_snapshots
    (project_id, payload, payload_hash, library_hash, identity_map_hash, reason, label, created_by)
  values
    (p_project_id, v_payload, v_p_hash, v_lib_hash, v_idm_hash, p_reason, p_label, auth.uid())
  returning id into v_id;

  return v_id;
end;
$fn$;

comment on function public.snapshot_project_v1(uuid, text, text) is
  'Writes one version-history snapshot for a production and returns its id, or '
  'NULL when nothing has changed since the last one (a skip, not a failure). '
  'SECURITY INVOKER: the caller''s own row-level security decides what it can '
  'snapshot. Measured at ~400 ms on the largest live production against the '
  'authenticated role''s 8s statement timeout (2026-09-11).';

revoke all     on function public.snapshot_project_v1(uuid, text, text) from public;
revoke all     on function public.snapshot_project_v1(uuid, text, text) from anon;
grant  execute on function public.snapshot_project_v1(uuid, text, text) to authenticated;
grant  execute on function public.snapshot_project_v1(uuid, text, text) to postgres;
