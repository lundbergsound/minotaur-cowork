# Next session opener — Cowork-Arch, written 2026-09-10 19:13 UTC

*Written at the close of the four-unit session (leg 3a · BATCH-HARNESS · HARNESS-SETTLE · DARKMODE-PASS). **Paste the block in §0 into a fresh Arch chat.** Everything below §0 is for the seat, not for Daniel.*

---

## 0 · ⚠ WHAT DANIEL PASTES — nothing else is needed

```
Open the Minotaur Arch seat.

Read, in this order, from ~/Developer/Minotaur-Cowork/:
  1. Architecture_Prompt_v34.md
  2. Minotaur_v2_Roadmap_v4_25.md
  3. Minotaur_v2_Session_Log.md
  4. drafts/260910-1913_next_session_opener.md   <- this file, §1 onward
  5. drafts/260910-1913_owed-at-daniels-desk_v3.md

THE SESSION LOG IS AT 10 ENTRIES. THE ROLLOVER IS DUE AND RUNS BEFORE ANY
WORK: archive the oldest eight into session-log-archives/, leave two.
Do not start a unit before that is done.

Then verify state from files (never from memory, never from packed-refs),
tell me in plain English where we are, and propose the next move.
```

---

## 1 · ⚠ THE ROLLOVER IS THE FIRST ACT OF THE SESSION

`Minotaur_v2_Session_Log.md` closed at **10 `### ` entries**. The header already carries `Rollover: ⚠ DUE — RUN IT AT THE NEXT PRE-OPEN`. Archive the oldest **eight** to `session-log-archives/`, keep the newest two, and reset the header's `Current log:` count. **Do this before reading anything into a plan** — a rollover run after work has started competes with the work for the same file.

## 2 · State as measured at close — re-measure, do not trust these

| Measure | At close, 2026-09-10 19:13 UTC |
|---|---|
| Code repo `main` | **`dce1b72`** — origin identical, nothing to push |
| Cowork repo `main` | **`f0a5d42`** — origin identical, **but new drafts and Roadmap v4.25 are uncommitted** |
| Suite | **2978 tests / 156 files** |
| Typecheck | 0 |
| Frozen guards | 3 / 3 |
| Migration ledger | **57 — UNCHANGED for nine units** |
| `CLAUDE.md` | **114,954 of 150,000** — ⚠ **this number moves while CC is running; re-read it** |
| Visual gate | **five consecutive 28/28** — the first time this tree has closed it at all |

⚠ **Read HEAD from `.git/refs/heads/main`, never `.git/packed-refs`** — packed-refs carries a stale `be0769de`, which is also the frozen-gate baseline, so a stale read looks plausible (GIT-CFG). **Never run `git` in either repo folder** (O-1) — it leaves a lock file CC cannot delete.

## 3 · In flight when this was written

**CC is executing `handoffs/to-cc/260910-1854_fence-forms.md`**, started 18:54 UTC. Its return will land in `handoffs/from-cc/` (gitignored — carry anything durable out of it into a draft). If it has already returned, read it first: it is the only thing in the tree that may have moved since these numbers were taken.

## 4 · What was closed, and the one shape that runs through it

Four units, four production deploys, `1276cc4..dce1b72`. The Roadmap's CLOSED THIS SESSION section is authoritative; do not re-derive it here.

⚠ **Three Arch errors in one session, one shape:** *an instrument must not inherit the claim's parameters — census the class, then narrow.* The leg-3a needle priced against the wrong table · the flake (2) attribution taken from a non-discriminating invariant · **DARKMODE-PASS's entire premise, where six palette pairs were measured that render on no element anyone named.** Fifth occurrence on this project. **What saved the third one was that the handoff ordered a census BEFORE the fix and forbade concluding the colours were fine** — the instruction outlived the reasoning that produced it. **Write handoffs that way.**

## 5 · ⚠ REGISTER — this seat was corrected on it this session

Daniel said, in this session: *"I'm not sure what this chat is doing or what any of the things you said mean."* The cause was relaying seat-to-seat shorthand to him verbatim. **Docket ids, commit hashes and rule names are for the seat and for CC. What goes to Daniel is plain English: what happened, what it costs, what he has to decide.** Keep the two registers separate on purpose.

His standing instruction this week, stated twice: **keep CC working on things that do not need his attention, log every gate and ruling for later, and do not ask him to run gates.** His attention is divided. **Postpone, do not waive** — his words about the browser gate.

## 6 · Five new Docket rows were written into v4.25 at the close

**FIXTURE-NUMLABELS-GONE** and **DEADCLASS-SURFACE** in ACTIVE · **HARNESS-THEMEWRITE** in HELD · **APCA-NOT-WCAG** and **GATE-SETTLE-BETWEEN** in STANDING. They were named in the Docket Sweep before their rows existed — **that gap is the Parity Rule's own failure mode (uncited = unbuilt) and it was closed by hand.** When a sweep names a new row, write the row in the same edit.

## 7 · The next moves, in the order this seat would take them

1. **The rollover** (§1).
2. **Read CC's FENCE-FORMS return** and carry it out of the gitignored file.
3. **Commit the Cowork tree** — Daniel's block is in `drafts/260910-1913_cowork-commit-block.md`. He has said he will do commits if told what they are for.
4. **Issue the next long handoff.** The week plan in `drafts/260909-1931_low-involvement-week_plan.md` holds the four items that do **not** terminate at Daniel's eyes or printer. Everything else is gated on him and belongs in the owed list, not in a handoff.
5. ⚠ **The password rotation is the one time-sensitive item** — a credential was printed to disk by CC this session, disclosed and remediated. It is still owed.

## 8 · Do not do these

- **Do not re-import the parity fixture** to restore `num_labels` before someone looks at what ran **2026-09-01 13:03 UTC**. The re-import overwrites the only evidence. (FIXTURE-NUMLABELS-GONE.)
- **Do not sweep the 105 dead `text-surface-*` classes.** A dead class renders at full body colour; "repairing" it makes contrast worse. Daniel's ruling is owed. (DEADCLASS-SURFACE.)
- **Do not add the four new dark tokens to `tailwind.config.js`.** That single edit activates ~110 dead classes app-wide.
- **Do not quote six clean gate runs as a diagnosis** of GATE-THEMEGLYPH. Absence of evidence. (GATE-SETTLE-BETWEEN.)
- **Do not treat a green machine gate as consent**, and do not fold a refused run into a pass/fail count.
