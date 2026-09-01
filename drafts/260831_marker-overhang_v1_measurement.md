# MARKER-OVERHANG — v1 MEASURED. It is a DEFECT, and it is NOT inherited.

**Main line, 2026-08-31, while CC ran EQUIP-LABELS-2. Read-only; no repo write.**

MARKER-OVERHANG was registered on Daniel's 2026-08-31 print as **"NOT a defect
yet"**, on the explicit condition that *v1 must be measured first, because a
text-width marker in v1 would overhang identically.* **v1 is now measured, and
it does not overhang, because v1 does not render the marker the way v2 does.**

## The two artifacts

| | file |
|---|---|
| v1 | `cable-box/Cable PDFs/Tail Line Labels by Model.pdf` — 27 pp, 612×792, Buena Vista Social Club, printed 7/11/2026 |
| v2 | `parity-pairs/260831_stock-is-die-proof/260831-1316_v2_tail-line-labels_STOCK-IS-DIE_LOCALBUILD_chrome-savepdf.pdf` — 41 pp, 612×792, at `9a333cc` |

The same named marker appears in both, so this is a matched element and
FOUNDSET-NOT-COUNT does not apply to the comparison.

## THE MEASUREMENT

**v1, page 13, column 1 — the marker occupies TWO LINES at ONE x origin:**

```
y = 44.50   size 10.00   x 27.00 → 137.90   w 110.90   'CAT5-1x XLRF+1x XLRM'
y = 56.50   size 10.00   x 27.00 →  76.13   w  49.13   'Tail Labels'
```

Same left edge, **12.00 pt apart**. It is one string — `CAT5-1x XLRF+1x XLRM
Tail Labels` — **WRAPPED**. It is the only wrapped marker in v1's entire 27-page
document, and it is the same model v2 renders as one long line.

**v2, page 1 — the same string on ONE line:**

```
y = 44.00   size 10.00   x 27.25 → 190.19   w 162.95   'CAT5-1x XLRF+1x XLRM Tail Labels'
```

**Avery 5167 column 2's sticker begins at x 168.75. v2's marker ends at 190.19 —
21.44 pt onto the neighbouring sticker.** (The registered figure was 22.50 pt
from x 26.25 / width 165.00; measured off the artifact it is **x0 27.25,
x1 190.19, width 162.95, overhang 21.44**. Correct the record.)

**v1's clearance on the same sheet:** its own column 2 cell begins at
22.00 + 145.13 = 167.13; the marker's first line ends at 137.90 — **29.23 pt
clear**, and its second line ends at 76.13.

## v1's marker origins, confirming the pitch independently

Widest first-line marker at each of v1's four column origins:

| column origin | widest first line | right edge |
|---|---|---|
| 27.00 | 110.90 | 137.90 |
| 172.13 | 88.50 | 260.63 |
| 317.26 | 94.50 | 411.76 |
| 462.39 | 79.49 | 541.88 |

Origin deltas: **145.13 · 145.13 · 145.13** — v1's Tail Line pitch to the
hundredth, reproduced from a different element than the one STOCK-IS-DIE used.
**No v1 marker on any of the four columns reaches the next column.**

## THE MECHANISM, AND WHAT IT MEANS

**v1's marker is a WRAPPING BLOCK BOUNDED TO ITS COLUMN. v2's is a SINGLE-LINE
TEXT-WIDTH CHIP.** v1 has never overhung because it wraps; v2 overhangs because
it cannot.

So the standing caution is discharged in the opposite direction from the one it
anticipated: **the shape is not inherited, v1 offers no licence for it, and this
is a real parity defect with a v1 pedigree for its fix.**

## THE FIX'S PEDIGREE — (b), measured, with an honest bound

- The marker wraps at the same left edge, **line pitch 12.00 pt** at 10 pt text,
  second line left-aligned on the first.
- **The wrap width cannot be pinned exactly from one instance.** It is bounded:
  at least **110.90** (line 1 fits) and less than the width of
  `CAT5-1x XLRF+1x XLRM Tail` (~133 pt, since ` Tail` adds ~22 pt at this size).
  **The 126.00 pt sticker width sits inside that bound** and is the obvious
  candidate — but it is a candidate, not a measurement, and it should be written
  as one. A second wrapped instance in any corpus would close it.

## WHY THIS IS URGENT RATHER THAN TIDY

It is the one element on the sheet that lands on a **neighbouring sticker**, and
on the current artifact it collides with nothing only because column 2's first
row happens to be empty. **It is one data value away from printing a model name
across a real label** — and every remaining 5167 output (Steck Labels, Equipment
Labels, Small Cable, Small Tail Block, Tail Line) is being built onto this die.
It should be fixed before any of them goes to real stock.

## STANDING RULE THIS EARNS

**A shape shared with v1 is not a behaviour shared with v1.** MARKER-OVERHANG
was held back from being called a defect because v2's marker is text-width "like
v1's." Both are text; only one wraps. **The pedigree question is never "is this
element v1's element" — it is "does it do what v1's element does, measured on
the artifact."**
