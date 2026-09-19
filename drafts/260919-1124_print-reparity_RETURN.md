# 260919-1124 · PRINT-REPARITY · RETURN (parallel Arch session — analysis only)

*Parallel scope: PRINT-REPARITY, cable and box prints, v1 against v2. No CC handoff issued, no schema or SQL writes, no governing-document edits, nothing written to the code repo, git never run. Test show only: JOY (`daniel+test01@`, project `b04ab9b5…`, created 2026-09-19 14:33 UTC). Buena Vista Social Club was not printed, probed or queried; its July v1 arbiter PDFs already on file were read for geometry only.*

**Session open: passes.** HEAD `4fe0af9` = origin/main (read from the ref files), no `index.lock`, migration ledger 79 live (latest `20260919144200`), all three mounts reachable.

---

## 0 · RULED by Daniel, 2026-09-19 (added 11:41 ET, after the first send) — his words, verbatim

> "1. make small cable labels match v1, please
> 2. sort as number approved
> 3. follow v1 page break
> 4. follow v1's resizing rules"

What each settles, and the assumption I made where his line stops short. **Each assumption is one word to correct.**

| # | Settles | Carried into | Assumption, named |
|---|---|---|---|
| **R1** | Small Cable Labels go to v1: rows start at 36.00, every heading is one 36.00 row, and everything inside the sticker (chip, name centre, location, hairline, text edges, no "(Not in Bundles)") is v1's. The fence comment in `CableLabelsPrintClient.tsx:77-82` is retired. | Handoff A | **The column positions stay on the Avery cut** (20.25 + 148.50, STOCK-IS-DIE). v1's own columns sit up to 9.46 pt off that cut, and "match v1" read literally would put that error back. Inside each sticker it is v1 exactly. |
| **R2** | v2's number-aware order stands: `6-Pair, 12-Pair, 19-Pair`; `RG6` before `RG59`; `A Bass DI` before `A2 KVM`. It is a **named divergence** from v1 and must be written into the source with its date, so nobody "fixes" it back from the artifact. | Handoffs A, B, C | **The blank group stays last**, as v2 has it, in line with the 2026-09-18 ruling *"blank should sort after anything with a value"* — but it gets v1's `Not Grouped` label. |
| **R3** | Cable Checklist: a new page for each group, the group in the page title, and the "Not in Bundles" band in every group that has loose cables. Tail Checklist by model: one model per page run, model in the title. Grouped Small Cable Labels: each group starts a new column, as v1. The "continuous flow" comment in `CableChecklistPrintClient.tsx:3-10` is retired. | Handoffs A, C | **The tail LABEL sheets keep the 2026-08-30 ruling** (a model section starts a page, where v1 starts a column). R3 was asked about the two checklists; say "tails too" if it was meant wider. |
| **R4** | v2 follows how v1 rows grow and shrink. The rules are measured in §4.10. The headline: **a long Bundle Summary name wraps and the row grows**, where v2 cuts it off (`SD Preview:The Seque`). This replaces the 2026-09-18 "(c) choice, stays truncated", made when no v1 example existed. | Handoff C; PAPERWORK | **The 33.4 / 34.4 base row is not a resizing rule.** It is a fixed 1.00 pt layout difference between your two v1 files (the Tested box sits at 17.62 in JOY, 18.62 in BVSC; all text identical). v2 stays at 34.5, BVSC's. |

---

## 1 · Daniel — where this lands

**One line: the labels that were measured in August still hold, the three shop documents were never measured and are visibly off everywhere, and two label sheets have problems that would waste stock tomorrow.**

- **Hold up well (pass):** Tail Panel Labels, the Tail Line label cells, the Small Tail Block label cells, the Line List, and the Bundle Summary's columns. Every object is within three-quarters of a point of v1.
- **Would waste label stock:**
  - **Small Cable Labels print 12 points too low on the sheet.** On 36-point stickers that puts the bottom line of each label onto the sticker below. On the grouped version, about one label in eight is off by a further 14 to 27 points, because the group headings are not a full sticker tall.
  - **"By model" on the tail labels does not sort by model.** It sorts by cable name and then starts a new page every time the model changes. JOY's Small Tail Block Labels come out as **14 sheets where v1 uses 2**; Tail Line Labels as 40 pages against 26.
- **Never brought to parity (whole document is off):** the **Cable Checklist**, the **Tail Checklist** and the **Bundle Sheet**. Headers sit 11 to 27 points high, footers 13 to 33 points low, columns are 10 to 37 points from v1's, the tick boxes are 8.25 points where v1's are 12, rows are tighter, and v1's per-group page breaks are gone. These are the same shared header and footer that measured wrong on 2026-09-18. The fix pattern already exists from that day's Bundle Summary work.
- **The project logo is missing from every v2 cable document.** JOY has a top-right logo stored in v2; v1 prints it on all five documents; v2 prints it on none.
- **Not measured: the whole box family.** The archive you attached has no box prints, so the box labels, Box List and Contents List are listed, not measured. The staged August box fixes are carried forward unchanged.
- **Found on the way, and it is not a print problem:** the import left **13 tails with no cable**. Forty JOY cable names end in a space; v1 still matches tails to them, v2 does not. Four multicore cables lose their tails on every v2 print, and their Line List pages vanish (79 pages against 84). That belongs to the main line's import work, not to this unit.

**Cost:** three CC units for the cable family (labels, tail sort, documents), one held for the box family until a box pair exists. The four rulings I asked for are answered and recorded in §0.

**Next step:** correct any of the four assumptions in §0 in a word. The one thing I need from you to finish the job is a matched **box** pair from the same fresh JOY.

---

## 2 · Proposed changes, layout by layout

Plain words. The measurements behind each line are in §4. "v1" means today's JOY FileMaker print.

### Small Cable Labels (both sorts)
1. Move every label row up 12 points so row 1 starts at the top of the first sticker, as v1 and the other two Avery 5167 sheets already do.
2. Make every group, bundle and model heading exactly one sticker tall, so labels under a heading stay on the sticker rows (v1 does; v2's headings are 14, 21 and 27 points).
3. Make the colour chip v1's size and position: full width from the sticker's left edge, 131 × 14 points, not the narrower centred chip.
4. Centre the cable name where v1 centres it (6 points left of where v2 has it).
5. Pull the bottom line of text in from the right: on the fourth column v2's text ends 3 points from the paper's edge, inside most printers' unprintable margin.
6. Drop the words "(Not in Bundles)" from each loose cable's label. v1 prints nothing there.
7. Move the "@ location" line down 4 points to v1's position.
8. Restore v1's grey hairline above the bottom line of text.
9. Put the page title where v1 has it (v2's is 41 points to the left) and match the small "Printed / Page" lines.
10. On the grouped sort, start each group in a new column, as v1 does (ruled R3), and label the blank group "Not Grouped". It stays last, and the order stays v2's number-aware order (ruled R2).
11. On the grouped sort, show "(Not in Bundles)" in grey under the group name, as v1 does. v2 prints the group's name a second time, underlined.

### Tail Line Labels
1. Make "By Cable Model, then by Cable" actually sort by model. One cause, in the code: the list is sorted by model and then every builder re-sorts it by cable name.
2. Give this sheet the "Include / Don't Include Small Tail Block Label" choice. v1 offers it here; v2 shows it on the Small Tail Block sheet instead, where it makes no sense, and always includes the blocks here.
3. Nothing inside the labels changes. Block cell, line cell, model marker and page header all match v1 to within 0.9 points.

### Small Tail Block Labels
1. Same sort fix as above. That alone takes JOY from 14 sheets back to 3 (one per model, by your 2026-08-30 page-break ruling) or 2 (v1's behaviour).
2. Nothing inside the labels changes.

### Tail Panel Labels
1. No change. 258 text objects over both pages and 234 rules on page 1; the worst is 0.88 points.

### Cable Checklist
1. Give it v1's own header and footer positions, the way the Bundle Summary got them on 2026-09-18: header down 11 to 14 points, footer up 30 to 33, footer ink black.
2. Print the project logo top right.
3. Start each group on a new page with the group in the page title (ruled R3: "follow v1 page break").
4. Treat `Vor` and `vor` as one group. v2 prints "Group: Vor", "Group: vor", "Group: Vor" as three sections.
5. Put loose cables under a grey "Not in Bundles" band, as v1 does in every group. v2 never prints it on JOY.
6. Rebuild the row to v1's columns: model at 236, Female at 321, Male at 435 (v2 is 19, 35 and 37 points left of those).
7. Make the three tick boxes 12 × 12 at v1's positions (v2's are 8.25 × 8.25).
8. Stop wrapping cable names at about 100 points. v1 gives the name 209 points and never wraps these; v2 wraps "nFS Anntenna Ext." and drops the second line 3 points to the left.
9. Tail lines at v1's 15-point spacing with the grey hairline under each (v2: 12 points, no hairline).
10. Rebuild the bundle band: 36 points tall, bundle length right-aligned at 234, Flagged / Not Flagged at fixed positions, 12-point Bundled/Tested boxes. In v2 the Flagged text floats after the name, so it starts in a different place on every band.
11. Pink end tint hugs the word, as v1's does, not the whole cell.

### Tail Checklist (both sorts)
1. v1's header and footer positions; logo.
2. "Pulled/Labeled" caption above the header rule, not below it.
3. Tail text at v1's 294 (v2 is 16 points left); tick boxes 12 × 12 at 687 and 709 (v2's are 8.25 at 738 and 754).
4. Name column as wide as v1's. v2 wraps "Aviom Trunk 1"; v1 does not.
5. Rules: grey hairline between a cable's two tails, trim-colour rule between cables. v2 draws every rule the same.
6. By model: one model per page run, with the model in the page title. v2 runs three models onto one page with a stray left-aligned title in the middle, and the last page's title loses its colon.
7. Model order stays v2's: 6-Pair, 12-Pair, 19-Pair (ruled R2: "sort as number approved").

### Bundle Sheet
1. v1's header and footer positions, "Tape Here, Please" line included; logo.
2. v1's sheet is 706 points wide and leaves the right 59 points empty. v2 stretches to the full page, which moves every column. Rebuild to v1's width.
3. Put "Flagged: Booth" over the flagged (pink) column. **In v2 it sits over the other column**, 117 points to the right, so the sheet reads as if the wrong end were flagged.
4. Print the box number: v1 "Box: 3 Ampland", v2 "Box: Ampland".
5. Bundle name and length at 48 points (v2: 45 and 46). Rule under them is v1's 1-point trim colour, not 2.25-point black.
6. Rows at v1's 28-point spacing (v2: 22.5), 12 × 12 tick boxes (v2: 8.25), v1's column positions.
7. Title in Arial Bold as v1 has it (v2 uses Century Gothic Bold).
8. Model order inside a bundle stays v2's: RG6 before RG59 (ruled R2).

### Bundle Summary and Line List (PAPERWORK's two, re-checked on JOY because you printed them)
1. Add the logo. Nothing else on the Line List: 77 of 79 pages match object for object; the other two differ only because v2's tails differ (the import finding).
2. Bundle Summary: a name too long for its column wraps onto a second line and the row grows 9 points, as v1 does (ruled R4: "follow v1's resizing rules"). v2 cuts it off today.
3. Bundle Summary: paint the Not Flagged end's colour chip. v1 does on 12 of JOY's 26 rows; v2 never does.
4. Line List: a multicore with no tails prints no tail rows in v1. v2 prints the cable type's default tails instead.
5. The 33.4 / 34.4 row height is a fixed difference between your two v1 files, not a resizing rule. v2 stays at BVSC's.

### Box labels, Box List, Contents List
1. Not measured — no box prints in the archive. The four staged residuals stand as written on 2026-08-26 (§5, handoff D).

---

## 3 · Evidence, and which pairs are matched

**Source:** `Archive 16.zip`, attached to this session by Daniel. 26 PDFs, counted at source: 14 v1 (FileMaker Pro Advanced 17.0.1) and 12 v2 (Chrome 152 Save-as-PDF, Skia). **Filed, renamed to convention, at** `~/Minotaur_v1_exports/parity-pairs/260919_print-reparity/` — 26 written, 0 rejected. All v2 prints are 100 % scale: document content spans 27.00–585.00, which is the design's 36 px margin.

| Pair | Pages v1 / v2 | Layout | Data | Sort / options | Status |
|---|---|---|---|---|---|
| Cable Checklist by group | 33 / 23 | same | same, less the orphaned tails | same nominal sort | **measured** |
| Tail Checklist by cable | 6 / 6 | same | same, less 3 cables' tails | same | **measured** |
| Tail Checklist by model | 9 / 7 | same | same | same nominal sort; order differs (R2) | **measured** |
| Bundle Sheets by group, model before name | 26 / 26 | same | same | same nominal sort; order differs (R2) | **measured** |
| Small Cable Labels by cable | 12 / 12 | same | v1 870 names, v2 842 | same | **measured** |
| Small Cable Labels by group, model, break | 19 / 14 | same | same | **"break" not verified on the v2 side** — the saved setting reads `cableLabelsBreakBetweenModels: false` after the run | cells measured; column flow **listed, not measured** |
| Tail Line Labels by model | 26 / 40 | same | same | v1 "include"; v2 always includes | **measured** |
| Tail Line Labels by cable | 17 / 28 | same | same | **v1 printed without block labels, v2 with** | line cells measured; flow **listed, not measured** |
| Small Tail Block Labels | 2 / 14 | same | same | both by model | **measured** |
| Tail Panel Labels | 2 / 2 | same | same | same | **measured** |
| Bundle Summary | 2 / 2 | same | same | same | re-checked (PAPERWORK's) |
| Mult Line List | 84 / 79 | same | 5 mults missing in v2 | same | re-checked (PAPERWORK's) |
| Bundle Labels by group | 2 / — | — | — | — | **v1 only — listed, not measured** |
| Steck Labels | 19 / — | — | — | — | **v1 only — listed, not measured** |
| Big Box Labels, Small Box Labels, Replacement Numbers, Box List, Contents List | — / — | — | — | — | **no pair supplied — not measured** |

**Two things every reader of these numbers needs:**
- v1's PDFs carry hidden checkbox values as ArialMT `1` text beside each tick box. They do not render. They are excluded from every comparison.
- **The palette is closed** (Ledger, 2026-08-26: *"These are product-wide colours in v2, so they shouldn't have their own hard-coded table."*). v1 orange `#FD9A00` against v2 `#EEA036`, purple `#AE00F0` / `#AF1F7B`, yellow, green and red are ruled drift and are **not findings**. The one open colour is the staged `BUNDLE_FLAG` revert (`#FED1CF` v1, `#FDD1CF` v2), re-measured today on five documents with zero variance.

---

## 4 · Tables. Δ = v2 − v1, in points. ✅ within 0.75 · quantum = Chrome's 0.75 pt paint grid · ❌ finding

### 4.1 Cable Checklist — v1 p1/p6, v2 p1/p2 (`…cable-checklist-by-group…`)

The BVSC July arbiter (`cable-box/Cable PDFs/Cable Checklist by Group.pdf` p1) has **the same geometry as today's JOY v1 to the hundredth** on every object below, so this is not a JOY quirk.

| Object | v1 | v2 | Δ | Verdict |
|---|---|---|---|---|
| Project name top / x | 27.89 / 26.99 | 16.84 / 27.00 | **−11.05** / 0.01 | ❌ chrome |
| Venue top | 48.47 | 34.89 | **−13.58** | ❌ |
| Title top / centre x | 66.91 / 306.41 | 54.34 / 305.99 | **−12.57** / −0.42 | ❌ / ✅ |
| Title underline y, weight | 80.00, 1.00 | 66.38, 0.75 | **−13.62**, quantum | ❌ |
| Header rule y / weight / span | 82.50 / 1.00 / 27–586 | 74.25 / 1.50 / 27–585 | **−8.25** / +0.50 / −1.00 | ❌ |
| Logo, top right | 171.6 × 34.0 at x 409.98, y 24.98 | absent | — | ❌ |
| Footer rule y / weight / span | 726.70 / 1.00 / 27–588 | 760.12 / 0.75 / 27–585 | **+33.42** / quantum / −3.00 | ❌ |
| Footer date top / x | 736.28 / 27.00 | 766.20 / 27.00 | **+29.92** / 0.00 | ❌ |
| Page number top / right edge | 736.48 / 584.96 | 766.20 / 585.00 | **+29.72** / +0.04 | ❌ / ✅ |
| Footer ink | black | #444444 | — | ❌ |
| Fonts, sizes, weights | CG, CG-Bold, CG-BoldItalic, CG-Italic at 6 / 8 / 10 / 12 / 14 | same | — | ✅ (except next row) |
| "Bundled/Tested:" face | Arial-Bold 10 | CG-Bold 10 | — | ❌ |
| Group heading | in the page title; new page per group | "Group: x" 14 pt underlined, in the flow | — | ❌ R3 |
| Blank group | first, title "Cable Checklist for Group:" | last, "Group:" | — | R2 |
| `Vor` / `vor` | one group | three sections on p19 | — | ❌ |
| "Not in Bundles" band | 15 bands | 0 | — | ❌ |
| Band fill span / height / colour | 26–586 / 36.00 / #D6D6D6 | 27–585 / 48.75 / #D9D9D9 | **+12.75** tall | ❌ |
| Band top rule / bottom rule | 2.00 / 1.00 at +37.5 | 1.50 / none | — | ❌ |
| Bundle name x, size | 27.00, 14 underlined | 31.50, 14 underlined | **+4.50** | ❌ |
| Bundle length | right-aligned at 234.00 | follows the name, 10.5 gap | floats | ❌ |
| "Flagged:" x / value x | 288.20 / 333.00 | 142.09 / 189.91 on `Ampland`, 169.23 / 217.05 on `Ampland Ext.` | **floats** | ❌ |
| Flag chip | 286–332 × 15.00, behind the label | 187.5–220.5 × 12.00, behind the value | — | ❌ |
| Bundled/Tested boxes (outer) | 12 × 12 at x 552, 572 | 7.50 × 7.50 at 562.50, 573.00 | **−4.50** size | ❌ |
| "Pulled/Labeled/Tested" x | 495.00–582.13 | 493.35–580.50 | −1.65 | ❌ small |
| Cable name x | 27.00 | 30.00 | **+3.00** | ❌ |
| Name chip | from 26.00, 17.00 tall, name end + 2.4 | from 27.00, 15.00 tall, name end + 2.8 | −2.00 tall | ❌ |
| Name wrap | none up to 236 (209 pt) | wraps at about 100 pt; line 2 at x 27.00 | — | ❌ |
| Model line x | 236.00 | 216.71 | **−19.29** | ❌ |
| "Female:" x | 321.00 | 285.91 | **−35.09** | ❌ |
| "Male:" x | 435.00 | 397.51 | **−37.49** | ❌ |
| End tint | 320–354 × 12.00 (hugs the label) | 283.5–395.25 × 13.50 (whole cell) | — | ❌ |
| Row tick boxes (outer) | 12 × 12, 1.00 pt, at x 534 / 552 / 570 | 8.25 × 8.25, 0.75 pt, at 551.25 / 564.00 / 576.75 | **−3.75** size, +17.25 / +12.00 / +6.75 x | ❌ |
| Tail label x | 35.00 | 34.50 | −0.50 | ✅ |
| First tail below name top | 18.40 | 16.63 | −1.77 | ❌ |
| Tail pitch | 15.00 | 12.00 | **−3.00** | ❌ |
| Tail hairline | 0.50 pt #D6D6D6, 25.4–584.9, under each tail | none | — | ❌ |
| "@ location" 6 pt | gap 2.31 | gap 1.67 | −0.64 | ✅ |
| Row rule weight / span | 0.50 / 26.4–586.9 | 0.75 / 27–585 | quantum / −1.90 right | ✅ / ❌ small |
| Row pitch, no tails | 25.39 | 23.25 | **−2.14** | ❌ |
| Row pitch, two tails | 55.38 | 47.25 | **−8.13** | ❌ |
| Pages | 33 | 23 | — | follows from the above |

### 4.2 Bundle Sheet — p1 both (`…bundle-sheets-by-group-model-before-name…`)

| Object | v1 | v2 | Δ | Verdict |
|---|---|---|---|---|
| "Tape Here, Please" top / centre x | 39.50 / 377.44 | 17.64 / 396.00 | **−21.86** / **+18.56** | ❌ |
| Tape rule | y 54.50, 26–733, 1.00, #ADADAD | y 33.38, 27–765, 0.75 dashed (2.25 on / 1.5 off), #BBBBBB | **−21.12** | ❌ · v1's dash array not read (OQ-4's box cut rule measured 3.005 / 3.005) |
| Project name top | 61.94 | 37.09 | **−24.85** | ❌ |
| Venue top | 82.53 | 55.14 | **−27.39** | ❌ |
| Title top / centre / face | 87.94 / 378.95 / Arial-Bold 14 | 74.59 / 395.99 / CG-Bold 14 | **−13.35** / **+17.04** / face | ❌ |
| Header rule y / weight / span | 102.50 / 1.00 / 28–733 | 94.50 / 1.50 / 27–765 | **−8.00** / +0.50 / **+32** right | ❌ |
| Logo | 171.6 × 34.0 at x 556.98, y 60.00 | absent | — | ❌ |
| Sheet width | content 24–733 | 27–765 | **+32** right | ❌ root of the column Δs |
| Bundle name | Arial-Bold **48**, top 113.08, x 27.00 | Arial-Bold **45**, top 103.29, x 27.00 | **−3 pt** size | ❌ |
| Length | CG-Bold **48**, right edge 728.98 | CG-Bold **46**, right edge 764.99 | **−2 pt** size, **+36.01** | ❌ |
| Rule under the name | y 157.50, 1.00, trim colour | y 148.88, **2.25, black** | — | ❌ |
| "Group:" x / "Box:" x | 35.00 / 180.00 | 27.00 / 248.39 | −8.00 / **+68.39** | ❌ |
| Box value | `3 Ampland` | `Ampland` | number dropped | ❌ |
| "Cables:" right edge | 729.00 | 764.99 | +35.99 | ❌ |
| "Flagged: Booth" x | 392.97, over the pink column | 509.67, over the other column | **+116.70** | ❌ **reads wrong** |
| Pink column | 391.97–512.97 (121.00), continuous from y 166 | 381.00–507.00 (126.00), from y 174.75 | −10.97 / +5.00 wide | ❌ |
| Column heads: Cable / Model | 35.00 / 276.00 | 27.00 / 248.39 | −8.00 / **−27.61** | ❌ |
| Head rule | y 201.50, 1.00 | y 193.50, 1.50 | — | ❌ |
| Cable name x / chip | 35.00 / from 34.00, 17.00 tall | 30.00 / from 27.00, 15.00 tall | −5.00 | ❌ |
| Model x | 276.00 | 248.39 | **−27.61** | ❌ |
| End 1 x / End 2 x | 393.00 / 527.00 | 382.72 / 508.17 | **−10.28** / **−18.83** | ❌ |
| Tick boxes (outer) | 12 × 12 at x 653, 702 (Labeled box sits 2.00 lower) | 8.25 × 8.25 at 661.50, 727.50 | **−3.75** size | ❌ |
| Row pitch / rule weight | 28.00 / 1.00 | 22.50 / 0.75 | **−5.50** / quantum | ❌ / ✅ |
| Footer rule y | 567.50 | 580.12 | **+12.62** | ❌ |
| Footer date top / x · page right edge | 572.08 / 25.00 · 730.96 | 586.20 / 27.00 · 765.00 | **+14.12** / +2.00 · +34.04 | ❌ |
| Order of cables in a bundle | Ethercon, **RG59, RG6** | Ethercon, **RG6, RG59** | 4 of 26 sheets differ | R2 |
| Bundle order, one bundle per page | same 26 | same 26 | — | ✅ |
| Double spaces in a name | kept: `Ampland  Ext.` prints with a 26.6 pt gap | collapsed to one space (12.5) | — | small; HTML collapses runs of spaces. **Correction to the first send: v1 does NOT clip long names here — that reading was my word-grouping, not v1.** |

### 4.3 Tail Checklist — by cable p1, by model p1/p9 (v1), p4/p6/p7 (v2)

| Object | v1 | v2 | Δ | Verdict |
|---|---|---|---|---|
| Project name / venue / title tops | 27.89 / 48.47 / 66.89 | 16.84 / 34.89 / 54.34 | **−11.05 / −13.58 / −12.55** | ❌ chrome |
| Title centre x | 377.94 | 395.99 | **+18.05** | ❌ |
| Header rule y / weight / span | 83.48 / 1.00 / 27–730 | 74.25 / 1.50 / 27–765 | **−9.23** / +0.50 / +35 | ❌ |
| "Pulled/Labeled" caption | top 74.64, above the rule, x 668.99–727.67 | top 78.52, below the rule, x 706.31–765.00 | +37.3 x | ❌ |
| Logo | 171.6 × 34.0 at x 556.98, y 26.00 | absent | — | ❌ |
| Name x / size | 28.99 / 16 bold | 30.00 / 16 bold | +1.01 | ❌ small |
| Name chip | from 27.99, 21.98 tall | from 27.00, 19.50 tall | −2.48 tall | ❌ |
| Name column before wrap | fits `Aviom Trunk 1` (108 pt), wraps `Ableton Midi to FOH` | wraps `Aviom Trunk 1` | narrower | ❌ |
| Wrapped-name line pitch / row height | 20.00 / 46.02 | 24.00 / 48.75 | +4.00 / +2.73 | ❌ |
| Tail label x (Female / Male) | 293.99 | 277.91 | **−16.08** | ❌ |
| Tail label x, blank end ("Tail:") | 296.78 | 277.91 | −18.87 | ❌ |
| "@ location" 8 pt gap | 5.7 | 2.2 | −3.5 | ❌ small |
| Tick boxes (outer) | 12 × 12 at x 686.99, 708.99 | 8.25 × 8.25 at 738.00, 753.75 | **−3.75** size | ❌ |
| Row pitch | 26.02 | 24.75 | **−1.27** | ❌ |
| Rule between a cable's two tails | 0.50, #D6D6D6, 25.39–728.90 | 0.75, trim colour, 27–765 | — | ❌ |
| Rule between cables | 1.00, trim, 28.28–731.28 | 0.75, trim, 27–765 | quantum | ✅ weight |
| Footer rule y / date top | 562.88 / 572.46 | 580.12 / 586.20 | **+17.24 / +13.74** | ❌ |
| By model: paging | one model per page run; model in the title | models run on; p4 carries three titles, one at x 27 mid-page | — | ❌ |
| By model: last title | `Tail Checklist:` (blank model) | `Tail Checklist` on p7 | colon lost | ❌ |
| By model: order | 12-Pair, 19-Pair, 6-Pair, blank | 6-Pair, 12-Pair, 19-Pair, blank | — | R2 |
| Rows | 101 | 101 | — | ✅ |

### 4.4 Small Cable Labels — by cable p2/p4 (v1), p1/p4 (v2); grouped, all pages

Column origins: v1 23.00 / 167.30 / 311.60 / 455.90 (pitch 144.30); v2 20.25 + 148.50 (the Avery 5167 cut). **The x origin is ruled** (`cableGeometry.ts`, STOCK-IS-DIE, recorded as Daniel's 2026-08-31 ruling; Ledger: *"parity for a label sheet is the Avery die, not v1's ink"*). So x is compared **inside the cell**, from each side's own origin. Rows: v1 36.00 + 36.00 n.

| Object | v1 | v2 | Δ | Verdict |
|---|---|---|---|---|
| **Row origin** | 36.00 (first chip top 37.43) | 48.00 (first chip top 49.50) | **+12.07** | ❌ **top finding** — Avery 5167's own top is 36.00, so v1 and the die agree here |
| Row pitch / rows | 36.00 / 20 | 36.00 / 20 | 0.00 | ✅ |
| Chips off the row phase (grouped sort) | 0 of 528 | **60 of 504** (56 by 27 pt, 4 others) | — | ❌ headings are 14 / 21 / 27 pt, not 36 |
| Chip in cell: x, w × h | 0.00, 131.04 × 13.97 | 14.25, 115.50 × 15.00 | **+14.25, −15.54** w | ❌ — `CABLE_CHIP.smallCable` already records 131.04 × 14.00, inset 0; the client does not use it |
| Chip top in cell | 1.43 | 1.50 | +0.07 | ✅ |
| Name centre in cell / top | 65.97 / 4.51 | 72.20 / 4.20 | **+6.23** / −0.31 | ❌ / ✅ |
| "@ location" top in cell | 22.68 | 18.57 | **−4.11** | ❌ |
| Hairline above the bottom text | 0.50, #DEDEDE, −0.25 → 131.29, at 27.93 | none | — | ❌ |
| Model / end text, right edge in cell | 124.95 | 142.92 | **+17.97** | ❌ |
| … on column 4, on the sheet | ends 580.85 | ends **608.67** of 612 | — | ❌ clips on a real printer |
| Model / end text top in cell | 28.68 or 30.11 | 26.82 | −1.86 / −3.29 | ❌ |
| Bundle name (italic) x / top in cell | 6.04 / 28.68 | 1.50 / 26.82 | −4.54 / −1.86 | ❌ |
| Loose cable | prints nothing | prints `(Not in Bundles)` | — | ❌ |
| Project name x / top | 25.00 / 21.50 | 27.00 / 17.64 | +2.00 / −3.86 | ❌ |
| Title centre x / underline y | 316.95 / 33.00 | 276.15 / 28.12 | **−40.80** / −4.88 | ❌ |
| "Printed" line | 6 pt, right edge 592.92, top 20.25 | 7 pt, right edge 584.99, top 21.54 | size +1 | ❌ |
| "Page N of M" top | 27.25 | 32.04 | +4.79 | ❌ |
| Fill direction | column-major | column-major | — | ✅ |
| Name order | `A2 KVM` before `A Bass DI` (spaces ignored) | `A Bass DI` before `A2 KVM` | — | R2 |
| Grouped: group start | new column; bold group name, grey `(Not in Bundles)` under it | runs on; group name printed twice, second underlined | — | ❌ |
| Grouped: blank group | first, labelled `Not Grouped` | last, unlabelled | — | ❌ / R2 |
| Grouped: heading stranded at a column foot | none | `19-Pair` at the foot of p1 column 1 | — | ❌ |
| Label count | 870 names | 842 | 11 names print two more labels in v1 (`Auto PRV`, `Deck PRV`, `Deck SM`, `LX Prv`, `LX/VID SM`, `Party Line`, `Sound PRV`, `Sound SM`, `Spot PRV`, `Spot SM`, `Vid PRV`); the rest is name wrapping | cause not established — likely v1's name-keyed links again (§7) |

### 4.5 Tail Line Labels — cells from both pairs; v1 origin 20.00 + 145.13, v2 20.25 + 148.50, rows 36 + 36 n both

| Object (in cell) | v1 | v2 | Δ | Verdict |
|---|---|---|---|---|
| Block chip x, w × h, top | 0.00, 131.04 × 17.28, 0.43 | 0.00, 131.25 × 17.25, 0.75 | ≤ 0.32 | ✅ quantum |
| Block name x / top, 14 pt | 30.02 / 4.34 | 30.00 / 4.09 | −0.02 / −0.25 | ✅ |
| "Female" / "Tails" 6 pt tops | 2.68 / 9.68 | 2.07 / 8.82 | −0.61 / −0.86 | quantum-scale; one pixel high |
| Line chip x, w × h, top | 34.00, 69.00 × 11.52, 1.00 | 33.75, 69.00 × 12.00, 0.75 | ≤ 0.48 | ✅ quantum |
| Line header 8 pt x / top | 43.30 / 3.66 | 43.30 / 3.52 | 0.00 / −0.14 | ✅ |
| Line name 10 pt centre / top | 65.99 / 14.31 | 65.96 / 13.95 | −0.03 / −0.36 | ✅ |
| "@ location" top / centre | 26.68 / 67.49 | 26.07 / 65.97 | −0.61 / −1.52 | ✅ / small |
| Model marker: chip, text, underline | 6.00–94.00 × 14.00; text 7.00, top 8.51; rule 18.43, 1.00 | 6.00–93.00 × 14.25; 7.00, 7.95; 18.38, 0.75 | ≤ 1.00 | ✅ quantum |
| Page header: name, title, Printed, Page | 22.00 / 22.50 · 261.70 · top 20.25 · top 27.25 | 22.00 / 22.14 · 261.66 · 20.07 · 26.82 | ≤ 0.43 | ✅ |
| Title underline y / weight | 34.00 / 1.00 | 32.62 / 0.75 | **−1.38** | ❌ small — the same one-pixel underline as PAPERWORK's OQ1, in the other direction |
| **"By model" order** | by model, then cable | **by cable name; page break at every model change** | 26 → 40 pages | ❌ **top finding** |
| Include block labels | an option on this sheet | always on; the option is on the other sheet | — | ❌ |

### 4.6 Small Tail Block Labels — v1 origin 20.00 + 146.33, v2 20.25 + 148.50

| Object (in cell) | v1 | v2 | Δ | Verdict |
|---|---|---|---|---|
| Chip, name 14 pt, name 10 pt (long names) | 0.06, 131.04 × 17.28 · 30.08 / 4.34 · 17.81 / 5.51 | 0.00, 131.25 × 17.25 · 30.00 / 4.09 · 17.79 / 4.95 | ≤ 0.56 | ✅ |
| "@ location" 8 pt top | 25.66 | 26.02 | +0.36 | ✅ |
| Model marker and caption | caption 3.68; chip 1.06–44.06 × 17.00; text top 12.93 | 3.57; 0.75–42.75 × 16.50; 13.14 | ≤ 1.31 | ✅ quantum-scale |
| Long name over "Female / Tails" | overlaps in v1 too | same | — | ✅ v1's own |
| Page header | 22.00 / 21.50 · 250.98 · rule 33.00 | 22.00 / 21.39 · 250.90 · rule 31.88 | ≤ 1.12 | ✅ / underline as above |
| **Order and paging** | 12-Pair, 19-Pair, 6-Pair; **2 pages** (44 + 59 labels) | cable-name order, page break at each model change; **14 pages**, p1 holds 2 labels | — | ❌ **top finding** |

### 4.7 Tail Panel Labels — both pages

| Measure | Result | Verdict |
|---|---|---|
| Text runs matched | 256 of 258 (the two unmatched are the differing "Printed" stamps) | ✅ |
| Δx median / range | −0.04 / −0.12 … +0.01 | ✅ |
| Δ top median / range | −0.39 / −0.88 … +0.14 | ✅ — only "Female" under the cable name reaches −0.88 (one pixel) |
| Fonts, sizes | 0 mismatches | ✅ |
| Rules (158 horizontal, 76 vertical on p1) | all within 0.75; weights 0.50 → 0.75 | ✅ quantum |
| Marker chip | 23–123 × 14 → 23.25–121.5 × 14 | −1.5 wide, ✅ quantum-scale |

### 4.8 Bundle Summary and Line List on JOY (PAPERWORK's — a re-gate, not this unit's work)

| Object | v1 JOY | v2 | Δ | Verdict |
|---|---|---|---|---|
| Bundle Summary: every label and value x | — | — | ≤ 0.06 | ✅ |
| Bundle Summary: header rule, first row | 82.50 | 82.88 | +0.38 | ✅ |
| Bundle Summary: row pitch | **33.40** (first row 36.28) | 34.50 (37.50) | **+1.10 a row, +17.0 by row 16** | R4 — the BVSC arbiter reads **34.40** (37.28) |
| Bundle Summary: rows on p1 | 18 | 18 | — | ✅ |
| Bundle Summary: mark boxes (outer) | 12 × 12 at 574–586 | 12 × 12 at 573.75–585.75, none clipped | −0.25 | ✅ |
| Bundle Summary: continuation title centre | 308.41 | 306.40 | −2.01 | ❌ small |
| Logo, both documents | present | absent | — | ❌ |
| Line List: 77 pages matched by mult | 4,135 text runs | — | all ≤ 0.75 | ✅ |
| Line List: `cTech Com`, `cSpot Shadow` | 4 tails / 0 tails in the header block | 2 tails / 2 tails | block height ±32 | data (§7), not layout |
| Line List: pages | 84 | 79 | 5 mults absent in v2 | data (§7) |

### 4.10 v1's resizing rules, measured (for R4). Where v2 already follows one, it says so.

| Document | v1 rule | Evidence | v2 today | Verdict |
|---|---|---|---|---|
| Bundle Summary | Row is fixed (33.40 JOY / 34.40 BVSC). **A name too long for its 145 pt column wraps at a word; line 2 sits 17.00 below line 1; the row grows by 9.00** (33.40 → 42.40). Nothing else in the row moves. | JOY v1 p1 `SD Preview:The` / `Sequel`, rule 586.38 → 628.78 | `whiteSpace: nowrap; overflow: hidden` (`BundleSummaryPrintClient.tsx:180`) — prints `SD Preview:The Seque` | ❌ → wrap and grow |
| Bundle Summary | Not Flagged value carries its end's colour chip, 10.00 tall, from x 329 | JOY v1: 12 chips; BVSC: 12 | **0 chips** — only the Flagged value is chipped (13 = 13) | ❌ PAPERWORK |
| Line List | Header block grows **16.00 per tail row**: first line number at 145.91 with no tails, 177.91 with two, 209.91 with four | JOY v1 pp. 32 / 1 / 34 | coded `tailPitch: 15.75`; two tails lands 178.09 (+0.18) | ✅ within quantum; four tails would land −0.32 |
| Line List | **A mult with no tails prints no tail rows** | JOY v1 p32 `cSpot Shadow` | prints `Female Tail: Clear-Com YC-36` / `Male Tail: …` — the cable TYPE's default tail, by design (`LineListPrintClient.tsx:140-141`) | ❌ PAPERWORK — v2 prints tails the cable does not have |
| Cable Checklist | Row = 25.39 + **15.00 per tail**; an end cell that wraps adds 10.00 and its tint grows 12 → 22; **names do not wrap** (209 pt column) | JOY v1 p6; BVSC p1 `Carp Office Com` | 23.25 + 12.00 per tail; names wrap at about 100 pt | ❌ Handoff C |
| Tail Checklist | Name wraps at a word inside about 125 pt; line pitch 20.00; row 26.02 → 46.02 | JOY v1 by-cable p1 | wraps sooner (about 100 pt); pitch 24.00; row 24.75 → 48.75 | ❌ Handoff C |
| Bundle Sheet | Bundle name is a fixed 48 pt and prints in full; row fixed 28.00 | JOY v1 pp. 2, 16, 18 | fixed 45 / 46 pt; row 22.50 | ❌ Handoff C |
| Small Tail Block, Tail Line block cell | Name drops 14 → 10 pt when long; overlaps "Female / Tails" past that | JOY v1 p2 | same, to 0.56 | ✅ |
| Small Cable Labels | Nothing resizes; every heading is one 36.00 row | grouped file, 528 chips on one phase | headings 14 / 21 / 27 | ❌ Handoff A |

### 4.9 Box family — not measured

No v1 or v2 box print came in the archive. Standing v1 arbiters are on file (`cable-box/Box PDFs/`, BVSC, July), but a BVSC-against-JOY pair is not a matched pair, and this session may not print BVSC.

---

## 5 · Findings, ranked by what a crew member would notice

1. **Small Cable Labels land a third of a sticker low** (+12.07 pt on a 36 pt row), and the bottom line of each label prints on the next sticker. Every sheet, both sorts. (§4.4)
2. **"By model" does not sort by model** on Tail Line and Small Tail Block labels: 14 sheets for 2, 40 pages for 26, and the model sections are shuffled. Root cause read at source: `TailLabelsPrintClient.tsx:213-225` sorts by model, then `cableLabels.ts:180 / 214 / 240 / 274` re-sort every run with `byParentThenEnd`. (§4.5, §4.6)
3. **Bundle Sheet: "Flagged: Booth" sits over the wrong column.** A shop reading it would flag the wrong end of the bundle. (§4.2)
4. **Grouped Small Cable Labels: one label in eight is off the sticker rows** because headings are not one sticker tall. (§4.4)
5. **Four multicore cables print with no tails, and five Line List pages are missing** — import, not print (§7). A crew member would see it on the Cable Checklist first.
6. **Small Cable Labels, column 4: text runs to 3.3 pt from the paper edge** and will clip. (§4.4)
7. **Tick boxes are 8.25 pt on all three documents** where v1's are 12. Hard to tick in the dark with a Sharpie.
8. **Cable Checklist groups run together**, `Vor` splits in three, and the "Not in Bundles" band is gone. (§4.1)
9. **Bundle Sheet loses the box number** ("Box: Ampland" for "Box: 3 Ampland"). (§4.2)
10. **Names wrap that v1 never wraps** — Cable Checklist at about 100 pt, Tail Checklist on `Aviom Trunk 1` — which makes rows taller and uneven. (§4.1, §4.3)
11. **No project logo on any cable document.** (§4.1–4.3, §4.8)
12. **Header, footer and column positions on the three documents**: 8 to 37 pt. Visible side by side, not to someone holding one sheet. (§4.1–4.3)
13. **Small Cable Labels print "(Not in Bundles)" on every loose label**; v1 prints nothing. (§4.4)
14. Footer ink grey (#444) for black; title faces on the Bundle Sheet; one-pixel title underlines. Nobody would notice; listed for completeness.

**Passes, for the record:** Tail Panel Labels; Tail Line and Small Tail Block label cells, markers and headers; the Line List; the Bundle Summary's x positions, header, boxes and rows per page.

---

## 6 · Rulings asked of Daniel — **all four answered 2026-09-19, see §0.** Kept as asked, for the record.

**R1 — Small Cable Labels rows: may the y axis move?** The code fences it off:
> "**The y axis is deliberately NOT wired.** `CABLE_GRID.smallCable` carries a 108.00 pt top and a 72.00 pt row pitch, measured off v1, where this output renders 20 rows at 36.00 pt under a compact header. STOCK-IS-DIE pins the cell ORIGIN'S X and nothing else, and moving the rows would change what this sheet renders — which its handoff puts out of scope." — `CableLabelsPrintClient.tsx:77-82`

Today's v1 print is the first 36-pt-row v1 artifact on file (the July arbiter was the "by Bundle" layout with 72 pt rows). It puts row 1 at **36.00**, which is also Avery 5167's published top, so v1 and the die agree and there is nothing to trade off. **Proposed (c → b): rows start at 36.00; headings are one row tall.** The proof only you can give is one printed sheet held against a real 5167 blank.

**R2 — Which order is right when text order and number order disagree?** v1 sorts as text and ignores spaces; v2 sorts numbers as numbers. Measured today:
- models: v1 `12-Pair, 19-Pair, 6-Pair` and `RG59, RG6`; v2 `6-Pair, 12-Pair, 19-Pair` and `RG6, RG59` (Tail Checklist, tail labels, Bundle Sheet — 4 of 26 sheets differ);
- names: v1 `A2 KVM` before `A Bass DI`; v2 the reverse (Small Cable Labels);
- blank group: v1 first and labelled `Not Grouped`; v2 last.

The BVSC arbiter's Tail Checklist by Model runs `12-Pair, 19-Pair, 6-Pair, CAT5…` too, so this is v1's behaviour, not JOY's. v2's order is arguably the better one for a person. **Two paths: (a) v1's order everywhere, so a v1 user finds things where they were; (b) keep v2's natural order and record it as a named divergence.** I lean (b) for models and names, (a) for the blank group, because `Not Grouped` first is where a shop looks for strays. Yours to call.

**R3 — Cable Checklist: a new page for each group?** The code header states a choice:
> "Continuous per-group flow: grey bundle bands; colour-filled name cells; … loose cables under the group title with the `Not in Bundles` sub-banner only in mixed groups" — `CableChecklistPrintClient.tsx:3-10`, citing P2/P3/P11/P12 and "Cable Checklist by Group.pdf p1/p31/p54"

Both v1 artifacts disagree with both halves. JOY: 15 groups (the blank one included), each starting a page, "Not in Bundles" in every group that has loose cables (15 bands), mixed or not. BVSC July arbiter: 27 groups over 54 pages, every group starting a page. I could not find P2/P3 quoted in your words. **If you ruled continuous flow, say so and it stands; if not, parity says one group per page and the band in every group.** Same question for the Tail Checklist by model, where the arbiter also runs one model per page.

**R4 — Bundle Summary row height: 33.4 or 34.4?** Your JOY file prints rows 33.40 pt tall; the BVSC file v2 was built from prints 34.40. v2 is 34.50. Both hold 18 rows a page. **Which v1 file carries the layout you consider current?** If it does not matter to you, I propose leaving v2 as it is and recording the 1-point spread as v1's own.

Already ruled, noted and not re-argued: the palette (closed 2026-08-26); the Avery x origin (STOCK-IS-DIE); a model section starting a page on the tail label sheets (recorded in `TailLabelsPrintClient.tsx:684-686` as "RULED (Daniel, 2026-08-30)"). **For the last two I found the record but not your words quoted; the main line should cite the Ledger lines when it issues.**

---

## 7 · Found on the way — for the main line, not this unit

**IMPORT: tails lose their cable when the cable's name ends in a space.**
- JOY in v2: 461 cables, 175 tails, **13 tails with `parent_cable_id` null** (read-only SELECTs on project `b04ab9b5…`).
- **40 cable names carry a trailing space.** Four are multicores — `Center Cluster Center `, `Drive B `, `iAmpland `, `Prosc SR Sub ` — and each has **0 tails in v2**; v1 prints two tails under each. That is 8 of the 13. The other 5 print in v1 under a nameless row in the blank group; v1's own strays.
- Consequences seen in print: those four lose their tails on the Cable Checklist; `Drive B`, `iAmpland` and `cPreview` vanish from the Tail Checklist; the Line List is 79 pages for 84.
- **`cPreview` appears in three v1 prints and nowhere in v2's cable table** (`ilike 'cPreview%'` returns nothing). Not explained.
- v1 also prints two more labels for each of 11 names (`Auto PRV`, `Deck PRV`, …) and lists 4 tails on `cTech Com`'s Line List page where v2 lists 2. v1 relates by name, so same-named cables share tails; v2 relates by id. That is v2 being right, but it changes counts a v1 user will compare.
- **End colours:** v1 prints the ends `SD Tech Table` and `Tech Com Rack` in Sand (`#E4BF8F`); v2 stores and prints them as `chartreuse` (`#B8D586`). Sand and Chartreuse are both exact palette matches, so this is a mapping difference in the import or in v1's own layout, not palette drift. Not resolved.

---

## 8 · Proposed CC handoffs — one per family, **NOT ISSUED**. The main line issues.

Every UX line below carries pedigree (b): an evidence file in `~/Minotaur_v1_exports/parity-pairs/260919_print-reparity/`, with the page. Anything resting on R1–R4 is marked.

**A · PRINT-REPARITY-LABELS — Small Cable Labels.** `Tier: CC · Session: FRESH`
- **RULED R1 (Daniel 2026-09-19: "make small cable labels match v1, please").** Row origin 36.00; every heading one 36.00 row. Column origins stay `AVERY_5167` (assumption named in §0). Evidence: `…v1_cable-labels-by-cable…` p4 (chip tops 37.43 + 36 n), `…v1_cable-labels-by-group-model-and-break…` all pages (528 chips, one phase).
- Chip from `CABLE_CHIP.smallCable` (131.04 × 14.00, inset 0) — the constant exists and is unused. Name centre 65.97; location top 22.68; hairline 0.50 #DEDEDE at 27.93; model text right edge 124.95; bundle name x 6.04; nothing printed for a loose cable. Evidence: same file, p2 cells `A GTR 1 DI 1`, `Apron FB 1`; p1 `A2 KVM Rec 1`.
- Header: title centre 316.95, name x 25.00 / top 21.50, "Printed" 6 pt. Evidence: p1.
- Grouped sort: group starts a column; `Not Grouped`; grey `(Not in Bundles)` under the group name. Evidence: grouped file p1. **Order: v2's, RULED R2 ("sort as number approved") — blank group last, labelled `Not Grouped`.** Column break per group: RULED R3.
- **Success:** on a JOY reprint, first chip top 37.43 ± 0.75; 0 chips off phase; column-4 ink ends ≤ 585; **then Daniel's sheet against a 5167 blank.**
- *Critique:* moves the y axis that an earlier handoff fenced; the fence comment must be rewritten, not deleted. *Blast radius:* Big Cable Labels share the client; pin them with a before/after.

**B · PRINT-REPARITY-TAILSORT — Tail Line and Small Tail Block Labels.** `Tier: CC · Session: FRESH`
- The model sort must survive the builders: either the builders take a comparator, or "by model" sorts inside them. Evidence: `…v1_small-tail-block-labels…` p1–2 (12-Pair, 19-Pair, 6-Pair; 44 + 59 labels), `…v1_tail-line-labels-by-model-include…` 26 pages. **Order of the models: number-aware, RULED R2** — so the success order is 6-Pair, 12-Pair, 19-Pair, with the divergence comment and its date in the source.
- Move "Include / Don't Include Small Tail Block Label" to the Tail Line sheet. Evidence: `…v1_tail-line-labels-by-cable…` (no block cells) against `…by-model-include…` (block cells). The v2 screen cites frame 040 — CC reads the frame before moving it.
- No geometry change: a regression test pins the cell numbers in §4.5 and §4.6.
- **Success:** JOY Small Tail Block ≤ 3 pages; Tail Line by model ≤ 27; one marker per model.
- *Critique:* smallest of the three and the biggest paper saving; nothing blocks issuing it first. *Blast radius:* Tail Panel uses the same sorted list (`panelBreaks`); it passed today and must pass again.

**C · PRINT-REPARITY-DOCS — Cable Checklist, Tail Checklist, Bundle Sheet.** `Tier: CC · Session: FRESH · the largest`
- Per-document chrome through `v1DocChrome.tsx`, the 2026-09-18 pattern; shared `DocHeader` / `DocFooter` stay untouched only if nothing else still uses them. Numbers: §4.1–4.3 chrome rows.
- Logo top right on all five cable documents, from `projects.top_right_image_url` (JOY has one). v1 box: 171.6 × 34.0; x 409.98 portrait, 556.98 landscape. **The July arbiter has no logo, so this case was never in evidence before today.**
- Rows, columns, boxes, rules, bands: §4.1–4.3, every ❌ row, each with its v1 number.
- Bundle Sheet: v1's 706 pt sheet width; "Flagged:" over the flagged column; box number.
- Group key case-insensitive. **Paging: v1's, RULED R3 ("follow v1 page break").** **Order: number-aware, RULED R2.** **Row growth: v1's, RULED R4 ("follow v1's resizing rules") — §4.10.**
- **Success:** the §4.1–4.3 tables re-measured on a JOY reprint, every row ≤ 0.75 or a named quantum; page counts 33 / 9 / 6 / 26 (R3 ruled to v1's paging; the counts hold only once the import's orphaned tails are fixed, so gate on rows per page, not totals).
- *Critique:* three documents in one unit is a lot; if CC's first checkpoint (chrome + logo on all three) runs long, split the Bundle Sheet out. *Blast radius:* `useMeasuredPages` pagination changes with every height; the PRINT-CLIP guard (no row lost off a page) must run on all three.

**D · PRINT-REPARITY-BOX — held.** Needs a matched JOY box pair. Carries, unchanged, `handoffs/_staging/260826-1845_print-parity-box-ADDENDUM-1_DRAFT.md`: the Stack underline (1.0 pt, text width, y 208.00) and the Header underline correction (1.5 pt at 213.00 → 1.0 at 214.00); the dashed grey cut rules (OQ-4: `#ADADAD`, 1.0 pt, dash 3.005 / 3.005, big label y 395.50, small sheet y 154.50 / 298.50 / 442.50 / 586.50) — **still your call whether v2 wants them**; Box-in-Box suppressing the Stack and its underline (your words, 2026-08-26: *"the stack field was filled in, then hidden when the box went in another box."*); and `MC.BUNDLE_FLAG` → `#FED1CF`. Also still owed and unmeasured today: OQ-3, OQ-5, the v1 continuation header, the cover-page body size, Box List and Contents List (BOX-DOC-PARITY).

**For PAPERWORK, not a new unit:** the logo on Bundle Summary and Line List; the Bundle Summary continuation title (−2.01); **R4 ruled — the long name wraps and the row grows 9.00 (§4.10)**; the missing Not Flagged colour chip (0 of 12); the Line List printing a cable type's default tails where the cable has none.

---

## 9 · Method, and what would change these numbers

- pdfplumber 0.11.9 on all 26 files; every word with face and size, every rule, fill and box with weight and colour; PyMuPDF renders for the eye only. Text runs matched by identical text in reading order; shapes by nearest neighbour. Label cells are compared from each side's own cell origin.
- v2's boxes are stroked paths; sizes quoted are the outer edge (path + 0.75). v1's are outer edges already.
- A residual under 0.75 pt is Chrome's paint grid and is called a quantum, not a finding. Rule weights 0.50 / 1.00 → 0.75 are the same (EQUIPLIST-RULE-QUANTUM).
- **v1 is not one layout.** Each show is its own FileMaker file. JOY and BVSC agree to the hundredth on the Cable Checklist and differ by 1.00 on the Bundle Summary's row. Where they agree I say so; where only JOY was read, the number is JOY's.
- v1's dash patterns were not read (pdfplumber does not report them); the Bundle Sheet's tape rule is dashed to the eye in both.
- Not checked: screen previews (this unit is print-to-PDF only); Big Cable Labels, Cable Folder Labels, Bundle Labels, Steck Labels, Balun Labels, Big Tail Block Labels, Tail Folder Labels — no v2 print supplied.

*End of return. Tracked copy: `drafts/260919-1124_print-reparity_RETURN.md`.*
