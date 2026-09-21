# PRINT-REPARITY-DOCS — ADDENDUM 1: text in the Bundle Sheet's flagged column follows the palette's text colour

Tier: claude-opus-5
Model: claude-opus-5
Session: CONTINUE

*Arch, main line, 2026-09-21. Daniel's browser gate on JOY, 2026-09-21: items 1, 2, 4 and 5 pass. Item 3, the
Bundle Sheet, is held on one finding, below. The right margin was checked against v1 and passes: rules end at
729 / 733, the length's right edge at 728.98, the logo box at x 556.98 — the same on both. The 26 pages pair
one to one. Line numbers were read at the working tree today.*

## The finding (pedigree (b), Daniel's 2026-09-21 Save-as-PDF against `260919-1051_v1_bundle-sheets-by-group-model-before-name_JOY_FILEMAKER.pdf`)

When the flagged end has a palette colour, the flagged column is filled with it — that part is right on every
page. **But the text on that fill stays black.** v1 gives the text the palette's own text colour for that fill.
Measured on all 26 pages, the column's fill is not the pale rose on 13 of them, and on the three whose fill is
Green (`#70AF46`) — **p5 `FOH #1`, p17 `SD Tech #1`, p19 `SD Tech #2`** — v1 prints `Flagged: FOH` and the end
text in the column (`Female`, `Grey`) in **white**; Daniel's v2 print has them **black**. On the other ten
(Orange, Chartreuse, Pink) both versions print black, which is what the palette says for those fills, so those
pages pass by luck, not by rule.

Every cable-name chip on all 26 pages already follows the rule (eleven fill/text pairings, identical on both
sides) — the rule is in the palette and the chips apply it; the flagged column does not.

## The change (one file)

`src/components/print-cable/BundleSheetPrintClient.tsx`:

1. `flagTint` (line 292) is `endTintStyle(pg.bundle.flaggedEndColor, true)`, which already returns
   `{ backgroundColor, color }` — the palette's `text` for a palette colour, `#000` for the rose default
   (`docChrome.tsx:368-373`). The two fills spread it (`:328`, `:409`) and the `color` rides along harmlessly on
   an empty div. **The text does not.**
2. `Flagged: <end>` (`:357-359`) and the two end cells in the column (`:410-411`, `cell(first)` — and only the
   cell that sits inside `FLAG_COL`) are `text12` / `text10`, which hard-code `color: '#000'` (`:184-187`).
   Give them `color: flagTint.color ?? '#000'`, applied after the base style so it wins.
3. Nothing else changes: not the fill, not the geometry, not the not-flagged cell, not the name chips.

**Assumption, named:** both end cells sit in fixed columns (`ROW.end1X` 393.00 inside the flagged column,
`ROW.end2X` 527.00 outside it), so only the first takes the colour. If `first` / `second` can swap columns
anywhere in the file, apply the colour by column, not by variable name.

## Gate

- Suite, typecheck, lint, build, frozen 3/3. Visual gate: no event expected (unchanged from the unit).
- A regression test in `v1DocGeometry.test.ts` or beside it: a bundle whose flagged end is Green renders
  `Flagged:` and the flagged-column end text with `color: #ffffff`; one whose flagged end is unset renders them
  `#000`.
- Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT
  section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every
  line."*

**Daniel's gate, on JOY:** Bundle Sheets, pages 5, 17 and 19 — `Flagged: FOH` and the `Female` / `Grey` text in
the green column are white. Page 1 (Booth, rose) is unchanged.

Return as an addendum section in the existing `from-cc/260920-1755_print-reparity-docs.md` return, with the
FILES CHANGED list and the COMMIT BLOCK updated if the staged set moves (it should not — the file is already in
it). One commit, the unit's own subject.
