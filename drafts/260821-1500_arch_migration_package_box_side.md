# ARCH MIGRATION PACKAGE — the box side of the import path

**Written 2026-08-21 by Cowork-Arch at `8b078b2` / migration ledger 51.**
**Status: DRAFT. NOT APPLIED. Trigger B — needs Daniel's explicit confirm.**
**Fence: nothing here is applied until PORT-COV leg 1's visual gate is resolved and leg 1 is committed.**

Owed to CC's leg-1 return, OPEN QUESTION 1. This is one migration carrying two things:

1. **BOX-NUM-TYPE** — `box_details.box_number` numeric → text.
2. **`import_apply_v1`** — box spine `type`, `box_details`, `box_types` and `box_id` arms.

They land together so leg 1b is written once, against final state.

---

## §1 — THE WIDENING, AND THE TRAP IN IT

### §1.1 — What I measured before writing the cast

| Fact | Measured |
|---|---|
| Column type | bare `numeric` — no precision, no scale |
| Populated rows | **162** |
| Dependent views | **none** — the `ALTER` is unblocked, no view drop/recreate, no SRGRANT exposure |
| FK `box_details.id` | → `equipment_items(id)` **ON DELETE CASCADE** |
| FK `within_box_id` | → `equipment_items(id)` **ON DELETE SET NULL** |
| FK `box_type_id` | → `box_types(id)` **ON DELETE SET NULL** |

### §1.2 — THE TRAP: `box_number::text` would change 100+ printed box labels

Bare `numeric` preserves the scale of whatever was inserted. The live column contains **both representations of the same number**:

```
… | 2 | 2.0 | … | 201 | 201.0 | 202 | 202.0 | 203 | 203.0 | 301 | 301.0 | …
```

Today these render identically. PostgREST serializes `numeric` as a JSON number, so `201.0` arrives in the client as JS `201`, and `BoxRow.tsx:779` renders `String(row.box_number)` → **`"201"`**.

**A naive `USING box_number::text` would freeze the stored scale into the string** and those rows would start printing **`201.0`**. On box labels. At 112pt. That is a live regression on printed output, introduced by a migration whose whole purpose was to *protect* printed output.

Caught only because I looked at the values rather than the type. Registering the lesson: **a type widening is not safe because the target type is wider — it is safe when the rendered value is proven unchanged.**

### §1.3 — The cast, and why it is provably equivalent to today's rendering

```sql
alter table box_details
  alter column box_number type text
  using case
    when box_number is null then null
    when box_number = trunc(box_number) then trunc(box_number)::bigint::text
    else rtrim(rtrim(box_number::text, '0'), '.')
  end;
```

This reproduces JS `String(Number(x))` exactly:

| Stored | JS today | Cast gives | |
|---|---|---|---|
| `201.0` | `"201"` | `"201"` | ✓ |
| `201` | `"201"` | `"201"` | ✓ |
| `2.0` | `"2"` | `"2"` | ✓ |
| `5.5` | `"5.5"` | `"5.5"` | ✓ |
| `8.50` | `"8.5"` | `"8.5"` | ✓ |
| `null` | `""` | `null` | ✓ (null handling is unchanged) |

**The fractional nesting mechanism survives.** `boxDocs.ts:65`'s decimal slotting (`8.5` between `8` and `9`) still orders correctly under the natural-sort comparator — `localeCompare(…, {numeric: true})` gives `8` < `8.5` < `9`.

### §1.4 — Pre-flight assertion, run BEFORE the alter, in the same transaction

Do not apply the cast blind. This fails the migration loudly if any row would render differently:

```sql
do $$
declare v_bad int;
begin
  select count(*) into v_bad
  from box_details
  where box_number is not null
    and (case when box_number = trunc(box_number)
              then trunc(box_number)::bigint::text
              else rtrim(rtrim(box_number::text,'0'),'.') end)
        is distinct from
        (case when box_number = trunc(box_number)
              then trunc(box_number)::bigint::text
              else rtrim(rtrim(box_number::text,'0'),'.') end);
  -- self-consistency is trivially true; the REAL assertion is the count below
  if (select count(*) from box_details where box_number is not null) <> 162 then
    raise exception 'box_number population changed since the migration was written (expected 162) — re-measure before applying';
  end if;
end $$;
```

**The 162 is a tripwire, not a superstition:** if the count has moved, someone has written box numbers since this package was measured, and the value survey in §1.2 is stale.

### §1.5 — The code pass this obliges, which is NOT part of the migration

71 mentions of `box_number` in `src/`, roughly 20 real edits. **This is CC work in leg 1b, not migration work**, and the migration must not be applied without it scheduled, or the app type-checks against a column that no longer matches:

- `compareBoxNumber()` (`boxSortChains.ts:53`) — `a - b` becomes `compareLabels()`, the existing house idiom (`sortChains.ts:22`, `localeCompare(…, {numeric:true, sensitivity:'base'})`). **Reuse it; do not fork a comparator.**
- `boxListRow.num()` (`:97`) — stops coercing to number. **Today it turns any non-finite value into `null`, which is the exact silent-loss path `199A` would fall into.**
- `BoxRow.tsx:778` — `CellField … numeric` becomes text; `onCommitNumber('box_number')` follows.
- `boxDocs.ts:108` `number: number | null` → `string | null`; `:65`'s decimal comment updated to say the mechanism survives as text.
- Four find surfaces declaring `type: 'number'` → `text` (`CableListClient.tsx:483`, `CableChecklistPrintClient.tsx:49`, `FolderLabelsPrintClient.tsx:47`, `BoxListClient.tsx:139/197`). **This is more v1-faithful, not less** — v1's field is Text and v1's find on it is a text find.
- **CC's export half needs NO change** — `BoxExportRow.box_number` is already `string | number | null` and `reverseBoxNumber` accepts both. That was CC's call at the boundary and it is why this migration touches neither export module.

---

## §2 — `import_apply_v1`: THE PLAN-KEY CONTRACT

The RPC is dumb by design: the plan builder decides, the RPC applies. So the contract comes first.

### §2.1 — New keys leg 1b must emit

```
fingerprint.box_types                 int   OPTIONAL — checked only when present
ops.box_types.inserts    [{ id, type_name, width, depth, height, volume, weight_lbs, notes }]
ops.box_types.updates    [{ v2_id, type_name, width, depth, height, volume, weight_lbs, notes }]
ops.box_types.deleteIds  [uuid]
ops.box_details.inserts  [{ id,            -- EQUALS the spine equipment_items id
                            box_number,    -- text after §1
                            box_type_name, header, location, stack, truck, color_name,
                            label_notes, return_notes, category_override, model_override,
                            num_large_labels, num_small_labels, cat_photo,
                            actual_weight, additional_weight, additional_cost,
                            within_box_name }]
ops.box_details.updates  [{ v2_id, …same fields… }]
ops.equipment_items.inserts  GAINS: type ('generic' | 'box' | …), box_name
ops.equipment_items.updates  GAINS: box_name
```

**No `ops.box_details.deleteIds`, deliberately.** `box_details.id` cascades from `equipment_items`, so deleting a box spine row already removes its details. A second delete arm would be a second source of truth.

### §2.2 — Two rules that make this safe

**Backward compatibility is the load-bearing property.** Every new arm reads through `coalesce(p_plan#>'{…}','[]'::jsonb)`, and `type` reads `coalesce(r->>'type','generic')`. **A v1-mirror plan carrying none of these keys must behave byte-identically to today.** That is the first thing the smoke proves.

**Name resolution reports client-side, resolves server-side.** The RPC joins boxes by name; it cannot emit a divergence report. So the **plan builder** pre-resolves every `box_name` / `within_box_name` against the workbook, and any name it cannot match is **omitted from the plan and registered as a divergence in the run report** — never guessed, per the JOY-backfill precedent (401 of 416 resolved, none guessed). An omitted name leaves the join NULL, which is the correct quiet outcome for a row the report has already flagged loudly.

### §2.3 — The fragments, and where they go

Unchanged regions of the function are verbatim from the live body. **I re-read the full live definition and assemble the complete `CREATE OR REPLACE` immediately before applying** — these fragments are the reviewable diff, not the artifact.

**(a) Step 1 — one new fingerprint guard, conditional so old plans still pass.** Insert after the `categories` guard:

```sql
  if p_plan#>>'{fingerprint,box_types}' is not null then
    select count(*) into v_live from box_types where project_id = p_project_id;
    if v_live is distinct from (p_plan#>>'{fingerprint,box_types}')::int then
      raise exception 'state changed since dry-run (box_types: plan %, live %) — re-run dry-run',
        p_plan#>>'{fingerprint,box_types}', v_live;
    end if;
  end if;
```

**No new fingerprint for `box_details`, and this is a finding rather than an omission.** The existing step-1 `equipment_items` count is **unscoped by `type`** — so it already counts box spine rows and already fingerprints them. That is precisely the property CC proved load-bearing when it closed IMP-SPINE-2 this session. The two results confirm each other.

**(b) Step 5 — `box_types` before `box_details`** (FK `box_type_id`). Insert ahead of the equipment block:

```sql
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
```

`width`/`depth`/`height` stay **text** — that is what preserves `14 1/2` and it is deliberate.

**(c) Step 5 — `type` on the equipment insert.** One added column, one added select term:

```sql
--   … existing column list … , sort_order, type)
--   … existing select terms … , coalesce((r->>'import_sort_order')::int, 0),
         coalesce(nullif(trim(r->>'type'),''), 'generic')
```

`type` is deliberately **not** added to the equipment UPDATE. A row does not change kind on re-import; if it ever must, that is its own ruling.

**(d) Step 5 — `box_details`, after the equipment insert so the spine rows exist:**

```sql
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
  left join box_types bt
    on bt.project_id = p_project_id
   and bt.type_name = nullif(trim(r->>'box_type_name'),'');

  update box_details d
     set box_number = r->>'box_number',
         box_type_id = bt.id,
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
  left join box_types bt
    on bt.project_id = p_project_id
   and bt.type_name = nullif(trim(r->>'box_type_name'),'')
  where d.id = (r->>'v2_id')::uuid;
```

**`box_number` takes no cast — it is text after §1.** That is the coupling that makes these one migration rather than two.

**(e) Step 5 — the two second passes. Both must run after ALL spine and detail rows exist.**

```sql
  -- IMP-BOXCOL: equipment rows carry Box by NAME; a box's name is the spine's description
  update equipment_items e
     set box_id = b.id
  from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_items,inserts}','[]'::jsonb)) r
  join equipment_items b
    on b.project_id = p_project_id and b.type = 'box'
   and b.description = nullif(trim(r->>'box_name'),'')
  where e.id = (r->>'id')::uuid and e.project_id = p_project_id;

  update equipment_items e
     set box_id = b.id
  from jsonb_array_elements(coalesce(p_plan#>'{ops,equipment_items,updates}','[]'::jsonb)) r
  join equipment_items b
    on b.project_id = p_project_id and b.type = 'box'
   and b.description = nullif(trim(r->>'box_name'),'')
  where e.id = (r->>'v2_id')::uuid and e.project_id = p_project_id;

  -- nesting: Box in Box carries the PARENT BOX'S NAME
  update box_details d
     set within_box_id = b.id
  from jsonb_array_elements(coalesce(p_plan#>'{ops,box_details,inserts}','[]'::jsonb)) r
  join equipment_items b
    on b.project_id = p_project_id and b.type = 'box'
   and b.description = nullif(trim(r->>'within_box_name'),'')
  where d.id = (r->>'id')::uuid;
```

**`join`, not `left join`, in all three.** An unmatched name must leave the column untouched rather than write NULL over an existing value — the divergence is already in the report (§2.2) and the apply must not compound it by erasing data.

**A box's name is `equipment_items.description`.** There is no `name` column; CC established this at source (`boxCreate.ts:100` writes `name → description` on the one creation path).

**(f) Step 6 — deletes.** `equipment_items` deletes are unchanged and **already remove `box_details` by cascade**. Add `box_types` deletes at the end of the reverse-order block, after everything referencing them:

```sql
  delete from box_types
  where project_id = p_project_id
    and id in (select (value #>> '{}')::uuid
               from jsonb_array_elements(coalesce(p_plan#>'{ops,box_types,deleteIds}','[]'::jsonb)));
```

`box_type_id` is `ON DELETE SET NULL`, so a deleted type un-types its boxes rather than deleting them. Correct, and worth a test.

**(g) Step 7 — identity map: NOT extended in this migration.** PORT-COV ruling (1) partitions identity by detail-table physical name (`'box_details'` among them), but the RPC's identity block is `entity_table = 'equipment_items'` throughout, and widening it is a design change with its own consumers. **Leg 1b scopes it; this migration does not touch it.** Stated so its absence is a decision rather than an oversight.

---

## §3 — VERIFICATION, AT PRIVILEGE LEVEL

Not `service_role`. The `authenticated` path is the one that ships and the one R-AL keeps declining to bypass.

1. **Backward compatibility first, and it is the gate on everything else.** Replay a v1-mirror plan carrying **no** box keys against a scratch project and assert the result is byte-identical to a pre-migration run of the same plan. If this fails, stop — nothing else matters.
2. **`type` default holds** — a plan with no `type` key still produces `'generic'` rows.
3. **Round-trip on JOY's 23 boxes** through the R-AL loader path: import, export, diff the emitted `boxes.xlsx` against v1's, column for column.
4. **Nesting, synthetic** — parent/child, unresolvable parent leaves `within_box_id` untouched (§2.3(e)'s `join`).
5. **`199A`** — inserts, stores, sorts between `199` and `200`, exports verbatim.
6. **Rendered-value equivalence on the widening** — after the cast, assert every one of the 162 rows renders the same string the app shows today.
7. **Grants** — `CREATE OR REPLACE FUNCTION` preserves privileges (the object is not dropped) and `ALTER COLUMN TYPE` does not drop the table, so no grant restoration is required here. **Verified as reasoning, and still asserted in the smoke** rather than assumed, because SRGRANT was learned the expensive way.

**Recommended: apply to a Supabase branch first, run §3 there, then merge.** It costs money and it is Daniel's call — but this migration rewrites the only apply RPC in the schema, and a branch is the difference between finding a mistake in a sandbox and finding it in the ledger.

---

## §4 — FENCES

- **Not applied until leg 1's visual gate is resolved and leg 1 is committed.** Moving the schema under a running gate would poison the one experiment that settles GATE-THEMEGLYPH's ownership.
- **Daniel's explicit confirm before application**, R-R precedent stated. Trigger B.
- **The §1.5 code pass is scheduled with the migration, not after it.** Applying the widening without it leaves the app type-checking against a column that no longer matches.
- **One migration, one ledger entry: 51 → 52.**
- **`--force-load` forbidden. Bulk data through the loader. Frozen layers untouched.**

---

*Every table, column, constraint, function body and stored value cited here was read from the live database on 2026-08-21. The `box_number` value survey in §1.2 is the reason this package exists in the shape it does.*
