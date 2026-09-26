# CHANGEALL-REFUSAL — a refused Change All says so where the operator is looking; two more silent fallbacks close; two things measured

Tier: claude-opus-5
Model: claude-opus-5
Session: FRESH

*Arch, main line, 2026-09-24 18:05 ET. Code base `3809860` = `origin/main` (read from the ref files). Migration
ledger **83**, live-read at open. Every citation below was read at `3809860`. Hard stops: no migration, no SQL
writes, the frozen layer stays closed, test shows and throwaways only (never Buena Vista Social Club, never a cohort
member's show), GATE-NOGREP, and the commit waits on Daniel's phrase.*

**Why this unit exists.** CHANGEALL-NEWMETHOD shipped in `3809860` with two gaps Daniel found at his gate
(`handoffs/from-cc/260924-1752_changeall-newmethod_CLOSE.txt`, his words verbatim there):

- Step 3: *"fail - nothing happens, it reverts."* The refusal worked — nothing was written — but the message went to
  the 10 px red `actionError` span beside the cable count (`CableListClient.tsx:4329-4331`), and he never saw it.
- Step 5 was not run. He could not find "the paler category line" from words, twice. **MMM-CAT is in production
  and ungated.**

Daniel approved this scope on 2026-09-24 ("yes, go ahead") against Arch's four-bullet proposal, including CP3 and
CP4 below.

## CP1 · The refusal lands in a dialog, not in the toolbar

**Ruling (Arch, pedigree (c), on existing-surface evidence):** the unmatched-name refusal uses the cable list's
**existing single-OK refusal dialog**, the one Change All already uses for its snapshot refusals:
`<ConfirmDialog open={snapshotRefusal != null} … confirmLabel="OK" singleAction>` at `CableListClient.tsx:4718-4726`,
set from the Change All path at `:3291`, `:3345`, `:3647`, `:3823`. That is the idiom the operator already meets
when Change All says no; the `actionError` span is for a write that *failed*, and it stays for that. No new component.

- Both call sites move: the inspector's own commit (`:2556`) and the Change All capture's `refuse` (`:3479`).
  Measure first whether they can share `snapshotRefusal` or need a sibling state; either is fine, one dialog on
  screen at a time.
- Wording unchanged: `unmatchedNameMessage` (`src/lib/cable/cableChangeAll.ts:126-128`) — *There's no method called
  "Nutes".*
- After OK: the field shows the stored value (as today), and **focus returns to the field he was in**, so the
  next keystroke is his, not the browser's. Measure that it does.
- All four fields (method, category, colour, model) and both paths (Enter in the field; Change All with the field
  still open).
- Tests pin the dialog's presence and text, not only the absence of the write. Deletion control RED for each path.

## CP2 · One annotated screenshot of the category sub-band (no behaviour change)

On a seeded throwaway, equipment list, **Method sort**, at least two methods with a category inside each. Capture
**one** screenshot with the category sub-band **circled or arrowed** (plain annotation is fine), and write it to
`docs/reference/evidence/equipment/` named in that folder's existing convention (`s4auto_gate_02_band_stack.png` is
a neighbour). In the return, give **the exact on-screen text** of the band in the shot and of the row directly
above and below it, so Arch can write Daniel's step in the words he will see.

## CP3 · Change All greys out when nothing is found

Today the cable list's Change All button is `disabled={!changeAllArmed}` (`:4389`), and `changeAllArmed` latches true
(`:3379`), so after a find with no results the button stays live and a press does nothing, silently — reported in
the CHANGEALL-NEWMETHOD CLOSE. **Ruling (pedigree (b) + B1):** it disables when no cable is current, as every sibling
list already does — `disabled={!changeAllArmed || !currentRowId}` at `TailListClient.tsx:1035`,
`BoxListClient.tsx:1764`, `BundleListClient.tsx:1242`, `LineListClient.tsx:1299` — which matches B1's greyed panel.
Measure the equipment list's (`EquipmentListClient.tsx:3264`) and library's (`EquipmentLibraryClient.tsx:542`)
buttons for the same latch; **report, do not change** them. Test + deletion control RED.

## CP4 · A bad length refuses instead of falling back

`captureCableDraftRow`'s `case 'length'` (`:3521-3532`) ends `break // invalid → revert (stored)`: a draft
`parseLengthInput` calls `invalid` (`fifty`, `-5`, `1,000` — `cableLength.test.ts:62-64`) leaves `patched` equal to
the stored row, so Change All offers to write **the stored length** across the found set. Same data-loss shape as
`Nutes`. **Ruling (Arch, pedigree (c)):** it refuses through the CP1 dialog. Proposed text *"fifty" isn't a
length.* — keep it in `cableChangeAll.ts` beside `unmatchedNameMessage`. Check the single-edit path
(`handleCommitLength`) for the same fallback and report what it does; change it only if it also silently reverts,
and say so. Test + deletion control RED.

## CP5 · Measure only, then stop — two registrations

1. **Tab after the scope dialog.** Daniel, at the 2026-09-24 gate, equipment list: *"I tried clicking into a method
   and changing it for an item, it asked me just that item or all, I said just that item, and then when I hit tab,
   I was in the top menus."* Reproduce on a throwaway. Say whether focus is **dropped** (to `body`) or **moved**,
   name the file and line where the dialog closes, and stop. It goes on the Docket.
2. **Does the equipment list have the `Nutes` fallback?** CHANGEALL-NEWMETHOD fixed the cable list only
   (`unmatchedNameMessage` has no caller outside `CableListClient.tsx`). Read the equipment list's Change All draft
   capture: does an unmatched method, category or model fall back to the stored value and offer a mass write?
   ⚠ **If yes, say so in the first line of your return** — do not fix it in this unit.

## Close

- Full suite, typecheck, lint, build, frozen 3/3, visual gate (a dialog renders nothing at rest, so no event is
  expected — if one fires, stop and report it), dependency gate, throwaway census 0.
- For each gate command: *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT section
  if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every line."*
- Update the fence (FENCE-ONEUNIT).
- Return in `handoffs/from-cc/`: DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT, the CP2 texts, the CP5 findings,
  and the COMMIT BLOCK.

**Daniel's gate, in plain words.** Restart `:3100` first. Use the Cable Parity Fixture.

1. **Cable list, typed in and Enter.** Click any cable. In the panel at the bottom, click the **Method** box, type
   `Nutes`, press **Enter**. A box pops up in the middle of the screen: *There's no method called "Nutes".* with
   an **OK** button. Press OK. The Method box shows what the cable had before, and you can keep typing in it.
2. **Cable list, typed in then Change All.** Same again, but instead of Enter, press the **Change All** button in
   the top bar. The same pop-up appears, and no "replace … of these records" question follows.
3. **A bad length.** Click a cable's **Length** box, type `fifty`, press the **Change All** button. A pop-up says
   *"fifty" isn't a length.* Nothing changes.
4. **Find nothing.** Do a find that matches no cable. The bottom panel greys out, and the **Change All** button is
   greyed too.
5. **The category band** — Arch writes this step from CP2's screenshot before you run it.

Proposed subject: `CHANGEALL-REFUSAL: a refused Change All says so in a dialog; Change All greys with nothing found; a bad length refuses`.
