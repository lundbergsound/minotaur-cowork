# RETURN — META, the whole process and hygiene batch in one pass

*Written 2026-09-12 by the META parallel (Cowork-Arch), against the opener `260912_meta-parallel_OPENER.md`. Roadmap of record: `Minotaur_v2_Roadmap_v4_31.md`. **Proposals only — nothing was installed, nothing was committed, no CC handoff was issued, no governing document was edited.** Every number below is a measurement.*

---

## Read this part and nothing else, if that is all there is time for

**One item needs you today and the rest can wait for the beta to be out.**

⚠ **The Architecture Prompt says CC cannot push. CC can push, and has been able to since August 30.** `Architecture_Prompt_v35.md` — the document this seat reads first at every open — says *"the push half is INERT until FENCE-PUSH lands"* and *"`git push` is denied in TWO places."* Measured today by running both forms through the fence: a bare `git push` is **permitted** by the fence and **allow-listed** in `settings.json`. `CLAUDE.md` has this right in three places and the Roadmap's retired index has it right too. Only the Architecture Prompt is wrong, twelve days after the ruling and one day after its own rewrite.

**Why it matters to you rather than to the machinery:** when you type `COMMIT APPROVED:` you are approving a production deploy. Vercel builds every push to `main`. An Arch session reading v35 believes you are approving a commit, so it can offer to run your browser gate afterwards — and it did exactly that on `e3a336a`, where the phrase was typed at 23:05 and the gate ran at 23:29 and 23:38. Both defects that gate found were pre-existing, so nothing broke. The next one might not be.

**The fix is one paragraph in one document and it is written out ready to install** (`260912_meta_FENCE-AND-PUSH_PROPOSAL.md`, Proposal 1). It is the only thing in this batch this seat would put in front of a build job.

**Everything else divides into three piles:**

- **Twenty minutes at your desk, whenever:** the repo strays and ignore lines (commands written out, paste-ready). ⚠ **One correction: two of the three strays are untracked, but `session-log-archives/` is TRACKED, so an ignore line does nothing to it.** Under the row as written you would add three lines, the committed file would stay, and the row would be marked done.
- **A ruling you own and nobody else can make:** SEDRULE-REMAINDER, at Sprint 4 close. Measured, six write vectors have no guard at all — not three. Two of the fixes need no ruling from you and can proceed either way.
- **One Arch session after the invite:** the Docket prune, the HELD audit's sitting, and the Session Log's header. All real, none of it blocking ≈Sept 18.

**Three of the fifteen turned out not to be worth doing.** They are named at the bottom.

---

## The fifteen, each in four lines

### 1. FENCE-HEREDOC — the hole is the interpreter, not the heredoc

**Measured.** Eleven cases run through the fence. `python3 - <<'EOF'` writing a source file: **allowed**. `node - <<'EOF'`: **allowed**. And the two that matter more, because a matcher written for heredocs would miss them: `python3 -c "open('src/app/page.tsx','w')"` **allowed**, `node -e "fs.writeFileSync(…)"` **allowed**. The fence blocks shell write vectors — `sed -i`, redirects, `tee`, `git add -A` — and not one interpreter.
**Proposed.** A matcher on the interpreter invocation rather than on redirection syntax, accepting that it over-blocks read-only interpreter use, because that is the correct failure direction. Battery cases are part of the unit.
**Owns it.** Arch, in whichever unit next touches `.claude/hooks/`.
**Costs.** Small — one matcher, ten battery cases in the file that already exists. ⚠ **It does not block the beta and should not take a slot before it.**

### 2. WF1A-PHRASE — the phrase is checked by nothing

**Measured.** `COMMIT APPROVED` appears **4 times in `CLAUDE.md` and 0 times** in `bash-fence.sh`, `commit-msg` or `settings.json`. `git commit -m '…'` passes the fence with no phrase present.
**Proposed.** Stop calling it a mechanism. Build the guard only if the sunset review keeps WF-1a — it would need a new channel for the phrase, to protect a pilot that may not survive Sprint 4.
**Owns it.** Arch for the wording; you for the pilot's future.
**Costs.** One sentence in each prompt.

### 3. SEDRULE-REMAINDER — yours, and the count is six not three

**Measured, nothing decided.** `perl -i`, `perl -i.bak`, `gawk -i inplace`, `ruby -i` all pass — and so do **`ex -sc '%s/…/x'`** and **`patch file < diff`**, which the row does not name. Six of six. ⚠ **And it is not the rider that makes this live: `settings.local.json` carries 184 allow entries including `Bash(node *)`, `Bash(python3 *)`, `Bash(curl *)` and a literal `perl -pi` entry naming `EquipmentListClient.tsx`.** The prompt is already gone in ordinary interactive runs.
**Proposed.** Options laid out in cost order, no recommendation on the rider itself. ⚠ **Two of the three help whether the rider expires or not: prune the 184 entries, and build item 1's matcher.** Neither needs your ruling.
**Owns it.** You, at Sprint 4 close, for the rider. Arch for the two that do not wait on it.
**Costs.** The prune is an hour and it is the highest-value hour in this batch.

### 4. CCSED-260911 — evidence, and the mechanism is confirmed

**Measured.** `frozen-check.sh` is wired `PostToolUse` with matcher `Edit|Write|MultiEdit`. A bash write is not an Edit, so it bypasses the frozen check **by construction**. The rule's reason is exactly right; only its enforcement is missing, which is item 1.
**Proposed.** Nothing of its own. It is the evidence for items 1 and 3 and should stay a row until both are settled.
**Owns it.** Folds into the Sprint 4 close sitting, as written.
**Costs.** Nothing.

### 5. UNATTENDED-MEASURE — the candidate is struck, and the replacement is smaller

**Measured.** ⚠ **`--restricted` does not read `.claude/settings.json` at all** — proven by the disappearance of the warning that names that file (present once on a plain run, zero times under `--restricted`), plus the flag's own help text: *"ignores user, project and local settings files."* That file is the only place the fence is wired. **So `--restricted` removes the fence for a different reason than `--bare` did and arrives at the same place, and it should be struck beside it.** Measurement 2 is fully answered — the binary enumerates its own values: `user`, `project`, `local`, and `local` is excludable. Measurement 3 **cannot be answered as written**: "the four gate invocations" resolves to nothing, because three different gate sets are written down, of 3, 5 and 6 members.
**Proposed.** The surviving candidate is **`--setting-sources user,project`**, which was not the plan and is better than it: the fence lives in `settings.json` and all 184 accreted rules live in `settings.local.json`, so that one flag keeps the guard and drops the accretion. Cost: two allow entries, because the visual gate's `--gate` form and the Vercel pre-open check are currently permitted only by the blanket `Bash(node *)`.
**Owns it.** Arch. ⚠ **Still HELD — one measurement remains before anything is built** (do hooks declared in a `--settings` file register under `--restricted`).
**Costs.** Nothing yet, and that is the point: ⚠ **had this row been worked in the order it was written — design, build, measure — the unit intended to harden the fence would have switched it off.**

### 6. DOCKET-ROWLENGTH — the row's own numbers are stale and the truth is worse

**Measured.** The row says the Docket is 61% of the Roadmap and ▶ ACTIVE is 35%. Against v4.31: **Docket 97.2%, ▶ ACTIVE 48.2%.** 35% reproduces exactly at v4.27, before the restructure deleted 35,541 characters of history — the Docket barely moved, the denominator shrank. ⚠ **▶ ACTIVE has not lost one character since v4.30: 56,171 both times.** Mean ACTIVE row: 705 characters; longest 1,948. **And two hygiene defects found while measuring: v4.31 states no character cap and no character count** (v4.28, v4.29 and v4.30 each did), so the ratchet has nothing to ratchet — the cap went out with the 457 words of preamble; **and v4.31's footer still reads "End of Roadmap v4.28 … Retires v4.27."**
**Proposed.** The one-line rule with a counted bound (no row over 300 characters, ACTIVE ≤ 25,000, which takes the file to ~83,000 and lets the cap ratchet to 90,000). The cap restored as a metadata line under the H1 so a preamble deletion cannot take it again. The footer fixed, and a footer read-back added to the close checklist. **Five rows worked as demonstrations — each a one-line Docket row paired with the Ledger extract that must land first.**
**Owns it.** Arch, one session. ⚠ **Sequenced Ledger-append-first, always.**
**Costs.** About 12 minutes per row for the pairing, so ~one Arch session for all 77. ⚠ **This seat did NOT prune the other 72 rows, deliberately: their reasoning's destination is the Ledger, which a parallel may not write, so a prune here would delete reasoning before it had anywhere to land.**

### 7. GATE-REPORTING — the channel does not exist, and now that is measured

**Measured.** `Minotaur-Cowork/handoffs/` holds **0 tracked files of 225 index entries** — the whole directory, both directions, is gitignored. Every CC return and every gate result inside one lives on a single disk and vanishes on a fresh clone. `drafts/` by contrast holds **135** tracked files, so a durable channel exists; it is simply not where gate results go. The `_CLOSE.txt` contract already requires five machine gate counts and **has no field for your browser gate** — the machine gates are recorded, the human one is not.
**Proposed.** Add the browser gate to `_CLOSE.txt` as a required field on the same terms as the machine counts (result, time, or the explicit words `NOT RUN` with who deferred it), and carry `_CLOSE.txt` into `drafts/` under the standing rule that already covers every other download-only deliverable. No new directory, no new rule.
**Owns it.** Arch.
**Costs.** Two lines of contract. ⚠ **One encouraging measurement: at the 2026-09-11 close CC refused a commit phrase without a gate result, citing GATE-REPORTING by name. The row is already working through being written down, which argues for the small fix over a mechanism.**

### 8. GATE-BEFORE-COMMIT — the rule exists, in the wrong place

**Measured.** `CLAUDE.md`'s COMMIT BLOCK rules already say *"the block never weakens gate-first discipline: Daniel runs it only after his browser gates pass,"* and §Commit authority already says the browser gate *"is the last check before live."* ⚠ **But the block's numbered sequence starts at step 1, `git add`.** The gate is a rule beneath the thing that gets pasted, not a step inside it.
**Proposed.** A **step 0** in the COMMIT BLOCK: the gate named, run, passed, with the time — your line quoted. Empty means CC stops and says so. Plus one clause in the Architecture Prompt: **Arch never offers to defer a browser gate to after the commit**, because the commit is a deploy.
**Owns it.** Arch.
**Costs.** One template change. It is the cheapest item in the batch and pairs with item 7.

### 9. CLAUDE-HARNESS-STALE — ⚠ **already fixed. Retire the row.**

**Measured.** The row says `CLAUDE.md` still describes SUBPIXEL-WANDER site 4 as `provisional: true` with a `refineBy`. It does not. `CLAUDE.md:1262` correctly says **site 3** is still provisional — which is true, site 3 *is* provisional in the live file — and `docs/reference/visual-capture-harness.md:212-215` correctly records GATE-NEST-UPGRADE dropping both the flag and the `refineBy` from site 4. **No text anywhere in the repo describes site 4 as provisional.** The defect was repaired when the harness section was relocated on 2026-09-08.
**Proposed.** Retire the row to the Ledger as discharged-by-measurement, no code change.
**Owns it.** Arch, at the next close.
**Costs.** Nothing. It is one of the three that was not worth doing.

### 10. REPO-STRAY-UNTRACKED — right about two, wrong about the third

**Measured.** By parsing `.git/index` directly (1,295 entries, no git command run): `Claude outputs/` **untracked** ✓ · `{src/` **untracked** ✓ · ⚠ **`session-log-archives/` TRACKED** — one committed file, so it does not show in `git status` and an ignore line does nothing to it. `Claude outputs/` is back with four files, two written **2026-09-10 at 20:31 and 20:38** during a live CC session, exactly as recorded. The code repo's `.gitignore` is 25 lines and names none of the three. `Minotaur-Cowork/.gitignore` is **two lines** — `.DS_Store` and `handoffs/` — confirmed. ⚠ **And a fourth stray the row does not name: `_to_delete/` in the Cowork repo is untracked and unignored too.**
**Proposed.** Paste-ready command blocks: two ignore lines, one `git rm -r --cached` for the tracked one, three ignore lines for the Cowork repo, and the commit. ⚠ **With a warning: check the four files under `Claude outputs/` before deleting them** — two are the 2026-09-10 autonomy-audit pair, superseded by today's measurements but check anyway.
**Owns it.** You, twenty minutes.
**Costs.** Twenty minutes. ⚠ **Correct the row too, or the tracked one survives the fix.**

### 11. REPO-MIGRATIONS-ABSENT — worse than 2 against 59

**Measured.** Applied migrations, live-read: **59**, first 2026-05-21, last 2026-09-11. Files in `supabase/migrations/`: **2**, both tracked, latest 2026-07-11. Both counts reproduce the row exactly. ⚠ **What the row does not say: neither file reconciles against the ledger.** `20260707152921_equipment_library_model_unique.sql` **matches no applied version at all** — that day's applied entry is `20260707132157`. The other carries a date where a version timestamp belongs (`20260711_…` against applied `20260711162133`), so `supabase db push` would replay it as unknown. **Effectively zero of the 59 are reconcilable from the code repo.** And the `drafts/` fallback is thinner than implied: **5 `.sql` files** in `Minotaur-Cowork`, covering at most 5 of the 57 unfiled.
**Proposed.** The standing convention (every applied migration lands as a file in the session it is applied, version string exactly as the ledger records it, apply incomplete until committed), plus the close-checklist addition that byte-matches the live ledger against the files and not only against the opener. Backfill: fix the two existing filenames now — five minutes — and export the 57 in one Arch pass behind the beta.
**Owns it.** Arch.
**Costs.** Five minutes now, one pass later. ⚠ **One pre-condition on the five-minute fix: confirm whether `20260707152921` was ever applied.** It matches no version, so it is either a renamed copy or a migration written and never run, and those want opposite treatment.

### 12. HELD-IS-NOT-FORGOTTEN — audited in full, and it fails the rule 15 ways

**Measured.** 41 HELD rows: **23 legal · 8 vague · 5 carrying no trigger at all · 4 whose trigger has already fired · 1 dangling.** ⚠ **The five triggerless rows cover 22 IDs, because three of them bundle 9, 3 and 8 under a trigger column reading only "unchanged from v4.6"** — a provenance note, five weeks and twenty-five Roadmap versions old. A fourth group of the same shape carries 11 more in the BATCH table, for 31 in total. **The four already fired:** `AUTH-REFRESH-HANG` and `EXPRPT-STALE` are `BATCH-PREBETA` members, which ⏭ NEXT bundles into the next CC unit; `FENCE-HEREDOC` and `WF1A-PHRASE` are named META members, measured today. ⚠ **And the dangling one is the failure the rule exists to catch: `CHANGEALL-METHODDOCTRINE` is held "With FIELD-CONTRACT", and FIELD-CONTRACT was retired at v4.30** — one version earlier, with its successor named in the retirement's own line. `AUTOCOMPLETE-NOPORTAL` in ▶ ACTIVE has the same broken trigger. Two rows (`FROZENCHECK-FAILOPEN`, `HARNESS-SIGNOUT`) open *"⚠ NEW, ACTIVE"* while sitting under ⏸ HELD.
**Proposed.** Four moves to ▶ ACTIVE this close (five — `IMPRPT-COPY` is a `BATCH-PREBETA` member hiding inside one of the grouped rows). The three grouped rows, 20 IDs, to ICEBOX now, with ICEBOX given its own release trigger so the move is not a relabelling; their individual triggers ruled at the first close after the invite. One word each for the eight vague ones, offered as proposals rather than questions. Both FIELD-CONTRACT triggers re-pointed at `FIELDCONTRACT-3B`. And a mechanical close check: **every trigger named in the Docket is resolved against the file, and one naming a retired row is a defect.**
**Owns it.** Arch for the moves and the mechanical check; you and Arch for the 31, after the beta.
**Costs.** Ten minutes for the moves and the ICEBOX shift. The 22 are a real sitting and ⚠ **none of them blocks ≈Sept 18, which is why they wait.**

### 13. The Session Log header has no bound

**Measured.** **102 bullets, 70,554 characters, 11,207 words — 50.0% of a 140,996-character file.** Mean bullet 690 characters, longest 2,205. ⚠ **And it is not the header the Architecture Prompt mandates: of the six required fields, zero appear in the required form.** Two survive in bold (`Current log`, `Rollover`); `Shipped`, `In flight`, `Next action` and `Open decisions` do not exist as fields at all. **The six fields were the bound. Abandoning the template removed it, and no close instruction counted.**
**Proposed.** Restore the six fields with a counted bound of 4,000 characters, first four as one paragraph each. ⚠ **Sequenced after item 14's destination exists** — a header rewrite performed first deletes standing rules.
**Owns it.** Arch.
**Costs.** The rewrite is one close; the triage of 102 bullets is the work in it.

### 14. Rollover deletes findings, and it is a policy not an accident

**Measured.** Six archives, **425,675 characters**, all tracked — and all unreadable by working sessions by rule (archives are write-once and never read; you must upload one for its contents to be usable). So the only place a finding survives rollover is the header. ⚠ **Every incentive in the system pushes material into the one container with no bound. Item 13 is the symptom; this is the cause.**
**Proposed.** A fifth source of truth — `Minotaur_v2_Standing_Facts.md`, tracked, bounded at 20,000 characters, read after the Roadmap — because the corpus currently has history nobody reads, archives nobody may read, and a header everybody reads with no bound, and **no bounded readable home for a standing fact**. Plus a rollover sub-step: every entry leaving the log is read for standing facts and each is lifted in the same step, with the archive's header naming what was lifted, so a later reader can tell *"nothing was there"* from *"nobody looked."*
**Owns it.** Arch.
**Costs.** A new governing document, which should be resisted unless the measurement justifies it — 70,554 characters surviving in the only unbounded container is the justification. ⚠ **Retrospectively: one bounded check of the most recent archive only** (92,839 characters), at the first close after the invite. Nothing found there closes the question for the other five.

### 15. The register problem, and it is now a number

**Measured.** Arch's open corpus is **316,582 characters** — Architecture Prompt 27,355 + Roadmap 116,471 + Session Log 140,996 + Brief 31,760. The part written in your register, ▶ NOW plus ⏭ NEXT, is **1,847 characters. 0.58%.** A seat that reads 316,582 characters of dense internal register and then writes you one message writes in the register it has been reading. Three writing failures in one close, one cause, and the cause is a ratio.
**Proposed.** One guard rather than a tenth rule: draft, then re-read against a single test — *would a sharp professional who has not read the Roadmap follow this?* — and rewrite rather than appending a glossary. Plus the habit that will actually work: ⚠ **write your message before writing the close package, not after.**
**Owns it.** Arch.
**Costs.** Nothing. ⚠ **And the honest limit: items 13 and 14 are the real fix here, and they are only a mitigation.** A header at 4,000 characters instead of 70,554 removes 66,554 characters of internal register from every open and moves your share of the corpus from 0.58% to **0.74%**. Still small. The register problem is reduced by the bound, not solved by it.

---

## Not worth doing — three of the fifteen

Fifteen rows was a target to prune, not a quota to fill.

1. ⚠ **CLAUDE-HARNESS-STALE (9) — the defect does not exist.** Measured at source: no document in the repo describes SUBPIXEL-WANDER site 4 as provisional; the fix landed with the 2026-09-08 harness relocation, and `CLAUDE.md`'s surviving mention is about site 3 and is correct. **Retire the row; do not work it.** It is worth noting *why* it stayed on the list: the row was written against text that had already moved to another file, and nobody re-read the file after the move.
2. ⚠ **WF1A-PHRASE's guard (2) — do not build it.** The measurement confirms the phrase is enforced by nothing. But the failure it was registered for — `OMMIT APPROVED:` accepted and flagged — is CC's judgement working correctly, and a guard needs a new channel for the phrase to protect a pilot whose sunset review is at Sprint 4 close. **Fix the wording, keep the row for the sunset sitting, build nothing.**
3. ⚠ **A full sweep of the six Session Log archives (14) — not now, and possibly not ever.** 425,675 characters read on the suspicion that something durable is buried in them, six days before a private beta, is exactly the process work the priority ruling forbids. **One archive, after the invite, decides whether the other five are worth opening.**

**And one that was nearly filed and should not have been.** This seat measured `.git/hooks/` holding nothing but samples and was one sentence from reporting *"the commit-msg hook is not installed, so the no-trailer rule is unenforced."* `.git/config` sets `core.hooksPath = .claude/hooks`, so the hook **is** wired — and running the hook proved it rejects `Co-Authored-By` correctly. ⚠ **Recorded because it is the guard rail working:** the claim came from reading a directory listing, and the measurement that killed it took one command. It also turned up a real hole on the way — `commit-msg` does not catch `🤖 Generated with Claude Code`, which committed clean.

---

## Boundaries — what this session did and did not do

- **No CC handoffs.** None, for any member.
- **No migrations, no schema, no grants, no RLS.** The database was read once, for the applied migration ledger.
- **No edits to the Roadmap, the Ledger, the Session Log, the Brief, the Architecture Prompt or `CLAUDE.md`.** Every change is a proposal in a separate file.
- **No repo commits and no pushes.** The hygiene commands are written for you to paste.
- **No git command in either mount.** State was read from `HEAD`, `logs/HEAD`, the ref files, `.git/config` and `.git/index` as plain files. No lock file was created; none existed at open and none exists now.
- **Wrote only to `handoffs/parallel/` and `drafts/`.** ⚠ **Both, deliberately: `handoffs/` is gitignored, so a file left only there is not in the repo** — which is finding 10's fourth measurement applied to this seat's own output.

**State at open, verified from files and matching the opener exactly:** code repo `96efd113b4d232919ba121cb5da1f045384e7ee7` = `origin/main` · `Minotaur-Cowork` `478ba4834fa7832a0749bbe8274932c035ac10fb` = `origin/main` · no lock files in either `.git/` · `CLAUDE.md` **115,579** characters by `wc -m` · all three mounts reachable.

---

## The files

| File | Covers |
|---|---|
| `260912_meta_RETURN.md` | this document |
| `260912_meta_FENCE-AND-PUSH_PROPOSAL.md` | members 1, 2, 3, 4 — the full fence battery and the push-clause correction |
| `260912_meta_UNATTENDED-MEASURE_PROPOSAL.md` | member 5 — the three measurements and the redesign |
| `260912_meta_DOCKET-ROWLENGTH_PROPOSAL.md` | member 6 — the section measurements, the rule, five worked rows, the cap and footer defects |
| `260912_meta_GATE-REPORTING_PROPOSAL.md` | members 7, 8 — one mechanism, two symptoms |
| `260912_meta_REPO-HYGIENE_PROPOSAL.md` | members 10, 11 — paste-ready commands and the migration convention |
| `260912_meta_HELD-AUDIT_PROPOSAL.md` | member 12 — all 41 rows with verdicts |
| `260912_meta_SESSIONLOG_PROPOSAL.md` | members 13, 14, 15 — the structural three |

Member 9 has no proposal file: it is discharged by measurement and wants only a retirement line.

---

## The single next step

**Install the one-paragraph FENCE-PUSH correction into the Architecture Prompt at this close, and leave the other fourteen for the first close after the private-beta invite.**
