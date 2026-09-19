# METHOD-SORT-BLANK: step 2 of 3, the app learns that a method's sort order can be blank

Tier: claude-opus-5
Model: claude-opus-5
Session: FRESH

*Arch, 2026-09-19. HEAD `4fe0af9` = `origin/main`. **Migration ledger 79.** Migration 79
(`20260919144200_methods_sort_order_nullable`) was applied by Arch today on Daniel's go-ahead. Its file of
record is written to `supabase/migrations/` but **untracked**, and it rides this commit.*

**⚠ Every answer you need is in this file. There is no blank for anyone to fill in.**

## §0 · HARD STOPS

1. **No migrations and no SQL writes.** Step 3 (the backfill and dropping the default) is Arch's, after
   this ships.
2. **MAILGATE.**
3. **Test shows only** (JOY and the other `daniel+test01@` projects, or your seeded throwaways). **Never
   Buena Vista Social Club.**
4. **Expected gate: 28/28, no baseline event.** No live method is blank yet, and Visual Gate Fixture's
   `Rent-Main` stays 0. If a frame moves, stop.
5. Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the handoff file's RAW
   OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it.
   Show every line."*
6. GATE-NOGREP. Commit only on Daniel's `COMMIT APPROVED: <first words>`, after his gate.

## §1 · The ruling and what the database now allows

- **Daniel, verbatim, 2026-09-18:** *"blank should sort after anything with a value. 0 should sort before
  1"*.
- **Evidence (b):** in every v1 methods export, the user's field `Sort Override Manual` is **blank** on
  each method v2 holds at 0. `Sort Override` is v1's calculation, where empty becomes 0, and it is what
  `map.ts:679` imports today.
- **Now live:** `methods.sort_order` is nullable. Its **default is still 0** until step 3.
  `import_apply_v1` inserts a blank as blank. On update, a key that is present but blank clears the value,
  and an absent key keeps it. Read the column live, and regenerate the types.

## §2 · CP1: census, then make every reader blank-safe

1. **Regenerate `database.generated.ts`.** `methods.sort_order` becomes `number | null`.
2. **Census every reader and writer** of a method's sort order across `src/` and `scripts/`, and quote each
   site. Arch's grep lists these candidates; the census is yours:
   - `queries/methods.ts`, `MethodsAdminClient.tsx`, `EquipmentListClient.tsx`, `EquipmentItemRow.tsx`,
     `EquipmentLibraryClient.tsx`, `sortChains.ts`, `printEngine.ts`, `boxContents.ts`, `naSystem.ts`,
     `dashboard/new/page.tsx`;
   - the equipment, box and revision loaders;
   - `export/{runExport,coerce,buildSheet}.ts`;
   - `import/{map,spec}.ts` and `import/workbook/*`.
3. **One rule everywhere a method sort is compared, on screen and on paper:** a value sorts by value,
   **0 before 1**, and **blank sorts after every value**. Blanks tie among themselves and fall through to
   the existing next term (the name). Put it in one comparator and route every site through it.
   `printEngine`'s `?? Infinity` already behaves this way; prove it with a test that uses a real `null`,
   not `undefined`.
4. **Section numbers for a blank method** (`majorNum` is ordinal + 1 today): **report only.** Keep the
   REPORTED collision test. This is not a redesign.

## §3 · CP2: writers

1. **Methods admin:** clearing the Sort Override field saves **blank**. It does not save 0, and it does not
   refuse. A typed 0 saves 0. Show both in a browser smoke on a throwaway.
2. **Every insert of a new method** (admin create, Change All's create-missing (CHANGEALL-METHODNEW), the
   new-project seed): census each one.
   - A site that relies on the column default: report it. The default changes to blank at step 3.
   - A site that sends 0 explicitly: change it to blank, unless a ruling says 0. The system `N/A` rows
     keep their fixed high ranks (`seed_project_na_rows`).
3. **v1 import:** read **`Sort Override Manual`**. Blank maps to blank, a number maps to that number.
   Update `spec.ts` so that `Sort Override` becomes the IGNORE'd derived column and `Manual` becomes the
   mapped one, and record the reason. Workbook import: keep the same semantics.
4. **v1 export:** a blank round-trips as a blank `Sort Override Manual` and `Sort Override = 0`, which is
   v1's own shape. Test the round trip.
5. **End-to-end proof** (Arch's rehearsal couldn't run a full import): import a small v1 methods fixture
   that has a blank and a 0 into a throwaway through the real `import_apply_v1`. Expected: blank is stored
   as blank, and 0 is stored as 0. Then re-import with the blank changed to 3, and with 3 changed back to
   blank, to prove the update arm. Census 0 afterwards.

## §4 · Close

- Run the suite, typecheck, lint, build, frozen 3/3, and the gate 28/28 with no event.
- Update the fence (FENCE-ONEUNIT).
- **The COMMIT BLOCK includes `supabase/migrations/20260919144200_methods_sort_order_nullable.sql`.**
- Return DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT.
- **Daniel's gate, on JOY only:**
  1. Methods admin: clear one method's Sort Override, then print the equipment list by method. That
     method's section prints **after** every numbered one. Type 0 back into it, and it prints **first**.
  2. Put it back as it was.
- Proposed subject: `METHOD-SORT-BLANK: blank method sort order sorts last; import reads Sort Override
  Manual`.
