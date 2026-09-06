# CAT-NOTE PRINT HALF — v1 MEASUREMENT OF RECORD

**Measured 2026-09-06 from the Cowork-Arch seat, session opening on `1a54c3b`.**
**Instrument:** `pdfplumber` 0.11.10 on the user's own machine (local VM), scripts under `~/catnote/`, nothing staged and nothing written into a mount by the probes.

**Arbiter:** `~/Minotaur_v1_exports/equipment/260905-1159_v1_equipment-list_BVSC-Tour_FILEMAKER.pdf`
31 pages · 612 × 792 letter portrait · FileMaker Pro Advanced 17.0.1 · Century Gothic
Pedigree **(b)**, cited by file, page and coordinate. PDF-CHROME-PATH does not bind a v1 FileMaker source.

**Data side:** live read of `categories` on `Buena Vista Social Club`, 2026-09-06.

---

## 1 · THE STORED NOTES — SIX, AND THE DRIFT IS CONFIRMED

| category | chars | CR | LF |
|---|---|---|---|
| `4.1 Microphone Hardware` | 42 | 0 | 0 |
| `8.0 Power` | **154** | **0** | **2** |
| `9.0 Hardware and Rigging` | 114 | 1 | 0 |
| `11.0 Racks and Boxes` | 56 | 0 | 0 |
| `13.0 Cable` | 161 | 1 | 0 |
| `13.1 Tails` | 83 | 0 | 0 |

⚠ **BVSC-8POWER-DRIFT is confirmed live and unchanged:** `8.0 Power` reads **154 / 0 CR / 2 LF** against its v1 source's 153 / 1 CR, from Daniel's 2026-09-06 browser gate. `9.0 Hardware and Rigging` and `13.0 Cable` still carry their bare CRs byte-for-byte. **A future round-trip comparison on BVSC must not report `8.0 Power` as a defect.**

⚠ **Two of six notes are CR-only.** Any `split('\n')` sees them as one segment. This is IMPORT-LINEBREAK-CR arriving in the *paginator*, not only the renderer.

---

## 2 · CATNOTE-RULE — ⚠ **REINSTATED. THE FIRST READING OF THIS SECTION WAS WRONG.**

**This section originally read "REFUTED ON THE ARTIFACT" and concluded there was nothing here to build. That conclusion shipped into `260906-1054_cat-note-print.md` §2.1, into `267d477`'s commit message, and into production as a missing rule. Daniel found it on the printed page. The section is rewritten rather than appended to, because a heading that states a wrong claim gives orders.**

**The claim under test (Docket, from v1's layout definitions):** fourteen colour-keyed 2 pt full-width `Object type="Line"` rules, each hidden unless `Temporary Variables::Minotaur Color` matches **AND** `Categories::Notes ≠ ""` — so v1 draws a rule in the paperwork colour **only where a category carries a note.**

### 2.1 ⚠ HOW THE FIRST MEASUREMENT MISSED IT

The probe filtered `linewidth >= 2.0`, **because the DDR lead said 2 pt.** The note-conditional rule renders at **1.00 pt**, so the instrument could not see it and returned absence — which was written down as refutation.

**What made the wrong answer look confirmed:** the probe *did* find a 2 pt paperwork-colour rule under every heading. That is a **different object** — the category-heading underline — and finding it in the right neighbourhood read as corroboration. *Two objects in one place, one instrument that could see only the wrong one.*

*A SEARCH RUN WITH THE WRONG INSTRUMENT RETURNS ABSENCE — fifth occurrence on this project, and the first written into a handoff as a finding and shipped. **The instrument was chosen from the claim's own wording, which is what made it blind: the lead said 2 pt, so the probe looked for 2 pt, so the 1 pt object it was actually testing for could not appear.** When testing a claim, the filter must not inherit the claim's parameters.*

### 2.2 THE LINE-CLASS CENSUS — six classes, three of them orange

Whole document, no width filter:

| linewidth | colour | x0 → x1 | count | object |
|---|---|---|---|---|
| 2.00 | paperwork | 24.00 → 585.00 | 31 | page header rule, 1/page |
| 2.00 | paperwork | 24.99 → 585.99 | 31 | page footer rule, 1/page |
| 2.00 | paperwork | 26.98 → 585.98 | 48 | **category heading underline** (47 headings + 1 orphan) |
| **1.00** | **paperwork** | **26.27 → 584.27** | **14** | ⚠ **THE NOTE RULE** |
| 1.00 | grey `#DEDEDE` | 25.27 → 586.27 | 535 | body row separators |
| 1.00 | black | 239.11 → 369.86 | 31 | page header, 1/page |

**Three different x ranges and two different weights across the three orange interior classes.** The note rule is narrower and shifted left of the heading rule: width **558.00** against **559.00**, starting 0.71 further left.

### 2.3 IT IS NOTE-CONDITIONAL, MEASURED BOTH WAYS

| | has the 1.00 pt rule | does not |
|---|---|---|
| headings **with** a note | **14** | 0 |
| headings **without** a note | 0 | **33** |

**Fourteen instances, and the document contains exactly fourteen lines of that class — nothing else uses it.** The negative half is what proves it is not a second heading underline.

### 2.4 PLACEMENT

| From → to | Measured | spread | n |
|---|---|---|---|
| bottom of the LAST note line → rule | **2.26** | min 2.26, max 2.26 — identical on all 14 | 14 |
| rule → top of the FIRST item | **4.63** | 4.58 – 4.68 | 14 |

Worked example, p7 `4.1 Microphone Hardware`: heading top 637.00 / bottom 649.04 · **2.00 pt heading rule y 653.50** · note top 658.00 / bottom 670.00 · **1.00 pt note rule y 672.26** · first item top 676.90.

**The full block is: heading → 2 pt rule → note → 1 pt rule → first item.** The rule sits INSIDE the 18.90 already measured between the note and the first item — it is not new space.

**What was correct in the original section and stands:** the 2.00 pt heading underline is on **47 of 47** headings, note-carrying and note-free alike, and is **not** the note-conditional rule. v2 already draws its equivalent (`PrintEquipmentListClient.tsx:1177`).

**Registered as an EQUIP-LIST-PARITY input:** v1's heading rule is **2.00 pt**, v2's is **1 px**. Not this unit's.

**Built as CAT-NOTE-RULE** on handoff `260906-1329_cat-note-rule.md`.

---

## 3 · THE BLOCK — MEASURED GEOMETRY

```
    category heading      12.00 pt Century Gothic BOLD    x0 = 25.98
    ── 2.00 pt rule, paperwork colour ──                  x 26.98 → 585.98
    category note         12.00 pt Century Gothic ITALIC  x0 = 27.98
    first item            12.00 pt Century Gothic Italic  qty right-aligned
    item sub-note         10.00 pt Century Gothic Italic  x0 = 69.00
```

⚠ **The rule sits between the heading and the note.** CATNOTE-TYPE's "between the category heading and the first item" is true but incomplete.

| From → to | Measured (pt) | Spread | n |
|---|---|---|---|
| heading top → rule | **16.46** | 16.42–16.50 | 47 |
| rule → first line of block | **4.48** | 4.43–4.54 | 47 |
| heading top → first line of block | **20.95** | 20.90–21.00 | 47 |
| note line → note line (soft wrap) | **15.00** | exact | 4 |
| paragraph → paragraph (hard break) | **30.00** | exact | 5 |
| last note line → first item | **18.90** | one reads 18.80 | 14 |

**⚠ The note occupies the first item's slot.** `heading top → first line of block` is **20.95 whether that line is a note or an item**, across all 47 headings. v1 reserves no space for the note; its only cost is its own height.

**⚠ Two leading numbers, not one.** A soft wrap advances **15.00**; a hard line break advances **30.00** — a paragraph break carrying 15.00 pt of space. Proven on `9.0 Hardware and Rigging`, whose stored note holds exactly one CR, no blank line, and whose first paragraph does not wrap: the gap is 30.00 with no wrap involved. `white-space: pre-line` gives 15.00 and is wrong on every multi-paragraph note.

**⚠ The left edge is a 2.00 pt indent, not flush** — a correction to CATNOTE-TYPE. Heading `x0 = 25.98` on all 47; note `x0 = 27.98` on all 14. The six notes open with **A · P · M · C · 9 · A** and the headings with **1 · 2 · 3 · 4 · 5 · 8 · 9 · 11 · 13**: different glyph sets, identical x0 within each class, so it is a frame offset and not italic side bearing — side bearing would scatter.

**Indent ladder, three levels:** heading 25.98 → note 27.98 → item (qty right-aligned; 1-digit starts 43.83, 2-digit 37.18) → sub-note 69.00.

---

## 4 · WHERE THE NOTE REPEATS — SETTLED BY THE ARTIFACT

**Six stored notes produce FOURTEEN printed notes.**

| category | note instances |
|---|---|
| `4.1 Microphone Hardware` | 5 |
| `8.0 Power` | 4 |
| `13.0 Cable` | 2 |
| `9.0 Hardware and Rigging` | 2 |
| `11.0 Racks and Boxes` | 2 |
| `13.1 Tails` | 1 |

The document runs several **LISTS**, each with its own full set of category sections — `1.0 Consoles` heads a section on pp. 1, 16, 19 and 22. **The rule is therefore: emit at every non-continued section header whose category carries a note.** One rule, no sort branch, and it reproduces CATNOTE-TYPE's "prints again when the category appears in a different LIST" without special-casing lists.

**This also settles the `by-method-category` sort with no ruling owed by Daniel.** `buildSections` emits one section per (method group × category) with `header: catName` (`printEngine.ts:365-372`), so a category heading several sections carries its note on each — the same rule in both sorts. **An open question closed by measurement rather than sent to his desk.**

---

## 5 · v2's SURFACE — READ AT SOURCE THIS SESSION

- **`fetchCategories` selects `'*'`** (`src/lib/queries/categories.ts`) — the notes are fetched. ✓
- ⚠ **…and then discarded.** `PrintPageLoader.tsx:57-60` projects the rows to `categories.data.map(c => c.name)` before they reach the client. **No query changes; a projection does.** The opener's "so `categories.notes` is in hand on the print surface" is wrong on that last clause.
- ⚠ **`initialCategories` also seeds the print page's Find autocomplete** (`categoryOptions`, `PrintEquipmentListClient.tsx:272-277`). Its shape must not change — the `num_labels`/Find lesson of 2026-08-31, one surface over.
- **`seedCategoryNote`** already exists and is exported (`src/lib/equipment/categoryNote.ts`) — the same normalizer CAT-ADMIN's editing half seeds its control with. The print half reuses it rather than calling `normalizeLineBreaks` a third way.
- **`section-hdr` is pushed in exactly FOUR places** in `paginateBlocks` — one at `item.kind === 'sec'` (`continued: false`) and **three** continuation re-emissions (`~527`, `~547`, `~570`, all `continued: true`). Populating a `note` field on the one and never the three makes "no note on a continued header" structural rather than remembered.

### ⚠ 5.1 THE PAGINATION HAZARD — the finding of the session

**The equipment list paginates by CONSTANT HEIGHT ESTIMATES and was never converted to measured pagination.** `paginateBlocks` accumulates `usedH` from `SECTION_HDR_H = 34`, `METHOD_HDR_H = 26`, `DETAIL_ROW_H = 16`, `modelRowHeight()` and `detailedModelHeaderHeight()`, breaking at `CONTENT_H`.

**And the page is a fixed `height: PAGE_H` container whose body is `flex: 1, overflow: 'hidden'`** (`:967`, `:978`, `:1042`), with `overflow: hidden !important` in the print CSS (`:922`).

**PRINT-CLIP and BOX-PRINT-CLIP retired the estimate paginator from the four cable and box documents and deleted `paginateByHeight`. This document still has the mechanism.** A category note is the first *variable-height* element to enter this flow at section level. **An under-estimated height does not spill onto an extra page — it clips, silently, off the bottom.**

**Not in the opener, the Roadmap or the Session Log.** It is what makes `categoryNoteHeight` a pure, separately-tested function rather than an inline expression, and it is why the acceptance probe must be a note that **pushes a section over a page boundary** — a note that fits proves nothing, which is the 1→2-line probe error from CAT-ADMIN one unit ago.

⚠ **The look-ahead at `printEngine.ts:495` is the easy miss:** `const neededH = SECTION_HDR_H + firstRowH` is what stops an orphaned heading at a page foot. Unchanged, a heading plus a six-line note lands at the bottom with its first item pushed to the next page.

⚠ **`modelRowHeight`'s idiom is the precedent to copy** (`:121-128`) — split on `\n`, `Math.max(1, Math.ceil(seg.length / 70))` per segment. **But its 70-char divisor is tuned to the item column's width and size; the note runs the full text width from the heading's edge.** The divisor is a different number and must be measured, not carried across. *A shape shared with the neighbour is not a behaviour shared with the neighbour.*

⚠ **`printEngine.ts` has no test file at all.** `categoryNoteHeight` gets the first one.

---

## 6 · WHAT THIS MEASUREMENT DID NOT SETTLE

- **The size v2 should use.** v1's absolute 12.00 pt is at v1 scale; v2 runs at EQUIP-LIST-SCALE's measured 0.750. The handoff builds the note as **"the size of a body item line"** — the relationship CATNOTE-TYPE actually recorded, which is scale-invariant and correct both before and after EQUIP-LIST-PARITY. Pedigree (b): the artifact states 12.00 = 12.00.
- **Whether v1's note wraps at the full text width or a narrower frame.** Not measurable from these six notes — none is long enough to wrap at anything but the widest setting. CC measures it on the running app.
- **The one unmatched interior rule** (p. 5, `y 718.37`).

---

*Filed as the measurement of record for CAT-NOTE's print half. Handoff of record: `handoffs/to-cc/260906-1054_cat-note-print.md`.*

---

# ⚠ CORRECTION — APPENDED 2026-09-06, SAME SESSION, AFTER CAT-NOTE'S RETURN

**§1's live read was taken against a project name that is NOT UNIQUE — and the name is not unique BY DESIGN.**

## TWO PROJECTS SHARE THE NAME, AND THAT IS A PRODUCT REQUIREMENT

**RULED / STATED (Daniel, 2026-09-06): two productions of the same musical carry the same show name, and supporting that is a MUST-HAVE FEATURE.** Duplicate `projects.name` is not drift, not junk, and not a cleanup item. Both rows below are real, current, and Daniel's.

| project id | now named | categories | noted | spine rows | `8.0 Power` |
|---|---|---|---|---|---|
| `57874c69-06b6-41b1-91d8-6a00e5255110` | **`Buena Vista Social Club US Tour`** (renamed by Daniel 2026-09-06) | 30 | 6 | **2,591** | **154 / 0 CR / 2 LF — DRIFTED** |
| `cf780353-448d-4b15-a054-973f577b215c` | **`Buena Vista Social Club`** — **MEXICO CITY, THE LIVE SHOW** | 30 | 6 | **1,024** | **153 / 1 CR / 0 LF — v1-clean** |

**⚠ `cf780353` IS THE DRIVER. It is BVSC-MX — the production this entire Roadmap is sequenced by — and Daniel is building its equipment list now.** Its lower row count is **deliberate**: he started it with **cable and boxes blank**. It is not an incomplete import, it is not a failed apply, and it is not a reference corpus.

**`57874c69` is the US Tour** — the 2,591 rows the Session Log records as "the BVSC Tour imported and verified sheet by sheet" (equipment 1,059 + cables 1,372 + tails 131 + boxes 29 = 2,591). That reading was correct; it simply had no id attached, and the show it names is the Tour, not Mexico City.

## ⚠ AN ARCH ERROR, AND IT REACHED DANIEL AS A FINDING

The first version of this correction called `cf780353` *"an incomplete earlier attempt — the evening APPLY-TIMEOUT stopped the first import"* and recommended renaming it as stale. **Every part of that was inferred from a row count and a timestamp, and written in the tense of a measurement.** Daniel corrected it in one line.

*TENSE-IS-A-CLAIM, third occurrence in six days, and the same shape as the six-minute Change All and the category-notes-are-dropped claim: **inferring a mechanism instead of measuring one**, then publishing the inference as a finding. The mitigation that has worked every time — write it as a lead that must be proven — was available and was not used.*

## What this corrects in §1 above

§1's table is **`57874c69`'s (the US Tour's) six notes.** It was taken from a query filtered on `p.name` with no project id, which cannot distinguish the two, and it returned six rows where twelve exist; why that call returned six is **unexplained** and the per-project read above supersedes it.

**BVSC-8POWER-DRIFT IS THEREFORE MISATTRIBUTED IN EVERY DOCUMENT THAT CARRIES IT.** Daniel's 2026-09-06 browser gate edited `8.0 Power` on the **US Tour** (`57874c69`), not on Mexico City. **Mexico City's `8.0 Power` is byte-identical to its v1 source at 153 / 1 CR / 0 LF.** The Roadmap, the Session Log and the Ledger all record the drift against "Buena Vista Social Club" unqualified, which now reads as the driver show and is wrong. **Propagation owed at this session's close.**

## Consequences, registered

1. **⚠ PROJECT-NAME-NOT-UNIQUE — NEW, and it is now a live class rather than a hypothetical.** Two current projects share a name by design. **Anything that identifies a project by name is ambiguous**, including: the visual-gate harness, which finds its fixture by name (`finding fixture project "Visual Gate Fixture"`); every SQL read in these documents filtered on `p.name`; every evidence provenance line and Docket row reading "BVSC". **Wants a sweep for name-keyed project lookups, and every future measurement cites a project id.** ⚠ **Not to be "fixed" by making the name unique — the duplicate is the feature.**
2. **BVSC-8POWER-DRIFT is re-pointed at `57874c69` (US Tour).** Mexico City is byte-clean. A round-trip comparison on Mexico City has no known drift to excuse; one on the US Tour does.
3. **Mexico City carries THREE CR-only notes** (`8.0 Power`, `9.0 Hardware and Rigging`, `13.0 Cable`) against the US Tour's two — so it is the **better** subject for CAT-NOTE's browser gate: a bare-CR note is precisely the case that renders run-on if normalization is missed.
4. **PROJ-CLEAN-2's census moves 24 → 25 and is fully explained.** The 2026-09-05 count of 24 already included Mexico City (`cf780353`, created 2026-09-05 00:16 UTC); the US Tour (`57874c69`) was created 2026-09-06 01:02 UTC, after that measurement. **Neither is a cleanup candidate.**

**Nothing in §2–§6 is affected** — every one of those measurements was taken against the v1 PDF or against `src/`, neither of which is reached through a project name.
