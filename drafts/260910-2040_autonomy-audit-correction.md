# CORRECTION to `drafts/260910-2035_autonomy-readiness_findings.md` — finding 3 is FALSE

*Written 2026-09-10 20:40 UTC from a Cowork seat with read access to both repos. **The
correction is measured at source, not reasoned.** Findings 1, 2 and 4 of that file are NOT
disputed here and are separately confirmed or left standing where noted.*

---

## ⚠ FINDING 3 IS WRONG: `commit-msg` IS WIRED. THE NO-TRAILER BACKSTOP IS IN FORCE.

The findings file states that `.git/config` has **no** `core.hooksPath` and that
`.git/hooks/` holds no non-sample files, concluding that `.claude/hooks/commit-msg` never
runs and that Daniel must wire it by hand.

**`/Users/Daniel/Developer/Minotaur/.git/config`, read verbatim:**

```
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
	ignorecase = true
	precomposeunicode = true
	hooksPath = .claude/hooks
[remote "origin"]
	url = https://github.com/lundbergsound/minotaur-v2.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "main"]
	remote = origin
	merge = refs/heads/main
```

**`core.hooksPath = .claude/hooks` is present.** `.claude/hooks/commit-msg` is therefore the
repository's `commit-msg` hook, and CLAUDE.md's claim that the no-trailer rule is
hook-enforced stands.

⚠ **The second half of the observation is correct and is what misled it: `.git/hooks/` holds
only `.sample` files** — verified, fourteen of them, nothing else. **That is the EXPECTED
state once `hooksPath` is redirected.** Git stops consulting `.git/hooks` entirely; an empty
default directory is the signature of a working redirect, not of a missing one.

**Nothing is owed. Daniel is NOT to run `git config core.hooksPath`** — it is already set,
and O-1's prohibition on running git in the repo folder was never the obstacle it was
described as.

## ⚠ THE LESSON, WHICH IS WORTH MORE THAN THE CORRECTION

**An audit inferred a config value from a directory listing, and the inference produced a
confident FALSE NEGATIVE about a safety control.** *Absence of the hook files is not absence
of the hook.* Had it been acted on, the record would carry "the no-trailer backstop is
inert" — a claim that would have justified either a redundant fix or, worse, a decision made
on the belief that a control was missing.

This is **SCAN-NONZERO's family in a new costume**: an instrument that could not see the
object it existed to test for, returning absence as if it were refutation. The project's own
standing rule already names the fix — **read the source that decides, not a directory that
reflects it.** `.git/config` is four lines away and settles it.

## The other three, briefly — not disputed, and two independently confirmed

- **Finding 1 (the 184-rule `settings.local.json`) — CONFIRMED, and one detail sharpens it.**
  Measured: **184 allow rules, ZERO ask, ZERO deny, no `hooks` key** — the file is purely
  additive permission, accreted from months of "always allow". `Bash(rm *)`, `Bash(node *)`,
  `Bash(python3 *)`, `Bash(curl *)` and `Bash(claude *)` are all present as written.
  ⚠ **One correction to its framing: several `Bash(git -C …)` rules are in that allow list,
  but `settings.json`'s deny carries `Bash(git -C *)`, and deny wins** — so those specific
  entries are already dead. The finding's substance is unaffected; the count of live rules is
  lower than 184.
- **Finding 2 (no Stop hook) — CONFIRMED.** `settings.json` declares `PreToolUse` (Bash →
  `bash-fence.sh`) and `PostToolUse` (Edit|Write|MultiEdit → `frozen-check.sh`) and nothing
  else. `settings.local.json` declares no hooks at all.
- **Finding 4 (the installed fence's stale "CANDIDATE — NOT INSTALLED" header) — NOT
  independently verified here, accepted as plausible, and folded into FENCE-RULINGS
  AMEND-1 §4a** with an instruction to verify at source before editing.

⚠ **None of finding 1's remedy is taken here.** A separate `--bare` settings file for
unattended runs is a NEW PERMISSION SURFACE and is Daniel's ruling under the FENCE-PUSH
precedent — and the findings file is right that `--bare`'s existence on the installed build,
and `frozen-check.sh`'s behaviour under it, are both unmeasured. **Measure before scoping.**
