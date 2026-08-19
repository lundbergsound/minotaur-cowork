# 🗺️ ROADMAP — Minotaur v2 (v4.0)

**Version 4.0 • August 19, 2026 • Forward-only file — history lives in `Minotaur_v2_Ledger_v1_0.md`**

## 🧭 Next Sessions (RM-6 — plain English, kept current)

- **S4-3 leg 5 is CLOSED ENTIRE at `07150e6`** (build + AMEND-1 + AMEND-2, one commit, 39 files), pushed. The pen is with the main line; no parallel writer.
- **Next: S4-3 leg 6 — the three box print chains + P5 (R-F).** v1 pedigree: scripts 280/714, print layout 212, find layout 316, script 804's pre-print "things not in boxes" sweep. Banked leg-6 inputs: the print chain still hard-codes `boxLabel: null` (`docData.ts:23,:54` · `CableLabelsPrintClient.tsx:94`) · the categorized-box print case is unexercised (fixture boxes carry no category — cheap declared event under H2) · **CLAUDE.md's fence still reads "the next unit is S4-3 leg 5" — leg 6's handoff advances it.**
- **Pre-open:** verify Vercel READY at `07150e6` (`node scripts/vercel-preopen.mjs`) · refs from ref files, never git (Cowork seat) · migration ledger **51**.
- **Proposed, Daniel to confirm: the AC pass runs after leg 6** — R-AC (typed text wins in every autocomplete; a suggestion commits only when explicitly chosen) gave AC-ENTER its design ruling, and Daniel's discomfort is app-wide. Members under BATCH-AC below.
- **Gate standing notes:** `npm run test:visual` does not run — use `node --env-file=.env.local scripts/visual-capture.mjs --gate` (VIS-ENVFILE). GATE-THEMERACE (Δ42, topbar, intermittent): re-run once, never register it. Declarations: plain flags, reasons by hand, rule 9 per-dimension 1.75/8.
- **At Daniel's desk:** **R8-DRILL, OVERDUE** (hard stop before the September attorney engagement; gates account/project cleanup) · the CAND-4 texts · `HERO_BID_TO_OPENING` goes plural when Vape! Chicago opens · GIT-CFG strays.

## Lineage (full change-log lives in the Ledger; prior roadmap files in Minotaur-Cowork git history)

| Version | Date | Closed | Retires |
|---|---|---|---|
| **v4.0** | Aug 19 | **S4-3 leg 5 entire at `07150e6`** (cable box bands + data · R-7 yellow, project-armed · New Box dialog, (rrrr) resolved · ADMIN-NAV K-2 pairing · SORT-PERSIST, ledger 51) · roadmap restructured per R-AD (RM-7/RM-8) | v3.14 |
| v3.14 | Aug 18 | DOOR + LANDING entire at `e92f2c9` (landing page · closed door · waitlist RPC) | v3.13 |
| v3.13 | Aug 16 | HARNESS-H4 at `13a8233` (zero-tolerance gate · exception registry · rule 9 per-dimension) | v3.12 |

## Current Status (August 19, 2026)

Live at `https://minotaur.app` at **`07150e6`**, pushed (`e92f2c9..07150e6`). S4-3 leg 5 closed entire — four rounds, one commit, 39 files (26 modified, 13 new). Counts: suite **1677/111** · frozen **3/3 vs `be0769de`** · visual **28/28 at zero tolerance**, six baselines re-adopted under the leg-5 declared event (02/03/08 pairs, the R-7 yellow) · **migration ledger 51** (`s4_3_leg5_list_sort_mode_persistence`). Governing set: **Arch Prompt v30** · Strategy v14 · **Roadmap v4.0** + Ledger v1.0 (Aug-19 append). Session Log at **7 entries**, rollover clear. **Next:** leg 6 → **R8-DRILL, overdue**.

## 🏗 Sprint Plan (RM-7: this table IS the trigger for NEXT-class work)

| Unit | Status | Ref |
|---|---|---|
| S4-1 decks-clear · S4-2 S4-AUTO | ✅ | Aug 10–11 · `1f06092` |
| MMM-CAT (category sub-band editable) | NEVER-RAN | re-issue fresh on scheduling |
| S4-3 legs 0–4 (box family) | ✅ | `6d52921` · `8461c2a`+`254ec1c` · `23a34d6` |
| S4-3 leg 5 — box assignments completion | ✅ | Aug 18–19 · `07150e6` |
| **S4-3 leg 6 — three box PDFs + P5 (R-F)** | **NEXT** | inputs banked in 🧭 |
| HARNESS H1 · H2 · H4 | ✅ | `e55269c` · `ddcf929` · `13a8233` |
| DOOR + LANDING | ✅ | `e92f2c9` |
| **AC pass (BATCH-AC)** | PROPOSED after leg 6 | Daniel confirms placement |
| S4-mid: D-2b + BASE-EVT (FOCUS-MP in headroom) | QUEUED | |
| S4-late: GS-C → LINE-STECK (+STECK-COLOR) → S3-G-2 (+UNFLAG-WARN) → ALLOC | QUEUED | |
| S4-close: EXPORT+GBD (BATCH-EXPORT: PORT-COV v2 build) | QUEUED | |
| Sprint-4 close reviews: WF1A-SUNSET · auto-mode rider EXPIRES · COWORK-PORT · PRINT-REDO if Daniel opens it | QUEUED | |
| KKK-PASS (narrow-window responsive) | immediately after Sprint 4 | |
| Pre-beta: SHARE build → ADM-1 · AUTH-DOMAIN · 3TL · DEPS · CL-HILITE (BATCH-PREBETA) | QUEUED | |
| Post-beta: BATCH-BOX · GCM completion · Maintenance · Spreadsheet Export · RF/Walkies/Circuits · IAS Import · real-time collab · licensing ~Nov · PWA | QUEUED | |

## 📌 Docket (RM-7: every row carries a trigger class — NEXT lives in the sprint table · DATED · EVENT · BATCH · ICEBOX. RM-8: one-line rows; history exits to the Ledger.)

### DATED — calendar-bound, mostly Daniel's desk

| ID | One line | When |
|---|---|---|
| R8-DRILL | Backup restore drill per R8 runbook; unblocks PORT-READY, feeds addendum §B retention number, gates account/project cleanup | **OVERDUE** — hard stop before September |
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
| RULINGS-WANTED | REV-STAMP · (ff) tab strip · (dddd) `#` headings · IMP-SORT · WIRE-TYPE disposition · BAND-EDITOR sequencing (equipment box band editor's unmatched-name path vs the All/One confirm) · `no_box_needed` vs the yellow (recommend: suppress; rides R7-ARM-2) | Surfaced at each icebox sweep; none urgent |

### BATCH — the batch is scheduled; members inherit (sprint table has the dates)

| Batch | Members (one line each) |
|---|---|
| **BATCH-HARNESS** (after box unit + import/export + SHARE, per R-V) | H3 (SUBPIXEL-WANDER diagnosis; site 2 thrice-measured is the anchor; new n=1 observations at `1127,18` 02/03-light and `149,108` 12-light) · GATE-THEMERACE (the Δ42 bridge case) · GATE-COUNTWAIT (capture-flake (3)'s true cause, `locator.count()` no-wait; fix is one line) · GATE-DLGRACE (frame-07 NoMethodDialog race, `visual-capture.mjs:459-461`, same count()-once family) · GATE-FIXDIRTY (fire-and-forget sort restore) · GATE-LOADPROXY (load ceiling tracks nothing) · VIS-ENVFILE (`npm run test:visual` lacks `--env-file`) |
| **BATCH-AC** (proposed after leg 6; R-AC is the ruled design) | R-AC build: typed text wins app-wide; suggestion commits only on arrow/click · (bbb) inline-completion Enter · (eee) exact-match suppression · substring-vs-prefix narrowing (B5) · hover-highlight commit target · AC-HANDLED (`handledRef` latch clear-on-new-edit) · BoxDetailPanel Category/Method lying-screen · NewBoxTypeDialog opening-keystroke hazard (safe today; harden with the NewBoxDialog timeStamp guard) · New-Box-dialog Type field → autocomplete if Daniel still wants it after R-AC lands |
| **BATCH-BOX** (post-private-beta) | TYPE-HOLD (+ R-J DB uniqueness rides its migration) · R7-ARM-2 (R-AE: yellow arms only when ≥1 record has a box assigned; + `no_box_needed` if ruled) · BOXTYPE-DIALOG-2 (R-AF: discuss type-creation dialog inside New Box dialog) · BAND-EDITOR build (after its sequencing ruling) · PANEL-NAV · BOX-DUP · BUNDLE-HOLD · BOX-SORT (R-H toolbar idiom) · BOXTYPE-CA (Change All on Box Types admin) · BOXTYPE-BTN (cosmetic, accepted) · (fff) remaining_quantity edit path · SEED (61-row v1 export, unblocked) · UNITS (R-M — **bound: private beta, before public beta**) · BOX-BAND-ROLLUP (Percent Full + Weight on the cable box band — the only v1 band fields still missing; needs design) |
| **BATCH-EXPORT** (S4-close) | PORT-COV v2 build (v1 side DONE; seven rulings in Ledger) · EXPORT-ORDER (positional contract; 567 boxes map 38 vs 566's 36; Box Types order confirmed) · WIRE-TYPE (rule port-or-omit first) · IMP-SPINE-2 (secondary type-unscoped reads; count is correct as-is) |
| **BATCH-PREBETA** | SHARE (design ruled; invites need a non-public-form account path — Strat input received) · (ppp) settings header rides SHARE · ADM-1 (REV-B owed) · AUTH-DOMAIN (gates SHARE phase 2) · 3TL · DEPS · CL-HILITE |
| **BATCH-HOUSEKEEPING** (opportunistic / a chore day) | LINT (no ESLint config exists) · SRGRANT sweep · ST-RACE · CTF-SEED · SLOT-AUDIT residue (six routes audited at leg 5 — one real gap: Bundle list has Duplicate but registers no onClone) |

### ICEBOX — deliberately parked; swept at every sprint close (RM-7's safety net)

PAL-UNIFY · CMDK · LAT (~89ms warm-up residual) · EST-AUDIT · UNDO · TRASH · RTL (component harness) · TYPE-TOG · LIB-RENDER (+ (pppp)) · GCM-LAND · NOTES-NL · GROUP-RES · MPP-COS · REV-SPRINT2 · SNAP-CHK · CONTRAST · DASH-FRAME · TAB-BRIDGE · BINGO (Daniel, post-private-beta) · (q) Zite consolidation (Daniel) · (u) · (yy) · (aaa) · (ccc) · (hhh) · (jjj) · (vvv) · (ffff) · COWORK-PORT (Sprint 4 close; carries the one-writer amendment proposal) · WF1A-SUNSET (Sprint 4 close; datapoint register in Ledger)

## ❓ Open Questions (live only)

- `box_default_large_labels` 5 (OQ4 ruled) vs the v1 panel's `#Big Labels 2` — flagged, not acted on.
- The categorized-box print case is unexercised → leg 6 stages it as its own cheap declared event.
- v1 continuation header · cover-page body size → PRINT-REDO.
- Script 551 extraction · cable Change All checkbox eligibility · house-wide Cancel semantics · Used∩Ignored · empty-string note · link `field_name` CHECK backstop · cable-type RENAME affordance · CL a-1 uploads · d2_01 red Members count · CL multi-letter-per-project · stale-category healing · CC credit-budget policy · OQ#2b own-band pendency · band-cascade harmonization.
- **Seat consolidation** — rule at or after COWORK-PORT; the datapoint register lives in the Ledger (Aug-16/Aug-19 appends).

---

*End of Roadmap v4.0 — August 19, 2026. **Retires Roadmap v3.14** (file retained in Minotaur-Cowork git history; its row histories are of record there and in the Ledger's Aug-19 append). Unit of record: S4-3 leg 5 at `07150e6`; handoffs `to-cc/260818-2030_*`, `260819-0810_*-amend1`, `260819-1005_*-amend2`; returns `from-cc/260818-1555_*`, `260818-2027_*-amend1`, `260819-0740_*-amend2`. History: `Minotaur_v2_Ledger_v1_0.md`.*
