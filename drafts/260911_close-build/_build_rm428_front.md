# 🗺️ ROADMAP — Minotaur v2 (v4.28)

**Version 4.28 • September 11, 2026 • Retires v4.27 • Forward-only file — history lives in `Minotaur_v2_Ledger_v1_0.md`**

⚠ **RESTRUCTURED THIS VERSION, ON DANIEL'S RULING OF 2026-09-11.** Four sections, in this order, and no others: **▶ NOW** · **⏭ NEXT** · **🏗 THE SEQUENCE** · **📌 THE DOCKET**. **History does not appear in this file at all** — the Lineage change-log (22,728 characters), the SHIPPED table (7,862) and the two closed-session sections (4,951) are **deleted and never recreated**; every one of them is in the Ledger. *The file was 161,971 characters and the block Daniel actually reads was 1,546 of them — one percent, sitting above 28,000 characters of history he had to scroll past to reach the sequence.*

**TWO BOUNDS, and they are the point of the restructure:**

1. ⚠ **NOW + NEXT + THE SEQUENCE together are capped at 8,000 characters.** That is the part written for Daniel. Over the cap, prune — never accrete.
2. ⚠ **The whole file is capped at 135,000 characters.** It stands at roughly 126,000 after this pass. **The cap RATCHETS DOWN as the Docket is pruned and never up.** A cap the file already violates is an order nobody can follow, which is the `CLAUDEMD-ATLIMIT` failure, so this one is set where the file actually is.

**⚠ STILL SEQUENCED BY ONE PRODUCTION: BUENA VISTA SOCIAL CLUB, MEXICO CITY (Daniel, 2026-09-05).** Parity and housekeeping that does not serve that show takes a pin — named as a pin, never dropped. **BVSC-MX is `cf780353-448d-4b15-a054-973f577b215c`;** the US Tour is `57874c69-06b6-41b1-91d8-6a00e5255110`. ⚠ **Every citation of a project names its id, and duplicate `projects.name` is never "fixed" by a uniqueness constraint.**

---

## ▶ NOW

**Version history's database half is live and its safety net is shipped.** Migration **58** created `project_snapshots` and `project_blobs` and the `snapshot_project_v1` function; **VERHIST-GUARD shipped at `951557c`**, so on the equipment list a Change All or Delete Found touching **more than 20 records**, and **any Delete All**, now writes a backup first and refuses the gesture if that backup fails.

**Proven end to end on live data, not estimated:** three snapshots on a real project shared **one** library blob and **one** identity-map blob between them — **1.88 MB total where carrying those inline would have been 3.15 MB**, and every further snapshot now adds nothing for either.

⚠ **Two of seventeen destructive commit points are wired.** The hourly timer, the retention rule and the Save Version button are **not built**.

## ⏭ NEXT — the next three sessions

1. **Turn the hourly backups on.** A small database change adding the timer and the cleanup rule. ⚠ **It needs one answer from Daniel first** — see below.
2. **Put the backup in front of the other fifteen places that can destroy data.** The same guard, now cheap: the cable, box, bundle, tail and two admin screens, plus the three import paths, which carry one extra constraint of their own.
3. **Build the History screen** — seeing the backups, and opening one as a new production.

**⚠ Yours, whenever — nothing here is blocked on anyone else.**

- **The one answer that gates step 1:** when you name a version and save it deliberately, can the cleanup ever delete it? *(Arch's view: no.)*
- **The one thing that gates letting outside users in:** there is still no page that finishes a password reset.
- **Yours alone, with a deadline:** the temporary rule letting three text-editing tools bypass the shell guard expires at Sprint 4's close. Claude Code broke that rule four times tonight and disclosed it — evidence for letting it expire rather than extending it.
- **Two minutes:** three stray folders sit untracked in the code repo and none is ignored.
- **Carried, unchanged:** the two postponed browser gates on shipped code; a printed 5167 sheet against a real Avery blank; the Tail Panel reprint.

---

## 🏗 THE SEQUENCE — in order, and the order is the point

**A unit does not move up from PINNED without a ruling.** The first table is what gets built and in what order; the second is everything held behind it.

| # | Unit | What it is | State |
|---|---|---|---|
| **1** | **VERHIST-TIMER — the hourly backup and the cleanup** | The second and smaller half of the migration: install `pg_cron`, schedule `snapshot_project_v1` hourly, and add the retention delete (48h hourly / 30d daily / weekly after). ⚠ **TRIGGER B. Arch's, rehearsal-first, Daniel confirms before the apply.** ⚠ **Gated on one ruling — whether a manually named Save Version is exempt from the cleanup.** Note for the design: `pg_cron` runs as a superuser, so RLS does not apply and `created_by` is null for an automatic snapshot, which is correct but must be deliberate | **NEXT** |
| **2** | **VERHIST-FANOUT — the other fifteen commit points** | The guard exists and the census pins all seventeen; this wires the remaining fifteen. Cable, box, bundle, tail, the two admin grids under their **"Delete Unused"** label, and the three import-apply sites. ⚠ **The import sites carry Arch's constraint: the snapshot is its own COMPLETED request before the apply begins**, because the apply already exhausts its 8-second budget and must keep single-transaction atomicity. CC, one unit | After 1 |
| **3** | **VERHIST-UI — the History screen and the Save Version button** | ⚙ PROJECT → History: the list, the manual **Save Version** (the `'manual'` reason exists in SQL and no surface invokes it), and **"Open as new production"** — a fork, never in place. ⚠ **The restore path must decide what happens to the import identity map in the fork** — carry it and you copy dead pointers, drop it and the fork cannot be re-imported against. Measured evidence for that decision is in this session's Ledger append | After 2 |
| **4** | **AUTH-RESETPAGE — the password reset page** | ⚠ **IT GATES PUBLIC BETA ON ITS OWN AND NOTHING ELSE ON THIS LIST DOES.** No page completes a password reset, so a beta user who forgets one has no way back in. Measured at source | **Arch proposes this slot; Daniel's ruling on the order** |
| **5** | **The two fail-open controls — FROZENCHECK-FAILOPEN and HARNESS-SIGNOUT** | Both small, both currently load-bearing in the wrong direction. ⚠ **Each gets a BATTERY, not a reading** — FENCE-RULINGS is the precedent and it caught two defects in its own author's work by running | After 4 |
| **6** | **FIELD-CONTRACT leg 3b — the remainder** | ⚠ **DECLARED OPENED IN v4.25 AND NEVER GIVEN A DOCKET ROW (DOCKET-STALEACTIVE).** Gated on nine rulings and must be SCOPED from the tenth Ledger append before it is sequenced | **Scope it first** |
| **7** | **BATCH-HOUSEKEEPING, and `duplicate_item_v1` with the next migration window** | The registered small fixes waiting for a convenient unit. ⚠ **`duplicate_item_v1` is a MIGRATION — Trigger B, Arch's, rehearsal-first — and must not ride a UI batch** | After the above |

