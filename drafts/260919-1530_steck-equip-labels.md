# STECK-EQUIP-LABELS: Steck Labels and Equipment Labels, each with its v1 find screen

Tier: claude-opus-5
Model: claude-opus-5
Session: FRESH

*Arch, main line, 2026-09-19. Code is at `fa050c2`, which is `origin/main` (PRINT-REPARITY-LABELS, shipped).
The migration ledger is **81**. Read HEAD and origin from the ref files, and read the ledger live (expect 81).*

**Migration 81 is applied.** It is `20260919190044_v_equipment_list_address_and_print_settings_default`,
and it did two things:

- **`v_equipment_list` now carries `address`,** appended as its last column. Its grants and
  `security_invoker` are unchanged.
- `projects.print_list_settings` now defaults to `'{}'::jsonb`. Every reader already normalises an
  empty object.

**Its file of record is in `supabase/migrations/`, untracked, and rides this commit.** It is md5
`146a3b9a…`, read back from the ledger. Do not edit it.

**⚠ Every answer you need is in this file. There is no blank for anyone to fill in.**

## §0 · HARD STOPS

1. **No migrations and no SQL writes.** Regenerate the types with `npm run db:types`, so that `address`
   appears on `v_equipment_list`.
2. **The column x origins stay on each die** (STOCK-IS-DIE, Daniel 2026-08-31). Both new sheets print on
   **Avery 5167**, 4 × 20, through `AVERY_5167` and the `TailDieCells` stamping used by Small Cable
   Labels. v1's ink is compared **inside the cell**.
3. **Test shows only**: JOY `b04ab9b5…` and the other `daniel+test01@` projects, or seeded throwaways.
   **Never Buena Vista Social Club.**
4. **Visual gate.** Only **frame 01** (light and dark) may move, because two Menu cards turn on. Declare it
   as this unit's one baseline event. **If any other frame moves, stop.**
5. Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the handoff file's
   RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or
   describe it. Show every line."*
6. GATE-NOGREP. Commit only on Daniel's `COMMIT APPROVED: <first words>`, after his gate.

## §1 · Rulings of record

- **LAYOUT-FINDSCREEN, Daniel 2026-09-18.** All six are quoted in
  `drafts/260918-1240_paperwork-findscreen_RULED.md`. Three bind here:
  - no skip hint line: *"I don't recongize this from v1, so no."*;
  - skip appears only where v1 has it: *"yes, skip only appears where it does in v1."*, which means
    **By Cable** on Steck and **By Description** on Equipment Labels;
  - **Max # Label Sets is dropped**: *"drop"*.
- **Proposals (c3), (c4), (c6) and (c7) stand**, because Daniel did not strike them. They are in
  `handoffs/parallel/260918-1224_paperwork-findscreen_DESIGN.md` §4–5:
  - Steck's unlabelled Source/Destination field is labelled **"End"**;
  - Exact Matches is the **"is exactly" operator**, not a checkbox;
  - Cancel closes the skip box and prints nothing;
  - the skip input reads *"Number of labels to skip:"*.
- **Equipment Labels' count, RULED (Daniel, 2026-08-28):** *equipment labels replicate v1's function
  exactly; v2 stores the real per-item count.* That is `num_labels`, built in EQUIP-LABELS-2. An item
  prints `num_labels` stickers, and an item with 0 or blank prints none.
- **Priority:** Daniel, 2026-09-19, moved these two ahead of the 5167 stock check, *"so that I can do
  one 5167 check on steck labels, equipment labels, tail line labels, and cable labels"*.
- **New today, and it rides this unit (CP3):** Daniel, 2026-09-19, on the Small Cable Labels grouped
  sort: **"first"**. `Not Grouped` prints first, as v1 prints it.

## §2 · CP1: Steck Labels (pedigree (b); design `handoffs/parallel/260828-1430_remaining-layouts-design.md` §3.3)

**What it is.** Patch-panel stickers. Each carries the device, the cable or line name, the model, and
`@ <panel>`.

**The found set** (v1 scripts 397 → 396 → 394, read at source in the design):

1. Take four row sets: every cable's source end, every cable's destination end, every mult line's
   source end, and every mult line's destination end.
2. The count is `source_steck_count` / `destination_steck_count` on cables and on lines. A row whose
   count is blank or below 1 is **dropped**; every other row is **repeated to its count**. The count is
   both the filter and the multiplier.
3. **Check the arithmetic on JOY before building:**
   - sum the four counts by SELECT;
   - count the `@` tokens in `260919-1058_v1_steck-labels_JOY_FILEMAKER.pdf` (19 pages, in
     `~/Minotaur_v1_exports/parity-pairs/260919_print-reparity/`);
   - report both numbers. The design's control is `cable-box/Cable PDFs/Steck Labels.pdf`: **342 `@`
     = 191 + 108 + 13 + 30**.
   - A gap is reported and not chased. The import's trailing-space defect (IMPORT-TRAILSPACE) is known.

**The find screen**, from design §4 row 3:

- **Options:**
  - Sort: **By Device, then by Cable** (the default) · By Group, then by Cable · By Cable;
  - Model before name, the shared project setting (R-37);
  - v1's Recommendations text.
- **Find fields, in v1's order:** Cable · Device (Rack) · Group · Model · Bundle · Method · Category ·
  **End** · Print List.
- **Grammar:** use `WhichXFindBlock`, with the "is exactly" operator.
- **Legend:** *"Which Cables? (Leaving this blank will show all …)"*, verbatim from v1 layout 263.
- **Skip:** only on By Cable, through `SkipLabelsDialog`, the shipped pattern.
- **A blank find prints everything.**

**The sticker and the sheet.** Measure them from the v1 JOY Steck file before building (Surface Rule):

- every text object's position inside the cell;
- font and size;
- any shrink-to-fit behaviour;
- grouped-sort headings and breaks;
- **the fill order, which nobody has measured yet.** The design says only "not determined". Report
  what you find.

Carry v1's rules as named constants, as `smallCableLabels.ts` does. Any v1 rule you build beyond this
list is pedigree (b): list it in OPEN QUESTIONS with its page, as you did last unit.

**Menu:** enable **Steck Labels** (`MenuPageLoader.tsx:214`) at `cable/print-steck-labels`.

## §3 · CP2: Equipment Labels (pedigree (b) and the 2026-08-28 ruling; design §4.3–4.3.1)

**The found set:** equipment items with `num_labels ≥ 1`, each repeated `num_labels` times. Keep the
repeats **consecutive**, as v1's iterate script builds them.

- Apply the same equipment-only filter as the design's §4.1 (`type = 'generic'`). If the view or the
  surface says otherwise at HEAD, report it.
- **Control on JOY:** the design computed **36 items, Σ 36**. Re-count by SELECT and report it.

**The two sorts print two different labels.** This is measured in design §4.3.0:

| Sort | Label carries | v1 evidence |
|---|---|---|
| **By Group, then by Model, then by Description** (default) | group header *"Equipment Labels / <Group>"* · Description · **Model** · Address | `260919-1251_v1_equipment-labels-by-group_JOY_FILEMAKER.pdf`; `equipment/260829-1804_v1_equipment-labels_BVSCNY_blank-find_sort-group-model-description.pdf` |
| **By Description** | Description · Address | `equipment/260829-1804_v1_equipment-labels_BVSCNY_blank-find_sort-description.pdf` (the clean grid: 4 × 20, 36 pt pitch, fills **down columns**) |

- **The description shrinks to fit:** 14 pt on some labels, 10 pt on longer ones, in the same column.
  Characterise the rule from the prints; don't assume it.
- **Address is 8 pt** and now comes from `v_equipment_list.address`.
- The By-Group sheet's cell count is not reliable, because the extra Model line spills the row bin.
  Measure it by label, not by grid.
- **The find screen**, from design §4 row 4:
  - Options: Sort only (Max # Label Sets is dropped);
  - find fields: **Description · Group · Category · Model**;
  - grammar: `WhichXFindBlock` with "is exactly";
  - legend: *"What Equipment Labels? (Leaving this blank will show all …)"*;
  - skip only on By Description.
- **Menu:** enable **Equipment Labels** (`MenuPageLoader.tsx:173`) at `equipment/print-labels`.

## §4 · CP3: Small Cable Labels, `Not Grouped` first (pedigree (a), Daniel 2026-09-19, "first")

- On the **Small Cable Labels grouped sort only**, the blank group prints **first**.
- Rewrite the proposal half of the comment at `cableDocs.ts:216-219` into a ruling, quoting the word
  and the date.
- The order term is shared with other cable documents. If flipping it for Small Cable Labels would
  move the Cable Checklist, Bundle Sheet or any other document, **scope the change to Small Cable Labels
  and leave the others as they are.** List each document that shares the term. Those documents belong
  to PRINT-REPARITY-DOCS.
- **The tail label sheets keep blank models last.** No ruling covers them.

## §5 · Left out, and why

- **Bundle Labels and Tail Folder Labels.** They use the same find shell, but together with these two
  that would make four new layouts in one unit. They stay next in PAPERWORK.
- **Group Parts and Device Patch.** PAPERWORK, after those.
- **Live results under the find.** Ruled *"not now"*.

## §6 · Close

- Run the full suite, typecheck, lint, build, frozen 3/3, the visual gate (frame 01 only, one declared
  event) and the dependency gate. Census 0.
- Measure both new sheets from **emitted PDFs**, as last unit, against the v1 JOY files. Every in-cell
  object must be within ±0.75 or a named quantum.
- Update the fence (FENCE-ONEUNIT).
- Return DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT, plus the COMMIT BLOCK.
- The COMMIT BLOCK includes
  `supabase/migrations/20260919190044_v_equipment_list_address_and_print_settings_default.sql`.

**Daniel's gate, on JOY only.** Restart `:3100` first.

1. **Menu → Steck Labels**, blank find, By Device. Every sticker shows a device, a name, a model and an
   `@ panel`. The page count is close to v1's 19.
2. **Steck Labels, By Cable.** The skip box appears. Skip 3, and the first label lands on the fourth
   sticker, down the first column.
3. **Menu → Equipment Labels**, By Group. There is a group header, each label shows Description,
   Model and **Address**, and a two-label item prints two stickers in a row.
4. **Equipment Labels, By Description.** Each label shows Description and Address only, and the skip
   box appears.
5. **Small Cable Labels, grouped.** `Not Grouped` comes first.

Proposed subject: `STECK-EQUIP-LABELS: Steck Labels and Equipment Labels with their v1 find screens;
Not Grouped first`.
