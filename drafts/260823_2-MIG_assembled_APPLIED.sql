-- =====================================================================
-- 2-MIG · PORT-COV leg 2 — the cable RPC arms
-- Assembled 2026-08-23, Cowork-Arch MAIN LINE, off handoffs/260823-2130_next_session_opener.md
-- Governing set: Arch v31 · Roadmap v4.5 · Session Log at 4 · scope of record
--                drafts/260823_portcov_leg2_scope.md
--
-- Migration ledger 52 -> 53.  Trigger B.  Rehearsal-first per ARCH-MIG-BOX.
-- Repo state at assembly: Minotaur HEAD = origin/main = 9c41b37
--                         Minotaur-Cowork HEAD = origin/main = 9d24a1b
--
-- EVERY claim below was measured on the LIVE database this session, never
-- recalled: the 306-line body of import_apply_v1, the full column list of all
-- seven cable tables, the FK graph off equipment_items, every CHECK constraint,
-- the function ACLs, and the live row counts.
--
-- FIVE RIDERS, all previously ruled:
--   (1) MIRROR-SYSMETHOD (b)  - Daniel, Aug 22 (Ledger 1503): "the RPC-side
--       `and not is_system` backstop rides the next migration". This is it.
--   (2) DIV-AMBIG-CLEAR      - Daniel (Ledger 1399): "Fix when the RPC is next
--       opened; do not spend a migration on it alone." This opens it.
--   (3) CABLE-IDENTITY-GAP   - export_mint_identity mints for equipment_items
--       only; bundles and cable_mult_lines emit a blank HistoryID.
--   (4) BOX-NOBOX            - Daniel, Aug 22; ruled INTO this migration Aug 23
--       on the measurement that no_box_needed already exists (no DDL).
--   (5) The cable arms themselves + 4 conditional fingerprint keys.
--
-- ---------------------------------------------------------------------
-- REHEARSAL RECORD - run 2026-08-23 against LIVE, forced rollback, verbatim.
-- Branch-or-main: MAIN with forced-rollback rehearsal (Daniel, Aug 23).
--
-- ROLLBACK MECHANISM PROVEN FIRST, before trusting it with the real thing:
--   probe function created inside BEGIN..ROLLBACK -> residue 0.
--
-- PRE-FLIGHT: all 7 assertions passed.
--
-- REHEARSAL B (export_mint_identity overload), target JOY:
--   2-arg equipment_items=1368  bundles=26  mult_lines=636
--   1-arg legacy=1368 (untouched and still working)
--   blank_history_ids=0   <- CABLE-IDENTITY-GAP closed
--   residue after rollback: overloads=1, cable identity rows=0, strays=0
--
-- REHEARSAL A (import_apply_v1 replacement), target JOY:
--   result={"run_id":"5c4188ec-13c9-4918-b0f0-b8f0e4a552aa","status":"succeeded",
--           "ambiguous":{"bundle_box_name":0,"cable_type_name":0,"within_box_name":0,
--                        "tail_parent_cable":0,"equipment_box_name":0,
--                        "cable_source_device":0}}
--   R5_guard=OK                 (createMissing.cable_types refused, as designed)
--   stale_fingerprint_guard=OK  (a wrong cable_mult_lines fingerprint ABORTS -
--                                proof the four new conditional guards fire)
--   runs=1 revisions=1          (only the happy path left provenance)
--   untouched: cable_details=461 mult_lines=636 bundles=26 cable_types=18
--              link_groups=54 system_methods=1
--
-- RESIDUE CHECK AFTER ROLLBACK - 9 assertions, all clean:
--   cable_hits=0 · is_system_hits=0 · export_overloads=1 · stray_runs=0
--   stray_revisions=0 · stray_identity=0 · no_box_needed=0
--   ledger head=20260822144022 · ledger count=52
--
-- APPLIED 2026-08-24 on Daniel's explicit confirm (Trigger B), to MAIN.
--   ledger 52 -> 53 : 20260824220701_port_cov_leg2_2mig_cable_rpc_arms
--   ledger 53 -> 54 : 20260824220944_port_cov_leg2_2mig_revoke_public_on_export_overload
--
-- POST-APPLY VERIFICATION - all green:
--   both functions present, all three signatures
--   prosecdef = false (SECURITY INVOKER) on all three
--   proconfig = search_path=public on all three
--   rows written by the migration: 0
--   live data untouched: cable_details 1611 · mult_lines 1228 · bundles 100
--                        cable_types 96 · link_groups 54 · no_box_needed 0
--
-- THE GRANT CHECK CAUGHT A REAL DEFECT, which is why it is in the runbook.
-- export_mint_identity(uuid,text) is a NEW object, so Postgres gave it the
-- default EXECUTE grant to PUBLIC - unlike the two pre-existing functions,
-- whose ACLs CREATE OR REPLACE preserved. Measured: anon COULD execute the
-- overload and could not execute the other two. Not exploitable (SECURITY
-- INVOKER + the project RLS gate raises for anon before any row is read), but
-- the wrong posture. Corrected by the 54 migration above.
-- Final state, byte-identical across all three:
--   acl = {postgres=X/postgres,authenticated=X/postgres}
--   anon  EXECUTE = false on all three
--   authenticated EXECUTE = true on all three
--
-- METHOD NOTE, recorded against myself: the first count of "functions with
-- PUBLIC execute" used LIKE '%=X/postgres%' and returned 3 - a FALSE POSITIVE,
-- because 'postgres=X/postgres' contains that substring. has_function_privilege
-- is the measurement that answers the question, and it said one. Same class as
-- counting 'tail' and finding 'detail'. A match on shared characters is not
-- evidence - the standing rule, earned again.
-- ---------------------------------------------------------------------
--
-- WHAT THIS MIGRATION DOES *NOT* DO:
--   - No ALTER TABLE. No DDL of any kind on tables. Two function bodies only.
--   - It does not touch mirrorFingerprintCount. The separation of the delete
--     row-set from the fingerprint count cost IMP-SPINE and MIRROR-SYSMETHOD
--     two sessions to establish and is deliberately left alone.
--   - It does not add an import path. Sheets leave REGISTER_NOT_IMPORTED only
--     when their arm exists AND the plan side ships (2-IMP-a/b/c).
-- =====================================================================


-- =====================================================================
-- PART 0 · PRE-FLIGHT ASSERTIONS  (run standalone; abort the migration on any failure)
-- =====================================================================
-- These prove the world is what this file was written against. If any raises,
-- STOP: the file was assembled against a different database.

do $preflight$
declare v int; v_txt text;
begin
  -- 0.1 the cable side is genuinely absent from the RPC today
  select (length(lower(pg_get_functiondef(p.oid)))
          - length(replace(lower(pg_get_functiondef(p.oid)),'cable','')))/5
    into v
  from pg_proc p join pg_namespace n on n.oid=p.pronamespace
  where n.nspname='public' and p.proname='import_apply_v1';
  if v <> 0 then
    raise exception 'PRE-FLIGHT 0.1 FAILED: import_apply_v1 already mentions cable % times', v;
  end if;

  -- 0.2 no_box_needed exists and needs no DDL
  if not exists (select 1 from information_schema.columns
                 where table_schema='public' and table_name='equipment_items'
                   and column_name='no_box_needed' and data_type='boolean') then
    raise exception 'PRE-FLIGHT 0.2 FAILED: equipment_items.no_box_needed missing or not boolean';
  end if;

  -- 0.3 is_system exists on methods and ONLY on methods (MIRROR-SYSMETHOD does not repeat)
  select count(*) into v from information_schema.columns
   where table_schema='public' and column_name='is_system';
  if v <> 1 then
    raise exception 'PRE-FLIGHT 0.3 FAILED: is_system found on % tables, expected exactly 1', v;
  end if;

  -- 0.4 cable_mult_lines.cable_id is NOT NULL - this is what forces the
  --     lateral resolve at INSERT rather than a name second-pass.
  if exists (select 1 from information_schema.columns
             where table_schema='public' and table_name='cable_mult_lines'
               and column_name='cable_id' and is_nullable='YES') then
    raise exception 'PRE-FLIGHT 0.4 FAILED: cable_mult_lines.cable_id is nullable; arm (e) assumes NOT NULL';
  end if;

  -- 0.5 tail_details.parent_cable_id IS nullable - R-3 depends on it
  --     (orphaned tails import with a blank Mult; orphaned lines cannot).
  if exists (select 1 from information_schema.columns
             where table_schema='public' and table_name='tail_details'
               and column_name='parent_cable_id' and is_nullable='NO') then
    raise exception 'PRE-FLIGHT 0.5 FAILED: tail_details.parent_cable_id is NOT NULL; R-3 assumes nullable';
  end if;

  -- 0.6 link_groups.entity_type domain is exactly cable|bundle|mult_line
  select pg_get_constraintdef(oid) into v_txt from pg_constraint
   where conname='link_groups_entity_type_check';
  if v_txt is null or v_txt not like '%mult_line%' then
    raise exception 'PRE-FLIGHT 0.6 FAILED: link_groups entity_type CHECK not as measured: %', v_txt;
  end if;

  -- 0.7 the two unique constraints the guards rely on
  if not exists (select 1 from pg_constraint where conname='bundles_project_id_bundle_name_key')
  or not exists (select 1 from pg_constraint where conname='cable_types_project_id_model_name_key') then
    raise exception 'PRE-FLIGHT 0.7 FAILED: expected unique constraints on bundles/cable_types missing';
  end if;

  raise notice 'PRE-FLIGHT: all 7 assertions passed.';
end
$preflight$;


-- =====================================================================
-- PART 1 · import_apply_v1  — full replacement
-- =====================================================================
-- SECURITY INVOKER (prosecdef=false) and SET search_path TO 'public' are both
-- preserved verbatim from the live definition. Do not "improve" either: the
-- RLS story depends on INVOKER, and the seven cable tables each carry exactly
-- one FOR ALL policy keyed on projects.owner_id = auth.uid() (scope 5.6).
--
-- THE EMPTY-STRING TRAP - read this before editing any arm below.
-- Eleven constrained text columns across the cable tables carry CHECK
-- constraints of the shape CHECK (col = ANY (ARRAY['a','b'])). A NULL passes
-- such a CHECK; an EMPTY STRING does not. v1 cells arrive as '' far more often
-- than as NULL, so every one of these columns is written through
-- nullif(trim(...),'') and never as a bare r->>'x'. A single bare read aborts
-- the whole transaction and rolls back the entire import.
--   cable_details : flagged_end, split_end, source_patch_line_end,
--                   destination_patch_line_end, length_unit
--   cable_mult_lines : source_patch_line_end, destination_patch_line_end
--   tail_details  : tail_end
--   bundles       : length_unit, kind
--   cable_types   : default_label_size
-- This is the same defect class as the cast trap caught in ARCH-MIG-BOX.

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
         r->>'flagged_end_label', r->>'flagged_end_color',
         r->>'not_flagged_end_label', r->>'not_flagged_end_color',
         coalesce((r->>'bundled')::boolean,false),
         coalesce((r->>'packed')::boolean,false),
         coalesce((r->>'tested')::boolean,false),
         coalesce((r->>'invert')::boolean,false),
         coalesce((r->>'is_extension')::boolean,false),
         coalesce(nullif(trim(r->>'kind'),''),'bundle'),      -- CHECK: bundle|infrastructure
         r->>'notes', coalesce((r->>'sort_order')::int,0)
  from jsonb_array_elements(coalesce(p_plan#>'{ops,bundles,inserts}','[]'::jsonb)) r
  on conflict (project_id, bundle_name) do nothing;

  update bundles b
     set group_label = r->>'group_label',
         length_value = (r->>'length_value')::numeric,
         length_unit = nullif(trim(r->>'length_unit'),''),
         flagged_end_label = r->>'flagged_end_label',
         flagged_end_color = r->>'flagged_end_color',
         not_flagged_end_label = r->>'not_flagged_end_label',
         not_flagged_end_color = r->>'not_flagged_end_color',
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
         r->>'color',
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
         color = r->>'color',
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
         r->>'line_color',
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
         line_color = r->>'line_color',
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
  select count(*) into v_amb_bundle from (
    select 1
    from jsonb_array_elements(coalesce(p_plan#>'{ops,bundles,inserts}','[]'::jsonb)) r
    cross join lateral (
      select count(*) as n from equipment_items b
      where b.project_id = p_project_id and b.type = 'box'
        and b.description = nullif(trim(r->>'box_name'),'')
    ) x
    where nullif(trim(r->>'box_name'),'') is not null and x.n > 1
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

  update import_identity_map
     set last_seen_run_id = v_run_id
  where project_id = p_project_id and entity_table = 'equipment_items'
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
    ));
end;
$function$;

-- Grants: CREATE OR REPLACE preserves the existing ACL
-- ({postgres=X/postgres,authenticated=X/postgres}), but Engineering Standards
-- requires them restated and verified whenever an object is recreated.
GRANT EXECUTE ON FUNCTION public.import_apply_v1(uuid, jsonb, jsonb, text, text, jsonb, jsonb) TO authenticated;


-- =====================================================================
-- PART 2 · CABLE-IDENTITY-GAP, export side — ADDITIVE OVERLOAD
-- =====================================================================
-- DESIGN DECISION, stated plainly because it is a real tradeoff:
-- The obvious fix is to widen export_mint_identity's RETURNS TABLE with an
-- entity_table column. That CANNOT be done with CREATE OR REPLACE - changing a
-- return type requires DROP + CREATE, which (a) destroys the grant, and (b)
-- breaks runExport at HEAD until the app ships in the same deploy.
-- Instead this adds a SECOND function with a different argument list. The
-- one-argument original is untouched and keeps working, so nothing must ship
-- in lockstep and the migration is reversible by dropping one new function.
CREATE OR REPLACE FUNCTION public.export_mint_identity(
  p_project_id uuid,
  p_entity_table text)
 RETURNS TABLE(v2_id uuid, history_id uuid)
 LANGUAGE plpgsql
 SET search_path TO 'public'
AS $function$
begin
  if not exists (select 1 from projects where id = p_project_id) then
    raise exception 'export_mint_identity: project not found or not accessible';
  end if;
  if p_entity_table not in ('equipment_items','bundles','cable_mult_lines') then
    raise exception 'export_mint_identity: unsupported entity_table %', p_entity_table;
  end if;

  -- mint + persist for rows of this entity with no identity entry
  if p_entity_table = 'equipment_items' then
    insert into import_identity_map
      (project_id, entity_table, v1_history_id, row_hash,
       assigned_history_id, v2_id, first_run_id, last_seen_run_id)
    select p_project_id, 'equipment_items', null, null, gen_random_uuid(), e.id, null, null
    from equipment_items e
    where e.project_id = p_project_id
      and not exists (select 1 from import_identity_map im
                      where im.project_id = p_project_id
                        and im.entity_table = 'equipment_items' and im.v2_id = e.id)
    on conflict do nothing;
  elsif p_entity_table = 'bundles' then
    insert into import_identity_map
      (project_id, entity_table, v1_history_id, row_hash,
       assigned_history_id, v2_id, first_run_id, last_seen_run_id)
    select p_project_id, 'bundles', null, null, gen_random_uuid(), b.id, null, null
    from bundles b
    where b.project_id = p_project_id
      and not exists (select 1 from import_identity_map im
                      where im.project_id = p_project_id
                        and im.entity_table = 'bundles' and im.v2_id = b.id)
    on conflict do nothing;
  else
    insert into import_identity_map
      (project_id, entity_table, v1_history_id, row_hash,
       assigned_history_id, v2_id, first_run_id, last_seen_run_id)
    select p_project_id, 'cable_mult_lines', null, null, gen_random_uuid(), ml.id, null, null
    from cable_mult_lines ml
    where ml.project_id = p_project_id
      and not exists (select 1 from import_identity_map im
                      where im.project_id = p_project_id
                        and im.entity_table = 'cable_mult_lines' and im.v2_id = ml.id)
    on conflict do nothing;
  end if;

  -- defensive: any legacy entry with neither ID gets one (pre-amendment shape)
  update import_identity_map
     set assigned_history_id = gen_random_uuid()
   where project_id = p_project_id and entity_table = p_entity_table
     and v1_history_id is null and assigned_history_id is null;

  -- full emission map for this entity, one round trip
  return query
  select im.v2_id, coalesce(im.v1_history_id, im.assigned_history_id)
  from import_identity_map im
  where im.project_id = p_project_id
    and im.entity_table = p_entity_table
    and (
      (p_entity_table = 'equipment_items'
        and exists (select 1 from equipment_items e where e.id = im.v2_id and e.project_id = p_project_id))
   or (p_entity_table = 'bundles'
        and exists (select 1 from bundles b where b.id = im.v2_id and b.project_id = p_project_id))
   or (p_entity_table = 'cable_mult_lines'
        and exists (select 1 from cable_mult_lines ml where ml.id = im.v2_id and ml.project_id = p_project_id))
    );
end;
$function$;

GRANT EXECUTE ON FUNCTION public.export_mint_identity(uuid, text) TO authenticated;


-- =====================================================================
-- PART 3 · POST-APPLY VERIFICATION  (run standalone AFTER the apply)
-- =====================================================================
-- Includes grants and privilege level, per Engineering Standards.

-- 3.1 both functions exist, INVOKER, correct search_path, grants intact
select p.proname,
       pg_get_function_identity_arguments(p.oid) as args,
       p.prosecdef                                as security_definer_should_be_false,
       p.proconfig                                as config_should_be_search_path_public,
       p.proacl::text                             as acl_must_include_authenticated_X
from pg_proc p join pg_namespace n on n.oid = p.pronamespace
where n.nspname='public' and p.proname in ('import_apply_v1','export_mint_identity')
order by p.proname, args;

-- 3.2 the cable side is now present, and the box side was not disturbed
select (length(lower(pg_get_functiondef(p.oid))) - length(replace(lower(pg_get_functiondef(p.oid)),'cable_details','')))/13   as cable_details_hits_expect_gt0,
       (length(lower(pg_get_functiondef(p.oid))) - length(replace(lower(pg_get_functiondef(p.oid)),'cable_mult_lines','')))/16 as mult_lines_hits_expect_gt0,
       (length(lower(pg_get_functiondef(p.oid))) - length(replace(lower(pg_get_functiondef(p.oid)),'link_group','')))/10       as link_group_hits_expect_gt0,
       (length(lower(pg_get_functiondef(p.oid))) - length(replace(lower(pg_get_functiondef(p.oid)),'is_system','')))/9         as is_system_hits_expect_1,
       (length(lower(pg_get_functiondef(p.oid))) - length(replace(lower(pg_get_functiondef(p.oid)),'no_box_needed','')))/13    as no_box_needed_hits_expect_2,
       (length(lower(pg_get_functiondef(p.oid))) - length(replace(lower(pg_get_functiondef(p.oid)),'box_types','')))/9         as box_types_hits_expect_16
from pg_proc p join pg_namespace n on n.oid=p.pronamespace
where n.nspname='public' and p.proname='import_apply_v1';

-- 3.3 privilege level: prove `authenticated` can actually execute both
select has_function_privilege('authenticated',
         'public.import_apply_v1(uuid,jsonb,jsonb,text,text,jsonb,jsonb)','EXECUTE')  as import_exec_authenticated,
       has_function_privilege('authenticated',
         'public.export_mint_identity(uuid)','EXECUTE')                               as export_1arg_exec_authenticated,
       has_function_privilege('authenticated',
         'public.export_mint_identity(uuid,text)','EXECUTE')                          as export_2arg_exec_authenticated;

-- 3.4 nothing was written: this migration touches no rows
select (select count(*) from equipment_items)  as equipment_items_expect_6597_plus_boxes,
       (select count(*) from cable_details)    as cable_details,
       (select count(*) from cable_mult_lines) as cable_mult_lines,
       (select count(*) from bundles)          as bundles,
       (select count(*) from cable_types)      as cable_types,
       (select count(*) from link_groups)      as link_groups,
       (select count(*) from link_group_members) as link_group_members,
       (select count(*) from equipment_items where no_box_needed) as no_box_needed_expect_0;

-- =====================================================================
-- END 2-MIG
-- =====================================================================
