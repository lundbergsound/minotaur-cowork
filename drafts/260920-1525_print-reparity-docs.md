# PRINT-REPARITY-DOCS: Cable Checklist, Tail Checklist and Bundle Sheet to v1, the logo on all five cable documents, and PAPERWORK's leftovers

Tier: claude-opus-5
Model: claude-opus-5
Session: FRESH

*Arch, main line, 2026-09-20. Code is at `1982063`, which is `origin/main` (PALETTE-V1-HUES, shipped). The
migration ledger is **83**. Read HEAD and origin from the ref files, and read the ledger live (expect 83). Line
numbers were read at `1982063` today. **No migration rides this unit** — nothing here touches the database.*

**What this is.** The three shop documents were never compared against v1 until 2026-09-19. The comparison is
`handoffs/parallel/260919-1124_print-reparity_RETURN.md` (a tracked copy is at
`drafts/260919-1124_print-reparity_RETURN.md`). Its §4.1, §4.2 and §4.3 hold the measured tables — every object
on each document, v1 against v2, in points — and §4.10 holds v1's row-growth rules. **Those tables are the
specification.** This file tells you which rows are ruled, which are assumptions, what is already known about the
code, and where to stop. Every number in the tables carries pedigree (b): a file in
`~/Minotaur_v1_exports/parity-pairs/260919_print-reparity/`, with the page.

**Five checkpoints, one unit**, on Daniel's standing instruction to bundle. If CP1 runs long, the Bundle Sheet
(CP4) is the part to split out — say so in OPEN QUESTIONS and stop after CP3.

**⚠ Every answer you need is in this file or the return it names. There is no blank for anyone to fill in.**

## §0 · HARD STOPS

1. **No migrations and no SQL writes.**
2. **Test shows only**: JOY `0d329963-dcd1-403d-a5ad-1f78f0b9a425` and the other `daniel+test01@` projects, or
   seeded throwaways. **Never Buena Vista Social Club, and never a cohort member's show.**
3. **Visual gate: no event expected.** `scripts/visual-capture.mjs` names none of these five documents, so all
   28 frames should hold. **A moved frame is a stop.**
4. **PRINT-CLIP on all three checklists/sheets.** Every row height changes here, and `useMeasuredPages` paginates
   by height. The guard that no row is lost off a page runs on the Cable Checklist, the Tail Checklist and the
   Bundle Sheet, on JOY, in both sorts where a document has two.
5. Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT
   section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every
   line."*
6. GATE-NOGREP. Commit only on Daniel's `COMMIT APPROVED: <first words>`, after his gate.
7. **Read the print before you write the sentence.** Where this file says "measure", open the named PDF at the
   named page. A number this file does not give is in the return's table or on the page; it is not to be
   predicted.

## §1 · Rulings of record

**Daniel, 2026-09-19, verbatim (return §0):**

> "1. make small cable labels match v1, please
> 2. sort as number approved
> 3. follow v1 page break
> 4. follow v1's resizing rules"

- **R2 — "sort as number approved."** v2's number-aware order stands everywhere in this unit: `6-Pair, 12-Pair,
  19-Pair`; `RG6` before `RG59`. It is a **named divergence from v1**: write it into the source with its date
  wherever a sort is touched, so nobody "fixes" it back from the artifact.
- **R3 — "follow v1 page break."** Cable Checklist: a new page for each group, the group in the page title. Tail
  Checklist by model: one model per page run, the model in the title. **R3 was asked about the two checklists.**
  The tail LABEL sheets keep their 2026-08-30 ruling and are not in this unit.
- **R4 — "follow v1's resizing rules."** The rules are measured in return §4.10. This unit builds the four that
  touch these documents (Bundle Summary name wrap, Cable Checklist row growth, Tail Checklist name wrap, Bundle
  Sheet fixed rows) and leaves the rest as they are, because §4.10 says they already pass.
- **Daniel, 2026-09-19, on the labels' blank group: *"first"***, carried in `cableDocs.ts:217`. **Assumption,
  named, one word to correct:** the Cable Checklist's blank group also prints first, as v1 prints it (return
  §4.1: v1 puts the blank group first with the title `Cable Checklist for Group:`). If Daniel says "last", the
  title is the same and only the order moves.
- **Daniel, 2026-09-18:** *"blank should sort after anything with a value. 0 should sort before 1"* — the
  comparator, unchanged here.

## §2 · CP1: v1's page chrome and the logo, on all five cable documents (pedigree (b))

The five: Cable Checklist, Tail Checklist, Bundle Sheet, Bundle Summary, Line List.

1. **Chrome.** The Cable Checklist, Tail Checklist and Bundle Sheet still use the shared `DocHeader` /
   `DocFooter` (`CableChecklistPrintClient.tsx:248, 342`; `TailChecklistPrintClient.tsx:167, 220`;
   `BundleSheetPrintClient.tsx:147, 223`). Move each to a per-document `V1ChromeSpec` in `v1DocChrome.tsx`, the PAPERWORK-1 pattern
   the Bundle Summary and Line List already use. The numbers are the chrome rows of return §4.1 (Cable
   Checklist), §4.3 (Tail Checklist) and §4.2 (Bundle Sheet): project name, venue, title top and centre, title
   underline, header rule y / weight / span, footer rule, date, page number, **footer ink black**. Two of the
   three are landscape (`DocPrintCss landscape`, `BundleSheetPrintClient.tsx:134`, `TailChecklistPrintClient.tsx:153`)
   and `v1DocChrome.tsx` hard-codes `PAGE_W_PT = 612` (line 89): generalise the page width; do not fork the file.
   - **Bundle Sheet extras:** the "Tape Here, Please" line at top 39.50 / centre x 377.44 and its rule at y 54.50,
     x 26–733, 1.00 pt `#ADADAD`. v1's rule is dashed to the eye and its dash pattern was not read (return §9);
     keep v2's dash array on it. Title face **Arial-Bold 14** at centre 378.95 (see §5.3).
   - **Tail Checklist:** the "Pulled/Labeled" caption sits **above** the header rule (top 74.64, x 668.99–727.67);
     v2 puts it below (`TailChecklistPrintClient.tsx:177`).
   - `DocHeader` / `DocFooter` stay untouched if any shipped document still uses them after this; if none does,
     say so in OPEN QUESTIONS and leave them — removal is a separate call.
2. **The project logo, top right, on all five.** v1 prints the project's top-right image in a **171.6 × 34.0 pt
   box** at **x 409.98 (portrait)** and **x 556.98 (landscape)**; y is **24.98** on the Cable Checklist (§4.1),
   **26.00** on the Tail Checklist (§4.3), **60.00** on the Bundle Sheet (§4.2). **Measure y for the Bundle
   Summary and the Line List** on `260919-1051_v1_bundle-summary_JOY_FILEMAKER.pdf` p1 and
   `260919-1053_v1_mult-line-list_JOY_FILEMAKER.pdf` p1 — the return records the logo as present on both but does
   not give the y. Source: `projects.top_right_image_url`, resolved the way `PrintEquipmentListClient.tsx:1232`
   does (`useResolvedImageUrl`). Fit the image inside the box, aspect kept, right-aligned; no box when the
   project has no image.
   - ⚠ **The re-imported JOY has no logo today** (`top_right_image_url` is null, live-read 2026-09-20). The old
     JOY had one. Daniel uploads it in Project Settings before his gate (§8); until then, gate the logo box on a
     throwaway with an image, and the "no image → no box" case on JOY as it stands.
   - ⚠ The July arbiters (`cable-box/Cable PDFs/`) carry no logo; the five JOY v1 prints of 2026-09-19 are the
     only evidence for this leg.

## §3 · CP2: the Cable Checklist body (pedigree (b), return §4.1; R2, R3, R4)

`CableChecklistPrintClient.tsx` and `lib/print/cableDocs.ts`.

1. **R3 — a page per group.** The page title becomes `Cable Checklist for Group: <group>` (v1's title, §4.1;
   with the blank group, the title ends at the colon). Retire the in-flow `group-title` block
   (`CableChecklistPrintClient.tsx:260-264`) for the grouped sort, and rewrite the header comment at lines 3–10,
   which still says "Continuous per-group flow", to say what the file now does and why (R3, with the date).
   `useMeasuredPages` takes `forceBreakBefore` (`useMeasuredPages.tsx:92`); a group boundary is one.
2. **The group key is case-sensitive.** `compareLabels` sorts `Vor` and `vor` as equal
   (`lib/equipment/compareLabels.ts:19`, `sensitivity: 'base'`), and then `cableDocs.ts:380` breaks a section
   on `c.groupLabel !== curGroup`, so JOY prints `Vor`, `vor`, `Vor` as three sections. **The same pattern is at
   `cableLabels.ts:117`** for the grouped Small Cable Labels. Fix both with one normalised key (fold case the way
   `compareLabels` does), not two. The printed label is the one v1 prints: open
   `260919-1052_v1_cable-checklist-by-group_JOY_FILEMAKER.pdf` at the Vor page and use that spelling; if v1
   prints the first spelling in sort order, that is the rule.
3. **The "Not in Bundles" band.** v1 JOY prints **15 bands**; v2 prints **0** (§4.1). The code prints the band
   only in a group that holds both bundled and loose cables (`cableDocs.ts:393-395`, citing the July arbiter's
   p31 and p54). **Measured 2026-09-20 on JOY's `v_cable_list`: no group is mixed** — `Bundles` holds 178 cables
   all bundled; the other 15 groups (with `Vor`/`vor` as one) hold only loose cables. So v1 prints the band over
   a loose-only group's cables, under the page title. Build that: **every group with loose cables gets the band.**
   Before you do, open the July arbiter `cable-box/Cable PDFs/Cable Checklist by Group.pdf` at p31 and say in
   OPEN QUESTIONS whether it shows a loose-only group without a band. If it does, that is a v1-against-v1
   difference for Arch to place; the JOY matched pair governs this build.
4. **The bundle band** (§4.1): 36.00 tall, fill `#D6D6D6` spanning 26–586, a 2.00 pt rule on top and 1.00 pt
   under; bundle name x 27.00 at 14 pt underlined; **length right-aligned at x 234.00**; `Flagged:` at x 288.20
   with its value at 333.00 and the chip 286–332 × 15.00 **behind the label**; Bundled/Tested boxes 12 × 12 at
   x 552 and 572, `Bundled/Tested:` in **Arial-Bold 10**; `Pulled/Labeled/Tested` 8 pt from x 495.00. Today
   (`CableChecklistPrintClient.tsx:265-294`) the length follows the name and `Flagged:` (`:282`) floats after it.
5. **The row** (§4.1): name at x 27.00 in a chip 17.00 tall; **no wrap** — the name column is 209 pt wide (the
   model line starts at 236.00); model at 236.00; `Female:` at 321.00; `Male:` at 435.00; end tint 12.00 tall
   **hugging the label** (320–354), not the cell; tick boxes **12 × 12, 1.00 pt** at x 534, 552, 570 (today
   11 CSS px, 1.5 px, `:318`); row rule 0.50 pt spanning 26.4–586.9; row pitch **25.39 with no tails**. The
   percentage widths at `:309-314` go; the columns are positions.
6. **Tails** (§4.1, §4.10): first tail 18.40 below the name top, **pitch 15.00**, a 0.50 pt `#D6D6D6` hairline
   spanning 25.4–584.9 under each; the row grows **15.00 per tail**; the `@ location` 6 pt line keeps its gap.
   An end cell that wraps adds 10.00 and its tint grows 12 → 22 (§4.10) — build it, and find one on JOY to gate
   it or say there is none.
7. **R2 holds** inside a group: number-aware order, blank group first (§1 assumption), `Not Grouped` is not
   printed here — the checklist's blank group title is v1's `Cable Checklist for Group:`.

## §4 · CP3: the Tail Checklist body (pedigree (b), return §4.3; R2, R3, R4)

`TailChecklistPrintClient.tsx`.

1. **R3 — by model, one model per page run**, the model in the page title (`Tail Checklist: 19-Pair`), and the
   blank model's title keeps its colon (`Tail Checklist:`; v2 drops it on the last page, §4.3). Today three models
   run onto one page with a stray left-aligned title mid-page (`:184`).
2. **Row** (§4.3): name at x 28.99, 16 pt bold, chip 21.98 tall; the name column wraps at a word inside about
   125 pt (fits `Aviom Trunk 1`, wraps `Ableton Midi to FOH`), line pitch 20.00, row 26.02 → 46.02 when it wraps;
   tail labels (`Female` / `Male` / `Tail:`) at x 293.99 (today 277.91); the `@ location` 8 pt gap 5.7; tick
   boxes **12 × 12 at x 686.99 and 708.99** (today 8.25 at 738.00 / 753.75); row pitch **26.02**.
3. **Rules** (§4.3): between a cable's two tails 0.50 pt `#D6D6D6` spanning 25.39–728.90; between cables 1.00 pt
   in the trim colour spanning 28.28–731.28. Today every rule is the same.
4. **R2 holds:** 6-Pair, 12-Pair, 19-Pair, blank last — with the divergence comment.
5. 101 rows on JOY in both versions; the row count is the regression check.

## §5 · CP4: the Bundle Sheet (pedigree (b), return §4.2; R2, R4)

`BundleSheetPrintClient.tsx`.

1. **Sheet width.** v1's content runs **24–733** and leaves the right 59 pt of the landscape page empty; v2
   stretches to 765, which is the root of every column Δ in §4.2. Rebuild to v1's width; every x below is a page
   position, not a percentage (`:167-182` and `:208-209` use `width: '18%'` / `'17%'` today).
2. **"Flagged: Booth" over the flagged column.** v1 sets it at x 392.97, over the pink column (391.97–512.97,
   continuous from y 166); v2 prints it at 509.67, over the other column (`:170`), **so the sheet reads as if the
   wrong end were flagged.** This is the one finding on the sheet a crew member would act on wrongly.
3. **Faces and sizes.** Bundle name **Arial-Bold 48** (today 45, `:156`); length **CG-Bold 48** right-aligned at
   728.98 (today 46, `:157`); title **Arial-Bold 14**. The comment at `:39` calls the giant name "the ONE Arial
   exception (P4-AMEND)"; v1 measures three Arial sites across these documents (the Bundle Sheet's name and
   title, the Cable Checklist's `Bundled/Tested:`). Rewrite that comment to name all three with the evidence
   file; do not add a fourth.
4. **Box line:** v1 prints `Box: 3 Ampland` — the box **number and name**; v2 prints the name only (`:167`;
   `docData.ts:26` already returns `boxNumber` beside `boxLabel`).
5. **Meta and heads** (§4.2): `Group:` at x 35.00, `Box:` at 180.00, `Cables:` right edge 729.00; the rule under
   the name at y 157.50, **1.00 pt in the trim colour** (today 2.25 pt black); column heads `Cable` 35.00 /
   `Model` 276.00, head rule y 201.50 at 1.00; cable name x 35.00 in a chip 17.00 tall; model 276.00; End 1
   393.00, End 2 527.00; tick boxes **12 × 12 at x 653 and 702** (the Labeled box sits 2.00 lower); **row pitch
   28.00** (today 22.50), row rule 1.00.
6. **R4:** the name is a fixed 48 pt and prints in full; the row is fixed at 28.00. Nothing grows on this sheet.
7. **Double spaces in a name are kept** — v1 prints `Ampland  Ext.` with its gap; HTML collapses it. `white-space:
   pre` on the giant name.
8. **R2 holds:** RG6 before RG59 inside a bundle, with the divergence comment.

## §6 · CP5: PAPERWORK's leftovers on the Bundle Summary and the Line List (pedigree (b); R4)

1. **Bundle Summary, R4 — a long name wraps and the row grows.** v1: a name too long for its 145 pt column
   wraps at a word, line 2 sits 17.00 below line 1, the row grows by **9.00**, nothing else in the row moves
   (§4.10; JOY v1 p1 `SD Preview:The` / `Sequel`). v2 prints `SD Preview:The Seque` behind `whiteSpace: nowrap;
   overflow: hidden` (`BundleSummaryPrintClient.tsx:180`). v2's base row is 34.50 (BVSC's 34.40, ruled to stay),
   so a wrapped row is 43.50. This replaces the 2026-09-18 "(c) choice, stays truncated", which was made when no
   v1 example existed.
2. **Bundle Summary — the Not Flagged colour chip.** v1 paints the not-flagged end's colour chip, **10.00 tall
   from x 329**, on 12 of JOY's 26 rows; v2 paints none. The comment at `:62` ("the not-flagged value has no
   chip") is wrong at source — rewrite it with the evidence page.
3. **Bundle Summary — continuation title** centre 308.41 in v1, 306.40 in v2 (−2.01, §4.8).
4. **Line List — a mult with no tails prints no tail rows.** v1 JOY p32 `cSpot Shadow`. v2 prints the cable
   TYPE's default tail (`LineListPrintClient.tsx:140-142`), "by design" at the time; R4 and the print overrule
   it. The header block still grows 16.00 per tail row, which already passes (§4.10).
5. **The logo on both** — CP1.

## §7 · Left out, and why

- **BOX-ROW-TYPE** (the equipment list's box rows by type): a design call, Arch's.
- **The Small Cable Labels' "@" line crowding the grey rule** (Daniel: *"minor. Look to ride along whenever"*):
  a label sheet, not one of these documents; it rides the next labels unit.
- **`cPreview`, the two Chartreuse-for-Sand end colours, and parentless tails sharing a column**: IMPORT-TRAILSPACE's remainder, Arch diagnoses first.
- **The page totals 33 / 9 / 6 / 26** in the return's success line are v1's counts with v1's data; JOY in v2
  still carries 5 parentless tails, so **gate on rows per page and row growth, not on totals.** Report the totals
  in RAW OUTPUT for the record.

## §8 · Close

- Checkpoints in order, CP1 → CP5; the full gate set at each: suite, typecheck, lint, build, frozen 3/3, the
  visual gate (§0.3, no event expected), the dependency gate, PRINT-CLIP on all three (§0.4). Census 0.
- **Success, measured, not predicted:** reprint the three documents on JOY (Chrome Save-as-PDF, 100%, US Letter,
  PDF-CHROME-PATH) and re-measure the §4.1, §4.2 and §4.3 tables against the v1 files named in the return; every
  row ≤ 0.75 pt or a named quantum (EQUIPLIST-RULE-QUANTUM). Paste the re-measured tables verbatim.
- Update the fence (FENCE-ONEUNIT).
- Return DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT, plus the COMMIT BLOCK.

**Daniel's gate, on JOY only.** Restart `:3100` first.

0. **Before the gate: upload JOY's logo** in Project Settings (the re-imported JOY has none).
1. **Cable Checklist by Group.** Each group starts its own page and the page title names it. `Vor` appears once.
   Every group with loose cables shows the grey "Not in Bundles" band. The three tick boxes are the big v1 ones.
   The logo is top right.
2. **Tail Checklist by Model.** One model per run of pages, named in the title; the last page's title still ends
   with a colon. Big tick boxes. Logo.
3. **Bundle Sheet.** "Flagged: Booth" sits over the pink column. The box line reads `Box: 3 Ampland`. The name is
   larger and the rows are taller. Logo.
4. **Bundle Summary.** `SD Preview:The Sequel` wraps onto two lines and its row is taller; Not Flagged ends show
   their colour chip. Logo.
5. **Line List.** `cSpot Shadow` prints no tail rows. Logo.

Proposed subject: `PRINT-REPARITY-DOCS: Cable Checklist, Tail Checklist and Bundle Sheet to v1; the logo on all
five cable documents; Bundle Summary and Line List leftovers`.
