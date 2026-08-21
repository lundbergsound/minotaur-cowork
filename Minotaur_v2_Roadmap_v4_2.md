# 🗺️ ROADMAP — Minotaur v2 (v4.2)

**Version 4.2 • August 21, 2026 • Forward-only file — history lives in `Minotaur_v2_Ledger_v1_0.md`**

## 🧭 Next Sessions (RM-6 — plain English, kept current)

- **PORT-COV leg 1 (the box EXPORT half) is CLOSED at `a243867`**, one commit, 12 files, +1073/−26, pushed. AMEND-3's confirming visual gate also came back **28/28 green** at the top of the session, so **R-AM is discharged and leg 6 stays closed**.
- **FIRST ACTION next session: apply the Arch migration.** It is written and unapplied — `drafts/260821-1500_arch_migration_package_box_side.md`. It carries two things in one ledger entry (51 → 52): `import_apply_v1` gains box spine `type`, `box_details`, `box_types` and `box_id` arms; and `box_details.box_number` widens numeric → **TEXT** per BOX-NUM-TYPE. **Read §1.2 before applying** — the naive cast would change 100+ printed box labels from `201` to `201.0`, and the normalizing cast plus its pre-flight tripwire are why this package exists in the shape it does.
- **Then PORT-COV leg 1b — the box IMPORT half**, against the migrated RPC. It carries the ~20-site `box_number` code pass (§1.5 of the package), IMP-BOXCOL, and the natural-sort comparator (reuse `compareLabels`, do not fork one).
- **Then PORT-COV leg 2 — the cable side.** WIRE-TYPE is now RULED (deprecate), so the cable-side scope shrank.
- **SHARE build-prep is DONE and waiting** — `drafts/260821-1145_share_build_prep.md`. It carries REV-B measured against the live database, the closed-signup account path, and four open questions for Daniel. **Its headline finding: seven project-scoped tables are owner-only, so sharing is broken at the CURRENT three roles, not just at the fourth.**
- **Pre-open:** refs from ref files, never git (Cowork seat) · check for an orphaned `index.lock` · migration ledger **51** · Vercel READY at `a243867`. **`next-env.d.ts` will show modified — never committed.** A pre-existing untracked stray sits at `docs/reference/evidence/equipment/`.
- **Bulk data (R-AL, standing):** never route rows through a model context. Generator → payload file → loader executed where the network lives → one verification query.
- **Gate standing notes:** `npm run test:visual` does not run — use `node --env-file=.env.local scripts/visual-capture.mjs --gate` (VIS-ENVFILE). **The harness spawns its own fresh dev server when :3000 is free, so DEV-SERVER-AGE is satisfied by construction — there is nothing to restart.** Load ceiling honored; **`--force-load` forbidden**. **GATE-THEMEGLYPH: see the docket — it is intermittent, it can reproduce byte-identically, and it must not be registered in the diff-exception registry.**
- **Stash-window rule, new and standing:** any gate run inside a stash window regenerates `next-env.d.ts` and blocks the restore. `git checkout -- next-env.d.ts` immediately before the restore is a **routine step**, and the cycle is **`apply` → verify fingerprint → `drop`, never bare `pop`.**
- **At Daniel's desk:** **R8-DRILL, OVERDUE** (hard stop before the September attorney engagement) · **BOX-REPRINT** · the CAND-4 texts · `HERO_BID_TO_OPENING` goes plural when Vape! Chicago opens · GIT-CFG strays.

## Lineage (full change-log lives in the Ledger; prior roadmap files in Minotaur-Cowork git history)

| Version | Date | Closed | Retires |
|---|---|---|---|
| **v4.2** | Aug 21 | **R-AM discharged** (28/28 green, quiet machine) · **PORT-COV leg 1 export half at `a243867`** · FINDING 1 discharged · IMP-SPINE-2 closed · EXPORT-ORDER's 38-vs-36 reconciled at source · **BOX-NUM-TYPE and WIRE-TYPE both RULED** · SHARE build-prep delivered · Arch migration package written, unapplied · **GATE-THEMEGLYPH** registered | v4.1 |
| v4.1 | Aug 21 | S4-3 leg 6 entire at `8b078b2` · JOY + BVSC NY seeded · R-AL bulk-data architecture | v4.0 |
| v4.0 | Aug 19 | S4-3 leg 5 entire at `07150e6` · roadmap restructured per R-AD | v3.14 |

## Current Status (August 21, 2026)

Live at `https://minotaur.app` at **`a243867`**, pushed (`8b078b2..a243867`). **PORT-COV leg 1's export half shipped**: `boxes.xlsx` at 36 columns and `box types.xlsx` at 6, both pinned by tests against v1's measured headers, empty classes omitted as v1 omits them. Counts: suite **1865/117** (from 1816) · frozen **3/3 vs `be0769de`** · dependency gate empty · build and strict typecheck clean · **migration ledger 51, unchanged — this leg carried no schema by design**. Visual gate **28/28 on the committed tree** (RUN A, load 3.58). Governing set: **Arch Prompt v30** · Strategy v14 · **Roadmap v4.2** + Ledger v1.0 (Aug-21 second append). Session Log at **9 entries**, rollover fires at 10. **Next:** the Arch migration → leg 1b → **R8-DRILL, overdue**.

## 🏗 Sprint Plan (RM-7: this table IS the trigger for NEXT-class work)

| Unit | Status | Ref |
|---|---|---|
| S4-1 decks-clear · S4-2 S4-AUTO | ✅ | Aug 10–11 · `1f06092` |
| MMM-CAT (category sub-band editable) | NEVER-RAN | re-issue fresh on scheduling |
| S4-3 legs 0–5 (box family) | ✅ | `6d52921` · `8461c2a`+`254ec1c` · `23a34d6` · `07150e6` |
| S4-3 leg 6 — three box PDFs + P5 (R-F) | ✅ | `8b078b2` |
| **VIS-CONFIRM — AMEND-3's confirming gate** | ✅ **28/28, R-AM DISCHARGED** | Aug 21, load 4.19, fresh server |
| **PORT-COV leg 1 — box EXPORT half** | ✅ | `a243867` |
| **ARCH-MIG-BOX — the migration (RPC box arms + `box_number` → TEXT)** | **NEXT** | Written, unapplied: `drafts/260821-1500_…`. Trigger B, Daniel's confirm, ledger 51→52 |
| **PORT-COV leg 1b — box IMPORT half** | **NEXT, after the migration** | Carries the §1.5 code pass, IMP-BOXCOL, natural sort |
| **PORT-COV leg 2 — cable side** | QUEUED | Net-new DDR extraction; WIRE-TYPE now ruled out of scope |
| HARNESS H1 · H2 · H4 | ✅ | `e55269c` · `ddcf929` · `13a8233` |
| DOOR + LANDING | ✅ | `e92f2c9` |
| S4-mid: D-2b + BASE-EVT (FOCUS-MP in headroom) | QUEUED | |
| S4-late: GS-C → LINE-STECK (+STECK-COLOR) → S3-G-2 (+UNFLAG-WARN) → ALLOC | QUEUED | deferred by the Aug-21 sequencing ruling, not dropped |
| S4-close: GBD | QUEUED | EXPORT's PORT-COV content moved forward and is shipping in legs |
| Sprint-4 close reviews: WF1A-SUNSET · auto-mode rider EXPIRES · COWORK-PORT · PRINT-REDO if Daniel opens it | QUEUED | |
| KKK-PASS (narrow-window responsive) | immediately after Sprint 4 | |
| **Pre-beta: SHARE build (build-prep DONE) → ADM-1 · AUTH-DOMAIN · 3TL · DEPS · CL-HILITE · GCM completion (R-AH)** | QUEUED | BATCH-PREBETA |
| **AC pass (BATCH-AC)** | **after private beta STARTS (R-AG)** | own trigger; not post-beta |
| Post-beta: BATCH-BOX · Maintenance · Spreadsheet Export · RF/Walkies/Circuits · IAS Import · real-time collab · licensing ~Nov · PWA | QUEUED | |

## 📌 Docket (RM-7: NEXT lives in the sprint table · DATED · EVENT · BATCH · ICEBOX. RM-8: one-line rows.)

### DATED — calendar-bound, mostly Daniel's desk

| ID | One line | When |
|---|---|---|
| R8-DRILL | Backup restore drill per R8 runbook; unblocks PORT-READY, feeds addendum §B retention number, gates account/project cleanup | **OVERDUE** — hard stop before September |
| BOX-REPRINT | v2's five box outputs printed at 100% against the arbiters — the only valid parity evidence for AMEND-1/2/3 | Daniel's desk |
| CAND-4 | Four personal texts to the named beta candidates; accounts stay live; invites post-terms | This week |
| HERO-PLURAL | `HERO_BID_TO_OPENING` in `src/app/page.tsx` goes plural | When Vape! Chicago opens |
| COMMS-REWRITE | R-W: Comms Prompt v9 deleted, rewritten from scratch | Before next Comms deliverable |
| LEGAL-SEP | September attorney engagement; addendum §F scope. **Note: any account minted by SHARE's admin-issued path joins §F's pre-terms set, so its count is not fixed** | September 2026 |
| COMMS-Q | October announcement to the v1 list, carrying the beta path | October |
| TOK-VC | Vercel token rotation | Private-beta start; hard ~Nov 8 |
| LIC-NOV | Licensing subsystem design (+ ownership transfer) | ~November |
| VERHIST | Durable version history | ~November |
| BRIEF-12 | Brief v1.2: terms-before-any-third-party-access · signup-state history · Communications section | Strat scheduling |
| GIT-CFG | git identity config · Next 16 `middleware`→`proxy` · two stray trees to delete | Housekeeping |

### EVENT — fires on a named condition

| ID | One line | Trigger |
|---|---|---|
| **GATE-THEMEGLYPH** | **NEW.** Δ42, 19-judged-px, light-only diff on the topbar theme-toggle glyph at `1273,14–1307,32` — distinct from the registered Δ1 wander at `1582,18`. **Intermittent, but capable of reproducing BYTE-IDENTICALLY across separate spawns**, which is why it twice looked diff-determined and twice was not. **NEVER register it in the diff-exception registry** — Δ42 is a real visual difference and DIFF-EXC-BOUND exists to prevent exactly that masking. Wants diagnosis, not tolerance | BATCH-HARNESS / H3 |
| **REPRO-SUSPECT** | **NEW inference rule, not an instance:** *a byte-identical reproduction is strong evidence but not proof of determinism; a single contrary run refutes it, and a single confirming run does not establish it.* Earned twice in one session, in both directions | Standing |
| **SENT-BUNDLE** | Daniel's ruling: derive the Contents column from `cable_details.labeled`, or drop it as a recorded divergence | Daniel's word |
| **BOX-TYPE-VOL** | **NEW.** `box_types.volume` is numeric while width/depth/height are text; a v1 Volume cell holding free text would not round-trip. Not observed in either corpus | Same class as BOX-NUM-TYPE |
| **BOX-LABEL-COUNTS** | **NEW.** `num_large_labels`/`num_small_labels` are NOT NULL ints in v2; a v1 blank imports as `0` and exports back as `0`, not blank | Rides leg 1b |
| **BOX-EXPORT-ORDER** | **NEW, recorded divergence.** v1's on-disk box row order is its found-set order and is not reconstructable; v2 exports by name comparator, deliberately choosing determinism over fidelity | Recorded, no action |
| **SHOP-ORDER-NOTES** | **NEW.** `Shop Order Notes` → `public_notes` is **corroborated, not ruled from a v1 statement**. If a v1 artifact contradicts it, it loses | On contrary evidence |
| **BUNDLE-FIND** | Bundle List registers no find surface | Rides the next bundle-touching unit |
| **SED-GUARD** | PreToolUse hard-block on bash-mediated writes to repo files. **The fence fired correctly on Aug 21 and is armed** | Next harness touch |
| **DEV-SERVER-AGE** | Harness should refuse, not warn, past a dev-server age trigger. **Note: the harness spawning its own server satisfies this by construction** | BATCH-HARNESS |
| **REPO-WEIGHT** | Evidence corpus size policy | Before it is urgent |
| DIFF-EXC-BOUND | Bound registry sites by area × maxPixels. **GATE-THEMEGLYPH is the first Δ42 candidate and was refused** | Triggered; bound owed before any Δ>1 site is admitted |
| METHOD-FIX · PRINT-REDO · PARITY-PAIR · GATE-PDF · GATE-OL25WR · GATE-C4 · S504 · CONCEPT-A · UNALLOC · EFFGRP · DOOR-V1LINK · CABLE-LOADER | unchanged from v4.1 | |
| RULINGS-WANTED | REV-STAMP · (ff) tab strip · (dddd) `#` headings · IMP-SORT · BAND-EDITOR sequencing · `no_box_needed` vs the yellow. **WIRE-TYPE removed — RULED** | Icebox sweeps |

### BATCH — the batch is scheduled; members inherit

| Batch | Members |
|---|---|
| **BATCH-HARNESS** (after the box import/export legs + SHARE, per R-V) | H3 (SUBPIXEL-WANDER) · **GATE-THEMEGLYPH** · GATE-COUNTWAIT · GATE-DLGRACE · GATE-FIXDIRTY · **GATE-LOADPROXY — two new supporting instances Aug 21: three different flakes admitted BELOW the 5.00 ceiling on fresh servers, and one refusal at 5.96 on a proxy the admitted runs show does not predict capture stability** · VIS-ENVFILE · DEV-SERVER-AGE |
| **BATCH-AC** (after private beta starts, R-AG) | unchanged from v4.1 |
| **BATCH-BOX** (post-private-beta) | unchanged from v4.1 |
| **BATCH-EXPORT** (now shipping in legs) | ~~PORT-COV leg 1 export~~ ✅ · **ARCH-MIG-BOX** · **leg 1b** · **leg 2 (cable)** · IMP-BOXCOL (rides 1b) · IMP-SPINE-2 ✅ closed · EXPORT-ORDER ✅ reconciled |
| **BATCH-PREBETA** | SHARE (**build-prep DONE**; REV-B delivered) · (ppp) settings header rides SHARE · ADM-1 · AUTH-DOMAIN · 3TL · DEPS · CL-HILITE · GCM completion |
| **BATCH-HOUSEKEEPING** | LINT · SRGRANT sweep · ST-RACE · CTF-SEED · SLOT-AUDIT residue · REPO-WEIGHT |

### ICEBOX — deliberately parked; swept at every sprint close

Unchanged from v4.1.

## ❓ Open Questions (live only)

- **Where is the BVSC NY v1 export?** The xlsx corpus holds only JOY (23 boxes, **zero nesting**) and BVSC Broadway (**zero boxes**). BVSC NY — 134 boxes, 22 nested — was seeded by another route and is not in `~/Minotaur_v1_exports/`. **The box import path will be built with no nested-box sample from any real v1 export.** A home-wide search was started and stopped; it is not in the corpus directory, but it may be on the machine.
- **What actually moves the theme-toggle glyph?** Two byte-identical failures and two passes on the same tree. The module-graph hypothesis is unproven and was not falsified — it was never tested.
- The own-truck vs resolve-up reading on box labels is unobservable by construction.
- `box_default_large_labels` 5 (OQ4 ruled) vs the v1 panel's `#Big Labels 2`.
- v1 continuation header · cover-page body size → PRINT-REDO.
- Script 551 extraction · cable Change All checkbox eligibility · house-wide Cancel semantics · Used∩Ignored · empty-string note · link `field_name` CHECK backstop · cable-type RENAME affordance · CL a-1 uploads · d2_01 red Members count · CL multi-letter-per-project · stale-category healing · CC credit-budget policy · OQ#2b own-band pendency · band-cascade harmonization.
- **Seat consolidation** — rule at or after COWORK-PORT.

---

*End of Roadmap v4.2 — August 21, 2026. **Retires Roadmap v4.1**. Unit of record: PORT-COV leg 1 at `a243867`; handoff `to-cc/260821-1145_port-cov-leg1-box-side.md`; returns `from-cc/260821-1114_*`, `260821-1325_*`, `260821-1347_*`, `260821-1408_*`, `260821-1417_*`. History: `Minotaur_v2_Ledger_v1_0.md`.*
