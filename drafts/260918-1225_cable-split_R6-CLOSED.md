# CABLE-SPLIT R6 — closed by measurement (Arch main line, 2026-09-18 12:25 ET, ledger 77)

R6 asked where the 3 live `split_of_id` rows (measured 2026-08-28) came from, since the import path cannot write that key.

**Measured live today: 0 rows carry `split_of_id`.** The 2026-08-28 three lived on projects since deleted (Ledger: BVSC NY and JOY "are gone"). There is nothing left to trace; R6 closes with no provenance owed.

**Parentless `split_end` rows today: 7, not the 9 of 2026-08-28** — every one written by an import (child `created_at` identical to its batch, one transaction each):
- Buena Vista Social Club US Tour (`57874c69…`, imported 2026-09-06 01:57Z): 3 — `destination` ×2, `daisy_chain` ×1.
- Cable Parity Fixture (`dbf56057…`, imported 2026-08-27 19:20Z): 4 — `destination` ×1, `daisy_chain` ×3.

⚠ For R7's cleanup: 4 of the 7 are on **Cable Parity Fixture**, a parity fixture. Clearing them changes fixture data; check which prints and frames read `split_end` before the statement is written. BVSC US Tour is a real show — Daniel's word before its 3 are cleared.
R7 (the migration) is rehearsed only once CC's BATCH-FRONTDOOR run is back — no rolled-back DDL on `import_apply_v1` while CC is forcing an import failure against the same database.
