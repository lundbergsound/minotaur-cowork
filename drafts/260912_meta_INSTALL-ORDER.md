# INSTALL ORDER — META parallel, for the main line's close

*Written 2026-09-12 by the META parallel (Cowork-Arch), as the last artifact of that pass. ⚠ **This is a proposal to the main line, not a CC handoff** — the parallel issues none. Where an item is CC-shaped, this sheet says so and the main line writes that handoff itself. Read with `260912_meta_RETURN.md`; every measurement cited is there.*

**Daniel's ruling, 2026-09-12: he is not hand-editing these.** So each item below names who does the editing — Arch at the close, CC in a unit, or Daniel's keypress on a permission prompt. **Nothing here asks him to open a document.**

---

## TIER 1 — this close, Arch's own edit, ~15 minutes

Both are text in documents Arch already rewrites at every close. No unit, no handoff, no dependency.

| # | Edit | File | Source |
|---|---|---|---|
| 1 | Replace the FENCE-PUSH bullet — the push half is LIVE, a WF-1a commit is a deploy | `Architecture_Prompt_v35.md` → v36 | FENCE-AND-PUSH, Proposal 1 |
| 2 | Add step 0 (browser gate: named, result, time) to the COMMIT BLOCK template; replace the gate-first rule beneath it | `CLAUDE.md` | GATE-REPORTING, Proposal 1 |
| 3 | Add the browser-gate field to the `_CLOSE.txt` contract; name `_CLOSE.txt` under the carry-into-`drafts/` rule | `CLAUDE.md` | GATE-REPORTING, Proposal 2(b) |
| 4 | Restore the cap-and-count metadata line under the H1; fix the footer, which still reads "End of Roadmap v4.28" | Roadmap → v4.32 | DOCKET-ROWLENGTH, Proposals 2 and 3 |
| 5 | Four HELD → ACTIVE (AUTH-REFRESH-HANG · EXPRPT-STALE · FENCE-HEREDOC · WF1A-PHRASE), plus IMPRPT-COPY; re-point two FIELD-CONTRACT triggers at FIELDCONTRACT-3B; strike "ACTIVE" from two HELD row texts | Roadmap → v4.32 | HELD-AUDIT, Proposals 1, 4, 5 |
| 6 | Retire CLAUDE-HARNESS-STALE as discharged-by-measurement | Roadmap → v4.32 + Ledger | RETURN, item 9 |
| 7 | Move the three "unchanged from v4.6" grouped rows (20 IDs) to ICEBOX, with ICEBOX given its own release trigger | Roadmap → v4.32 | HELD-AUDIT, Proposal 2(b) |

⚠ **Item 1 carries a propagation obligation** (O-8): the stale claim was searched for, and `Architecture_Prompt_v35.md` is the only document holding it. `CLAUDE.md` and the Roadmap's RETIRED index are already correct. **It is also a Strat-tier fact** — the push permission rests on a Strat invariant — so the correction belongs in the Strat record too, or the two tiers disagree in writing.

⚠ **Item 5's four moves are the ones that cost something if skipped:** `AUTH-REFRESH-HANG` is in the next CC bundle per ⏭ NEXT while the Docket still calls it HELD. A CC session reading the Docket will not know it is in scope.

---

## TIER 2 — CC-shaped, rides the next unit that touches those directories

The main line writes these handoffs. Neither is standalone; both are small and both should be bundled, per the standing ruling on bundling small fixes.

| # | Unit | What it does | Prompts Daniel will see |
|---|---|---|---|
| 8 | **FENCE-INTERP** (rename of FENCE-HEREDOC) | Matcher on interpreter invocations — `python3`/`python`/`node`/`ruby`/`perl` with `-c`/`-e`/`-pe`/`-i`/bare `-`/heredoc — blocked against repo paths. Battery cases H1, H3, H4, H5, S1–S6 plus three read-only controls into `scripts/fence-battery.mjs` | None — `.claude/hooks/` and `scripts/` are Edit-allowed |
| 9 | **commit-msg pattern** | Add the `🤖 Generated with Claude Code` line to the no-trailer check. One line; rides item 8 | None |

⚠ **Item 8 needs the fence's execute bit checked after any write** (`chmod +x .claude/hooks/*`) — the file has lost it before, and a fence without it is silently offline. ⚠ **And a settings change is not in force until the CC session restarts**, which is the trap that makes a green battery meaningless in the session that wrote it.

---

## TIER 3 — the repo hygiene, and it is mostly CC's with a few keypresses

⚠ **This is the tier Daniel's ruling actually bites on, so it is priced honestly.** The commands in `260912_meta_REPO-HYGIENE_PROPOSAL.md` are written for a human paste. Most of them can go to CC instead, but not all, and here is exactly where the friction sits — **measured against the live allow lists and the fence, not assumed:**

| Action | Can CC do it? |
|---|---|
| Append the ignore lines | ⚠ **Not by `cat >>`** — the fence blocks redirects to repo files. By the Edit tool, yes — but `.gitignore` is not in the `Edit(...)` allow list, so **one permission prompt per file** |
| `rm -rf "Claude outputs" "{src"` | ⚠ **DENIED** — `Bash(rm -rf *)` is in the deny list, and deny beats every allow. Needs a non-recursive form, or Daniel |
| `git rm -r --cached session-log-archives` | Not allow-listed — **one permission prompt** |
| `git add .gitignore` · `git commit` · `git push` | Yes, on the confirm phrase — all three permitted |

**So the shape is: one CC handoff, three or four permission prompts, one confirm phrase.** That is four keypresses instead of four pasted blocks, and it is the honest floor — the deny on `rm -rf` is a control working correctly and should not be lifted for a tidy-up.

⚠ **Two things in this tier need a decision before the handoff, not during it:**

1. **The four files under `Claude outputs/`** are Arch output from 2026-09-06 and 2026-09-10. Their content is superseded (the autonomy pair by today's UNATTENDED-MEASURE measurements; the catnote pair shipped), so **this seat's position is: delete them.** But deletion is irreversible and the main line should state that position to Daniel in one line rather than have CC discover it.
2. **`supabase/migrations/20260707152921_equipment_library_model_unique.sql` matches no applied version.** Before its filename is fixed, someone confirms whether it was ever applied — a renamed copy of `20260707132157` and a migration never run want opposite treatment. **One query, and it belongs in the same handoff.**

---

## TIER 4 — after the private-beta invite. Do not schedule before it.

None of this blocks ≈Sept 18, and the priority ruling says so explicitly.

| # | Work | Cost | Sequencing constraint |
|---|---|---|---|
| 10 | **Docket prune** — 77 ACTIVE rows to one line each, under the 300-character rule | ~1 Arch session | ⚠ **Ledger append FIRST, always.** Five worked pairs are in the proposal as the pattern |
| 11 | **`Minotaur_v2_Standing_Facts.md`** created and read into the open order | ~half a session | ⚠ **Must exist before item 12** |
| 12 | **Session Log header** — 70,554 characters and 102 bullets triaged into item 11, then rewritten to the six mandated fields under 4,000 characters | ~1 session | ⚠ **After 11.** A header rewrite done first deletes standing rules |
| 13 | **Rollover sub-step** — standing facts lifted out of every entry before it is archived, and the archive names what was lifted | one paragraph | Rides item 11 |
| 14 | **One archive read** (`Session_Log_Archive_2026-09-10.md`, 92,839 characters) for buried standing facts | ~30 min | Decides whether the other five are worth opening |
| 15 | **The 22 triggerless IDs** given real triggers, and the BATCH table's "unchanged from v4.6" groups read in the same sitting | a Daniel-and-Arch sitting | After item 7's ICEBOX move makes the Docket legal in the meantime |
| 16 | **Migration backfill** — export the 57 unfiled migrations from the applied ledger | ~1 Arch pass | Row's own trigger: before any second environment |
| 17 | **Prune `settings.local.json`'s 184 allow entries** | ~1 hour | ⚠ **Highest-value hour in the batch, and independent of the rider decision** |

---

## Daniel's desk — what genuinely cannot be delegated

1. **SEDRULE-REMAINDER, at Sprint 4 close.** Whether the auto-mode rider expires. Six write vectors have no guard; items 8 and 17 improve the position whichever way he rules, and neither waits on him.
2. **The `Claude outputs/` delete** — one line of confirmation, per Tier 3 note 1.
3. **The four permission prompts and one confirm phrase** in Tier 3.

Everything else on this sheet is Arch's or CC's.

---

## The parallel is closed

Nothing further is owed by this seat. Eight files in `handoffs/parallel/` and mirrored in `drafts/`; the return and the FENCE-AND-PUSH proposal are also in claude.ai project knowledge. ⚠ **The one item this seat would not let slide to Tier 4 is item 1** — until it lands, the document Arch reads first at every open says CC cannot push, and it can.
