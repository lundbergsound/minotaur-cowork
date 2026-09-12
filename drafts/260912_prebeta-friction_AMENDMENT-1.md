# PREBETA-FRICTION — AMENDMENT 1 · the close, with the push held back

Tier: 3 (Claude Code)
Session: CONTINUE — same session as `260912-0841_prebeta-friction.md`. Nothing else changes; all three checkpoints stand as returned and green.

---

## 1 · §B is UPHELD. My handoff was wrong and you were right to bounce it.

**FENCE-PUSH landed 2026-08-30 and the push is yours on the phrase.** I re-measured at source rather than take the return's word for it: `.claude/settings.json:6` carries `"Bash(git push)"` in **allow**, deny at `:22-23` carries only `--force*` / `-f*` / `--delete *` / `--mirror*`; `bash-fence.sh:47-51` carries the explicit FENCE-PUSH block and its error string at `:131` says a bare push is permitted; the hook has its execute bit. `CLAUDE.md` has it right in six places and the Roadmap lists FENCE-PUSH closed at `9a333cc`/`0bf6df3`.

**The cause is `Architecture_Prompt_v35.md:198`** — the only live document still carrying the stale claim, installed twelve days after the ruling. This seat read it at the open and restated it. **Corrected at this session's close; the correction is already written into `drafts/260912_prebeta-friction_HANDOFF.md`.** Nothing in your work is affected.

## 2 · ⚠ THE ONE CHANGE: COMMIT, THEN STOP. DO NOT PUSH.

**Daniel has deferred his browser gate to a later sitting (his call, 2026-09-12, logged at `drafts/260912_owed-at-daniels-desk_v4.md`).**

A push is a **production deploy** — Vercel builds every push to `main` — and **GATE-BEFORE-COMMIT** says the human gate is what closes a handoff, not a follow-up to it. So this unit's work gets **saved** now and **released** later:

**On the phrase: stage by explicit filename → verify → commit → STOP.**

⚠ **This is Arch asking for LESS than your authority, not a contradiction of FENCE-PUSH.** The fence permits the push; this instruction declines to use it yet. Say so plainly in the terminal and in the `_CLOSE.txt` — record the push as **owed, pending Daniel's browser gate**, not as blocked.

**The `_CLOSE.txt` records the pushed state read from the ref files, which will correctly read: committed, not pushed, `origin/main` still at `96efd11`.**

## 3 · Everything else in the return is ACCEPTED

- **§A — accepted.** Parallelising the break loop means a failed purge attempts all actions instead of stopping at the first. That path was never atomic and the old code left it partially purged too; this is a difference of degree, it moves toward the state the plan intended so a retry converges, and declining it means declining the fix. The success path is a byte-identical row set. **The failure message's silence about changed link groups is registered as CABLEDEL-FAILMSG for Daniel's wording — not yours, and not in this unit.**
- **§C — the right call, and it is on the record as a decision.** Declining to write a proposal constant for a message that never renders was correct. A compliance gesture in the shape of the defect is still the defect.
- **§D — correct refusal, and it is now a registered row (EXPRPT-HINT) with Arch's marked proposal awaiting Daniel's wording.** Do not touch `settings/page.tsx:451`.
- **§E — accepted.** The 1,000-row PostgREST cap understates the cache the planner scanned; all sixteen target groups were inside the window and the planner's own work measured 0 ms. Nothing in the finding turns on it.
- **§F — confirmed.**

**Your CP2 method is the part of this return worth naming.** Refuting both of the handoff's candidate hypotheses by measuring the production — zero patch ends, so the per-row writers could not be the six seconds — and then finding the real cause in groups-per-cable, which no cable count would ever have revealed, is the unit doing its job rather than the instruction doing it. The handoff pointed at the wrong two things and said to measure first; measuring first is what made that survivable.

## 4 · Success condition

The commit exists, `origin/main` still reads `96efd11`, and the `_CLOSE.txt` names the push as owed pending Daniel's gate. **Then stop and return — do not open another unit; the next one has its own handoff and its own pointer.**
