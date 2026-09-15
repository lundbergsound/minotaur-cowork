# NEXT SESSION — opener

*Written at the close of the 2026-09-15 Cowork-Arch main line. Read the governing set
first, in the order the Architecture Prompt gives; this file only says what to do once
the checks pass. **Nothing in this file is a substitute for reading the Roadmap.***

## State at this close — verify it, do not trust it

- Code **`9e581be`** = `origin/main`, live, deploy READY. Read HEAD from the ref files;
  **never run `git` in either repo folder**, even `git status`.
- **Migration ledger 69.** Live-read it; do not cite this number.
- Suite 3,355 / 175 · frozen 3/3 · visual 28/28 · no baseline event · `CLAUDE.md`
  110,968 characters.
- Session Log at **3 entries**, rollover **clear** (rolled over 2026-09-15).
- Nothing is building. No CC session is live.
- ⚠ **The `project_members` hard rule is DISCHARGED.** Migrations 65–69 are applied;
  non-owner membership rows are legal. The table still holds 15 rows, all `owner`.

## The shape of this session — SESSION-SHAPE, ruled 2026-09-15

**1 · FIRST, before anything else: write the BATCH-PREBETA handoff to CC.**

Bundle it as wide as the ruled material allows (HANDOFF-BUNDLE). Every member is ruled;
none needs a decision from Daniel to write. ⚠ **Put the answers IN the pointer. Never
hand Daniel a blank to fill in** — a fill-in-the-blank cost a whole checkpoint on
2026-09-14. Members are listed in the BATCH-PREBETA row; the ones with fresh pedigree:

- **CATCOUNT-COLUMN** — ruled 2026-09-15, *"every record in a category, regardless of
  list."* The count is already computed and already passed to the tab, so this is one
  column and no new database read. The delete guard stays unfiltered.
- **CABLE-CHANGEALL-METHODNULL** — ruled 2026-09-15, pulled forward. `CableListClient.tsx:3499-3508`.
  The equipment-side pattern to copy already exists.
- **AUTH-POLISH's input half** — ruled 2026-09-15, cut the ghost text.
- **AUTOCOMPLETE-NOPORTAL** — ⚠ **the row's old cause is false; read the corrected row
  before writing a word of it.** The work is the print-options filter row and the
  revisions grid, not the equipment list.
- **TYPES-REGEN** — stale by eleven migrations; zero-diff expected, run it anyway.
- **The five sharing migration files into `supabase/migrations/`.**

⚠ **CABLEDEL-FAILMSG is still owed by Daniel and the text IS the deliverable** — it
joins only if he gives the wording before the handoff is written. Do not invent it.

⚠ **Capture `pg_policies` for any table a migration will touch BEFORE applying it**
(POLICY-CAPTURE-FIRST, added this close after 67 was applied without it).

**2 · Once Daniel confirms the handoff is in CC's hands, spin off the parallels.**
Two are wanted, and they are independent of each other:

- **SHARE-ROSTER design.** ⚠ **Study what Zite did with sharing BEFORE the handoff is
  written, not during the build. Parity is NOT wanted; the interaction ideas are.**
  WHOCOL-RLS's database half is already done — `project_member_names()` is applied and
  returns `(user_id, display_name)` for one project, including past snapshot authors,
  while `profiles` stays self-only. What remains is the surface that calls it.
  **This is the largest remaining build before the invite.**
- **RLS-HELPER-COST.** The regression we created on 2026-09-15. ⚠ **Read the row's
  numbers and its two eliminations before proposing anything:** dropping `SECURITY
  DEFINER` is ruled out because 69 puts policies on `project_members` and an
  invoker-rights helper would recurse; and the set-returning candidate measured no
  better **but was measured inside a DDL transaction, so it proves nothing.**
  ⚠ **GATE-SETTLE-BETWEEN: a measurement sharing a transaction with schema changes is
  not a measurement.** Warm up, repeat three times, no DDL in the transaction.

**3 · The third parallel is already live and its hold is released.** APPLY-TIMEOUT
returned Phase 1 and was held until 65–69 were applied. That is done, so Phase 2 may
run. ⚠ **Do not let a full-size import measurement share a machine with CC's visual
gate.**

## What is owed by Daniel, so it can be asked once and batched

CABLEDEL-FAILMSG's wording · SYSROW-REPORTMSG's wording · whether RLS-HELPER-COST sits
before the invite or in week one · `Versioning Test` keep or delete · whether the four
unused methods named `0` are removed from live projects (Arch's hand, not CC's) ·
the fourteen remaining cohort accounts and the real names for `profiles.display_name`,
which is now what every member sees of every other member.

## Standing traps this session must not walk into

- ⚠ **NOW and NEXT are Daniel's words.** They are stale at this close and Arch may not
  rewrite them; the proposed replacement was given in chat on 2026-09-15 for him to edit.
  Propose in three lines, never edit.
- ⚠ **The ❓ Open Questions section is ABOLISHED** (QUESTIONS-IN-ROWS). A question goes
  in the row of the unit that will answer it, or becomes its own row with an owner and a
  trigger. Do not re-create the section.
- ⚠ **`compareLabels` is the single app-wide comparator** imported by roughly twenty
  modules. Its empty-LAST contract is load-bearing everywhere. Never change it to fix
  one surface.
- ⚠ **Screen and paper now disagree** about where a blank description sorts. That is
  deliberate and registered to PRINT-RULES; do not "fix" it by citing the screen.
- ⚠ **A set asserted from a narrow search is the house error.** It produced three of
  five Arch errors on 2026-09-15 and four wrong claims on 2026-09-08. Census the class,
  then narrow.
- **MAILGATE** holds. Nothing sends mail; CC never sends mail or provisions accounts.

## First action

Read the governing set, run the seat and state checks, then write the BATCH-PREBETA
handoff. Deliver it with the pointer complete, state the return condition, and stop.
