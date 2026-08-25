-- =====================================================================
-- 2-MIG-b · PORT-COV leg 2 — the GAP migration
-- Assembled 2026-08-25, Cowork-Arch MAIN LINE, off handoffs/260825-1300_next_session_opener.md
-- Governing set: Arch v31 · Roadmap v4.6 · Session Log at 5 · rollover clear
-- Scope of record for the cable side: drafts/260823_portcov_leg2_scope.md
--
-- Migration ledger 54 -> 55.  Trigger B.  Rehearsal-first, per the runbook.
-- Repo state at assembly: Minotaur        HEAD = origin/main = 9a140ca
--                         Minotaur-Cowork HEAD = origin/main = de22f2e
--
-- WHY THIS MIGRATION EXISTS. 2-IMP-a found five gaps in 2-MIG's own arms and
-- returned all five as OPEN QUESTIONS rather than emitting plan keys the RPC
-- would silently ignore. All five are Arch's. This closes them.
--
--   (n) BRANCH-NO-ARM      - cable_types.branch_cable_type_id has no arm at all
--   (o) DOMAIN-COLOR-BARE  - four cable_color DOMAIN columns written bare
--   (p) MATCHED-BUNDLE-ID  - the last_seen_run_id refresh is equipment-only
--   (q) BUNDLE-BOX-ONINSERT- an existing bundle cannot be re-boxed
--   (r) BUNDLE-RENAME      - the bundles UPDATE never writes bundle_name
--
-- WHAT THIS MIGRATION DOES *NOT* DO:
--   - NO DDL of any kind. One function body, replaced. No ALTER TABLE, no
--     ALTER DOMAIN, no new object - so no new object can take Postgres' default
--     EXECUTE grant to PUBLIC, which is the defect the 54 migration existed to
--     undo. Pre-flight 0.6 asserts that rather than assuming it.
--   - It does not touch mirrorFingerprintCount or MIRROR_SCOPED_TYPE. 2-IMP-b
--     widens the scoped type; this does not.
--   - It does not touch export_mint_identity. Both signatures are left alone.
--
-- ROLLBACK ARTIFACT, and it is exact rather than reconstructed:
--   drafts/260823_2-MIG_assembled_APPLIED.sql PART 1 was proven code-identical
--   to the live function body on 2026-08-25 - normalised md5
--   e81bc4a1414ecc29525bc1b20e8397be, 34,503 chars, both sides, differing only
--   in whitespace inside parentheses. Re-applying that PART 1 restores the
--   pre-migration state exactly. THIS FILE WAS BUILT FROM THAT PROVEN BASE BY
--   MECHANICAL TRANSFORM, not retyped: fourteen exact-match edits, each
--   asserting exactly one match, then twelve structural assertions on the
--   result. A hand-transcribed 1,200-line function is a drift risk this
--   project has already paid for once.
--
-- ---------------------------------------------------------------------
-- MEASUREMENTS TAKEN LIVE FOR THIS FILE, 2026-08-25. Nothing here is recalled.
--
-- THE FIVE GAPS, RE-CONFIRMED AGAINST THE LIVE BODY (not against the record):
--   branch_cable_type          0 occurrences in the live function
--   bundles UPDATE SET list    runs group_label..sort_order; bundle_name absent
--   {ops,bundles,inserts}      3 references · {ops,bundles,updates} 1
--   matchedV2Ids               1 refresh, entity_table = 'equipment_items' only
--   bundles UPDATE colours     flagged_end_color = r->>'flagged_end_color', bare
--
-- SCHEMA, live:
--   cable_types.branch_cable_type_id  uuid NULL, FK -> cable_types(id)
--                                     ON DELETE SET NULL (SELF-REFERENTIAL)
--   cable_types INSERT names 21 of the table's 24 columns; the three omitted are
--                                     branch_cable_type_id, created_at, updated_at
--   cable_types_project_id_model_name_key   UNIQUE (project_id, model_name)
--   bundles.bundle_name               text NOT NULL
--   bundles_project_id_bundle_name_key      UNIQUE (project_id, bundle_name)
--   cable_color DOMAIN                NULL or one of FOURTEEN lowercase names.
--                                     Carried by exactly four BASE-table columns
--                                     - bundles.flagged_end_color,
--                                     bundles.not_flagged_end_color,
--                                     cable_details.color,
--                                     cable_mult_lines.line_color - and
--                                     INHERITED by five view columns across
--                                     v_bundle_list and v_cable_list, which is
--                                     why widening the domain was never an
--                                     option and nullif(trim(...),'') is.
--   import_identity_map               6,243 rows, ALL entity_table =
--                                     'equipment_items'; ZERO v2_id values
--                                     appear under more than one entity_table.
--
-- CORPUS, measured on the v1 export files this morning:
--   `def ends`.Branch Cable Type populated  BVSC NY 32/50 · BVSC 40/56 · JOY 32/48
--     - matches the record exactly.
--   SELF-REFERENTIAL rows: SEVEN in every one of the four export sets. A row
--     whose Branch Cable Type IS its own Cable Model. See arm (n): they are
--     written, not filtered.
--   UNRESOLVABLE branch names: THREE, all in BVSC, all three fibre types naming
--     'LC' - a connector, not a model. They resolve to nothing and leave NULL.
--
-- ---------------------------------------------------------------------
-- TWO THINGS MEASURED THAT ARE **NOT** THIS MIGRATION'S, recorded so the next
-- session does not re-derive them:
--
-- 1. THE COLOUR FIX CLOSES THE EMPTY STRING, AND ONLY THE EMPTY STRING.
--    nullif(trim(x),'') turns '' into NULL, which the domain accepts. It does
--    NOT turn 'Red' into 'red'. The corpora carry Title Case throughout plus a
--    'REd' in BVSC's cable.xlsx and a 'red' in BVSC NY's bundles - so a plan
--    carrying a RAW v1 colour would still abort the whole import on the domain.
--    What makes colours valid is the MAPPER (coerceCableColorToken, which
--    lowercases and falls back to NULL with a variance line), not this RPC.
--    Do not read this arm as "the RPC now validates colours." It does not.
--
-- 2. THE `''` IN THE RECORD IS THE PARSED ROW, NOT THE SPREADSHEET CELL.
--    The record says BVSC NY's bundles "carry '' twice in both colour columns".
--    Read at source, those two cells are ABSENT in the .xlsx. They become ''
--    at parse.ts:84, which reads the sheet with `defval: ''` and then
--    `rowArr[idx] ?? ''`. The record's substance is correct and no correction
--    is owed; the wording describes the parsed record rather than the file.
--    Noted because measuring the FILE and concluding "the record is wrong"
--    would have been DOMAIN-NOT-CHECK committed against our own documents.
--
-- ---------------------------------------------------------------------
-- REGISTERED WHILE MEASURING, and it belongs to 2-IMP-b, not here:
--   LINECOLOR-ZERO. `lines.xlsx`.`Line Color` carries v1's null-marker '0' on
--   59 BVSC NY rows and 27 JOY rows - 86 across the two corpora. It is not one
--   of the fourteen names, so coerceCableColorToken will import each one blank
--   AND emit a variance line: 86 spurious "colour "0" is not one of v2's
--   fourteen cable colours" warnings on every import of those shows. '0' is the
--   same null-marker idiom already ruled for `def tails`.Method. 2-IMP-b's
--   mapper should read '0' as blank on this column rather than as a bad colour.
--
-- ---------------------------------------------------------------------
-- PLAN-SIDE WORK THIS MIGRATION PAIRS WITH - none of it rides here:
--   - BRANCH-NO-ARM is INERT until spec.ts stops refusing `Branch Cable Type`
--     (DEF_ENDS_IGNORED, varianceMonitored) and maps it to
--     `branch_cable_type_name`. Until then the arm exists and no plan feeds it.
--     The plan side should also REPORT unresolvable branch names, precedent
--     `unresolvableTailMethods`.
--   - BUNDLE-RENAME and BUNDLE-BOX-ONINSERT go LIVE THE MOMENT THIS APPLIES:
--     the plan ALREADY sends `bundle_name` and `box_name` on bundle update rows
--     (map.ts bundleRowTargetValues), and the RPC has simply been ignoring them.
--     cablePlan.ts's `renamesNotApplied` and `boxLinkSkippedOnUpdate` reports
--     become WRONG on the next import after this lands - they will report as
--     not-applied work that was applied. Correcting those two reports is
--     2-IMP-b's, and it is the one item here with a deadline attached to it.
--   - The `skipped.bundle_rename_collision` counter is new in the return
--     payload and nothing renders it yet.
-- =====================================================================


-- ---------------------------------------------------------------------
-- REHEARSAL RECORD — run 2026-08-25 against LIVE, forced rollback, verbatim.
-- Target: JOY (43dd9fde-dafb-403f-b6b1-8d2ba50f506f) — chosen because it is the
-- only corpus project that already carries SEVEN populated branch links, which
-- is exactly what arm (n)'s absent-key guard has to not destroy.
--
-- ROLLBACK MECHANISM PROVEN FIRST, before trusting it with the real thing:
--   throwaway function created inside BEGIN..ROLLBACK -> visible inside (1),
--   residue after rollback 0. A forced-rollback rehearsal is worthless if the
--   rollback is not real.
-- HARNESS PROVEN TOO: a DO block raising an exception was confirmed to surface
--   as a tool-level ERROR rather than being swallowed. A pre-flight that cannot
--   fail loudly is decoration. (Test a guard, don't read it.)
--
-- PRE-FLIGHT: all 7 assertions passed.
--
-- CONTROL — the PRE-MIGRATION function, fired at an empty-string colour:
--   ABORTED, as it must: 'value for domain cable_color violates check
--   constraint "cable_color_check"'. The defect is reproduced before it is
--   fixed, so arm (o) is demonstrated to fix something rather than asserted to.
--
-- BODY FIDELITY: the body installed in the rehearsal normalises to
--   1e09f04d8f4c95f86bf4ecdb757056d0 — byte-identical to THIS FILE. The paste
--   carried no transcription drift.
--
-- REHEARSAL A — all five arms, one call. RPC returned:
--   {"run_id":"14aed46e-15ec-46fa-859c-0af2e1e6a4ee","status":"succeeded",
--    "skipped":{"bundle_rename_collision":1},
--    "ambiguous":{"bundle_box_name":0,"cable_type_name":0,"within_box_name":0,
--                 "tail_parent_cable":0,"equipment_box_name":0,
--                 "cable_source_device":0}}
--
--   (n) branch resolves a name .................. expect CAT5 :: got CAT5
--   (n) SELF-REFERENCE is written ............... expect CAT5 (itself) :: got CAT5
--   (n) unresolvable name leaves alone .......... expect NULL :: got NULL
--   (n) ABSENT KEY PRESERVES the live value ..... before e36540dd / after e36540dd  PRESERVED
--   (n) explicit blank CLEARS ................... before e36540dd / after NULL  CLEARED
--   (o) bundle colours '' -> NULL ............... flagged NULL, not_flagged NULL
--   (o) cable colour '' -> NULL ................. NULL
--   (o) mult-line colour '' -> NULL ............. NULL
--   (q) EXISTING bundle re-boxed on update ...... d464896f -> df61dc79 (Band Bundles)  RE-BOXED
--   (q) previously unboxed bundle boxed ......... NULL -> d464896f (Ampland)  BOXED
--   (r) rename applied .......................... "Ampland" -> "Ampland RENAMED"
--   (r) COLLIDING rename refused, NOT aborted ... "Bass" unchanged, counted 1
--   (p) matched BUNDLE identity stamped ......... last_seen_run_id = this run
--   row counts untouched ........................ bundles 26 · cable_types 18
--                                                 cable_details 461 · equipment_items 1368
--
--   The fourth line is the one that matters most: without the
--   `r ? 'branch_cable_type_name'` guard that row reads as an explicit blank and
--   every branch link in the project is cleared on the first re-import. The
--   rehearsal is what turned that from an argument into a measurement.
--
-- RESIDUE CHECK AFTER ROLLBACK — 10 assertions, all clean:
--   function body back to the 2-MIG base (e81bc4a1414ecc29525bc1b20e8397be)
--   branch_cable_type hits 0 · stray import_runs 0 · stray revisions 0
--   stray identity rows 0 · JOY renames 0 · JOY branch links 7 (unchanged)
--   JOY boxed bundles 25 (unchanged) · probe function 0
--   ledger 54, head 20260824220944
--
-- APPLIED 2026-08-25 on Daniel's explicit confirm (Trigger B), to MAIN.
--   ledger 54 -> 55 : 20260825184800_port_cov_leg2_2migb_cable_rpc_gap_arms
--   The PRE-FLIGHT block was carried INSIDE the applied migration rather than
--   run beside it, so the precondition and the change are one transaction and
--   the assertion cannot be skipped by whoever applies it.
--
-- POST-APPLY VERIFICATION - all green:
--   body md5 1e09f04d8f4c95f86bf4ecdb757056d0 - the live function is byte-for-
--     byte (modulo comments and whitespace) the body in THIS FILE, which is the
--     body the rehearsal exercised.
--   all three signatures present · prosecdef=false (SECURITY INVOKER) on all
--     three · proconfig=search_path=public on all three
--   acl {postgres=X/postgres,authenticated=X/postgres}, IDENTICAL on all three
--   authenticated EXECUTE = true on all three · anon = false on all three
--   functions with PUBLIC execute: 0 - measured with has_function_privilege,
--     not by matching ACL text. No new object was created, so 2-MIG's default-
--     PUBLIC defect could not recur, and that was checked rather than assumed.
--   branch arm present (5 hits) · rename counter present (1)
--   bare colour writes: flagged 0 · not_flagged 0 · color 0 · line_color 0
--   rows written by the migration: 0. Live data untouched:
--     cable_details 1611 · cable_mult_lines 1228 · bundles 100 · cable_types 96
--     link_groups 54 · identity 6243 · branch links populated 10 (unchanged)
--
-- ONE PREDICTION IN THIS FILE WAS WRONG, and it is corrected rather than
-- quietly dropped. PART 2's nullif_trim check was written expecting 66; the
-- live answer is 74, and so is this file's - they agree. The 66 came from
-- arithmetic on a base count of 58 taken from pg_get_functiondef, whose COMMENT
-- text carries its own `nullif(trim(` occurrences; the file's base body has 56.
-- The count was measuring a string that also lives in prose. The md5 is the
-- check that answers the question, and it matched exactly. Corrected below.
-- The number was wrong; the risk was not.
-- ---------------------------------------------------------------------


-- =====================================================================
-- PART 0 · PRE-FLIGHT ASSERTIONS  (run standalone; abort on any failure)
-- =====================================================================
-- These prove the world is what this file was written against. Each asserts the
-- PROPERTY it cares about rather than a proxy for it.

do $preflight$
declare v int; v_txt text;
begin
  -- 0.1 THE LIVE BODY IS EXACTLY THE BASE THIS FILE WAS TRANSFORMED FROM.
  -- Not "the function exists", not "it looks right" - the same bytes, modulo
  -- comments and whitespace. If anything has touched import_apply_v1 since
  -- 2-MIG, this raises and the transform is rebuilt rather than forced.
  select md5(regexp_replace(
           btrim(regexp_replace(regexp_replace(p.prosrc,'--[^
]*','','g'),'\s+',' ','g')),
           '\s*([(),;])\s*','','g'))
    into v_txt
  from pg_proc p join pg_namespace n on n.oid=p.pronamespace
  where n.nspname='public' and p.proname='import_apply_v1';
  if v_txt is distinct from 'e81bc4a1414ecc29525bc1b20e8397be' then
    raise exception 'PRE-FLIGHT 0.1 FAILED: live import_apply_v1 is not the base this file was built from (got %)', v_txt;
  end if;

  -- 0.2 this migration has not already run
  select (length(pg_get_functiondef(p.oid))
          - length(replace(pg_get_functiondef(p.oid),'branch_cable_type','')))/17
    into v
  from pg_proc p join pg_namespace n on n.oid=p.pronamespace
  where n.nspname='public' and p.proname='import_apply_v1';
  if v <> 0 then
    raise exception 'PRE-FLIGHT 0.2 FAILED: import_apply_v1 already mentions branch_cable_type % times', v;
  end if;

  -- 0.3 branch_cable_type_id is what arm (n) assumes: uuid, nullable, self-FK
  if not exists (select 1 from information_schema.columns
                 where table_schema='public' and table_name='cable_types'
                   and column_name='branch_cable_type_id'
                   and data_type='uuid' and is_nullable='YES') then
    raise exception 'PRE-FLIGHT 0.3 FAILED: cable_types.branch_cable_type_id missing, not uuid, or NOT NULL';
  end if;
  if not exists (select 1 from pg_constraint
                 where conname='cable_types_branch_cable_type_id_fkey'
                   and confrelid='public.cable_types'::regclass) then
    raise exception 'PRE-FLIGHT 0.3 FAILED: branch FK is not self-referential to cable_types';
  end if;

  -- 0.4 arm (n) resolves by model_name and relies on that being unique;
  --     arm (r)'s guard exists because bundle_name is unique and NOT NULL.
  if not exists (select 1 from pg_constraint where conname='cable_types_project_id_model_name_key')
  or not exists (select 1 from pg_constraint where conname='bundles_project_id_bundle_name_key') then
    raise exception 'PRE-FLIGHT 0.4 FAILED: expected unique constraints missing';
  end if;
  if exists (select 1 from information_schema.columns
             where table_schema='public' and table_name='bundles'
               and column_name='bundle_name' and is_nullable='YES') then
    raise exception 'PRE-FLIGHT 0.4 FAILED: bundles.bundle_name is nullable; arm (r) assumes NOT NULL';
  end if;

  -- 0.5 the cable_color DOMAIN is a DOMAIN and carries exactly four BASE-table
  --     columns. Keyed on contypid, because a conrelid query cannot see a
  --     domain - the measurement that earned DOMAIN-NOT-CHECK.
  select count(*) into v from pg_type t join pg_constraint c on c.contypid=t.oid
   where t.typname='cable_color';
  if v <> 1 then
    raise exception 'PRE-FLIGHT 0.5 FAILED: cable_color domain constraint count is %, expected 1', v;
  end if;
  select count(*) into v from information_schema.columns c
   join information_schema.tables tb
     on tb.table_schema=c.table_schema and tb.table_name=c.table_name
  where c.table_schema='public' and c.domain_name='cable_color'
    and tb.table_type='BASE TABLE';
  if v <> 4 then
    raise exception 'PRE-FLIGHT 0.5 FAILED: cable_color is on % base-table columns, expected 4', v;
  end if;

  -- 0.6 NO NEW OBJECT. All three signatures already exist, so CREATE OR REPLACE
  --     preserves every ACL and nothing can inherit the default PUBLIC grant.
  select count(*) into v from pg_proc p join pg_namespace n on n.oid=p.pronamespace
   where n.nspname='public'
     and (p.proname='import_apply_v1'
          or (p.proname='export_mint_identity'));
  if v <> 3 then
    raise exception 'PRE-FLIGHT 0.6 FAILED: expected 3 existing function signatures, found %', v;
  end if;

  -- 0.7 arm (p) drops the entity_table filter, which is only safe while a v2_id
  --     cannot mean two different rows. Asserted, not assumed.
  select count(*) into v from (
    select v2_id from import_identity_map group by v2_id having count(distinct entity_table) > 1
  ) q;
  if v <> 0 then
    raise exception 'PRE-FLIGHT 0.7 FAILED: % v2_id values span more than one entity_table; arm (p) is unsafe', v;
  end if;

  raise notice 'PRE-FLIGHT: all 7 assertions passed.';
end
$preflight$;


-- =====================================================================
-- PART 1 · import_apply_v1  — full replacement
-- =====================================================================
-- SECURITY INVOKER (prosecdef=false) and SET search_path TO 'public' are
-- preserved verbatim. Do not "improve" either: the RLS story depends on INVOKER.
--
-- THE EMPTY-STRING TRAP, restated because arm (o) widens it. Eleven constrained
-- TEXT columns carry CHECK constraints of the shape CHECK (col = ANY (...)); a
-- NULL passes such a CHECK and an EMPTY STRING does not. As of this migration
-- FOUR MORE columns join them - not by CHECK but by the cable_color DOMAIN,
-- which behaves the same way and is invisible to a conrelid query. Every one of
-- the fifteen is written through nullif(trim(...),'') and never as a bare
-- r->>'x'. A single bare read aborts the transaction and rolls back the import.

CREATE OR REPLACE FUNCTION public.import_apply_v1(
  p_project_id uuid,
  p_plan jsonb,
  p_snapshot jsonb,
  p_revision_name text,
  p_source_label text,
  p_file_manifest jsonb DEFAULT '[]'::jsonb,
  p_counts jsonb DEFAULT '{}'::jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SET search_path TO 'public'
AS $function$
declare
  v_run_id uuid; v_live int; v_base int;
  -- DIV-AMBIG-CLEAR counters. Omitted-because-ambiguous is not absent, and
  -- until now every one of these skips was silent.
  v_amb_box int := 0; v_amb_within int := 0; v_amb_bundle int := 0;
  v_amb_cable int := 0; v_amb_device int := 0; v_amb_ctype int := 0;
  -- BUNDLE-RENAME's guard counts what it refused, for the same reason
  -- DIV-AMBIG-CLEAR counts its skips: a guard that skips in silence is the
  -- defect it was written to prevent.
  v_rename_blocked int := 0;
begin
  -- 0. project visible under caller's RLS
  if not exists (select 1 from projects where id = p_project_id) then
    raise exception 'import_apply_v1: project not found or not accessible';
  end if;

  -- ---------------------------------------------------------------
  -- 1. stale-plan fingerprint guard (2C-3)
  -- ---------------------------------------------------------------
  select count(*) into v_live from equipment_items where project_id = p_project_id;
  if v_live is distinct from (p_plan#>>'{fingerprint,equipment_items}')::int then
    raise exception 'state changed since dry-run (equipment_items: plan %, live %) — re-run dry-run',
      p_plan#>>'{fingerprint,equipment_items}', v_live;
  end if;
  select count(*) into v_live from equipment_library_items where project_id = p_project_id;
  if v_live is distinct from (p_plan#>>'{fingerprint,equipment_library_items}')::int then
    raise exception 'state changed since dry-run (equipment_library_items: plan %, live %) — re-run dry-run',
      p_plan#>>'{fingerprint,equipment_library_items}', v_live;
  end if;
  select count(*) into v_live from methods where project_id = p_project_id;
  if v_live is distinct from (p_plan#>>'{fingerprint,methods}')::int then
    raise exception 'state changed since dry-run (methods: plan %, live %) — re-run dry-run',
      p_plan#>>'{fingerprint,methods}', v_live;
  end if;
  select count(*) into v_live from categories where project_id = p_project_id;
  if v_live is distinct from (p_plan#>>'{fingerprint,categories}')::int then
    raise exception 'state changed since dry-run (categories: plan %, live %) — re-run dry-run',
      p_plan#>>'{fingerprint,categories}', v_live;
  end if;

  -- BOX-ARM (a): conditional box_types fingerprint. Absent key = old plan = skip.
  if p_plan#>>'{fingerprint,box_types}' is not null then
    select count(*) into v_live from box_types where project_id = p_project_id;
    if v_live is distinct from (p_plan#>>'{fingerprint,box_types}')::int then
      raise exception 'state changed since dry-run (box_types: plan %, live %) — re-run dry-run',
        p_plan#>>'{fingerprint,box_types}', v_live;
    end if;
  end if;

  -- CABLE-ARM (a): four conditional fingerprint keys, each following box_types'
  -- pattern exactly, so a plan minted before this migration SKIPS rather than
  -- aborts. Cables and tails need NO key of their own: they are spine rows and
  -- the all-types equipment_items count above already covers them (scope 5.3).
  if p_plan#>>'{fingerprint,cable_types}' is not null then
    select count(*) into v_live from cable_types where project_id = p_project_id;
    if v_live is distinct from (p_plan#>>'{fingerprint,cable_types}')::int then
      raise exception 'state changed since dry-run (cable_types: plan %, live %) — re-run dry-run',
        p_plan#>>'{fingerprint,cable_types}', v_live;
    end if;
  end if;
  if p_plan#>>'{fingerprint,bundles}' is not null then
    select count(*) into v_live from bundles where project_id = p_project_id;
    if v_live is distinct from (p_plan#>>'{fingerprint,bundles}')::int then
      raise exception 'state changed since dry-run (bundles: plan %, live %) — re-run dry-run',
        p_plan#>>'{fingerprint,bundles}', v_live;
    end if;
  end if;
  if p_plan#>>'{fingerprint,cable_mult_lines}' is not null then
    select count(*) into v_live from cable_mult_lines where project_id = p_project_id;
    if v_live is distinct from (p_plan#>>'{fingerprint,cable_mult_lines}')::int then
      raise exception 'state changed since dry-run (cable_mult_lines: plan %, live %) — re-run dry-run',
        p_plan#>>'{fingerprint,cable_mult_lines}', v_live;
    end if;
  end if;
  if p_plan#>>'{fingerprint,link_groups}' is not null then
    select count(*) into v_live from link_groups where project_id = p_project_id;
    if v_live is distinct from (p_plan#>>'{fingerprint,link_groups}')::int then
      raise exception 'state changed since dry-run (link_groups: plan %, live %) — re-run dry-run',
        p_plan#>>'{fingerprint,link_groups}', v_live;
    end if;
  end if;

  -- 2. provenance run row (IMP-5)
  insert into import_runs (project_id, source_label, file_manifest, counts, dry_run, status, created_by)
  values (p_project_id, p_source_label, p_file_manifest, p_counts, false, 'running', auth.uid())
  returning id into v_run_id;

  -- 3. automatic pre-apply snapshot (IMP-2); guard freezes it after insert
  insert into equipment_list_revisions (project_id, revision_name, snapshot, created_by, editable)
  values (p_project_id, p_revision_name, p_snapshot, auth.uid(), false);

  -- ---------------------------------------------------------------
  -- 4. create-missing (IMP-8), appended after current max sort_order
  -- ---------------------------------------------------------------
  select coalesce(max(sort_order),0) into v_base from categories where project_id = p_project_id;
  insert into categories (project_id, name, sort_order)
  select p_project_id, t.nm, v_base + 10 * t.ord
  from (select value #>> '{}' as nm, row_number() over () as ord
        from jsonb_array_elements(coalesce(p_plan#>'{createMissing,categories}','[]'::jsonb))) t
  on conflict (project_id, name) do nothing;

  select coalesce(max(sort_order),0) into v_base from methods where project_id = p_project_id;
  insert into methods (project_id, name, sort_order)
  select p_project_id, t.nm, v_base + 10 * t.ord
  from (select value #>> '{}' as nm, row_number() over () as ord
        from jsonb_array_elements(coalesce(p_plan#>'{createMissing,methods}','[]'::jsonb))) t
  on conflict (project_id, name) do nothing;

  -- CABLE-ARM (b): R-5's trap, enforced at the data layer instead of trusted.
  -- createMissing covers categories and methods ONLY. A cable_types key handed
  -- to it would be IGNORED IN SILENCE - the exact failure that nearly killed
  -- BOX-TYPE-LIB. Fail loudly instead. Cable/tail models created under R-5 ride
  -- ops.cable_types.inserts, not createMissing.
  if jsonb_array_length(coalesce(p_plan#>'{createMissing,cable_types}','[]'::jsonb)) > 0 then
    raise exception 'import_apply_v1: createMissing.cable_types is not supported (R-5) — cable and tail models must ride ops.cable_types.inserts';
  end if;

  -- ---------------------------------------------------------------
  -- 5. inserts/updates, FK-safe order
  -- ---------------------------------------------------------------
  insert into categories (id, project_id, name, sort_order, notes)
  select (r->>'id')::uuid, p_project_id, r->>'name', coalesce((r->>'sort_order')::int,0), r->>'notes'
  from jsonb_array_elements(coalesce(p_plan#>'{ops,categories,inserts}','[]'::jsonb)) r;

  update categories c
     set sort_order = coalesce((r->>'sort_order')::int, c.sort_order), notes = r->>'notes'
  from jsonb_array_elements(coalesce(p_plan#>'{ops,categories,updates}','[]'::jsonb)) r
  where c.id = (r->>'v2_id')::uuid and c.project_id = p_project_id;

  insert into methods (id, project_id, name, color_name, color_hex, multiplier, notes, shop_order_header, sort_order)
  select (r->>'id')::uuid, p_project_id, r->>'name', r->>'color_name', r->>'color_hex',
         (r->>'multiplier')::numeric, r->>'notes', r->>'shop_order_header', coalesce((r->>'sort_order')::int,0)
  from jsonb_array_elements(coalesce(p_plan#>'{ops,methods,inserts}','[]'::jsonb)) r;

  update methods m
     set color_name = r->>'color_name', color_hex = r->>'color_hex',
         multiplier = (r->>'multiplier')::numeric, notes = r->>'notes',
         shop_order_header = r->>'shop_order_header',
         sort_order = coalesce((r->>'sort_order')::int, m.sort_order)
  from jsonb_array_elements(coalesce(p_plan#>'{ops,methods,updates}','[]'::jsonb)) r
  where m.id = (r->>'v2_id')::uuid and m.project_id = p_project_id;

  insert into equipment_library_items (id, project_id, model, category, cost, cost_date, cost_source,
         country_of_origin, depth_inches, ignored, library_note, method_hint, public_note,
         power_draw_watts, rack_units, starred, product_url, weight_lbs)
  select (r->>'id')::uuid, p_project_id, r->>'model', r->>'category', (r->>'cost')::numeric,
         (r->>'cost_date')::date, r->>'cost_source', r->>'country_of_origin', (r->>'depth_inches')::numeric,
         coalesce((r->>'ignored')::boolean,false), r->>'library_note', r->>'method_hint', r->>'public_note',
         (r->>'power_draw_watts')::numeric, (r->>'rack_units')::numeric,
         coalesce((r->>'starred')::boolean,false), r->>'product_url', (r->>'weight_lbs')::numeric
  from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_library_items,inserts}','[]'::jsonb)) r;

  update equipment_library_items l
     set category = r->>'category', cost = (r->>'cost')::numeric, cost_date = (r->>'cost_date')::date,
         cost_source = r->>'cost_source', country_of_origin = r->>'country_of_origin',
         depth_inches = (r->>'depth_inches')::numeric, ignored = coalesce((r->>'ignored')::boolean,false),
         library_note = r->>'library_note', method_hint = r->>'method_hint', public_note = r->>'public_note',
         power_draw_watts = (r->>'power_draw_watts')::numeric, rack_units = (r->>'rack_units')::numeric,
         starred = coalesce((r->>'starred')::boolean,false), product_url = r->>'product_url',
         weight_lbs = (r->>'weight_lbs')::numeric
  from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_library_items,updates}','[]'::jsonb)) r
  where l.id = (r->>'v2_id')::uuid and l.project_id = p_project_id;

  -- BOX-ARM (b): box_types before box_details (FK box_type_id).
  insert into box_types (id, project_id, type_name, width, depth, height, volume, weight_lbs, notes)
  select (r->>'id')::uuid, p_project_id, r->>'type_name',
         r->>'width', r->>'depth', r->>'height',
         (r->>'volume')::numeric, (r->>'weight_lbs')::numeric, r->>'notes'
  from jsonb_array_elements(coalesce(p_plan#>'{ops,box_types,inserts}','[]'::jsonb)) r;

  update box_types t
     set type_name = coalesce(r->>'type_name', t.type_name),
         width = r->>'width', depth = r->>'depth', height = r->>'height',
         volume = (r->>'volume')::numeric, weight_lbs = (r->>'weight_lbs')::numeric,
         notes = r->>'notes'
  from jsonb_array_elements(coalesce(p_plan#>'{ops,box_types,updates}','[]'::jsonb)) r
  where t.id = (r->>'v2_id')::uuid and t.project_id = p_project_id;

  -- CABLE-ARM (c): cable_types before cable_details (FK cable_type_id) and
  -- before any tail row that inherits its label defaults. tail_method_id
  -- resolves by method NAME, first-wins, mirroring mapMethods.
  insert into cable_types (id, project_id, model_name, source_end, destination_end,
         default_label_size, mult_line_count, add_lines, add_tails,
         outside_diameter_in, weight_lbs_per_ft, reference,
         source_tail_model, destination_tail_model,
         tail_big_block_label, tail_small_block_label, tail_line_labels,
         tail_panel_labels, tail_balun_labels, tail_method_id, library_tier)
  select (r->>'id')::uuid, p_project_id, r->>'model_name',
         r->>'source_end', r->>'destination_end',
         nullif(trim(r->>'default_label_size'),''),          -- CHECK: big|small|both|none
         (r->>'mult_line_count')::int,
         coalesce((r->>'add_lines')::boolean,false),
         coalesce((r->>'add_tails')::boolean,false),
         (r->>'outside_diameter_in')::numeric, (r->>'weight_lbs_per_ft')::numeric,
         r->>'reference', r->>'source_tail_model', r->>'destination_tail_model',
         coalesce((r->>'tail_big_block_label')::boolean,false),
         coalesce((r->>'tail_small_block_label')::boolean,false),
         coalesce((r->>'tail_line_labels')::boolean,false),
         coalesce((r->>'tail_panel_labels')::boolean,false),
         coalesce((r->>'tail_balun_labels')::boolean,false),
         m.id, nullif(trim(r->>'library_tier'),'')
  from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_types,inserts}','[]'::jsonb)) r
  left join methods m on m.project_id = p_project_id
                     and m.name = nullif(trim(r->>'tail_method_name'),'')
  on conflict (project_id, model_name) do nothing;   -- CAT-DUP-class guard, not a fix

  update cable_types t
     set source_end = r->>'source_end', destination_end = r->>'destination_end',
         default_label_size = nullif(trim(r->>'default_label_size'),''),
         mult_line_count = (r->>'mult_line_count')::int,
         add_lines = coalesce((r->>'add_lines')::boolean, t.add_lines),
         add_tails = coalesce((r->>'add_tails')::boolean, t.add_tails),
         outside_diameter_in = (r->>'outside_diameter_in')::numeric,
         weight_lbs_per_ft = (r->>'weight_lbs_per_ft')::numeric,
         reference = r->>'reference',
         source_tail_model = r->>'source_tail_model',
         destination_tail_model = r->>'destination_tail_model',
         tail_big_block_label   = coalesce((r->>'tail_big_block_label')::boolean, t.tail_big_block_label),
         tail_small_block_label = coalesce((r->>'tail_small_block_label')::boolean, t.tail_small_block_label),
         tail_line_labels       = coalesce((r->>'tail_line_labels')::boolean, t.tail_line_labels),
         tail_panel_labels      = coalesce((r->>'tail_panel_labels')::boolean, t.tail_panel_labels),
         tail_balun_labels      = coalesce((r->>'tail_balun_labels')::boolean, t.tail_balun_labels),
         -- ARCH DIVERGENCE 1 idiom, carried verbatim: an ABSENT/blank name
         -- clears the link (a real edit); a PRESENT but unresolvable one
         -- leaves it alone. This is DIV-AMBIG-CLEAR's shape.
         tail_method_id = case
           when nullif(trim(r->>'tail_method_name'),'') is null then null
           else coalesce(m.id, t.tail_method_id)
         end,
         updated_at = now()
  from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_types,updates}','[]'::jsonb)) r
  left join methods m on m.project_id = p_project_id
                     and m.name = nullif(trim(r->>'tail_method_name'),'')
  where t.id = (r->>'v2_id')::uuid and t.project_id = p_project_id;

  -- CABLE-ARM (d): bundles. Unique on (project_id, bundle_name) and measured
  -- clean in all three corpora (scope 3.6), so ON CONFLICT is a guard, not a
  -- fix. box_id is a NAME second-pass below - boxes may not exist yet here.
  insert into bundles (id, project_id, bundle_name, group_label,
         length_value, length_unit, flagged_end_label, flagged_end_color,
         not_flagged_end_label, not_flagged_end_color,
         bundled, packed, tested, invert, is_extension, kind, notes, sort_order)
  select (r->>'id')::uuid, p_project_id, r->>'bundle_name', r->>'group_label',
         (r->>'length_value')::numeric,
         nullif(trim(r->>'length_unit'),''),                 -- CHECK: ft|m
         r->>'flagged_end_label',
         nullif(trim(r->>'flagged_end_color'),''),              -- DOMAIN cable_color
         r->>'not_flagged_end_label',
         nullif(trim(r->>'not_flagged_end_color'),''),          -- DOMAIN cable_color
         coalesce((r->>'bundled')::boolean,false),
         coalesce((r->>'packed')::boolean,false),
         coalesce((r->>'tested')::boolean,false),
         coalesce((r->>'invert')::boolean,false),
         coalesce((r->>'is_extension')::boolean,false),
         coalesce(nullif(trim(r->>'kind'),''),'bundle'),      -- CHECK: bundle|infrastructure
         r->>'notes', coalesce((r->>'sort_order')::int,0)
  from jsonb_array_elements(coalesce(p_plan#>'{ops,bundles,inserts}','[]'::jsonb)) r
  on conflict (project_id, bundle_name) do nothing;

  select count(*) into v_rename_blocked
  from jsonb_array_elements(coalesce(p_plan#>'{ops,bundles,updates}','[]'::jsonb)) r
  join bundles b on b.id = (r->>'v2_id')::uuid and b.project_id = p_project_id
  where nullif(trim(r->>'bundle_name'),'') is not null
    and nullif(trim(r->>'bundle_name'),'') is distinct from b.bundle_name
    and exists (select 1 from bundles o
                 where o.project_id = p_project_id
                   and o.bundle_name = nullif(trim(r->>'bundle_name'),'')
                   and o.id <> b.id);

  update bundles b
     set
         -- BUNDLE-RENAME (2-MIG-b). Until now this UPDATE never wrote
         -- bundle_name, so a v1-side rename was described by the plan and never
         -- applied. It is written here THROUGH A COLLISION GUARD, because
         -- bundles_project_id_bundle_name_key is UNIQUE and NOT DEFERRABLE: a
         -- bare write would abort the WHOLE import the first time a rename
         -- targets a name another bundle still holds - including an unmirrored
         -- v2 bundle this plan deliberately leaves alone. The guard turns a
         -- whole-transaction abort into one counted, reported skip.
         -- An ABSENT or blank key leaves the name alone (coalesce shape), so no
         -- pre-2-MIG-b plan can blank a name.
         bundle_name = case
           when nullif(trim(r->>'bundle_name'),'') is null then b.bundle_name
           when exists (select 1 from bundles o
                         where o.project_id = p_project_id
                           and o.bundle_name = nullif(trim(r->>'bundle_name'),'')
                           and o.id <> b.id) then b.bundle_name
           else nullif(trim(r->>'bundle_name'),'')
         end,
         group_label = r->>'group_label',
         length_value = (r->>'length_value')::numeric,
         length_unit = nullif(trim(r->>'length_unit'),''),
         flagged_end_label = r->>'flagged_end_label',
         flagged_end_color = nullif(trim(r->>'flagged_end_color'),''),
         not_flagged_end_label = r->>'not_flagged_end_label',
         not_flagged_end_color = nullif(trim(r->>'not_flagged_end_color'),''),
         bundled      = coalesce((r->>'bundled')::boolean, b.bundled),
         packed       = coalesce((r->>'packed')::boolean, b.packed),
         tested       = coalesce((r->>'tested')::boolean, b.tested),
         invert       = coalesce((r->>'invert')::boolean, b.invert),
         is_extension = coalesce((r->>'is_extension')::boolean, b.is_extension),
         kind         = coalesce(nullif(trim(r->>'kind'),''), b.kind),
         notes = r->>'notes',
         sort_order = coalesce((r->>'sort_order')::int, b.sort_order),
         updated_at = now()
  from jsonb_array_elements(coalesce(p_plan#>'{ops,bundles,updates}','[]'::jsonb)) r
  where b.id = (r->>'v2_id')::uuid and b.project_id = p_project_id;

  -- DEV1-R9 sort_order; BOX-ARM (c): 'type' on the INSERT only.
  -- BOX-NOBOX: no_box_needed carries v1's affirmative Box = "0" marker.
  -- Measured: 562 BVSC NY cable rows and 335 equipment rows carry it.
  insert into equipment_items (id, project_id, category_id, method_id, model, description, group_label,
         quantity, remaining_quantity, public_notes, private_notes, circuit, address, labels_done, drawn, packed,
         sort_order, type, no_box_needed)
  select (r->>'id')::uuid, p_project_id, cat.id, m.id,
         coalesce(r->>'model',''), coalesce(r->>'description',''), r->>'group_label',
         coalesce((r->>'quantity')::int,1), (r->>'remaining_quantity')::int,
         r->>'public_notes', r->>'private_notes', r->>'circuit', r->>'address',
         coalesce((r->>'labels_done')::boolean,false), coalesce((r->>'drawn')::boolean,false),
         coalesce((r->>'packed')::boolean,false),
         coalesce((r->>'import_sort_order')::int, 0),
         coalesce(nullif(trim(r->>'type'),''), 'generic'),
         coalesce((r->>'no_box_needed')::boolean, false)
  from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_items,inserts}','[]'::jsonb)) r
  left join categories cat on cat.project_id = p_project_id and cat.name = nullif(trim(r->>'category_name'),'')
  left join methods m     on m.project_id  = p_project_id and m.name  = nullif(trim(r->>'method_name'),'');

  update equipment_items e
     set category_id = cat.id, method_id = m.id,
         model = coalesce(r->>'model',''), description = coalesce(r->>'description',''),
         group_label = r->>'group_label', quantity = coalesce((r->>'quantity')::int,1),
         remaining_quantity = (r->>'remaining_quantity')::int,
         public_notes = r->>'public_notes', private_notes = r->>'private_notes',
         circuit = r->>'circuit', address = r->>'address',
         labels_done = coalesce((r->>'labels_done')::boolean,false),
         drawn = coalesce((r->>'drawn')::boolean,false),
         packed = coalesce((r->>'packed')::boolean,false),
         -- BOX-NOBOX: absent key preserves the live value rather than clearing
         -- it, so an old plan cannot silently un-mark a no-box row.
         no_box_needed = coalesce((r->>'no_box_needed')::boolean, e.no_box_needed)
  from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_items,updates}','[]'::jsonb)) r
  left join categories cat on cat.project_id = p_project_id and cat.name = nullif(trim(r->>'category_name'),'')
  left join methods m     on m.project_id  = p_project_id and m.name  = nullif(trim(r->>'method_name'),'')
  where e.id = (r->>'v2_id')::uuid and e.project_id = p_project_id;

  -- BOX-ARM (d): box_details, after the equipment insert so spine rows exist.
  insert into box_details (id, box_number, box_type_id, header, location, stack, truck,
         color_name, label_notes, return_notes, category_override, model_override,
         num_large_labels, num_small_labels, cat_photo,
         actual_weight, additional_weight, additional_cost)
  select (r->>'id')::uuid, r->>'box_number', bt.id,
         r->>'header', r->>'location', r->>'stack', r->>'truck',
         r->>'color_name', r->>'label_notes', r->>'return_notes',
         r->>'category_override', r->>'model_override',
         coalesce((r->>'num_large_labels')::int, 0),
         coalesce((r->>'num_small_labels')::int, 0),
         coalesce((r->>'cat_photo')::boolean, false),
         (r->>'actual_weight')::numeric, (r->>'additional_weight')::numeric,
         (r->>'additional_cost')::numeric
  from jsonb_array_elements(coalesce(p_plan#>'{ops,box_details,inserts}','[]'::jsonb)) r
  left join lateral (
    select t.id from box_types t
     where t.project_id = p_project_id
       and t.type_name = nullif(trim(r->>'box_type_name'),'')
     order by t.id
     limit 1
  ) bt on true;

  -- ARCH DIVERGENCE 1 (Daniel approved 2026-08-22): an ABSENT/blank type name
  -- clears the type (a real edit); a PRESENT but unresolvable one leaves it alone.
  update box_details d
     set box_number = r->>'box_number',
         box_type_id = case
           when nullif(trim(r->>'box_type_name'),'') is null then null
           else coalesce(bt.id, d.box_type_id)
         end,
         header = r->>'header', location = r->>'location', stack = r->>'stack',
         truck = r->>'truck', color_name = r->>'color_name',
         label_notes = r->>'label_notes', return_notes = r->>'return_notes',
         category_override = r->>'category_override', model_override = r->>'model_override',
         num_large_labels = coalesce((r->>'num_large_labels')::int, d.num_large_labels),
         num_small_labels = coalesce((r->>'num_small_labels')::int, d.num_small_labels),
         cat_photo = coalesce((r->>'cat_photo')::boolean, d.cat_photo),
         actual_weight = (r->>'actual_weight')::numeric,
         additional_weight = (r->>'additional_weight')::numeric,
         additional_cost = (r->>'additional_cost')::numeric
  from jsonb_array_elements(coalesce(p_plan#>'{ops,box_details,updates}','[]'::jsonb)) r
  left join lateral (
    select t.id from box_types t
     where t.project_id = p_project_id
       and t.type_name = nullif(trim(r->>'box_type_name'),'')
     order by t.id
     limit 1
  ) bt on true
  where d.id = (r->>'v2_id')::uuid;

  -- CABLE-ARM (e): cable_details. id IS the spine id (1:1, ON DELETE CASCADE),
  -- so the spine row must already exist - it does, two arms above.
  -- cable_type_id resolves at INSERT by model name (a cable_types row is
  -- guaranteed present by arm (c)); bundle_id and the device ids are NAME
  -- second-passes below, because a bundle's box and a device row may be
  -- created later in this same plan.
  -- R7-6: patch linkage is permanently unenrolled. source_patch_line_id and
  -- destination_patch_line_id are NEVER written from a v1 plan; they are
  -- v2-internal and a re-import must not fabricate them.
  insert into cable_details (id, project_id, cable_name, cable_type_id,
         length_value, length_unit, color,
         source_device_text, source_connection,
         destination_device_text, destination_connection,
         flagged_end, source_steck_count, destination_steck_count,
         big_label, small_label, is_mult, is_extension, split_end,
         pulled, labeled, tested, print_list, eta, patch_color_break)
  select (r->>'id')::uuid, p_project_id, r->>'cable_name', ct.id,
         (r->>'length_value')::numeric,
         nullif(trim(r->>'length_unit'),''),                    -- CHECK: ft|m
         nullif(trim(r->>'color'),''),                          -- DOMAIN cable_color
         r->>'source_device_text', r->>'source_connection',
         r->>'destination_device_text', r->>'destination_connection',
         nullif(trim(r->>'flagged_end'),''),                    -- CHECK: source|destination
         (r->>'source_steck_count')::int, (r->>'destination_steck_count')::int,
         coalesce((r->>'big_label')::boolean,false),
         coalesce((r->>'small_label')::boolean,true),
         (r->>'is_mult')::boolean,
         coalesce((r->>'is_extension')::boolean,false),
         nullif(trim(r->>'split_end'),''),                      -- CHECK: source|destination|daisy_chain
         coalesce((r->>'pulled')::boolean,false),
         coalesce((r->>'labeled')::boolean,false),
         coalesce((r->>'tested')::boolean,false),
         coalesce((r->>'print_list')::boolean,false),
         r->>'eta',
         coalesce((r->>'patch_color_break')::boolean,false)
  from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_details,inserts}','[]'::jsonb)) r
  left join lateral (
    select t.id from cable_types t
     where t.project_id = p_project_id
       and t.model_name = nullif(trim(r->>'cable_type_name'),'')
     order by t.id limit 1
  ) ct on true;

  update cable_details d
     set cable_name = r->>'cable_name',
         cable_type_id = case
           when nullif(trim(r->>'cable_type_name'),'') is null then null
           else coalesce(ct.id, d.cable_type_id)
         end,
         length_value = (r->>'length_value')::numeric,
         length_unit = nullif(trim(r->>'length_unit'),''),
         color = nullif(trim(r->>'color'),''),                  -- DOMAIN cable_color
         source_device_text = r->>'source_device_text',
         source_connection = r->>'source_connection',
         destination_device_text = r->>'destination_device_text',
         destination_connection = r->>'destination_connection',
         flagged_end = nullif(trim(r->>'flagged_end'),''),
         source_steck_count = (r->>'source_steck_count')::int,
         destination_steck_count = (r->>'destination_steck_count')::int,
         big_label   = coalesce((r->>'big_label')::boolean, d.big_label),
         small_label = coalesce((r->>'small_label')::boolean, d.small_label),
         is_mult     = coalesce((r->>'is_mult')::boolean, d.is_mult),
         is_extension = coalesce((r->>'is_extension')::boolean, d.is_extension),
         split_end   = nullif(trim(r->>'split_end'),''),
         pulled      = coalesce((r->>'pulled')::boolean, d.pulled),
         labeled     = coalesce((r->>'labeled')::boolean, d.labeled),
         tested      = coalesce((r->>'tested')::boolean, d.tested),
         print_list  = coalesce((r->>'print_list')::boolean, d.print_list),
         eta = r->>'eta',
         patch_color_break = coalesce((r->>'patch_color_break')::boolean, d.patch_color_break)
  from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_details,updates}','[]'::jsonb)) r
  left join lateral (
    select t.id from cable_types t
     where t.project_id = p_project_id
       and t.model_name = nullif(trim(r->>'cable_type_name'),'')
     order by t.id limit 1
  ) ct on true
  where d.id = (r->>'v2_id')::uuid and d.project_id = p_project_id;

  -- CABLE-ARM (f): tail_details. id IS the spine id. parent_cable_id is a NAME
  -- second-pass and IS NULLABLE - R-3: orphaned tails DO import, rendering as
  -- an editable blank Mult cell (TailListClient.tsx:170), visible and fixable.
  insert into tail_details (id, project_id, tail_end,
         big_block_label, small_block_label, line_labels, panel_labels, balun_labels,
         racked, pulled, labeled)
  select (r->>'id')::uuid, p_project_id,
         nullif(trim(r->>'tail_end'),''),                        -- CHECK: source|destination
         coalesce((r->>'big_block_label')::boolean,false),
         coalesce((r->>'small_block_label')::boolean,false),
         coalesce((r->>'line_labels')::boolean,false),
         coalesce((r->>'panel_labels')::boolean,false),
         coalesce((r->>'balun_labels')::boolean,false),
         coalesce((r->>'racked')::boolean,false),
         coalesce((r->>'pulled')::boolean,false),
         coalesce((r->>'labeled')::boolean,false)
  from jsonb_array_elements(coalesce(p_plan#>'{ops,tail_details,inserts}','[]'::jsonb)) r;

  update tail_details t
     set tail_end = nullif(trim(r->>'tail_end'),''),
         big_block_label   = coalesce((r->>'big_block_label')::boolean, t.big_block_label),
         small_block_label = coalesce((r->>'small_block_label')::boolean, t.small_block_label),
         line_labels       = coalesce((r->>'line_labels')::boolean, t.line_labels),
         panel_labels      = coalesce((r->>'panel_labels')::boolean, t.panel_labels),
         balun_labels      = coalesce((r->>'balun_labels')::boolean, t.balun_labels),
         racked  = coalesce((r->>'racked')::boolean, t.racked),
         pulled  = coalesce((r->>'pulled')::boolean, t.pulled),
         labeled = coalesce((r->>'labeled')::boolean, t.labeled)
  from jsonb_array_elements(coalesce(p_plan#>'{ops,tail_details,updates}','[]'::jsonb)) r
  where t.id = (r->>'v2_id')::uuid and t.project_id = p_project_id;

  -- CABLE-ARM (g): cable_mult_lines. THE ONE ARM WHOSE SHAPE IS FORCED.
  -- cable_id is NOT NULL with an FK to the spine, so the parent CANNOT be a
  -- second pass - it resolves inside the INSERT, first-wins by cable name in
  -- source row order, exactly as R-3 rules. A line whose parent does not
  -- resolve is DROPPED here, which is why R-3 requires the pre-apply dialog:
  -- the operator is told before the apply, because afterwards it is too late
  -- to fix the data in v1. (JOY: 12 lines under 'cPreview'.)
  insert into cable_mult_lines (id, project_id, cable_id, line, description,
         source_device_text, source_connection,
         destination_device_text, destination_connection,
         line_color, starred, source_steck_count, destination_steck_count, print_list)
  select (r->>'id')::uuid, p_project_id, cb.cable_id, r->>'line', r->>'description',
         r->>'source_device_text', r->>'source_connection',
         r->>'destination_device_text', r->>'destination_connection',
         nullif(trim(r->>'line_color'),''),                     -- DOMAIN cable_color
         coalesce((r->>'starred')::boolean,false),
         (r->>'source_steck_count')::int, (r->>'destination_steck_count')::int,
         coalesce((r->>'print_list')::boolean,false)
  from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_mult_lines,inserts}','[]'::jsonb)) r
  cross join lateral (
    select (array_agg(e.id order by e.sort_order, e.id))[1] as cable_id
    from equipment_items e
    join cable_details cd on cd.id = e.id
    where e.project_id = p_project_id and e.type = 'cable'
      and cd.cable_name = nullif(trim(r->>'cable_name'),'')
  ) cb
  where cb.cable_id is not null;

  update cable_mult_lines ml
     set line = r->>'line', description = r->>'description',
         source_device_text = r->>'source_device_text',
         source_connection = r->>'source_connection',
         destination_device_text = r->>'destination_device_text',
         destination_connection = r->>'destination_connection',
         line_color = nullif(trim(r->>'line_color'),''),        -- DOMAIN cable_color
         starred = coalesce((r->>'starred')::boolean, ml.starred),
         source_steck_count = (r->>'source_steck_count')::int,
         destination_steck_count = (r->>'destination_steck_count')::int,
         print_list = coalesce((r->>'print_list')::boolean, ml.print_list),
         updated_at = now()
  from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_mult_lines,updates}','[]'::jsonb)) r
  where ml.id = (r->>'v2_id')::uuid and ml.project_id = p_project_id;

  -- CABLE-ARM (h): link_groups, then members. Recompute-only per R-2 - groups
  -- are derived from shared v1 Link X values and never invent a link.
  -- entity_type CHECK domain is exactly cable|bundle|mult_line (verified).
  insert into link_groups (id, project_id, entity_type, field_name)
  select (r->>'id')::uuid, p_project_id,
         nullif(trim(r->>'entity_type'),''), nullif(trim(r->>'field_name'),'')
  from jsonb_array_elements(coalesce(p_plan#>'{ops,link_groups,inserts}','[]'::jsonb)) r;

  -- LINK-ORPHAN, defended at write instead of only at read. item_id has NO
  -- foreign key and is 100% orphaned live (210 members, 0 resolving). This arm
  -- refuses to insert a membership whose item does not exist in this project,
  -- so a mirror re-import cannot add to the orphan pile.
  insert into link_group_members (link_id, project_id, item_id)
  select (r->>'link_id')::uuid, p_project_id, (r->>'item_id')::uuid
  from jsonb_array_elements(coalesce(p_plan#>'{ops,link_group_members,inserts}','[]'::jsonb)) r
  where exists (
      select 1 from equipment_items e
       where e.id = (r->>'item_id')::uuid and e.project_id = p_project_id)
     or exists (
      select 1 from bundles b
       where b.id = (r->>'item_id')::uuid and b.project_id = p_project_id)
     or exists (
      select 1 from cable_mult_lines ml
       where ml.id = (r->>'item_id')::uuid and ml.project_id = p_project_id)
  on conflict (link_id, item_id) do nothing;

  -- ---------------------------------------------------------------
  -- 5b. NAME SECOND-PASSES, after every spine and detail row exists.
  -- DIV-AMBIG-CLEAR: each pass now COUNTS what it skipped for ambiguity
  -- instead of skipping in silence. Omitted-because-ambiguous is not absent.
  -- ---------------------------------------------------------------

  -- BOX-ARM (e): equipment_items.box_id by box name, EXACTLY ONE match.
  select count(*) into v_amb_box from (
    select 1
    from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_items,inserts}','[]'::jsonb)) r
    cross join lateral (
      select count(*) as n from equipment_items b
      where b.project_id = p_project_id and b.type = 'box'
        and b.description = nullif(trim(r->>'box_name'),'')
    ) x
    where nullif(trim(r->>'box_name'),'') is not null and x.n > 1
  ) q;

  update equipment_items e
     set box_id = s.box_id
  from (
    select (r->>'id')::uuid as target_id, x.box_id
    from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_items,inserts}','[]'::jsonb)) r
    cross join lateral (
      select (array_agg(b.id order by b.id))[1] as box_id, count(*) as n
      from equipment_items b
      where b.project_id = p_project_id and b.type = 'box'
        and b.description = nullif(trim(r->>'box_name'),'')
    ) x
    where x.n = 1
  ) s
  where e.id = s.target_id and e.project_id = p_project_id;

  update equipment_items e
     set box_id = s.box_id
  from (
    select (r->>'v2_id')::uuid as target_id, x.box_id
    from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_items,updates}','[]'::jsonb)) r
    cross join lateral (
      select (array_agg(b.id order by b.id))[1] as box_id, count(*) as n
      from equipment_items b
      where b.project_id = p_project_id and b.type = 'box'
        and b.description = nullif(trim(r->>'box_name'),'')
    ) x
    where x.n = 1
  ) s
  where e.id = s.target_id and e.project_id = p_project_id;

  select count(*) into v_amb_within from (
    select 1
    from jsonb_array_elements(coalesce(p_plan#>'{ops,box_details,inserts}','[]'::jsonb)) r
    cross join lateral (
      select count(*) as n from equipment_items b
      where b.project_id = p_project_id and b.type = 'box'
        and b.description = nullif(trim(r->>'within_box_name'),'')
    ) x
    where nullif(trim(r->>'within_box_name'),'') is not null and x.n > 1
  ) q;

  update box_details d
     set within_box_id = s.parent_id
  from (
    select (r->>'id')::uuid as target_id, x.parent_id
    from jsonb_array_elements(coalesce(p_plan#>'{ops,box_details,inserts}','[]'::jsonb)) r
    cross join lateral (
      select (array_agg(b.id order by b.id))[1] as parent_id, count(*) as n
      from equipment_items b
      where b.project_id = p_project_id and b.type = 'box'
        and b.description = nullif(trim(r->>'within_box_name'),'')
    ) x
    where x.n = 1
  ) s
  where d.id = s.target_id;

  -- CABLE-ARM (i): bundles.box_id by box name. Same EXACTLY-ONE rule.
  -- BUNDLE-BOX-ONINSERT (2-MIG-b): the counter now spans BOTH arms, because
  -- the box pass below now spans both. Counting inserts only would have made
  -- the report quieter than the behaviour.
  select count(*) into v_amb_bundle from (
    select 1
    from (
      select r from jsonb_array_elements(coalesce(p_plan#>'{ops,bundles,inserts}','[]'::jsonb)) r
      union all
      select r from jsonb_array_elements(coalesce(p_plan#>'{ops,bundles,updates}','[]'::jsonb)) r
    ) bx
    cross join lateral (
      select count(*) as n from equipment_items b
      where b.project_id = p_project_id and b.type = 'box'
        and b.description = nullif(trim(bx.r->>'box_name'),'')
    ) x
    where nullif(trim(bx.r->>'box_name'),'') is not null and x.n > 1
  ) q;

  update bundles bu
     set box_id = s.box_id
  from (
    select (r->>'id')::uuid as target_id, x.box_id
    from jsonb_array_elements(coalesce(p_plan#>'{ops,bundles,inserts}','[]'::jsonb)) r
    cross join lateral (
      select (array_agg(b.id order by b.id))[1] as box_id, count(*) as n
      from equipment_items b
      where b.project_id = p_project_id and b.type = 'box'
        and b.description = nullif(trim(r->>'box_name'),'')
    ) x
    where x.n = 1
  ) s
  where bu.id = s.target_id and bu.project_id = p_project_id;

  -- CABLE-ARM (i2) - BUNDLE-BOX-ONINSERT (2-MIG-b). Arm (i) above reads
  -- ops.bundles.inserts ONLY, so an EXISTING bundle could never be re-boxed by
  -- a re-import: the plan carried box_name on the update row and the RPC
  -- ignored it. The plan already counts what it expected to lose
  -- (cablePlan.ts's boxLinkSkippedOnUpdate, surfaced as "Box not re-applied").
  -- This is the exact analogue of leg 1b's nestingSkippedOnUpdate.
  --
  -- SEMANTICS, chosen to MATCH the box side rather than to be clever: this is
  -- SET-ONLY, mirroring the equipment_items box_id update pass statement for
  -- statement. A blank or absent box_name does NOT clear an existing box link,
  -- so a bundle removed from its box in v1 still does not un-box in v2. That
  -- gap is REAL and is registered as an open question rather than closed here,
  -- because closing it on the bundle side alone would make the two sides of the
  -- same idiom disagree.
  update bundles bu
     set box_id = s.box_id
  from (
    select (r->>'v2_id')::uuid as target_id, x.box_id
    from jsonb_array_elements(coalesce(p_plan#>'{ops,bundles,updates}','[]'::jsonb)) r
    cross join lateral (
      select (array_agg(b.id order by b.id))[1] as box_id, count(*) as n
      from equipment_items b
      where b.project_id = p_project_id and b.type = 'box'
        and b.description = nullif(trim(r->>'box_name'),'')
    ) x
    where x.n = 1
  ) s
  where bu.id = s.target_id and bu.project_id = p_project_id;

  -- CABLE-ARM (j): cable_details.bundle_id by bundle name. bundle_name is
  -- UNIQUE per project (measured clean in all three corpora), so ambiguity is
  -- structurally impossible here - the counter is kept for symmetry and will
  -- read 0 unless the constraint is ever dropped.
  update cable_details d
     set bundle_id = bu.id
  from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_details,inserts}','[]'::jsonb)) r
  join bundles bu on bu.project_id = p_project_id
                 and bu.bundle_name = nullif(trim(r->>'bundle_name'),'')
  where d.id = (r->>'id')::uuid and d.project_id = p_project_id;

  update cable_details d
     set bundle_id = case
           when nullif(trim(r->>'bundle_name'),'') is null then null
           else coalesce(bu.id, d.bundle_id)
         end
  from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_details,updates}','[]'::jsonb)) r
  left join bundles bu on bu.project_id = p_project_id
                      and bu.bundle_name = nullif(trim(r->>'bundle_name'),'')
  where d.id = (r->>'v2_id')::uuid and d.project_id = p_project_id;

  -- CABLE-ARM (k): tail_details.parent_cable_id by cable name, first-wins per
  -- R-3. A tail whose parent does not resolve KEEPS a null parent and renders
  -- as an editable blank Mult cell. Nothing is dropped and nothing is hidden.
  select count(*) into v_amb_cable from (
    select 1
    from jsonb_array_elements(coalesce(p_plan#>'{ops,tail_details,inserts}','[]'::jsonb)) r
    cross join lateral (
      select count(*) as n
      from equipment_items e join cable_details cd on cd.id = e.id
      where e.project_id = p_project_id and e.type = 'cable'
        and cd.cable_name = nullif(trim(r->>'parent_cable_name'),'')
    ) x
    where nullif(trim(r->>'parent_cable_name'),'') is not null and x.n > 1
  ) q;

  update tail_details t
     set parent_cable_id = s.cable_id
  from (
    select (r->>'id')::uuid as target_id, x.cable_id
    from jsonb_array_elements(coalesce(p_plan#>'{ops,tail_details,inserts}','[]'::jsonb)) r
    cross join lateral (
      select (array_agg(e.id order by e.sort_order, e.id))[1] as cable_id
      from equipment_items e join cable_details cd on cd.id = e.id
      where e.project_id = p_project_id and e.type = 'cable'
        and cd.cable_name = nullif(trim(r->>'parent_cable_name'),'')
    ) x
    where x.cable_id is not null
  ) s
  where t.id = s.target_id and t.project_id = p_project_id;

  -- CABLE-ARM (l): device references on cables and mult lines, by spine
  -- description. EXACTLY-ONE, like every other name resolution here.
  select count(*) into v_amb_device from (
    select 1
    from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_details,inserts}','[]'::jsonb)) r
    cross join lateral (
      select count(*) as n from equipment_items e
      where e.project_id = p_project_id and e.type = 'generic'
        and e.description = nullif(trim(r->>'source_device_name'),'')
    ) x
    where nullif(trim(r->>'source_device_name'),'') is not null and x.n > 1
  ) q;

  update cable_details d
     set source_device_id = s.dev_id
  from (
    select (r->>'id')::uuid as target_id, x.dev_id
    from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_details,inserts}','[]'::jsonb)) r
    cross join lateral (
      select (array_agg(e.id order by e.id))[1] as dev_id, count(*) as n
      from equipment_items e
      where e.project_id = p_project_id and e.type = 'generic'
        and e.description = nullif(trim(r->>'source_device_name'),'')
    ) x
    where x.n = 1
  ) s
  where d.id = s.target_id and d.project_id = p_project_id;

  update cable_details d
     set destination_device_id = s.dev_id
  from (
    select (r->>'id')::uuid as target_id, x.dev_id
    from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_details,inserts}','[]'::jsonb)) r
    cross join lateral (
      select (array_agg(e.id order by e.id))[1] as dev_id, count(*) as n
      from equipment_items e
      where e.project_id = p_project_id and e.type = 'generic'
        and e.description = nullif(trim(r->>'destination_device_name'),'')
    ) x
    where x.n = 1
  ) s
  where d.id = s.target_id and d.project_id = p_project_id;

  update cable_mult_lines ml
     set source_device_id = s.dev_id
  from (
    select (r->>'id')::uuid as target_id, x.dev_id
    from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_mult_lines,inserts}','[]'::jsonb)) r
    cross join lateral (
      select (array_agg(e.id order by e.id))[1] as dev_id, count(*) as n
      from equipment_items e
      where e.project_id = p_project_id and e.type = 'generic'
        and e.description = nullif(trim(r->>'source_device_name'),'')
    ) x
    where x.n = 1
  ) s
  where ml.id = s.target_id and ml.project_id = p_project_id;

  update cable_mult_lines ml
     set destination_device_id = s.dev_id
  from (
    select (r->>'id')::uuid as target_id, x.dev_id
    from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_mult_lines,inserts}','[]'::jsonb)) r
    cross join lateral (
      select (array_agg(e.id order by e.id))[1] as dev_id, count(*) as n
      from equipment_items e
      where e.project_id = p_project_id and e.type = 'generic'
        and e.description = nullif(trim(r->>'destination_device_name'),'')
    ) x
    where x.n = 1
  ) s
  where ml.id = s.target_id and ml.project_id = p_project_id;

  -- CABLE-ARM (n) - BRANCH-NO-ARM (2-MIG-b). cable_types.branch_cable_type_id
  -- is a real column with an FK back to cable_types, the export already emits it
  -- as `def ends.Branch Cable Type`, and arm (c)'s INSERT names twenty-one
  -- columns without it. It is SELF-REFERENTIAL, so it cannot resolve at INSERT:
  -- the row it points at may be created later in this same plan. Hence a second
  -- pass, here, after every cable_types row exists.
  --
  -- Resolution is by model_name and is UNAMBIGUOUS BY CONSTRUCTION -
  -- cable_types_project_id_model_name_key is UNIQUE (project_id, model_name) -
  -- so there is no exactly-one counter here and none is missing. An unresolvable
  -- name leaves NULL on an insert and leaves the live value alone on an update.
  --
  -- A SELF-REFERENCE IS WRITTEN, NOT FILTERED. Measured on the v1 corpora
  -- 2026-08-25: SEVEN rows in every one of the four export sets name their own
  -- Cable Model as their Branch Cable Type (BVSC 7/40 populated, BVSC NY 7/32,
  -- JOY 7/32). A `bt.id <> t.id` guard would have read as common sense and
  -- silently dropped seven rows a show - the failure class this unit exists to
  -- close. The FK permits it; v1 means it; it is written.
  --
  -- Populated counts, measured on the same files and matching the record:
  --   BVSC NY 32/50 - BVSC 40/56 - JOY 32/48.
  -- BVSC additionally carries THREE branch names that resolve to nothing (three
  -- fibre types naming 'LC', a connector rather than a model). Those leave NULL.
  update cable_types t
     set branch_cable_type_id = bt.id
  from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_types,inserts}','[]'::jsonb)) r
  join cable_types bt on bt.project_id = p_project_id
                     and bt.model_name = nullif(trim(r->>'branch_cable_type_name'),'')
  where t.id = (r->>'id')::uuid and t.project_id = p_project_id;

  -- The UPDATE arm carries ARCH DIVERGENCE 1's idiom - an explicit blank CLEARS
  -- the link, a present-but-unresolvable name LEAVES IT ALONE - matching
  -- tail_method_id, its sibling in the very same statement.
  --
  -- THE `r ? 'branch_cable_type_name'` GUARD IS LOAD-BEARING, and its absence
  -- would have been a live regression. Today's plan does NOT emit this key:
  -- spec.ts refuses the column under BRANCH-NO-ARM. Without the existence test,
  -- an absent key would read as an explicit blank and CLEAR every branch link on
  -- every updated cable type on the first re-import after this migration. Same
  -- shape as BOX-NOBOX's "absent key preserves the live value".
  update cable_types t
     set branch_cable_type_id = case
           when nullif(trim(r->>'branch_cable_type_name'),'') is null then null
           else coalesce(bt.id, t.branch_cable_type_id)
         end
  from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_types,updates}','[]'::jsonb)) r
  left join cable_types bt on bt.project_id = p_project_id
                          and bt.model_name = nullif(trim(r->>'branch_cable_type_name'),'')
  where t.id = (r->>'v2_id')::uuid and t.project_id = p_project_id
    and (r ? 'branch_cable_type_name');

  -- ---------------------------------------------------------------
  -- 6. deletes, reverse FK order
  -- ---------------------------------------------------------------
  -- CABLE-ARM (m): memberships and groups first. link_group_members CASCADEs
  -- off link_groups.link_id, so the explicit member delete exists only for
  -- removing a member while its group survives.
  delete from link_group_members
  where project_id = p_project_id
    and item_id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,link_group_members,deleteIds}','[]'::jsonb)));

  delete from link_groups
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,link_groups,deleteIds}','[]'::jsonb)));

  -- Mult lines deleted on their own (a line removed while its cable stays).
  -- A line removed WITH its cable rides the equipment_items CASCADE below.
  delete from cable_mult_lines
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_mult_lines,deleteIds}','[]'::jsonb)));

  -- The spine delete. MEASURED BLAST RADIUS, so nobody has to re-measure it:
  -- six CASCADE arms  - box_details, cable_details, tail_details,
  --                     cable_mult_lines, maintenance_history, rf_device_details
  -- eleven SET NULL arms - equipment_items.box_id (self), box_details.within_box_id,
  --                     bundles.box_id, cable_details {allocated_from_id,
  --                     source_device_id, destination_device_id, split_of_id},
  --                     cable_mult_lines {source_device_id, destination_device_id},
  --                     tail_details.parent_cable_id, cast_members.rf_device_id
  -- Live today: maintenance_history 0 rows, rf_device_details 0 rows,
  -- cast_members.rf_device_id 0 non-null. The last three become real only if
  -- the mirror ever scopes 'rf' (BVSC-RF, post-beta).
  delete from equipment_items
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_items,deleteIds}','[]'::jsonb)));

  delete from equipment_library_items
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_library_items,deleteIds}','[]'::jsonb)));

  -- MIRROR-SYSMETHOD (b) — THE RIDER. Daniel, Aug 22: (a) landed plan-side at
  -- d39179a; (b), the data-layer backstop, rides the next migration. This is
  -- the next migration. A seeded system row is never a delete candidate no
  -- matter what the plan says.
  -- Checked per table and it does NOT repeat: seed_project_na_rows inserts
  -- into `methods` and nothing else, and is_system exists on exactly one table
  -- in the whole database. No cable table needs this guard.
  delete from methods
  where project_id = p_project_id
    and not is_system
    and id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,methods,deleteIds}','[]'::jsonb)));

  delete from categories
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,categories,deleteIds}','[]'::jsonb)));

  -- SET NULL parents delete LAST, so their children are already gone or
  -- already repointed. Same reason BOX-ARM (f) put box_types here.
  delete from bundles
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,bundles,deleteIds}','[]'::jsonb)));

  delete from cable_types
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_types,deleteIds}','[]'::jsonb)));

  -- BOX-ARM (f): box_types deletes last. box_type_id is ON DELETE SET NULL.
  delete from box_types
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid
               from jsonb_array_elements(coalesce(p_plan#>'{ops,box_types,deleteIds}','[]'::jsonb)));

  -- ---------------------------------------------------------------
  -- 7. identity map maintenance
  -- ---------------------------------------------------------------
  -- CABLE-IDENTITY-GAP, import side. Previously equipment_items only, which is
  -- why bundles and cable_mult_lines exported a blank HistoryID. The three
  -- statements below are now entity_table-driven so a cable-side plan carries
  -- its own identity rows. 'box_details' was noted as leg 1b's scope in the
  -- prior body; that comment is retired - identity is keyed on the spine id.
  delete from import_identity_map
  where project_id = p_project_id and entity_table = 'equipment_items'
    and v2_id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_items,deleteIds}','[]'::jsonb)));

  delete from import_identity_map
  where project_id = p_project_id and entity_table = 'bundles'
    and v2_id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,bundles,deleteIds}','[]'::jsonb)));

  delete from import_identity_map
  where project_id = p_project_id and entity_table = 'cable_mult_lines'
    and v2_id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,cable_mult_lines,deleteIds}','[]'::jsonb)));

  -- Inserts now carry entity_table from the plan row, defaulting to
  -- 'equipment_items' so every pre-migration plan behaves exactly as before.
  insert into import_identity_map (project_id, entity_table, v1_history_id, row_hash,
         assigned_history_id, v2_id, first_run_id, last_seen_run_id)
  select p_project_id,
         coalesce(nullif(trim(r->>'entity_table'),''), 'equipment_items'),
         (r->>'v1_history_id')::uuid, r->>'row_hash',
         (r->>'assigned_history_id')::uuid, (r->>'v2_id')::uuid, v_run_id, v_run_id
  from jsonb_array_elements(coalesce(p_plan#>'{identity,inserts}','[]'::jsonb)) r;

  update import_identity_map im
     set v1_history_id = (r->>'v1_history_id')::uuid, last_seen_run_id = v_run_id
  from jsonb_array_elements(coalesce(p_plan#>'{identity,upgrades}','[]'::jsonb)) r
  where im.project_id = p_project_id
    and im.entity_table = coalesce(nullif(trim(r->>'entity_table'),''), 'equipment_items')
    and im.v2_id = (r->>'v2_id')::uuid;

  -- MATCHED-BUNDLE-ID (2-MIG-b). This refresh was 'equipment_items'-only, so a
  -- matched BUNDLE's identity row was never stamped with the run that saw it -
  -- bookkeeping, not data, but it makes last_seen_run_id lie about bundles.
  -- The entity_table filter is DROPPED rather than widened to a list: v2_id is a
  -- uuid primary key, so it is unique across every entity table at once. Two
  -- measurements back that, taken live 2026-08-25: zero v2_id values appear
  -- under more than one entity_table, and the plan already sends bundle ids in
  -- this array. The project_id filter still bounds the statement.
  update import_identity_map
     set last_seen_run_id = v_run_id
  where project_id = p_project_id
    and v2_id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{identity,matchedV2Ids}','[]'::jsonb)));

  -- ---------------------------------------------------------------
  -- 8. finish
  -- ---------------------------------------------------------------
  update import_runs set status = 'succeeded', finished_at = now() where id = v_run_id;

  -- DIV-AMBIG-CLEAR: the return payload now distinguishes
  -- omitted-because-ambiguous from absent. Keys are additive; every existing
  -- caller reading run_id and status is unaffected.
  return jsonb_build_object(
    'run_id', v_run_id,
    'status', 'succeeded',
    'ambiguous', jsonb_build_object(
      'equipment_box_name',   v_amb_box,
      'within_box_name',      v_amb_within,
      'bundle_box_name',      v_amb_bundle,
      'tail_parent_cable',    v_amb_cable,
      'cable_source_device',  v_amb_device,
      'cable_type_name',      v_amb_ctype
    ),
    -- ADDITIVE, and deliberately a NEW TOP-LEVEL key rather than a sixth
    -- `ambiguous` counter. ImportV1Client renders `ambiguous` through a FIXED
    -- label map (AMBIGUOUS_LABELS), so a new key inside that object would be
    -- invisible in the UI - a silent skip wearing a counter's clothes. At top
    -- level its absence from the report is obvious, and surfacing it is named
    -- plan-side work in 2-IMP-b. It is not an ambiguity: the name resolved
    -- perfectly well, to a row that already owns it.
    'skipped', jsonb_build_object(
      'bundle_rename_collision', v_rename_blocked
    ));
end;
$function$;

-- Grants: CREATE OR REPLACE preserves the existing ACL
-- ({postgres=X/postgres,authenticated=X/postgres}), but Engineering Standards
-- requires them restated and verified whenever an object is recreated.
GRANT EXECUTE ON FUNCTION public.import_apply_v1(uuid, jsonb, jsonb, text, text, jsonb, jsonb) TO authenticated;


-- =====================================================================
-- PART 2 · POST-APPLY VERIFICATION  (run standalone AFTER the apply)
-- =====================================================================
-- Includes grants AND privilege level, per Engineering Standards. The grant
-- check is not a formality: on 2-MIG it caught a PUBLIC EXECUTE that no
-- rehearsal could have.

-- 2.1 all three signatures, INVOKER, search_path, ACL
select p.proname,
       pg_get_function_identity_arguments(p.oid) as args,
       p.prosecdef                                as security_definer_should_be_false,
       p.proconfig                                as config_should_be_search_path_public,
       p.proacl::text                             as acl_should_be_postgres_and_authenticated
from pg_proc p join pg_namespace n on n.oid = p.pronamespace
where n.nspname='public' and p.proname in ('import_apply_v1','export_mint_identity')
order by p.proname, args;

-- 2.2 PRIVILEGE LEVEL, measured with has_function_privilege rather than by
-- pattern-matching the ACL text. 'postgres=X/postgres' contains '=X/postgres',
-- which is how a LIKE '%=X/postgres%' count returned 3 on 2-MIG when the true
-- answer was 1. anon MUST be false on all three; authenticated MUST be true.
select has_function_privilege('authenticated',
         'public.import_apply_v1(uuid,jsonb,jsonb,text,text,jsonb,jsonb)','EXECUTE') as import_exec_authenticated_expect_t,
       has_function_privilege('anon',
         'public.import_apply_v1(uuid,jsonb,jsonb,text,text,jsonb,jsonb)','EXECUTE') as import_exec_anon_expect_f,
       has_function_privilege('authenticated','public.export_mint_identity(uuid)','EXECUTE')        as export_1arg_authenticated_expect_t,
       has_function_privilege('anon','public.export_mint_identity(uuid)','EXECUTE')                 as export_1arg_anon_expect_f,
       has_function_privilege('authenticated','public.export_mint_identity(uuid,text)','EXECUTE')   as export_2arg_authenticated_expect_t,
       has_function_privilege('anon','public.export_mint_identity(uuid,text)','EXECUTE')            as export_2arg_anon_expect_f;

-- 2.3 the five arms are present, and no bare colour write survives anywhere
select (length(d) - length(replace(d,'branch_cable_type_name','')))/22            as branch_hits_expect_5,
       (length(d) - length(replace(d,'bundle_rename_collision','')))/23           as rename_counter_hits_expect_1,
       (length(d) - length(replace(d,'{ops,bundles,updates}','')))/21             as bundles_updates_refs_expect_4,
       (length(d) - length(replace(d,E'= r->>\'flagged_end_color\'','')))/26      as bare_flagged_expect_0,
       (length(d) - length(replace(d,E'= r->>\'color\'','')))/15                  as bare_color_expect_0,
       (length(d) - length(replace(d,E'= r->>\'line_color\'','')))/20             as bare_line_color_expect_0,
       (length(d) - length(replace(d,'nullif(trim(','')))/12                      as nullif_trim_expect_74  -- counts COMMENT text too; the md5 above is the real check
from (select pg_get_functiondef(p.oid) as d from pg_proc p
      join pg_namespace n on n.oid=p.pronamespace
      where n.nspname='public' and p.proname='import_apply_v1') s;

-- 2.4 nothing was written: this migration touches no rows
select (select count(*) from equipment_items)     as equipment_items,
       (select count(*) from cable_details)       as cable_details_expect_1611,
       (select count(*) from cable_mult_lines)    as cable_mult_lines_expect_1228,
       (select count(*) from bundles)             as bundles_expect_100,
       (select count(*) from cable_types)         as cable_types_expect_96,
       (select count(*) from cable_types where branch_cable_type_id is not null) as branch_populated_expect_unchanged,
       (select count(*) from link_groups)         as link_groups_expect_54,
       (select count(*) from import_identity_map) as identity_rows_expect_6243;

-- 2.5 the ledger moved by exactly one
select count(*) as ledger_count_expect_55,
       max(version) as head
from supabase_migrations.schema_migrations;

-- =====================================================================
-- END 2-MIG-b
-- =====================================================================
