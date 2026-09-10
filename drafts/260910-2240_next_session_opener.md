# Next session opener — Cowork-Arch, written 2026-09-10 22:40 UTC

*Written at the close of the FENCE-FORMS / FENCE-RULINGS session. **Paste the block in §0 into a fresh Arch chat.** Everything below §0 is for the seat, not for Daniel.*

---

## 0 · ⚠ WHAT DANIEL PASTES — nothing else is needed

```
Open the Minotaur Arch seat.

Read, in this order, from ~/Developer/Minotaur-Cowork/:
  1. Architecture_Prompt_v34.md
  2. Minotaur_v2_Roadmap_v4_25.md
  3. Minotaur_v2_Session_Log.md
  4. drafts/260910-2240_next_session_opener.md   <- this file, §1 onward

NO ROLLOVER IS DUE — the log stands at 3 and it fires at 10.

THE ROADMAP IS THE FIRST WORK OF THE SESSION, before any unit: v4.25 does not
carry FENCE-FORMS or FENCE-RULINGS at all, and six new Docket rows are owed.
The Ledger owes its eleventh append.

Then verify state from files (never from memory, never from packed-refs),
tell me in plain English where we are, and propose the next move.
```

---

## 1 · ⚠ WHAT THE LAST CLOSE OWED AND DID NOT DELIVER — read this before trusting v4.25

**The 2026-09-10 close installed the Session Log and NOTHING ELSE.** No Roadmap version, no Ledger append. That is a departure from every prior close in this log and it is recorded as a gap, not as a choice: **`Minotaur_v2_Roadmap_v4_25.md` is the current file and it predates both fence units entirely.**

**So the Roadmap you are reading is stale in a specific, enumerable way. Do not treat its Docket as complete.** What it is missing is §3.

⚠ **Two further process facts from that close, both measured:**

- **`handoffs/` IS GITIGNORED — the whole directory.** The two to-cc handoffs written that session (`260910-2007_fence-rulings.md`, `260910-2029_fence-rulings-AMEND1.md`) were named in the commit and **silently not committed**; git printed *"The following paths are ignored"* and moved on. This is the same reason CC's returns survive only as carry-out drafts. **Anything durable in a handoff must be carried into `drafts/` in the same pass or it is not in the repo.**
- **The rollover ran at the CLOSE, not at the pre-open.** The session opened on a question rather than an opener and nothing gated it. **The rule is unchanged and it reads "before any work."**

## 2 · State as measured at close — re-measure, do not trust these

| Measure | At close, 2026-09-10 22:40 UTC |
|---|---|
| Code repo `main` | **`31b4c26`** — origin identical, pushed, nothing owed |
| Cowork repo `main` | **`fa65e82`** — pushed, tree clean but for `_to_delete/` |
| Suite | **2980 tests / 157 files**, zero skipped |
| Typecheck / build / dependency gate | 0 / clean / clean |
| Frozen guards | 3 / 3 vs `be0769de` |
| Migration ledger | **57 — UNCHANGED for TEN units** |
| Fence battery | **147 cases · 126 pass · 0 fail · 21 open** |
| `CLAUDE.md` | **115,579 CHARACTERS** of 150,000 |
| Session Log | **3 entries — rollover clear** |

⚠ **`CLAUDE.md`'s limit is in CHARACTERS (`wc -m`), and the number of record was being read with `wc -c`.** The two differ by ~1,200 here because the file is full of multi-byte ⚠ and em dashes. **Read the right instrument.**

⚠ **Read HEAD from `.git/refs/heads/main`, never `.git/packed-refs`** (GIT-CFG). **Never run `git` in either repo folder** (O-1).

## 3 · ⚠ THE ROADMAP WORK, ENUMERATED. This is the session's first act.

**Install v4.26, retiring v4.25**, per KNOW-HYG — H1, filename and footer bumped together, 🧭 block counted at six bullets, output checked for duplicate Docket ids, CR and NUL bytes before install.

**CLOSED THIS SESSION must gain:** **FENCE-FORMS** (built, never committed on its own — its battery and candidate shipped inside FENCE-RULINGS) and **FENCE-RULINGS** at **`31b4c26`**, `dce1b72..31b4c26`, 4 files.

**Six Docket rows are owed, and the first two are the ones that matter:**

1. ⚠ **AUTH-RESETPAGE — ACTIVE, and it gates public beta on its own.** `minotaur.app` has **no page that completes a password reset**. Measured at source: `src/app/auth/` holds only `callback`, `login`, `signup`; the login page carries no "forgot password" link; `callback/route.ts` exchanges the code and redirects to `/dashboard` unconditionally, with no branch for a recovery type. **A recovery email's link is valid and lands on the sign-in page with nowhere to go.** Every beta user who forgets a password has **no recovery path at all** — not a degraded one.
2. ⚠ **FROZENCHECK-FAILOPEN — ACTIVE.** `.claude/hooks/frozen-check.sh` line 14 is `git show HEAD:"$SRC" > … 2>/dev/null || exit 0` — **if `git show` fails for any reason the hook exits 0 and the edit is allowed, silently.** Line 2 has the same shape: an absent `jq` empties `FILE` and falls to `*) exit 0`. **True today in interactive runs; headless is only where it becomes likely.** Second half: it compares against **HEAD** while `scripts/frozen-gate.mjs` compares against **`be0769de`**, so a bad change that gets committed becomes HEAD and the hook goes quiet. **The gate is the control; the hook is an early warning that stops warning at the worst moment.** It also carries no identifying header.
3. **HARNESS-SIGNOUT — ACTIVE, small.** `auth.sessions` held **1,431 rows** for the test user before the rotation; the harness signs in every run and never signs out. Cleared to 0. **A leaked credential's usefulness is normally bounded by session lifetime; a user that never signs out has no such bound.**
4. **VERHIST-LIBDEDUP — the design pass its seventh ruling waits on.** Fingerprint the library at snapshot time; if unchanged, reference the stored copy. Turns **1.71 MB of every 5.38 MB snapshot** into 1.71 MB per actual library edit. ⚠ **Cost: retention can no longer delete by date alone — expiry becomes reference-counted, inside the very path R-V2's viability depends on. Price it before +2 closes.**
5. **UNATTENDED-MEASURE — HELD, three measurements before any build.** ⚠ **`--bare` is STRUCK from the design: it skips hooks, skills, plugins, MCP and `CLAUDE.md`, so an unattended run under it has no fence, no frozen-check and no operating contract.** `--restricted` (v2.1.248+, present in v2.1.268) is the candidate. **Measurement 1, and nothing is built until it is answered: if `--restricted` refuses to read settings files, does it also drop the HOOKS declared there?** Then: what values `--setting-sources` takes and whether it can exclude `local`; and whether the four gate invocations match under prefix semantics. Detail in `drafts/260910-2050_autonomy-measurements-and-proposal.md`.
6. **SEDRULE-REMAINDER — STANDING, Daniel's, Sprint 4 sunset.** `perl -i`, `gawk -i inplace` and `ruby -i` on an ordinary repo file have **no control at all** under the auto-mode rider — only the Sed Disclosure Rule, which is an obligation on the writer. Pinned as measured OPEN battery cases 15/16/136/137 so it cannot quietly stop being true.

**VERHIST's ACTIVE row takes its six firm rulings** (§4) **and its one conditional.** **The Ledger owes its ELEVENTH append**, carrying both fence units, the three fail-open/misdocumenting controls, and the register correction in §5.

## 4 · VERHIST is RULED NEXT, and six of seven are firm

Restore is **fork-only** — always a copy, never an overwrite · **hourly, skip-if-unchanged**, retention 48h/30d/weekly · **snapshot before Change All, Delete Found, Delete All and import apply, plus a manual Save Version** · **if the snapshot fails, the gesture REFUSES** · History under **⚙ PROJECT → History** · **it is the next unit.** ⚠ **The seventh — the equipment library in snapshots — is a LEAN, not a ruling**, and Docket row 4 above is what closes it. **The Parity Rule applies: do not build against it.**

## 5 · ⚠ REGISTER — this seat failed on it TWICE this session, in the shape §5 of the last opener named

The `sed` ruling and the `git add` question were both put to Daniel as multiple-choice cards in seat shorthand. **He answered *"what does this mean?"* to both.** The repair was to explain the fence from first principles in plain English and re-ask in prose.

⚠ **The lesson is NOT "explain it better." It is that a question a seat can answer should never reach him at all.** The Parity Rule sends **UX** to Daniel; **an enforcement boundary inside the tooling is engineering structure and is Arch's.** Ruling A was then taken by Arch on exactly that reasoning — **and it is recorded as Arch's, with his words, and explicitly NOT as his approval.** *"Did not object" is not approval.*

His standing instruction is unchanged: **keep CC working on things that do not need his attention, log every gate and ruling for later, and do not ask him to run gates.**

## 6 · The shape that ran through the whole session, and it is the same one

**Three separate controls were found to be lying or asleep, and every one was caught by RUNNING it rather than reading it:** `sed --in-place` was never reachable by the matcher that claimed it — **and the first draft of CC's own return recorded that case as a PASS, from reading** · `frozen-check.sh` exits 0 when it cannot run · the installed fence's header read `CANDIDATE — NOT INSTALLED` while installed and in force. **Add the parallel audit's finding 3**, which inferred a config value from a directory listing and produced a confident false negative about a safety control, and it is four in one day.

⚠ **TEST THE GUARD, DO NOT READ IT** is already a standing rule. **What this session adds: the author of an instrument is not exempt from it.** The battery caught two defects in its own unit's work, both by running.

## 7 · Do not do these

- **Do not treat v4.25's Docket as current.** §3 is what it is missing.
- **Do not build on `frozen-check.sh`** or count it as a control until §3.2 is fixed.
- **Do not use `--bare` for anything unattended.** It removes every control this project has.
- **Do not re-import the parity fixture** to restore `num_labels` before someone looks at what ran **2026-09-01 13:03 UTC**. (FIXTURE-NUMLABELS-GONE.)
- **Do not sweep the 105 dead `text-surface-*` classes** — a dead class renders at full body colour and "repairing" it makes contrast worse. Daniel's ruling is owed. (DEADCLASS-SURFACE.)
- **Do not add the four new dark tokens to `tailwind.config.js`** — that single edit activates ~110 dead classes app-wide.
- **Do not open FENCE-HEREDOC inside another unit.** Consciously left a fifth time; `cp`, `mv`, `python3` and `node` writes are still unmatched and **three of the five reach a frozen file**.
- **Do not scope a repo-root predicate** unless the over-block actually bites — the trigger is a legitimate in-place `sed` on a file outside both the repo and the scratch destinations.
- **Do not treat a green machine gate as consent**, and do not fold a refused run into a pass/fail count.

## 8 · Owed at Daniel's desk — unchanged except for one addition

**Nothing from FENCE-RULINGS.** The credential rotation is **DISCHARGED** — the one time-sensitive item is gone.

Carried: the browser gates **POSTPONED, NOT WAIVED** on leg 3a, HARNESS-SETTLE and DARKMODE-PASS · **DEADCLASS-SURFACE** and the other rulings in `drafts/260910-1913_owed-at-daniels-desk_v3.md` §4–§5 · the **5167 sheet against a real Avery blank**, still the only unrun acceptance on a shipped unit · the **Tail Panel reprint** · **CAND-4 overdue** · **LEGAL-SEP is now**.

⚠ **New, and it is his alone:** **the auto-mode rider's Sprint 4 sunset now carries a consequence it did not before** — while it stands, `perl`, `gawk` and `ruby` can edit any repo file with no control whatsoever. **That is an argument for letting it expire on schedule rather than extending it, and the decision is his.**
