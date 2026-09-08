# EQUIP-LIST-PARITY — the leading, the rules, and the cover letter
### v1↔v2 measurement of record · 2026-09-06 (afternoon) · Cowork-Arch, main line

**Arbiters, both landed, both cited by file:**

- **v1** `~/Minotaur_v1_exports/equipment/260905-1159_v1_equipment-list_BVSC-Tour_FILEMAKER.pdf` — 31 pp, 612×792 pt letter portrait, Century Gothic, FileMaker Pro Advanced 17.0.1.
- **v2** `~/Minotaur_v1_exports/parity-pairs/260905_equipment-list-pair/260905-2202_v2_equipment-list_BVSC-Tour_CHROME.pdf` — 24 pp, 612×792 pt, Skia/PDF m152.
- **cover letter** `~/Minotaur_v1_exports/equipment/260905_v1_cover-letter_BVSC-Tour_SOURCE.docx` — the Word **source**, read directly, not its print.

Instrument: `pdfplumber` 0.11.10 on the local device. **Every class was censused before any narrowing** (AN INSTRUMENT MUST NOT INHERIT THE CLAIM'S PARAMETERS). Vertical advances are measured **baseline to baseline**, taken from each glyph's text matrix, not from `top`, because a glyph bounding box is set by the font's ascent and differs between roman and italic on the same line.

⚠ **THE v2 HALF OF THE MATCHED PAIR IS STALE BY TWO SHIPPED UNITS.** It was printed 2026-09-05 22:02, before CAT-NOTE's print half (`267d477`) and CAT-NOTE-RULE (`f4192cd`). It carries **no category note and no note rule**. It remains a valid arbiter for type, leading, rule weights and the row separator — none of which those two units touched — and it is **not** a valid acceptance artifact for this unit. **A fresh v2 print at HEAD is owed before EQUIP-LIST-PARITY is accepted.**

---

## 1 · THE FRAME: A v1 POINT IS A v2 PIXEL, 1:1 — AND IT IS ALREADY SHIPPED

Both documents print the same physical page. v1 is **612 × 792 pt**; v2 is **816 × 1056 px** at 96 dpi, which is the same 612 × 792 pt. The unit ratio is **96/72 = 1.3333**, and the ruled type ratio is **0.750**, so:

> **0.750 × 1.3333 = 1.000.** A v1 measurement in POINTS is carried into v2 as the same number in PIXELS, unchanged.

This is not a new derivation. It is written in `printEngine.ts`'s own CAT-NOTE comment block, and it is **in production**: `CAT_NOTE_LINE_H = 15` was carried from v1's measured 15.00 pt soft wrap, `CAT_NOTE_RULE_PX = 1` from v1's 1.00 pt rule, `CAT_NOTE_INDENT = 2` from v1's 2.00 pt indent. The type obeys it too: v1's 12.00 pt item line is `fontSize: 12` in v2 and measures 9.00 pt in the PDF (12 × 0.75).

⚠ **AND HERE IS THE THING THIS SECTION FIRST GOT WRONG, CORRECTED IN PLACE BECAUSE A HEADING THAT STATES A WRONG CLAIM GIVES ORDERS.** The 1:1 mapping above describes what v2 does **today**. Whether it is also the TARGET is a question this measurement cannot answer, and the first draft of this section asserted that it was.

**The two readings, and they give different numbers for every line in §2:**

- **(A) KEEP the 0.750.** v2's type stays at 0.750 of v1 and the LEADING is brought to 0.750 to match it — one die, one ratio, v1 point → v2 pixel 1:1 throughout. The list keeps printing smaller than v1's and keeps fitting 24 pages against 31.
- **(B) PARITY — v2 matches v1 at full size.** Every v1 point becomes **1.3333 px**, type and leading together: the item line goes 12 px → 16 px, and the list grows back toward v1's 31 pages.

⚠ **THE MECHANISM ARGUES FOR (B), AND IT IS AN INFERENCE ABOUT INTENT RATHER THAN A MEASUREMENT.** v2's type is `fontSize: 12` for v1's 12.00 pt, `10` for 10.00, `14` for 14.00 — **v1's POINT numbers used as PIXEL values, on every element class**, which is why the ratio is *exactly* 0.750 everywhere rather than approximately anything. That is the signature of a units error, not of a design decision. The leading did not come from v1 at all (23.00 px against v1's 19.97), which is why it landed on a different ratio. **If (B) is right, the 0.750 is a defect and not a die, and EQUIP-LIST-SCALE's "measured at exactly 0.750" is a measurement of the bug.**

⚠ **RULED (Daniel, 2026-09-06) — EQUIP-LIST-FULLSIZE: (B). v2 MATCHES v1 AT FULL SIZE.** Every v1 point becomes **1.3333 px**, type and leading together. **The 0.750 is a units defect, not a die**, and EQUIP-LIST-SCALE's "measured at exactly 0.750 on every element class" is a measurement of that defect — exact because using a point number as a pixel number is exact, not because anything was designed to it. Under either reading the measurements in §2–§8 stand; this ruling fixes the multiplier at **4/3**.

⚠ **THE PAGE DIE IS THE EXCEPTION AND DOES NOT SCALE.** v1's list die is `x 25.98 → 584.96` and v2's `27.00 → 584.99` — both in POINTS, already within ~1 pt, and `MARGIN_X = MARGIN_Y = 36` px is 27.00 pt. **Margins, page size and column origins stay exactly as they are.** Only type, leading and rule weights take the 4/3.

⚠ **AND THE SHIPPED CAT-NOTE CONSTANTS ARE NOT EXEMPT.** Every `CAT_NOTE_*` value in `printEngine.ts` is a v1 point value written as a pixel under the 1:1 frame — `CAT_NOTE_FONT_PX 12`, `CAT_NOTE_LINE_H 15`, `CAT_NOTE_PARA_GAP 15`, `CAT_NOTE_INDENT 2`, `CAT_NOTE_RULE_TOP_GAP 2.26`, `CAT_NOTE_RULE_PX 1`, `CAT_NOTE_RULE_BOTTOM_GAP 4.63`. They were **correct against v1 and are correct relative to the document's current scale**; they take the same 4/3 as everything else. The prior instruction *"do not touch the note rule"* protected it from being **re-derived**, not from being **scaled**, and it is superseded by this ruling.

**Either ruling corrects a governing claim and carries a propagation list** — Roadmap v4.21 (Next Sessions ¶1, the Sprint Plan row, EQUIP-LIST-SCALE, EQUIP-LIST-PARITY, CONTCAT-DIVERGE), the Session Log's STATE OF PLAY, the Ledger's Sep-6 sixth append, and `drafts/260906-1430_next_session_opener.md` §3.

## 2 · THE LEADING TABLE — SEVEN TRANSITIONS, MEASURED ACROSS BOTH DOCUMENTS ENTIRE

Not four samples on one page. Every consecutive same-page pair in both documents, classified by the font and size of each line.

| transition | v1 (pt) | n | **(A) keep 0.750 → px** | **(B) parity → px** | v2 today (pt) | v2 today (px) | n |
|---|---|---|---|---|---|---|---|
| item → item | **19.97** / 20.97 | 235 / 89 | **19.97** | **26.63** | 17.25 | 23.00 | 326 |
| item → sub-note | **15.34** | 164 | **15.34** | **20.45** | 12.75 | 17.00 | 155 |
| sub-note → sub-note | **12.00** | 126 | **12.00** | **16.00** | 10.50 | 14.00 | 131 |
| sub-note → item | **16.62** | 134 | **16.62** | **22.16** | 15.75 | 21.00 | 134 |
| heading → item | **20.94** | 31 | **20.94** | **27.92** | 18.00 | 24.00 | 62 |
| item → heading | **20.79** | 24 | **20.79** | **27.72** | 21.75 | 29.00 | 24 |
| sub-note → heading | **17.45** | 13 | **17.45** | **23.27** | 20.25 | 27.00 | 14 |

**v2's leading matches NEITHER candidate today.** Against (A) it is loose on all seven, by 1.66 to 9.55 px. Against (B) it is **tight on five and loose on two** — which is the sharper fact: the spacing was not scaled from v1 at all, in either frame, and the ratio wanders from 0.82 to 1.16 depending on the transition. Fitting one number to that is what produced "≈0.86".

**v2's leading is looser than v1's on every one of the seven transitions, by seven different amounts between 1.66 and 9.55 px.** Fitting one ratio to that is what produced "≈0.86". **The build takes the middle column: v1's point value, as pixels.**

⚠ **v2's item pitch is a single value with ZERO exceptions — 17.25 pt on 326 of 326 gaps.** It is not drifting; it is uniformly wrong.

Corroboration from the code, independent of the PDFs: `modelRowHeight` returns **22** for a row with no notes (22 + a 1 px separator = the measured 23.00), and note lines cost **14** each (the measured 14.00). The estimate paginator and the printed page agree with each other. Both are 3.03 and 2.00 px too tall against v1.

## 3 · ⚠ v1'S BODY ROW HAS TWO HEIGHTS, AND WHAT SELECTS THEM IS NOT MEASURED

**19.97 on 235 gaps and 20.97 on 89 — exactly 1.00 pt apart.** This is not glyph-box noise and not accumulated rounding: **the grey row-separator rules show the same two gaps**, so it is the row grid itself, and long runs are internally uniform at one value rather than alternating.

- **19.97 is the base.** It is the only value on pages 1–22 and 30–31, and it composes cleanly: a row carrying sub-notes measures 19.97 + 12.00 × n (31.97, 43.97, 55.97 all observed).
- **20.97 appears only on pages 23–29** — the `13.0 Cable` / `13.1 Tails` / `13.2 Adapters` run — where both values occur mixed **within a single page and within a single category**.
- **Ruled out by test, not by assumption:** indent (both x0 classes carry both), quantity digit count, description length, right-edge extent, presence of a descender, apostrophe, comma, parenthesis, slash. None separates them.

⚠ **A MEASUREMENT'S BOUNDARY IS A CLAIM TOO — so this is recorded as unexplained rather than resolved by the convenient guess.** For the build: **take 19.97.** It is the base value, it is 73% of the population, it is the only value in 24 of the 31 pages, and it is the one that composes with the sub-note stack. The 20.97 is registered as **EQUIPLIST-ROWH-BIMODAL** and does not block this unit.

## 4 · ⚠ SUBNOTE-HARDBREAK — NEW, LIVE AT HEAD, AND IT IS CAT-NOTE'S FINDING ONE LEVEL DOWN

v1's item sub-note has **two leading numbers, exactly as the category note does**: soft wrap **12.00**, hard break **24.00** (and 36.00 for a doubled break — 20 and 2 instances). v2 renders **10.50 on 131 of 131 gaps — no second value at all.**

Checked record by record rather than in aggregate, on five items present in both documents:

| item | v1 | v2 |
|---|---|---|
| `EAW UB12Si` — `with 2x NL4` → `or similar offstage program` | **24.00** | 10.50 |
| `Meyer LEOPARD` — `XLR3 Input` → `tower upper / cluster` | **24.00** | 10.50 |
| `Meyer ULTA-X23` — `analog audio version` → `tower sides` | **24.00** | 10.50 |
| `Meyer ULTRA-X20` — `analog audio version` → `fills/monitors` | **24.00** | 10.50 |
| `Meyer ULTRA-X22` — `analog audio version` → `fills/monitors` | **24.00** | 10.50 |

**Five of five: v1 opens a line, v2 does not.** At source, `PrintEquipmentListClient.tsx:1253` and `:1424` join a row's sub-notes with `' · '` into one string before `normalizeLineBreaks`, so the structure v1 prints as a paragraph break has nowhere to land. **This is the same defect CAT-NOTE fixed for the category note, on the item sub-note, and it is unfixed at HEAD.** Targets: soft **12.00 px**, hard break **24.00 px**.

## 5 · THE RULE FAMILY — TWO RULES ARE HALF-WEIGHT, NOT ONE, AND ONE IS ALREADY CORRECT

v1's whole line inventory is **six classes, 690 objects**. Censused, then narrowed:

| v1 rule | weight | x span | n |
|---|---|---|---|
| row separator, grey `#DEDEDE` | **1.00 pt**, solid | 25.27 → 586.27 | 535 |
| category heading underline, paperwork orange | **2.00 pt** | 26.98 → 585.98 | 48 |
| page header, orange | **2.00 pt** | 24.00 → 585.00 | 31 |
| page footer, orange | **2.00 pt** | 24.99 → 585.99 | 31 |
| list-band underline, black | 1.00 pt | 239.11 → 369.86 | 31 |
| **category NOTE rule, orange** | **1.00 pt** | 26.27 → 584.27 | 14 |

v2, each orange rule classified by the line directly above it:

| v2 rule | weight | = px | v1 target | verdict |
|---|---|---|---|---|
| under a Bold@9.00 line — **the category heading underline**, 62 of 62 | 0.75 pt | **1.00 px** | 2.00 | ⚠ **HALF** |
| page header rule, 24 of 24 | 1.50 pt | **2.00 px** | 2.00 | ✅ already right |
| page footer rule | 0.75 pt | **1.00 px** | 2.00 | ⚠ **HALF** |

⚠ **The registered item named the heading rule only. The page FOOTER rule is half-weight too**, and the page header is already correct — so this is a two-line change, not one, and not three. **The 1.00 pt NOTE rule at `x 26.27 → 584.27` shipped correct at `f4192cd` (`CAT_NOTE_RULE_PX = 1`) and is not touched.**

## 6 · ⚠ THE ROW SEPARATOR IS A DIFFERENT OBJECT IN v2 — NEW

v1 draws **one solid 1.00 pt grey stroke** per row, `x 25.27 → 586.27`.

v2 draws a **dotted line**: 372 filled rectangles per row, each **1.50 × 0.75 pt on a 2.25 pt pitch**, `x 27.00 → 584.25`. That is **176,527 objects in a 24-page PDF against v1's 690** — a factor of 256.

Three divergences in one object: **style** (dotted vs solid), **weight** (0.75 pt = 1.00 px vs 1.00 pt = 1.33 px… v1's target is **1.33 px**, so v2 is light), and **span** (27.00 → 584.25 against 25.27 → 586.27, both ends short). Registered as **EQUIPLIST-DOTRULE**. Beyond parity it is a plausible cause of slow print preview and large PDFs, which is worth knowing before PREVIEW-CLIP is opened.

## 7 · QTY-ITALIC IS UNIVERSAL, NOT "SOME"

**Every** body item line in v1 carries both `CenturyGothic-Italic@12.00` and `CenturyGothic@12.00` — 2,045 italic characters at body size across the document, on every sampled line class, at every indent. **v2 contains zero italic characters at 9.00 pt.** The mechanism recorded on 2026-09-06 (quantity italic, description roman, same line) is confirmed and its extent is now measured: **all rows, not some.**

## 8 · THE COVER LETTER HAS ITS OWN DIE — READ FROM THE `.docx`, NOT A PRINT

The Word source is on disk and answers the question the Docket left open.

| | cover letter (`.docx`) | equipment list (v1) |
|---|---|---|
| page | 8.5 × 11 in | 612 × 792 pt |
| margins | **top 24.75 pt · left / right / bottom 36.00 pt** (header 24.75, footer 4.30) | die `x 25.98 → 584.96` |
| font | Century Gothic | Century Gothic |
| body | **10.00 pt** (`Normal`) | 12.00 pt |
| body leading | **`w:line 259 auto` = 1.079 × single**, `w:after 160 tw` = **8.00 pt** | 19.97 pt fixed |
| headings | **16.00** (`Heading1`, before 24.00 / after 6.00) · **12.00** (`Heading2`) · **28.00** (`Title`) | 12.00 category · 14.00 band |

⚠ **THE ASSUMPTION IS REFUTED: THE TWO HALVES WERE NEVER ON ONE SCALE IN v1.** The letter's body is **10.00 pt where the list's is 12.00**, its left margin is **36.00 pt where the list's is ~26.00**, and its leading is a **multiplier** where the list's is a fixed advance. Applying the list's 0.750 would set the letter's body at 7.50 pt — a size it uses for nothing. **The cover letter takes the `.docx`'s own numbers, carried 1:1 into pixels by §1's frame.** Daniel's ruling of 2026-09-05 stands untouched: v2's cover-letter **design** is good; this is a scale job.

## 9 · WHAT THIS UNIT MOVES, AND THE HAZARD THAT RIDES IT

Every number in §2 is an input to `paginateBlocks`'s **constant estimates**, and this document still paginates by them into a page whose body is `flex: 1, overflow: hidden` (**EQUIPLIST-ESTIMATE-PAGINATOR**; a negative control lost six of 120 rows off page 2 with no error). Tightening the item row from 23.00 to 19.97 px takes ~3 px off every one of ~470 rows — **roughly 1.4 pages of content moving up** — and every one of `SECTION_HDR_H` 34, `METHOD_HDR_H` 26, `DETAIL_ROW_H` 16, `MODEL_DETAIL_HDR_H` 22, `modelRowHeight`'s 22 / 24 + 14n and `detailedModelHeaderHeight`'s 14 has to move with it, or the estimate and the page disagree in the direction that loses rows.

**PAGINATE-SLACK is what is currently absorbing the difference** — `CONTENT_H` 880 against a real container of 910 — and this unit consumes it. **Do not tune `CONTENT_H` inside this unit; do not attempt the conversion to measured pagination inside it either.** Every clip probe runs under `emulateMedia({media:'print'})` at a true 816 × 1056 viewport (**PRINTPROBE-MEDIA**) and measures **flow cost, top of block to top of next block, printing both rect and flow** (**RECT-VS-FLOW**).

## 10 · BOUNDARIES — WHAT THIS DOCUMENT DOES NOT ESTABLISH

1. **What selects v1's 20.97 row** (§3). Measured, unexplained, and 19.97 is taken on the stated grounds rather than because the question is closed.
2. **The 62 v2 heading underlines against v1's 48** — a page-count and continued-header difference, not measured, not asserted.
3. **v1's own leading on the cover letter's printed page.** §8 reads the `.docx`, which states intent; the printed artifact states behaviour, and the two have disagreed before on this project.
4. **Nothing here is measured at HEAD** except the four source reads named inline. The v2 artifact is `260905-2202`, two units behind (§0).
5. **CONTCAT-DIVERGE stays at 0.900 by ruling** and is not an exception to §1's frame — it is a ruled divergence, pedigree (a).

---

*Written 2026-09-06 by the Cowork-Arch main line, before any handoff was issued. Instrument, sample sizes and page coverage stated for every number. Nothing in this file was written to the code repo.*
