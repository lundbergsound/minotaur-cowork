# 🗺️ ROADMAP — Minotaur v2 (v4.4)

**Version 4.4 • August 22, 2026 • Forward-only file — history lives in `Minotaur_v2_Ledger_v1_0.md`**

## 🧭 Next Sessions (RM-6 — plain English, kept current)

- **THE v1 MIRROR IMPORT NOW COMPLETES END TO END.** Daniel's browser gate landed the **first full BVSC NY import in the project's history**: `Status: succeeded`, revision snapshot written first, **1368 equipment · 2101 library · 134 boxes · 76 box types · 21 methods · 31 categories**. Three aborts were peeled off in one session, each hiding the next, and **no machine gate saw any of them** — two were found by Daniel's browser gate.
- **MIRROR-SYSMETHOD + METHOD-DUP/CAT-DUP CLOSED at `d39179a`.** 6 files, +349/−5. The seeded `N/A - Labels Only` method is protected from delete planning **without leaving the corpus or the fingerprint** — filtering it out would have aborted every mirror apply on every project (IMP-SPINE on a second table). Methods and categories now dedupe by exact name, first-wins, mirroring the library and box-type idioms.
- **HISTID-UUID + FENCE-STALE CLOSED at `41d1002`.** 6 files, +355/−53. Non-UUID v1 HistoryIDs are nulled at map time and fall back to hash identity, per the 2026-08-14 ruling that had never been built. **Hash neutrality proven by measurement** — 3,025 rows across three corpora, identical sha256 before and after.
- **FIRST ACTION next session: PORT-COV leg 2, the cable side.** Net-new DDR extraction; WIRE-TYPE is RULED (deprecate), so the scope shrank. Not scoped yet. **GATE-NEST-UPGRADE rides it** — a one-word registry edit, already ruled.
- **Counts at `41d1002`:** suite **1975 tests across 121 test files, ZERO skipped** · frozen **3/3 vs `be0769de`** · visual **28/28 @ 0.0000%** · migration ledger **52**, unchanged — neither unit needed one.
- **⚠ COUNT NOTATION (TESTCOUNT):** `1975/121` is **TESTS / TEST FILES**, never passing / skipped. The suite has no skipped tests. An Arch handoff read the second number as "skipped" on Aug 22 and wrote it into an instruction; the notation warning now also lives in `CLAUDE.md`'s run fence.
- **Two propagation failures this session, and they are the same disease.** **HISTID-UUID**: a ruling taken Aug 14 reached the Ledger and this Roadmap and **no file in the repo**, and cost a gate abort eight days later. **FENCE-STALE**: `CLAUDE.md`'s run fence sat three units stale and **told CC that a unit closed on Aug 19 was next**. Both fixed at `41d1002`. **A stale document does not fail quietly — it gives orders.**
- **SHARE build-prep is DONE and waiting** — `drafts/260821-1145_share_build_prep.md`. **Headline: seven project-scoped tables are owner-only, so sharing is broken at the CURRENT three roles, not just at the fourth.**
- **Install path of record changed (Daniel, Aug 22):** the Arch seat writes close files to the mount **and** to claude.ai project knowledge. Daniel does not. Archives are excluded — write-once, never read by a working session.
- **Pre-open:** refs from ref files, never git · check for an orphaned `index.lock` · migration ledger **52** · Vercel READY at `41d1002`. One untracked stray remains at `docs/reference/evidence/equipment/`; **`docs/reference/_to_delete/` and `drafts/_to_delete/` are GONE** — Daniel cleared them Aug 22.
- **Rollover:** clear. Session Log at 3 entries; archive `Session_Log_Archive_2026-08-22.md` holds the oldest 8.
- **Bulk data (R-AL, standing):** never route rows through a model context. Generator → payload file → loader executed where the network lives → one verification query. Both Aug-22 Ledger appends were made on disk under this rule and byte-verified append-only.
- **Gate standing notes:** `npm run test:visual` does not run — use `node --env-file=.env.local scripts/visual-capture.mjs --gate` (VIS-ENVFILE). The harness spawns its own fresh dev server, so DEV-SERVER-AGE is satisfied by construction. **`--force-load` forbidden** — refused twice this session for ~20 minutes under audio load and retried, never overridden (**GATE-LOAD-AUDIO**). **GATE-THEMEGLYPH did not fire** in either run.
- **At Daniel's desk:** **R8-DRILL, OVERDUE** · **BOX-REPRINT** · the CAND-4 texts · `HERO_BID_TO_OPENING` plural when Vape! Chicago opens · GIT-CFG strays · **PROJ-CLEAN-2** (15 stale projects on the test user's dashboard, seven of them `Amend2`/`FIX1` leftovers) · commit + push `Minotaur-Cowork`.

## Lineage (full change-log lives in the Ledger)

| Version | Date | Closed | Retires |
|---|---|---|---|
| **v4.4** | Aug 22 (evening) | **MIRROR-SYSMETHOD + METHOD-DUP/CAT-DUP at `d39179a`** · **HISTID-UUID + FENCE-STALE at `41d1002`** · **the first complete BVSC NY mirror import lands** · Session Log rollover run at pre-open · four Arch corrections (TESTCOUNT · HISTID-UUID · FENCE-STALE · proxy-precondition) · GATE-NEST-UPGRADE ruled | v4.3 |
| v4.3 | Aug 22 | ARCH-MIG-BOX applied (ledger 52) · PORT-COV leg 1b closed at `4c234dd` · the live gap opened and shut same day · BVSC NY landed · four Daniel rulings · Arch Prompt v31 | v4.2 |
| v4.2 | Aug 21 | R-AM discharged · leg 1 export half at `a243867` · BOX-NUM-TYPE and WIRE-TYPE ruled · SHARE build-prep | v4.1 |

## Current Status (August 22, 2026 — evening)

Live at `https://minotaur.app` at **`41d1002`**, pushed (`4c234dd..d39179a..41d1002`). **The v1 mirror import completes end to end on the full BVSC NY corpus.** Migration ledger **52**, unchanged this session. Counts: suite **1975 tests / 121 test files, zero skipped** · frozen **3/3 vs `be0769de`** · typecheck 0 · dependency gate empty · build clean · visual **28/28 @ 0.0000%**, zero frames moved by either unit. Governing set: **Arch Prompt v31** · Strategy v14 · **Roadmap v4.4** (retiring v4.3) + Ledger v1.0 (two Aug-22 appends). Session Log at **3 entries, rollover clear.** **Next:** PORT-COV leg 2, the cable side → **R8-DRILL, overdue**.

## 🏗 Sprint Plan (RM-7)

| Unit | Status | Ref |
|---|---|---|
| S4-1 decks-clear · S4-2 S4-AUTO | ✅ | Aug 10–11 · `1f06092` |
| MMM-CAT (category sub-band editable) | NEVER-RAN | re-issue fresh on scheduling |
| S4-3 legs 0–6 (box family) | ✅ | `6d52921` · `8461c2a`+`254ec1c` · `23a34d6` · `07150e6` · `8b078b2` |
| PORT-COV leg 1 — box EXPORT half | ✅ | `a243867` |
| ARCH-MIG-BOX — the migration | ✅ | ledger 52, `20260822144022`, rehearsal-first |
| PORT-COV leg 1b — box IMPORT half | ✅ | `4c234dd` · 47 files |
| **MIRROR-SYSMETHOD + METHOD-DUP / CAT-DUP** | ✅ **CLOSED** | `d39179a` · 6 files · browser gate passed |
| **HISTID-UUID + FENCE-STALE** | ✅ **CLOSED** | `41d1002` · 6 files · full BVSC NY import applied |
| **PORT-COV leg 2 — cable side** | **NEXT** | Net-new DDR extraction; WIRE-TYPE ruled out. GATE-NEST-UPGRADE rides it |
| HARNESS H1 · H2 · H4 | ✅ | `e55269c` · `ddcf929` · `13a8233` |
| DOOR + LANDING | ✅ | `e92f2c9` |
| S4-mid: D-2b + BASE-EVT (FOCUS-MP in headroom) | QUEUED | |
| S4-late: GS-C → LINE-STECK (+STECK-COLOR) → S3-G-2 (+UNFLAG-WARN) → ALLOC | QUEUED | deferred by the Aug-21 sequencing ruling |
| S4-close: GBD | QUEUED | |
| Sprint-4 close reviews: WF1A-SUNSET · auto-mode rider EXPIRES · COWORK-PORT · PRINT-REDO if opened | QUEUED | SEAT-MIG discharged at v31 |
| KKK-PASS (narrow-window responsive) | after Sprint 4 | |
| **Pre-beta: SHARE build → ADM-1 · AUTH-DOMAIN · 3TL · DEPS · CL-HILITE · GCM (R-AH)** | QUEUED | BATCH-PREBETA |
| **AC pass (BATCH-AC)** | after private beta STARTS (R-AG) | own trigger |
| Post-beta: BATCH-BOX · Maintenance · Spreadsheet Export · **RF/Walkies/Circuits (BVSC-RF)** · IAS Import · real-time collab · licensing ~Nov · PWA | QUEUED | |

## 📌 Docket

### DATED

| ID | One line | When |
|---|---|---|
| R8-DRILL | Backup restore drill per R8 runbook; unblocks PORT-READY, feeds addendum §B, gates account/project cleanup | **OVERDUE** — hard stop before September |
| BOX-REPRINT | v2's five box outputs printed at 100% against the arbiters — the only valid parity evidence for AMEND-1/2/3 | Daniel's desk |
| CAND-4 | Four personal texts to the named beta candidates | This week |
| HERO-PLURAL | `HERO_BID_TO_OPENING` goes plural | When Vape! Chicago opens |
| COMMS-REWRITE | R-W: Comms Prompt v9 deleted, rewritten from scratch | Before next Comms deliverable |
| LEGAL-SEP | September attorney engagement; addendum §F scope | September 2026 |
| COMMS-Q | October announcement to the v1 list | October |
| TOK-VC | Vercel token rotation | Private-beta start; hard ~Nov 8 |
| LIC-NOV · VERHIST | Licensing subsystem (+ ownership transfer) · durable version history | ~November |
| BRIEF-12 | Brief v1.2: terms-before-third-party-access · signup-state history · Communications section | Strat scheduling |
| GIT-CFG | git identity · Next 16 `middleware`→`proxy` · stray trees · **`LEG1B GATE` scratch project · `Minotaur_v1_exports/BVSC_NY/_to_delete/`** (the two repo-side `_to_delete/` folders are GONE) | Housekeeping |
| **PROJ-CLEAN-2** | **NEW.** The test user's dashboard carries **15 projects**, seven of them `Amend2`/`FIX1` leftovers dated 7/31/2026 from an earlier session's smoke. CC did not touch them | Daniel's desk |

### EVENT

| ID | One line | Trigger |
|---|---|---|
| **MIRROR-SYSMETHOD** | **CLOSED Aug 22 at `d39179a`, ruling (a).** `CurrentV2Row.protected` excludes a row from DELETE planning only — never from the corpus, the fingerprint, natural-key resolution or `createMissing`. Filtering the fetch instead would have shrunk `fingerprint.methods` below the RPC's all-rows count and aborted **every** mirror apply on **every** project — IMP-SPINE on a second table | Closed |
| **MIRROR-SYSMETHOD (b)** | **RULED, UNIMPLEMENTED.** The RPC-side `and not is_system` on the methods delete — the data-layer guarantee. Deliberately not spent on its own migration | Next RPC touch (BOX-NOBOX or BOX-REPARENT) |
| **METHOD-DUP** | **CLOSED Aug 22.** BVSC NY's `methods.xlsx` carries `Rent-Boxes` twice; both rows inserted and `methods_project_id_name_key` aborted at step 5, **ahead of** the system-method guard at step 6. Exact-name first-wins dedupe, one variance entry per dropped row | Closed |
| **CAT-DUP** | **CLOSED Aug 22 — a GUARD, not a fix.** Same missing dedupe, same constraint; no corpus carries a duplicate category (29 / 31 / 29). Runs **before** the sort partition, because `sort_order` is assigned `(idx+1)*10` over the ordered array | Closed |
| **HISTID-UUID** | **CLOSED Aug 22 at `41d1002`.** BVSC NY's `boxes.xlsx` carries **27 of 134** HistoryIDs as FileMaker timestamps; `import_apply_v1` casts `v1_history_id::uuid` and the apply aborted. Nulled at map time, hash identity instead, per the 2026-08-14 ruling that had never been built. Equip clean 1368/1368; JOY boxes clean 23/23 | Closed |
| **HISTID-HASH-COST** | **NEW — recorded divergence.** The 27 BVSC NY boxes now match on row hash, so a v1-side edit between two imports reads as delete-plus-insert rather than update. The cost the Aug-14 ruling chose over widening the column; now reported per row in the variance list | Recorded |
| **FENCE-STALE** | **CLOSED Aug 22 at `41d1002`.** `CLAUDE.md`'s run fence sat three units stale and told CC that S4-3 leg 6 — closed Aug 19 — was next. Rewritten, surgery confined by sha256 on both halves. Standing lesson amended: **whoever measures updates the fence in the same pass** | Closed |
| **TESTCOUNT** | **NEW — correction of record.** `1975/121` is TESTS / TEST FILES, not passing / skipped; the suite has zero skipped. An Arch handoff misread it and instructed CC on the wrong number. Notation warning now in `CLAUDE.md`'s run fence, this Roadmap, the Ledger and the Session Log header | Propagated |
| **GATE-NEST-UPGRADE** | **NEW — RULED Aug 22.** `subpixel-wander/box-nesting-error-single-px` earned its second observation at exactly its registered coordinate (`184,358`, 1 px, Δ1), which its own `refineBy` says upgrades it on the spot. Drop `provisional`, retire `refineBy`. No bbox widens, no delta changes; DIFF-EXC-BOUND's trigger untouched. Does **not** contradict REPRO-SUSPECT | Rides PORT-COV leg 2 |
| **GATE-LOAD-AUDIO** | **NEW.** The load gate refused twice for ~20 minutes with Logic Pro, QL Editor, QLab and Dante Virtual Soundcard live, passing at 3.79. `--force-load` correctly never used. A **scheduling** question, never a reason to loosen the ceiling | BATCH-HARNESS |
| **SMOKE-LOGIN-HYDRATION** | **NEW.** Three smoke runs died on a `waitUntil: 'domcontentloaded'` goto making the Sign In click a silent no-op — no console error, no failed request. Folded into CC's own smoke memory | Recorded |
| **BOX-NOBOX** | **RULED Aug 22, unimplemented.** `Box = "0"` is v1's affirmative no-box marker → `equipment_items.no_box_needed`. Of BVSC NY's 335 such rows only **4** are label rows; **331** are ordinary gear across 18 categories, against **12** genuinely blank. Needs an RPC arm (migration), plan work, and a **`CLAUDE.md` addition at line 817** — an owed propagation item | Ruled; rides its implementing leg |
| **BOX-REPARENT** | `import_apply_v1`'s nesting second pass reads `ops.box_details.INSERTS` only. A first import nests correctly; **a re-import cannot RE-PARENT an existing box.** Closing it is a migration | BATCH-BOX or next RPC touch |
| **DIV-AMBIG-CLEAR** | **Intent RULED Aug 22, fix deferred.** Omitted-because-ambiguous is not absent; the plan must carry a distinct marker. Unreachable today | Next RPC touch |
| **IMPRPT-COPY** | Two report-copy defects, no data impact: the Equipment line renders the sheet-diff count while the sentence beneath describes the plan's; the nested-box count is computed and never displayed | Next import-page touch |
| **BUILDSHEET-CMT** | `buildSheet.ts:318-322` still says `box_number` "is `numeric` at HEAD." Arch's own propagation obligation | Next touch of that module |
| **BOX-NAME-UNIQ** | A box's name is `equipment_items.description` and nothing constrains it; one project already carries two boxes sharing a name | On recurrence, or BATCH-BOX |
| **BOX-TYPE-LIB** · **BOX-TYPE-AMBIG** · **NEWBOX-FREETEXT** | **RULED Aug 22, SHIPPED** | Closed |
| **BOX-TYPES-DIM-DROP** | `box_types.dimensions` is dead — 0 of 125 rows populated | BATCH-HOUSEKEEPING |
| **BOX-ALPHA-UNSAMPLED** | All populated BVSC NY and JOY box numbers are plain integers (JOY has one `5.5`). `199A` is exercised by fixtures and Daniel's gate only | Standing caution |
| **BVSC-RF** | BVSC NY is the only export carrying `circuits.xlsx` / `rf cast.xlsx` / `rf gear.xlsx` / `rf roles.xlsx` | Post-beta RF work |
| **EQUIP-LABELS-2** | BVSC NY's `equip.xlsx` produces 286 variance entries, all `unrecognized FileMaker boolean value "2"` on `Labels`. Pre-existing | Next equipment-import touch |
| **GATE-THEMEGLYPH** | Δ42 light-only diff on the topbar theme-toggle glyph. Intermittent, capable of reproducing byte-identically. **NEVER register it.** Did not fire Aug 22, either run | BATCH-HARNESS / H3 |
| **REPRO-SUSPECT** | Inference rule: *a byte-identical reproduction is strong evidence but not proof of determinism; one contrary run refutes it, one confirming run does not establish it* | Standing |
| **SENT-BUNDLE** | Daniel's ruling owed: derive Contents from `cable_details.labeled`, or drop as a recorded divergence | Daniel's word |
| **BOX-TYPE-VOL** · **BOX-LABEL-COUNTS** · **BOX-EXPORT-ORDER** · **SHOP-ORDER-NOTES** | unchanged from v4.3 | |
| **BUNDLE-FIND** · **SED-GUARD** · **DEV-SERVER-AGE** · **REPO-WEIGHT** | unchanged from v4.3 | |
| DIFF-EXC-BOUND | Bound registry sites by area × maxPixels. Trigger remains the first site registered above maxChannelDelta 1 — untouched by GATE-NEST-UPGRADE | Bound owed before any Δ>1 site |
| METHOD-FIX · PRINT-REDO · PARITY-PAIR · GATE-PDF · GATE-OL25WR · GATE-C4 · S504 · CONCEPT-A · UNALLOC · EFFGRP · DOOR-V1LINK · CABLE-LOADER | unchanged from v4.3 | |
| RULINGS-WANTED | REV-STAMP · (ff) tab strip · (dddd) `#` headings · IMP-SORT · BAND-EDITOR sequencing · `no_box_needed` vs the yellow | Icebox sweeps |

### BATCH

| Batch | Members |
|---|---|
| **BATCH-HARNESS** (after the box legs + SHARE, per R-V) | H3 · GATE-THEMEGLYPH · GATE-COUNTWAIT · GATE-DLGRACE · GATE-FIXDIRTY · GATE-LOADPROXY · VIS-ENVFILE · DEV-SERVER-AGE · **GATE-LOAD-AUDIO** |
| **BATCH-AC** (after private beta starts, R-AG) | unchanged from v4.3 |
| **BATCH-BOX** (post-private-beta) | unchanged · BOX-NAME-UNIQ · BOX-REPARENT |
| **BATCH-EXPORT** | ~~leg 1 export~~ ✅ · ~~ARCH-MIG-BOX~~ ✅ · ~~leg 1b~~ ✅ · ~~MIRROR-SYSMETHOD~~ ✅ · ~~HISTID-UUID~~ ✅ · **leg 2 (cable)** |
| **BATCH-PREBETA** | SHARE (build-prep DONE) · (ppp) settings header · ADM-1 · AUTH-DOMAIN · 3TL · DEPS · CL-HILITE · GCM |
| **BATCH-HOUSEKEEPING** | LINT · SRGRANT sweep · ST-RACE · CTF-SEED · SLOT-AUDIT residue · REPO-WEIGHT · BOX-TYPES-DIM-DROP · **PROJ-CLEAN-2** |

### ICEBOX

Unchanged from v4.3.

## ❓ Open Questions (live only)

- ~~**What shape should MIRROR-SYSMETHOD's fix take?**~~ **CLOSED Aug 22 — plan-side (a) now, RPC-side (b) rides the next migration.**
- **Does the operator need the report to say a system row was protected?** Today the Methods delete count simply reads 0 and nothing explains why it is not 1. Not blocking; no data is hidden.
- **Should the HISTID-HASH-COST wording be sharpened?** The 27 affected boxes lose a stable v1 identity and the variance list says so per row — but the operator-visible consequence (a v1-side edit reads as delete-plus-insert) is not spelled out in the report.
- **Do the 39 boxes whose types BOX-TYPE-LIB created want dimensions?** They import with `type_name` only. Not blocking.
- **What actually moves the theme-toggle glyph?** The module-graph hypothesis is unproven and was never tested.
- The own-truck vs resolve-up reading on box labels is unobservable by construction.
- `box_default_large_labels` 5 (OQ4 ruled) vs the v1 panel's `#Big Labels 2`.
- v1 continuation header · cover-page body size → PRINT-REDO.
- Script 551 extraction · cable Change All checkbox eligibility · house-wide Cancel semantics · Used∩Ignored · empty-string note · link `field_name` CHECK backstop · cable-type RENAME affordance · CL a-1 uploads · d2_01 red Members count · CL multi-letter-per-project · stale-category healing · CC credit-budget policy · OQ#2b own-band pendency · band-cascade harmonization.

---

*End of Roadmap v4.4 — August 22, 2026. **Retires Roadmap v4.3**. Units of record: MIRROR-SYSMETHOD + METHOD-DUP/CAT-DUP (`4c234dd..d39179a`) and HISTID-UUID + FENCE-STALE (`d39179a..41d1002`). Handoffs `to-cc/260822-2020_mirror-sysmethod.md` and `to-cc/260822-2234_histid-uuid.md`; returns in `from-cc/` under the same names. History: `Minotaur_v2_Ledger_v1_0.md`.*
