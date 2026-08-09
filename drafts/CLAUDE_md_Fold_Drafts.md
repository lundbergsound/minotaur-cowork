# CLAUDE.md Fold Drafts — Aug-9 Workflow Housekeeping

*(DRAFT — produced in the 2026-08-09 parallel drafting session against the
2,078-line CLAUDE.md uploaded to that session. NOTHING here is installed
until the post-S3-G principal housekeeping session executes. That session
re-anchors every block against the then-current file — the S3-G build
session will have folded new content by then.)*

---

## How to use this file (housekeeping session)

Plain summary: three folds and one hook file. Fold 1 (WF-1a) replaces the
Commit authority section and patches three other sites that cite WF-1.
Fold 2 (Multi-Leg Run Pattern) and Fold 3 (PDF evidence-class rule) are
clean insertions into the Operating Contract. Every placement uses a
**text anchor**, never a line number — the S3-G fold will have shifted
line positions.

- Each fold block below has a PLACEMENT instruction and a FOLD TEXT block.
- FOLD TEXT is verbatim-final except items marked **[RULING NEEDED]** —
  those halt the fold until Daniel rules.
- Apply in order: Fold 1 (all four sites), Fold 2, Fold 3, hook placement.

## Anchor-collision watchlist (S3-G build session runs in parallel)

The S3-G close fold will land before this file executes. Expected S3-G
touches, and whether they collide with these folds:

- **New `### Cable S3-G architecture of record` section** inserted near the
  file tail (before `## Desktop Handoff File Protocol`) — no collision, but
  it shifts everything after it. Text anchors absorb this.
- **`## Current run fence` heading + lineage rewrite** — no collision;
  no fold below touches the run fence.
- **Tier-A "Standing machine gates for any run" bullet** — Fold 1d edits
  its final clause. If the S3-G fold also edits this bullet, reconcile by
  hand: Fold 1d changes ONLY the "nothing staged, no commits" tail.
- **Standing-instructions discharge lines (types regen, etc.)** — no fold
  below touches Standing instructions except the hook-placement note's
  proposed glob widening, which is an OPEN QUESTION, not a fold.
- **Historical lineage mention of WF-1** (`745e447` in the run-fence
  lineage) — deliberately untouched. History is not rewritten by a
  supersession.

---

# FOLD 1 — WF-1a Commit Pilot (Strat decision 1)

## 1a. Commit authority section — full replacement

**PLACEMENT:** Replace the ENTIRE section beginning at the heading
`### Commit authority (July 24 — WF-1, supersedes the July-23 commit authority)`
through the end of the no-trailer paragraph (the line ending
`…every drafted COMMIT BLOCK message.`), i.e. everything up to but NOT
including `### Fork rule (G1 — standing, GS-A window Aug 4–7)`.

**FOLD TEXT:**

```
### Commit authority (Aug 9 — WF-1a PILOT, supersedes WF-1's stage/commit
### clauses; the push clause is unchanged; sunset review at Sprint 4 close,
### alongside the auto-mode rider)
**Plain version: CC may stage and commit — but only after Daniel types the
confirm phrase in the terminal, and push is still Daniel's paste, always.**
- **The phrase gates everything.** CC stages and commits ONLY after Daniel
  types the confirm phrase in the terminal for THIS commit:
  **[RULING NEEDED — confirm phrase; proposed: `COMMIT APPROVED`]**.
  No phrase, no stage, no commit. The phrase is per-commit, never
  standing; a green gate, a passed browser gate, or "looks good" in
  conversation is never the trigger. If a handoff implies commit
  authority without the phrase flow, that is a handoff defect — flag it.
- **Sequence on the phrase:** stage by explicit filename (never `-A`,
  never a bare directory; double-quote bracketed paths) →
  `git status --short` and verify the staged set exactly matches FILES
  CHANGED (any mismatch: stop, report, do not commit) → `git commit`
  with the drafted message.
- **`git push` is Daniel's paste — always, no pilot exception.** CC never
  pushes. Arch delivers the push as its own paste block; checks and
  Daniel-run pastes never share a paste.
- **Enforcement:** the settings deny list lifts `git commit` ONLY;
  `git push` stays denied in the deny list and the bash-fence. (The
  bash-fence's own `git commit` block must be lifted in the same
  execution pass — a lifted deny list behind a still-armed fence is a
  dead pilot; see the hook/fence execution notes.)
- **No-trailer rule (standing) — now hook-enforced:** the
  `.claude/hooks/commit-msg` hook rejects any commit message carrying
  `Co-Authored-By` or any other trailer; subject + body only. The
  drafting discipline is unchanged — never draft a trailer into a
  commit message; the hook is the backstop, not a license.
- **Unchanged from WF-1:** Arch never commits; Daniel's browser gate
  precedes any commit approval; commit messages follow the repo's
  existing style.
- **Pilot sunset:** reviewed at Sprint 4 close alongside the auto-mode
  rider — continue, revise, or revert to WF-1.
```

## 1b. Permission-mode rider — one-phrase patch

**PLACEMENT:** In `### Permission mode (July 23 rider — expires at Sprint 4
close)`, find the phrase `the WF-1
no-commit rule` (line-wrapped in the current file).

**FOLD TEXT (replace that phrase only):**

```
the WF-1a commit rules (phrase-gated stage/commit; push is Daniel's paste)
```

## 1c. Tier-A standing machine gates — tail-clause patch

**PLACEMENT:** In the bullet `**Standing machine gates for any run
(Tier A):**` find the final clause `nothing
staged, no commits — Daniel owns the commit checkpoint.`

**FOLD TEXT (replace that clause only):**

```
nothing staged, no commits before Daniel's terminal confirm phrase
(WF-1a) — Daniel owns the commit checkpoint; push is always Daniel's
paste.
```

## 1d. Desktop Handoff File Protocol — COMMIT BLOCK supersession

Two patches inside `## Desktop Handoff File Protocol`.

**PLACEMENT (first patch):** Replace the COMMIT BLOCK format
introduction line
`<the exact, paste-ready sequence for DANIEL to run after his browser
gates pass, in this order:`

**FOLD TEXT:**

```
<the exact sequence for this commit. Under the WF-1a pilot, steps 1–3
are executed by CC ONLY after Daniel types the confirm phrase in the
terminal; step 4 (`git push`) is always a paste Daniel runs himself,
after the commit lands. In this order:
```

**PLACEMENT (second patch):** Replace the first COMMIT BLOCK rule, the
bullet reading
`- The block is ALWAYS instructions FOR Daniel — CC never executes it
  (WF-1: CC never stages, commits, or pushes). There is no
  CC-executes exception.`

**FOLD TEXT:**

```
- Steps 1–3 execute ONLY on Daniel's per-commit confirm phrase (WF-1a);
  without the phrase, the block is inert record. Step 4 (`git push`) is
  NEVER executed by CC — no exception, pilot or otherwise.
```

*(The remaining COMMIT BLOCK rules — gate-first discipline, the
`git add`-matches-FILES-CHANGED defect rule — stand unchanged and are
not touched.)*

---

# FOLD 2 — Multi-Leg Run Pattern (Strat decision 2)

**PLACEMENT:** Insert as a new subsection in the CC Operating Contract,
immediately AFTER `### Internal checkpoints (self-gating for long runs)`
and before `### Proceed without asking (rubber-stamp authority)`.

**FOLD TEXT:**

```
### Multi-Leg Run Pattern (Aug 9 — standing; memorialized from the S3-G run)
Plain version: legs are planned disjoint up front, each leg gates and
documents itself before the next, commits land in leg order, and
Daniel's browser gates batch by how risky the leg is.
- **Step 0 — disjoint-footprint map, before any leg builds.** Enumerate
  every leg's file footprint and prove the footprints disjoint; where
  files are genuinely shared, declare them and the leg ordering that
  protects them. No map, no run.
- **Full machine gate set per leg** — build · strict typecheck · frozen
  gate · visual gate · guarded-code grep · dependency gate — run at each
  leg's close, never deferred to end of run.
- **Per-leg boundary files.** Each leg closes with its own boundary file
  (DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT, scoped to that
  leg) at the Desktop Handoff Protocol's fidelity bar.
- **Serial commits.** Commits land in leg order; a leg's commit is in
  before the next leg's commit lands. (Which legs share a commit is a
  per-run Arch/Daniel scoping call; seriality — never interleaving or
  reordering — is the standing rule.)
- **Context-budget handover license stands.** Legs within one unit may
  split across CC sessions when the context budget requires; the
  boundary file is the handover artifact, and the incoming session reads
  it before building.
- **Daniel's browser gates batch by risk class:** plumbing legs (no UX
  surface) batch to end of run; UX-surface legs gate BEFORE the next leg
  builds on them.
```

---

# FOLD 3 — PDF Evidence-Class Rule (Strat decision 3b)

**PLACEMENT:** Insert as a new subsection in the CC Operating Contract,
immediately AFTER the `### The Parity Rule (binds CC AND Arch)` section
and before `### Response quality (no first drafts)`.

**FOLD TEXT:**

```
### Evidence classes (Aug 9 — output parity is PDF-only)
Plain version: comparing printed output between v1 and v2 requires PDFs
on both sides; screenshots only prove what a screen looks like.
All v1↔v2 OUTPUT-parity evidence — anything comparing printed or
exported output between the two versions — is print-to-PDF, at 100%
scale, on matching paper size and orientation on BOTH sides of the
comparison. Screenshots remain valid for on-screen UX anatomy only
(layout, controls, dialog anatomy as rendered in the interface). A
screenshot of printed output is not parity evidence — treat it as an
unestablishable pedigree: OPEN QUESTIONS, request the PDF.
```

---

# HOOK FILE — `.claude/hooks/commit-msg` (delivered alongside this file)

The hook file `commit-msg` ships as its own download with this
deliverable. Contents are final; wiring has open questions.

**PLACEMENT NOTE (execution session):**

1. Save the file to `.claude/hooks/commit-msg` (exact name, no
   extension — git requires the literal hook name).
2. `chmod +x .claude/hooks/commit-msg` — run it explicitly. **The
   standing chmod instruction's glob (`chmod +x .claude/hooks/*.sh`)
   MISSES this file** — it has no `.sh` extension. July-24 incident of
   record applies in full: an unexecutable hook is silently dead.
3. **Wiring [RULING NEEDED]:** git does not run hooks from
   `.claude/hooks/` on its own. Two options:
   - **(1)** `git config core.hooksPath .claude/hooks` — one command,
     committed nowhere (per-machine); redirects ALL git hook lookup to
     that directory, so anything in `.git/hooks/` stops running
     (verify nothing lives there first).
   - **(2)** copy or symlink to `.git/hooks/commit-msg` — no config
     change, but per-machine and invisible in the repo; re-placement
     needed on any fresh clone.
   Housekeeping session verifies the repo's current hook state and
   Daniel rules 1 or 2.
4. Same execution pass: lift `git commit` from the settings deny list,
   lift the bash-fence's `git commit` block, confirm `git push` stays
   denied in both, and verify the hook fires by attempting a test commit
   with a `Co-Authored-By:` trailer on a throwaway change (expect
   rejection).
5. Propose (OPEN QUESTION, not a fold): widen the standing chmod
   instruction to `chmod +x .claude/hooks/*` so future extensionless
   hooks are covered.
```
