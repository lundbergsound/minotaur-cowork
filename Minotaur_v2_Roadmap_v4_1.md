# 🗺️ ROADMAP — Minotaur v2 (v4.1)

**Version 4.1 • August 21, 2026 • Forward-only file — history lives in `Minotaur_v2_Ledger_v1_0.md`**

## 🧭 Next Sessions (RM-6 — plain English, kept current)

- **S4-3 leg 6 is CLOSED ENTIRE at `8b078b2`**, five commits (`6d17f07` build · `f40bca6` AMEND-1 · `e566454` evidence · `aa080ac` AMEND-2 · `8b078b2` AMEND-3), all pushed. The pen is with the main line; no parallel writer.
- **FIRST ACTION next session: re-run the confirming visual gate on a quiet machine and report it as a standalone line** (R-AM — AMEND-3's coverage is the earlier 28/28; confirmation is deferred, not waived). **If it comes back non-green when quiet, HALT AND MEASURE rather than re-run** — that would mean the flake families are mis-scoped, which is a larger finding than the amendment. Restart the dev server first (DEV-SERVER-AGE).
- **Then: Daniel's re-print.** v2's five box outputs at 100%, matching paper size and orientation, against the arbiters in `docs/reference/evidence/print/parity/`. **This is the only thing that confirms three amendments of parity work actually landed** — everything in AMEND-1/2/3 is confirmed by construction and against the *v1* side, never against a v2 render. PDF evidence-class rule stands: screenshots are on-screen anatomy only.
- **Then the next unit is Daniel's call**, with SENT-BUNDLE and BOX-NUM-TYPE the two rulings that would let the box family close clean.
- **Pre-open:** refs from ref files, never git (Cowork seat) · check for an orphaned `index.lock` · migration ledger **51** · Vercel READY at `8b078b2`. **`next-env.d.ts` will show modified — it is Next-generated, self-declares "should not be edited", flips with build-vs-dev, and must stay out of every commit.**
- **Bulk data (R-AL, standing):** never route rows through a model context. Generator → payload file → loader executed where the network lives → one verification query. `bvscny-load.mjs` is the reference implementation.
- **Gate standing notes:** `npm run test:visual` does not run — use `node --env-file=.env.local scripts/visual-capture.mjs --gate` (VIS-ENVFILE). GATE-THEMERACE (Δ42, topbar, intermittent): re-run once, never register it. DLGRACE: re-run. Load ceiling honored; **`--force-load` forbidden**. Declarations: plain flags, reasons by hand, rule 9 per-dimension 1.75/8.
- **At Daniel's desk:** **R8-DRILL, OVERDUE** (hard stop before the September attorney engagement; gates account/project cleanup) · the CAND-4 texts · `HERO_BID_TO_OPENING` goes plural when Vape! Chicago opens · GIT-CFG strays.

## Lineage (full change-log lives in the Ledger; prior roadmap files in Minotaur-Cowork git history)

| Version | Date | Closed | Retires |
|---|---|---|---|
| **v4.1** | Aug 21 | **S4-3 leg 6 entire at `8b078b2`** (three box print chains + P5 · parity rebuilt from the v1 layout · Box List landscape · top-slot `Length(Self) ≥ 12` · catalog flag 7 closed) · **JOY + BVSC NY seeded**, BVSC NY now the box parity corpus · **R-AL** bulk-data architecture · BATCH-AC and GCM re-triggered (R-AG/R-AH) | v4.0 |
| v4.0 | Aug 19 | S4-3 leg 5 entire at `07150e6` (cable box bands + data · R-7 yellow, project-armed · New Box dialog, (rrrr) resolved · ADMIN-NAV K-2 pairing · SORT-PERSIST, ledger 51) · roadmap restructured per R-AD (RM-7/RM-8) | v3.14 |
| v3.14 | Aug 18 | DOOR + LANDING entire at `e92f2c9` (landing page · closed door · waitlist RPC) | v3.13 |

## Current Status (August 21, 2026)

Live at `https://minotaur.app` at **`8b078b2`**, pushed (`aa080ac..8b078b2`). S4-3 leg 6 closed entire — four rounds across five commits, the leg's evidence class escalating mid-unit from rendered v1 PDFs to **FileMaker layout mode with the Inspector open**, which states the rule where a PDF can only imply it. Counts: suite **1816/117** (from 1677) · frozen **3/3 vs `be0769de`** · dependency gate empty · build and strict typecheck clean · **migration ledger 51, unchanged — this leg carried no schema**. Visual gate: **28/28 accepted under R-AM, confirming run deferred to next session** (four attempts on a loaded machine, three failure modes, all in documented flake families; nothing written). Two full v1 shows now seeded: **BVSC NY** (134 boxes incl. **22 nested**, 1,119 cables, 71 bundles, 190 tails, 1,368 equipment rows, 552 mult lines, 58 box types) **replaces JOY as the box parity corpus** — JOY has no nesting at all. Evidence corpus: 21 v1 parity artifacts plus the layout frames. Governing set: **Arch Prompt v30** · Strategy v14 · **Roadmap v4.1** + Ledger v1.0 (Aug-21 append). Session Log at **8 entries**, rollover fires at 10. **Next:** the confirming gate → Daniel's re-print → **R8-DRILL, overdue**.

## 🏗 Sprint Plan (RM-7: this table IS the trigger for NEXT-class work)

| Unit | Status | Ref |
|---|---|---|
| S4-1 decks-clear · S4-2 S4-AUTO | ✅ | Aug 10–11 · `1f06092` |
| MMM-CAT (category sub-band editable) | NEVER-RAN | re-issue fresh on scheduling |
| S4-3 legs 0–4 (box family) | ✅ | `6d52921` · `8461c2a`+`254ec1c` · `23a34d6` |
| S4-3 leg 5 — box assignments completion | ✅ | Aug 18–19 · `07150e6` |
| **S4-3 leg 6 — three box PDFs + P5 (R-F)** | ✅ | Aug 19–21 · `8b078b2` |
| **VIS-CONFIRM — AMEND-3's confirming gate on a quiet machine** | **NEXT** | R-AM; standalone line, halt-don't-re-run if non-green |
| HARNESS H1 · H2 · H4 | ✅ | `e55269c` · `ddcf929` · `13a8233` |
| DOOR + LANDING | ✅ | `e92f2c9` |
| S4-mid: D-2b + BASE-EVT (FOCUS-MP in headroom) | QUEUED | |
| S4-late: GS-C → LINE-STECK (+STECK-COLOR) → S3-G-2 (+UNFLAG-WARN) → ALLOC | QUEUED | |
| S4-close: EXPORT+GBD (BATCH-EXPORT: PORT-COV v2 build) | QUEUED | |
| Sprint-4 close reviews: WF1A-SUNSET · auto-mode rider EXPIRES · COWORK-PORT · PRINT-REDO if Daniel opens it | QUEUED | |
| KKK-PASS (narrow-window responsive) | immediately after Sprint 4 | |
| Pre-beta: SHARE build → ADM-1 · AUTH-DOMAIN · 3TL · DEPS · CL-HILITE · **GCM completion (R-AH)** (BATCH-PREBETA) | QUEUED | |
| **AC pass (BATCH-AC)** | **after private beta STARTS (R-AG)** | own trigger; not post-beta |
| Post-beta: BATCH-BOX · Maintenance · Spreadsheet Export · RF/Walkies/Circuits · IAS Import · real-time collab · licensing ~Nov · PWA | QUEUED | GCM exits to pre-beta per R-AH |

## 📌 Docket (RM-7: every row carries a trigger class — NEXT lives in the sprint table · DATED · EVENT · BATCH · ICEBOX. RM-8: one-line rows; history exits to the Ledger.)

### DATED — calendar-bound, mostly Daniel's desk

| ID | One line | When |
|---|---|---|
| R8-DRILL | Backup restore drill per R8 runbook; unblocks PORT-READY, feeds addendum §B retention number, gates account/project cleanup | **OVERDUE** — hard stop before September |
| BOX-REPRINT | v2's five box outputs printed at 100% against the arbiters — the only valid parity evidence for AMEND-1/2/3 | Next session, Daniel's desk |
| CAND-4 | Four personal texts to the named beta candidates; accounts stay live; invites post-terms | This week |
| HERO-PLURAL | `HERO_BID_TO_OPENING` in `src/app/page.tsx` goes plural | When Vape! Chicago opens |
| COMMS-REWRITE | R-W: Comms Prompt v9 deleted, rewritten from scratch (v10 amendments + the R-U miss are inputs) | Before next Comms deliverable |
| LEGAL-SEP | September attorney engagement; addendum §F scope (pre-terms accounts, notice, IMP-SPINE disclosure) | September 2026 |
| COMMS-Q | October announcement to the v1 list, carrying the beta path ("no announcement without a way in") | October |
| TOK-VC | Vercel token rotation | Private-beta start; hard ~Nov 8 |
| LIC-NOV | Licensing subsystem design (+ ownership transfer) | ~November |
| VERHIST | Durable version history | ~November |
| BRIEF-12 | Brief v1.2: terms-before-any-third-party-access restatement · signup-state history · Communications section (Strat) | Strat scheduling |
| GIT-CFG | git identity config · Next 16 `middleware`→`proxy` · two stray trees to delete (Daniel) | Housekeeping |

### EVENT — fires on a named condition

| ID | One line | Trigger |
|---|---|---|
| **SENT-BUNDLE** | **Daniel's ruling: derive the Contents column from `cable_details.labeled`, or drop it as a recorded divergence** — no v1 field of that name exists; v2 prints it empty, a known 80-for-80 mismatch | **Daniel's word; blocks a clean Contents parity** |
| **BOX-NUM-TYPE** | `199A` — v1 box numbers are text, v2's column is numeric; schema decision, divergence live in printed output today | Schema ruling |
| **BUNDLE-FIND** | Bundle List registers no find surface; capped AMEND-1's Show Me narrowing at three classes of four | Rides the next bundle-touching unit |
| **IMP-BOXCOL** | Importer does not carry Box on equipment rows (found while backfilling JOY) | Rides BATCH-EXPORT / import work |
| **SED-GUARD** | PreToolUse hard-block on bash-mediated writes to repo files; the SED LEDGER is a promise, not a mechanism | Next harness touch, or opportunistic |
| **DEV-SERVER-AGE** | Harness should **refuse**, not warn, past a dev-server age trigger (2 supporting instances; a warning nobody watches is the GATE-LOADPROXY class) | BATCH-HARNESS |
| **REPO-WEIGHT** | Evidence corpus size policy — 21 parity PDFs + a dozen layout PNGs and growing | Before it is urgent |
| DIFF-EXC-BOUND | Bound registry sites by area × maxPixels (design note in Ledger) | First site registered above Δ1; harness warns |
| METHOD-FIX | Fixture debt: method band + changed-note row on printed fixture | Next fixture-touching declared event |
| PRINT-REDO | Equipment-list print parity re-attempt; measurement harness first | Daniel's word only (Sprint 4 close earliest) |
| PARITY-PAIR | v1 preliminary + v2 revision-mode prints, both missing | Before PRINT-REDO |
| GATE-PDF · GATE-OL25WR · GATE-C4 | Print-side physical gates (Save-as-PDF packet · die-cut stock · C4 re-scope) | At a printer / show |
| S504 | Residual s504 delete-variant frames | When v1 cooperates |
| CONCEPT-A | Print-header unit | Gated on the a-1 uploads |
| UNALLOC | Unallocate may not return cable/tails to generic | Needs a reproduction from Daniel |
| EFFGRP | effective_group view defect; four-step migration ready | Daniel's ruling |
| DOOR-V1LINK | R-U removed the only v1-product-page link; "keep selling v1" was this page's job | Daniel's call, any time |
| CABLE-LOADER | Cold-load flash: cable page loader doesn't gate on the boxes read (box bands paint late); + consider boxList prefetch | Rides the next cable-touching unit |
| RULINGS-WANTED | REV-STAMP · (ff) tab strip · (dddd) `#` headings · IMP-SORT · WIRE-TYPE disposition · BAND-EDITOR sequencing · `no_box_needed` vs the yellow (recommend: suppress; rides R7-ARM-2) | Surfaced at each icebox sweep; none urgent |

### BATCH — the batch is scheduled; members inherit (sprint table has the dates)

| Batch | Members (one line each) |
|---|---|
| **BATCH-HARNESS** (after box unit + import/export + SHARE, per R-V) | H3 (SUBPIXEL-WANDER diagnosis; site 2 thrice-measured is the anchor; n=1 observations at `1127,18` 02/03-light and `149,108` 12-light) · GATE-THEMERACE (the Δ42 bridge case) · GATE-COUNTWAIT (capture-flake (3)'s true cause, `locator.count()` no-wait; fix is one line) · GATE-DLGRACE (frame-07 NoMethodDialog race, `visual-capture.mjs:459-461`, same family) · GATE-FIXDIRTY (fire-and-forget sort restore) · GATE-LOADPROXY (load ceiling tracks nothing) · VIS-ENVFILE (`npm run test:visual` lacks `--env-file`) · **DEV-SERVER-AGE (refuse, don't warn)** |
| **BATCH-AC** (**after private beta starts, R-AG**; R-AC is the ruled design) | R-AC build: typed text wins app-wide; suggestion commits only on arrow/click · (bbb) inline-completion Enter · (eee) exact-match suppression · substring-vs-prefix narrowing (B5) · hover-highlight commit target · AC-HANDLED (`handledRef` latch clear-on-new-edit) · BoxDetailPanel Category/Method lying-screen · NewBoxTypeDialog opening-keystroke hazard (safe today; harden with the NewBoxDialog timeStamp guard) · New-Box-dialog Type field → autocomplete if Daniel still wants it after R-AC lands |
| **BATCH-BOX** (post-private-beta) | TYPE-HOLD (+ R-J DB uniqueness rides its migration) · R7-ARM-2 (R-AE) · BOXTYPE-DIALOG-2 (R-AF) · BAND-EDITOR build (after its sequencing ruling) · PANEL-NAV · BOX-DUP · BUNDLE-HOLD · BOX-SORT (R-H toolbar idiom) · BOXTYPE-CA · BOXTYPE-BTN (cosmetic, accepted) · (fff) remaining_quantity edit path · SEED (61-row v1 export, unblocked) · UNITS (R-M — **bound: private beta, before public beta**) · BOX-BAND-ROLLUP (Percent Full + Weight on the cable box band) |
| **BATCH-EXPORT** (S4-close) | PORT-COV v2 build (v1 side DONE; seven rulings in Ledger) · EXPORT-ORDER (positional contract; 567 boxes map 38 vs 566's 36) · WIRE-TYPE (rule port-or-omit first) · IMP-SPINE-2 (secondary type-unscoped reads; count is correct as-is) · **IMP-BOXCOL** |
| **BATCH-PREBETA** | SHARE (design ruled; invites need a non-public-form account path) · (ppp) settings header rides SHARE · ADM-1 (REV-B owed) · AUTH-DOMAIN (gates SHARE phase 2) · 3TL · DEPS · CL-HILITE · **GCM completion (R-AH — moved in from post-beta)** |
| **BATCH-HOUSEKEEPING** (opportunistic / a chore day) | LINT (no ESLint config exists) · SRGRANT sweep · ST-RACE · CTF-SEED · SLOT-AUDIT residue (Bundle list has Duplicate but registers no onClone) · **REPO-WEIGHT** |

### ICEBOX — deliberately parked; swept at every sprint close (RM-7's safety net)

PAL-UNIFY · CMDK · LAT (~89ms warm-up residual) · EST-AUDIT · UNDO · TRASH · RTL (component harness) · TYPE-TOG · LIB-RENDER (+ (pppp)) · GCM-LAND · NOTES-NL · GROUP-RES · MPP-COS · REV-SPRINT2 · SNAP-CHK · CONTRAST · DASH-FRAME · TAB-BRIDGE · BINGO (Daniel, post-private-beta) · (q) Zite consolidation (Daniel) · (u) · (yy) · (aaa) · (ccc) · (hhh) · (jjj) · (vvv) · (ffff) · COWORK-PORT (Sprint 4 close; carries the one-writer amendment proposal) · WF1A-SUNSET (Sprint 4 close; datapoint register in Ledger)

## ❓ Open Questions (live only)

- **The own-truck vs resolve-up reading on box labels is UNOBSERVABLE by construction** — the two differ only on a nested box, and a nested box has `Box in Box` populated, covering the truck field. Built as own-truck because that is what the field *is*; pinned by a test that documents the unobservability. Surfaces only on a nested box whose parent has a blank name.
- `box_default_large_labels` 5 (OQ4 ruled) vs the v1 panel's `#Big Labels 2` — flagged, not acted on.
- v1 continuation header · cover-page body size → PRINT-REDO.
- Script 551 extraction · cable Change All checkbox eligibility · house-wide Cancel semantics · Used∩Ignored · empty-string note · link `field_name` CHECK backstop · cable-type RENAME affordance · CL a-1 uploads · d2_01 red Members count · CL multi-letter-per-project · stale-category healing · CC credit-budget policy · OQ#2b own-band pendency · band-cascade harmonization.
- **Seat consolidation** — rule at or after COWORK-PORT; the datapoint register lives in the Ledger (Aug-16/Aug-19 appends).

---

*End of Roadmap v4.1 — August 21, 2026. **Retires Roadmap v4.0** (file retained in Minotaur-Cowork git history; its row histories are of record there and in the Ledger's Aug-21 append). Unit of record: S4-3 leg 6 at `8b078b2`; handoffs `to-cc/260819-1150_s4-3-leg6-box-print-chains.md`, `260819-1845_*-amend1`, `260820-1330_*-amend2`, `260820-1520_*-amend3`; returns `from-cc/260819-1352_*`, `260819-2010_*-amend1`, `260820-1330_*-amend1-close`, `260820-1415_*-amend2`, `260820-1535_*-amend3`. History: `Minotaur_v2_Ledger_v1_0.md`.*
