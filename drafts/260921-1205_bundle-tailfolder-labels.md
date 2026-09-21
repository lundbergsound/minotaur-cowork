# BUNDLE-TAILFOLDER-LABELS: Bundle Labels and Tail Folder Labels, each with its v1 find screen, on Avery 5160

Tier: claude-opus-5
Model: claude-opus-5
Session: FRESH

*Arch, main line, 2026-09-21. Code is at `d2c897b`, which is `origin/main` (PRINT-REPARITY-DOCS, shipped). The
migration ledger is **83**. Read HEAD and origin from the ref files, and read the ledger live (expect 83). Line
numbers were read at `d2c897b` today. **No migration rides this unit** — nothing here touches the database; the
two new sort settings go into `projects.print_list_settings`, which merges new keys as JSON
(`cablePrintSettings.ts:98`).*

**What this is.** PAPERWORK's step 3: the last two label outputs still greyed out on the Cable menu
(`MenuPageLoader.tsx:213, 221`). Both print on **Avery 5160**, the die `Cable Folder Labels` already ships on
(`cableGeometry.ts:139-147`, `FOLDER`, 3 × 10, column-major). Both get the shipped find-screen shape — options,
"Which …?" find, GO, Skip Labels where v1 has it, preview. The design is
`handoffs/parallel/260918-1224_paperwork-findscreen_DESIGN.md` (§4 rows 1 and 2, §5) and its six rulings are
`handoffs/parallel/260918-1240_paperwork-findscreen_RULED.md`; both have tracked copies in `drafts/`.

**Evidence, pedigree (b):**

- `~/Minotaur_v1_exports/cable-box/Cable PDFs/Bundle Labels.pdf` — BVSC, 6 pages, the **By Box** sort.
- `~/Minotaur_v1_exports/parity-pairs/260919_print-reparity/260919-1057_v1_bundle-labels-by-group_JOY_FILEMAKER.pdf`
  — JOY, 2 pages, the **By Group** sort. JOY is `0d329963-dcd1-403d-a5ad-1f78f0b9a425`.
- `~/Minotaur_v1_exports/cable-box/Cable PDFs/Tail Folder Labels.pdf` — BVSC, 1 page, 8 labels.
- `~/Minotaur_v1_exports/cable-box/Cable PDFs/Cable Folder Labels.pdf` — the shipped die, for the cell and
  the page chrome these two share.

**Two checkpoints, one unit.** ⚠ **Every answer you need is in this file or the two design files. There is no
blank for anyone to fill in.**

## §0 · HARD STOPS

1. **No migrations and no SQL writes.**
2. **Test shows only**: JOY and the other `daniel+test01@` projects, or seeded throwaways. **Never Buena Vista
   Social Club, and never a cohort member's show.** The BVSC PDFs above are evidence files, not a live project.
3. **Visual gate.** Design §6, measured at `fcdeb2a`: no frame photographs a Cable-tab menu or any print options
   screen, so **no event is expected**. Re-check at HEAD: frame `01-project-menu` is `/project/<id>`
   (`visual-capture.mjs:751`). If enabling the two Cable-menu buttons moves it, that is a declared two-frame event
   with the frames looked at; anything else moving is a stop.
4. **The renderer is the one source of truth for fill order** (design §8.4). Both outputs render through the
   `FOLDER` grid, which is `fill: 'column'`; the skip count and the sheet must come from the same function.
5. Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT
   section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every
   line."*
6. GATE-NOGREP. Commit only on Daniel's `COMMIT APPROVED: <first words>`, after his gate.
7. **Read the print before you write the sentence.** Every cell number below was read off the PDFs today; where
   this file says "measure", open the named file at the named page.

## §1 · Rulings of record (pedigree (a))

From `260918-1240_paperwork-findscreen_RULED.md`, Daniel, 2026-09-18, verbatim:

1. **No skip hint line** — *"I don't recongize this from v1, so no."* The skip box stays v1's script 83 as
   shipped.
2. **Skip appears only where v1 has it** — *"yes, skip only appears where it does in v1."* For these two: Bundle
   Labels on **By Bundle, then by Cable** only; Tail Folder Labels **always**.
4. **Tail Folder Labels on Avery 5160** — *"yes"*.
5. **Bundle Labels shares Bundle Sheet's sort setting** — *"yes"*. That is `bundleSheetSort`
   (`cablePrintSettings.ts:41, 57`), read and written by both pages.
6. **No live results under the find** — *"not now"*.

(Ruling 3, Max # Label Sets, is Equipment Labels' and is not here.)

**R2 — Daniel, 2026-09-19: *"sort as number approved."*** Number-aware order everywhere, a named divergence
from v1 written into the source with its date. It bites on Tail Folder Labels: v1 prints `12-Pair, 19-Pair,
6-Pair` (text order); v2 prints `6-Pair, 12-Pair, 19-Pair`.

**Design proposals (c), not struck by Daniel — they stand:** (c1) Tail Folder's legend reads *"Which Cable
Models? (Leaving this blank will show all cable models.)"* — v1's says "groups", a slip; (c2) Bundle Labels shows
no "Model before name" option; (c3) Bundle Labels' second find field is labelled **Group**; (c6) Cancel on the
skip box closes it and prints nothing, as v2 does today; (c7) the skip box's input label gains v1's colon —
*"Number of labels to skip:"* — `SkipLabelsDialog.tsx:45` already has it; confirm and move on.

## §2 · CP1: Bundle Labels (pedigree (b), the two Bundle Labels PDFs)

**Route** `/project/<id>/cable/print-bundle-labels`, a new client beside `FolderLabelsPrintClient.tsx`, fed by
`CableDocPageLoader.tsx` the way the other cable prints are; the menu button at `MenuPageLoader.tsx:213` goes
live. **Page chrome is Cable Folder Labels'** (project name bold-italic 12 at x 16 / top 21.50; the title
centred with its 1.00 pt underline at y 33; date-time and `n of N` at the right, 10 pt) — measure once on
`Cable Folder Labels.pdf` and reuse what the shipped page does.

**Screen** (design §4 row 1): options **Sort** (the three Bundle-Sheet sorts, `bundleSheetSort`, default
`group_bundle_cable`) and **Date Format**; find **"Which Bundles? (Leaving this blank will show all bundles.)"**
with fields **Bundle · Group**, the R-23 `WhichXFindBlock`; GO; Skip Labels **only on By Bundle, then by Cable**
(ruling 2; precedent `CableLabelsPrintClient.tsx`, skip only on By Cable).

**The run.** One cell per **end** of each bundle — **two cells per bundle, the flagged end first** (JOY p1:
`Ampland @ Booth` then `Ampland @ BlackBox`, Booth flagged; `Ampland Ext. @ BlackBox` then `@ Booth`, BlackBox
flagged; `Bass @ BlackBox` then `@ Bass`). Under **By Group** and **By Box**, a **heading cell** opens each
group / box and takes a cell in the column flow (JOY p1 cell 1 `Bundles`; BVSC p1 `No Box`, p1 col 1 `201 FOH
Runs`). Under By Bundle, no heading cells. Bundle order inside a heading: `compareLabels`; blank group / no box
first, as the shipped folder page does. ⚠ The By-Box population is **the boxes the bundles sit in**, never the
project's box registry — the same rule the folder page learned (`FolderLabelsPrintClient.tsx:13-27`).

**The cell** (5160, 72.00 tall; numbers are page points off JOY p1, column 1, cells 2–3; x is from the page
edge, column 1 — derive columns 2 and 3 from `FOLDER.pitch.x`):

| object | measured | note |
|---|---|---|
| **bundle name** | 18 pt **bold**, centred on the column (x centre ≈ 112.97), glyph top **+11.14** from the cell top; a **1.00 pt black underline** the width of the name, **+27.40** | `Ampland` 119.14 / rule 135.40 in the 108–180 cell |
| **`@ <end>`** | 14 pt regular, centred, glyph top **+32.35** | `@ Booth` 140.35 |
| **end colour chip** | behind the `@` line: **186.00 × 20.02**, from x **19.00** (col 1) / 217.42 (col 2) / 415.84 (col 3), top **+28.44**; the palette colour of **that end**, text in the palette's text colour | BVSC p1: `@ Front of House Mix` white on Green; `@ Ampland` black on Orange; no chip for a colourless end |
| **`Box: <number> <name>`** | 8 pt, `Box:` bold, x **26.00**, glyph top **+48.66** | `Box: 3 Ampland` — number and name, as the Bundle Sheet prints it |
| **`Group: <group>`** | 8 pt, `Group:` bold, x 26.00, glyph top **+58.66** | `Group: Bundles` |
| **length** | 10 pt, **right-aligned to x 197.99**, glyph top **+59.08** | `200'` |
| **centre tick** | a 1.00 pt vertical line, **7.00 long**, at the column centre (x 112.50 / 310.92 / 509.34), from the cell top **+1.44** | on every cell, heading cells included |
| **heading cell** | 18 pt bold, **left at x 17**, glyph top +18.18, underlined 1.00 pt at +34.43 the width of the text; on a **#FED1CF chip 24.00 tall from +13.43**, from x 16 to the text end + 2 | JOY `Bundles`; BVSC `No Box`, `201 FOH Runs` — the box heading prints number and name |

Blank fields print nothing and move nothing (BVSC `Sub Training` cells: no Box line, no Group line moves). A
name too wide for the column: **measure** — find one on BVSC pp. 2–6 or say there is none; if none, keep the
name on one line at 18 pt and note it in OPEN QUESTIONS.

**Success:** on JOY, By Group prints **2 pages**, cell for cell against the JOY PDF: heading cell, then the
bundle pairs in v1's order; every object above within 0.75 pt of the JOY file, measured with pdfplumber on a
Chrome Save-as-PDF. Skip = 3 on By Bundle leaves the top three cells of column 1 blank.

## §3 · CP2: Tail Folder Labels (pedigree (b), `Tail Folder Labels.pdf`)

**Route** `/project/<id>/cable/print-tail-folder-labels`; the menu button at `MenuPageLoader.tsx:221` goes live.
Page chrome: Cable Folder Labels', title `Tail Folder Labels`.

**Screen** (design §4 row 2): no options; find **"Which Cable Models? (Leaving this blank will show all cable
models.)"** (c1), one field **Cable Model**; GO; Skip Labels **every run** (ruling 2). Sort: cable model,
number-aware (R2), no choice offered.

**The run.** **One cell per distinct tail model in the show** — BVSC prints 8: `12-Pair`, `19-Pair`, `6-Pair`,
`CAT5-1x XLRF+1x XLRM`, `Combo`, `Ethercon`, `NL4`, `NL8`. The population is `DocTail.model`
(`cableDocs.ts:74-77`, the tail's own model text), distinct, trimmed, blank excluded — **assumption, named:** a
tail with no model prints no cell; if v1 prints a `Tails` cell for blank, it would be on this sheet and it is
not.

**The cell** is the folder cell: `FOLDER_CELL` (`cableGeometry.ts:177-180`) — 18 pt, two centred lines, line 1
the model, line 2 the word **`Tails`** — **but both lines bold** (Cable Folder's line 2 is regular; here
`Tails` measures `CenturyGothic-Bold` on all 8). Glyph tops **+8.67 and +30.67** from the cell top, the same
as FOLDER_CELL. ⚠ **A long model wraps and pushes `Tails` down**: `CAT5-1x XLRF+1x` / `XLRM` / `Tails` at
+8.67 / +30.67 / +52.67 (a 22.00 line pitch) — three lines inside the 72.00 cell, top-anchored. Build the wrap;
do not shrink the type (the Small Tail Block's 14 → 10 rule is a different cell).

**Success:** a throwaway seeded with those eight models prints one page, 8 cells in column 1, cell for cell
against the BVSC PDF within 0.75 pt, in the order `6-Pair, 12-Pair, 19-Pair, CAT5…, Combo, Ethercon, NL4, NL8`
(R2 — v1's own order is text order; the difference is the ruled one). Skip = 2 leaves the top two cells blank.

## §4 · Both

- `STOCK-IS-DIE` gains a fifth output (Tail Folder Labels) in its source comment where the list lives; the
  governing docs are Arch's at close.
- `buildFolderCells` / `buildGroupFolderCells` (`cableLabels.ts:465, 493`) are the shipped heading and cell
  builders; extend or sit beside them — code structure is yours — but one column-major placement function
  serves all three 5160 outputs.
- The skip dialog is `SkipLabelsDialog.tsx`, unchanged (ruling 1); `applySkip` (`cableLabels.ts`) leads the run
  with N blanks.
- Regression tests pin: two cells per bundle, flagged end first; heading cells only on the two grouped sorts;
  skip offered only where §1 says; Tail Folder's distinct-model population and its number-aware order.

## §5 · Left out, and why

- **The skip hint line** — ruled no.
- **Max # Label Sets** — Equipment Labels', ruled drop.
- **Live results under the find** — ruled not now (OQ9 stays unbuilt everywhere).
- **Group Parts and Device Patch** — PAPERWORK's step 5, the equipment find grid; their own unit.
- **Box Labels firing the skip on every GO** (design §8.7) — not checked against v1's box scripts; the box
  family's round.
- **Whether v1 prints a `Tails` cell for a blank model** — see §3's named assumption.

## §6 · Close

- Run the full suite, typecheck, lint, build, frozen 3/3, the visual gate (§0.3), the dependency gate. Census 0.
- Success, measured: the two pdfplumber comparisons in §2 and §3, pasted verbatim. Reproduction on a throwaway
  is expected (HARNESS-RLS-CORPUS); Daniel's print on JOY is the record.
- Update the fence (FENCE-ONEUNIT).
- Return DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT, plus the COMMIT BLOCK.

**Daniel's gate, on JOY only.** Restart `:3100` first.

1. **Cable menu.** Bundle Labels and Tail Folder Labels are live buttons, not greyed out.
2. **Bundle Labels, By Group.** Two pages. The first cell is a `Bundles` heading on a pink chip; then
   `Ampland @ Booth`, `Ampland @ BlackBox`, `Ampland Ext. @ BlackBox`, `Ampland Ext. @ Booth`, each with its
   underline, `Box: 3 Ampland`, `Group: Bundles`, the length at the right, and a short tick at the top centre.
   Hold it against `260919-1057_v1_bundle-labels-by-group_JOY_FILEMAKER.pdf`.
3. **Bundle Labels, By Bundle.** No heading cells; the skip box appears on GO; skip 3 leaves the top three
   cells of column 1 empty.
4. **Tail Folder Labels.** One cell per tail model, `<model>` over `Tails`, both bold; the skip box appears on
   GO; `6-Pair` before `12-Pair` (your number-sort ruling — v1 puts it after `19-Pair`).

Proposed subject: `BUNDLE-TAILFOLDER-LABELS: Bundle Labels and Tail Folder Labels on Avery 5160, each with its
v1 find screen`.
