# PAPERWORK-1 — ADDENDUM 2: Daniel's browser gate FAILED on two items; fix them and run the full comparison

Tier: claude-opus-5
Model: claude-opus-5
Session: CONTINUE

*Arch, 2026-09-18 20:25 ET. This replies to the 18:52 addendum section of
`from-cc/260918-1748_paperwork-1.md`. The tree is still uncommitted and the ledger is still 78. §0 of
the original handoff still binds. **No commit phrase has been given.***

## §0 · Daniel's gate, his words (record these verbatim in the return)

> "BVSC is a live show, so we should test using test shows. I've done some tests in Joy. the "current"
> cut off is an odd regression. paperwork example is fine. bundle summary print preview is cut off, but
> PDF looks OK — run full comparison. here's a line list."

**Standing from now on: gate prints and probes use test shows only (JOY, and the other test01
projects). Never Buena Vista Social Club.** Your fence text and every gate list you write should say so.

His four Chrome Save-as-PDF prints, all from your `:3100` build, are filed at
`~/Minotaur_v1_exports/parity-pairs/260918_paperwork-1_gate/`:

- `joy.pdf`, 19 pp, basic.
- `joy revised.pdf`, 20 pp, detailed with revisions.
- `bundle summary.pdf`, 2 pp.
- `line list.pdf`, 79 pp.

Arch has already checked the counts against JOY:

| Output | Printed | JOY data |
|---|---|---|
| Bundle Summary rows | 26, "Continued" on p.2 | 26 bundles, 1 group |
| Line List pages | 79 | 79 mults, 603 lines |

Both match.

## §1 · The FAILURES

**F1 · The `Current` column is cut off in the detailed revision print.**

- On `joy revised.pdf` p.1, the header reads `v1 Curren`.
- The **Current quantities themselves** are cut at the right edge: `2`, `15`, `12` are partly clipped.
- The green revision band stops at the clip, while the grey row rule runs about 2 pt past it.

Daniel calls it a regression. Your OQ4 called it pre-existing. **Settle that with an A/B, not an
argument:**

1. Seed one throwaway, as the test user, with a revision where the Current quantity is 2 or 3 digits.
2. Render the detailed revision print twice, same data, same database:
   - once on the **live site**, which still runs `7c96904`;
   - once on your `:3100` build.
3. Measure the right edge of the Current column's text and title against the clip in each, and quote both.
4. Say which change caused it. The DOTRULE clip widening and the row-box overhang are the suspects.

**Fix: every character of the Current column, title included, sits inside the page, in the print and in
the preview.** Choose one mechanism, and don't widen the clip past the page's printable area. Two options:

- move the column left by exactly the overflow;
- size the column to its content.

Either is fine; say which one you chose. The rule must also stop where the band stops, or the band must
reach where the rule does. They should end at the same x. Then gate: frame 07 is expected to move under a
round 3 of the same declared event.

**F2 · Bundle Summary's mark boxes are cut off.**

- In the on-screen preview (Daniel's screenshot) the Bundled/Tested boxes are cut at the right edge.
- **The PDF also cuts them.** At 300 dpi, `bundle summary.pdf` p.1 shows every box's right border missing.
- In v1's `cable-box/Cable PDFs/bundle summary.pdf` p.1, every box is whole, and its right side sits at
  about x 585.6 pt.

Measure v1's box rectangle exactly, then place v2's box at v1's rectangle. Nothing may be clipped, in the
preview or the PDF. **The same check applies to Line List's `Pulled`/`Labeled` boxes** and to every
other mark box in the family: prove none is clipped.

## §2 · The FULL COMPARISON Daniel asked for

For **Bundle Summary** and **Line List**, compare Daniel's JOY PDFs against the v1 arbiters
(`bundle summary.pdf`, `Mult Detail.pdf`). The data is different, so compare **anatomy and geometry,
object by object**:

- fonts, sizes and weights;
- x of every label and value;
- row pitch;
- rule weights, colours and spans;
- title, header and footer;
- chips and mark boxes;
- page breaks and the "Continued" title.

Tabulate every item with v1, v2, the Δ and a verdict. Fix every divergence over 0.5 pt, or any
difference of style, where v1 is unambiguous. List anything that is data-driven or needs a ruling, and
don't fix it. Arch's eye has already flagged these three for you to confirm or refute:

1. Line List: v1 sets the mult name on the cable's colour chip (`4W` on green); JOY's p.1 name is plain.
   Is that data (no colour) or a missing chip?
2. Bundle Summary: a long name is truncated (`SD Preview:The Seque…`). Does v1 truncate, wrap or shrink?
   If the v1 arbiter has no long name, say so. It's then a (c) choice, and it stays truncated.
3. Both: JOY has no top-right header text. Confirm the right slot renders when a project has it, on a
   throwaway.

## §3 · Close

Run the full suite, typecheck, lint, build, frozen 3/3, and the gate. Put everything in RAW OUTPUT and add
a revised COMMIT BLOCK. **Daniel's re-gate, on JOY only:**

1. Detailed with revisions: `Current` is whole on every page.
2. Bundle Summary: the boxes are whole in the preview and the PDF.
3. Line List: one look at the PDF.

**Safari is dropped from the gate.** The preview clip Daniel found in Chrome replaces it.
