-- =====================================================================
-- ARCH-MIG-BOX — assembled migration, ledger 51 -> 52
-- Assembled 2026-08-22 by Arch (claude.ai seat) from
--   drafts/260821-1500_arch_migration_package_box_side.md
-- against the LIVE definition of public.import_apply_v1 and the LIVE
-- column lists of box_details / box_types / equipment_items.
--
-- Daniel's rulings carried:
--   BOX-NUM-TYPE  -> widen box_details.box_number numeric -> TEXT
--   branch-or-main -> MAIN, with a rehearsal run that rolls back
--
-- STATUS: APPLIED 2026-08-22 as migration 20260822144022,
--         name arch_mig_box_widen_box_number_and_rpc_box_arms, ledger 51 -> 52.
--         Rehearsal ran first and rolled back clean; real apply verified green.
--         Both Arch divergences approved by Daniel 2026-08-22.
--
-- Run §A first. It executes everything and then deliberately fails, so
-- nothing is kept. Only after §A reports clean does §B run for real.
-- =====================================================================


-- =====================================================================
-- §A — REHEARSAL. Deliberately aborts. Nothing persists.
--      Paste §A0 + §A1 + §A2 + §A3 + §A4 as ONE statement batch.
-- =====================================================================

-- --- §A0 -------------------------------------------------------------
-- Pre-flight. Corrected: the original §1.4 compared an expression to
-- itself and could never fail. This computes the same answer by an
-- independent route (float8 shortest-representation, which is the same
-- rule the browser uses) and requires the two to agree on every row.
do $preflight$
declare
  v_pop int;
  v_mismatch int;
  v_unsafe int;
begin
  select count(*) into v_pop
    from box_details where box_number is not null;

  if v_pop <> 162 then
    raise exception
      'PRE-FLIGHT FAIL: box_number population is % (expected 162). Someone has written box numbers since this package was measured — re-measure before applying.',
      v_pop;
  end if;

  select count(*) into v_unsafe
    from box_details
   where box_number is not null
     and abs(box_number) >= 9007199254740991::numeric;

  if v_unsafe <> 0 then
    raise exception
      'PRE-FLIGHT FAIL: % row(s) exceed the magnitude where the independent check is trustworthy.',
      v_unsafe;
  end if;

  select count(*) into v_mismatch
    from box_details
   where box_number is not null
     and box_number::float8::text is distinct from
         (case when box_number = trunc(box_number)
               then trunc(box_number)::bigint::text
               else rtrim(rtrim(box_number::text,'0'),'.') end);

  if v_mismatch <> 0 then
    raise exception
      'PRE-FLIGHT FAIL: % row(s) would render differently after the cast. DO NOT APPLY.',
      v_mismatch;
  end if;

  raise notice 'PRE-FLIGHT OK: 162 rows, 0 render changes, 0 unsafe magnitudes.';
end
$preflight$;


-- --- §A1 -------------------------------------------------------------
-- The widening. The USING clause reproduces String(Number(x)) exactly.
-- Measured 2026-08-22: 153 of 162 rows are stored with a trailing .0,
-- so a naive box_number::text would have changed 153 printed labels.
alter table public.box_details
  alter column box_number type text
  using case
    when box_number is null then null
    when box_number = trunc(box_number) then trunc(box_number)::bigint::text
    else rtrim(rtrim(box_number::text, '0'), '.')
  end;


-- --- §A2 -------------------------------------------------------------
-- import_apply_v1, complete. Unchanged regions are byte-verbatim from
-- the live definition read 2026-08-22. Added regions are marked BOX-ARM.
create or replace function public.import_apply_v1(
  p_project_id uuid,
  p_plan jsonb,
  p_snapshot jsonb,
  p_revision_name text,
  p_source_label text,
  p_file_manifest jsonb default '[]'::jsonb,
  p_counts jsonb default '{}'::jsonb
)
 returns jsonb
 language plpgsql
 set search_path to 'public'
as $function$
declare
  v_run_id uuid; v_live int; v_base int;
begin
  -- 0. project visible under caller's RLS
  if not exists (select 1 from projects where id = p_project_id) then
    raise exception 'import_apply_v1: project not found or not accessible';
  end if;

  -- 1. stale-plan fingerprint guard (2C-3)
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
  -- No box_details fingerprint by design: the equipment_items count above is
  -- unscoped by type and therefore already fingerprints box spine rows.
  if p_plan#>>'{fingerprint,box_types}' is not null then
    select count(*) into v_live from box_types where project_id = p_project_id;
    if v_live is distinct from (p_plan#>>'{fingerprint,box_types}')::int then
      raise exception 'state changed since dry-run (box_types: plan %, live %) — re-run dry-run',
        p_plan#>>'{fingerprint,box_types}', v_live;
    end if;
  end if;

  -- 2. provenance run row (IMP-5)
  insert into import_runs (project_id, source_label, file_manifest, counts, dry_run, status, created_by)
  values (p_project_id, p_source_label, p_file_manifest, p_counts, false, 'running', auth.uid())
  returning id into v_run_id;

  -- 3. automatic pre-apply snapshot (IMP-2); guard freezes it after insert
  insert into equipment_list_revisions (project_id, revision_name, snapshot, created_by, editable)
  values (p_project_id, p_revision_name, p_snapshot, auth.uid(), false);

  -- 4. create-missing (IMP-8), appended after current max sort_order
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

  -- 5. inserts/updates, FK-safe order: categories -> methods -> library
  --    -> box_types -> equipment -> box_details -> name second-passes
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
  -- width/depth/height stay TEXT — that is what preserves "14 1/2".
  -- box_types.dimensions is deliberately not written: measured 0/125
  -- populated, superseded by width/depth/height. Registered for drop.
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

  -- DEV1-R9: equipment inserts carry sort_order from the NEW plan key
  -- 'import_sort_order' (workbook importer only; v1 plans never carry it,
  -- so v1 inserts keep landing at 0 — the 'Import sheet order → sort_order'
  -- roadmap item remains open and untouched).
  -- BOX-ARM (c): 'type' added to the INSERT only. A row does not change
  -- kind on re-import; if it ever must, that is its own ruling.
  insert into equipment_items (id, project_id, category_id, method_id, model, description, group_label,
         quantity, remaining_quantity, public_notes, private_notes, circuit, address, labels_done, drawn, packed,
         sort_order, type)
  select (r->>'id')::uuid, p_project_id, cat.id, m.id,
         coalesce(r->>'model',''), coalesce(r->>'description',''), r->>'group_label',
         coalesce((r->>'quantity')::int,1), (r->>'remaining_quantity')::int,
         r->>'public_notes', r->>'private_notes', r->>'circuit', r->>'address',
         coalesce((r->>'labels_done')::boolean,false), coalesce((r->>'drawn')::boolean,false),
         coalesce((r->>'packed')::boolean,false),
         coalesce((r->>'import_sort_order')::int, 0),
         coalesce(nullif(trim(r->>'type'),''), 'generic')
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
         packed = coalesce((r->>'packed')::boolean,false)
  from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_items,updates}','[]'::jsonb)) r
  left join categories cat on cat.project_id = p_project_id and cat.name = nullif(trim(r->>'category_name'),'')
  left join methods m     on m.project_id  = p_project_id and m.name  = nullif(trim(r->>'method_name'),'')
  where e.id = (r->>'v2_id')::uuid and e.project_id = p_project_id;

  -- BOX-ARM (d): box_details, after the equipment insert so spine rows exist.
  -- box_number takes NO cast — it is text after §A1. That coupling is why
  -- the widening and the RPC land as one migration.
  -- No ops.box_details.deleteIds by design: box_details.id cascades from
  -- equipment_items, so a second delete arm would be a second source of truth.
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

  -- ARCH DIVERGENCE from the package fragment, stated so it is a decision:
  -- the package's UPDATE used a bare left join, which would write NULL over
  -- an existing box_type_id whenever a named type failed to resolve. That
  -- contradicts the package's own doctrine at (e) — an unmatched name must
  -- not erase. Split explicitly: an ABSENT/blank name clears the type
  -- (a real edit); a PRESENT but unresolvable name leaves it alone.
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

  -- BOX-ARM (e): the name second-passes. All three run after every spine
  -- and detail row exists.
  --
  -- ARCH DIVERGENCE, second: the package used `join equipment_items b ...
  -- on b.description = <name>`. A box's name is equipment_items.description
  -- and NOTHING enforces its uniqueness — measured 2026-08-22, one project
  -- already carries two boxes sharing a name. A plain join there resolves a
  -- duplicate name to an arbitrary box, silently. These require EXACTLY ONE
  -- match; ambiguity is treated as non-resolution and leaves the column
  -- untouched, the same outcome the package already ruled for unmatched
  -- names, with the divergence reported client-side.

  -- IMP-BOXCOL: equipment rows carry Box by NAME.
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

  -- nesting: Box in Box carries the PARENT BOX'S NAME
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

  -- 6. deletes, reverse FK order: equipment -> library -> methods -> categories
  delete from equipment_items
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_items,deleteIds}','[]'::jsonb)));
  delete from equipment_library_items
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_library_items,deleteIds}','[]'::jsonb)));
  delete from methods
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,methods,deleteIds}','[]'::jsonb)));
  delete from categories
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,categories,deleteIds}','[]'::jsonb)));

  -- BOX-ARM (f): box_types deletes last, after everything referencing them.
  -- box_type_id is ON DELETE SET NULL, so a deleted type un-types its boxes
  -- rather than deleting them.
  delete from box_types
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid
               from jsonb_array_elements(coalesce(p_plan#>'{ops,box_types,deleteIds}','[]'::jsonb)));

  -- 7. identity map maintenance (equipment-only, per rulings)
  --    NOT extended to 'box_details' here. PORT-COV ruling (1) partitions
  --    identity by detail-table name, but widening this block is a design
  --    change with its own consumers. Leg 1b scopes it. Stated so its
  --    absence is a decision, not an oversight.
  delete from import_identity_map
  where project_id = p_project_id and entity_table = 'equipment_items'
    and v2_id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_items,deleteIds}','[]'::jsonb)));

  insert into import_identity_map (project_id, entity_table, v1_history_id, row_hash,
         assigned_history_id, v2_id, first_run_id, last_seen_run_id)
  select p_project_id, 'equipment_items', (r->>'v1_history_id')::uuid, r->>'row_hash',
         (r->>'assigned_history_id')::uuid, (r->>'v2_id')::uuid, v_run_id, v_run_id
  from jsonb_array_elements(coalesce(p_plan#>'{identity,inserts}','[]'::jsonb)) r;

  update import_identity_map im
     set v1_history_id = (r->>'v1_history_id')::uuid, last_seen_run_id = v_run_id
  from jsonb_array_elements(coalesce(p_plan#>'{identity,upgrades}','[]'::jsonb)) r
  where im.project_id = p_project_id and im.entity_table = 'equipment_items'
    and im.v2_id = (r->>'v2_id')::uuid;

  update import_identity_map
     set last_seen_run_id = v_run_id
  where project_id = p_project_id and entity_table = 'equipment_items'
    and v2_id in (select (value #>> '{}')::uuid from jsonb_array_elements(coalesce(p_plan#>'{identity,matchedV2Ids}','[]'::jsonb)));

  -- 8. finish
  update import_runs set status = 'succeeded', finished_at = now() where id = v_run_id;
  return jsonb_build_object('run_id', v_run_id, 'status', 'succeeded');
end;
$function$;


-- --- §A3 -------------------------------------------------------------
-- Post-change checks, still inside the doomed transaction.
do $verify$
declare
  v_type text;
  v_changed int;
  v_grants text;
  v_report text;
begin
  select data_type into v_type
    from information_schema.columns
   where table_schema='public' and table_name='box_details' and column_name='box_number';

  -- Every surviving string must already BE the shortest representation of
  -- its own value. If re-rendering it changes it, the cast produced
  -- something the app would not have printed.
  select count(*) into v_changed
    from box_details d
   where d.box_number is not null
     and d.box_number is distinct from (d.box_number::numeric)::float8::text;

  select string_agg(distinct privilege_type, ',' order by privilege_type)
    into v_grants
    from information_schema.role_table_grants
   where table_schema='public' and table_name='box_details' and grantee='authenticated';

  v_report := format(
    'box_number type=%s | rows whose stored string is NOT canonical = %s (expect 0) | box_details grants to authenticated = %s',
    v_type, v_changed, coalesce(v_grants,'NONE'));

  raise exception 'REHEARSAL COMPLETE — ROLLED BACK. %', v_report;
end
$verify$;


-- =====================================================================
-- §B — THE REAL APPLY. Identical to §A0 + §A1 + §A2, without §A3.
--      Do not run until §A's report reads clean.
--      Apply as migration name: arch_mig_box_widen_box_number_and_rpc_box_arms
-- =====================================================================


-- =====================================================================
-- §C — POST-APPLY VERIFICATION (run separately, after §B)
-- =====================================================================
-- 1. type is text and no value gained a trailing .0
--      select count(*) from box_details where box_number like '%.0';   -- expect 0
-- 2. the fractional nesting slot survived
--      select box_number from box_details where box_number like '%.%'; -- expect the 8.5-class value
-- 3. grants intact under the shipping identity
--      set local role authenticated;  select count(*) from box_details;  reset role;
-- 4. backward compatibility — replay a v1-mirror plan carrying NO box keys
--    against a scratch project and assert byte-identical results. This is
--    the gate on everything else and it belongs in leg 1b's suite.
-- 5. ledger reads 52, one new entry, no residue from the rehearsal.
