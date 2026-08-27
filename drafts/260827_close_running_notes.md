# CLOSE RUNNING NOTES — 2026-08-27 session (MAIN LINE)

Live scratch for this session's close package. Not a deliverable.

## In flight

- **CC: `CABLE-C1`, the cable selector pass.** Handoff issued at
  `handoffs/to-cc/260827-1248_cable-c1-selectors.md`. FRESH session, opened off `0468a5d`.
  Awaiting return at `handoffs/from-cc/…_cable-c1-selectors.md`. **Session is NOT closed while CC
  is out** — Rule 1 stops a close being skipped, it never licenses one being run early.
- **Parallel session on the Arch prompt** — Daniel opened it. Main line writes no Arch prompt
  version this session.

## Decisions taken today

- **SUPABASE PLAN UPGRADED TO PRO**, by Daniel, 2026-08-27, mid-drill. Confirmed at source: org
  `errkslonajoscyllhwys` returns `plan: pro`. **This discharges the registered Strat item** ("a
  Supabase plan upgrade is a STRAT decision and is registered as one"). Needs a Strat-record entry
  as well as the Arch one, or the two tiers disagree in writing.
- **DEEP-ARCHIVE queued** at Daniel's request — scope at `drafts/260827_deep_archive_scope.md`.
  Docket row owed. Carries a LEGAL-SEP dependency: retention window is a legal parameter.

## R8 drill — state

The upgrade **invalidated the drill's premise mid-run.** Recorded rather than quietly re-based:

- **`evidence/r8-drill-260827/r8_01_plan-tier_free.png` is now STALE EVIDENCE.** Its filename
  asserts a tier that is no longer true. Retake or annotate; do not let it stand as F1.
- **F5b no longer fires.** "Plan has no managed backups — upgrade decision owed before public beta"
  was true this morning and is not true now. The upgrade IS the answer to it.
- **Paths A and B are no longer unavailable.** The opener's "restore-to-a-new-project needs a paid
  plan, so Path C is the drill" was correct when written and is now superseded. **Path A is the
  drill.** Path C's dump was never taken and is not owed.
- Measured from the dashboard, not assumed: **8 daily backups, 20 Aug 14:49:05 → 27 Aug 14:50:34
  (+0000), all COMPLETED, type PHYSICAL.** So F2 = Y, count 8, window ~7 days → **F4 = 7**.
- **The eight backups predate today's upgrade.** Supabase was taking them on Free and withholding
  the restore control, or backfilled on upgrade. **NOT MEASURED which** — do not assert either in
  the findings block.
- **F8 = N is now cited from the product itself**, verbatim on the Scheduled backups tab: *"Database
  backups do not include objects stored via the Storage API, as the database only includes metadata
  about these objects."* Better evidence than the docs citation it replaces.
- **F7 measured 2026-08-27 by query, pending screenshot corroboration: 5 objects, 2,956,970 bytes
  (2.82 MB)** in `project-images`.
- **F9 changed by Daniel:** not a manual mirror. Automated off-platform mirror = DEEP-ARCHIVE Tier 3.
  Findings block must record **no coverage today** plus the scoped item — recording "manual mirror"
  when no mirror exists would be a plan written as a posture.

## Costs confirmed at source, not estimated

- A second project on this org: **$10/month**, from `get_cost` — not free, and not covered by the
  spend cap, which explicitly excludes Compute. Pro-rated, so a short-lived drill project is cents.
  **It must be deleted or it is $10/mo standing.**

## Owed at close

Roadmap v5.0 · Ledger Aug-27 second append · Session Log entry 9 · R8 standing-posture document ·
docket rows for **DEEP-ARCHIVE** and the spend-cap decision if Daniel takes it · propagation of the
Pro upgrade through the Roadmap Current Status, the Session Log STATE OF PLAY and the docket's
"a Supabase plan upgrade is a STRAT decision" line.

**Also uncommitted since this morning and still not pushed:** Roadmap v4.9 (untracked), Ledger and
Session Log (modified), `evidence/` (untracked). Same O-5 exposure that bit on Aug 24.
