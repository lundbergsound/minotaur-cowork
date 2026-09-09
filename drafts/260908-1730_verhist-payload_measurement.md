# VERHIST — the payload, measured per table

*Cowork-Arch main line, 2026-09-08, taken from this seat against the live database while CC runs FIELD-CONTRACT leg 3a. **Read-only: one SELECT, no write, no schema change.** This is the measurement the parallel's §4 deferred ("to be MEASURED in the unit") and the one the leg-2 close named as still open.*

**Subject: `Buena Vista Social Club US Tour` (`57874c69-06b6-41b1-91d8-6a00e5255110`), 2,591 equipment rows — the largest production in the database and therefore the retention worst case.**

## 1 · ⚠ THE INSTRUMENT'S BOUNDARY, STATED FIRST

`pg_column_size()` on an **in-memory** jsonb returns the size of the uncompressed binary jsonb datum. **It is NOT the post-TOAST stored size.** TOAST compression is applied when a value is *stored*, and storing one requires the table this unit has not built yet.

**So this measurement is an UPPER BOUND, not the compressed figure.** The compressed number is still unmeasured and is properly taken inside VERHIST-MIG, after the table exists, as a post-apply verification. *A measurement's boundary is a claim too* — recorded rather than glossed.

## 2 · The payload, per table

| Table | Rows | JSON text (bytes) | Binary jsonb (bytes) |
|---|---:|---:|---:|
| `equipment_items` | 2,591 | 1,885,563 | 1,904,492 |
| `equipment_library_items` | 2,594 | 1,712,688 | 1,654,418 |
| `cable_details` | 1,372 | 1,302,676 | 1,257,813 |
| `cable_mult_lines` | 404 | 299,557 | 293,060 |
| `cable_types` | 74 | 57,137 | 55,984 |
| `tail_details` | 131 | 46,902 | 44,828 |
| `bundles` | 62 | 36,785 | 37,149 |
| `box_types` | 68 | 21,066 | 20,899 |
| `categories` | 30 | 8,528 | 8,932 |
| `methods` | 14 | 5,481 | 5,706 |
| `cover_letters` | 1 | 358 | 388 |
| `link_groups` · `link_group_members` · `circuits` · `cast_members` · `walkie_channels` · `walkie_assignments` · `maintenance_history` · `project_features` | 0 | 0 | 0 |
| **INCLUDED TOTAL** | | **5,376,741** | **5,283,669** |

**Excluded, measured so the exclusion is priced rather than assumed:**

| Table | Rows | JSON text | Binary jsonb |
|---|---:|---:|---:|
| `import_identity_map` | 3,057 | 1,583,434 | 1,601,378 |
| `import_runs` | 5 | 15,198 | 18,640 |
| `equipment_list_revisions` | 7 | 2,777,864 | 3,170,735 |

## 3 · What the numbers change

**3.1 · The 5.3 MB figure is CORROBORATED from a second instrument.** 5,376,741 bytes here against the 5,390,551 measured at the leg-2 close — 0.26% apart, different table sets. **The floor is real and it is ~5.3 MB per snapshot of the largest production.**

**3.2 · ⚠ THE BINARY FORM SAVES NOTHING — ratio 0.983, and FIVE TABLES ARE LARGER AS jsonb THAN AS TEXT.** `equipment_items` goes 1,885,563 → 1,904,492; `bundles`, `categories`, `methods` and `cover_letters` all grow too. **Any retention plan that was quietly counting on the binary encoding to shrink the payload should stop.** Whatever saving exists is TOAST's alone and is still unmeasured (§1).

**3.3 · ⚠ EXCLUDING `import_identity_map` IS NOT "LOW STAKES" — IT IS 1.58 MB, THE SECOND-LARGEST ITEM IN THE DATABASE FOR THIS PROJECT.** The parallel recorded the include/exclude question as low stakes and leaned exclude on use-case grounds. **The lean is right and the stakes are not low: carrying it would put the payload at 6.96 MB, a 29% increase.** Now decided on a number rather than a preference.

**3.4 · ⚠ THE LIBRARY IS 32% OF THE PAYLOAD AND WANTS ITS OWN DECISION.** `equipment_library_items` is 1.71 MB across 2,594 rows — larger than every cable table combined. **It is not obviously snapshot data:** it is the per-project reference catalogue a user picks models from, not the production's own content. Dropping it takes a snapshot from 5.38 MB to 3.66 MB, a 32% saving on every row the table will ever hold. **Against that: a fork with no library is a production whose autocomplete is empty.** Registered as a real question, not resolved here.

**3.5 · ⚠ A LIVE STORAGE FACT NOBODY HAS COSTED, FOUND WHILE MEASURING SOMETHING ELSE.** `equipment_list_revisions` holds **2.78 MB in SEVEN ROWS — roughly 400 KB per revision** — and it is in production now, growing on every revision print, with no thinning and no retention rule. It is correctly OUT of the VERHIST payload (§3.6 of the parallel: different shape, different job). **But VERHIST's retention conversation with the attorney has to cover this table too, because it is already accumulating user data on the same clock.** Named as its own row.

## 4 · What this does to R-V2

Retention was proposed as *hourly kept 48 hours · daily kept 30 days · weekly beyond · manual and gesture snapshots kept until deleted*, against an estimate of 1–2 MB.

At a measured **5.3 MB upper bound** and the parallel's own "eight to ten snapshots on an active editing day": **one active day on this one production is ~42–53 MB before thinning.** The whole database is 34 MB today. **The proposed default is still the right shape — but it is now load-bearing rather than precautionary, and skip-if-unchanged stops being an optimisation and becomes the thing that makes the design viable at all.**

## 5 · Still unmeasured, and properly so

- The post-TOAST stored size (§1) — belongs to VERHIST-MIG's post-apply verification.
- Whether the same ratios hold on `Buena Vista Social Club` Mexico City (`cf780353-448d-4b15-a054-973f577b215c`, 1,024 spine rows, cable and boxes deliberately blank). Not taken: the US Tour is the worst case and retention sizes to the worst case.
