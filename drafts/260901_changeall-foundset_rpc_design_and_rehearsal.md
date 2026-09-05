# CHANGEALL-FOUNDSET — the RPC route: design, surface, and rehearsal

**Written 2026-09-01 from the Arch seat. Route B RULED by Daniel 2026-09-01: send the ids inside the request body. This document is the migration's design, the measured surface it is built against, and the rehearsal that proves it — all of it run before any apply. Migration ledger stands at 56; nothing here has been applied.**

---

## 1 · The surface, re-swept 2026-09-01 — the scope is LARGER than the opener recorded

`BundleListClient.tsx` was unswept because grep called it binary. It is valid UTF-8 with **exactly one NUL byte**, at line 1265, inside a React key: `` `g-${band.label || '<NUL>blank'}` `` — a typo where `'blank'` was meant. That one byte hid six call sites. **Registered as GREP-NULBYTE.** *A search run with the wrong instrument returns absence.*

Full sweep, read with python rather than grep. **36 live call sites, four classes:**

**Class 1 — batched `.in('id', ids)` on UPDATE (the Change All shape) — 18 sites**
`EquipmentListClient:1831 · 2128` · `CableListClient:875 · 891 · 914 · 939 · 1911 · 1913 · 3035 · 3339 · 3544` · `BundleListClient:830` · `LineListClient:1119` · `TailListClient:790` · `EquipmentLibraryClient:322` · `BoxListClient:879 · 889 · 915 · 1269`

**Class 2 — `.in()` on DELETE — 9 sites, not 5**
`TailListClient:670` · `CableListClient:2679 · 2880 · 3007 · 3043` · `BundleListClient:724 · 967 · 999` · `BoxListClient:1089`
New beyond the recorded five: `CableListClient:2679` (`link_groups`, the failed-enrollment compensation) and `BundleListClient:724 · 967 · 999`.

**Class 3 — `.in()` on SELECT — 7 sites, never counted before**
`EquipmentListClient:2037 · 2156` · `CableListClient:920 · 2878 · 2884` · `BundleListClient:965 · 971`

**⚠ Two of these are select-then-delete pairs with the select's error unchecked:**
`CableListClient:2878 → 2880` and `BundleListClient:965 → 967`. Above the ceiling the select is rejected, `data ?? []` yields an empty list, `if (ids.length)` is false, **the delete silently does not run, and the rows it was meant to remove are orphaned.** No error, no red flash, nothing on screen. This is the worst failure in the unit and it was invisible to the earlier scope.

**Class 4 — raw `.or()` filter strings carrying the id list TWICE — 2 sites**
`CableListClient:2888-2890` and `BundleListClient:975-977`, both `source_patch_line_id.in.(${idList}),destination_patch_line_id.in.(${idList})`.
**These hit the ceiling at roughly HALF the row count of every other site**, because the same list is spent twice in one URL.

## 2 · What the database says — introspected live, not remembered

- All ten tables in scope carry **RLS enabled**, and every write policy carries a **`WITH CHECK`** on project ownership. A caller cannot move a row into a project they do not own; the database refuses it, not the client.
- **`link_group_members` HAS NO `id` COLUMN.** It is keyed `(link_id, item_id)`. An id-keyed function can never serve it — it needs its own arm. *This must not be discovered mid-build.*
- **House RPC doctrine, read at source and copied rather than invented:** every product function in this database — `import_apply_v1`, `merge_methods`, `export_mint_identity` — is **SECURITY INVOKER** with `search_path = public`, granted to `authenticated` only. Only auth/seed triggers are DEFINER. The functions below follow that doctrine exactly.

**Why SECURITY INVOKER is the whole security argument:** the function runs as the caller, so RLS applies unchanged. It removes a size ceiling; it grants no new reach. Proven below at T7 and D5, not asserted.

## 3 · The four functions

Not one. Four, because there are four distinct key shapes, and one of them has no `id` at all.

| Function | Serves | Key |
|---|---|---|
| `bulk_update_v1(p_table, p_ids, p_patch)` | Class 1, all 18 update sites | `id = any(ids)` |
| `bulk_delete_v1(p_table, p_ids)` | Class 2, 7 of the 9 deletes | `id = any(ids)` |
| `delete_tails_of_cables_v1(p_cable_ids)` | the two select-then-delete pairs | read + delete in ONE statement |
| `unlink_group_members_v1(p_link_id, p_item_ids)` | `CableListClient:1280` · `BundleListClient:999` | `(link_id, item_id)` |

**`delete_tails_of_cables_v1` is the one that earns its keep beyond the ceiling.** It folds the read and the delete into a single statement, so there is no intermediate id list to truncate and no unchecked error between them. The failure mode at Class 3 above becomes unrepresentable rather than handled.

**Guards, enforced in SQL:**
- table must be on an explicit allowlist (update: 8 tables; delete: 4) — anything else raises `42501`
- `id`, `project_id`, `owner_id`, `created_at`, `updated_at` are never patchable — raises `42501`
- every patch key must exist on the table — raises `42703`
- empty id array returns `0` and writes nothing, no error
- every identifier passes through `format('%I')` **after** validation against `information_schema`; values go through `jsonb_populate_record`, which casts to the column's real type. No caller string ever reaches SQL unquoted.

**Each function returns the row count it actually wrote.** Today a Change All that matches fewer rows than it asked for is invisible. This makes that difference readable for the first time — and it is the same registry FIELD-CONTRACT will want, so the two units share one list rather than growing two.

### The SQL, as rehearsed

```sql
create or replace function public.bulk_update_v1(p_table text, p_ids uuid[], p_patch jsonb)
returns integer language plpgsql security invoker set search_path = public as $body$
declare
  v_tables constant text[] := array['equipment_items','cable_details','cable_mult_lines','tail_details',
                                    'bundles','box_details','link_groups','equipment_library_items'];
  v_blocked constant text[] := array['id','project_id','owner_id','created_at','updated_at'];
  v_key text; v_sets text := ''; v_n int;
begin
  if p_table is null or not (p_table = any(v_tables)) then
    raise exception 'bulk_update_v1: table % is not writable here', p_table using errcode='42501';
  end if;
  if p_ids is null or coalesce(array_length(p_ids,1),0) = 0 then return 0; end if;
  if p_patch is null or jsonb_typeof(p_patch) <> 'object' or p_patch = '{}'::jsonb then
    raise exception 'bulk_update_v1: patch must be a non-empty object' using errcode='22023';
  end if;
  for v_key in select k from jsonb_object_keys(p_patch) k loop
    if v_key = any(v_blocked) then
      raise exception 'bulk_update_v1: column % is not writable here', v_key using errcode='42501';
    end if;
    if not exists (select 1 from information_schema.columns c
                   where c.table_schema='public' and c.table_name=p_table and c.column_name=v_key) then
      raise exception 'bulk_update_v1: % has no column %', p_table, v_key using errcode='42703';
    end if;
    v_sets := v_sets || case when v_sets='' then '' else ', ' end || format('%I = p.%I', v_key, v_key);
  end loop;
  execute format('update public.%I t set %s from jsonb_populate_record(null::public.%I, $2) p
                  where t.id = any($1)', p_table, v_sets, p_table) using p_ids, p_patch;
  get diagnostics v_n = row_count;
  return v_n;
end $body$;

create or replace function public.bulk_delete_v1(p_table text, p_ids uuid[])
returns integer language plpgsql security invoker set search_path = public as $body$
declare
  v_tables constant text[] := array['equipment_items','cable_details','bundles','link_groups'];
  v_n int;
begin
  if p_table is null or not (p_table = any(v_tables)) then
    raise exception 'bulk_delete_v1: table % is not deletable here', p_table using errcode='42501';
  end if;
  if p_ids is null or coalesce(array_length(p_ids,1),0) = 0 then return 0; end if;
  execute format('delete from public.%I where id = any($1)', p_table) using p_ids;
  get diagnostics v_n = row_count;
  return v_n;
end $body$;

create or replace function public.delete_tails_of_cables_v1(p_cable_ids uuid[])
returns integer language plpgsql security invoker set search_path = public as $body$
declare v_n int;
begin
  if p_cable_ids is null or coalesce(array_length(p_cable_ids,1),0) = 0 then return 0; end if;
  delete from equipment_items
   where id in (select t.id from tail_details t where t.parent_cable_id = any(p_cable_ids));
  get diagnostics v_n = row_count;
  return v_n;
end $body$;

create or replace function public.unlink_group_members_v1(p_link_id uuid, p_item_ids uuid[])
returns integer language plpgsql security invoker set search_path = public as $body$
declare v_n int;
begin
  if p_link_id is null or p_item_ids is null or coalesce(array_length(p_item_ids,1),0) = 0 then return 0; end if;
  delete from link_group_members where link_id = p_link_id and item_id = any(p_item_ids);
  get diagnostics v_n = row_count;
  return v_n;
end $body$;

revoke execute on function public.bulk_update_v1(text, uuid[], jsonb) from public, anon;
revoke execute on function public.bulk_delete_v1(text, uuid[]) from public, anon;
revoke execute on function public.delete_tails_of_cables_v1(uuid[]) from public, anon;
revoke execute on function public.unlink_group_members_v1(uuid, uuid[]) from public, anon;
grant execute on function public.bulk_update_v1(text, uuid[], jsonb) to authenticated;
grant execute on function public.bulk_delete_v1(text, uuid[]) to authenticated;
grant execute on function public.delete_tails_of_cables_v1(uuid[]) to authenticated;
grant execute on function public.unlink_group_members_v1(uuid, uuid[]) to authenticated;
```

## 4 · The rehearsal — run 2026-09-01, as `authenticated`, inside a forced rollback

**Update family**

```
T0 create:           OK (security invoker, search_path=public)
T0 corpus:           1368 generic rows in Cable Parity Fixture
T0 role:             authenticated  auth.uid()=82695c57-306a-4d87-9cf7-f34b65cbb250
T1 bad table:        BLOCKED 42501
T2 project_id:       BLOCKED 42501
T3 unknown column:   BLOCKED 42703
T4 empty ids:        returns 0 (no error)
T5 real update:      1368 rows in 117.0 ms  (one statement, one transaction)
T5 verify written:   1368 rows read back
T6 explicit null:    1368 rows set to NULL (JSON null -> SQL NULL)
T7 RLS as non-owner: 0 rows written (0 = RLS still in force)
```

**Delete family**

```
D0 create x3:        OK (all security invoker, search_path=public)
D0 corpus:           40 parent cables, 79 tail rows beneath them
D0 corpus:           link group 002648a0-... with 2 members
D1 delete projects:  BLOCKED 42501
D2 lgm by id:        BLOCKED 42501 (correct - no id column)
D3 tails of cables:  79 spine rows deleted in 259.9 ms (expected 79) - read+write ONE statement
D3 cascade check:    0 tail_details rows remain (0 = cascade held)
D4 unlink members:   2 removed (expected 2)
D5 RLS as non-owner: 0 rows deleted (0 = RLS still in force)
```

**Residue checks, both runs: CLEAN.** 0 leftover functions · 0 sentinel rows · fixture back to 2,811 equipment rows, 190 tail rows, the test group's 2 members restored · **migration ledger still 56.**

**⚠ The rollback has a positive control, not just an absence check.** After T6 set all 1,368 `group_label` values to NULL, the post-rollback read finds **1,009 of 1,368 null and 359 carrying real values** — the pre-rehearsal distribution. Had the rollback failed, all 1,368 would read null. *A control that only checks for absence cannot tell "rolled back" from "never ran."*

## 5 · Timing — and a number of mine that a better instrument revised

**⚠ The rehearsal's 117.0 ms was a cold reading and I reported it as the cost. It is not.** That transaction created the four functions and called one of them in the same breath, so it paid for plan compilation. The **installed** function, called on the same 1,368 rows, runs in **57.4 ms** — against **62.6 ms** for the bare UPDATE measured on 2026-08-31. The guards are free at this scale; there is no ~54 ms tax and I should not have written one before measuring the artifact.

*The source states intent; the artifact states behaviour. A rehearsal that builds and runs in one transaction is not measuring what ships.*

`delete_tails_of_cables_v1` at 259.9 ms for 79 spine rows is dominated by cascade work across `tail_details` and the link tables, not by the id list.

## 6 · What this does NOT do — and who owns the rest

**The migration removes the ceiling for the 27 WRITE sites. It does nothing for the 7 reads or the 2 raw-filter sites.** Those are CC's, after the apply:

- Reads have no atomicity requirement, so **chunking is correct for them** — a read split into two batches and concatenated gives the same answer. They need a shared chunked helper **and their errors checked**, which today they are not.
- The two `.or()` sites need the same helper with their doubled id list accounted for.
- Every write site moves to the RPC **through one shared helper, not 27 local patches** — a fix landing only in `runPlainChangeAll` fixes one of them.

**⚠ Two things that must not be discovered mid-build, carried forward:** `updateItem` is in the FROZEN gate (`EquipmentListClient.tsx` vs `be0769de`) — **frozen-layer contact is a CC hard-stop.** And several of these surfaces are captured gate frames, so a UX-visible change is a **declared baseline event: CC measures which frames move; Arch does not predict.**

## 7 · Status — APPLIED

**Applied to main 2026-09-01 on Daniel's explicit confirm. Migration ledger 56 → 57**, `changeall_foundset_bulk_write_rpcs`. Additive only: no table, column, policy or existing function was touched, and no application code calls these yet.

**Post-apply verification, on the installed objects rather than on the source:**

```
ledger now:          57
all four present:    4/4
security_definer:    false on all four  (SECURITY INVOKER, as intended)
config:              search_path=public on all four
anon EXECUTE:        false on all four
authenticated EXEC:  true  on all four
```

**Live smoke as `authenticated`, forced rollback:**

```
guard bad table:     BLOCKED 42501
guard project_id:    BLOCKED 42501
installed update:    1368 rows in 57.4 ms
empty-array delete:  returns 0, writes nothing
RLS as non-owner:    0 rows (0 = in force)
```

**Residue after the smoke: CLEAN.** 0 sentinel rows · fixture back to 2,811 equipment rows and 190 tail rows · the 1,009/1,368 `group_label` distribution intact, which is the positive control on the rollback · four functions installed, ledger 57.

**Next, and it is CC's:** rewire the 27 write sites onto these four through ONE shared helper, chunk-and-error-check the 7 reads and 2 raw-filter sites, and carry `CLAUDE.md`'s run fence in the same pass (FENCE-COUNTS). Frozen-layer contact on `updateItem` is a hard-stop; several surfaces are captured gate frames, so a UX-visible change is a declared baseline event that CC measures and Arch does not predict.
