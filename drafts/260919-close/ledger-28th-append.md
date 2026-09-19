
## Twenty-eighth append — 2026-09-18 (evening) to 2026-09-19, Arch (Cowork main line, Architecture Prompt v39)

**Three production deploys: `4fe0af9` PAPERWORK-1 · `afd4e03` METHOD-SORT-BLANK · `6a8f3d4` REVPAIR-TAILSORT, each on Daniel's JOY gate and phrase. Migrations 79 and 80 applied. Ledger 78 → 80.** Returns: `from-cc/260918-1748_paperwork-1.md` (with ADDENDUM and ADDENDUM-2), `260919-1146_method-sort-blank.md`, `260919-1320_revpair-tailsort.md`, and their `_CLOSE.txt`. Parallels: `handoffs/parallel/260919-1105_revlist-regression_RETURN.md`, `260919-1124_print-reparity_RETURN.md`.

### PAPERWORK-1 `4fe0af9` (26 files)

- **EQUIPLIST-DOTRULE:** one solid `#DEDEDE` rule per row. It is 1 px, the nearest paintable weight to v1's 1.00 pt (EQUIPLIST-RULE-QUANTUM, −0.25 pt), spanning 25.50 → 586.50 against v1's 25.27 → 586.27. Drawing objects on a 7-page list went from **58,077 to 201**, with pitch and pagination unchanged.
- **PRINT-HINT-EQUIP:** Daniel's full text.
- **EQUIPSORT-NODESC-PRINT:** a blank description sorts FIRST in both branches (`compareDescriptions`). The evidence is v1 `260829-1804_v1_equipment-labels_BVSCNY_blank-find_sort-description.pdf` p.1, where column-1 slots 1–2 are empty.
- **EQUIPLIST-NAMEWRAP:** the page budget reads the rendered name's line count. The wrap case went from 107 against 83 to exact.
- **The detailed layout lost a row per page:** a colourless method chip's 0.5 px border added 2 px (22.3281 against `DETAIL_ROW_H` 20.3281). The border is now bled into the row, it is pixel-identical, and the constant is unchanged.
- **The Current column:** `REV_CURRENT_COL_W = 61` px, measured in the wider face. An A/B against the live site proved the `Curren` clip **predated** this unit.
- **SETTINGS-PAPERWORK-PREVIEW:** built with the print's own `PageHeader`.
- **Bundle Summary and Line List** use v1's own page chrome per document (`v1DocChrome.tsx`). The full comparison puts every object within 0.5 pt except the title underline, which is one pixel low. Every mark box is unclipped (70 and 36 boxes). The Line List mult-name colour chip is built, and lines follow v1's `GetAsNumber` order (`AC, 1, 2`).
- **Gate:** Daniel's first gate FAILED on two items: *"the "current" cut off is an odd regression … bundle summary print preview is cut off"*. The re-gate passed on JOY.
- **METHOD-SORT-ORDER** was found to hold at the engine. The data held v1 blanks as 0.

### METHOD-SORT-BLANK — 79 · `afd4e03` · 80

- **Finding.** v1's user field is `Sort Override Manual`, which is blank on every method v2 held at 0, across all seven exports. `Sort Override` is v1's calculation, empty→0 (the DDR: `If ( Manual ≠ "" ; Manual ; "zzzz" )`, so v1 sorts a blank LAST), and `map.ts:679` imported the calculation.
- **79** (`20260919144200`, on "go ahead"): the column is nullable, the default was kept for now, and `import_apply_v1` stops coalescing (insert, and update when the key is present). The RPC went from `42808553…` to **`86af03b7…`** (= rehearsal). The file of record was re-derived from the executed statement: **`e3537ca2…`**.
- **The CC pass `afd4e03`:** one comparator, `compareMethodSortOrder`. The import reads Manual, the export writes v1's shape, and the real RPC was proven on insert, update and clear. 3,520 / 188.
- **80** (`20260919162802`, on "apply METHOD-SORT-BLANK 80"): **21** import-created, never-edited zeros were set blank (rehearsed at 22; the data moved in between: the JOY '0' method was gone, Deborah Silver & Fabulous Friends was imported, and five JOY `Rent-Main-Masque*` methods were set to 0 during Daniel's gate, so those count as edited and were excluded). Visual Gate Fixture was excluded. The default was dropped, and createMissing methods now insert blank. The RPC went to **`0df630bd…`** (= rehearsal). Statement md5 **`ce10d42d…`**, which equals the file.
- ⚠ **Five JOY methods now sit at 0 from the gate.** Daniel was told.

### REVPAIR-TAILSORT `6a8f3d4` (21 files)

- **REVPAIR-CROSS-SORT.** A by-category revision printed by method keyed `(No Method)|header` against `Main List|header`: 0 of 17 old sections matched 29 current ones. **Present since `bb66bb3`, 2026-07-12.** Measured identical at `7c96904` and `4fe0af9`, so a rollback was not warranted. The fix is a read-side re-bucket by each old item's method group. JOY `16ebe6f9`, `rent`: From **0 → 291**, orphans **17 → 0**, and the 35 in-section deletions are identical to the by-category print's. The gate print is **20 pp** against v1's 19 (it ends at 13.1 Tails with no orphans); the difference is pagination and rides EQUIP-PARITY-2.
- **The print-settings seed was Zite-shaped:** `sort: by_category`, `dateFormat: M/D/YYYY h:mmp`. It is now normalised on read. The settings write keeps foreign keys, so the `cablePrint` settings survive. The mount-skip was broken by React's dev double-mount (MOUNT-SKIP-BY-OBJECT). The column default itself is still Zite-shaped and rides STECK-EQUIP-LABELS' migration.
- **TAILSORT.** `byParentThenEnd` re-sorted every run after the model sort. JOY Small Tail Block went from **14 to 3** pages and Tail Line by model from **40 to 30** (27 without the 13 parentless tails). The include-blocks choice moved to Tail Line (frame 040 is v1's screen). Tail Panel is byte-identical.
- **CP4.** `compareMethodOrder` orders numbered methods, then (No Method), then blanks A–Z, at every site. (No Method) on the screen bands moved from 999 (before N/A) to after N/A, which is Arch's reading of *"no method should go ahead of them"*.
- Gate **"gates 1-4 pass"**. 3,579 / 192.

### The lost unit — how PRINT-PARITY fell off (Daniel asked)

| Version | Date | What happened |
|---|---|---|
| v4.5 | 23 Aug | PRINT-PARITY entered |
| v4.8 | 26 Aug | Unit 1 (box labels) closed `8c6b2e0`, 51.35 → 0.63 pt; the cable rounds closed on 30 Aug |
| v4.19–v4.27 | 6–10 Sep | **Unit 2 (the box residuals)** sat STAGED, UNISSUED in the Sprint Plan's PINNED queue |
| **v4.28** | **11 Sep** | The readability rewrite deleted the Sprint Plan as history and checked only **Docket** rows byte-identical. Unit 2 vanished, and **MMM-CAT** (ruled, never built, hit live 2026-09-08) vanished with it. The six v1 sections found on 2026-09-18 were lost in the same edit |
| v4.28–v4.42 | | One trailing bullet, "PRINT-PARITY's remaining", named a unit that no longer existed. BOX-DOC-PARITY's trigger ("after cable parity") had already fired on 30 Aug |
| v4.43 | 17 Sep | The bullet went |
| v4.45 | 18 Sep | The last mentions (Tail Panel reprint, OQ-B, BOX-REPRINT) went |

**Guard adopted for every Roadmap rewrite:** census every unit ID in the retired version against the new one. Each must be present, closed in the Ledger, or retired by a quoted ruling. v4.47 was censused this way: 120 IDs, 0 missing. The guard lives in the opener's traps, **not** as a new prompt rule, and it replaces the narrower Brief-section census.

### The parallels

- **REVLIST** (above) also delivered the equipment list's approved parity list (EQUIP-PARITY-2, nine items, plus BOX-ROW-TYPE).
- **PRINT-REPARITY cable round.** 26 PDFs were filed at `~/Minotaur_v1_exports/parity-pairs/260919_print-reparity/`.
  - **Passes:** Tail Panel, the Tail Line and Small Tail Block cells, the Line List, and Bundle Summary's x positions.
  - ❌ **Small Cable Labels** sit +12.07 pt low, and 60 of 504 chips are off phase in the grouped sort.
  - ❌ **Cable Checklist, Tail Checklist and Bundle Sheet** have never been compared: chrome is 8–33 pt off, tick boxes are 8.25 against 12, and the Bundle Sheet's "Flagged:" sits over the wrong column.
  - **The project logo** is absent from every cable document.
  - **Import:** 40 JOY cable names end in a space and 13 tails have no cable.
  - **Rulings R1–R4** are verbatim in the return §0.

### Rulings of record, Daniel, 2026-09-18/19

- "go" (PAPERWORK-1).
- Both gates, verbatim above.
- *"BVSC is a live show, so we should test using test shows"* (standing: TEST-SHOWS-ONLY).
- *"blank should sort after anything with a value. 0 should sort before 1"*.
- "go ahead" (79) · "apply METHOD-SORT-BLANK 80".
- *"two blank methods should order between themselves alphabetically. no method should go ahead of them"*.
- *"OK, revision fix and parity measures approved"*.
- R1–R4.
- "bundle them".
- Steck and Equipment labels move ahead of the 5167 check: *"so that I can do one 5167 check on steck labels, equipment labels, tail line labels, and cable labels"*.
- Ride-along: *"equipment radio buttons follow project color, but cable radio buttons do not"*.

### Arch errors — five

1. Told Daniel to gate on Buena Vista Social Club, a live show.
2. The first handoff carried `Tier: 3`; the contract names the model.
3. Migration 79's file was first written with comment lines that never executed. It was corrected to the executed statement, `e3537ca2…`.
4. The bundle carried the parallel's two wrong citations: `readPrintDateFormat` at `:69` (it is `:128`), and frame 040 as v2's screen (it is v1's).
5. Predicted 19 pages for the revised print; it prints 20.
