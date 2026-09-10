## SEPTEMBER 10, 2026 — ELEVENTH APPEND — FENCE-FORMS AND FENCE-RULINGS CLOSED IN ONE COMMIT AT `31b4c26` · ⚠ THE BASH FENCE MEASURED FOR THE FIRST TIME AND WRONG 17 WAYS IN BOTH DIRECTIONS, WITH `sed --in-place` NEVER REACHABLE BY THE MATCHER THAT CLAIMED IT · THE TEST-USER CREDENTIAL ROTATED AND THE ITEM DISCHARGED · ⚠ TWO PRODUCT DEFECTS FOUND BY DOING THE CHORE RATHER THAN BY LOOKING FOR THEM, ONE OF WHICH GATES PUBLIC BETA ON ITS OWN · ⚠ THREE SEPARATE CONTROLS FOUND FAILING OPEN OR MISDOCUMENTING THEMSELVES IN ONE DAY, EVERY ONE CAUGHT BY RUNNING IT · AN AUTONOMY AUDIT WHOSE FINDING 3 WAS FALSE · `--bare` STRUCK FROM THE UNATTENDED DESIGN · VERHIST'S SEVEN RULINGS ANSWERED, SIX FIRM (append block)

### 1 · The session, and the two departures it is recorded with

One unit's worth of commit, two units' worth of work. **FENCE-FORMS was built and never committed on its own** — its 114-case battery and its candidate hook shipped inside FENCE-RULINGS' commit — which is why **no Roadmap has ever carried it**, and why this append and Roadmap v4.26 are the first documents in which it exists.

⚠ **TWO PROCESS DEPARTURES, BOTH MEASURED, BOTH RECORDED AS GAPS RATHER THAN AS CHOICES.**

**(1) The rollover ran at the CLOSE, not at the pre-open.** The session opened on Daniel's question rather than on an opener, and **no seat check gated it**. The rule reads *"before any work"* and this session did a day's work first. The archive itself is sound — `Session_Log_Archive_2026-09-10.md`, the oldest **8** entries, **byte-exactness proven by reconstructing the pre-rollover file from header + archive + kept remainder and asserting equality**, not by eye — and the live log reset to the header plus the most recent **2**, taking it to **3**. The defect is the timing, not the artifact.

**(2) The close installed the Session Log and NOTHING ELSE.** No Roadmap version, no Ledger append. **That is a departure from every prior close in this log**, and it left `Minotaur_v2_Roadmap_v4_25.md` standing as the current file while carrying neither fence unit. *A Roadmap that is current and does not describe the day's work is the stale-document exposure in its purest form: it does not fail quietly, it gives orders.* Both are repaired here.

⚠ **AND A THIRD, SMALLER, WHICH EXPLAINS A RECURRING LOSS: `handoffs/` IS GITIGNORED — the whole directory.** The two to-cc handoffs written that session (`260910-2007_fence-rulings.md`, `260910-2029_fence-rulings-AMEND1.md`) were **named in the `git add` and silently not committed**; git printed *"The following paths are ignored"* and moved on. **This is the same reason CC's returns survive only as carry-out drafts.** The operating rule that follows: **anything durable in a handoff is carried into `drafts/` in the same pass, or it is not in the repo.**

### 2 · FENCE-FORMS — the battery, and the unit whose thesis was its own author

CC built a **114-case battery** that feeds destructive command spellings to `.claude/hooks/bash-fence.sh` **as data on stdin**, so every case is judged without any of them running. Measured against the installed fence, it was **wrong 17 ways in both directions: 8 false negatives and 9 false positives.**

⚠ **THE CENTRAL FINDING IS THE UNIT'S OWN AUTHOR. `sed --in-place` WAS NEVER REACHABLE BY THE MATCHER THAT CLAIMED TO BLOCK IT.** The optional prefix group must end in whitespace, so the `-` the matcher requires is always token-initial — and `--in-place`'s is followed by another `-`. The spelling could never match. ⚠ **The first draft of CC's own return recorded that case as a PASS, from READING. The battery said ALLOW.** *Reading a guard reports the reader's belief.* **TEST THE GUARD, DO NOT READ IT** was already a standing rule; **what this session adds is that the author of an instrument is not exempt from it.**

### 3 · FENCE-RULINGS — `31b4c26`, 4 files, `dce1b72..31b4c26`, one production deploy

Three further spellings were found that **the ruled list did not name**: `-i.bak.2`, an attached quoted suffix, and **GNU long-option abbreviation**. ⚠ **Two of the three had been reaching a FROZEN file** — so the widened `INPLACE_FLAG` is not a widening of the remit but the frozen guard finally covering the class it had always claimed to cover (case 132 proves it).

**The battery is now a standing suite file** with a 120-second budget, so the fence is regression-tested by every run rather than by hand. ⚠ **It caught TWO defects in this unit's own work, both by running:** a `read` that dropped the final token — **which is exactly where a `sed` file operand lives** — and a wrapper that failed as a 5-second timeout **wearing the shape of a verdict failure**.

⚠ **A HOOK BODY CHANGE TAKES EFFECT ON THE NEXT TOOL CALL WITH NO SESSION RESTART — MEASURED, and open since FENCE-FORMS.** Case 129 was fired as a real Bash call in a session already running when the file changed underneath it, and the fence refused it with the new message. **Do NOT generalise this to `.claude/settings.json`, which is read once at session start.** The distinction now lives in the hook's own header.

⚠ **AND THE HEADER IS WHY IT HAD TO: the installed fence's own header read `CANDIDATE — NOT INSTALLED` while installed and in force.** *The document that lied was the control itself.*

### 4 · The credential rotation — DISCHARGED, and the two product defects it found

`daniel+pt@daniellundberg.com`, the harness's test user and the Visual Gate Fixture's owner. Rotated by **direct `auth.users` update in the SQL editor at 19:51:33 UTC**, and **verified live from the Arch seat rather than taken on report**: `updated_at` moved, `recovery_token` cleared, `recovery_sent_at` null, **sessions 0 and refresh tokens 0**. **The one time-sensitive item on Daniel's desk is gone.**

⚠ **IT COULD NOT BE DONE THROUGH THE PRODUCT, AND THE REASON IS A DEFECT THAT GATES PUBLIC BETA ON ITS OWN. `minotaur.app` HAS NO PAGE THAT COMPLETES A PASSWORD RESET.** Measured at source: `src/app/auth/` holds only `callback`, `login` and `signup`; the login page carries **no "forgot password" link**; and `callback/route.ts` **exchanges the code and redirects to `/dashboard` unconditionally, with no branch for a recovery type**. **A recovery email's link is valid and lands the user on the sign-in page with nowhere to go.** Every beta user who forgets a password has **no recovery path at all — not a degraded one.** Registered as **AUTH-RESETPAGE**.

⚠ **AND THE ROTATION SURFACED A SECOND FINDING NOBODY WAS LOOKING FOR: `auth.sessions` HELD 1,431 ROWS FOR THE TEST USER.** The harness signs in on every gate and capture run and **never signs out**, going back months. Cleared to 0. **The housekeeping half is trivial; the security half is not** — *a leaked password's usefulness is normally bounded by how long a session minted with it survives, and a user that never signs out has no such bound.* The credential incident's blast radius was therefore larger than *"the password was on disk"* implies, and **the session delete was remediation, not tidying.** Registered as **HARNESS-SIGNOUT**.

*Two product defects found by DOING a chore rather than by looking for them. The chore was the instrument.*

### 5 · The third control — `frozen-check.sh` fails open, found by reading it at source

`.claude/hooks/frozen-check.sh` line 14 is `git show HEAD:"$SRC" > … 2>/dev/null || exit 0` — **if `git show` fails for any reason the hook exits 0 and the edit is allowed, silently.** Line 2 has the same shape: `FILE=$(jq -r …)`, and **an absent `jq` empties the variable, falls through to `*) exit 0`, and passes every edit unchecked.** ⚠ **This is true TODAY in interactive runs; headless is only where it becomes likely.**

Second, smaller, and it is the half that bites late: **the hook compares against `HEAD` while `scripts/frozen-gate.mjs` compares against the declared baseline `be0769de`** — so once a bad change is committed it becomes HEAD and the hook stops objecting. ⚠ **THE GATE IS THE REAL CONTROL; THE HOOK IS AN EARLY WARNING THAT GOES QUIET AT EXACTLY THE WRONG MOMENT.** Neither half fixed; both named so nothing is built on top of them. It also carries **no identifying header at all** — a one-line fix for whichever unit is next in that directory. Registered as **FROZENCHECK-FAILOPEN**.

### 6 · The autonomy audit — one of four findings was FALSE, and it was false in a familiar way

A parallel seat's audit reported that `commit-msg` is inert — no `core.hooksPath`, `.git/hooks/` holding only samples — so the no-trailer backstop never runs. ⚠ **`.git/config` line 8 reads `hooksPath = .claude/hooks`, measured at source.** **An empty default hooks directory is the SIGNATURE OF A WORKING REDIRECT, not evidence against one.** *An audit inferred a config value from a directory listing and produced a confident FALSE NEGATIVE about a safety control.* Corrected in `drafts/260910-2040_autonomy-audit-correction.md` and in FENCE-RULINGS AMEND-1 §4b, and confirmed independently by CC.

**Findings 1, 2 and 4 stand.** `settings.local.json` carries **184 allow rules, zero ask, zero deny, no hooks** — purely additive, accreted from months of *"always allow"* · **no `Stop` hook exists** · the fence header lied (fixed in this unit).

⚠ **AND THE REMEDY THAT AUDIT PROPOSED WOULD HAVE REMOVED EVERY CONTROL THIS PROJECT HAS.** `--bare` skips auto-discovery of **hooks, skills, plugins, MCP servers, auto memory and `CLAUDE.md`** — so an unattended run under it would have **no bash fence, no frozen-check and no operating contract**: the least constrained session this project has ever run, **the exact inverse of the intent. `--bare` is STRUCK from the design.**

The candidate that remains is **`--restricted`** (v2.1.248+, present in the installed v2.1.268): it removes `Bash`/`WebFetch` from the tool set unless named in `--allowedTools`, confines file operations to the working directory, and **refuses to read settings files that could re-grant what it removed — which neutralises the 184 rules without pruning them.** ⚠ **THE QUESTION THAT DECIDES WHETHER IT IS USABLE IS UNMEASURED: if it refuses to read `settings.json`, does it also drop the HOOKS declared there? That is the only place the fence is wired. MEASURE BEFORE ANYTHING IS BUILT.** Registered as **UNATTENDED-MEASURE**, three measurements deep, detail in `drafts/260910-2050_autonomy-measurements-and-proposal.md`.

Two facts that shape that design and are measured rather than assumed: **deny beats every allow at every precedence level**, and **a PreToolUse hook runs even for an allow-listed call and beats it on exit 2** — so the fence already overrides those 184 rules everywhere it has a matcher, and they are dangerous **precisely and only** where it has none: `node`, `python3`, `curl`.

### 7 · Rulings of record — this append

**Daniel — VERHIST, six of seven FIRM, and the unit is unblocked.** Restore is **fork-only**, always a copy and never an overwrite · **hourly with skip-if-unchanged**, retention **48h / 30d / weekly** · **snapshot before all four destructive gestures** — Change All, Delete Found, Delete All, import apply — **plus a manual Save Version** · ⚠ **if the snapshot fails, the gesture REFUSES** (Arch's position, taken) · History lives under **⚙ PROJECT → History** · **VERHIST is the NEXT unit.**

⚠ **THE SEVENTH IS A LEAN, NOT A RULING, AND THE PARITY RULE APPLIES — NOTHING IS BUILT AGAINST IT.** He leans yes on including the equipment library in snapshots but asked whether an unchanged library can be stored once across successive snapshots. **Content-fingerprint dedup turns 1.71 MB of every 5.38 MB snapshot into 1.71 MB per actual library edit — at the cost of reference-counted expiry, inside the very retention path R-V2's viability depends on.** Registered as **VERHIST-LIBDEDUP**; **the design pass is owed before +2 closes** and it is VERHIST's opening move.

**Daniel — RULING B:** `git add -u`, `:/` and `./` **join the ruled bulk-staging set** (*"different phrasing of already fenced git commands"*).

**Arch — RULING A, and it is recorded as ARCH'S, with Daniel's words, and explicitly NOT as his approval.** In-place `sed` is blocked on **any repo file and every non-scratch path**, not only the frozen layer; `perl`, `gawk` and `ruby` unchanged. ⚠ **Daniel was ASKED and answered *"that rule is too far out of my depth to make sense to me."*** That was read as the question being **mis-routed rather than deferred** — the Parity Rule sends **UX** to Daniel, and **an enforcement boundary inside the tooling is engineering structure and is Arch's.** Arch ruled it, told him, and he did not object. ⚠ ***"Did not object" is not approval and is not recorded as approval.*** It is a tightening, it is in force, and **it is his to overrule.**

**Arch, also:** **accept the inherited over-block** — `scratch_ok` is a permitted-*destination* test rather than a repo test, so a non-scratch path outside the repo is refused too; that is the redirect guard's own long-standing behaviour, and a real repo-root predicate becomes a Docket row **that gets scoped if and when it bites** · **§B and §C ratified as built** · **the widened `INPLACE_FLAG` is not a widening of the remit**, per case 132.

### 8 · ⚠ The register failed TWICE this session, in the exact shape the last opener's §5 named

The `sed` ruling and the `git add` question were **both put to Daniel as multiple-choice cards in seat shorthand.** He answered ***"what does this mean?"*** to both. The repair was to explain the fence from first principles in plain English — what it is, what it guards, what the two decisions actually cost — and re-ask in prose.

⚠ **THE LESSON IS NOT "EXPLAIN IT BETTER." IT IS THAT A QUESTION A SEAT CAN ANSWER SHOULD NEVER REACH HIM AT ALL.** Ruling A is that correction applied. His standing instruction is unchanged: **keep CC working on things that do not need his attention, log every gate and ruling for later, and do not ask him to run gates.**

### 9 · ⚠ The shape that ran through the whole session, and it is one shape

**Three separate controls were found to be lying or asleep, and every one was caught by RUNNING it rather than by reading it:** `sed --in-place` was never reachable by the matcher that claimed it — *and the first draft of CC's own return recorded that case as a PASS, from reading* · `frozen-check.sh` exits 0 when it cannot run · the installed fence's header read `CANDIDATE — NOT INSTALLED` while installed and in force. **Add the parallel audit's finding 3, which inferred a config value from a directory listing and produced a confident false negative about a safety control, and it is FOUR IN ONE DAY.**

⚠ **NEW STANDING RULE — THE AUTHOR OF AN INSTRUMENT IS NOT EXEMPT FROM "TEST THE GUARD, DO NOT READ IT."** The battery caught two defects in its own unit's work, both by running.

### 10 · A Docket hygiene defect, measured in this file's own successor and registered rather than silently repaired

⚠ **v4.25's DOCKET SWEEP CLAIMED RETIREMENTS IT DID NOT PERFORM.** It states *"Retired to the Ledger: FIELD-CONTRACT · FINDPARITY-UNTYPED · DARKMODE-PASS · NEXTENV-CHURN — index 26 → 30."* **Measured in the file itself: none of it happened.** `FIELD-CONTRACT`, `FINDPARITY-UNTYPED` and `DARKMODE-PASS` are still **live rows in ▶ ACTIVE**; the retirement index gained **no row** and still reads **26**; `NEXTENV-CHURN` appears in **no Ledger append at all**.

**Two more sit beside them from earlier versions:** `CLAUDEMD-ATLIMIT`, closed by ROADMAP-REFACTOR in the **eighth append**, still reads *"⚠ IMMEDIATE. No build unit runs before it"* — **an order that is false** — and `ROADMAP-REFACTOR` itself, closed in v4.23. `CAPFLAKE-LIBLIGHT` is a sixth: v4.25 calls it closed as a duplicate and **its text is in no append**, so retiring it would LOSE it.

⚠ **IT WAS NOT REPAIRED IN THIS PASS, AND THE REASON IS NAMED RATHER THAN LEFT TO BE INFERRED: retiring `FIELD-CONTRACT` would drop LEG 3b, which v4.25 declared opened and gated on nine rulings and then never gave a Docket row to.** The repair needs leg 3b scoped from the tenth append first, and **inventing it inside a pass scoped to something else is precisely the error this Ledger keeps recording.** Registered as **DOCKET-STALEACTIVE**, with its own small Arch pass: scope leg 3b, carry `CAPFLAKE-LIBLIGHT`'s text into an append, then retire all six together.

*A sweep line that asserts a retirement is itself a document, and a document that asserts an action is not the action.*

⚠ **AND A SECOND HYGIENE FINDING, MEASURED AT THIS OPEN, ONE THIRD OF WHICH IS ARCH-OUTPUTS-MIRROR RECURRING TODAY.** Three untracked trees sit in the CODE repo working directory and **none is in its `.gitignore`**, so every one shows in `git status` and is excluded by hand on every commit. **(1) `Claude outputs/` IS BACK, and two of its four files were written 2026-09-10 at 20:31 and 20:38 UTC — during the FENCE-RULINGS session, while a CC session was live.** ⚠ **That is a SECOND breach of the one-writer backstop, and it recurred for a nameable reason: the September 6 instance was MOVED to `_to_delete/` and no ignore line was ever added.** *A breach closed by relocating the evidence is a breach that reopens.* **(2) `{src/`** — a brace expansion that never expanded, empty but for `.DS_Store`, dated 2026-07-04 (GIT-CFG's "stray trees"). **(3) `session-log-archives/`** in the code repo, holding one `Session_Log_Archive_2026-07-03.md` from before the Cowork split, its name now colliding with the live directory in `Minotaur-Cowork`.

⚠ **AND THE MEASUREMENT THAT EXPLAINS A RECURRING LOSS: `Minotaur-Cowork/.gitignore` IS TWO LINES — `.DS_Store` and `handoffs/`.** The whole handoffs directory, both directions. **That is why to-cc files named explicitly in a `git add` are silently not committed** — git prints *"The following paths are ignored"* and moves on — **and why every CC return survives only as a carry-out draft.** Registered as **REPO-STRAY-UNTRACKED**.

### 11 · Retired to the Ledger this append

**FENCE-FORMS** (built, never committed on its own — §2) and **FENCE-RULINGS** (`31b4c26` — §3) leave the Docket. **The retirement index moves 26 → 28**, which is the first time it has actually moved since v4.23.

### 12 · Registered this append

**AUTH-RESETPAGE** (ACTIVE — gates public beta on its own) · **FROZENCHECK-FAILOPEN** (ACTIVE) · **HARNESS-SIGNOUT** (ACTIVE) · **VERHIST-LIBDEDUP** (ACTIVE — VERHIST's opening move) · **UNATTENDED-MEASURE** (HELD — three measurements before any build) · **SEDRULE-REMAINDER** (STANDING to Sprint 4 close, Daniel's) · **DOCKET-STALEACTIVE** (ACTIVE, §10) · **REPO-STRAY-UNTRACKED** (ACTIVE, §10).

⚠ **SEDRULE-REMAINDER IS DANIEL'S ALONE AND IT NOW CARRIES A CONSEQUENCE IT DID NOT BEFORE.** `perl -i`, `gawk -i inplace` and `ruby -i` on an ordinary repo file have **no control at all** under the auto-mode rider — only the Sed Disclosure Rule, which is an obligation on the writer rather than a guard. **Pinned as measured OPEN battery cases 15 / 16 / 136 / 137 so it cannot quietly stop being true.** **While the rider stands, three binaries can edit any file in the repo with no guard whatsoever — an argument for letting it EXPIRE on schedule rather than extending it, and the decision is his.**

### 13 · Consciously left, a FIFTH time

**FENCE-HEREDOC.** `cp`, `mv`, `python3` and `node` writes remain unmatched by the fence, and **three of the five reach a frozen file.** Not opened inside another unit, deliberately — but it is now the oldest unclosed guard gap on the list and the battery that would prove it already exists.

---

*End of the September 10, 2026 eleventh append. HEAD **`31b4c26`**, pushed — `.git/refs/heads/main` and `.git/refs/remotes/origin/main` read identical, re-measured at the following open. `Minotaur-Cowork` at **`2839a73`**, pushed, origin identical. **Migration ledger 57 — live-read and byte-matched, UNCHANGED for TEN consecutive units.** Suite **2980 / 157**, zero skipped. Frozen **3/3 vs `be0769de`**. Typecheck 0, dependency clean, build clean. **Fence battery 147 cases · 126 pass · 0 fail · 21 open.** `CLAUDE.md` **115,579 characters of 150,000** (`wc -m`; the `wc -c` byte count is 116,795 and reads as larger — the limit is CHARACTERS). Session Log **3 entries, rollover clear, fires at 10**. Roadmap installed as **v4.26, retiring v4.25**. ⚠ **Next: VERHIST's library-dedup design pass, then AUTH-RESETPAGE, which gates public beta on its own.***
