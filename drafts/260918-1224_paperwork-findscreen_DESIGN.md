# PAPERWORK — the find-or-options screen and the skip-N offset (LAYOUT-FINDSCREEN) — DESIGN

*Parallel session return · written 2026-09-18 12:24 ET · Cowork-Arch, DESIGN ONLY.
Opener: `handoffs/parallel/260918-1215_paperwork-findscreen_OPENER.md`. Governing set read:
Architecture Prompt v39 · Roadmap v4.45 · Brief v1.2 · Session Log · order ruling
`drafts/260918-1218_paperwork-order_RULED.md`.*

---

## FOR DANIEL — readable on its own

**Where I land: the screen already exists in v2. What is left is small, and it needs six
one-word answers from you.**

- **The screen is not new.** Eight of v2's shipped print pages already use one shape: options at
  the top, a "Which cables?" (or boxes, or equipment) find under them, GO, and — on label
  sheets — the "Skip Labels?" box. The six new layouts get that same shape, filled in from each
  v1 layout's own fields and sorts. No new screen, no database change.
- **One correction to this morning's premise.** Line List *does* have a find screen in v1
  ("Which Mults?"). Only Bundle Summary goes straight to paper. It changes nothing in the order
  you ruled — Line List's find is the ordinary one v2 already builds — but it is seven layouts
  with a screen, not six.
- **The skip box already works; it has one trap.** Every label sheet I could measure fills
  **down each column first**, not across the row. So "skip 3" skips the top three stickers of the
  left column. A crew member counting across the sheet will get it wrong, and v1 had the same
  trap. The fix I recommend is one line under the number: *"First label prints on: column 1,
  row 4."* Nothing to configure, nothing to learn.
- **Skip appears exactly where v1 put it:** on the un-grouped sort of each label (by name, by
  description, by cable), and always on Tail Folder Labels. Grouped sorts start each group fresh,
  so a skip there means nothing.
- **Your 5167 print still matters, but only to two of these.** It tells us whether a skipped
  sheet lands the first Steck or Equipment label squarely on a sticker. It does not change how
  the skip counts, so nothing here waits for it.
- **Cost to the screenshot check:** no new frames. The only frame that moves is the Project
  Menu, when the three equipment buttons stop being greyed out — a declared change of two
  pictures each time.

**What I need from you is the six answers in the next section.** Then the main line can write
the build handoff.

---

## 1 · THE RULINGS YOU OWE — batched, one word each

**[MILESTONE HALT] Trigger A** — a new operator flow on seven print pages. **Risk:** built without
these answers, the screens either copy v1's traps or invent fixes you never agreed to. **You
supply:** six answers. **Resolved:** each has a word next to it.

1. **The skip hint line.** v1 asks only *"Number of labels to skip:"* and fills down columns, so
   the count is easy to get wrong. Add one line under the box saying which sticker the first label
   lands on (*"column 1, row 4"*)? **Yes / no.**
   *(The alternative — tap the sticker on a picture of the sheet — is friendlier but is a new
   component on four shipped pages; I don't recommend it now.)*
2. **Where skip appears.** v1 offers it only on *"By Bundle, then by Cable"* (Bundle Labels),
   *"By Description"* (Equipment Labels), *"By Cable"* (Steck), and every Tail Folder run. Keep
   exactly that? **Yes / no.**
3. **Equipment Labels' reprint cap.** v1's find has **"Max # Label Sets"** — print only the first
   N of each item's labels, for a reprint. The cable version was retired because cable counts
   became checkboxes; equipment keeps real counts now (your Q-1 ruling). **Keep / drop.**
4. **Tail Folder Labels' sticker sheet.** v1 prints them on the same die as Cable Folder Labels
   — Avery 5160, 30 to a sheet — measured to the hundredth of a point (§3.3). Confirm that is
   their stock? **Yes / no.**
5. **Bundle Labels and Bundle Sheet share one sort setting**, as they do in v1 (both read the
   same "Bundle Sheet Print Sort Order"). **Yes / no.**
6. **The live results under the find.** You ruled on 2026-08-11 (OQ9) that box finds show a
   results table that narrows as you type. It was never built on any box page. Build it once,
   here, for all these screens? **Yes / not now.**

**And one blanket line:** the seven small proposals marked **(c)** in §4 and §5 stand unless you
strike one by number.

---

## 2 · STATE, VERIFIED AT SOURCE

- **Seat:** Cowork, all three mounts granted at open. **HEAD** `fcdeb2a` = `origin/main`, read from
  `.git/refs/`; no `index.lock`. **No git command run.** Nothing written to the code repo.
- **Migration ledger 77**, live-read; the newest is `rls_read_policies_set_form` at 16:07 UTC =
  12:07 ET. Matches the opener.
- **The walkthrough has happened.** Your order ruling (12:18 ET) puts this design at step 3, with
  Bundle Labels and Tail Folder Labels; Steck and Equipment Labels at step 4 after the 5167 print;
  Group Parts and Device Patch at step 5.

---

## 3 · WHAT THE EVIDENCE CHANGED

### 3.1 · The screen is a shipped pattern, not a new one

At `fcdeb2a` eight print pages share one shape (Build Spec R-22: *"one page per output combining
Options + Find … in-page preview with Back"*):

- **Options** — `OptionBox` groups with `DocRadio` sorts, `DocCheck` toggles, `DateFormatBox`,
  and v1's Recommendations text verbatim (`CableLabelsPrintClient.tsx:335-356`).
- **Find** — `WhichXFindBlock.tsx`, the R-23 grammar: OR request rows, `+ and`, per-criterion Omit,
  operators including *is exactly*, the v1 legend *"(Leaving this blank will show all X.)"*, and
  the optional Print List scope (P6). Used by the cable and box pages.
- **The equipment find** — `PrintEquipmentListClient.tsx:401-465`: fixed columns **Method ·
  Category · Group**, autocompleting fields, a row per OR request, `×` to remove. This is v1
  layout **19 `Search-Method`** — the very layout Group Parts lands on.
- **GO** — `GoRail`, **Main Menu** back.
- **Skip** — `SkipLabelsDialog.tsx` on GO, on four surfaces (Cable, Tail, Box labels).

So "design the screen once" means **one per-layout configuration of what exists.** Sort choices
persist per project inside `projects.print_list_settings` (`cablePrintSettings.ts:111-118` merges
new keys into the JSON) — **no migration, no Trigger B.**

### 3.2 · Corrections to the record

1. **Line List has a v1 find.** Script **67** goes to layout **260 `Search-Mult Line List`** and
   `Enter Find Mode [Pause]`: *"Which Mults? (Leaving this blank will show all mults.)"* — Mult ·
   Model · Method · Group, with a `+` request button. **Seven of the nine land on a screen; only
   Bundle Summary (script 360) does not.** The order ruling stands, because Line List's screen is
   the plain shipped find with no options and no skip; only its stated reason was wrong.
   *Propagation for the main line:* the opener, the August design's "six of the eight", Roadmap
   v4.45's PAPERWORK row and the Ledger's LAYOUT-FINDSCREEN row all say six.
2. **"Label ID" is not an Equipment Labels find field.** Layout **280** shows it only as a display
   token (`<<Label ID>>`). The find is **Description · Group · Category · Device Model**, plus
   **Max # Label Sets** and **Exact Matches**; script **464** turns Max # into `Label ID ≤ N`.
   The August design §4.3 listed Label ID as a field.
3. **OQ9 (a) is ruled but unbuilt.** `handoffs/to-cc/260811-0300_s4-3-boxes-overnight.md:78`:
   *"live-narrowing results table under the find fields, per keystroke."* No box print page at
   `fcdeb2a` has one (`BoxListPrintClient.tsx:312-318` is find then GO). Hence ruling 6.

### 3.3 · Fill order, measured — every sheet I could read fills down columns

| output | stock | fill | evidence |
|---|---|---|---|
| Bundle Labels | 5160, 3 × 10 | **column** | `Bundle Labels.pdf` p1: `FOH 3` ends column 1, `FOH 4` opens column 2; p6: column 1 full (10), column 2 partial, column 3 empty |
| Tail Folder Labels | **5160** (ruling 4) | **column** | `Tail Folder Labels.pdf`: all 8 labels in column 1. Text centre **112.47** (Cable Folder's column-1 centre is 112.49, `cableGeometry.ts` FOLDER note); model em-tops **44.67 / 116.67 / 188.67**, i.e. 36 + **8.67** on a **72.00** pitch = `FOLDER_CELL` exactly (`cableGeometry.ts:177-179`). The one odd step is `CAT5-1x XLRF+1x XLRM` wrapping to two lines and pushing its `Tails` down 22 pt. |
| Equipment Labels | 5167, 4 × 20 | **column** | `…equipment-labels…sort-description.pdf` p5 (38 labels): column 1 rows 1-20, column 2 rows 1-18, columns 3-4 empty. The `Labels = 2` pairs sit in consecutive rows of one column (August §4.3.0). |
| Steck Labels | 5167, 4 × 20 | **not determined** | `Steck Labels.pdf` p9 has labels in all four columns with gaps — consistent with a grouped sort's breaks, not a fill order. A parity-pass measurement at the Steck unit. |

**v2 already knows this rule for folders** (`cableGeometry.ts:134-137`: *"v1 fills this grid
COLUMN-major … a shop reaching for the fourth label gets a different box"*).

---

## 4 · THE SCREEN, PER LAYOUT

**Shell, identical for all seven:** options (if any) → find → [live results, ruling 6] → GO →
skip dialog (where §5 says) → in-page preview → print. Blank find prints everything; sort default
is the first entry of v1's own list, as the shipped cable defaults are
(`cablePrintSettings.ts:53-60`). **Find grammar:** cable side and Equipment Labels use
`WhichXFindBlock` (R-23; Equipment Labels needs its *exact* operator — R-23 names the Zite grammar
*"the v2 reference for Exact Matches"*); Group Parts and Device Patch use the equipment find grid,
because their v1 layouts (19, 351) are that grid's own family.

| # | layout | options | find fields (v1 order) | sorts, default first | skip | pedigree |
|---|---|---|---|---|---|---|
| 1 | **Bundle Labels** | Sort · Date Format | Bundle · Group | By Group, then by Bundle, then by Cable · By Box, then by Bundle, then by Cable · By Bundle, then by Cable | on the third sort | (b) script 218; layouts 266, 173; value list 48. Shared sort key: ruling 5 |
| 2 | **Tail Folder Labels** | none | Cable Model | none (Cable Model asc) | **always** | (b) scripts 719, 728; layout 340 |
| 3 | **Steck Labels** | Sort · Model before name (the shared project setting, R-37) · v1's Recommendations text | Cable · Device (Rack) · Group · Model · Bundle · Method · Category · End · Print List | By Device, then by Cable · By Group, then by Cable · By Cable | on By Cable | (b) script 397; layouts 269, 263; value list 49 |
| 4 | **Equipment Labels** | Sort · Max # Label Sets (ruling 3) | Description · Group · Category · Model | By Group, then by Model, then by Description · By Description | on By Description | (b) script 464; layouts 281, 280; value list 51 |
| 5 | **Group Parts** | none | Method · Category · Group | none (script 15's fixed sort) | no | (b) scripts 12, 6, 15; layout 19; `260829-1735_v1_search-method_options-screen.png` |
| 6 | **Device Patch** | none | Device · Group | none (script 750's fixed sort) | no | (b) script 750; layout 351 |
| 7 | **Line List** | none | Mult · Model · Method · Group | none (script 67's fixed sort) | no | (b) script 67; layout 260 |
| — | Bundle Summary | **no screen** | — | — | — | (b) script 360 |

**Legends, verbatim from v1:** *Which Bundles?* · *Which Cables?* · *What Equipment Labels?* ·
*Which equipment?* · *Which Devices?* · *Which Mults?* — each *"(Leaving this blank will show all
…)"*.

**Proposals (c) — they stand unless struck:**

- **(c1) Tail Folder's legend says "cable models", not v1's "groups".** Layout 340 reads *"Which
  Cable Models? (Leaving this blank will show all groups.)"* — a v1 slip.
- **(c2) Bundle Labels shows no "Model before name".** Layout 266 carries it because Bundle Sheet
  shares the layout, but script 218 never reads it and the label prints no cable.
- **(c3) Label the two fields v1 left bare:** Bundle Labels' second field "Group" (layout 173,
  left 156) and Steck's Source/Destination field "End" (layout 263, left 818).
- **(c4) Exact Matches becomes the *is exactly* operator** on Steck and Equipment Labels, not a
  checkbox (R-23's own wording, above).
- **(c5) Max # Label Sets, if kept, is one field for the run**, not one per find request as in
  layout 280. Blank = all labels.

**What the operator must know to get a correct sheet: nothing.** Every default prints everything,
in v1's first sort, with no skip.

---

## 5 · THE SKIP-N OFFSET, SPECIFIED ONCE

**Reuse `SkipLabelsDialog.tsx` as it is; add one line.** Reason: it is already v1's script 83
verbatim (R-24), already on four shipped surfaces, and v1 has exactly one control for this —
replacing it would change four pages to fix nothing.

- **What it counts:** sticker cells on the output's die, **in the order that output fills them.**
  v1's mechanism is N blank records that sort to the head of the run (script 83 creates them;
  the sort fields `isblank` are `not (MULT = "")` and kin, so a blank sorts first ascending —
  DDR field calcs). v2's `applySkip` (`cableLabels.ts:135-138`) does the same: N blanks lead.
- **When it shows:** on GO, only where §4 says — the v1 branches that call `Add Blank Records`
  (scripts 218, 397, 464, 719). Shipped precedent: `CableLabelsPrintClient.tsx:368-371` fires it
  only on By Cable.
- **Default and reset:** **0, every run** — v1 script 83's first step is `Set Field [Add Blanks; 0]`;
  v2 is `defaultValue={0}`. No cap (v1 has none).
- **The hint line (ruling 1):** under the input, live as you type — *"First label prints on:
  column 1, row 4"*, and *"… on sheet 2"* once N reaches a full sheet. Computed from the **same**
  grid and fill the renderer uses (`cableGeometry.ts:412-416`, `cableCellSlot`), so it can never
  disagree with the paper. **It lands on all four shipped surfaces too**, which carry the same
  trap today (Cable Labels flows column-major, `CableLabelsPrintClient.tsx:91-98`).
- **(c6) Cancel keeps v2's shipped behaviour:** close the box and stay on the screen, nothing
  printed. v1's Cancel prints with zero skipped (script 83 never reads the button). A wasted
  sheet is the worse outcome.
- **(c7) The input label gains v1's colon:** *"Number of labels to skip:"* (script 83); v2 omits it.

**What the 5167 print settles here — named, slots left open.** The Ledger never lists the three
questions by name. The trail I can find is: the die-against-stock check owed since STOCK-IS-DIE
(2026-08-31, *"the only unrun acceptance on a SHIPPED unit"*); the Urbanist vertical shift of ink
inside a cell (`drafts/260917-1330_font-urbanist_ADDENDUM.md`, OQ4); and cell-width headroom
(same file, §5). **Only the first touches this design:** whether, after a skip, the first Steck or
Equipment label sits on its sticker. **Left open:** the skip acceptance for those two layouts.
**Not open:** how the skip counts, which does not depend on the print.

---

## 6 · WHAT IT COSTS THE VISUAL GATE — measured

Measured from `scripts/visual-capture.mjs` at `fcdeb2a`: **28 frames = 14 surfaces × 2 themes**
(line 127; loop at 705).

- **No frame shows any print options or find screen.** The only print frame, **07**, is the
  equipment list *preview* after GO (lines 891-921). No frame opens the Cable tab (**13** opens
  Boxes, lines 1039-1044). **So the seven screens and the skip hint move no frame.**
- **Frame 01 moves.** It photographs the Equipment tab, where Group Parts, Device Patch and
  Equipment Labels render at 45% opacity (`MenuCard.tsx:50`; seen in
  `screenshots/baseline/01-project-menu-light.png`). Enabling them moves **01-light and 01-dark**.
  Under your order that is **two declared events, two frames each** — step 4 (Equipment Labels)
  and step 5 (Group Parts with Device Patch). The five Cable-tab buttons move nothing.
- **Proposed: no new frames.** Precedent: none of the eight shipped options screens has one.

---

## 7 · CRITIQUE · BLAST RADIUS

**[CRITIQUE]** Two find looks now sit on the Equipment tab — the column grid for Group Parts and
Device Patch, the R-23 rows for Equipment Labels — chosen by pedigree, not by eye; if that
reads wrong on screen, putting Equipment Labels on the grid with an Exact checkbox is the
fallback. And the fill-order evidence is three sheets of four; Steck's is still unmeasured.

**[BLAST RADIUS]** Device Patch needs the equipment find grid to take other columns, and that
grid is unguarded by the gate (frame 07 photographs the preview, not the find), so your browser
gate on the Equipment List print's find is the only check against a regression there.

---

## 8 · FOR THE MAIN LINE — stated, not acted on

1. **"Six" should read "seven"** in the opener, Roadmap v4.45 (PAPERWORK), the Ledger's
   LAYOUT-FINDSCREEN row and the order ruling's reason for Line List (§3.2 item 1).
2. **Equipment Labels' field list** in the August design and LAYOUT-EQUIPLABELS drops Label ID
   (§3.2 item 2).
3. **OQ9 (a) is ruled and unbuilt on every box page** — a ruled-but-missing item whatever ruling 6
   says.
4. **Two sources of truth for one sheet:** `CABLE_GRID.smallCable` says `fill: 'row'`
   (`cableGeometry.ts:220`) while the Cable Labels client flows column-major on its own
   (`CableLabelsPrintClient.tsx:91-98`, and line 77 says its y axis is not wired to the grid). The
   skip hint must read what the renderer does; the build handoff should name one.
5. **Tail Folder Labels on 5160** (ruling 4) adds a fifth output to STOCK-IS-DIE's list.
6. **Bundle Labels' measured sheet was the By Box sort** — box headings (`No Box`, `201 FOH Runs`)
   take cells in the column flow. That likely explains the August "four to six blank cells a page";
   a parity-pass question, not this one.
7. **Box Labels fires the skip on every GO** (`BoxLabelsPrintClient.tsx:369`), unlike Cable Labels.
   Whether that matches v1's box scripts was not checked; out of scope here.

*End of design. No CC handoff, no schema, no migration, no governing document edited, nothing
written to the code repo. Copies: `handoffs/parallel/` and `drafts/`.*
