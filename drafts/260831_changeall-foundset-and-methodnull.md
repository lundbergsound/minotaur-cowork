# TWO NEW CHANGE-ALL DEFECTS, found by Daniel's browser gate 2026-08-31

**Both are PRE-EXISTING and neither belongs to EQUIP-LABELS-2.** They were found
while discriminating whether that unit's blank-cell failure was its own; it was
not. Registered here so the close folds them in.

## CHANGEALL-FOUNDSET — Change All fails above some found-set size

**Measured by Daniel, 2026-08-31, on `Cable Parity Fixture`:**

- Labels, blank cell, Change All, found set narrowed to **72 of 1,368** → **PASSES.**
- **Method**, Change All, found set **1,368** → **red flash and revert**, the same
  failure, on a completely different field.
- Private Notes, Change All → reported as "cannot get it to work at all",
  **untested at a narrow found set** — most likely this same defect, not a third
  one. One retry at ≤72 rows settles it.

**So the variable is the found-set SIZE, not the field, and not this unit.**
`runPlainChangeAll` issues `supabase.from('equipment_items').update(dbPatch).in('id', ids)`
as ONE request carrying every id in the found set. Nothing in EQUIP-LABELS-2
touched that call. **The threshold is unmeasured — it is somewhere in (72, 1368]
and should be measured rather than guessed**, along with whether the failure is a
request-size limit, a timeout, or something else. The error is discarded by
`runPlainChangeAll`, which reads only `error` and paints `save-error-flash`; the
actual message and code have never been looked at. **That is the first thing to
capture.**

**Loud, not silent:** the write fails, the optimistic patch is reverted, and the
row flashes. No data is lost.

## CHANGEALL-METHODNULL — an unrecognised Method draft BLANKS the method across the found set

**⚠ SILENT DATA LOSS, on a shipped surface, and it is live in production now.**

**Measured by Daniel:** find Method contains "main", type **`Rent-SAI`** (a method
that does not exist yet) into the Method field, run Change All **without
committing the cell first** → **every row in the found set had its Method set to
blank.** Committing the new method first, then running Change All, works.

**Confirmed at source, and it is an ASYMMETRY between two adjacent fields doing
the same job:**

- **Draft-capture stage** (`EquipmentListClient.tsx:2205-2235`): `category_name`
  runs `resolveDraftOption(...)` and, on no match, returns **the stored row** —
  the draft reverts and never reaches the write. **`method_name` has no such
  branch**; it falls into `isEquipChangeAllField(field)` → `draftText(cap.draft)`,
  so the raw typed text passes straight through.
- **Write stage** (`:2254-2262`): `methods.find(m => m.name.toLowerCase() === …) ?? null`
  → `dbPatch = { method_id: meth?.id ?? null }`. An unmatched name therefore
  writes **`method_id: null`** to every id in the found set, and
  `displayPatch` sets `method_name: null` to match. **The write SUCCEEDS**, so
  there is no error, no flash, and nothing to undo.

**Category is defended against exactly this and Method is not.** It is the same
defect class CC named an hour ago in this unit — *a field that needs a
resolve doctrine sitting in the arm that has none.*

**Method is load-bearing:** it drives the `N/A - Labels Only` print exclusions,
the Cable Checklist's group sections, and the no-box logic. Blanking it across a
found set is not cosmetic.

**⚠ AND CHANGEALL-FOUNDSET IS CURRENTLY MASKING IT.** At 1,368 rows the write
fails, so nothing is blanked. At 72 it succeeds and blanks silently. **Fixing the
found-set defect alone would unmask this one at full-show scale.** They must be
scheduled together, and METHODNULL first.

**Open, not assumed:** whether the right behaviour is revert (category's shape)
or create-the-method (the import's IMP-8 create-missing shape). v1's own
behaviour is the arbiter and has not been measured. Daniel's ruling.

## What this settles about EQUIP-LABELS-2

Its blank-cell-plus-Change-All failure was **CHANGEALL-FOUNDSET**, not its own
defect. AMENDMENT 2's integer branch is correct and necessary on its own terms —
the `{num_labels: null}` 23502 was real and is fixed — and the unit passes at
every found set below the threshold. **It is committable.**
