# PRINT-REPARITY-LABELS: Small Cable Labels to v1, Tail Panel sorts by model, and the equipment list's approved v1 differences

Tier: claude-opus-5
Model: claude-opus-5
Session: FRESH

*Arch, main line, 2026-09-19. Code is at `6a8f3d4`, which is `origin/main`. The migration ledger is **80**
and nothing is uncommitted from Arch. Read HEAD and origin from the ref files, and read the ledger live
(expect 80). Every line number below was read at `6a8f3d4` today. **Three members, one unit.** The bundle
was censused on Daniel's standing instruction to bundle small fixes: every member is ruled and cited.
Two items came out, with the reasons in §5.*

- **Part 1:** Small Cable Labels to v1. Source: `handoffs/parallel/260919-1124_print-reparity_RETURN.md`,
  §8 A, with the numbers in §4.4 and the rulings in §0.
- **Part 2:** Tail Panel "by model" gets the same sort fix that Tail Line and Small Tail Block got
  in `6a8f3d4`. Source: `handoffs/from-cc/260919-1320_revpair-tailsort.md`, OPEN QUESTIONS 6.
- **Part 3: EQUIP-PARITY-2**, the equipment list's approved differences. Source:
  `handoffs/parallel/260919-1105_revlist-regression_RETURN.md` §6 A.

**⚠ Every answer you need is in this file. There is no blank for anyone to fill in.**

## §0 · HARD STOPS

1. **No migrations and no SQL writes.** The equipment `address` in `v_equipment_list` and the
   print-settings column default belong to Arch, in a later migration. Do not work around the missing
   address.
2. **The column x origins stay on the Avery 5167 cut** (`AVERY_5167`, 20.25 + 148.50: STOCK-IS-DIE,
   Daniel 2026-08-31). Only the y axis and what sits inside each sticker move to v1.
3. **No tail label geometry changes.** Part 2 is order only. The §4.5–4.7 pins from `6a8f3d4` must pass
   unchanged.
4. **Test shows only**: JOY `b04ab9b5…` and the other `daniel+test01@` projects, or seeded throwaways.
   **Never Buena Vista Social Club.**
5. **Visual gate.** Frames may move only when they show a Small Cable Labels sheet or an equipment list
   print. Declare each one as this unit's baseline event, following `CLAUDE.md`. **If any other frame
   moves, stop.**
6. Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the handoff file's
   RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or
   describe it. Show every line."*
7. GATE-NOGREP. Commit only on Daniel's `COMMIT APPROVED: <first words>`, after his gate.

## §1 · Rulings of record

- **Daniel, 2026-09-19, on the cable comparison, verbatim:** *"1. make small cable labels match v1,
  please 2. sort as number approved 3. follow v1 page break 4. follow v1's resizing rules"*. Return §0
  says what each one settles (R1–R4).
- **Daniel, 2026-09-19, on the equipment list:** *"OK, revision fix and parity measures approved."*
  This covers the §6 A list of the revlist return. Items 1 and 12 shipped in `6a8f3d4`. Item 8 is out
  (§5).
- **Tail label sheets:** a model section starts a page. This is **ruled (Daniel, 2026-08-30)** and
  recorded at `TailLabelsPrintClient.tsx:681-683`.
- **Evidence folders:** `~/Minotaur_v1_exports/parity-pairs/260919_print-reparity/` (cable) and
  `…/260919_revlist-regression/` (equipment list). The file names below are shortened to their
  descriptive part.

## §2 · CP1: Small Cable Labels to v1 (pedigree (a) R1, then (b) as cited)

**The fence comment is being overruled, not deleted.** `CableLabelsPrintClient.tsx:77-83` says the y
axis is "deliberately NOT wired". Rewrite it to say what now holds: the x origin comes from the die
(STOCK-IS-DIE), and the y axis and everything inside the sticker come from v1 (R1, Daniel
2026-09-19).

Targets are in points. x is measured inside the cell from the cell's own origin. Tolerance is ±0.75
(Chrome's paint grid).

| # | What | v1 target | Evidence |
|---|---|---|---|
| 1 | Row origin | first row at **36.00**; first chip top 37.43; pitch 36.00 × 20 rows | `v1_cable-labels-by-cable` p4 |
| 2 | Headings (group, bundle, model) | each exactly **one 36.00 row**, so every chip stays on phase | `v1_cable-labels-by-group-model-and-break`, all pages (528 chips, 0 off phase) |
| 3 | Colour chip | **`CABLE_CHIP.smallCable`** (`cableGeometry.ts:363`: 131.04 × 14.00, inset 0); top 1.43 | by-cable p2 |
| 4 | Cable name | centred at **65.97**; top 4.51 | by-cable p2, `A GTR 1 DI 1`, `Apron FB 1` |
| 5 | "@ location" line | top **22.68** | same |
| 6 | Hairline | 0.50 pt `#DEDEDE`, from −0.25 to 131.29, at **27.93** | same |
| 7 | Model / end text | right edge **124.95**; top 28.68 (or 30.11) | same. On column 4, ink must end ≤ 585 on the sheet (v2 ends at 608.67 of 612) |
| 8 | Bundle name (italic) | x **6.04**, top 28.68 | same |
| 9 | Loose cable | **prints nothing** where v2 prints `(Not in Bundles)` | by-cable p1, `A2 KVM Rec 1` |
| 10 | Page header | title centred at **316.95**, underline y 33.00; project name x 25.00, top 21.50; "Printed" **6 pt**, right edge 592.92, top 20.25; "Page N of M" top 27.25 | by-cable p1 |
| 11 | Grouped sort: group start | each group **starts a new column** (R3); bold group name with a grey `(Not in Bundles)` under it, where v2 prints the name twice, the second time underlined | grouped file p1 |
| 12 | Grouped sort: blank group | labelled **`Not Grouped`** | grouped file p1 |
| 13 | Grouped sort: no heading stranded at a column foot | a heading is never the last row of a column | v2 today strands `19-Pair` at the foot of p1 column 1 |

**Order: v2's number-aware order stands** (R2: `6-Pair, 12-Pair, 19-Pair`; `RG6` before `RG59`). Write
the dated divergence comment where the order is decided, if `6a8f3d4` did not already put one on this
path.

**Where the blank group goes: last.** This is **proposal (c)**: the parallel's assumption under R2,
which Daniel has not corrected. v1 puts it first. Name it in the return so he can reverse it in a word.

**Blast radius:** Big Cable Labels use the same client. Pin their output before and after. It must
not move.

**Success, on a JOY reprint (both sorts):**

- first chip top 37.43 ± 0.75;
- 0 chips off the 36.00 phase on the grouped sort;
- column-4 ink ends ≤ 585;
- every row of the table within ±0.75.

Measure it from the printed PDF, as the parallel did (§9 of the return). The label count (842 against
v1's 870) is **not** this unit's work. See §5.

## §3 · CP2: Tail Panel "by model" sorts by model (pedigree (a) R2 and 2026-08-30)

**The latent defect** (from your own return, OPEN QUESTIONS 6, re-read at `6a8f3d4`):

- `buildPanelStrips` (`cableLabels.ts:349`) re-sorts by cable name;
- `panelBreaks` (`TailLabelsPrintClient.tsx:266-271`) forces a page break at every model change;
- so a multi-model panel print breaks at every change of model. JOY cannot show it, because all 7 of
  its panel tails are 19-Pair.

1. Carry the model order through `buildPanelStrips` on `cable_model_cable`, the same way you did for
   the grid builders in `6a8f3d4`: number-aware, with blank models last. Within a model, cables keep
   today's order.
2. **Test:** use a seeded fixture with at least three models, interleaved by cable name. By model it
   gives **one page run per model, in number order**. By cable it stays byte-identical to HEAD. Add a
   deletion control.
3. **JOY's Tail Panel output stays byte-identical** to `6a8f3d4` in both sorts. §4.7 of the reparity
   return must pass unchanged.

## §4 · CP3: EQUIP-PARITY-2, the equipment list's approved differences (pedigree (a) Daniel's approval, then (b) as cited)

The numbers are the item numbers from the revlist return's §6 A. The evidence files are in
`…/260919_revlist-regression/`.

| # | What changes | v1 target | Evidence |
|---|---|---|---|
| 2 | A deleted row's **sub-notes are struck through** too, not only the model | struck through, as the model is | `v1_revised-basic-by-method` p1 (`spare`, `One HMA Loop`, `Waves Card`) against `v2_revised-basic-by-method` p19. **If HEAD already strikes them, report it and skip.** |
| 3 | Detailed list: the **method chip wraps** instead of truncating | 8.0 pt, up to two lines (`Rent-Main-Masque- / PRG-SAI`), chip x0 327 | `v1_detailed-by-category` p1 against `v2_detailed-by-METHOD` p1 (every chip reads `Rent-Main-…`) |
| 4 | Detailed list: **model-line quantities are roman** | `CenturyGothic` 12.0, not Italic. Basic-list italics stay (QTY-ITALIC). Sub-row quantities stay 10 pt roman | same pair, p1 |
| 5 | Detailed list: **indents** | sub-note 9 pt in from the model (x0 40.0 against model 31.0); sub-item name 18 pt (x0 49.0) | same pair, p1 (`on reel`, `FOH`) |
| 6 | Detailed list: **`Qty` column title** | bold `Qty` at the right of every category heading, x0 563.4 | same pair |
| 7 | Footer: **`1 of 19`**, not `Page 1 of 19` | 10 pt, on the equipment list prints | `v1_basic-by-method` against `v2_basic-by-method` |
| 9 | A cable with **no model at all** prints its bare quantity (`16`), not `16 (Unknown)` | bare quantity | basic pair p15. Composed cables with a model are unchanged (EP-P1) |
| 10 | **Sub-note wrap width** | measure v1's note column from the basic pair **first**, then match it. Today v2 wraps one word later (`…DPA 4091, Earthworks M23` on one line, where v1 breaks before `M23`) | basic pair. Report the measured width in the return |
| 11 | Basic list: **model column** | model x0 **59.98** (v2 56.74); sub-note x0 **69.0** (v2 70.02) | basic pair p1 |

**Report the page count, but don't chase it:** after items 2–11, print JOY's revised basic by method
(`Rev 9/19/2026 10:34a`, search `rent`) and report its page count. v1 prints 19 and `6a8f3d4` prints 20
(Ledger, twenty-eighth append). If it is still 20, report the cause if you can measure it, and change
nothing for it.

**Blast radius:**

- `useMeasuredPages` pagination changes with every row height. The PRINT-CLIP guard (no row lost off a
  page) must pass on basic, detailed and revised.
- Frame 07 (the same-sort revision pair) must still pair identically.
- PAPERWORK-1's two layouts (Bundle Summary, Line List) carry their own chrome and must not move.

## §5 · Left out of this unit, and why

- **BOX-ROW-TYPE** (item 8: boxes by type, not name). A design call, and Arch's.
- **Section numbers that collide** (OQ3). Report-only, as before.
- **Small Cable Labels' count** (842 against v1's 870). Its cause is not established: most likely v1's
  name-keyed links, which the import work owns.
- **Cable Checklist, Tail Checklist, Bundle Sheet** (reparity §8 C). They are the next unit, sized on
  their own.

## §6 · Close

- Run the full suite, typecheck, lint, build, frozen 3/3, the visual gate (with events only as §0.5
  allows) and the dependency gate. Census 0.
- Update the fence (FENCE-ONEUNIT, with this bundle as the one unit).
- Return DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT, plus the COMMIT BLOCK.

**Daniel's gate, on JOY only.** Restart `:3100` first.

1. **Small Cable Labels, by cable.** Page 1's first row of stickers sits at the very top of the sheet,
   with no gap above it. Loose cables print no "(Not in Bundles)". The fourth column's text is not
   cut off at the right.
2. **Small Cable Labels, grouped.** Each group starts a new column. The blank group reads
   `Not Grouped` and comes last.
3. **Detailed equipment list, by method.** The method chips show the whole method name, on two lines
   where needed. There is a `Qty` title at each category heading.
4. **Basic equipment list.** The footer reads `1 of 19`. The model-less cable on the Cable page reads
   `16`, not `16 (Unknown)`.
5. **Revised list** (`Rev 9/19/2026 10:34a`, by method, search `rent`). The struck-through rows' notes
   are struck through too.

Proposed subject: `PRINT-REPARITY-LABELS: Small Cable Labels to v1; Tail Panel sorts by model; equipment
list parity (EQUIP-PARITY-2)`.
