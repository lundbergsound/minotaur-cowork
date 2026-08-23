# 🗺️ ROADMAP — Minotaur v2 (v4.5)

**Version 4.5 • August 23, 2026 • Forward-only file — history lives in `Minotaur_v2_Ledger_v1_0.md`**

## 🧭 Next Sessions (RM-6 — plain English, kept current)

- **PORT-COV LEG 2 IS SCOPED FROM MEASUREMENT, AND UNIT 2-EXP IS CLOSED at `9c41b37`.** v2 now writes **eight v1-compatible cable sheets** — `cable` · `lines` · `tails` · `bundles` · `def ends` · `def tails`, plus both clone-link sheets pinned but emitting zero rows. 13 files, +2437/−45. **281 columns sha256-pinned to the real corpus headers**, proven before a line went into the repo.
- **TWO SESSIONS OPEN IN PARALLEL NEXT (Daniel, Aug 23).** The **MAIN LINE** takes **2-MIG**, the cable RPC arms — a migration, so Trigger B and Daniel's explicit confirm. A **PARALLEL session** takes **PRINT-PARITY**, the v1↔v2 print and preview parity pass. Openers: `handoffs/260823-2130_next_session_opener.md` · `handoffs/parallel/260823-2130_print-parity-opener.md`.
- **⚠ PRINT-PARITY breaks two standing rules as briefed, and both resolutions are in its opener.** A parallel session normally issues **no CC handoffs** (the one-writer rule), and CC's hard-stop list is normally non-negotiable while Daniel wants an 8-hour run that logs blockers instead of halting. **Resolutions: the parallel session's CC runs in its own git worktree on its own branch, and the three safety hard-stops stay while "ambiguous evidence" becomes log-and-skip.** Daniel's confirm is owed on the worktree.
- **The cable side cannot be one unit.** `cable.xlsx` carries **97 columns** against equipment's 53 and boxes' 36; the eight sheets carry **281 columns and 5,332 rows** across three shows. Five units: **2-EXP ✅ · 2-MIG · 2-IMP-a · 2-IMP-b · 2-IMP-c**.
- **The measurement of record is `drafts/260823_portcov_leg2_scope.md`** — constraints, cascades, the RLS finding, the fingerprint mechanism, the corpus counts. **Every remaining leg reads it instead of re-measuring.**
- **Daniel's re-import ruling changed the shape of the export half.** *"We need a re-import path for user confidence — if something doesn't work in v2, they need the ability to immediately revert to v1."* The export is a round-trip, not an archive. Clone-link tokens become required content; **ruled: synthesise the token, derived deterministically from the link group's id.** Two families cannot go back and are recorded divergences — patch linkage (R7-6) and `Link Mult`/`Link Line` (needs `mult_line` groups; closable by 2-IMP-c).
- **Counts at `9c41b37`:** suite **2089 tests across 124 test files, ZERO skipped** · frozen **3/3 vs `be0769de`** · visual **28/28 @ 0.0000%**, zero frames moved · migration ledger **52**, unchanged.
- **⚠ COUNT NOTATION (TESTCOUNT):** `2089/124` is **TESTS / TEST FILES**, never passing / skipped.
- **A new standing rule, earned twice in one session:** *a join measured between two columns that share a header is not evidence the source system makes that join.* Two dangle figures — 689 rows and 1,224 rows — were struck by re-measurement before they reached CC.
- **PDF evidence-class rule, restated because PRINT-PARITY depends on it:** all v1↔v2 output-parity evidence is **print-to-PDF at 100% scale, matching paper size and orientation on both sides.** Screenshots are valid for **on-screen UX anatomy only**. A screenshot of printed output is not parity evidence.
- **Install path of record (Daniel, Aug 22):** the Arch seat writes close files to the mount **and** to claude.ai project knowledge. Daniel does not. Archives excluded.
- **Pre-open:** refs from ref files, never git · check for an orphaned `index.lock` · migration ledger **52** · Vercel READY at `9c41b37`. One untracked stray remains at `docs/reference/evidence/equipment/`.
- **Rollover:** clear. Session Log at 4 entries.
- **Bulk data (R-AL, standing):** never route rows through a model context. *The Aug-23 Ledger append and Session Log rewrite were both made on disk under this rule and byte-verified.*
- **Gate standing notes:** `npm run test:visual` does not run — use `node --env-file=.env.local scripts/visual-capture.mjs --gate` (VIS-ENVFILE). The harness spawns its own dev server (DEV-SERVER-AGE satisfied by construction). **`--force-load` forbidden** (GATE-LOAD-AUDIO). **GATE-THEMEGLYPH did not fire Aug 23.** **GATE-NEST-UPGRADE applied** — and earned a *third* observation at its registered coordinate in the same session's final gate, vindicating the ruling independently.
- **At Daniel's desk:** **R8-DRILL, OVERDUE — hard stop before September, eight days** · **BOX-REPRINT** (now subsumed by PRINT-PARITY) · the CAND-4 texts · `HERO_BID_TO_OPENING` plural when Vape! Chicago opens · GIT-CFG strays · **PROJ-CLEAN-2** (~20 stale projects) · commit + push `Minotaur-Cowork`.

## Lineage (full change-log lives in the Ledger)

| Version | Date | Closed | Retires |
|---|---|---|---|
| **v4.5** | Aug 23 | **PORT-COV leg 2 SCOPED** (5 units, from measurement) · **2-EXP closed at `9c41b37`** · eight rulings, two Daniel's and both amended · two dangle figures struck by re-measurement · the clone-link sheets found to contain no data · **OQ1: re-import is a product requirement** · fifteen items registered · Arch correction 33 | v4.4 |
| v4.4 | Aug 22 (evening) | MIRROR-SYSMETHOD + METHOD-DUP/CAT-DUP at `d39179a` · HISTID-UUID + FENCE-STALE at `41d1002` · the first complete BVSC NY mirror import · rollover at pre-open · GATE-NEST-UPGRADE ruled | v4.3 |
| v4.3 | Aug 22 | ARCH-MIG-BOX applied (ledger 52) · PORT-COV leg 1b at `4c234dd` · BVSC NY landed · Arch Prompt v31 | v4.2 |

## Current Status (August 23, 2026)

Live at `https://minotaur.app` at **`9c41b37`**, pushed (`41d1002..9c41b37`). Migration ledger **52**, unchanged this session — 2-EXP needed none by design. Counts: suite **2089 tests / 124 test files, zero skipped** · frozen **3/3 vs `be0769de`** · typecheck 0 · dependency gate empty · build clean · visual **28/28 @ 0.0000%**, zero frames moved. Governing set: **Arch Prompt v31** · Strategy v14 · **Roadmap v4.5** (retiring v4.4) + Ledger v1.0 (Aug-23 append). Session Log at **4 entries, rollover clear.** **Next:** 2-MIG and PRINT-PARITY in parallel → **R8-DRILL, overdue**.

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
| **PORT-COV leg 2 — 2-EXP, the cable EXPORT half** | ✅ **CLOSED** | `9c41b37` · 13 files · 281 columns sha256-pinned |
| **PORT-COV leg 2 — 2-MIG, the RPC arms** | **NEXT (main line)** | **MIGRATION.** Carries MIRROR-SYSMETHOD (b) · DIV-AMBIG-CLEAR · CABLE-IDENTITY-GAP · BOX-NOBOX if ruled in. Trigger B |
| **PRINT-PARITY — v1↔v2 print and preview parity** | **NEXT (parallel)** | Net-new. Subsumes BOX-REPRINT; wants GATE-PDF built FIRST |
| PORT-COV leg 2 — 2-IMP-a (types + bundles) | QUEUED | carries DEFTAILS-OVERBROAD |
| PORT-COV leg 2 — 2-IMP-b (cables + lines + tails) | QUEUED | 162 columns; widens `MIRROR_SCOPED_TYPE`; carries LEN-INPUT-SUFFIX and R-3's dialog |
| PORT-COV leg 2 — 2-IMP-c (clone links, by recompute) | QUEUED | carries the `mult_line` link vocabulary |
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
| R8-DRILL | Backup restore drill per R8 runbook; unblocks PORT-READY, feeds addendum §B, gates account/project cleanup | **OVERDUE** — hard stop before September (8 days) |
| BOX-REPRINT | v2's five box outputs printed at 100% against the arbiters | **Subsumed by PRINT-PARITY** |
| CAND-4 | Four personal texts to the named beta candidates | This week |
| HERO-PLURAL | `HERO_BID_TO_OPENING` goes plural | When Vape! Chicago opens |
| COMMS-REWRITE | R-W: Comms Prompt v9 deleted, rewritten from scratch | Before next Comms deliverable |
| LEGAL-SEP | September attorney engagement; addendum §F scope | September 2026 |
| COMMS-Q | October announcement to the v1 list | October |
| TOK-VC | Vercel token rotation | Private-beta start; hard ~Nov 8 |
| LIC-NOV · VERHIST | Licensing subsystem (+ ownership transfer) · durable version history | ~November |
| BRIEF-12 | Brief v1.2: terms-before-third-party-access · signup-state history · Communications section | Strat scheduling |
| GIT-CFG | git identity · Next 16 `middleware`→`proxy` · stray trees · `Minotaur_v1_exports/BVSC_NY/_to_delete/` | Housekeeping |
| PROJ-CLEAN-2 | The test user's dashboard carries **~20** projects, most of them `Amend2`/`FIX1`/`S3G-2` leftovers | Daniel's desk |

### EVENT

| ID | One line | Trigger |
|---|---|---|
| **PORT-COV-REIMPORT** | **NEW — the ruling that reframes the export half (Daniel, Aug 23).** A v1 re-import path is a product requirement: *if something doesn't work in v2, the user reverts to v1 immediately.* The export is a round-trip, not an archive. Acceptance moves from column-order to round-trip | Standing, binds every export unit |
| **CLONE-TOKEN** | **RULED Aug 23.** Synthesise the `Link X` token, derived **deterministically from the link group's id** — v2 never stored v1's original and v1's own token is arbitrary, load-bearing only in being *shared*. Determinism means two exports of unchanged data produce identical files | Rides 2-IMP-c |
| **CLONE-FLAG-DIVERGE** | **OPEN QUESTION, unproven.** Recomputing groups from shared values reproduces v1's `Has Clones` on 19 of 23 cable fields. The four Source/Destination Device and Connection columns over-assert, with the recomputed set a **strict subset** — recompute never invents a link. The patch-relationship hypothesis is **not established and must not enter a handoff as a fact** | Diagnosis unscheduled |
| **CABLE-IDENTITY-GAP** | **NEW.** `export_mint_identity` mints for `equipment_items` ONLY (verified live). `bundles` and `cable_mult_lines` are their own tables and emit a blank HistoryID. Extending it is a **migration** | **Rides 2-MIG** |
| **DEFTAILS-OVERBROAD** | **NEW — found by Daniel's browser gate.** v2 emits **63** `def tails` rows where v1's file for the same show has **12**; 51 carry both tail-model columns blank. Filtering on a present source or destination tail model leaves **exactly 12** — the corpus supplies the acceptance number. Inert as an archive; a defect under PORT-COV-REIMPORT | **Rides 2-IMP-a** |
| **LEN-INPUT-SUFFIX** | **NEW.** `parseLengthInput()` strips and **discards** a typed `m`/`'`, so `150m` typed on an imperial show silently commits 150 **feet**. Directly contrary to R-4's requirement | **Rides 2-IMP-b** |
| **METRIC-UNRUN** | **NEW.** All 27 live projects are `imperial`. The per-row metric path exists through storage, view, display, sort and weight rollup and **has never met real data** | 2-IMP-b's browser gate, both directions |
| **CABLE-ORPHAN** | **NEW.** 17 JOY child rows name three cables that exist under no normalisation (exact / trim / case / whitespace all measured at 0 effect). **R-3: the 12 lines are dropped behind a pre-apply dialog; the 5 tails import with a blank Mult.** `cable_mult_lines.cable_id` is NOT NULL, which is why there is no third option | Rides 2-IMP-b |
| **LINK-ORPHAN** | **NEW.** `link_group_members.item_id` has no FK and is **100% orphaned live** — 210 members, 0 resolving against any candidate table. Defended at read (`CableListClient.tsx:685-688`); a mirror re-import orphans memberships permanently | BATCH-BOX or 2-IMP-c |
| **CABLE-HISTID** | **NEW.** 13 non-UUID HistoryIDs across `cable`, `tails` and `cable clone links` — the clone-link values are the **same literals** as the cable ones. `resolveHistoryId` is module-private and `SheetName`-typed; both need widening | Rides 2-IMP-b |
| **HISTENTRY-NOTID** | **NEW.** `History Entry ID` is 100% non-UUID in all three corpora and **not unique** (279 distinct over 1,084 values). A timestamp despite the name. Never map it to an id column | Standing caution |
| **CABLE-AUDIT-TIME** | **NEW, measured so nobody re-measures.** `_Create Time` / `_Modify Time` are real Excel **datetime** cells, `mm/dd/yyyy hh:mm:ss`, second resolution. v2 has a source for every sheet that needs one (`created_at`/`updated_at` on the spine, bundles, mult lines, cable types). `*Person` has no v2 counterpart | Next export touch |
| **EXPRPT-STALE** | **NEW.** The export report lists **4 filenames of 14**, hardcoded at `settings/page.tsx:478`; `boxes` and `box types` have been invisible **since leg 1**. Its at-rest hint text sits inside gate frame 06, so it moves a frame | Its own small pass |
| **FENCE-HEADLINE** | **NEW — structural.** The run fence's `HEAD is <hash>` line **can never be correct when written**: the hash does not exist until after the commit. FENCE-STALE fixed the content and left the mechanism. **Ruled: replace the hash with "the commit whose subject names this unit"** | Next `CLAUDE.md` touch |
| **CC-BASHWRITE** | **NEW, origin unestablished.** CC's 2-EXP return records that the turn arrived with an instruction to perform file **writes** via Bash (`cat`, `sed`, heredocs) and that it declined, on the Sed Disclosure Rule's own reason — a bash write bypasses the PostToolUse frozen-check hook. **That instruction is not in the Arch handoff.** Where it came from is open | Next session, before any CC handoff |
| **LINES-NOFK** | `lines.sourceID` / `destinationID` exist in v1 and are 0-populated in all three corpora; the DDR confirms no relationship joins on them. The name-key tax is structural | Standing |
| **JOY-NAME-HYGIENE** | JOY carries 29 blank `cable.Name` rows and 40 with leading/trailing whitespace. **Trimming on import would create additional collisions beyond the 61 measured** — the importer must not trim without a ruling | Rides 2-IMP-b |
| **LEN-SCALE** | `cable_details.length_value` 853 rows at scale 1 against 7 at scale 0; `bundles.length_value` 97 against 2. Invisible while the column stays numeric — re-verify the PostgREST serialisation claim at build | Next cable write touch |
| **MIRROR-SYSMETHOD (b)** | **RULED, UNIMPLEMENTED.** The RPC-side `and not is_system` on the methods delete | **Rides 2-MIG** |
| **BOX-NOBOX** | **RULED Aug 22, unimplemented.** `Box = "0"` → `equipment_items.no_box_needed`. Needs an RPC arm, plan work, and a `CLAUDE.md` addition at line 817 | **2-MIG, if ruled in** |
| **BOX-REPARENT** · **DIV-AMBIG-CLEAR** · **IMPRPT-COPY** · **BUILDSHEET-CMT** · **BOX-NAME-UNIQ** · **BOX-TYPES-DIM-DROP** · **BOX-ALPHA-UNSAMPLED** · **BVSC-RF** · **EQUIP-LABELS-2** · **HISTID-HASH-COST** · **SMOKE-LOGIN-HYDRATION** | unchanged from v4.4 | |
| **GATE-NEST-UPGRADE** | **APPLIED Aug 23** at `9c41b37`, and earned a **third** observation at its registered coordinate in the same session's final gate | Closed |
| **GATE-THEMEGLYPH** | Δ42 light-only diff on the topbar theme-toggle glyph. **NEVER register it.** Did not fire Aug 23 | BATCH-HARNESS / H3 |
| **GATE-LOAD-AUDIO** · **REPRO-SUSPECT** · **SENT-BUNDLE** | unchanged from v4.4 | |
| **GATE-PDF** | **PROMOTED.** No print-parity measurement instrument exists. PRINT-PARITY cannot converge on "looks closer" — it needs PDF→raster→diff at fixed DPI with a per-page offset report | **PRINT-PARITY's first build** |
| **BOX-TYPE-VOL** · **BOX-LABEL-COUNTS** · **BOX-EXPORT-ORDER** · **SHOP-ORDER-NOTES** · **BUNDLE-FIND** · **SED-GUARD** · **DEV-SERVER-AGE** · **REPO-WEIGHT** | unchanged from v4.4 | |
| DIFF-EXC-BOUND | Bound registry sites by area × maxPixels. Trigger remains the first site registered above maxChannelDelta 1 | Bound owed before any Δ>1 site |
| METHOD-FIX · PRINT-REDO · PARITY-PAIR · GATE-OL25WR · GATE-C4 · S504 · CONCEPT-A · UNALLOC · EFFGRP · DOOR-V1LINK · CABLE-LOADER | unchanged from v4.4 — **PRINT-REDO and PARITY-PAIR now fold into PRINT-PARITY** | |
| RULINGS-WANTED | REV-STAMP · (ff) tab strip · (dddd) `#` headings · IMP-SORT · BAND-EDITOR sequencing · `no_box_needed` vs the yellow | Icebox sweeps |

### BATCH

| Batch | Members |
|---|---|
| **BATCH-HARNESS** | H3 · GATE-THEMEGLYPH · GATE-COUNTWAIT · GATE-DLGRACE · GATE-FIXDIRTY · GATE-LOADPROXY · VIS-ENVFILE · DEV-SERVER-AGE · GATE-LOAD-AUDIO · **GATE-PDF (promoted out, to PRINT-PARITY)** |
| **BATCH-AC** (after private beta starts, R-AG) | unchanged from v4.4 |
| **BATCH-BOX** (post-private-beta) | unchanged · BOX-NAME-UNIQ · BOX-REPARENT · **LINK-ORPHAN** |
| **BATCH-EXPORT** | ~~leg 1~~ ✅ · ~~ARCH-MIG-BOX~~ ✅ · ~~leg 1b~~ ✅ · ~~MIRROR-SYSMETHOD~~ ✅ · ~~HISTID-UUID~~ ✅ · ~~**2-EXP**~~ ✅ · **2-MIG** · **2-IMP-a** · **2-IMP-b** · **2-IMP-c** |
| **BATCH-PREBETA** | SHARE (build-prep DONE) · (ppp) settings header · ADM-1 · AUTH-DOMAIN · 3TL · DEPS · CL-HILITE · GCM · **EXPRPT-STALE** |
| **BATCH-HOUSEKEEPING** | LINT · SRGRANT sweep · ST-RACE · CTF-SEED · SLOT-AUDIT residue · REPO-WEIGHT · BOX-TYPES-DIM-DROP · PROJ-CLEAN-2 · **FENCE-HEADLINE** |

### ICEBOX

Unchanged from v4.4.

## ❓ Open Questions (live only)

- **What actually drives the four over-asserting clone flags?** (CLONE-FLAG-DIVERGE.) The patch-relationship reading is a hypothesis and is unproven.
- **Where did CC's bash-write instruction come from?** (CC-BASHWRITE.) Not from the Arch handoff.
- **Does the PRINT-PARITY session's CC run get its own git worktree?** Daniel's confirm owed — it is what makes two parallel CC sessions safe under the one-writer rule.
- **Do the 39 boxes whose types BOX-TYPE-LIB created want dimensions?** Not blocking.
- **Does the operator need the report to say a system row was protected?** Not blocking.
- **Should the HISTID-HASH-COST wording be sharpened?**
- **What actually moves the theme-toggle glyph?** Unproven; never tested.
- The own-truck vs resolve-up reading on box labels is unobservable by construction.
- `box_default_large_labels` 5 (OQ4 ruled) vs the v1 panel's `#Big Labels 2`.
- v1 continuation header · cover-page body size → **PRINT-PARITY**.
- Script 551 extraction · cable Change All checkbox eligibility · house-wide Cancel semantics · Used∩Ignored · empty-string note · link `field_name` CHECK backstop · cable-type RENAME affordance · CL a-1 uploads · d2_01 red Members count · CL multi-letter-per-project · stale-category healing · CC credit-budget policy · OQ#2b own-band pendency · band-cascade harmonization.

---

*End of Roadmap v4.5 — August 23, 2026. **Retires Roadmap v4.4**. Unit of record: PORT-COV leg 2, unit 2-EXP (`41d1002..9c41b37`), 13 files, +2437/−45, suite 1975 → 2089 tests across 124 files. Handoff `to-cc/260823-1309_portcov-leg2-exp.md`; return in `from-cc/` under the same name. Scope of record: `drafts/260823_portcov_leg2_scope.md`. History: `Minotaur_v2_Ledger_v1_0.md`.*
