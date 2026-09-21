# NOTES-ONELINE — ADDENDUM 1: the `↵+N` marker sits at the cell's right edge and reads as a control, not as note text

Tier: claude-opus-5
Model: claude-opus-5
Session: CONTINUE

*Arch, main line, 2026-09-21. Daniel's gate on JOY passes (*"this passes"*), with one change to the marker.
Same commit, the unit's own subject.*

## Ruling (pedigree (a))

**Daniel, 2026-09-21, verbatim:** *"I'd like to move the glyph to the right, and make it clearer that it isn't
part of the note. would bold/dark grey help?"*

## The change (one file, one span)

`src/components/equipment/EquipmentItemRow.tsx`, the condensed branch (`:498-510`):

1. **Right edge.** The marker span (`:506`) gets `ml-auto` so it sits at the cell's right edge; the first-line
   span keeps `truncate min-w-0` and takes the room that is left. The row's `flex items-baseline gap-0.5`
   (`:499`) stays.
2. **Reads as a control.** Arch's proposal (c), for Daniel to correct at the gate: **a small pill**, not bold
   inline text — `rounded-sm px-1 bg-surface-200 text-surface-600` (the muted fill and darker text the app's
   other chips use), 9 px, `font-medium`, `tabular-nums`, glyph 8 px as today. A pill is unmistakably not part
   of the note; bold dark-grey inline text still sits on the note's own baseline and can read as its last word.
   If Daniel prefers plain text, the fallback is his words: `font-semibold text-surface-600`, no fill.
3. Nothing else moves: row height 21 px condensed, the title, the test's `data-notes-hidden-lines` attribute,
   the expanded branch.

## Gate

- Suite, typecheck, lint, build, frozen 3/3. Visual gate: frames 02 / 03 / 08 move again (the marker moved and
  changed fill) — one declared event on the same six frames, each looked at, differing only in the marker.
- The existing regression test still passes; add one assertion that the marker span carries `ml-auto`.
- Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT
  section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every
  line."*

**Daniel's gate, on JOY, both themes:** the `↵+5` marker sits at the right edge of the Notes cell as a small grey
pill; the note text is plainly separate from it. Say "plain" if you want text with no pill.

Return as ADDENDUM 1 in `from-cc/260921-1451_notes-oneline.md`; the commit block moves only if the staged set
moves (it should not).
