# QUEUED — `CLAUDE.md` amendments, to ride the FIRST handoff of the next session

**Written 2026-08-26 at the 2-IMP-b close. NOT applied.** `CLAUDE.md` is a repo
file and CC is its writer; one writer at a time. These fold into the next
handoff's §0 and are applied by CC, not by Arch.

**They are FORWARD-DATED and must be marked so in the handoff that carries
them:** they describe authority CC does not have until FENCE-PUSH lands. A
handoff citing a rule absent at HEAD says so in its body (Prompt Quality
Standards, Provenance O-4).

---

## 1 · WF-1a — the confirm phrase now covers the push

Wherever `CLAUDE.md` states that `git push` is human-only or Daniel's paste,
amend to: **the `COMMIT APPROVED: <first words>` phrase authorises stage →
verify → commit → push as ONE step.** Subject-binding is unchanged; a bare
approval still approves nothing; a green gate is still never consent.

**State the consequence inline, do not leave it inferable: a WF-1a commit is now
a production DEPLOY**, because Vercel builds on every push to `main`.

## 2 · The `_CLOSE.txt` artifact

After a successful push, CC writes
`handoffs/from-cc/YYMMDD-hhmm_<unit>_CLOSE.txt` — **plain text, not Markdown.**
Contents: unit · commit hash and `<before>..<after>` · file count · pushed state
read from the ref files, never from `git` · measured counts (suite, typecheck,
frozen, visual, dependency) · what closed · what stays open and who owns it ·
what is owed by Daniel. Written whether the unit ends clean or partial.
**Every number in it is a measurement or it is not written.**

## 3 · The enforcement change this depends on — FENCE-PUSH

Both layers must lift before 1 and 2 are satisfiable, and **CC restarts
afterwards because settings are read at session start**:

- `.claude/settings.json` — the deny entry `"Bash(git push *)"`.
- `.claude/hooks/bash-fence.sh` — the composition-aware matcher at the
  `git[[:space:]]+push` test, which exits 2 with *"git push is human-only
  (Strat invariant 1)."*

**The fence calls this a STRAT invariant.** Lifting it is a Strat-tier ruling
carried down, not an Arch decision — Daniel has ruled it and the Strat record
should say so too, or the tiers disagree in writing.

Also part of that unit, not follow-up:
- `chmod +x .claude/hooks/*` — hook files lose the execute bit when saved
  (July-24 incident of record: the fence ran dead and every PreToolUse ran
  unfenced).
- **A test battery against the new matcher.** Two holes have been found in this
  fence in three days — the `-av`/`-avm` false negative (FENCE-COMMITA) and
  FENCE-HEREDOC. **Test the guard; do not read it.** The battery must prove that
  bulk staging and `commit -a` are STILL blocked after the push rule is lifted.

---

## 4 · THE RUN FENCE IS STALE — ADDED 2026-08-26 19:5x, and it rides the same handoff

**CC flagged this itself in the first `_CLOSE.txt` under v32, correctly, as
Arch's call and not its own.** `CLAUDE.md`'s `## Current run fence` still reads
**"THIS UNIT IS PORT-COV LEG 2"** — a unit that closed at `e17fd97`, one commit
ago. PRINT-PARITY unit 1 closed at `8c6b2e0` after it.

**This is the "a stale document does not fail quietly — it gives orders"
hazard**, and the fence is the specific document the rule was written about
(FENCE-STALE, twice). Update in the same handoff as §1–§3:

- **HEAD** — self-locating per FENCE-HEADLINE; do not write a hash.
- **Counts** — re-measure at HEAD. At this writing the tree measured
  **2291 tests across 129 test files**, frozen 3/3, visual 28/28 run twice,
  ledger **55**. **Re-measure rather than copy those.**
- **Closed and pushed since this fence was last correct** — add
  **2-IMP-b `e17fd97`** and **PRINT-PARITY unit 1 `8c6b2e0`**.
- **THIS UNIT IS** — rewrite for whatever the next unit actually is.

**Interim risk, stated rather than left implicit:** between now and that
handoff, the fence names a closed unit. Any session that opens on it without
re-anchoring gets the wrong unit. The cable-parity parallel opener already
carries an explicit re-anchor instruction for exactly this reason; the next
main-line handoff must fix the fence itself rather than work around it.
