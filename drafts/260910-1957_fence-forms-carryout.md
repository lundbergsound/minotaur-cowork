# FENCE-FORMS — carried out of the gitignored return

*Source: `handoffs/from-cc/260910-1519_fence-forms.md` (gitignored — this draft is the
durable copy). Carried 2026-09-10 19:57 UTC by a Cowork chat. **Read at source, not
summarised from memory.** Nothing was installed, committed or run by this chat.*

---

## 1 · THE RESULT, IN ONE LINE

CC built a **114-case battery** that feeds destructive command spellings to
`.claude/hooks/bash-fence.sh` as **data on stdin** — so every one is judged without any of
them being run — and the installed fence is **wrong on 17 of them, in both directions:
8 false negatives and 9 false positives.** A candidate hook scores **93 pass / 0 fail** on
the same 114. **Both files are new and untracked; the installed hook is byte-untouched.**

| hook | cases | pass | fail | open |
|---|---|---|---|---|
| `bash-fence.sh` (installed) | 114 | 76 | **17** | 21 |
| `bash-fence.candidate.sh` | 114 | 93 | **0** | 21 |

⚠ **None of the 21 OPEN cases changed verdict between the two hooks.** That is the proof
the candidate repairs defects without silently closing a gap that is awaiting a ruling.

## 2 · ⚠ THE FINDING THAT IS THE UNIT'S OWN THESIS

**`sed --in-place` was never reachable by the guard, and reading the regex says the
opposite.** The matcher `-[a-zA-Z]*i` appears to match `--in-place` (`-` + nothing + `i`),
but the optional prefix group in front of it must end in whitespace, so the `-` it requires
is always token-initial — and `--in-place`'s token-initial `-` is followed by another `-`.

⚠ **CC's own first draft of the return recorded this case as a PASS, from reading. The
battery said ALLOW.** *An instrument that is read rather than run reports the reader's
belief.* Sixth occurrence of the shape the opener names in §4.

**The four mechanisms, each fixed once:** the in-place flag matcher required letters and a
token-initial dash (so `perl -0pi` and `sed --in-place` walked past, and the binary list
named three programs where the rule names a class, freeing `awk -i` and `ruby -i`) · three
guards asked two unrelated questions of the WHOLE command line, so `ls -d src; git push`
blocked on a `-d` belonging to the other command · a quoted `>` was read as a redirect,
which is the recorded false positive and also hits `grep -rn "loader -> src/components"` ·
`tee` takes many targets and only the first was ever read.

## 3 · ⚠ FOUR THINGS OWED AT DANIEL'S DESK, SMALLEST FIRST

**(a) Install the candidate — three commands, his by the FENCE-PUSH precedent** (CC does
not edit its own permission surface):

```
cp .claude/hooks/bash-fence.candidate.sh .claude/hooks/bash-fence.sh
chmod +x .claude/hooks/bash-fence.sh
node scripts/fence-battery.mjs .claude/hooks/bash-fence.sh
```

Third line must print `pass 93 · fail 0` and exit 0. **No `settings.json` edit is needed.**
⚠ **The chmod is not optional** — the candidate is `-rw-r--r--` as written, measured.
⚠ **Whether a running session re-reads a changed hook BODY without a restart was NOT
tested.** Restart, then re-run the battery; the battery answers it.

**(b) ⚠ THE §2 RULING — and it is larger than it looks.** An in-place stream edit of an
**ordinary** repo file is ALLOWED and no other matcher catches it (cases 14/15/16, three
binaries, three exit 0s, unchanged by the candidate per instruction). Two facts read at
source:

- ⚠ **`.claude/settings.json:14` carries `"Bash(sed *)"` in `allow`.** A `sed -i` against an
  ordinary repo file is not merely unfenced — it is **PRE-APPROVED**: no prompt, no hook,
  nothing. `perl`, `gawk` and `ruby` are absent from the allow list and would still prompt
  in default mode. **The three binaries are not equivalent in practice, and the one the Sed
  Disclosure Rule is named after is the unfenced one.**
- ⚠ **Under the auto-mode rider (CLAUDE.md, expires at Sprint 4 close) the prompt layer is
  not a control at all**, which leaves the fence as the only control for every form here.

**The policy forbids what the guard permits. Which of the two is wrong is Daniel's.**
Three shapes: **(a)** the fence blocks in-place edits of ANY repo file and the Sed
Disclosure Rule becomes a rule about the Edit tool · **(b)** the fence stays as built and
the disclosure ledger remains the only control on ordinary files · **(c)** the fence blocks
the pre-approved binary (`sed`) and leaves the prompt to handle the rest.

**(c) §D — three bulk-staging spellings the ruled list does not name.** `git add -u` (75),
`git add :/` (76), `git add ./` (77) all ALLOW on both hooks and each stages in bulk in
effect. **Blocking them is a two-token change to the same matcher.** Wants a ruling.

**(d) §J — does the battery join the standing suite?** It is at `scripts/fence-battery.mjs`,
run by hand. **CC deliberately wrote no `.test.ts` wrapper: a test asserting today's
behaviour would enshrine 17 defects, and one asserting the ruled behaviour fails until the
candidate is installed.** Once installed, a three-line wrapper puts all 114 cases in the
suite permanently. **Decide at install time.**

## 4 · Logged, not owed — the open cases that want their own units

- **§C FENCE-HEREDOC stays open, deliberately.** `cp /tmp/x src/app/globals.css`,
  `mv`, `python3 -c`, `python3 <<EOF`, `node -e writeFileSync` — all ALLOW on both hooks.
  ⚠ **Three of the five write a FROZEN-layer file**, reaching it by a mechanism the
  in-place guard does not model; case 24 is the shape that actually happened at
  CAT-NOTE-RULE. Blocking `cp`/`mv`/`python3`/`node` broadly is **a widening of the fence's
  remit, not a defect repair** — its own unit.
- **§E — a quoted flag is still a flag to git.** `git commit "-a" -m "x"` and
  `bash -c "git add -A"` both ALLOW. Closing this needs a shell-aware parse, not another
  regex; the same quote-stripping that makes `git commit -m "…2-IMP-a…"` work is what
  erases these. **Flagged as a known evasion, not a fix.**
- **§F — the read-only-head anchor.** `/bin/cat f > src/x.ts`, `VAR=1 cat f > src/x.ts` and
  a bare `> src/x.ts` all ALLOW: each hides the head the redirect guard anchors on.
  ⚠ **In default mode these would still prompt. Under the auto-mode rider they would not.**
- **§G** — `find . -name "*.log" | xargs rm` (the exec vector the family does not name) and
  `sort f -o src/x.ts` (a write flag, not a redirect). Both ALLOW on both hooks.
- **§H — two over-blocks the candidate KEEPS on purpose**, both only when a frozen file is
  named somewhere on the line: `perl -Mstrict` (an `i` inside "Mstrict") and a frozen file
  MENTIONED by a second command. **Conservative direction on the frozen layer; say so if
  you want them scoped like the others.**
- **§I — the incidental catch that survived.** `awk '{print $1 > "src/x.ts"}'` is blocked
  by the installed hook **by luck**; the two-pass scrub would have retired that catch
  silently, so the candidate carries an explicit awk rule to keep it. ⚠ **The one place the
  fix could have quietly cost something, and the battery is what caught that.**

## 5 · ⚠ THE BATTERY HAS ITS OWN DELETION CONTROL — and it is the right lesson

`node scripts/fence-battery.mjs --self-test` runs the case list against two control hooks,
one that blocks nothing and one that blocks everything: **46 of 46 BLOCK cases fail against
the permissive hook, 47 of 47 ALLOW cases fail against the deny-all hook.** SCAN-NONZERO /
SCAN-COMMENTS applied to the instrument itself. **A battery that reported agreement because
it could not see its subject would have been the third instance of that class this month.**

Related: **the daily-driver group (105–114)** puts the suite, the build, the frozen gate,
the teed visual gate and `git status --short` into the battery as first-class ALLOW cases,
**because a fence that taxes the ordinary run is the false-positive direction this unit
exists for.** All ten pass on both hooks.

## 6 · Two inbound claims that did not survive checking

- **"it is `-rwx------` now"** — measured, `bash-fence.sh` is `-rwxr-xr-x`. The chmod
  instruction is still right; the mode quoted is not that file's mode. (`commit-msg` is the
  odd one: `-rwx--x--x`.)
- **`node -e 'x.map(m => m[1])'` "must ALLOW"** — the BARE form already allows (case 48).
  The recorded false positive needs a read-only head in the composition to arm the guard:
  `cat f | node -e '… => m[1]'` (case 47). **Both are in the battery so the distinction is
  pinned rather than remembered.**

## 7 · State at CC's close, and one correction it carries

Read from CC's raw output at `dce1b72`, **not re-measured by this chat**: suite **2978 /
156**, zero skipped · typecheck 0 · frozen **3/3** vs `be0769de` · build clean · dependency
gate clean · guarded-code grep clean · **migration ledger 57, unchanged** · Vercel LATEST
`dce1b72` READY.

⚠ **FENCE-COUNTS: the fence's own suite counts are two units stale** — it says 2926/153,
which was leg 3a's number before HARNESS-SETTLE and DARKMODE-PASS landed. **2978/156 is
both the before and the after for this unit**, which adds no test files.

⚠ **The visual gate was NOT run, and that is correct for this unit** — two new files, a
Node script and an uninstalled shell hook, neither reachable from any route. **CC recorded
this rather than leaving it inferred. It does not generalise.**

## 8 · The commit block is INERT until §3(a) and §3(d) are settled

WHAT gets committed depends on the install: **if the candidate is installed first, the
second path becomes `.claude/hooks/bash-fence.sh` and the candidate file is deleted rather
than committed.** CC's block, unchanged, stages `scripts/fence-battery.mjs` and
`.claude/hooks/bash-fence.candidate.sh`, expects exactly 2 lines each beginning `A `, then
commits and pushes.
