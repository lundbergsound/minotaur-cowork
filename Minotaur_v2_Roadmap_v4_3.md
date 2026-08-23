# 🗺️ ROADMAP — Minotaur v2 (v4.3)

**Version 4.3 • August 22, 2026 • Forward-only file — history lives in `Minotaur_v2_Ledger_v1_0.md`**

## 🧭 Next Sessions (RM-6 — plain English, kept current)

- **PORT-COV LEG 1b IS CLOSED at `4c234dd`**, pushed. 47 files, **+3347 / −244**, suite **1865/117 → 1951/121**, frozen 3/3, visual 28/28 twice. The box sheets import: `boxes.xlsx` and `box types.xlsx` moved into `IMPORT_SPEC`, `box_number` is TEXT end to end, and Daniel's browser gate passed.
- **The live gap is CLOSED.** `box_details.box_number` widened to TEXT at ledger 52 this morning and the app caught up this afternoon. Box list sorting was wrong in production for roughly five hours across 4 projects / 2 owner accounts — knowingly accepted, scheduled, and now shut.
- **FIRST ACTION next session: `MIRROR-SYSMETHOD`.** A full v1 mirror import into any **newly created** project **aborts**. Found by Daniel's browser gate. The seeded `N/A - Labels Only` method (`is_system = true`, migration 44) is not in any v1 `methods.xlsx`, so the mirror plans to delete it and `guard_system_method` raises. **This is not leg 1b's defect** — it predates it and is the collision between P12's system rows (Aug 11) and the mirror delete path. Needs a ruling on shape: exclude system rows plan-side, or teach the RPC.
- **Then PORT-COV leg 2 — the cable side.** Net-new DDR extraction; WIRE-TYPE is RULED (deprecate), so the scope shrank.
- **SHARE build-prep is DONE and waiting** — `drafts/260821-1145_share_build_prep.md`. **Headline: seven project-scoped tables are owner-only, so sharing is broken at the CURRENT three roles, not just at the fourth.**
- **Governing set changed: Arch Prompt v31 installed, retiring v30** — a restructure, not an accretion. One seat (the claude.ai Arch seat is **retired**), a **one-writer** repo boundary replacing blanket read-only, three rules v28 had silently dropped **restored**, the close obligations consolidated into one `## Close` section, the **rollover moved to pre-open**, and the incident narratives moved to a Provenance appendix. **Discharges docket SEAT-MIG and the standing Seat-consolidation open question.**
- **Pre-open:** refs from ref files, never git · check for an orphaned `index.lock` · migration ledger **52** · Vercel READY at `4c234dd`. **`next-env.d.ts` will show modified — never committed.** Two untracked strays sit at `docs/reference/evidence/equipment/` and `docs/reference/_to_delete/`.
- **⚠ ROLLOVER IS DUE AT THE NEXT PRE-OPEN.** The Session Log stands at 10. Under Arch v31 the rollover is a pre-open step, not a close step — run it before any work, and **wait for Daniel's confirm before installing either file.**
- **Bulk data (R-AL, standing):** never route rows through a model context. Generator → payload file → loader executed where the network lives → one verification query.
- **Gate standing notes:** `npm run test:visual` does not run — use `node --env-file=.env.local scripts/visual-capture.mjs --gate` (VIS-ENVFILE). The harness spawns its own fresh dev server, so DEV-SERVER-AGE is satisfied by construction. **`--force-load` forbidden** — it was correctly refused at load 10.41 this session and retried instead. **GATE-THEMEGLYPH did not fire.**
- **At Daniel's desk:** **R8-DRILL, OVERDUE** · **BOX-REPRINT** · the CAND-4 texts · `HERO_BID_TO_OPENING` plural when Vape! Chicago opens · GIT-CFG strays · delete the `LEG1B GATE` scratch project and the two `_to_delete/` folders.

## Lineage (full change-log lives in the Ledger)

| Version | Date | Closed | Retires |
|---|---|---|---|
| **v4.3** | Aug 22 | **ARCH-MIG-BOX applied (ledger 52)** · **PORT-COV leg 1b closed at `4c234dd`** · the live gap opened and shut same day · **BVSC NY landed — Open Question closed** · four Daniel rulings (BOX-TYPE-LIB · BOX-TYPE-AMBIG · BOX-NOBOX · NEWBOX-FREETEXT) · **Arch Prompt v31**, retiring v30, discharging SEAT-MIG + Seat-consolidation · **MIRROR-SYSMETHOD found by the browser gate** | v4.2 |
| v4.2 | Aug 21 | R-AM discharged · leg 1 export half at `a243867` · BOX-NUM-TYPE and WIRE-TYPE ruled · SHARE build-prep | v4.1 |
| v4.1 | Aug 21 | S4-3 leg 6 entire at `8b078b2` · JOY + BVSC NY seeded · R-AL | v4.0 |

## Current Status (August 22, 2026)

Live at `https://minotaur.app` at **`4c234dd`**, pushed (`a243867..4c234dd`). **PORT-COV leg 1b shipped the box import half.** Migration ledger **52** (`arch_mig_box_widen_box_number_and_rpc_box_arms`, rehearsal-first with a clean forced rollback); `box_details.box_number` is **TEXT** across 162 rows with zero rendering change; `import_apply_v1` is **17,154 chars** with six box arms. Counts: suite **1951/121** · frozen **3/3 vs `be0769de`** · typecheck 0 · dependency gate empty · build clean · visual **28/28 twice** (loads 4.86 and 3.49). Governing set: **Arch Prompt v31** (retiring v30) · Strategy v14 · **Roadmap v4.3** + Ledger v1.0 (Aug-22 append). Session Log at **10 entries — rollover due at next pre-open.** **Next:** MIRROR-SYSMETHOD → PORT-COV leg 2 → **R8-DRILL, overdue**.

## 🏗 Sprint Plan (RM-7)

| Unit | Status | Ref |
|---|---|---|
| S4-1 decks-clear · S4-2 S4-AUTO | ✅ | Aug 10–11 · `1f06092` |
| MMM-CAT (category sub-band editable) | NEVER-RAN | re-issue fresh on scheduling |
| S4-3 legs 0–6 (box family) | ✅ | `6d52921` · `8461c2a`+`254ec1c` · `23a34d6` · `07150e6` · `8b078b2` |
| PORT-COV leg 1 — box EXPORT half | ✅ | `a243867` |
| **ARCH-MIG-BOX — the migration** | ✅ | ledger 52, `20260822144022`, rehearsal-first |
| **PORT-COV leg 1b — box IMPORT half** | ✅ **CLOSED** | `4c234dd` · 47 files · browser gate passed |
| **MIRROR-SYSMETHOD** | **NEXT** | Mirror import into a new project aborts on the system method. Ruling owed on shape |
| **PORT-COV leg 2 — cable side** | **NEXT, after** | Net-new DDR extraction; WIRE-TYPE ruled out |
| HARNESS H1 · H2 · H4 | ✅ | `e55269c` · `ddcf929` · `13a8233` |
| DOOR + LANDING | ✅ | `e92f2c9` |
| S4-mid: D-2b + BASE-EVT (FOCUS-MP in headroom) | QUEUED | |
| S4-late: GS-C → LINE-STECK (+STECK-COLOR) → S3-G-2 (+UNFLAG-WARN) → ALLOC | QUEUED | deferred by the Aug-21 sequencing ruling |
| S4-close: GBD | QUEUED | |
| Sprint-4 close reviews: WF1A-SUNSET · auto-mode rider EXPIRES · COWORK-PORT · PRINT-REDO if opened | QUEUED | **SEAT-MIG discharged at v31** |
| KKK-PASS (narrow-window responsive) | after Sprint 4 | |
| **Pre-beta: SHARE build → ADM-1 · AUTH-DOMAIN · 3TL · DEPS · CL-HILITE · GCM (R-AH)** | QUEUED | BATCH-PREBETA |
| **AC pass (BATCH-AC)** | after private beta STARTS (R-AG) | own trigger |
| Post-beta: BATCH-BOX · Maintenance · Spreadsheet Export · **RF/Walkies/Circuits (evidence now exists — BVSC-RF)** · IAS Import · real-time collab · licensing ~Nov · PWA | QUEUED | |

## 📌 Docket

### DATED

| ID | One line | When |
|---|---|---|
| R8-DRILL | Backup restore drill per R8 runbook; unblocks PORT-READY, feeds addendum §B, gates account/project cleanup. Acknowledged Aug 22 — register entry, not a prompt | **OVERDUE** — hard stop before September |
| BOX-REPRINT | v2's five box outputs printed at 100% against the arbiters — the only valid parity evidence for AMEND-1/2/3 | Daniel's desk |
| CAND-4 | Four personal texts to the named beta candidates | This week |
| HERO-PLURAL | `HERO_BID_TO_OPENING` goes plural | When Vape! Chicago opens |
| COMMS-REWRITE | R-W: Comms Prompt v9 deleted, rewritten from scratch | Before next Comms deliverable |
| LEGAL-SEP | September attorney engagement; addendum §F scope | September 2026 |
| COMMS-Q | October announcement to the v1 list | October |
| TOK-VC | Vercel token rotation | Private-beta start; hard ~Nov 8 |
| LIC-NOV · VERHIST | Licensing subsystem (+ ownership transfer) · durable version history | ~November |
| BRIEF-12 | Brief v1.2: terms-before-third-party-access · signup-state history · Communications section | Strat scheduling |
| GIT-CFG | git identity · Next 16 `middleware`→`proxy` · stray trees · **`LEG1B GATE` scratch project · `Minotaur/docs/reference/_to_delete/` · `Minotaur-Cowork/drafts/_to_delete/` · `Minotaur_v1_exports/BVSC_NY/_to_delete/`** | Housekeeping |

### EVENT

| ID | One line | Trigger |
|---|---|---|
| **MIRROR-SYSMETHOD** | **NEW — LIVE DEFECT, found by Daniel's browser gate Aug 22.** A v1 mirror import into a **new** project plans to delete the seeded `N/A - Labels Only` method (`is_system`, migration 44) because no v1 `methods.xlsx` carries it; `guard_system_method` raises at trigger depth 1 and **the whole apply aborts**. Nothing corrupts — it fails after writing the revision snapshot. Predates leg 1b. **Ruling owed: exclude system rows plan-side, or teach the RPC.** Categories are unaffected (no guard) | **NEXT SESSION** |
| **BOX-NOBOX** | **NEW — RULED Aug 22.** `Box = "0"` is v1's affirmative **no-box marker**, not a label-only artifact: of BVSC NY's 335 such rows, only **4** are label rows; the other **331** are ordinary gear across 18 categories, against just **12** rows with `Box` genuinely blank. Maps to `equipment_items.no_box_needed` (flag, migration 45). Today those rows import `box_id` null — right outcome, wrong report word. **Needs an RPC arm (migration) + plan work + a CLAUDE.md addition at line 817** | Ruled; rides its implementing leg |
| **BOX-REPARENT** | **NEW.** `import_apply_v1`'s nesting second pass reads `ops.box_details.INSERTS` only — verified in the live body. A first import nests correctly (BVSC NY's 22, proven); **a re-import cannot RE-PARENT an existing box.** Existing nesting is preserved, not clobbered, and the dry-run says so in amber. Closing it is a migration | BATCH-BOX or next RPC touch |
| **DIV-AMBIG-CLEAR** | **NEW — intent RULED Aug 22, fix deferred.** An ambiguous box-type name is omitted from the plan, and DIV-1 reads an absent name as *clear the type* — so ambiguity would CLEAR rather than LEAVE, the opposite of what both divergences intend. Unreachable today (zero live duplicate type names; the workbook dedupes first-wins). **Ruling: omitted-because-ambiguous is not absent; the plan must carry a distinct marker. Fix when the RPC is next opened — do not spend a migration on it alone** | Next RPC touch |
| **NEWBOX-FREETEXT** | **NEW — RULED Aug 22.** The New Box dialog's "must be a whole number" check is **removed** and stays removed: it became false when the column became text and it refused `199A` *and* `5.5`, a real JOY value. Shipped in `4c234dd` | Closed |
| **IMPRPT-COPY** | **NEW — two report-copy defects, no data impact.** (1) The Entity table's Equipment line renders the **sheet-diff** count (1368) while the sentence beneath says the box spine rows "are counted again inside the Equipment line" — true of the plan (`ops.equipment_items` = 1502, spine merged at `plan.ts:204`) and false of the printed number. (2) **The nested-box count is never shown** — the plan computes it (22 for BVSC NY) and the UI omits it, on the only corpus that has nesting | Next import-page touch |
| **BUILDSHEET-CMT** | **NEW — RULED Aug 22, rides the next pass.** `buildSheet.ts:318-322` still says `box_number` "is `numeric` at HEAD and becomes TEXT in the Arch migration." Arch's success condition 6 ("buildSheet untouched") forbade the fix; CC left it and flagged it, correctly. **Arch's own propagation obligation** | Next touch of that module |
| **BOX-NAME-UNIQ** | A box's name is `equipment_items.description` and nothing constrains it; **one project already carries two boxes sharing a name**, measured. DIV-2's exactly-one-match is the handling, not the fix | On recurrence, or BATCH-BOX |
| **BOX-TYPE-LIB** | **RULED Aug 22, SHIPPED.** v1's `box types.xlsx` is a **shared library, not a project's set** (JOY exports 61 types for a project using 3), **and v1 does not constrain a box's type to it** — BVSC NY carries 18 free-hand names on 39 boxes. The plan **creates** them via `ops.box_types.inserts` — **never `createMissing`**, which covers categories and methods only and would ignore a `box_types` key in silence | Closed |
| **BOX-TYPE-AMBIG** | **RULED Aug 22, SHIPPED.** The RPC resolves a box-type name with `order by t.id limit 1` while `box_types` carries only a PK and a project FK — nothing makes `type_name` unique. Zero live duplicates. Fixed client-side (exactly-one-match); the RPC's `limit 1` stays a backstop, no migration | Closed; RPC asymmetry recorded |
| **BOX-TYPES-DIM-DROP** | `box_types.dimensions` is dead — **0 of 125 rows populated**, superseded by width/depth/height. Not mapped | BATCH-HOUSEKEEPING |
| **BOX-ALPHA-UNSAMPLED** | All 131 populated BVSC NY box numbers and all 23 JOY ones are plain integers (JOY has one `5.5`). **`199A` is exercised by synthetic fixtures and Daniel's browser gate only** — no corpus carries it | Standing caution |
| **BVSC-RF** | BVSC NY is the **only** export carrying `circuits.xlsx` / `rf cast.xlsx` / `rf gear.xlsx` / `rf roles.xlsx` — first evidence for post-beta RF/Walkies/Circuits. `REGISTER_NOT_IMPORTED` spells them capitalised; matching is case-insensitive (`spec.file.toLowerCase()`), so a display divergence, not a defect | Post-beta RF work |
| **EQUIP-LABELS-2** | **NEW.** BVSC NY's `equip.xlsx` produced **286 variance entries**, all `unrecognized FileMaker boolean value "2"` on the `Labels` column. Equipment-side, pre-existing, not leg 1b's | Next equipment-import touch |
| **GATE-THEMEGLYPH** | Δ42 light-only diff on the topbar theme-toggle glyph at `1273,14–1307,32`. Intermittent, capable of reproducing byte-identically. **NEVER register it in the diff-exception registry.** Did not fire Aug 22 | BATCH-HARNESS / H3 |
| **REPRO-SUSPECT** | Inference rule: *a byte-identical reproduction is strong evidence but not proof of determinism; one contrary run refutes it, one confirming run does not establish it* | Standing |
| **SENT-BUNDLE** | Daniel's ruling owed: derive Contents from `cable_details.labeled`, or drop as a recorded divergence | Daniel's word |
| **BOX-TYPE-VOL** | `box_types.volume` is numeric while width/depth/height are text. **Not observed — BVSC NY's Volume cells are all numeric (7 of 58), dimensions all strings** | Same class as BOX-NUM-TYPE |
| **BOX-LABEL-COUNTS** | `num_large_labels`/`num_small_labels` are NOT NULL ints; a v1 blank imports as `0` and exports back as `0`. **Confirmed live in the browser gate's export** | Recorded |
| **BOX-EXPORT-ORDER** | Recorded divergence: v1's on-disk box order is its found-set order and is not reconstructable; v2 exports by name comparator | Recorded, no action |
| **SHOP-ORDER-NOTES** | `Shop Order Notes` → `public_notes` is corroborated, not ruled from a v1 statement | On contrary evidence |
| **BUNDLE-FIND** · **SED-GUARD** · **DEV-SERVER-AGE** · **REPO-WEIGHT** | unchanged from v4.2. **REPO-WEIGHT note: BVSC NY added ~10 MB to `~/Minotaur_v1_exports/`, outside both repos** | |
| DIFF-EXC-BOUND | Bound registry sites by area × maxPixels. GATE-THEMEGLYPH refused as the first Δ42 candidate | Bound owed before any Δ>1 site |
| METHOD-FIX · PRINT-REDO · PARITY-PAIR · GATE-PDF · GATE-OL25WR · GATE-C4 · S504 · CONCEPT-A · UNALLOC · EFFGRP · DOOR-V1LINK · CABLE-LOADER | unchanged from v4.2 | |
| RULINGS-WANTED | REV-STAMP · (ff) tab strip · (dddd) `#` headings · IMP-SORT · BAND-EDITOR sequencing · `no_box_needed` vs the yellow | Icebox sweeps |

### BATCH

| Batch | Members |
|---|---|
| **BATCH-HARNESS** (after the box legs + SHARE, per R-V) | H3 · GATE-THEMEGLYPH · GATE-COUNTWAIT · GATE-DLGRACE · GATE-FIXDIRTY · GATE-LOADPROXY · VIS-ENVFILE · DEV-SERVER-AGE |
| **BATCH-AC** (after private beta starts, R-AG) | unchanged from v4.2 |
| **BATCH-BOX** (post-private-beta) | unchanged · **+ BOX-NAME-UNIQ · BOX-REPARENT** |
| **BATCH-EXPORT** | ~~leg 1 export~~ ✅ · ~~ARCH-MIG-BOX~~ ✅ · ~~leg 1b~~ ✅ · **leg 2 (cable)** · ~~IMP-BOXCOL~~ ✅ · ~~IMP-SPINE-2~~ ✅ · ~~EXPORT-ORDER~~ ✅ |
| **BATCH-PREBETA** | SHARE (build-prep DONE) · (ppp) settings header · ADM-1 · AUTH-DOMAIN · 3TL · DEPS · CL-HILITE · GCM |
| **BATCH-HOUSEKEEPING** | LINT · SRGRANT sweep · ST-RACE · CTF-SEED · SLOT-AUDIT residue · REPO-WEIGHT · **BOX-TYPES-DIM-DROP** |

### ICEBOX

Unchanged from v4.2.

## ❓ Open Questions (live only)

- ~~**Where is the BVSC NY v1 export?**~~ **CLOSED Aug 22.** Landed at `~/Minotaur_v1_exports/BVSC_NY/2026-08-20_0120/`, 30 files, filenames verbatim. Verified at source: **134 boxes, 22 nested, all 22 parents resolving, zero duplicate box names, 129 typed.** The corpus now holds a real nested-box sample, and it round-trips.
- ~~**Seat consolidation**~~ **CLOSED Aug 22 — the claude.ai Arch seat is retired (Arch v31).** Discharges SEAT-MIG.
- **What shape should MIRROR-SYSMETHOD's fix take** — plan-side exclusion of `is_system` rows, or an RPC that refuses them? Plan-side is cheaper and needs no migration; RPC-side is the data-layer guarantee.
- **Do the 39 boxes whose types BOX-TYPE-LIB created want dimensions?** They import with `type_name` only. Not blocking.
- **What actually moves the theme-toggle glyph?** The module-graph hypothesis is unproven and was never tested.
- The own-truck vs resolve-up reading on box labels is unobservable by construction.
- `box_default_large_labels` 5 (OQ4 ruled) vs the v1 panel's `#Big Labels 2`.
- v1 continuation header · cover-page body size → PRINT-REDO.
- Script 551 extraction · cable Change All checkbox eligibility · house-wide Cancel semantics · Used∩Ignored · empty-string note · link `field_name` CHECK backstop · cable-type RENAME affordance · CL a-1 uploads · d2_01 red Members count · CL multi-letter-per-project · stale-category healing · CC credit-budget policy · OQ#2b own-band pendency · band-cascade harmonization.

---

*End of Roadmap v4.3 — August 22, 2026. **Retires Roadmap v4.2**. Units of record: ARCH-MIG-BOX (ledger 51 → 52, `20260822144022`) and PORT-COV leg 1b (`a243867..4c234dd`). Handoff `to-cc/260822-1505_port-cov-leg1b-box-import.md`; return `from-cc/260822-1123_port-cov-leg1b-box-import.md`. History: `Minotaur_v2_Ledger_v1_0.md`.*
