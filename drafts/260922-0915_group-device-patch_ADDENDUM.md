# GROUP-DEVICE-PATCH — ADDENDUM: two fixes from Daniel's JOY gate, before the commit

Tier: claude-opus-5
Model: claude-opus-5
Session: CONTINUE

*Arch, main line, 2026-09-22 09:15 ET. The unit is not committed. Daniel's gate passed all six steps. He then
printed both documents from v1 and v2 on JOY, and Arch compared them line by line. Two differences are
defects in this unit; fix them here, in the same commit. No migration, no SQL writes; the hard stops in
`260921-1642_group-device-patch.md` §0 still apply.*

**Evidence, pedigree (b)** — JOY `0d329963-dcd1-403d-a5ad-1f78f0b9a425`, matched pairs, printed by Daniel 2026-09-21/22:

- `~/Minotaur_v1_exports/parity-pairs/260922_group-device-patch_gate/260921-2344_v1_device-patch_JOY_FILEMAKER.pdf` (36 pp.)
- `…/260922-0844_v2_device-patch_JOY_chrome-savepdf.pdf` (35 pp.)
- `…/260921-2344_v1_group-parts_JOY_FILEMAKER.pdf` (33 pp.)
- `…/260922-0844_v2_group-parts_JOY_chrome-savepdf.pdf` (33 pp.)

## A1 · Device Patch: a blank sorts LAST, for Device and for Connection

Measured on the JOY pair: of 218 device headings, **68 hold the same rows as v1 in a different order**. In
every one I read, v2 puts the rows with a **blank Connection first** and v1 puts them **last**, e.g. `Fly Auto
Wired`:

- v1: `A Deck SM … from cFly Auto •1` · `B …` · `C …` · `D …` · then `cFly Auto 6-Pair, 50' from SD-7 Stage Left`
  (no connection).
- v2: `cFly Auto 6-Pair, 50' …` first, then A–D.

The same rule applies to Device: v1 prints the **blank-device block** (the 37 tail rows with a connection but no
device: `1 Deck SM (Tail) to cTech Com Ext. •1` …) as the **last heading of the document** (v1 p. 36, after
`Video Rack`); v2 prints it at the top of the unjoined band (v2 pp. 4–5, after `Video Prog`).

Fix: in script 750's print sort, an empty Device and an empty Connection sort after every non-empty value. Then
re-count: **measure** how many of the 68 still differ. For any that do, read the rows and say in DONE what the
remaining tie-break is — do not guess it.

## A2 · Group Parts: a long model wraps, as v1 does

`Sennheiser BA 70 Rechargeable Battery Pack for EW-D Bodypack and Handheld Transmitters` (JOY p. 4): v1 wraps
it — line 1 ends at x 538.4, `Transmitters` on a second line at x 73.0, **+16.5** below — and the row grows. v2
prints it on one line ending at **x 609.0**, off the page's printable area. **Measure** v1's wrap width on that
row (and any other wrapped model in the pair) and wrap the model field at it; the notes beneath and the row rule
move down with it.

Everything else in the Group Parts pair matches: 615 v1 lines against 614 v2, with the same quantities and
models on every line. The only other differences are the ruled number-aware order (R2: `6-Pair` before
`19-Pair`; `SD9T` before `SD10`) and `150ft'` → `150'`, which is v1 printing a stray unit in the data.

## Out of this addendum, and why

- **`Tech Rack` short 12 lines and `Panel SD-6` missing**: every missing row belongs to the mult `cPreview`,
  which is not in v2's JOY at all. That is IMPORT-TRAILSPACE's known import gap, not this printout.
- **14 devices show a different `Model:`**: several pieces of equipment share the device's name (three are
  named `ALD 1 Tech Wired`). v1 shows the first one entered. v2's JOY rows were all created in one import
  transaction, with the same `created_at`, so v2 cannot tell which came first. Arch's, with the import.
- **`GAL 1` / `GAL 2` / `GAL 4`**: v1 matches `GAL n` to a Galileo and prints `Gal n` with no model; v2's JOY
  item reads `Gal n`, so the match flips. This looks like the data differing between the two JOYs, not the code.
  Keep the exact match.

## Close

Re-run the full gate set as in the original handoff §6. The visual gate is expected to move nothing beyond the
declared frame-01 pair already written. Return an ADDENDUM section in the same return file: DONE / FILES
CHANGED / OPEN QUESTIONS / RAW OUTPUT, with the A1 re-count and the A2 wrap width pasted verbatim, and the
updated COMMIT BLOCK. Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the
handoff file's RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or
describe it. Show every line."*

**Daniel's re-gate, on JOY:** Device Patch — `Fly Auto Wired` lists A–D first, then the cable; the last page
ends with the tail rows that have no device. Group Parts p. 4 — the BA 70 line wraps onto a second line.
