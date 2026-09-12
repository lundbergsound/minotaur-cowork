# PROPOSAL — repo hygiene: the strays, the two-line ignore file, and 59 migrations against 2 files

*Written 2026-09-12 by the META parallel (Cowork-Arch). Members 10 (REPO-STRAY-UNTRACKED) and 11 (REPO-MIGRATIONS-ABSENT). Proposal only; **Daniel commits.** Everything here was read from files and from the live database — no git command was run in either mount.*

---

## Plain English, first

**The Docket is right about two of the three strays and wrong about the third, and the difference changes the fix.** `Claude outputs/` and `{src/` are untracked and unignored — an ignore line fixes each. **`session-log-archives/` is TRACKED** — it is committed, it does not show in `git status`, and an ignore line would do nothing to it. It needs removing from the repo, which is a different command and a different decision.

**`Claude outputs/` is back, exactly as recorded.** Four files; two of them written 2026-09-10 at 20:31 and 20:38 during a live CC session. A second one-writer breach, and it recurred because the September instance was moved rather than ignored.

**The migration gap is worse than "2 against 59."** The two files in the repo do not reconcile against the applied ledger at all. One of them — `20260707152921_equipment_library_model_unique.sql` — **matches no applied version**; the applied ledger has `20260707132157` that day and nothing at `152921`. The other carries a truncated version string (`20260711_…` against the applied `20260711162133`), so a `supabase db push` would treat it as an unknown migration rather than an applied one. **Effectively zero of the 59 applied migrations are reconcilable from the code repo.** And the `drafts/` fallback is thinner than the row implies: **five `.sql` files exist in `Minotaur-Cowork`, covering at most five of the 57 unfiled.**

---

## What was measured

**Code repo (`~/Developer/Minotaur`), at `96efd113`:**

- `.gitignore` — 25 lines. Ignores `node_modules/`, `.DS_Store`, `.env*`, `.next/`, `tsconfig.tsbuildinfo`, `next-env.d.ts`, `screenshots/gate/`, `screenshots/gate-diff/`, `.claude/settings.local.json`, two extraction blobs, `supabase/.temp/`. ⚠ **None of the three strays appears.**
- Top-level directories in the working tree: `Claude outputs/` · `docs/` · `node_modules/` · `screenshots/` · `scripts/` · `session-log-archives/` · `src/` · `supabase/` · `{src/`
- **Tracked status, from parsing `.git/index` directly (1,295 entries, version 2 — no git command):**

| Path | Tracked? |
|---|---|
| `Claude outputs/` | **0 entries — untracked** |
| `{src/` | **0 entries — untracked** |
| `session-log-archives/` | **1 entry — TRACKED** (`session-log-archives/Session_Log_Archive_2026-07-03.md`) |
| `supabase/migrations/` | 2 entries |

- `Claude outputs/` contents, with mtimes: `catnote_correction.md` 2026-09-06 16:39 · `catnote_correction2.md` 2026-09-06 16:46 · `260910-2035_autonomy-readiness_findings.md` **2026-09-10 20:31** · `260910-2050_autonomy-findings_ERRATA.md` **2026-09-10 20:38**
- `{src/` contents: three nested `.DS_Store` files only, all 2026-07-05 04:17, under `{src/{app/{auth,dashboard,project,api},components/`
- `session-log-archives/` contents: one file, `Session_Log_Archive_2026-07-03.md`, 12,395 bytes, 2026-07-03

**Cowork repo (`~/Developer/Minotaur-Cowork`), at `478ba483`:**

- `.gitignore` — **two lines**: `.DS_Store` and `handoffs/`. Confirmed.
- `.git/index` — 225 entries. `handoffs/` **0 tracked** · `drafts/` **135** · `session-log-archives/` 6 · `reference/` 3 · `evidence/` 2 · `_to_delete/` **0**
- ⚠ **A fourth stray the Docket does not name: `_to_delete/` in the Cowork repo is untracked AND unignored**, holding `260906_arch-stray-outputs/` and `260910_arch-scratch/`. It shows in every `git status` there for the same reason the code-repo trees do.

**Migrations — live read against `musfmquwwjlggyxckpos`:**

- Applied: **59**, first `20260521151157_fix_project_rls_policies`, last `20260911165516_verhist_timer_schedule_and_retention`. The Docket's count of 59 reproduces exactly.
- In `supabase/migrations/`: **2 files**, both tracked, latest dated 2026-07-11.
- ⚠ **Neither file reconciles.** `20260707152921_equipment_library_model_unique.sql` matches no applied version — the applied ledger holds `20260707132157_flatten_equipment_items_to_flat_records` that day and nothing at `152921`. `20260711_previous_revisions_editable_flag_guarded_policies_truncate_revoke.sql` matches applied `20260711162133` by name but its filename carries a date, not a version timestamp.
- `.sql` artifacts in `Minotaur-Cowork`: **5** in `drafts/` (`260822_ARCH-MIG-BOX_assembled_APPLIED.sql`, `260823_2-MIG_assembled_APPLIED.sql`, `260825_2-MIG-b_assembled.sql`, `260911-0100_verhist-mig_PROPOSED.sql`, `260911-1647_verhist-timer_APPLIED.sql`), 6 in the repo overall.

---

## PROPOSAL 1 — the commands, for Daniel to paste

⚠ **Read before pasting: block A is safe and reversible. Block B deletes files — the two `.md` files under `Claude outputs/` are Arch output from 2026-09-10 and may contain the only copy of something.** Check them first; `260910-2035_autonomy-readiness_findings.md` and `260910-2050_autonomy-findings_ERRATA.md` are the autonomy-audit pair, and the findings they carry are summarised in `drafts/260910-2050_autonomy-measurements-and-proposal.md` and superseded by today's `260912_meta_UNATTENDED-MEASURE_PROPOSAL.md`. The two `catnote_correction` files are from 2026-09-06 and their content shipped.

**Block A — the ignore lines (code repo).** Three appended lines; nothing is deleted.

```bash
cd ~/Developer/Minotaur
cat >> .gitignore <<'EOF'

# ARCH-OUTPUTS-MIRROR — Arch output written into the code repo is a one-writer
# breach, not a file class. Ignored so the breach cannot be closed by moving
# the evidence, which is how the Sept-6 instance recurred on Sept 10.
Claude outputs/

# An unexpanded brace expansion from 2026-07-04. Empty but for .DS_Store.
{src/
EOF
git status --short
```

Expected: one line, ` M .gitignore`. `Claude outputs/` and `{src/` stop appearing.

**Block B — remove the strays (code repo).** Run only after checking the four files.

```bash
cd ~/Developer/Minotaur
rm -rf "Claude outputs" "{src"
git rm -r --cached session-log-archives
rm -rf session-log-archives
git status --short
```

Expected: ` M .gitignore` plus one `D  session-log-archives/Session_Log_Archive_2026-07-03.md`. ⚠ **`session-log-archives/` needs the `git rm --cached` because it is tracked** — deleting the directory alone leaves a staged deletion, and an ignore line would have done nothing. The live archives are in `Minotaur-Cowork/session-log-archives/` (6 files, 425,675 bytes); this is a single July-3 stray from before the split, and the directory name collides with the live one.

**Block C — the Cowork repo's ignore file.** Two lines is why files named in a `git add` are silently not committed.

```bash
cd ~/Developer/Minotaur-Cowork
cat >> .gitignore <<'EOF'
_to_delete/
.venv/
*.tmp
EOF
git status --short
```

⚠ **Do NOT add to `handoffs/`'s ignore or remove it** — that is a deliberate decision with a standing rule attached (*anything durable in a handoff is carried into `drafts/` in the same pass*). Changing it is its own ruling, not hygiene.

**Block D — the commit.**

```bash
cd ~/Developer/Minotaur
git add .gitignore
git commit -m "chore(repo): ignore Arch output and the {src stray, remove the pre-split session-log-archives

Claude outputs/ recurred on 2026-09-10 during a live CC session because the
September 6 instance was moved to _to_delete/ and no ignore line was added.
session-log-archives/ was tracked, not untracked, so it needed removing rather
than ignoring. Measured by the META parallel, 2026-09-12."
git push
cd ~/Developer/Minotaur-Cowork
git add .gitignore
git commit -m "chore(repo): ignore _to_delete/ and scratch (META parallel, 2026-09-12)"
git push
```

⚠ **A push to `minotaur-v2` is a production deploy** (Vercel builds every push to `main`). This one touches `.gitignore` and deletes files git was tracking but nothing builds — still, it deploys, so run it when a deploy is acceptable.

## PROPOSAL 2 — correct the row

REPO-STRAY-UNTRACKED says *"three untracked trees … so every one shows in `git status`"* and *"three ignore lines and a delete."* Measured: **two untracked trees and one tracked directory; two ignore lines, one `git rm --cached`, and a fourth stray (`_to_delete/`) in the other repo.** ⚠ **The tracked one is the correction that matters** — under the row as written, someone adds three ignore lines, `session-log-archives/` keeps its committed file, and the row gets marked done.

---

## PROPOSAL 3 — the migration convention

**The standing rule, for the Architecture Prompt's migration runbook:**

> **Every applied migration lands as a file in `supabase/migrations/` in the same session it is applied, named `<version>_<name>.sql` with the version string exactly as the applied ledger records it.** The apply is not complete until the file is committed. A migration preserved only as a `drafts/` copy in `Minotaur-Cowork` is not in the code repo and cannot rebuild the database. ⚠ **The reason, because a bare rule gets rationalised past: on 2026-09-12 the repo held two files against fifty-nine applied, and NEITHER reconciled — one matched no applied version at all and the other carried a truncated version string. The database was unrebuildable from the repo, and it had been for two months without anything noticing.**

**And an addition to the close checklist:** the migration ledger is live-read at pre-open and **byte-matched against the files in `supabase/migrations/`**, not only against what the opener claims. The Architecture Prompt already requires the live read; it does not require the comparison against the files, which is the check that would have caught this.

**The backfill.** 57 files to export, and ⚠ **it is Arch's and it is not free.** Options:

- **(a) Export all 57 from the applied ledger**, in version order, filenames from the ledger's own version strings. Correct and complete, and it makes `supabase db push` meaningful on a fresh project. Cost: one Arch pass, and each body must come from the database's own record of the applied statement, not from a `drafts/` reconstruction.
- **(b) Export a single squashed baseline** at today's schema plus a forward-only convention from here. Cheaper, and it loses the history that makes a restore drill diagnosable.
- **(c) Fix the two existing files' names and adopt the convention forward-only**, leaving the 57 unfiled.

**Position: (a), scheduled behind the private beta, with (c) done now as five minutes of work.** The row's own trigger — *"before any second environment"* — is right, and (c) removes the specific trap that the two files currently in the repo would be replayed as new migrations against a fresh project. ⚠ **(c) has a pre-condition: confirm that `20260707152921_equipment_library_model_unique.sql` was ever applied at all.** It matches no applied version, so it is either a renamed copy of `20260707132157` or a migration that was written and never run — and those want opposite treatment.
