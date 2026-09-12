# PROPOSAL — the fence's real coverage, and the push clause that is twelve days stale

*Written 2026-09-12 by the META parallel (Cowork-Arch). Covers members 1 (FENCE-HEREDOC), 2 (WF1A-PHRASE), 3 (SEDRULE-REMAINDER — laid out, NOT decided), 4 (CCSED-260911). Proposal only; the main line installs. Every claim about what a matcher blocks was produced by running a case through `bash-fence.sh`, never by reading it.*

---

## Plain English, first

Three things were measured and all three are worse than the rows say.

1. **The fence guards shell write vectors and nothing else.** It blocks `sed -i`, redirects, `tee`, `git add -A`, `commit -a`. It blocks not one interpreter. `python3`, `node`, `perl`, `ruby`, `gawk`, `ex` and `patch` can each write any repo file today, and the fence returns exit 0. FENCE-HEREDOC is not a heredoc hole — the heredoc is incidental. `python3 -c "open('src/app/page.tsx','w')"` passes exactly as cleanly as the heredoc form does.

2. **The approval phrase is checked by nothing.** `COMMIT APPROVED` appears 4 times in `CLAUDE.md` and **0 times** in `bash-fence.sh`, `commit-msg` and `settings.json`. `git commit -m '…'` passes the fence with no phrase present anywhere. WF1A-PHRASE's lesson is right, and it is now measured rather than argued: the phrase is a mechanism enforced only by CC's judgement.

3. **The Architecture Prompt is wrong about the push, and it is the document this seat reads first.** `Architecture_Prompt_v35.md` (installed 2026-09-11) says *"The push half is INERT until FENCE-PUSH lands"* and *"`git push` is denied in TWO places — `.claude/settings.json` (`Bash(git push *)`)"*. Neither is true at HEAD. FENCE-PUSH landed **2026-08-30**. `CLAUDE.md` records it correctly in three separate places, and the Roadmap's RETIRED index lists FENCE-PUSH as closed at `9a333cc`/`0bf6df3`. Only the Architecture Prompt still says otherwise — twelve days after the ruling, and one day after its own rewrite.

**What it costs:** a seat that believes the push is inert will approve a commit believing it is not a release. It is a release — Vercel builds every push to `main`. This is the single item in the META batch that can cause a bad afternoon, and it is a one-paragraph fix.

---

## The battery — every verdict below was produced by a run

Harness: the command string is passed to `.claude/hooks/bash-fence.sh` on stdin as `{"tool_name":"Bash","tool_input":{"command":…}}`, cwd = the code repo root, exactly as a PreToolUse hook receives it. Exit 2 = BLOCKED, exit 0 = ALLOWED. The fence only inspects the string; nothing was executed and nothing was written. Controls run first, so a negative result cannot be a broken harness.

### Controls — the harness can produce a block

| Case | Command | Verdict |
|---|---|---|
| C1 | `sed -i '' 's/a/b/' src/app/page.tsx` | **BLOCKED** |
| C2 | `git add -A` | **BLOCKED** |
| C3 | `echo hello > src/app/page.tsx` | **BLOCKED** |
| C4 | `git push --force` | **BLOCKED** |

### FENCE-HEREDOC — and it is wider than its name

| Case | Command | Verdict |
|---|---|---|
| H1 | `python3 - <<'EOF'` … `open('src/app/page.tsx','w').write('x')` … `EOF` | **ALLOWED** |
| H2 | `cat > src/app/page.tsx <<'EOF'` … `EOF` | BLOCKED — it is the *redirect* that is caught, not the heredoc |
| H3 | `node - <<'EOF'` … `require('fs').writeFileSync('src/app/page.tsx','x')` … `EOF` | **ALLOWED** |
| H4 | `python3 -c "open('src/app/page.tsx','w').write('x')"` | **ALLOWED** |
| H5 | `node -e "require('fs').writeFileSync('src/app/page.tsx','x')"` | **ALLOWED** |

H4 and H5 matter more than H1 and H3: **the hole is the interpreter, not the heredoc.** A matcher written against `<<` would close two of these five and leave three open.

### SEDRULE-REMAINDER — six of six alternate in-place editors pass

| Case | Command | Verdict |
|---|---|---|
| S1 | `perl -i -pe 's/a/b/' src/app/page.tsx` | **ALLOWED** |
| S2 | `perl -i.bak -pe 's/a/b/' src/app/page.tsx` | **ALLOWED** |
| S3 | `gawk -i inplace '{print}' src/app/page.tsx` | **ALLOWED** |
| S4 | `ruby -i -pe 'gsub(/a/,"b")' src/app/page.tsx` | **ALLOWED** |
| S5 | `ex -sc '%s/a/b/\|x' src/app/page.tsx` | **ALLOWED** |
| S6 | `patch src/app/page.tsx < /tmp/p.diff` | **ALLOWED** |

⚠ **`ex` and `patch` are not named in the row.** The row names perl, gawk and ruby. Two further vectors exist, and `patch` is the one a future pass is most likely to reach for innocently.

### The phrase

| Case | Command | Verdict |
|---|---|---|
| W1 | `git commit -m 'feat: something'` | **ALLOWED** — no phrase required by any matcher |
| W2 | `git add src/app/page.tsx` | ALLOWED — correct, explicit filename |
| W3 | `git commit -am 'feat: something'` | BLOCKED |

### The push

| Case | Command | Fence | `settings.json` |
|---|---|---|---|
| P1 | `git push` | **ALLOWED** | `allow: "Bash(git push)"` |
| P2 | `git push origin main` | **ALLOWED** | NOT allow-listed — bare form only |
| C4 | `git push --force` | BLOCKED | `deny: "Bash(git push --force*)"` |

The fence's own refusal text for C4 names the ruling: *"A bare 'git push' is permitted under WF-1a (FENCE-PUSH, 2026-08-30)."* **The guard states the fact the Architecture Prompt denies.**

### Two controls that were NOT found broken — recorded so nobody re-derives them

- **`core.hooksPath = .claude/hooks`** is set in `.git/config`, so `commit-msg` IS wired into git even though `.git/hooks/` holds nothing but samples. ⚠ *This seat was one sentence from filing "the commit-msg hook is not installed" as a finding. Running the check instead of reasoning from the directory listing is what caught it.*
- **`commit-msg` catches `Co-Authored-By`** (case-insensitively, exit 1, verified in both casings). ⚠ **It does NOT catch `🤖 Generated with Claude Code`** — a message carrying that line committed clean at exit 0. One hole, one line to fix.

### The mechanism CCSED-260911 rests on, confirmed

`settings.json` wires `frozen-check.sh` as `PostToolUse` with matcher `Edit|Write|MultiEdit`. A bash write is not an Edit, so it bypasses the frozen check **by construction**, not by accident. The rule's reason is sound; only its enforcement is absent.

### The allow lists, which are the other half of the story

`.claude/settings.local.json` — **184 allow entries, no hooks, zero deny entries.** Among them:

- `Bash(node *)` · `Bash(python3 *)` · `Bash(python3 -c ' *)` · `Bash(node -e ' *)` · `Bash(curl *)`
- and an entry permitting an in-place perl edit of a named source file outright: `Bash(perl -pi -e "…" src/components/equipment/EquipmentListClient.tsx)`

So the two halves meet: **the fence has no matcher for the interpreters, and the local allow list removes the prompt for them.** That combination is live in interactive mode today. It is not a property of the auto-mode rider — the rider widens it; it did not create it.

---

## Proposals

### PROPOSAL 1 — Architecture Prompt, §Commit authority: replace the FENCE-PUSH bullet

**Delete** the bullet beginning *"The push half is INERT until FENCE-PUSH lands."* **Insert** in its place:

> - **The push half is LIVE (FENCE-PUSH, 2026-08-30, Daniel's ruling).** Both enforcement layers were **narrowed, not removed**: `.claude/settings.json` allows `Bash(git push)` — the bare form only, no wildcard — and denies `--force`/`-f`/`--delete`/`--mirror`; `bash-fence.sh` blocks the same destructive family, permits the bare form, and names this ruling in its own refusal text. **Re-measured 2026-09-12 by running both forms through the fence.** ⚠ **A WF-1a commit is therefore a production DEPLOY** — Vercel builds every push to `main` — so the browser gate preceding the phrase is the last check before live, and the pre-open production check is load-bearing. `git push origin main` is NOT allow-listed; only the bare form is. A settings change is not in force until the CC session restarts. Lifting or re-tightening this is a Strat-tier ruling and must land in the Strat record as well as here.

**Propagation list for this correction** (searched, not remembered): `Architecture_Prompt_v35.md` is the only document carrying the stale claim. `CLAUDE.md` §Commit authority, `CLAUDE.md:1569` and the Roadmap's RETIRED index are already correct and need no edit. Openers still in play are in scope; none of the three current ones restates the inert-push claim.

### PROPOSAL 2 — close the interpreter hole, and close it by shape

The row's framing invites a matcher for `<<`. That closes H1 and H3 and leaves H4, H5 and every future spelling open. **Propose instead a matcher on the interpreter invocation, not on the redirection syntax:** `python3`/`python`/`node`/`ruby`/`perl` invoked with `-c`, `-e`, `-pe`, `-i`, a bare `-` stdin, or any heredoc, is blocked when the repo is the working directory, with the refusal naming the Edit tool.

Read-only interpreter use is what this over-blocks. ⚠ **That over-block is the correct failure direction and should be accepted rather than engineered around** — the fence cannot parse an interpreter's intent, and a guard that tries will be wrong in the permissive direction, which is the direction that has now produced two holes in three days.

**The battery is part of the unit, not follow-up.** H1, H3, H4, H5 and S1–S6 are the acceptance set, plus at least three read-only interpreter cases recorded as deliberately blocked or deliberately allowed. `scripts/fence-battery.mjs` exists and is where they belong.

### PROPOSAL 3 — WF1A-PHRASE: make the phrase a matcher, or stop calling it a mechanism

- **(a) A `pre-commit` hook under `core.hooksPath`** refusing unless a phrase file written by Daniel's paste matches the drafted subject. Real enforcement — and it needs a channel for the phrase that a hook can read, which does not exist today.
- **(b) Accept that the phrase is a discipline, not a guard**, and say so in both prompts, removing the word *mechanism* so no future seat relies on enforcement that is not there.

**Position: (b) now; (a) only if the sunset review keeps WF-1a.** (a) builds a new channel to protect a pilot that may not survive Sprint 4 close, and the measured failure — `OMMIT APPROVED:` accepted and flagged — is CC's judgement working. Fixing the wording costs a sentence; building the guard costs a unit.

### PROPOSAL 4 — `commit-msg`: one more pattern

Add the attribution line to the no-trailer check. Measured: `Co-Authored-By` caught, `🤖 Generated with Claude Code` not. One line; rides any unit touching that directory.

---

## SEDRULE-REMAINDER — laid out, NOT decided

⚠ **Daniel's alone. This section decides nothing.** What the measurement adds to the row:

- The vector list is **six, not three**: perl, gawk, ruby, **ex**, **patch**, plus the interpreters (`node -e`, `python3 -c`), which are the same hole under another name.
- It is **not gated on the rider.** `Bash(node *)`, `Bash(python3 *)` and a literal `perl -pi` entry sit in `settings.local.json` today, so the prompt is already gone in ordinary interactive runs.
- So the question is not *"extend the rider or not."* It is *"does anything at all guard a repo write other than CC's compliance."* Today, for six vectors: nothing does.

**Options, in cost order:**

1. Let the rider expire and accept prompts on `node`/`python3`/`curl`.
2. **Prune `settings.local.json`'s 184 entries** — the only action that helps whether or not the rider expires.
3. Build PROPOSAL 2's matcher, which makes the surviving allow entries harmless wherever it has coverage.

⚠ **2 and 3 are independent of the rider decision and need no ruling to proceed.** That is the only thing this seat asks to have on the record before Sprint 4 close.
