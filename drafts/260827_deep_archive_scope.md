# DEEP-ARCHIVE — scope

**Written 2026-08-27 by the Cowork-Arch main line, at Daniel's request, mid-R8 drill.
NOT a unit yet. Queued for the Roadmap docket at this session's close.**

**Working ID: `DEEP-ARCHIVE`.** Registers alongside R8's standing-posture record. Not scheduled
here — sequencing is the close's call.

---

## 1 · THE REQUIREMENT, IN DANIEL'S WORDS

> *"Give me the version from six months ago."*

Supabase's managed backups do not answer this and no plan tier does: Pro keeps **7 days**, Team 14,
Enterprise up to 30. Beyond a month, the only archive that exists is one we keep ourselves.

**The requirement is two questions wearing one coat, and they want different answers:**

| | question | who asks it | what it needs |
|---|---|---|---|
| **A** | *Restore the whole database as it stood on 12 March.* | disaster, a bad migration found late, a legal request | a machine-restorable dump |
| **B** | *What did BVSC NY's cable list look like before the March rework?* | Daniel, on a Tuesday, about ONE show | a readable file he can open |

**B is the one that will actually get asked**, and answering it by restoring a whole database to
read one show is absurd. A design that only does A has technically met the requirement and
practically missed it.

---

## 2 · WHAT IT IS NOT

- **Not a replacement for Supabase's 7 days.** Those stay the fast layer — something broke Tuesday,
  roll back to Monday, two clicks. DEEP-ARCHIVE is the slow layer underneath.
- **Not `equipment_list_revisions`.** That table is in-product version history for equipment lists
  (VERHIST, ~Nov). It lives in the same database it is protecting, so it dies with it. Different job.
- **Not a manual chore.** Daniel ruled this out explicitly 2026-08-27: *an automated way that
  doesn't involve a manual download to my Mac.* A monthly reminder that depends on him being at a
  desk is the design that quietly stops happening in December.

---

## 3 · THE SHAPE

Three payloads, one scheduled job, one off-platform destination.

### Tier 1 — the restorable dump (answers A)

`pg_dump` of the whole database, custom format, weekly. This is the thing that can be poured back
into an empty Postgres and produce a working Minotaur.

**It must include `auth`, not just `public`.** A dump of `public` alone restores every show and
nobody who can log in. Every FK to a user dangles. This is the single easiest thing to get wrong
and it is invisible until the day it matters.

### Tier 2 — the readable snapshot (answers B)

One folder per project per month, built by **the export path the app already has** — the v1-parity
exporters shipped in PORT-COV leg 1 and leg 2 (box side and cable side, sha256-pinned columns).

The point: opening `2026-03/BVSC NY/cable.xlsx` needs Excel and nothing else. No restore, no
Postgres, no Arch session. And because it reuses code that is already tested against the round-trip
gate, the marginal build cost is small.

**Consequence worth stating plainly: this makes the exporters load-bearing for the archive.** A
regression in them silently degrades the archive rather than failing a test. It should be named in
the export units' own docket entries, or the coupling is undocumented.

### Tier 3 — the storage objects (closes the July-21 addendum)

The `project-images` bucket — **5 objects, 2,956,970 bytes (2.82 MB) measured 2026-08-27.**

Supabase states it in the dashboard verbatim: *"Database backups do not include objects stored via
the Storage API."* True on every plan, including Pro. So these files are covered by nothing today,
and the R8 drill records that as the current posture.

Same job, same schedule, same destination. At this size it is seconds.

---

## 4 · WHERE IT RUNS AND WHERE IT LANDS

**Runs: a scheduled GitHub Action** in `lundbergsound/minotaur-v2`. The repo exists, the secret
store exists, the schedule is declarative and reviewable in a diff, and it runs whether or not any
machine of Daniel's is on. A Vercel cron is the alternative and is the wrong tool — function
timeouts are minutes and a full dump is not.

**Lands: off-platform object storage**, Cloudflare R2 or Backblaze B2. Both free at this size; R2
charges no egress, which matters on the one day the archive is actually pulled back.

**Not into the git repo.** Binaries in git is a trap and REPO-WEIGHT is already a docket item.

**The split of duties, and it is a hard stop otherwise.** CC writes the workflow and the scripts.
**Daniel places every secret himself** — the database URL, the service-role key, the object-store
credentials. CC never handles a credential value. The credential the job uses should be
least-privilege and dedicated to it, not a copy of anything already in use.

**Retention:** weekly kept 3 months · monthly kept 24 months. At this data size the whole archive is
small enough that the cost of being generous is nil.

---

## 5 · THE TWO RULES THAT MAKE IT REAL RATHER THAN DECORATIVE

**5.1 · An archive nobody has restored is not an archive.** It is a folder of files with hopeful
names. The job must carry a **scheduled restore rehearsal** — quarterly, restore the *oldest*
retained archive into a throwaway project and run the standard count query. R8's own discipline,
applied to the thing R8 built. Without it, the failure mode is discovering in March that the job
has been writing zero-byte files since October.

**5.2 · It must fail loudly.** A silent scheduled job that has stopped working is *worse* than no
job, because it manufactures confidence. Two mechanisms, not one:

- the workflow fails the run and notifies on any non-zero exit;
- a **freshness check** that complains when the newest archive is older than its interval — this is
  what catches the job that stopped being *scheduled*, which a failure notification cannot.

---

## 6 · THE THING THAT ARGUES AGAINST BUILDING IT

**A two-year archive of user data is a liability as well as an asset, and it moves a line in the
legal addendum.**

The addendum carries a deletion placeholder — *"deleted user data may persist in encrypted backups
for up to ___ days before permanent removal."* R8 fills that blank from the managed backup window.
**DEEP-ARCHIVE makes that sentence false.** If monthly archives are kept 24 months, deleted user
data persists up to two years, and the honest disclosure says so.

That is not a reason to skip the archive. It is a reason the archive's retention window is a
**legal parameter, not an engineering preference** — and it needs to be on the September attorney
agenda (LEGAL-SEP) *before* the job is built, not after it has been accumulating for a year.

Two mitigations exist and should be priced there: shorten retention, or build a deletion path that
reaches into the archive on request. The second is real work and should not be assumed cheap.

---

## 7 · WHAT IS OWED BEFORE THIS BECOMES A UNIT

1. **Daniel:** the retention window, as a legal parameter, via LEGAL-SEP.
2. **Daniel:** the object store — R2 or B2 — and the account to hold it.
3. **Strat:** whether Tier 2's readable snapshot is in the first cut or a follow-on. It is the half
   Daniel will actually use and the half that is more work.
4. **Arch:** confirm the exporters can run headless outside a browser session. **NOT CHECKED — this
   is the load-bearing unknown in Tier 2.** If they cannot, Tier 2 needs a server-side path and its
   size changes materially.

**Estimated shape once those land:** Tier 1 + Tier 3 are one small CC unit. Tier 2 is its own unit
and is the larger of the two. The rehearsal and the freshness check ride Tier 1 — they are not
follow-up, they are the difference between a backup and a belief.

---

*Queued 2026-08-27. Cost at today's volumes: approximately zero. Cost of not having it, on the day
it is wanted: the six months.*
