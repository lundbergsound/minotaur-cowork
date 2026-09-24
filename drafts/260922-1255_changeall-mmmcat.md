# CHANGEALL-MMMCAT: diagnose and fix Change All's two silent failures; the category sub-band becomes editable in every sort

Tier: claude-opus-5
Model: claude-opus-5
Session: FRESH

*Arch, main line, 2026-09-22 12:55 ET. Code is at `d25d366`, which is `origin/main` (DEVPATCH-JOIN-CASE, shipped). The
migration ledger is **83**. Read HEAD and origin from the ref files, and read the ledger live. Line numbers below
were read at `d25d366` today.*

**What this is.** Two equipment-list units bundled (HANDOFF-BUNDLE): **CHANGEALL-NOTE + INSPECTOR-ARM**, a
diagnosis-first checkpoint on Change All, and **MMM-CAT**, a feature ruled on 2026-08-11 and never built. Both live
in `EquipmentListClient.tsx`, the frozen save layer's neighbour, so read `CLAUDE.md`'s frozen-gate section first.

## §0 · HARD STOPS

1. **No migrations, no SQL writes.** If either unit needs schema, stop and return it.
2. **Test shows only**: throwaways, or JOY `0d329963-dcd1-403d-a5ad-1f78f0b9a425` read-only. Never BVSC, never a
   cohort member's show (Daniel's "option C", 2026-09-21).
3. **The frozen layer stays closed.** The frozen gate (3/3 vs `be0769de`: `updateItem`, the save-error-flash rule and
   keyframes) must pass unchanged. **If the Change All cause is inside the frozen layer, stop at CP1** and return the
   diagnosis. Opening it is Daniel's ruling (FROZEN-FLASH is HELD on exactly that).
4. **Visual gate: no event expected.** MMM-CAT's sub-band must render byte-identically at rest (the July-13 band
   amendment already gave it the top-level band's class). Anything moving is a stop.
5. Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT
   section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every
   line."*
6. GATE-NOGREP. Commit only on Daniel's `COMMIT APPROVED: <first words>`, after his gate.

## §1 · CP1: Change All — reproduce, diagnose, then fix (CHANGEALL-NOTE · INSPECTOR-ARM)

**The reports, verbatim:**

- **CHANGEALL-NOTE** — Daniel, 2026-09-21: *"change all from a multi-line note seems not to do anything."* The date
  puts it close to NOTES-ONELINE (`5ccd009`, which condenses a multi-line note to one line on rows that aren't
  current), so test at HEAD and say whether that unit is involved.
- **INSPECTOR-ARM** — found at a Daniel browser gate (Ledger, VERHIST close): typing into **Method**, then Change All
  stays greyed out and silent. The recorded cause ("Method lives only in the inspector; Change All arms only with a
  row selected") was **refuted at `d980b73`** (Ledger): `method_name` is an ordinary row cell, one of the seventeen
  Change All fields (`equipmentChangeAll.ts`), and neither arming path reads a selected row. **The cause is
  unmeasured.** Do not start from either old hypothesis.

**Do, in order:**

1. On a throwaway with several rows sharing a model, reproduce each case on `next dev`: (a) a Public Notes cell and a
   Private Notes cell holding two or more lines — edit, then Change All; (b) a Method cell — type a method, then
   Change All; (c) a control case that works today (a one-line note), so the harness is proven.
2. For each failure, find the cause in the code: which arming path, which state, which condition. Name file and line.
3. **Return the diagnosis in the DONE section before fixing.** Then fix it in this unit **only if** the fix is
   outside the frozen layer and each cause is a local correction. If a cause is a design question (for example,
   what Change All should *mean* from a multi-line field), stop and return it; Arch rules it with Daniel.
4. Regression tests pin each fixed case, with a deletion control per fix that goes RED.

A control that looks live and does nothing is a defect (DEAD-CONTROL-IS-A-BUG). If you find a third case of that
shape in the Change All path while you're in there, name it, and don't fix it.

## §2 · CP2: MMM-CAT — the category sub-band becomes an edit surface under method, box and group sorts

**The spec is ruled; re-measure, do not re-design.** Rulings of record (pedigree (a), Ledger, Aug 10–11):

- **MMM-CAT-R0** (Daniel, Aug 10): the category sub-band under method/box/group sorts gets *"the SAME edit behavior as
  under category sort, including ⌥⇧I."*
- **MMM-CAT-R1** (Daniel, Aug 11): ⌥⇧I toggles **Model ↔ Category in every sort mode**: the top-level band in category
  sort, the sub-band elsewhere. The outer method/box/group band **stays click-only**.
- **MMM-CAT-R2** (Daniel, Aug 11): a sub-band category edit cascades to **that visible sub-band's records only**; the
  same category under other outer bands is untouched. Dialog-free (the Aug-10 "category cascade unchanged" ruling),
  through `runCategorySaveCascade`, never `commitBandFieldScoped`.
- The sub-band's look is settled (July-13 band amendment); the sticky pin chain (A5, `BAND_STICKY_H` = 28, model band
  at 2·H) must not change.

**The old handoff** `handoffs/to-cc/260811-0216_mmm-cat.md` is **STALE** in every citation (HEAD `1f06092`, suite 1250,
16 frames, `:3122`). Use it for its legs and its §3 warning only. **Re-measure every line against `d25d366`.** Today
the sub-band is the bare `<div className="category-header sticky z-[3]" …>{catLabel}</div>` under the comment
*"display-only here"* at `EquipmentListClient.tsx:3659-3675`, and `toggleModelCategoryFocus` (`:1819`) still no-ops
outside category sort (its own comment, `:1831-1838`).

**What it needs, from the old handoff's legs, re-measured:**

- a composite editor key, because one category label appears under several outer bands (the model band's
  `modelBandKey` already solves this);
- click opens the editor on the band's target record; set-existing-only by the selected option's id; a pristine
  commit is a silent no-op; error flash on `category_id`;
- ⌥⇧I both ways (R1); Enter-advance reopens the **sub-band** editor, not the outer band;
- `data-find-field="category_name"` on the sub-band, with the ⌥⇧F find-default checked in method, box and group sorts.

**⚠ The old §3 warning stands:** measure the sub-band's rendered height at rest and with the editor open, in both
themes. If any of the four is not 28 px, **stop and return the measurements.** Do not add a per-mode offset.

**Success:** on a throwaway in method sort with category `11.0` under two methods, editing the sub-band under one
method changes only that band's rows (R2); ⌥⇧I from a model band opens the sub-band and back (R1); category sort
behaves exactly as today.

## §3 · Close

- Full suite, typecheck, lint, build, frozen 3/3, visual gate (§0.4), dependency gate, census 0.
- Update the fence (FENCE-ONEUNIT). The last one carried GROUP-DEVICE-PATCH; DEVPATCH-JOIN-CASE's count was
  3822 / 207.
- Return DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT, plus the COMMIT BLOCK.

**Daniel's gate, on JOY.** Restart `:3100` first.

1. **Change All from a multi-line note.** Edit a Public Notes cell that holds two lines, choose Change All: every row
   with that model takes the note.
2. **Change All from Method.** Type a method into a row's Method cell, choose Change All: it's live, and every row
   with that model takes the method. (If CP1 stopped instead of fixing, skip 1–2; Arch brings you the diagnosis.)
3. **Sort by Method.** Click a category band under one method, change the category: only that method's rows move; the
   same category under another method is unchanged.
4. **⌥⇧I** on a model band in method sort opens the category band; ⌥⇧I again goes back.
5. **Sort by Category**: the category band edits exactly as it did.

Proposed subject: `CHANGEALL-MMMCAT: Change All from notes and Method; the category sub-band edits in every sort`.
