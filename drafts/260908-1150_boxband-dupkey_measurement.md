# BOXBAND-DUPKEY — the measurement of record

*Measured from the Arch seat 2026-09-08 via the Supabase MCP, because CC cannot: `Cable Parity Fixture` is owned by daniel@ and the harness signs in as the TEST user (HARNESS-RLS-CORPUS). Filed in `drafts/` rather than left in `handoffs/`, which is gitignored and does not survive a fresh clone.*

## The symptom

Daniel's browser gate, 2026-09-08, `Cable Parity Fixture` (`dbf56057-0447-41a9-81b1-a8842a83b958`), Box List, boxes-within-boxes ON: **two bands both labelled `Truck: Truck 2`** with different weights, one box rendered in both, and a React console error — *"Encountered two children with the same key, `Truck 2`"* at `BoxListClient.tsx:1854`.

## The cause — the comparator's equality is COARSER than the band label's identity

- `banded` (`BoxListClient.tsx:1562-1573`) is a **run-length** grouping keyed on the RAW trimmed truck string: a row joins the previous band only when `last.label === label`. The React key is that label.
- `makeBoxComparator('truck')` (`boxSortChains.ts:89`) orders by `compareLabels`, which is `localeCompare` with **`sensitivity: 'base'`** (case- and accent-insensitive) and **`numeric: true`** (`2` equals `02`).

Two rows differing only by case or numeric padding therefore compare **EQUAL** — so the sort may interleave them — while producing **DIFFERENT** band labels. The same label then opens a band twice, and the key collides.

## Confirmed in the live data, not inferred

`box_details` joined to `equipment_items` on `id`, for that project, grouped by `truck` with hex:

| truck | rows | hex |
|---|---|---|
| `Truck 2` | **10** | `547275636b2032` |
| `truck 2` | **1** | `747275636b2032` |

The single lowercase row is **`More Hardware`, box number 409**. It sorts equal to the ten `Truck 2` rows, lands among them, and splits the run into `Truck 2` … `truck 2` … `Truck 2`. That is CC's executable probe reproduced in production data.

Other trucks on this project: `Truck 1` (39) · `Truck 3` (25) · `Truck 4` (26) · `Rehearsal` (15) · `Spotting` (1) · `Tech Racks 2` (1) · null (17). No other case or padding variant exists today.

## It is NOT FIND-PARITY's

Established three ways: `boxSortChains.ts` is byte-identical at `44e206d`; no line of the FIND-PARITY diff touches banding, sorting, nesting or truck; and the mechanism reproduces against the unmodified comparator.

## The fix is the KEY, not the data — and it wants a ruling

⚠ **Do not "fix" this by making the React key unique (`${label}-${i}`).** That silences the warning and leaves two bands the sort believes are one — the defect intact and now invisible.

**The rule this earns: a band's identity must be the comparator's equality class, not the raw string it displays.** Band on the normalized key the comparator actually uses; display the first row's raw text as the label.

⚠ **That is UX-affecting and has no pedigree either way** (Parity Rule): merging them changes what Daniel sees — one band where there were two — and decides which spelling shows. **Wants Daniel's ruling or a v1 measurement of whether v1 bands case-insensitively.**

⚠ **DO NOT correct `More Hardware`'s truck string.** It is plausibly genuine v1 data; it is the only known live reproducer of this defect; and editing the parity corpus is what produced BVSC-8POWER-DRIFT. Leave it and cite it.

## Scope beyond boxes

The equipment list bands the same way. **Unmeasured** — whether its band builder and comparator have the same asymmetry is for the unit that takes this, not asserted here.
