# APPLY-TIMEOUT — parallel opener

Tier: 2 (Arch parallel)
Session: FRESH
Scope: ONE named unit — APPLY-TIMEOUT. Nothing else.
Opened from: the Cowork-Arch main line, 2026-09-15, on Daniel's ruling of the same
day that this runs as a parallel once CC is confirmed working. The main line closes
the session; this seat returns a file and nothing else.

---

## §0 · What this seat may not do

- **No migration. No DDL. No schema change of any kind.** APPLY-TIMEOUT is Trigger B
  and the apply belongs to the main line. If the answer turns out to be a database
  change, you write the proposal and stop.
- **No CC handoff.** A parallel never delegates.
- **No governing-document edit.** Not the Brief, not the Roadmap, not the Ledger, not
  the Session Log, not `CLAUDE.md`. Your output is one RETURN file.
- **Nothing but `owner` goes into `project_members`** until migration 66 is applied.
  Not a test row. Until then `snapshot_project_v1` reads seven owner-only cable
  tables under the caller's RLS and coalesces a blocked read to `[]`, so a
  non-owner row makes any of the twenty commit points write a cable-less backup and
  report success.
- **MAILGATE.** Nothing sends mail.
- **Never run `git` in either repo folder**, even `git status` — it leaves a lock file
  this seat cannot delete and blocks CC's next commit. Read git state from the
  plain-text files under `.git/`.
- **The Supabase spend cap stays on** (SPENDCAP-BETA). A measurement that needs it
  lifted is not a measurement you may run; say so instead.

---

## §1 · The question, stated so it cannot drift

A full-size v1 import hits the statement timeout and writes nothing. **The design is
working** — the whole import is one transaction and it aborts cleanly. The snapshot
half of the same path is fine at roughly 570 ms.

⚠ **The question is NOT "what should the ceiling be."** It is **"what does a real
full-size import actually cost, and where does that cost sit."** If the true cost
does not fit inside a sane ceiling, then the answer is not a bigger ceiling, and a
proposal that opens with a new timeout number has answered the wrong question.

**Carried figures, all of which you re-measure rather than cite:**

- `statement_timeout`: `authenticated` 8s, `authenticator` 8s, `anon` 3s — measured
  live 2026-09-14. One day old. Cheap to re-read; re-read it.
- The snapshot path at ~570 ms.
- Migration ledger at 64 at this seat's open. ⚠ **The main line is applying 65
  through 69 while you run.** Read the ledger live at your own open, record what you
  read, and do not "correct" a number against the main line's prose.

---

## §2 · Phase 1 — light work, runs immediately

Nothing in this phase writes anything, anywhere.

1. **Re-read the ceiling at source.** Every role's `statement_timeout`, plus the
   database-level and any function-level setting. A function with its own
   `SET statement_timeout` beats the role's, so check the function too — that alone
   could change the shape of the answer.
2. **Read `import_apply_v1` from live introspection, not from the repo.** Only the
   generated types describe the database and only the live body describes the
   function (the Surface Rule). ⚠ **Two files against 64 applied migrations means the
   repo cannot rebuild the database** (REPO-MIGRATIONS-ABSENT), so the repo's copy of
   this function may not be what is running.
   Answer, in the return: **is the body one statement or many?** The statement timeout
   applies per statement, so a single long-running function call dies as one unit
   whereas a loop of statements each gets its own budget — and which of those is true
   decides every option in Phase 3.
3. **Size the corpus at source.** Row counts per table for the largest real
   production, so "full-size" is a number and not a word. ⚠ Every citation names the
   project id, because two productions of one musical share a show name and that is a
   feature, never a uniqueness constraint (PROJECT-NAME-NOT-UNIQUE).
4. **Find the client call site** and record what it does on failure — what the
   operator sees when the import aborts, and whether anything is left behind.

**Phase 1 gate:** the return's measurement table is complete and every carried figure
above has been either confirmed or corrected before Phase 2 begins.

---

## §3 · Phase 2 — the heavy measurement. ⚠ IT HOLDS.

**Do not start Phase 2 until the main line confirms that CC's visual gate has
finished.** CC runs its visual gate once, at the end of its unit, on the same
machine. A reliability measurement taken on a contended machine is not a measurement
(GATE-SETTLE-BETWEEN), and a visual gate running against a machine busy with a
full-size import is not a gate. If you reach the end of Phase 1 and the main line has
not confirmed, **write the Phase 1 return and stop there.**

**How to time it without writing anything:**

Run the import inside a transaction that raises the timeout for that transaction only
and then rolls back — the proof-run-with-forced-rollback pattern this project already
uses for every migration. `SET LOCAL statement_timeout` inside the transaction, the
import, timings captured, then `ROLLBACK`. Confirm zero residue afterwards, in the
same way a migration residue check is confirmed, and quote the check.

**Guardrails on the target project:**

- ⚠ **Use a throwaway project, and import INTO it.** Never re-import onto a project
  that carries evidence. BVSC Mexico carries 823 orphan identity rows whose
  behaviour under re-import is unmeasured, and **a re-import overwrites the evidence
  that would tell you what happened** (IDMAP-ORPHAN-REIMPORT, FIXTURE-NUMLABELS-GONE).
- The parity fixtures are invisible to the test user, so every count is a labelled
  reproduction on a throwaway (HARNESS-RLS-CORPUS).
- **Two re-runs is the limit** (GRAPH-BEATS-RERUN). If two runs disagree, that
  disagreement is the finding — report it rather than hunting a third.

**What to bring back:** total wall time, the breakdown by phase or by statement, the
single largest contributor, and how the total scales against the row count — one
size is a point, not a curve, so measure at least two sizes if the budget allows and
say plainly if it did not.

---

## §4 · Phase 3 — the proposal

Only after Phase 2. Lay out the options with what each costs and what each risks, and
**include the non-timeout ones explicitly**, because the row's own warning says the
answer may not be a ceiling at all:

- chunk the import into statements that each fit the existing budget
- move it off the request path entirely, so no ceiling applies
- raise the ceiling for one role or one function, narrowly
- raise it globally

For each: does it need a migration, does it change what the operator sees, and what
happens to a half-finished import if it fails midway. **An import that can half-land
is worse than one that cleanly writes nothing**, which is what the current design
gets right — any option that trades the clean abort away must say so in its own
sentence.

⚠ **Storage or size estimates:** `pg_column_size` on a computed value reports the
uncompressed datum, so any estimate cites a stored measurement or states that it is
an expectation (TOAST-ON-WRITE).

⚠ **Tense:** an expectation written in the past tense reads as a measurement
(TENSE-IS-A-CLAIM). Keep them apart.

---

## §5 · Return

One file: `handoffs/parallel/<YYMMDD-hhmm>_apply-timeout_RETURN.md`, the stamp written
at the time of writing (PARALLEL-CLOCK). Sections:

- **MEASURED** — the figures, each with how and when it was taken
- **CORRECTED** — every carried figure this seat found wrong, named
- **OPTIONS** — Phase 3, with the tradeoff on each
- **RECOMMENDATION** — one, with the reason, and the reason it beats the others
- **OPEN QUESTIONS** — what could not be measured, and what it would take
- **RAW OUTPUT** — *Reproduce the complete raw output verbatim. Do not summarize,
  paraphrase, or describe it. Show every line.*

Write for Daniel first: lead with what an import costs and whether it fits, in plain
language, before any identifier. Every identifier gets a gloss on first use or does
not appear.

**Stop conditions — return early rather than push through:**

- the main line has not confirmed CC's visual gate is done (return Phase 1 alone)
- the answer needs a schema change (propose it; do not write it)
- two runs disagree (report the disagreement)
- a measurement would need the spend cap lifted (say so)
