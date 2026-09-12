# PROPOSAL — GATE-REPORTING and GATE-BEFORE-COMMIT: one mechanism, two symptoms

*Written 2026-09-12 by the META parallel (Cowork-Arch). Members 7 and 8, taken together because they share a cause. Proposal only; the main line installs.*

---

## Plain English, first

**The browser gate has no artifact.** Daniel runs it in his browser, says the result in Cowork, and types the confirm phrase at CC. Nothing writes it down anywhere durable. Measured: `Minotaur-Cowork/handoffs/` holds **0 tracked files out of 225 index entries** — the whole directory, both directions, is gitignored. So CC's returns and every gate result inside them exist on one disk and vanish on a fresh clone. **That is the reporting channel the row asks for: it does not exist, and it cannot be fixed by emphasis.** Two units of one session recorded the gate as never run when it had run and passed, and there was no record either of them could have checked.

**The ordering rule already exists — in the wrong place.** `CLAUDE.md`'s COMMIT BLOCK rules do say *"The block never weakens gate-first discipline: Daniel runs it only after his browser gates pass."* But the block's own numbered sequence starts at step 1, `git add`. The gate is a rule underneath the thing that gets pasted, not a step inside it. On `e3a336a` the phrase was typed at 23:05 and the gate ran at 23:29 and 23:38 — and because the push half has been live since 2026-08-30, that commit was already deployed to production before the gate that would have caught a defect ran.

**So: `CLAUDE.md` is not wrong, it is mis-ordered, and the fix is a step 0 rather than a new rule.**

---

## What was measured

- `handoffs/` in the Cowork repo: `0` tracked paths of 225 total in `.git/index`; `.gitignore` is two lines, `.DS_Store` and `handoffs/`. Gate results, CC returns and `_CLOSE.txt` artifacts all land there and none of them is in the repo.
- `drafts/` by contrast holds **135** tracked paths — so a durable channel exists and is working; it is simply not where gate results go.
- `CLAUDE.md` §Commit authority carries the doctrine correctly and in three places, including *"the browser gate that precedes commit approval is therefore the last check before live, not before a staging step"* and, at `:1569`, *"⚠ A WF-1a COMMIT IS A PRODUCTION DEPLOY. FENCE-PUSH is live."*
- The `_CLOSE.txt` contract already requires *"the measured counts (suite, typecheck, frozen, visual, dependency)"* and *"a number in it is a measurement or it is not written."* ⚠ **It does not require the browser gate's result.** The machine gates are recorded; the human gate is the one with no field.
- ⚠ **One encouraging data point, from the 2026-09-11 close:** CC refused a commit phrase without a gate result, *citing GATE-REPORTING*. The row is already changing behaviour through nothing but being written down. That argues for a small mechanism, not a large one.

---

## PROPOSAL 1 — a step 0 inside the COMMIT BLOCK

The COMMIT BLOCK is what gets pasted. Put the gate in it.

**In `CLAUDE.md`, the COMMIT BLOCK template becomes five steps, not four:**

```
 0. GATE: <the browser gate(s) this commit requires, named>, run and PASSED
    at <HH:MM> — Daniel's line, pasted or quoted. Absent or empty: CC does
    not execute the block and says so. A WF-1a commit is a production
    deploy; this is the last check before live.
 1. ONE `git add` line staging every changed/new file by explicit filename …
 2. `git status --short`, with the expected output stated on the next line …
 3. `git commit -m "<drafted message>"`
 4. `git push`
```

**And in the COMMIT BLOCK rules, replace** *"The block never weakens gate-first discipline: Daniel runs it only after his browser gates pass"* **with:**

> - **Step 0 is a precondition, not a courtesy.** The confirm phrase does not stand in for it: a phrase typed before the gate ran approves a deploy that nothing has checked. ⚠ **Measured precedent: on `e3a336a` the phrase was typed at 23:05 and the gate ran at 23:29 and 23:38.** With the push half live since 2026-08-30, a defect the gate caught in that window was already in production. If step 0 is empty CC stops and reports; it never proceeds on an inference that the gate probably passed.

⚠ **Why a step and not a stronger sentence:** the sentence exists already and was complied with in doctrine and not in order. A numbered step is inside the artifact CC executes, so skipping it is visible in the paste rather than inferable from its absence.

## PROPOSAL 2 — give the gate a durable artifact, in the channel that already works

**Add the browser gate to the `_CLOSE.txt` contract** as a required field, on the same terms as the machine counts:

> · **browser gate: named, result, and the time it ran** — Daniel's line quoted verbatim, or the explicit words `NOT RUN` with who deferred it and why. Unstated is a defect in the close artifact, exactly as an unstated suite count is.

**And make the artifact survive.** `_CLOSE.txt` lands in `handoffs/from-cc/`, which is gitignored. Two options:

- **(a)** Add a tracked `gates/` directory at the Cowork repo root; every `_CLOSE.txt` is copied there in the same step it is written, under `YYMMDD-hhmm_<unit>_CLOSE.txt`.
- **(b)** Apply the standing rule that already covers this — *"anything durable in a handoff is carried into `drafts/` in the same pass or it is not in the repo"* — to `_CLOSE.txt` explicitly, since `drafts/` is tracked and holds 135 files.

**Position: (b).** It adds no directory, no convention and no new rule; it names `_CLOSE.txt` under a rule that exists and is already obeyed for every other download-only deliverable. (a) is worth building only if gate results are ever wanted queryable as a set.

## PROPOSAL 3 — one line in the Architecture Prompt, so the seat asks for it

Under §Delegation, *"Daniel's browser gate and the commit step close every handoff"* becomes:

> Daniel's browser gate and the commit step close every handoff, **in that order**: the gate's result is quoted into step 0 of the COMMIT BLOCK before the phrase is requested. ⚠ **Arch never offers to defer a browser gate to after the commit** — the commit is a production deploy, so a deferred gate is a gate run on live code. Deferring it to a later *session* is Daniel's call and is recorded as owed.

The last clause is the one that matters: the 2026-09-11 close records Arch offering to defer a gate that then found two defects. The offer is the defect.

---

## What is deliberately not proposed

⚠ **No new gate, no automation of Daniel's browser gate, and no blocking mechanism.** The failure was ordering and record-keeping, and both fixes are text in documents that already exist. A mechanism here would cost a unit to protect a pilot whose sunset review is at Sprint 4 close — and the measured evidence is that CC already refuses on this row's name alone.
