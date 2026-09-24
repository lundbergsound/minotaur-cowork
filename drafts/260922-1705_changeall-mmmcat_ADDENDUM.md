# CHANGEALL-MMMCAT — ADDENDUM: the rulings on CP1, then CP2 as written

Tier: claude-opus-5
Model: claude-opus-5
Session: CONTINUE

*Arch, main line, 2026-09-22 17:05 ET. Your CP1 diagnosis (`from-cc/260922-1250_changeall-mmmcat.md`) is accepted.
Code still at `d25d366`. Every hard stop in `260922-1255_changeall-mmmcat.md` §0 still applies.*

## Rulings on your four open questions

1. **CHANGEALL-NOTE — parked.** Daniel, 2026-09-22: *"I don't remember."* Nothing to fix. Your twelve gestures are the
   record, and Arch carries them to the Ledger. Build nothing for it.
2. **INSPECTOR-ARM — ruled, and it is in this unit.** Daniel, 2026-09-22, *"yes"* to Arch's proposal, in answer to his
   own *"why not have the first cable selected by default?"*:
   - **A1 · The cable list opens with its first cable current**, the first row in the list's own sort after any
     find. That is v1's behaviour: FileMaker always has a current record when a list holds records. It happens once,
     when the list opens. A later find or re-sort that removes the current row follows whatever the list does
     today; **measure** that and don't change it.
   - **A2 · The five inspector `AutocompleteInput` fields** (colour, category, method, group, box;
     `CableInspectorPanel.tsx:299, 316, 330, 362, 404`) **grey out with the rest of the panel when there is no current
     cable**, which now means only an empty list or a find with no results. Your option (a): an additive, default-off
     `disabled` prop on `AutocompleteInput`, with every existing caller unchanged.
   - **A3 · Report only: the equipment list.** Does it open with no current row, like the cable list today
     (`EquipmentListClient.tsx:197` initialises `currentRowId` to `null`)? And does any control there look live and
     do nothing in that state? **Measure and report; change nothing.** Daniel matches the two lists by his own
     ruling, not by this unit.
   - **Blast radius:** frame 13 opens the Boxes tab, not the cable list, so no frame is expected to move. Confirm.
     If a frame does photograph the cable list, it is a declared event: open the frames and say what moved.
3. **CR→LF on a notes Change All — not this unit.** It goes to EXPORT-INTEGRITY, which already carries the
   line-feed and hash-drift issues. Arch registers it. Build nothing.
4. **Change All's scope — the code is right, and the gate step was wrong.** Replacing across the found set is v1's
   Replace Field Contents. Gate step 1 is withdrawn.

Your third case (the outer sort band opens only on its label text) and the 16-vs-17 count go to Arch's close. Build
nothing for either.

## Then CP2, MMM-CAT, exactly as §2 of the handoff

## Close

As in the handoff §3. Regression tests pin A1 and A2, each with a deletion control that goes RED.

**Daniel's gate, on JOY.** Restart `:3100` first.

1. **Cable list.** Open it: the first cable is highlighted and its details fill the bottom panel. Type a method in
   the panel's Method field and choose Change All: it's live, and every cable showing takes it.
2. **Cable list, a find that matches nothing.** The whole bottom panel is greyed, including Colour, Category, Method,
   Group and Box.
3. **Equipment list, sorted by Method.** Click a category band under one method and change the category. Only that
   method's rows change; the same category under another method doesn't.
4. **⌥⇧I** on a model band in method sort opens the category band; ⌥⇧I again goes back.
5. **Sorted by Category:** the category band edits exactly as before.

Proposed subject: `CHANGEALL-MMMCAT: the cable list opens on its first cable; the category sub-band edits in every sort`.
