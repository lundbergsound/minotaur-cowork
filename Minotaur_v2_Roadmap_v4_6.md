# 🗺️ ROADMAP — Minotaur v2 (v4.6)

**Version 4.6 • August 24, 2026 • Forward-only file — history lives in `Minotaur_v2_Ledger_v1_0.md`**

## 🧭 Next Sessions (RM-6 — plain English, kept current)

- **THREE UNITS CLOSED IN ONE SESSION.** **2-MIG applied** — the cable RPC arms, migration ledger **52 → 54**. **2-IMP-a closed at `af04251`** — cable types and bundles now import, 26 files, and the export-side DEFTAILS-OVERBROAD defect closed with it. **FENCE-COMMITA closed at `9a140ca`** — the bulk-staging guard had a hole in it.
- **⚠ THE MIGRATION LEDGER IS 54, NOT 53.** 2-MIG needed a second migration: the new `export_mint_identity` overload is a NEW object, so Postgres gave it the default `EXECUTE` grant to **PUBLIC**, which the two pre-existing functions do not have. Caught by the post-apply privilege check, corrected the same session. **53** = `port_cov_leg2_2mig_cable_rpc_arms` · **54** = `port_cov_leg2_2mig_revoke_public_on_export_overload`.
- **NEXT IS 2-MIG-b, a migration, and it exists because 2-IMP-a found five gaps in 2-MIG's own arms.** All five are Arch's, all five need the RPC, and CC correctly refused to work around any of them. See the Sprint Plan.
- **THEN 2-IMP-b** (cables + lines + tails, 162 columns), then **2-IMP-c** (clone links by recompute).
- **PRINT-PARITY IS POSTPONED, by Daniel's ruling (Aug 24):** CC is devoted to the cable legs, and the parallel session resumes when CC is free. **Its worktree Open Question is CLOSED and the answer was NO WORKTREE** — same tree, the parallel session issues no CC handoffs until the main line's CC is idle, and commits once at the end. v4.5 stated the opposite; that is corrected here.
- **PRINT-PARITY's measured findings are carried even though the session is paused.** The July-11 cable print run is a **partial found set** — 794 of 1,119 cables, 27 of 44 groups — made by hand that day and **unreconstructable** from anything we hold (`Print List` now holds 7 rows, the Aug-20 state). **Those PDFs are valid geometry arbiters and invalid pixel-diff arbiters.** Fresh v1 prints with a stated found set are now owed by Daniel before mode 2 can run on the cable family.
- **Counts at `9a140ca`:** suite **2191 tests across 126 test files, ZERO skipped** · frozen **3/3 vs `be0769de`** · visual **28/28 @ 0.0000%**, every frame byte-clean at ch0 · typecheck 0 · dependency gate empty · build clean.
- **⚠ COUNT NOTATION (TESTCOUNT):** `2191/126` is **TESTS / TEST FILES**, never passing / skipped.
- **⚠ `npm run lint` CANNOT RUN, and could not at `9c41b37` either.** The script is `next lint`, a command current Next reads as a directory argument; **no eslint config is tracked at the base commit.** Any handoff naming a lint gate is naming an unsatisfiable gate. Registered under **LINT**.
- **CC-BASHWRITE IS CLOSED: harness-side.** Eliminated by measurement — not in `CLAUDE.md`, not in `.claude/settings*`, not in any hook, not in Daniel's user config (no user `CLAUDE.md`, hooks are two desktop notifiers, one unrelated plugin), not in his 1,017-line prompt history, not in his paste cache. **It recurred on the 2-IMP-a turn and CC declined it again**, which is the confirmation. The standing defence is restating SED-GUARD inline in every handoff §0.
- **A new standing rule, earned three times in one session — DOMAIN-NOT-CHECK:** *a measurement that answers a near-neighbour of the question is not an answer.* Three instances: a `conrelid` constraint query cannot see a **domain** · counting `tail` finds `detail` · `LIKE '%=X/postgres%'` matches `postgres=X/postgres`. Each was caught, but only because something else was measured afterwards.
- **Install path of record (Daniel, Aug 22):** the Arch seat writes close files to the mount **and** to claude.ai project knowledge. Daniel does not. Archives excluded.
- **Pre-open:** refs from ref files, never git · check for an orphaned `index.lock` · migration ledger **54** · Vercel READY at `9a140ca` (CC's pre-open probe confirmed READY at `9c41b37`; `af04251` and `9a140ca` build after). One untracked stray remains at `docs/reference/evidence/equipment/`.
- **Rollover:** clear. Session Log at 5 entries.
- **Bulk data (R-AL, standing):** never route rows through a model context. *The Aug-24 Ledger append was made on disk under this rule and byte-verified.*
- **Gate standing notes:** `npm run test:visual` does not run — use `node --env-file=.env.local scripts/visual-capture.mjs --gate` (VIS-ENVFILE). The harness spawns its own dev server (DEV-SERVER-AGE satisfied by construction). **`--force-load` forbidden** (GATE-LOAD-AUDIO). **GATE-THEMEGLYPH did not fire Aug 24.**
- **At Daniel's desk:** **R8-DRILL, OVERDUE — hard stop before September, SEVEN days** · **fresh v1 print runs with a stated found set** (new, gates PRINT-PARITY mode 2) · the CAND-4 texts · `HERO_BID_TO_OPENING` plural when Vape! Chicago opens · GIT-CFG strays · **PROJ-CLEAN-2** (~20 stale projects) · commit + push `Minotaur-Cowork`.

## Lineage (full change-log lives in the Ledger)

| Version | Date | Closed | Retires |
|---|---|---|---|
| **v4.6** | Aug 24 | **2-MIG APPLIED** (ledger 52→54, five riders) · **2-IMP-a closed at `af04251`** · **FENCE-COMMITA closed at `9a140ca`** · DEFTAILS-OVERBROAD · MIRROR-SYSMETHOD (b) · DIV-AMBIG-CLEAR · BOX-NOBOX · FENCE-HEADLINE · CC-BASHWRITE closed harness-side · **2-MIG-b opened with five gaps** · DOMAIN-NOT-CHECK registered · the worktree question closed NO | v4.5 |
| v4.5 | Aug 23 | PORT-COV leg 2 SCOPED (5 units) · 2-EXP closed at `9c41b37` · eight rulings · two dangle figures struck · OQ1: re-import is a product requirement | v4.4 |
| v4.4 | Aug 22 (evening) | MIRROR-SYSMETHOD + METHOD-DUP/CAT-DUP at `d39179a` · HISTID-UUID + FENCE-STALE at `41d1002` · the first complete BVSC NY mirror import · GATE-NEST-UPGRADE ruled | v4.3 |

## Current Status (August 24, 2026)

Live at `https://minotaur.app` at **`9a140ca`**, pushed (`9c41b37..af04251..9a140ca`). Migration ledger **54**. Counts: suite **2191 tests / 126 test files, zero skipped** · frozen **3/3 vs `be0769de`** · typecheck 0 · dependency gate empty · build clean · visual **28/28 @ 0.0000%**. Governing set: **Arch Prompt v31** · Strategy v14 · **Roadmap v4.6** (retiring v4.5) + Ledger v1.0 (Aug-24 append). Session Log at **5 entries, rollover clear.** **Next:** 2-MIG-b → 2-IMP-b → 2-IMP-c, then PRINT-PARITY resumes → **R8-DRILL, overdue, seven days**.

## 🏗 Sprint Plan (RM-7)

| Unit | Status | Ref |
|---|---|---|
| S4-1 decks-clear · S4-2 S4-AUTO | ✅ | Aug 10–11 · `1f06092` |
| MMM-CAT (category sub-band editable) | NEVER-RAN | re-issue fresh on scheduling |
| S4-3 legs 0–6 (box family) | ✅ | `8b078b2` |
| PORT-COV leg 1 — box EXPORT half | ✅ | `a243867` |
| ARCH-MIG-BOX — the migration | ✅ | ledger 52, rehearsal-first |
| PORT-COV leg 1b — box IMPORT half | ✅ | `4c234dd` |
| MIRROR-SYSMETHOD + METHOD-DUP / CAT-DUP | ✅ | `d39179a` |
| HISTID-UUID + FENCE-STALE | ✅ | `41d1002` |
| PORT-COV leg 2 — 2-EXP, the cable EXPORT half | ✅ | `9c41b37` · 281 columns sha256-pinned |
| **PORT-COV leg 2 — 2-MIG, the RPC arms** | ✅ **APPLIED** | **ledger 53 + 54**, rehearsal-first with forced rollback · five riders landed |
| **PORT-COV leg 2 — 2-IMP-a (types + bundles)** | ✅ **CLOSED** | `af04251` · 26 files · round-trip 100% on all three shows |
| **FENCE-COMMITA — the bulk-staging guard** | ✅ **CLOSED** | `9a140ca` · a false NEGATIVE, open since the fence was written |
| **PORT-COV leg 2 — 2-MIG-b, the gap migration** | **NEXT (main line)** | **MIGRATION.** Five items, all Arch's, all found by 2-IMP-a. Trigger B |
| PORT-COV leg 2 — 2-IMP-b (cables + lines + tails) | QUEUED | 162 columns; widens `MIRROR_SCOPED_TYPE`; carries LEN-INPUT-SUFFIX, R-3's dialog, JOY-NAME-HYGIENE, DEFTAILS-METHOD-CREATE, and the two remaining `cable_color` domain columns |
| PORT-COV leg 2 — 2-IMP-c (clone links, by recompute) | QUEUED | carries CLONE-TOKEN and the `mult_line` link vocabulary |
| **PRINT-PARITY — v1↔v2 print and preview parity** | **POSTPONED** (Daniel, Aug 24) | Resumes when CC is free. Wants GATE-PDF first. **Fresh v1 prints owed** |
| HARNESS H1 · H2 · H4 | ✅ | `e55269c` · `ddcf929` · `13a8233` |
| DOOR + LANDING | ✅ | `e92f2c9` |
| S4-mid: D-2b + BASE-EVT (FOCUS-MP in headroom) | QUEUED | |
| S4-late: GS-C → LINE-STECK (+STECK-COLOR) → S3-G-2 (+UNFLAG-WARN) → ALLOC | QUEUED | deferred by the Aug-21 sequencing ruling |
| S4-close: GBD | QUEUED | |
| Sprint-4 close reviews: WF1A-SUNSET · auto-mode rider EXPIRES · COWORK-PORT · PRINT-REDO if opened | QUEUED | |
| KKK-PASS (narrow-window responsive) | after Sprint 4 | |
| **Pre-beta: SHARE build → ADM-1 · AUTH-DOMAIN · 3TL · DEPS · CL-HILITE · GCM (R-AH)** | QUEUED | BATCH-PREBETA |
| **AC pass (BATCH-AC)** | after private beta STARTS (R-AG) | own trigger |
| Post-beta: BATCH-BOX · Maintenance · Spreadsheet Export · **RF/Walkies/Circuits (BVSC-RF)** · IAS Import · real-time collab · licensing ~Nov · PWA | QUEUED | |

## 📌 Docket

### DATED

| ID | One line | When |
|---|---|---|
| R8-DRILL | Backup restore drill per R8 runbook; unblocks PORT-READY, feeds addendum §B, gates account/project cleanup | **OVERDUE** — hard stop before September (7 days) |
| **PRINT-FOUNDSET** | **NEW.** Fresh v1 print runs with a **stated found set**, print-to-PDF at 100%. The July-11 run is 794 of 1,119 cables and cannot be reconstructed | Before PRINT-PARITY mode 2 |
| CAND-4 | Four personal texts to the named beta candidates | This week |
| HERO-PLURAL | `HERO_BID_TO_OPENING` goes plural | When Vape! Chicago opens |
| COMMS-REWRITE | R-W: Comms Prompt v9 deleted, rewritten from scratch | Before next Comms deliverable |
| LEGAL-SEP | September attorney engagement; addendum §F scope | September 2026 |
| COMMS-Q | October announcement to the v1 list | October |
| TOK-VC | Vercel token rotation | Private-beta start; hard ~Nov 8 |
| LIC-NOV · VERHIST | Licensing subsystem (+ ownership transfer) · durable version history | ~November |
| BRIEF-12 | Brief v1.2: terms-before-third-party-access · signup-state history · Communications section | Strat scheduling |
| GIT-CFG | git identity · Next 16 `middleware`→`proxy` · stray trees · `Minotaur_v1_exports/BVSC_NY/_to_delete/` · the two `ORPHANED-index.lock.*` files in `Minotaur/.git/` | Housekeeping |
| PROJ-CLEAN-2 | The test user's dashboard carries **~20** projects, most of them `Amend2`/`FIX1`/`S3G-2` leftovers | Daniel's desk |

### EVENT

| ID | One line | Trigger |
|---|---|---|
| **PORT-COV-REIMPORT** | A v1 re-import path is a product requirement (Daniel, Aug 23): *if something doesn't work in v2, the user reverts to v1 immediately.* Acceptance is round-trip, not column order. **2-IMP-a met it: 100% on all three shows, every mapped column** | Standing, binds every export unit |
| **BRANCH-NO-ARM** | **NEW, and it is the reason 2-MIG-b exists.** `cable_types.branch_cable_type_id` is real, the export already emits it as `def ends.Branch Cable Type`, and `import_apply_v1`'s `cable_types` INSERT names 21 columns without it — with no name second-pass either. A `branch_cable_type_name` key would be **silently ignored**, so CC refused the column rather than pretend. Cost measured: **32/50 · 40/56 · 32/48** rows lose it every round trip | **Rides 2-MIG-b** |
| **DOMAIN-COLOR-BARE** | **NEW, Arch's error.** Four base-table columns sit on the `cable_color` DOMAIN — `bundles.flagged_end_color`, `bundles.not_flagged_end_color`, `cable_details.color`, `cable_mult_lines.line_color` — and `import_apply_v1` writes **all four bare**, with no `nullif(trim(…),'')`. A domain is not a CHECK and was invisible to the `conrelid` query that produced the handoff's "every one is protected" claim. **Live, not theoretical:** BVSC NY's bundles carry `""` twice in both colour columns, which the domain rejects. 2-IMP-a's mapper guards its two; the cable pair is still exposed | **Rides 2-MIG-b**; the cable half also binds 2-IMP-b |
| **MATCHED-BUNDLE-ID** | **NEW.** The RPC's `identity.matchedV2Ids` `last_seen_run_id` refresh is still `entity_table = 'equipment_items'`-only, so a matched bundle's row is never refreshed. Bookkeeping, not data; the plan already sends the ids | Rides 2-MIG-b |
| **BUNDLE-BOX-ONINSERT** | **NEW.** CABLE-ARM (i) reads `ops.bundles.inserts` only, so an existing bundle cannot be re-boxed by a re-import — the analogue of leg 1b's `nestingSkippedOnUpdate`. Reported in the UI as "Box not re-applied (25)" | Rides 2-MIG-b |
| **BUNDLE-RENAME** | **NEW.** The RPC's `bundles` UPDATE does not write `bundle_name`, so a v1-side rename is described by the plan and never applied. Reported as "Renames not applied" | Rides 2-MIG-b |
| **DEFTAILS-METHOD-CREATE** | **RULED Aug 24.** `def tails.Method` **DOES** join `createMissing`, matching leg 1b's precedent for box Category/Method. Inert on every corpus we hold — all values are `"0"`, present in `methods.xlsx` on all three shows — so it did not reopen the 2-IMP-a commit | **Rides 2-IMP-b** |
| **LINT** | **DIAGNOSED, not just named.** `npm run lint` is `next lint`, which current Next reads as a directory argument, and **no eslint config is tracked at `9c41b37`**. The gate is unsatisfiable by any session; adding a config is a dependency-and-tooling change | BATCH-HOUSEKEEPING |
| **CLONE-FLAG-DIVERGE** | **OPEN QUESTION, unproven.** Recompute reproduces v1's `Has Clones` on 19 of 23 cable fields; the four Source/Destination Device and Connection columns over-assert, recomputed set a **strict subset**. The patch-relationship hypothesis is **not established and must not enter a handoff as a fact** | Diagnosis unscheduled |
| **CLONE-TOKEN** | **RULED Aug 23.** Synthesise the `Link X` token deterministically from the link group's id | Rides 2-IMP-c |
| **LEN-INPUT-SUFFIX** | `parseLengthInput()` strips and **discards** a typed `m`/`'`, so `150m` on an imperial show silently commits 150 **feet**. Contrary to R-4 | **Rides 2-IMP-b** |
| **METRIC-UNRUN** | All 27 live projects are `imperial`. The per-row metric path exists end to end and **has never met real data**. *2-IMP-a note: `Bundle Length` is a NUMBER cell on every row of all three corpora, so the suffix branches meet no corpus data there either* | 2-IMP-b's browser gate, both directions |
| **CABLE-ORPHAN** | 17 JOY child rows name three cables that exist under no normalisation. **R-3: the 12 lines are dropped behind a pre-apply dialog; the 5 tails import with a blank Mult** | Rides 2-IMP-b |
| **LINK-ORPHAN** | `link_group_members.item_id` has no FK and is **100% orphaned live** — 210 members, 0 resolving. *2-MIG now defends it at WRITE: the arm refuses a membership whose item does not exist* | BATCH-BOX or 2-IMP-c |
| **CABLE-HISTID** | 13 non-UUID HistoryIDs across `cable`, `tails` and `cable clone links`; the clone-link values are the **same literals** as the cable ones | Rides 2-IMP-b |
| **HISTENTRY-NOTID** | `History Entry ID` is 100% non-UUID and **not unique** (279 distinct over 1,084). A timestamp despite the name. Never map it to an id column | Standing caution |
| **CABLE-AUDIT-TIME** | `_Create Time` / `_Modify Time` are real Excel **datetime** cells at second resolution. v2 has a source for every sheet that needs one. `*Person` has no v2 counterpart | Next export touch |
| **EXPRPT-STALE** | The export report lists **4 filenames of 14**, hardcoded at `settings/page.tsx:478`; `boxes` and `box types` invisible since leg 1. Its at-rest hint text sits inside gate frame 06 | Its own small pass |
| **LINES-NOFK** | `lines.sourceID` / `destinationID` are 0-populated in all three corpora; the DDR confirms no relationship joins on them. The name-key tax is structural | Standing |
| **JOY-NAME-HYGIENE** | JOY carries 29 blank `cable.Name` rows and 40 with leading/trailing whitespace. **Trimming on import would create collisions beyond the 61 measured** | Rides 2-IMP-b |
| **LEN-SCALE** | `cable_details.length_value` 853 rows at scale 1 vs 7 at scale 0; `bundles.length_value` 97 vs 2. Invisible while the column stays numeric | Next cable write touch |
| **BOX-REPARENT** · **IMPRPT-COPY** · **BUILDSHEET-CMT** · **BOX-NAME-UNIQ** · **BOX-TYPES-DIM-DROP** · **BOX-ALPHA-UNSAMPLED** · **BVSC-RF** · **EQUIP-LABELS-2** · **HISTID-HASH-COST** · **SMOKE-LOGIN-HYDRATION** | unchanged from v4.5 | |
| **GATE-THEMEGLYPH** | Δ42 light-only diff on the topbar theme-toggle glyph. **NEVER register it.** Did not fire Aug 24 | BATCH-HARNESS / H3 |
| **GATE-LOAD-AUDIO** · **REPRO-SUSPECT** · **SENT-BUNDLE** | unchanged from v4.5 | |
| **GATE-PDF** | No print-parity measurement instrument exists. PRINT-PARITY needs PDF→raster→diff at fixed DPI with a per-page offset report. *A prototype extractor `pdfgeom.py` exists from the paused parallel session* | **PRINT-PARITY's first build** |
| **BOX-TYPE-VOL** · **BOX-LABEL-COUNTS** · **BOX-EXPORT-ORDER** · **SHOP-ORDER-NOTES** · **BUNDLE-FIND** · **SED-GUARD** · **DEV-SERVER-AGE** · **REPO-WEIGHT** | unchanged from v4.5 | |
| DIFF-EXC-BOUND | Bound registry sites by area × maxPixels | Bound owed before any Δ>1 site |
| METHOD-FIX · PRINT-REDO · PARITY-PAIR · GATE-OL25WR · GATE-C4 · S504 · CONCEPT-A · UNALLOC · EFFGRP · DOOR-V1LINK · CABLE-LOADER | unchanged from v4.5 — **PRINT-REDO and PARITY-PAIR fold into PRINT-PARITY** | |
| RULINGS-WANTED | REV-STAMP · (ff) tab strip · (dddd) `#` headings · IMP-SORT · BAND-EDITOR sequencing · `no_box_needed` vs the yellow | Icebox sweeps |

### CLOSED THIS SESSION

**CC-BASHWRITE** (harness-side, confirmed by recurrence) · **DEFTAILS-OVERBROAD** (63→12, reproduced on all three corpora) · **MIRROR-SYSMETHOD (b)** · **DIV-AMBIG-CLEAR** · **BOX-NOBOX** · **CABLE-IDENTITY-GAP** (both sides; the export overload is additive, the 1-arg original untouched) · **FENCE-HEADLINE** (earned itself on the first try — the fence now reads "the commit whose subject names this unit") · **FENCE-COMMITA** · **CABLE-GUARD-GONE** (retired for three sheets, inverted for the other five).

### BATCH

| Batch | Members |
|---|---|
| **BATCH-HARNESS** | H3 · GATE-THEMEGLYPH · GATE-COUNTWAIT · GATE-DLGRACE · GATE-FIXDIRTY · GATE-LOADPROXY · VIS-ENVFILE · DEV-SERVER-AGE · GATE-LOAD-AUDIO · **GATE-PDF (promoted out, to PRINT-PARITY)** |
| **BATCH-AC** (after private beta starts, R-AG) | unchanged from v4.5 |
| **BATCH-BOX** (post-private-beta) | unchanged · BOX-NAME-UNIQ · BOX-REPARENT · **LINK-ORPHAN** |
| **BATCH-EXPORT** | ~~leg 1~~ ✅ · ~~ARCH-MIG-BOX~~ ✅ · ~~leg 1b~~ ✅ · ~~MIRROR-SYSMETHOD~~ ✅ · ~~HISTID-UUID~~ ✅ · ~~**2-EXP**~~ ✅ · ~~**2-MIG**~~ ✅ · ~~**2-IMP-a**~~ ✅ · **2-MIG-b** · **2-IMP-b** · **2-IMP-c** |
| **BATCH-PREBETA** | SHARE (build-prep DONE) · (ppp) settings header · ADM-1 · AUTH-DOMAIN · 3TL · DEPS · CL-HILITE · GCM · **EXPRPT-STALE** |
| **BATCH-HOUSEKEEPING** | **LINT (now diagnosed)** · SRGRANT sweep · ST-RACE · CTF-SEED · SLOT-AUDIT residue · REPO-WEIGHT · BOX-TYPES-DIM-DROP · PROJ-CLEAN-2 · ~~FENCE-HEADLINE~~ ✅ |

### ICEBOX

Unchanged from v4.5.

## ❓ Open Questions (live only)

- **What actually drives the four over-asserting clone flags?** (CLONE-FLAG-DIVERGE.) The patch-relationship reading is a hypothesis and is unproven.
- **Do the 39 boxes whose types BOX-TYPE-LIB created want dimensions?** Not blocking.
- **Does the operator need the report to say a system row was protected?** Not blocking.
- **Should the HISTID-HASH-COST wording be sharpened?**
- **What actually moves the theme-toggle glyph?** Unproven; never tested.
- **PRINT-PARITY's four, inherited and paused:** what stock does each label output print on (Q-P1) · which output prompted "funhouse" (Q-P2) · Big Cable Labels' rotated side text, Behavioral §9.8 vs Print Artifacts §B2 (Q-P3) · Bundle Sheet's Arial Bold 48, the only non-Century-Gothic display type (Q-P4).
- The own-truck vs resolve-up reading on box labels is unobservable by construction.
- `box_default_large_labels` 5 (OQ4 ruled) vs the v1 panel's `#Big Labels 2`.
- v1 continuation header · cover-page body size → **PRINT-PARITY**.
- Script 551 extraction · cable Change All checkbox eligibility · house-wide Cancel semantics · Used∩Ignored · empty-string note · link `field_name` CHECK backstop · cable-type RENAME affordance · CL a-1 uploads · d2_01 red Members count · CL multi-letter-per-project · stale-category healing · CC credit-budget policy · OQ#2b own-band pendency · band-cascade harmonization.

**CLOSED this session:** ~~Does the PRINT-PARITY session's CC run get its own git worktree?~~ **NO** — same tree, no CC handoffs until the main line's CC is idle, one commit at the end (Daniel, Aug 24). ~~Where did CC's bash-write instruction come from?~~ **The harness.**

---

*End of Roadmap v4.6 — August 24, 2026. **Retires Roadmap v4.5**. Units of record: PORT-COV leg 2 **2-MIG** (migration ledger 52→54), **2-IMP-a** (`9c41b37..af04251`, 26 files), **FENCE-COMMITA** (`af04251..9a140ca`). Suite 2089 → 2191 tests across 124 → 126 files. Handoff `to-cc/260824-2218_portcov-leg2-imp-a.md`; return `from-cc/260824-1905_portcov-leg2-imp-a.md`. Migration package of record: `drafts/260823_2-MIG_assembled_APPLIED.sql`. Scope of record: `drafts/260823_portcov_leg2_scope.md`. History: `Minotaur_v2_Ledger_v1_0.md`.*
