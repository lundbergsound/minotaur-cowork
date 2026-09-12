# Parallel opener — META, every process / workflow / hygiene row in one pass

Written 2026-09-12 08:41 EDT by the Cowork-Arch **main line**, which owns the close.

**Why this exists:** ⚠ **RULED (Daniel, 2026-09-12) — process, workflow and document-hygiene work runs in ONE parallel session and never on the main line. The priority is Minotaur v2: features, integrity, momentum.** Every row below has been costing main-line time one at a time. This pass is the whole set, once, so none of it does that again.

**Seat:** a **Cowork-Arch parallel** session. It reads the repo and the governing corpus and it writes **proposals**. It builds nothing.

**Roadmap of record:** `Minotaur_v2_Roadmap_v4_31.md`. The row is **META**, ▶ ACTIVE, released by trigger and not by date (🏗 THE SEQUENCE, last bullet).

---

## Pre-open requirements

1. **The seat check first.** Confirm Cowork with `~/Developer/Minotaur-Cowork/`, `~/Developer/Minotaur/` and `~/Minotaur_v1_exports/` all reachable. A missing mount is a halt.
2. **Verify state from files, never by running git.** ⚠ **Any git command in either mount — `git status` included — leaves a lock this seat cannot delete, and that lock blocks CC's next commit.** Read `HEAD`, `logs/HEAD` and the ref files as plain text. State at this opener's writing, read that way: code repo `96efd113b4d232919ba121cb5da1f045384e7ee7`, `Minotaur-Cowork` `478ba4834fa7832a0749bbe8274932c035ac10fb`, both equal to their `origin/main`, no lock files, `CLAUDE.md` **115,579 characters** by `wc -m`.
3. **Read in this order:** `Architecture_Prompt_v35.md` → `Minotaur_v2_Roadmap_v4_31.md` → `Minotaur/CLAUDE.md` → `Architecture_Provenance.md` on citation.

## Read order for the work itself

`Architecture_Prompt_v35.md` §Delegation, §The handoff, §Commit authority, §Close · `CLAUDE.md`'s fence, harness and standing-rules sections · `.claude/settings.json` and `.claude/hooks/bash-fence.sh` · `handoffs/from-cc/260910-2135_verhist-guard.md` · `drafts/260910-2050_autonomy-measurements-and-proposal.md`.

---

## Scope — the twelve named members, plus the three found at the 2026-09-11 close

**The guard rail, and it is the whole method here: TEST THE GUARD, DO NOT READ IT.** Every claim below about what a matcher blocks is verified by running a case against it, never by reading the script.

1. **FENCE-HEREDOC** — `bash-fence.sh` blocks `sed -i` and redirects but does **not** match `python3 - <<'EOF'` opening and rewriting a file. **The second hole in this guard in three days.** The Aug-13 widening covers the mechanism in words; the matcher does not cover it in fact.
2. **WF1A-PHRASE** — Daniel's approval arrived as `OMMIT APPROVED: …`, a dropped leading character. CC accepted and flagged it. **The lesson is for the guard, not for CC: if the phrase is a mechanism, a matcher checks it rather than CC's judgment.**
3. **SEDRULE-REMAINDER** — ⚠ **DANIEL'S ALONE, not this session's to rule.** `perl -i`, `gawk -i inplace` and `ruby -i` on an ordinary repo file have **no control at all** under the auto-mode rider. Pinned as OPEN battery cases 15 / 16 / 136 / 137. **This session may re-measure and lay out the options; it does not decide.** Sits at Sprint 4 close with WF1A-SUNSET.
4. **CCSED-260911** — evidence, not a task: four single-file repo writes through bash heredocs in VERHIST-GUARD round 1, two without the immediate frozen-gate run; self-disclosed; round 2 made none. **Feeds SEDRULE-REMAINDER and WF1A-SUNSET.**
5. **UNATTENDED-MEASURE** — ⚠ **HELD. THREE MEASUREMENTS BEFORE ANY BUILD, AND NOTHING IS BUILT UNTIL MEASUREMENT 1 IS ANSWERED.** `--bare` is **struck from the design** — it skips discovery of hooks, skills, plugins, MCP servers, auto memory and `CLAUDE.md`. The candidate is `--restricted`. **(1) If `--restricted` refuses to read `settings.json`, does it also drop the HOOKS declared there? That is the only place the fence is wired.** (2) What values `--setting-sources` takes, and whether it can exclude `local`. (3) Whether the four gate invocations match under prefix semantics. **Measure, then propose. Never a build first.**
6. **DOCKET-ROWLENGTH** — the Docket is **61% of the Roadmap**; ▶ ACTIVE alone is 35%. **The rule to apply: a Docket row is ONE line saying what is owed and who owns it; the reasoning goes to the Ledger.** Pruning it is what lets the character cap ratchet down. ⚠ **Propose the rewritten rows as a file; the main line installs them.**
7. **GATE-REPORTING** — ⚠ **the guard is unobservable from the seat that enforces it.** Daniel's browser gate runs in his browser and is reported to Arch in Cowork; the confirm phrase is typed at CC. **Both of one session's units recorded the gate as never run when it had run and passed.** It needs a **reporting channel**, not more emphasis.
8. **GATE-BEFORE-COMMIT** — the approval phrase for `e3a336a` was typed at 23:05; the gate ran at 23:29 and 23:38. **A WF-1a push is a production deploy**, so a defect the gate caught would already have been live. **The commit block must state the gate as a precondition, not a follow-up.** Pairs with 7.
9. **CLAUDE-HARNESS-STALE** — `CLAUDE.md`'s harness section still describes SUBPIXEL-WANDER site 4 as `provisional: true` with a `refineBy`; GATE-NEST-UPGRADE dropped both and `screenshots/diff-exceptions.json` already carries the corrected reasoning.
10. **REPO-STRAY-UNTRACKED** — ⚠ **three untracked trees in the CODE repo, none of them ignored**, so each shows in every `git status`. `Claude outputs/` **is back**, two files written 2026-09-10 during a live CC session — **a second one-writer breach, recurring because September's instance was MOVED to `_to_delete/` and no ignore line was ever added.** *A breach closed by relocating the evidence is a breach that reopens.* Plus `{src/` (an unexpanded brace, 2026-07-04) and a stray `session-log-archives/`. ⚠ **And the measurement that explains a recurring loss: `Minotaur-Cowork/.gitignore` is TWO LINES — `.DS_Store` and `handoffs/`** — which is why files named explicitly in a `git add` are silently not committed. **Propose the ignore lines and the delete as exact commands for Daniel to paste.**
11. **REPO-MIGRATIONS-ABSENT** — ⚠ **measured, not inferred: `supabase/migrations/` holds TWO files against FIFTY-NINE applied.** It stops at 2026-07-11; everything since was applied through the Supabase tool and preserved only as a `drafts/` copy in a **different repository**. The database cannot be rebuilt from the code repo. Harmless with one database; blocking the day a staging environment, a restore drill or a second region is wanted. **Export the applied ledger to files and propose the standing convention.**
12. **HELD-IS-NOT-FORGOTTEN** — **STANDING (Daniel, 2026-09-11): a ⏸ HELD row without a named release trigger is illegal**, and every close checks whether any trigger has fired and moves those rows to ▶ ACTIVE. **Audit ⏸ HELD once, in full, against that rule.**

**The three found at the 2026-09-11 close, and they are the structural ones:**

13. **The Session Log header has no bound and is now the system's real memory.** It is ~95 bullets. Nothing in any prompt caps it.
14. **Rollover archives entries — so a finding written into an entry DIES unless it is lifted to the header first.** Archives are write-once and never read by working sessions. Pairs with 13: the only durable place is the thing with no bound.
15. **The register problem.** Arch reads a ~95-bullet header and a dense Roadmap at every open and then writes in that register — correct for another Arch session, **wrong in a message to Daniel.** Three writing failures in one close, one cause.

---

## Boundaries — these are what make a parallel safe

- **No CC handoffs.** None, for any member, however small.
- **No migrations, no schema, no grants, no RLS.**
- **No edits to the Roadmap, the Ledger, the Session Log, the Brief, the Architecture Prompt or `CLAUDE.md`.** ⚠ **Every one of them is the main line's.** Proposals are written as **separate files** in `handoffs/parallel/`, and the main line installs them at its close.
- **No repo commits and no pushes.** Daniel commits.
- **Writes nowhere the main line writes.** `handoffs/parallel/` and `drafts/` only.

## Not to be re-litigated — ruled and closed

- **WF-1a's shape is ruled:** subject-bound per-commit phrase; the phrase authorises the push; **the push half is INERT until FENCE-PUSH lands** (denied in `.claude/settings.json` **and** in `bash-fence.sh`, and a **Strat invariant**, so lifting it is a Strat-tier ruling that must land in the Strat record too). Sunset review is at **Sprint 4 close (WF1A-SUNSET)**, not here.
- **`--bare` is struck.** Do not reopen it.
- **The auto-mode rider expires at Sprint 4 close** and whether to extend it is **Daniel's**.
- **Roadmap structure is settled at four sections** — ▶ NOW · ⏭ NEXT · 🏗 THE SEQUENCE · 📌 THE DOCKET, no history, in that order. DOCKET-ROWLENGTH prunes *within* it; it does not restructure it.
- **Process findings register HELD by default unless they block the private-beta gate** (Strat, 2026-09-11).
- **Priority is Minotaur v2 and momentum.** ⚠ **If this pass starts proposing process that costs build time, it has failed.**

## Expected return

- `handoffs/parallel/260912_meta_RETURN.md` — **plain English first.** For each of the fifteen: what was measured, what is proposed, who owns it, and what it costs. **A number in it is a measurement or it is not written.**
- Separate proposal files for anything that becomes governing text, named `260912_meta_<member>_PROPOSAL.md`, so the main line can install each one whole.
- ⚠ **A short list of the members that turned out NOT to be worth doing.** Fifteen rows is a target to prune, not a quota to fill.
