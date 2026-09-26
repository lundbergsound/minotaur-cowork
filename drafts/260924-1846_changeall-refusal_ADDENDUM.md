# CHANGEALL-REFUSAL — ADDENDUM: fold in the equipment list's Category fallback (CP6), and Arch's answers to your OQs

Tier: claude-opus-5
Model: claude-opus-5
Session: CONTINUE (the CHANGEALL-REFUSAL session; its nine files are uncommitted)

*Arch, main line, 2026-09-24 18:46 ET. Against your return `handoffs/from-cc/260924-1831_changeall-refusal.md`.
Code base `3809860` = `origin/main`. Every hard stop in `260924-1805_changeall-refusal.md` still applies. Nothing
is committed; the nine files stand.*

**Daniel's ruling, 2026-09-24, on your CP5.2 finding: "fold it in".** The equipment list's Category `Nutes`
fallback is fixed in this unit, before the commit.

## CP6 · The equipment list's Category refuses instead of falling back

Your measurement: `captureEquipDraftRow`, `EquipmentListClient.tsx:2556-2558` at `3809860`,
`patched = opt ? { ...row, category_name: opt.label } : row // unmatched → stored (revert)` — so `Nutes` on the
category band then Change All (⌥⇧\ or the toolbar) offers *"…replace the "Category" field of these 5 records with
"11.0 Consoles"?"*, the stored value.

**Ruling (pedigree (a) Daniel "fold it in" + the CHANGEALL-NEWMETHOD / CP1 shape):**

1. An unmatched category name **refuses**: no "replace … records" dialog, no write. The refusal uses the equipment
   list's **existing** single-OK refusal dialog — `<ConfirmDialog open={snapshotRefusal != null} … confirmLabel="OK"
   singleAction>` at `EquipmentListClient.tsx:3294-3300` — measured the same way you measured the cable list's
   (can the two ever be on screen together?). No new component.
2. Wording: the shared sentence, *There's no category called "Nutes".* Reuse `unmatchedNameMessage`; if importing
   it from `src/lib/cable/` into the equipment list is the wrong seam, move it — your judgment, say which.
3. OK returns focus to the category editor it came from, value reverted and selected, as on the cable list.
4. **Measure the single-edit path** (the category band editor's own Enter / Tab / click-away with `Nutes`): if it
   also reverts in silence, it refuses through the same dialog, as CP4 did for length. If it does something
   else that is ruled, leave it and say what.
5. Tests pin the dialog and the absence of the write on both paths; deletion controls RED.
6. **Not in scope, stay registered:** the equipment/library Change All latch, Quantity's NaN arm (`:2544`), the
   Tab focus drop at `:2022`.

## Arch's answers to your OPEN QUESTIONS

1. **`NewCableTypeDialog` guard: keep it.** It closes a silent write in production. Disclosed correctly.
2. **Model on Enter: your bounce is right.** CP1 was wrong to list Model's Enter path; CP-2 stands (Enter on an
   unknown model opens New Cable Type). No refusal there.
3. **Tab residual (caret in Group behind the dialog): register, do not fix.** Docket, with DIALOG-OPENING-KEY.
4. **DIALOG-OPENING-KEY census: registered as you have it.** No sweep in this unit.
5. **Docket rows:** Arch's, at close.
6. **The four untracked `s4auto_*` files:** stay out of this commit.
7. **Step 5:** written below from your CP2 texts.

## Close

The full gate set again (suite, typecheck, lint, build, frozen, visual, dependency, census 0, guarded-code grep),
raw output per the Raw Output Rule: *"Reproduce the complete raw output verbatim — into the handoff file's RAW
OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every
line."* Append a round to the same return file, then a fresh COMMIT BLOCK for the whole unit. Proposed subject
unchanged.

**Daniel's gate, in plain words.** Restart `:3100` first. Steps 1–5 on the **Cable Parity Fixture**; steps 6–9 on
**JOY**.

*Cable list*

1. **Unknown method, Enter.** Click any cable. In the panel at the bottom, click the **Method** box, type `Nutes`,
   press **Enter**. A box pops up in the middle of the screen: *There's no method called "Nutes".* with an **OK**
   button. Press OK. The Method box shows what the cable had, highlighted, so the next thing you type replaces it.
2. **Unknown method, Change All.** Same again, but instead of Enter press the **Change All** button in the top bar.
   The same pop-up; no "Would you like to replace…" question follows.
3. **A bad length.** Click a cable's **Length** box, type `fifty`, press **Change All**. A pop-up: *"fifty" isn't a
   length.* Nothing changes.
4. **Unknown model.** Click a cable's **Model** box, type `NoSuchType`, press **Enter**. The **New Cable Type** box
   opens and stays open. Press **Escape**: it closes and no new cable type exists. (Today it silently creates one.)
5. **Find nothing.** Do a find that matches no cable. The bottom panel greys out, and **Change All** is greyed too.

*Equipment list, on JOY*

6. **Find the category line.** Open the equipment list and press **Method** in the Sort row. Each method name sits
   on a dark bar (for example **Rental**). **Directly under it** is a paler, full-width line holding a category
   name (for example **11.0 Consoles**), and directly under *that* is a model line, a quantity then a model name.
   The paler line is the category line. The picture is
   `docs/reference/evidence/equipment/changeall_refusal_gate_05_category_subband.png`, circled in red.
7. **Edit the category line.** Click the category name on one of those paler lines: it becomes a box you can type
   in. Type another category that already exists in JOY and press **Enter**. Only the items under **that** method
   move to the new category; the same category under a different method is untouched. Then put it back.
8. **The keyboard swap.** Still in Method sort, click a **model** line so it opens for editing, then hold **Option
   + Shift** and press **I**: the editor jumps to that block's category line. Press it again: back to the model.
9. **Unknown category.** Click a category line, type `Nutes`, press **Change All**. A pop-up: *There's no category
   called "Nutes".* with OK. No "Would you like to replace…" question, and nothing changes.
