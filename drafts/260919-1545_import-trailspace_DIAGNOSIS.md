# IMPORT-TRAILSPACE — diagnosis (Arch, main line, 2026-09-19 15:45 ET)

*Read-only. Every database call was a SELECT, plus one proof-run of the fix with a forced rollback (no residue:
the function's md5 is `547d47f9…` before and after). Written while CC ran STECK-EQUIP-LABELS; nothing was written
to the code repo.*

## Root cause

`import_apply_v1` stores a cable's name **as sent**: `r->>'cable_name'`, untrimmed, at the insert (fn line 419)
and the update (447). Every lookup by name then compares that stored column with a **trimmed** key,
`cd.cable_name = nullif(trim(r->>'…'),'')`. So a cable named `Drive B ` (with a trailing space) can never be
found by name.

The client plan trims **both** sides (`cableDataPlan.ts:311`, `:393`, `:448`, `:505`). So the pre-apply dialog
believes every parent resolves, and it warns about nothing.

## What it loses

- **Mult lines (fn 537): DROPPED.** `cable_id` is NOT NULL, so a line whose cable is not found is not inserted.
  This happens silently: the dialog did not count it.
- **Tails (fn 750, 764): kept, with a null parent.**
- The same pattern sits on box names (fn 595–713) and device names (fn 778–837). **Live data has 0 untrimmed box
  names and 1 untrimmed equipment description**, so those arms are latent.

## Measured on JOY

v1 export `JOY/2026-07-12_1610`: 432 named cables, **40 with a trailing space**. Four of the 40 are multicores:

- `Center Cluster Center `
- `Drive B `
- `iAmpland `
- `Prosc SR Sub `

Between them they carry **33 mult lines and 8 tails**.

v2 JOY:

| | v1 | v2 |
|---|---|---|
| Mult lines | 648 | **603** |
| Tails with no parent | — | **13** |

**Lines: 648 − 33 (this defect) − 12 (under `cPreview`, which v1 carries as a line parent with no cable, the
known R-3 case) = 603, exactly.**

**Tails:** 8 of the 13 are this defect. The other 5 are v1's own strays (reparity return §7).

**Affected projects:** JOY and Versioning Test, both test shows. **No cohort show is affected yet.**

## Fix: proof-run, not applied

- **Wrap the stored side in `trim()` at all 16 sites.** The shape becomes
  `trim(cd.cable_name) = nullif(trim(…),'')`, and the same for `e.description` and `b.description`.
- The stored names keep their v1 bytes, so the export round-trip and the row hashes are unchanged.
- There are no indexes on `cable_details.cable_name` or `equipment_items.description`, so no query plan
  changes.
- **Rehearsed** as `CREATE OR REPLACE`: 16 sites before, 16 after. One overload. The ACL is unchanged
  (`authenticated=X`), and so is `search_path=public`. New md5 `cfb2c794…`.
- **Trigger B**, and Daniel's go-ahead.
- **After apply:** re-import JOY from a fresh v1 export. Expect 645 lines (648 − 12 under `cPreview`) and 5
  parentless tails, if the export's counts match July's.

## Not in this fix

- `cPreview` (12 lines under a name with no cable). That is v1's data, and R-3 already warns about it.
- Whether parentless tails share one column on the tail sheets.
- The Sand/Chartreuse end colours.

All three stay on the IMPORT-TRAILSPACE row.
