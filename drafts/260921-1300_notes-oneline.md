# NOTES-ONELINE: a multi-line note on the equipment list shows one line unless its row is selected

Tier: claude-opus-5
Model: claude-opus-5
Session: FRESH

*Arch, main line, 2026-09-21. Runs **after BUNDLE-TAILFOLDER-LABELS has committed** — one writer, one fence.
Read HEAD and origin from the ref files (expect them equal, at that unit's commit); the migration ledger is
**83** — read it live. Line numbers were read at `d2c897b`; re-read them at HEAD. **No migration, no SQL
write; nothing stored changes.** The print path is untouched.*

**What this is.** A cohort request (Jamie Tippett, via Daniel) that never reached the Docket. Ruled today.

## §0 · HARD STOPS

1. **No migrations and no SQL writes. The stored note bytes never change** — this is display only, and the
   §2 FROZEN row-hash contract (`src/lib/import/spec.ts`) depends on that.
2. **Test shows only**: JOY `0d329963-dcd1-403d-a5ad-1f78f0b9a425` and the other `daniel+test01@` projects.
   **Never Buena Vista Social Club, and never a cohort member's show.**
3. **Visual gate: an event is possible.** Frames 02, 03 and 08 photograph the equipment list on the Visual
   Gate Fixture (`visual-capture.mjs:790, 798, 989`). If the fixture holds any multi-line note, those frames
   move and it is a declared event — look at every moved frame and confirm it differs only in note rows
   growing shorter. **Any other movement is a stop.** If the fixture holds none, expect 28/28.
4. Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT
   section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every
   line."*
5. GATE-NOGREP. Commit only on Daniel's `COMMIT APPROVED: <first words>`, after his gate.

## §1 · Ruling of record (pedigree (a))

**Daniel, 2026-09-21, verbatim:** *"making multi-line notes condense to one line unless selected in the
equipment list … this was a Tippett request that should be in the docket, and I'd like to move it to the next
handoff and deploy ASAP."*

**Assumptions, named — each one word to correct:**

- **"Selected" = the current row** (`isCurrent`, `EquipmentItemRow.tsx:22, 1032`), the row with the selected
  background. Not hover, not a checkbox.
- **"One line" = the first line of the note, truncated with an ellipsis at the cell's width**, the way Group,
  Circuit and IP already truncate (`:501`, the non-wrap branch). Line breaks are not joined into one run.
- **Editing is unchanged**: clicking the cell still opens the auto-growing textarea with the whole note
  (`:389-392`, `:410`).
- **Both notes columns** — Public Notes and Private Notes (`:745-751`), the two `wrap` fields.

## §2 · The change (one file)

`src/components/equipment/EquipmentItemRow.tsx`, `InlineText`'s display span (`:479-507`):

1. The wrap branch's class (`:501`, `whitespace-pre-line break-words h-full min-h-[1.125rem]`) applies only
   when the row is current. Otherwise the span takes the non-wrap branch's `truncate h-full min-h-[1.125rem]`
   and shows **the first line only** (split `display` on the normalised `\n`; `normalizeLineBreaks` at `:478`
   already gives bare `\n`). Keep the `min-h` floor on both — GROUPCELL-BLANK and the (hh) fix live there.
2. `InlineText` needs to know the row is current: pass `isCurrent` down from the row (`:921`), or read it
   however the row already threads state to its cells — code structure is yours.
3. `title` on the condensed span carries the whole note (the non-wrap branch already does `val || title`), so
   hovering shows it without selecting.
4. **Row height follows:** a row that is not current is now one line tall regardless of its notes; the current
   row grows to fit, as every row did before. Nothing else in the row moves.

## §3 · Gate

- Suite, typecheck, lint, build, frozen 3/3 (`InlineText` is not in the frozen set; `updateItem` is — do not
  touch it). Visual gate per §0.3. Dependency gate empty.
- A regression test: a three-line note on a non-current row renders one line with the truncate class and no
  `whitespace-pre-line`; the same note on the current row renders all three; the stored value is byte-identical
  through a render-select-deselect cycle.
- **Measure on JOY** (or a throwaway if JOY has no multi-line note — say which): the row height of a
  three-line-note row before and after, not current, and current.

**Daniel's gate, on JOY.** Restart `:3100` first.

1. **Equipment list.** A row with a multi-line note shows one line, ending in `…`, and the row is the same
   height as its neighbours.
2. **Click the row.** It becomes the current row and the note opens out to all its lines; click another row
   and it condenses again.
3. **Click the note cell.** The editor opens with the whole note, as before. Escape closes it unchanged.
4. **Print the equipment list.** Notes print in full, as before.

Proposed subject: `NOTES-ONELINE: multi-line notes on the equipment list condense to one line unless the row
is selected`.
