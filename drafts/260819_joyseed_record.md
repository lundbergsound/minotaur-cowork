# JOY seed record — 2026-08-19 (main-line Arch session, Cowork seat)

**What:** the JOY project (`43dd9fde-dafb-403f-b6b1-8d2ba50f506f`) seeded from the v1 export set `~/Minotaur_v1_exports/JOY/2026-07-12_1610`, on Daniel's instruction, REPLACE mode (ruled "a" in-session). Applied from the Arch seat via Supabase MCP, chunked SQL, every insert idempotent (deterministic uuid5 ids, namespace `minotaur-v2/joyseed/2026-08-19`, `ON CONFLICT (id) DO NOTHING`). Generator + per-run report: session files `joyseed/generate.py`, `joyseed/seed.sql`, `joyseed/report.json` (regenerable from the export sheets + this record's namespace).

**Deleted first (enumerated, recorded):** the 31 hand-test rows — 11 cables (paPROSC L/R, bMOOSE, bDRUMS, bHORNS, Drummer *), 10 tails (Gah, Boo, (combo tails)…), 3 boxes (Moose, Tryout, Salmon), 7 bundles (Cable, Nuts, Taco, Mustard, Moose, FOH, Band) — plus 40 old mult lines. IDs in `joyseed/refdata.json`.

**Loaded (final census, verified):** 461 cables · 175 tails · 23 boxes · 26 bundles · 636 mult lines · 61 box types · 3 new cable types (RG6, RG213, XLR6, enriched from def ends/def tails) · 709 generic equipment rows untouched. 173 cables and 166 tails resolve to boxes; 178 cables to bundles; 91 mults.

**Mapping law:** PORT-COV sheet digest (260814-1909) — stored twins only (`* Manually Added`/`* Manual`), derived columns ignored; ruling 4 family. Colors normalized to the `cable_color` domain (lowercase closed set) on cable color, bundle end colors, mult-line color.

**Known gaps, deliberate:** v1 cable/line panel-label text has no v2 column (196 values dropped — WIRE-TYPE gap family) · 5 tails + 12 lines reference parents absent from the export (`cPreview`, `cALD #1`, `Cat SL Sub 3`) — tails loaded orphaned, lines skipped · no HistoryID→v2 identity-map provenance rows were written (these are v2-native rows; a future real import will not match them by identity) · JOY has zero nested boxes and zero splits in the export — nest one in-app to exercise the Inside: annotations · `_Create/_Modify` audit stamps not carried (rows carry seed-time timestamps).

**Two seed-time defects found and fixed in-session:** capitalized colors vs the lowercase domain (three sites) · 5 no-HistoryID tail rows collapsing to one deterministic id (re-keyed by row index; final tails 175 exact).
