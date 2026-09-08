# VERHIST — scope and decision block — PARALLEL RETURN

**`handoffs/parallel/260908-1551_verhist-scope_RETURN.md` · written 2026-09-08 15:51 EDT by a PARALLEL Cowork-Arch session (Daniel-declared) while the main line is mid-FIELD-CONTRACT with CC live. There is no opener for this parallel — Daniel opened it directly. The main line reads this as EVIDENCE and owns the fold-in: the Roadmap rows, the Ledger append and any CC handoff are its to write. This session issued no CC handoff, touched no migration or schema, and edited no Roadmap, Ledger or Session Log. A proposal until Daniel confirms.**

**Ruling of record (Daniel, 2026-09-08):** durable per-production version history is SCOPED — no Strat pass. Adds periodic snapshots: v1 takes one every half hour via Dropbox; v2 target is hourly.

---

## 1 · The requirement, in the terms v1 users already have

Today a v1 user relies on Dropbox version history to take the whole `.mino` back to a prior state, for three reasons: to look at it for reference · to open old and new side-by-side · to undo a significant change. v2 removes that net. What ships today covers one list, for one of the three.

## 2 · What exists at HEAD `44e206d` — measured, not recalled

| Piece | State at source |
|---|---|
| `equipment_list_revisions` | `id · project_id · revision_name · snapshot jsonb · editable · created_by · created_at`. Guard trigger makes a frozen snapshot immutable; TRUNCATE revoked; RLS update/delete policies. Applied 2026-07-11. **Good precedent — copy its shape.** |
| The snapshot itself | `{ settings, searchRows, savedAt, sections }` — **print-shaped, not data-shaped.** It is a rendering of the equipment list and cannot be turned back into rows. Written from `PrintEquipmentListClient.tsx:977` on print. |
| Previous Revisions view | `PreviousRevisionsClient.tsx`, 1,180 lines: picker · **+ Duplicate & Edit** · Rename · Delete Revision. Built. **No restore of any kind.** |
| Project History tab | Ruled R3 as a slot under ⚙ PROJECT; never designed. **Empty slot, ready.** |
| Change signal | **Five project-scoped tables carry NO `updated_at`** — `cable_details · tail_details · box_details · link_groups · link_group_members`. "Has anything changed since the last snapshot?" cannot be read from timestamps. |
| Timer | `pg_cron` 1.6.4 is **available and not installed** on `musfmquwwjlggyxckpos`. Enabling it is a one-line migration. |
| DEEP-ARCHIVE | Its own draft says in so many words: VERHIST lives in the same database it protects and dies with it; DEEP-ARCHIVE is the slow off-platform layer underneath. **Two jobs. This unit does not try to be the other one.** |

## 3 · The shape — Arch's recommendation

**One table, one SQL function, one timer, one gesture.**

**3.1 The table — `project_snapshots`.** Per-production, **data-shaped**: the rows of every project-scoped table, as JSON, so a snapshot can be poured back into rows. Columns: `id · project_id · taken_at · taken_by (null for the timer) · trigger · label · content_hash · row_counts jsonb · payload jsonb`. Copy `equipment_list_revisions`' guard: immutable once written, TRUNCATE revoked, RLS by project membership. `trigger` is an enum: `hourly · manual · change_all · delete_found · delete_all · import · print`.

**3.2 The function — `snapshot_project_v1(project_id, trigger, label)`.** Runs inside Postgres, so the timer path, the gesture path and the manual path are the same code. Builds the payload, hashes it, and **skips the write if the hash equals the latest snapshot's** — this is what makes hourly honest: an hour with no edits produces no row. It is also the answer to the missing `updated_at` columns: compare content, not clocks.

**3.3 The timer — `pg_cron`, hourly, every project.** Cheapest correct design at today's scale (29 projects, 34 MB database): build every project's payload once an hour and let the hash skip the unchanged ones. ⚠ **A cron job runs outside RLS.** The function needs a defined execution role for that path — a Trigger B design point, Arch's, settled in the migration, not discovered in it.

**3.4 The gestures — snapshot BEFORE the destructive ones.** Change All · Delete Found / Delete All · import apply. Plus a manual **Save version** with a name, and the existing print trigger keeps writing its own print-shaped revision (different artifact, different job — see 3.6).

**3.5 Restore — "Open as new production," never in place.** Restoring a snapshot creates a NEW project row carrying the same name (PROJECT-NAME-NOT-UNIQUE makes two productions with one name a ruled must-have, so this costs nothing) and inserts the payload with fresh ids, remapping every internal foreign key. **This one gesture answers all three use cases** — reference, side-by-side, and undo (open the old one, and if it is the one you want, delete the new one) — with ONE piece of UI. It also dodges the two hard problems an in-place restore carries: clobbering a collaborator's edits since the snapshot, and the row-hash identity trap RENAME-HASHDRIFT already names. **In-place restore is deferred to its own unit and Arch argues against it for beta regardless.**

⚠ **The restore is the hard half, and it has a precedent and a dependency.** `import_apply_v1` already does exactly this remap — rows from a foreign shape into a fresh project, atomically. The restore should be built on that pattern, not beside it. **The dependency is APPLY-TIMEOUT:** `authenticated` carries an 8-second statement timeout, and a full restore of a 2,591-row production is the same class of statement that times out today on import. APPLY-TIMEOUT (pinned, Trigger B, Arch's) is a prerequisite of the restore path, or the restore runs under the role that resolves it.

**3.6 What stays as it is.** `equipment_list_revisions` and Previous Revisions are the print-compare artifact — the green-diff v1 users know — and stay untouched. Do not merge the two tables; they hold different shapes for different jobs.

**3.7 The History UI.** ⚙ PROJECT → History (the R3 slot). A list: when · trigger · label · who. One action per row: **Open as new production.** A read-only in-place viewer is a second, later unit; the fork IS the viewer for the first cut.

## 4 · Retention — a legal parameter, with an engineering default

Hourly snapshots without thinning are a storage problem in a month and a legal problem now. Estimate, to be MEASURED in the unit: a 2,591-row production as JSON is on the order of 1–2 MB; with skip-if-unchanged, an active editing day yields roughly eight to ten snapshots. The engineering default Arch proposes: **hourly kept 48 hours · daily kept 30 days · weekly kept beyond, plus every `manual` and gesture snapshot kept until the user deletes it.** The retention window itself changes the attorney's deleted-data sentence exactly as DEEP-ARCHIVE does, and it goes to **LEGAL-SEP before the table accumulates**, not after.

## 5 · Rulings owed — answer in one reply

| # | Ruling | Arch's lean |
|---|---|---|
| **R-V1** | Restore is **fork-only** ("Open as new production") for the first cut; in-place restore is its own later unit | Yes |
| **R-V2** | Timer is **hourly with skip-if-unchanged**; retention default per §4 pending LEGAL-SEP | Yes |
| **R-V3** | Automatic snapshot **before** Change All · Delete Found/All · import apply, plus a manual **Save version** | Yes |
| **R-V4** | History lives in **⚙ PROJECT → History** with one action; read-only viewer deferred | Yes |
| **R-V5** | Sequencing: **VERHIST-MIG** (Arch, Trigger B: table + function + `pg_cron` + role) then **VERHIST-UI** (CC), placed **after DARKMODE-PASS and ahead of BATCH-HOUSEKEEPING**, so it lands before BATCH-PREBETA | Yes — the beta candidates are v1 users who will look for this net the first time a Change All goes wrong |

**Open, low stakes:** whether `import_identity_map` and `import_runs` ride in the payload. The forked production is a new production, so identity continuity into it is not the use case; Arch leans **exclude** and records the exclusion in the payload's own manifest.

## 6 · Unit shape once ruled

- **VERHIST-MIG** — Arch's. `project_snapshots` + guard + grants + RLS · `snapshot_project_v1` · `restore_snapshot_as_project_v1` (on the `import_apply_v1` pattern) · enable `pg_cron` and schedule the hourly job under a defined role · the thinning job. Rehearsal-first, forced rollback, residue check, authenticated probe. **Blocks on APPLY-TIMEOUT's ruling for the restore path.**
- **VERHIST-UI** — CC's. The History tab · the four gesture hooks · Save version · Open as new production · a test that fails when a destructive gesture is added without a snapshot hook (the FIELD-CONTRACT census shape). Declared baseline event: the project menu is a captured gate frame.
- **Owed alongside:** the LEGAL-SEP retention line · a `drafts/` copy of this file when the bridge is back · the Roadmap rows, written by the main line at its close, not by this session.

---

*Sources read at HEAD `44e206d` on 2026-09-08: `src/types/database.generated.ts` · `supabase/migrations/20260711_previous_revisions_editable_flag_guarded_policies_truncate_revoke.sql` · `src/lib/print/revisionSnapshot.ts` · `src/components/equipment/PreviousRevisionsClient.tsx` · `src/components/equipment/PrintEquipmentListClient.tsx` · `Minotaur-Cowork/drafts/260827_deep_archive_scope.md` · Supabase `list_extensions` on `musfmquwwjlggyxckpos`.*
