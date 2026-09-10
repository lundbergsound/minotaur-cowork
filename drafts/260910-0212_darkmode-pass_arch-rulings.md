# DARKMODE-PASS — Arch's read. ⚠ THE HANDOFF'S PREMISE WAS ARCH'S, AND IT WAS WRONG.

*Cowork-Arch, 2026-09-10. **Carried out of `handoffs/from-cc/260909-2203_darkmode-pass.md`, which is GITIGNORED.** Unit BUILT, uncommitted, browser gate owed.*

## 1 · ⚠ ARCH'S ERROR, IN FULL, BECAUSE IT SHAPED THE WHOLE UNIT

The handoff's §0 computed WCAG contrast for six `buildHCEquipPalette` token pairs, found the worst case **7.45**, concluded contrast was not the problem, and sent CC off with a **size hypothesis**.

⚠ **NOT ONE OF THOSE SIX PAIRS RENDERS ON ANY ELEMENT DANIEL'S EIGHT NOTES NAME.** The equipment list publishes eleven `--equip-*` variables and `filterText`, `filterBg`, `headerText` and `filterInputText` are not among them (`EquipmentListClient.tsx:2796-2833`). The project menu publishes none of the palette. The find panel imports nothing from the theme module. **The elements are on the Tailwind `surface-*` / `brand-*` scales.**

Measured on the running app, the worst case is **1.26**, and **eleven elements fail AA in dark mode.** ⚠ **Two measure APCA Lc 0.0 exactly** — not a rounding, but APCA's low clip, the value returned when contrast is below the level at which it will report a number at all.

**The mechanism of the error:** an earlier session triaged the eight notes to tokens in `hcTheme.ts`; this seat measured those tokens **without ever verifying that they reach the elements.** *An instrument must not inherit the claim's parameters* — and the parameters inherited here were a prior triage's, not a measurement's. **Fifth occurrence on this project; third on this seat in one session** (the leg-3a needle priced against the wrong table, the flake (2) attribution taken from a non-discriminating invariant, and this).

**What saved it:** the handoff ordered a census of what actually renders each note **before** touching `hcTheme.ts`, and forbade concluding the colours were fine. CC ran the census, refuted §0 on its own instrument, and said so first. *The instruction to census outlived the reasoning that produced it.*

## 2 · ⚠ THE LIGHT-MODE ANSWER WAS RIGHT AND THE REASONING WAS WRONG — and the correction is a standing rule

Daniel asked whether light mode needed the complementary change. Arch said no, on the ground that light measured better. **It does not.** Measured on the same elements: **light 1.45–1.67, dark 1.55–1.84 — light is very slightly WORSE by WCAG.** And Daniel has never once raised light mode.

**APCA explains what WCAG cannot, because WCAG's ratio is blind to polarity:**

| | light | dark |
|---|---|---|
| filter labels | Lc 25.2 | **Lc −8.1** |
| column header / footer | Lc 19.9 | **Lc 0.0** |
| category drop-down | Lc 29.4 | **Lc −9.0** |

**Two to three times worse in dark on the identical hex pair.** ⚠ **NEW STANDING RULE: FOR DARK-MODE TEXT, THE WCAG RATIO IS NOT THE INSTRUMENT — IT CANNOT SEE POLARITY.** Report Lc alongside it or the number will vindicate an unreadable pair. **Daniel's eye agreed with APCA against WCAG, and was right.**

## 3 · The root cause is one sentence this repo wrote two units ago

`globals.css:41-47`, added for P12 / M0-WIN:

> *"A dedicated muted token rather than `--surface-300`, which is a light-mode tint (`#cbc8c2`) and its `.dark` counterpart (`#44444e`) is a background tone — **neither reads as text in the other mode**."*

**That comment diagnoses the entire cluster.** It was written for the N/A method row and **never generalised**. Three of the eight notes, and five more elements nobody raised, are `--surface-300` used as a text colour. ⚠ *A finding recorded in a comment beside the one place it was noticed is a finding that will be re-derived.*

## 4 · ⚠ THE 105 DEAD CLASSES — AND WHY SWEEPING THEM WOULD MAKE THINGS WORSE

`text-surface-400/500/600/700` **emit no CSS** — the scale defines 0/50/100/200/300/800/900/950 and nothing between. **105 sites across 40 files** silently inherit the parent's colour.

⚠ **A dead class therefore renders at FULL body colour — WCAG 12.81 in dark. "Repairing" it to the muted tone its author intended would LOWER it to ~4.85.** That is the opposite of this unit's job, so **all 105 were left untouched, including two CC was already editing.** The question is which of them *should* be dim, and it is Daniel's.

⚠ **And the count is CODE-ONLY: a raw grep returns 109, four of which are comments — two written by this unit's own explanatory block.** SCAN-COMMENTS applies to a census as much as to a guard.

**The instrument that found them was itself wrong first:** the first probe walked `document.styleSheets` and reported "0 rules" for all six classes asked about — *including `text-surface-300`, which the census had just measured working.* Its own positive control caught it. *A control that passes is not a control; a control that contradicts a known-good case is one.*

## 5 · What was built, and what it deliberately did not touch

Four tokens gain **a dark half only**; every light half is byte-identical to what shipped. Values **adopted rather than invented** — `--text-muted` dark takes `--na-method-text`'s own dark value, the FOUND strip takes `--row-current-bg`'s, the border takes brand-800, the link brand-300.

| element | before | after |
|---|---|---|
| filter labels · project/theatre · SORT · Showing | 1.71 / Lc −8.1 | **4.50 / Lc −35.5** |
| column-header row · footer | 1.55 / **Lc 0.0** | **4.07 / Lc −34.2** |
| category drop-down · ✕ · shortcut hint | 1.84 / Lc −9.0 | **4.85 / Lc −36.4** |
| FOUND count | 1.26 / Lc 12.1 | **9.89 / Lc −80.2** |

⚠ **The tokens were deliberately NOT added to `tailwind.config.js`** — adding a `surface.400` step would have silently activated ~110 dead classes app-wide in one edit. **That restraint is the difference between this unit and a regression.**

**No font size or weight changed**, as instructed.

## 6 · ⚠ THE SIZE PREDICTION WAS ALSO WRONG, AND THE MEASUREMENT IS THE USEFUL PART

The handoff predicted the census would find size to be the answer, at a rows-per-screen cost. **Both halves need correcting.**

**Measured on the running page rather than estimated** — every candidate size applied to the real sub-12px chrome elements and the scroller re-measured:

| candidate | scroller | change | rows on screen |
|---|---|---:|---|
| as built | 742 px | — | 10.8 |
| 11 px | 740 px | **−2** | 10.7 |
| 12 px | 739 px | **−3** | 10.7 |

⚠ **TAKING EVERY CHROME LABEL TO 12px COSTS THREE PIXELS AND NO ROWS.** The filter bar is line-height-bound — its 9px labels sit in a 17.6px line box and grow into slack that already exists. **The density objection does not survive measurement.**

⚠ **The boundary of that measurement is itself a claim, and CC stated it: it covers the CHROME BANDS ONLY.** Raising the 8–11px text *inside rows* would cost rows directly and was not measured, because no note asks for it.

**Honest limit on the colour fix:** eleven elements render at 8–11px and **APCA publishes no size row below 12px.** The repair moves them from below the invisibility threshold to "minimum for any text, not for body copy" — a real, large improvement — **but no colour value brings a 9px label inside the model, because the model does not extend there.**

## 7 · Rulings owed by Daniel

1. **The browser gate — a real precondition**, and half is not machine-checkable: whether `#8a8580` is legible *enough*, and **the orange button, whose Orange case exists only on his own project.** The fixture is Blue, so every frame stayed identical.
2. **Muted dark, priced:** as built `#8a8580` (4.07–4.85) · `#9a958f` (5.0–6.0) · `#a8a39c` (5.9–7.1). Cost of each is glare; no density cost.
3. **Light mode:** untouched at 1.45–1.67. Adopting `--na-method-text`'s light `#6f6b64` gives 4.61–5.30 — **a bigger visual change than the dark half, and it moves all fourteen light frames.**
4. **Chrome type 9px → 11 or 12px:** 3 px, zero rows.
5. **NOTE 8's hit target:** the ✕ measures **9 × 18 px** against a 24 × 24 minimum in every guideline that names one.
6. ⚠ **GREEN — the ruled palette and the measurement disagree, live.** `MINOTAUR_COLORS` pairs Green `#70AF46` with **white**; both luminance fallbacks say **black**; black measures **7.91** against white's **2.66**. `contrastColor()` already returns black, **so the app already diverges from the palette on Green.** `Matched Pair Fixture` is a Green project. **Not silently reconciled — the ruling belongs to CONTRAST-PAIR's own close.**
7. **The 105 dead classes:** which should be dim (§4).
