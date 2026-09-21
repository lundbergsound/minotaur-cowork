# PRINT-REPARITY-DOCS — ADDENDUM 2: the Bundle Sheet's `Flagged:` header wraps inside its column and sits on the header line

Tier: claude-opus-5
Model: claude-opus-5
Session: CONTINUE

*Arch, main line, 2026-09-21. Daniel's second gate on the Bundle Sheet, 2026-09-21: the white-on-green fix
passes (*"this is an improvement"*). Two more findings on the same header, below. ADDENDUM 1's commit block
still stands; this rides the same commit. Line numbers were read at the working tree today.*

## Finding 1 — the `Flagged:` header does not wrap (pedigree (b))

`Flagged: Tech Com Rack` on JOY p24 (`Tech Com`). v1 wraps it inside the column: `Flagged: Tech Com` on line 1
at top 169.53, `Rack` on line 2 at top 184.53 (a 15.00 pt line pitch), both starting at x 392.97 and ending
inside the fill's right edge at 512.97. Daniel's v2 print sets it on one line: `Rack` runs from 510.32 to
539.84, **27 pt past the fill's edge**, and over the not-flagged column. Cause: `text12` is `absText(12)`
(`BundleSheetPrintClient.tsx:201`), which carries `whiteSpace: 'nowrap'` (`:185`), and the header div (`:379`)
has no width.

## Finding 2 — RULED, Daniel, 2026-09-21, a deliberate divergence from v1 (pedigree (a))

> *"make the flagged end header bottom-aligned, so one-line flagged ends are even with the non-flagged end and
> other headers, and they wrap upward when they're two-line"*

v1 top-aligns the header at 169.53 and wraps downward, so a one-line `Flagged: FOH` sits 16 pt above `Booth`,
`Cable` and `Model`, and a two-line one ends level with them. Daniel's rule: the header's **last line sits on the
header line** — the same line as the not-flagged head (`Booth`, top 185.50) — and a second line stacks above it.
Write it into the source with his words and the date so nobody "fixes" it back from the artifact.

## The change (one file)

`src/components/print-cable/BundleSheetPrintClient.tsx`, the `Flagged:` header div at `:379-381`:

1. **Width and wrap.** `width: PT(FLAG_COL.x1 - FLAG_COL.x0)` (the fill's own 121.00), `whiteSpace: 'normal'`,
   `lineHeight: PT(15)` — v1's measured line pitch. Text starts at `HEAD.flaggedX` as today.
2. **Bottom-aligned on the header line.** Anchor the div by its **bottom**, not its top: `bottom` = the flow
   box's height minus the not-flagged head's baseline box, so the last line's glyph top lands at v1's
   `notFlaggedHeadTop` (185.50) exactly where `Booth` / `BlackBox` sit (`:382`). The simplest form is a div
   positioned with `bottom:` and `display: flex; alignItems: flex-end`; use whatever keeps one measured number,
   and say which.
3. **Retire `HEAD.flaggedTop`** (`:128`) or re-comment it as v1's top-aligned position kept for the record; it
   is no longer a render input.
4. The ADDENDUM 1 colour rule (`color: flagTint.color`) stays on the div.

## Gate

- Suite, typecheck, lint, build, frozen 3/3. Visual gate: no event expected.
- Extend `bundleSheetFlagInk.test.ts` or `v1DocGeometry.test.ts` the same way ADDENDUM 1 did (source scan,
  comments stripped): the header div carries the column width, `whiteSpace: 'normal'`, and is anchored by
  `bottom`, not `top`.
- **Measure on the emitted PDF**, both cases, on the throwaway: a one-word flagged end (`FOH`) — `Flagged: FOH`
  glyph top within 0.75 of `Booth`'s (185.50 on v1's scale); a three-word one (`Tech Com Rack`) — two lines,
  the second (`Rack`) on the header line, the first 15.00 above it, both ending inside x 512.97. Paste the word
  table.
- Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT
  section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every
  line."*

**Daniel's gate, on JOY:** Bundle Sheets. **p24 `Tech Com`** — `Flagged: Tech Com` / `Rack` on two lines inside
the green column, `Rack` level with `Booth`. **p5 `FOH #1`** — `Flagged: FOH` on one line, level with
`BlackBox`, white on green. **p1 `Ampland`** — `Flagged: Booth` level with `BlackBox`.

Return as ADDENDUM 2 in `from-cc/260920-1755_print-reparity-docs.md`; the COMMIT BLOCK moves only if the staged
set moves (it should not). One commit, the unit's own subject.
