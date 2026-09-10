# Autonomy readiness — the two measurements, the Ruling A provenance, and a proposal

*Written 2026-09-10 ~20:50 UTC from the Cowork Arch seat, in answer to Daniel's three-item
instruction relayed through the parallel seat. **Item 1 (the header fix) was NOT done — see
§0. Nothing was built. The runner is not started.***

---

## §0 — ⚠ ITEM 1 DEFERRED ON PURPOSE: CC IS EDITING THAT FILE RIGHT NOW

**`.claude/hooks/bash-fence.sh`'s header fix is already in flight.** FENCE-RULINGS AMEND-1
§4a (`handoffs/to-cc/260910-2029_fence-rulings-AMEND1.md`) instructs CC to verify that header
at source and rewrite it, inside the unit that is executing as this is written.

⚠ **Two seats editing one file concurrently is how an edit disappears without either author
seeing it fail** — and this file is a live PreToolUse control, so a lost or half-applied edit
is not a documentation problem. **The instruction and the in-flight work agree on the fix;
they only disagree on who runs it.** CC has the file, so CC does it.

AMEND-1 §4a already carries the two things that matter beyond the wording: **verify at source
before editing** (the same instruction Daniel's item 1 gives), and **a header must never
assert its own file's install state**, because the identical bytes live at both the installed
and the candidate path — it names which PATH means what instead. Also folded in: check
`bash-fence.candidate.sh` and `frozen-check.sh` for the same defect.

**If CC's return does not show the header corrected, it comes straight back as a one-line
amendment.** It is not dropped.

## §1 — ITEM 2: RULING A's PROVENANCE, RECORDED

**RULING B — DANIEL'S.** `git add -u`, `git add :/`, `git add ./` join the ruled
bulk-staging set. His words at the time: *"closing them makes sense."* Confirmed again now:
*"different phrasing of already fenced git commands."* **Correctly attributed everywhere.**

**RULING A — ARCH'S, NOT DANIEL'S. Daniel was notified, not consulted for approval, and the
record must not say otherwise.** In-place `sed` is blocked on any repo file, not only the
frozen layer.

**How it actually happened, because provenance is the point:** Daniel WAS asked, in plain
English, and answered *"that rule is too far out of my depth to make sense to me."* ⚠ **That
answer was correctly read as the question being mis-routed rather than as a deferral** — the
Parity Rule sends UX to Daniel, and an enforcement boundary inside the tooling is engineering
structure. Arch then ruled it, told him what it had ruled and why, and he did not object.
**"Did not object" is not approval and is not recorded as approval.**

- **It is a TIGHTENING and it STAYS IN FORCE.** Installed 2026-09-10, live, measured
  147/125/0/22.
- **It is overrulable by Daniel at any time**, and that has been stated to him in those words.
- ⚠ **THE CONSEQUENCE THAT WILL BITE SOMETHING: any handoff written on the assumption that
  `sed -i` works on an ordinary repo file will now HARD-STOP at the fence.** Multi-site
  mechanical edits go through `perl -i` / `gawk -i inplace` / `ruby -i` under the unchanged
  Sed Disclosure Rule ledger, or through the Edit tool.
- **The CLAUDE.md passage that still says otherwise is being corrected in the same unit**
  (AMEND-1 §4) — it currently reads that in-place `sed` is permitted under a ledger, which
  after this install is false. **Until that lands, the contract and the enforcement
  disagree, and the enforcement is the one that is true.**

## §2 — ITEM 3(a): `--bare` — IT EXISTS, AND IT IS THE WRONG TOOL FOR THIS JOB

**Measured against the published Claude Code CLI reference, NOT against Daniel's installed
build** — ⚠ **the build-specific half of the question is still unmeasured**, and confirming it
needs one command in his terminal (`claude --help`), which is his hand, not mine.

**`--bare` exists: it is a minimal mode that skips auto-discovery.** ⚠ **It is not a
permission mechanism and it does not constrain anything.** Building the unattended posture on
it would produce a run that loads fewer things and can still do everything.

**The flag that actually does the job is `--settings <path>`**, which points a single run at
an alternate settings file. **Documented precedence, highest first:**

```
1. Managed settings (MDM / managed-settings.json)
2. --settings (command line)          <- the unattended file lands HERE
3. .claude/settings.local.json         <- the 184 additive allow rules
4. .claude/settings.json
5. ~/.claude/settings.json
```

⚠ **The unattended file therefore sits ABOVE `settings.local.json` without touching it** —
which is exactly the standing constraint that those 184 rules are neither pruned nor used.
**Whether a higher-precedence `permissions.allow` REPLACES the lower one or merges with it is
NOT established here, and the design must not depend on the answer** — see §4.

Two further facts that shape the design, both documented:

- ⚠ **DENY BEATS EVERYTHING.** Rules evaluate deny → ask → allow, first match wins, and
  specificity does not reorder them. **A `deny` entry cannot be overridden by any allow at
  any precedence level.**
- ⚠ **A PreToolUse hook runs even for an allow-listed call, and a hook exiting 2 beats an
  allow rule.** **The bash fence is therefore already overriding those 184 rules for
  everything it matches** — which sharpens the original finding rather than softening it:
  the 184 rules are dangerous precisely and only where the fence has NO matcher, and
  `node`, `python3` and `curl` are that gap, as reported.

## §3 — ITEM 3(b): `frozen-check.sh` — THE ANSWER IS WORSE THAN "IT BREAKS"

Read at source, all 24 lines. **The `git show HEAD:` call is not the fragile part.**

```bash
git show HEAD:"$SRC" > /tmp/frozen_head.$$ 2>/dev/null || exit 0
```

⚠ **THIS CONTROL FAILS OPEN. If `git show` fails for any reason at all, the hook exits 0 and
the edit is ALLOWED, silently.** No message, no nonzero exit, nothing in the transcript. And
line 2 has the same shape: `FILE=$(jq -r …)` — **if `jq` is absent the variable is empty, the
`case` falls to `*) exit 0`, and every edit passes unchecked.**

**So the honest answer to "does it work headless" is: it does not necessarily FAIL headless —
it silently stops working, which is strictly worse than failing.** *A guard that answers
"pass" when it could not run is the SCAN-NONZERO family again, and this one is a live control
on the frozen layer.* **This is true today, in interactive runs, and is not a headless
problem at all** — headless is only where it becomes likely.

**Second finding, smaller and worth its own line: this hook checks against `HEAD`, while the
frozen GATE (`scripts/frozen-gate.mjs`) checks against the declared baseline `be0769de`.**
They ask different questions. The hook asks *"did this edit change the region since the last
commit"*; the gate asks *"does the region still match the baseline"*. ⚠ **Once a bad change
is committed, it becomes HEAD and the hook stops objecting to it.** The gate is the real
control; the hook is an early-warning that goes quiet at exactly the wrong moment.

**Neither is fixed here.** Both are named so the runner is not built on top of them.

## §4 — THE PROPOSAL. THIS IS A RULING REQUEST, NOT WORK, AND NOTHING IS BUILT.

**Shape, for Daniel's yes/no. Deliberately built on DENY and HOOKS rather than on a narrowed
allow list, because deny and hooks are the two things whose precedence is documented and
unconditional** — the merge-versus-replace question in §2 then cannot sink it.

**A · `.claude/settings.unattended.json`, used only as `claude --settings <that file> …`**

- **DENY, non-negotiable and load-bearing:** `git commit` in every spelling · `git push` in
  every spelling (**a push is a production deploy**) · `mcp__…__execute_sql` · `mcp__…__apply_migration` ·
  `rm` · `curl` and `wget`. Deny wins over every allow beneath it, including all 184.
- **ALLOW, small and explicit:** the read-only set and the four gate commands, named exactly.
- **HOOKS declared explicitly in this file** — never inherited, never assumed.
- ⚠ **`node` and `python3` are the unresolved half and the proposal does not pretend
  otherwise.** The gates ARE `node`. Denying `node` denies the gates; allowing `node *` is
  the hole the whole exercise exists to close. **The only shape that survives both is
  allowing the four gate invocations by exact string and denying `node` otherwise** — and
  whether Claude Code's matcher can express that precisely enough to be worth trusting is
  **the first thing to measure, before any of this is built.**

**B · A `Stop` hook gating turn-end on `npm run test` · `npm run type-check` ·
`npm run test:visual` · `node scripts/frozen-gate.mjs`**

- **`Stop` exists and CAN block: exit 2 is a blocking error on a blockable event.** So the
  red-gate-blocks-the-turn design is mechanically possible. (`SessionEnd` and `StopFailure`
  also exist. **`SubagentStop` is NOT in the documented event list** — the findings file
  should not assume it.)
- ⚠ **RULING OWED, and it is Daniel's: does a red gate BLOCK the turn or only ANNOTATE it?**
  Blocking risks a wedged loop where the hook refuses to let a turn end that cannot fix
  itself; annotating risks a red gate scrolling past unread at 3am. **A defensible middle:
  block once, annotate on the retry, and never block twice on the same failure** — but that
  is a proposal, not a ruling, and it needs the wedge case thought through before it is one.
- ⚠ **THE STOP HOOK MUST NEVER READ AS CONSENT. It appends to the browser and print queue; it
  does not accept.** Written into the hook's own comment, not just into a document —
  *a green machine gate is not consent* is already a standing rule and this is the place it
  would most easily be eroded.
- ⚠ **It must also fail CLOSED**, unlike `frozen-check.sh` — if a gate cannot RUN, that is not
  a pass. §3 is the argument.

**C · Unchanged and not up for negotiation in any of this:** the browser and print gates stay
Daniel's by construction · `settings.local.json` is neither pruned nor used for unattended
runs · WF-1a's confirm phrase still gates every commit, which is why commit and push are
DENIED outright above rather than left to the phrase.

## §5 — MEASURE BEFORE ANY OF §4 IS BUILT

1. **`claude --help` on Daniel's installed build** — confirm `--settings` and `--bare` are
   present in the version he actually runs. One command, his hand. ⚠ **Everything in §2 is
   read from published docs, not from his machine.**
2. **Whether a higher-precedence `permissions.allow` replaces or merges with a lower one.**
   The design above survives either answer; anything simpler does not.
3. **Whether the permission matcher can allow four exact `node …` invocations while denying
   `node` generally.** If it cannot, §4A's node question reopens and the runner waits.

⚠ **CLAUDE.md was 114,954 of 150,000 characters at the last measurement and this unit is
adding to it. Trim before any leash-lengthening** — that constraint stands and is not
addressed here.
