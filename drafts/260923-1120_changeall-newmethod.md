# CHANGEALL-NEWMETHOD: a method name that doesn't exist must never become a mass write — and one measurement for LIVE-COLLAB

Tier: claude-opus-5
Model: claude-opus-5
Session: CONTINUE (the CHANGEALL-MMMCAT session; its ten files are still uncommitted)

*Arch, main line, 2026-09-23 11:20 ET. Code base `d25d366` = `origin/main`. Migration ledger **83**. Read HEAD and
origin from the ref files. Every hard stop in `260922-1255_changeall-mmmcat.md` §0 still applies: no migration, no
SQL writes, the frozen layer stays closed, test shows only, GATE-NOGREP, and the commit waits on Daniel's phrase.*

**Daniel's gate, 2026-09-23, on the Cable Parity Fixture** (his words): step 1 *"first cable selected good"*; step 3
*"find with no match grey pass"*; step 2 — *"Method change all passes for a method that's already defined, but
slowly. For a method that hasn't previously existed, it reverts to a different method."* Steps 4–6 (MMM-CAT) he
could not run; Arch is rewriting them in plain words and he runs them at the next gate. **So this unit does not
commit until CP1 below is fixed and re-gated.**

## §1 · CP1 — the defect, with his evidence

His two screenshots, which are the record: the inspector's Method field holds the typed word **`Nutes`** (a method
that does not exist in that project). The Change All dialog then reads **"Would you like to replace the 'Method'
field of these 1121 records with 'N/A - Labels Only'?"** — the row's *stored* method, not what he typed.

**The path, read at source (`CableListClient.tsx`, `d25d366`):**

- The inspector's own commit, `handleInspectorAuto` (`:2514`), case `'method'` (`:2565`): `resolve(...)` returns
  nothing for an unmatched name and the handler **returns silently** — no write, no message.
- The Change All draft capture, case `'method'` (`:3443-3449`): an unmatched name leaves `patched` as the stored
  row, so the plan is built from **the stored method**. The `isNaAlias` branch beside it is the 2026-09-15 ruling
  for a typed `0`; it is not this case.

So a typo in a Method field offers a mass replace of every row in the found set with a value the operator never
typed — 1,121 rows in his case, and the proposed value happened to be `N/A - Labels Only`, which is the one method
that hides rows from print. **This is a data-loss shape, not a cosmetic one.**

**The fix, ruled by Arch (pedigree (c), and Daniel strikes it at the gate if he disagrees):**

1. **A name that matches no method never becomes a Change All plan.** The dialog does not open. The operator is
   told, on screen, in the app's existing idiom for a refusal: name the field and the text, e.g. *"There's no
   method called "Nutes"."* Reuse whatever refusal surface the cable list already has — **measure it**; do not
   invent a second one.
2. **The same for the other resolved fields on that path** — colour, category, box, model — where an unmatched
   name today falls back to the stored value. Measure each, fix them the same way, and say in DONE which ones were
   affected.
3. **The typed text reverts visibly** to the stored value when it resolves to nothing, so the field never sits
   showing a word that is not what the record holds.
4. **Not in scope, register only:** whether typing a new method should *create* it (v1's value list behaviour is
   unmeasured here). That is Daniel's ruling and the method admin's unit.
5. Regression tests pin: an unmatched method name opens no dialog and writes nothing; a matched one still plans
   the whole found set. Deletion controls RED for each.

**Also measure, and report — do not tune:** Daniel says a 1,121-row Change All is *slow*. Time it on a throwaway of
similar size, say where the time goes (the write, the refetch, the re-render), and register the number. A fix is
its own unit unless it is one line and obvious, in which case say so and stop.

## §2 · CP2 — one measurement for LIVE-COLLAB (evidence only, change nothing)

Daniel's ruling of 2026-09-23 puts live multi-user editing on the Roadmap after RF, on the strength of what he told
Aaron Hanna: *two people in one show do not see each other's changes until they reload.* **Verify that, because
Aaron is already sharing shows.**

Two signed-in browser contexts (the support account and a second test account, on a throwaway project shared
between them — never a cohort member's project, "option C"):

1. Both on the same equipment list. A edits a cell. Does B see it without reloading? After reload?
2. Both edit **the same cell**, A first, then B, without reloading. What is stored, and is either told?
3. B edits a row A deleted, without reloading.
4. Same three on the cable list.

**Report what happens, including anything worse than "no live update":** a silent overwrite, a stale-value write,
an error that is swallowed, or a row that reappears. ⚠ If any of it loses a write with no message, say so at the
top of your return — Arch takes it to Daniel before anything else.

## §3 · Close

- Full suite, typecheck, lint, build, frozen 3/3, visual gate (no event expected), dependency gate, census 0.
- Update the fence (FENCE-ONEUNIT).
- Return in the same file: DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT, and the COMMIT BLOCK for the whole
  unit (this fix plus the ten files already built).

**Daniel's gate — the whole unit, in plain words.** Restart `:3100` first. Any test show; the Cable Parity Fixture
is fine.

1. **Cable list opens** with the first cable highlighted and the panel at the bottom filled in.
2. **Method, a name that exists.** Click a cable, type that method in the panel's Method box, press Enter, choose
   Change All: the dialog names *that* method, and every cable on screen takes it.
3. **Method, a name that does not exist.** Type `Nutes`, press Enter: it tells you there's no such method, the box
   goes back to what the cable had, and no Change All dialog appears.
4. **Find nothing:** nothing is selected and the whole bottom panel is greyed.
5. **The category bar in the equipment list.** Open the equipment list and press the **Method** button in the sort
   row, so the list is grouped by method. Under each method heading there is a second, paler heading line for each
   category (e.g. `13.0 Cable`). **Click that category line**: it becomes a box you can type in. Change it to
   another category and press Enter. Only the rows under *that* method move; the same category under a different
   method is untouched. Before this unit, clicking that line did nothing.
6. **The keyboard swap.** Still in Method sort, click a **model** line (the bold model heading) so it opens for
   editing, then hold **Option + Shift** and press **I**. The editor jumps to that block's category line. Press
   Option + Shift + I again: it jumps back to the model line.
7. **Sort by Category** (the Category button in the sort row): the category heading edits exactly as it always did.

Proposed subject: `CHANGEALL-NEWMETHOD: an unmatched name never becomes a Change All; the cable list follows its found set; the category sub-band edits in every sort`.
