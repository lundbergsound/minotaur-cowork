# MINOTAUR v2 — BACKUP STANDING POSTURE

**Verified 2026-08-27.** Discharges R8-DRILL, overdue since Aug 5 and top of the list for thirteen
sessions. Runbook: `R8_Backup_Verification_Runbook_2026-08-05.md`. Project `musfmquwwjlggyxckpos`.

**Read this first: the plan changed mid-drill.** Daniel upgraded the organisation from Free to Pro
while the drill was running. The runbook's premise — no managed backups, so a manual dump is the
only proof available — was true when the drill opened and false by the time it finished. What is
recorded below is the posture **after** the upgrade. The Free-plan findings are preserved in §4 so
the record shows what changed rather than quietly re-basing.

---

## THE FINDINGS

```
F1  Plan tier: PRO
      Upgraded by Daniel 2026-08-27, mid-drill. Confirmed at source: organisation
      errkslonajoscyllhwys returns plan: pro. Discharges the registered Strat item
      "a Supabase plan upgrade is a STRAT decision."

F2  Daily backups: Y
      newest  27 Aug 2026 14:50:34 (+0000)
      oldest  20 Aug 2026 14:49:05 (+0000)
      count   8 · all COMPLETED · type PHYSICAL

F3  PITR: N — offered as a paid add-on, not enabled (r8_03)

F4  EFFECTIVE RETENTION WINDOW: 7 days

F5  Restore PROVEN: method = restore-to-new-project (BETA), from the
      27 Aug 2026 14:50:34 (+0000) scheduled backup
      date       2026-08-27
      duration   restore started 17:43:50 (+0000); target queryable by 17:48 — ~5 minutes
      verified   counts ✓ — see VERIFICATION below

F5b DOES NOT FIRE. Retired by the upgrade. Path C was never run and is not owed.

F6  Drill artifact removed: Y
      "Minotaur Backup Test 8-27" (ref gywgfcsbyaenghzimrms) deleted by Daniel.
      Verified by listing, not by trusting the deletion: only minotaur-v2 remains on the org.

F7  project-images bucket: 5 objects · 2,956,970 bytes (2.82 MB)

F8  Storage included in restore: N — and the shape of the N matters, see below

F9  Storage posture: NO COVERAGE TODAY.
      Automated off-platform mirror scoped as DEEP-ARCHIVE Tier 3
      (drafts/260827_deep_archive_scope.md). Daniel ruled out a manual monthly
      download 2026-08-27. Recording "manual mirror" would be a plan written as
      a posture; this line says what is true today.

WRITTEN RESTORE PROCEDURE: repeat Phase 2 PATH A of the R8 runbook — Database →
  Backups → "Restore to new project" → Restore on the chosen backup. Verify with
  the count query below. Repoint Vercel env vars only on Daniel's explicit go.
  Delete the restored project when done: it bills at $10/month while it exists.

RE-VERIFY: before public beta (October) and at any plan change.
```

---

## VERIFICATION — why this is a proof and not a vibe

The restored copy was compared against production measured the same day at 16:50 (+0000). Several
tables came back **lower**, and every gap accounts for itself arithmetically. That is what makes
this a proof: a faithful restore of a backup taken at 14:50 should be missing exactly the work done
after 14:50, and it is.

| table | production | restored | gap | the gap is |
|---|---|---|---|---|
| projects | 30 | 27 | −3 | `Import Test`, `Import Test 2`, `Import Test 3` — all created after the backup |
| equipment_items | 9,522 | 6,904 | −2,618 | 1,309 × 2 |
| cable_details | 3,849 | 1,611 | −2,238 | 1,119 × 2 |
| cable_mult_lines | 2,332 | 1,228 | −1,104 | 552 × 2 |
| tail_details | 749 | 369 | −380 | 190 × 2 |
| bundles | 242 | 100 | −142 | 71 × 2 |
| cover_letters | 28 | 25 | −3 | one per Import Test |

Every gap is exactly **twice one BVSC NY corpus**, because `Import Test 2` and `Import Test 3` were
each a full BVSC NY import run this morning, after the backup. The newest project present in the
restore is `Test-8-22` (22 Aug).

**Independent corroboration of the backup's age.** `link_group_members` restored at **210** — which
is precisely the orphaned figure the Roadmap carries for LINK-ORPHAN, from before 2-IMP-c populated
the clone links this morning. Two unrelated clocks agree on when the backup was taken.

**Exact matches, cell for cell:** `box_details` 307 · `equipment_library_items` 13,741 ·
BVSC NY's own `equipment_items` **2,813** · `auth.users` **12**.

**Auth came across.** Twelve accounts with their credentials. A restore produces a working
application, not an orphaned dataset — which is the failure mode a `--schema=public` dump would have
had, and one reason Path A beats the runbook's Path C on more than convenience.

### The corrected verification query

**The runbook's query is STALE and must not be used.** It selects from `cables`, which does not
exist — cables live in `cable_details`. Rebuilt from the live schema 2026-08-27:

```sql
select 'projects' t, count(*) n from public.projects
union all select 'equipment_items', count(*) from public.equipment_items
union all select 'cable_details', count(*) from public.cable_details
union all select 'tail_details', count(*) from public.tail_details
union all select 'box_details', count(*) from public.box_details
union all select 'bundles', count(*) from public.bundles
union all select 'cable_mult_lines', count(*) from public.cable_mult_lines
union all select 'cover_letters', count(*) from public.cover_letters
union all select 'equipment_library_items', count(*) from public.equipment_library_items
union all select 'import_identity_map', count(*) from public.import_identity_map
union all select 'link_groups', count(*) from public.link_groups
union all select 'link_group_members', count(*) from public.link_group_members
order by 1;
```

---

## F8, STATED PROPERLY — the restore brings back the RECORD of the images, not the images

Supabase says it plainly on the Scheduled backups tab, quoted verbatim from the product:

> *"Database backups do not include objects stored via the Storage API, as the database only
> includes metadata about these objects. Restoring an old backup does not restore objects that have
> been deleted since then."*

**Measured in the restored copy: `storage.objects` held 5 rows and `storage.buckets` held 1.** The
metadata came across. The files did not.

**This is worse than a plain gap, because it presents as intact.** A recovered Minotaur would list
five images and serve five broken links, and nothing in the interface would say the difference. A
gap that announces itself can be planned around; this one cannot.

At today's size — 5 files, 2.82 MB — the exposure is small. It is not small in shape.

---

## §4 · WHAT THE FREE-PLAN HALF OF THE DRILL FOUND, PRESERVED

Recorded so the change is legible rather than erased:

- **F1 was Free**, spend cap enabled (`r8_01_plan-tier_free.png`). **That screenshot is now stale
  evidence and its filename asserts a tier that is no longer true.** Retake or annotate it.
- Free carried no daily backups and no PITR, and the restore control was withheld — so runbook
  Paths A and B were unavailable and Path C, a manual dump, was to be the drill.
- **The eight backups predate the upgrade.** Either Supabase was taking them on Free and withholding
  the restore control, or it backfilled them on upgrade. **NOT MEASURED — neither is asserted here.**
- **Path C was never run.** The upgrade made it unnecessary and it is not owed.

---

## TEARDOWN AND PROJ-CLEAN-2

- Restored project deleted; verified by listing.
- `Import Test`, `Import Test 2`, `Import Test 3` deleted in-app. Production: **30 → 27 projects,
  zero Import Tests remaining**, verified by query.
- **PROJ-CLEAN-2 is only partly discharged.** 27 projects remain and roughly 21 are leftovers —
  six `FIX1 Repro`, two `FIX1 Mixed`, three `Amend2`, two `S3G-2`, three called `Test`, plus `tesr`,
  `Test Cable`, `ACC`, `Test-8-22`. The six live shows are Our Town in Space · JOY ·
  Matchbook Festival · Vape! · BVSC NY · Comet Fall '26.
- **`Visual Gate Fixture` must NOT be swept.** It is the visual gate's fixture; deleting it breaks
  the gate. Named here because a cleanup pass reading only the name would bin it.

---

## ATTORNEY HAND-BACK

> *"Deleted user data may persist in encrypted backups for up to **7 days** before permanent
> removal."*

**This number is live and DEEP-ARCHIVE will change it.** A long archive of user data extends the
persistence window to the archive's retention, so the retention window is a legal parameter and not
an engineering preference. It belongs on the September attorney agenda (LEGAL-SEP) **before** the
archive is built, not after it has been accumulating.

---

## CARRIED TO THE CLOSE

- **R8-DRILL: CLOSED.** F1–F9 answered, restore proven by measurement, artifact removed.
- **The plan upgrade is a Strat-tier decision, taken.** It needs a Strat-record entry as well as
  this one, or the two tiers disagree in writing.
- **A NEW decision is now live and was not before: the spend cap.** On Free it was inert. On Pro,
  with the cap enabled, exceeding a usage quota **restricts the service** rather than billing —
  compute is explicitly excluded from the cap, usage items are not. For a database running a live
  Broadway show, that converts a few dollars of overage into an outage, on the busiest day, because
  busy is what exceeds a quota. **Undecided. Daniel's, and it is a cost decision, not an Arch one.**
- **DEEP-ARCHIVE** queued — `drafts/260827_deep_archive_scope.md`.
- **Runbook amendments owed:** the stale verification query · Path A is the drill, not Path C ·
  the $10/month cost of the restored project, which makes teardown load-bearing rather than tidy.

*Evidence: `evidence/r8-drill-260827/`. Findings measured through the Supabase connector and the
dashboard on 2026-08-27; every figure in this document is a measurement taken that day.*
