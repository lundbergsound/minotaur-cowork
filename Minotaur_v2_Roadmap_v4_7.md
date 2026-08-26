# 🗺️ ROADMAP — Minotaur v2 (v4.7)

**Version 4.7 • August 26, 2026 • Forward-only file — history lives in `Minotaur_v2_Ledger_v1_0.md`**

## 🧭 Next Sessions (RM-6 — plain English, kept current)

- **TWO UNITS CLOSED.** **2-MIG-b applied** — the five gap arms, migration ledger **54 → 55**. **2-IMP-b closed at `e17fd97`** (`9a140ca..e17fd97`, 33 files, +4161/−198): `cable.xlsx`, `lines.xlsx` and `tails.xlsx` are mapped sheets now — **162 columns** — and the v1→v2→v1 round trip is **100% on all three corpora**.
- **⚠ THE DELETE UNIVERSE DID NOT WIDEN, AND MUST NOT.** v4.6's Sprint Plan row said 2-IMP-b "widens `MIRROR_SCOPED_TYPE`". **That was wrong and is corrected here** — the instruction was withdrawn mid-unit after CC refused it. The mirror's delete universe is `type = 'generic'` spine rows ONLY; cables, tails, mult lines, boxes, bundles and cable types mirror through **their own insert/update-only partitions**. `boxPlan.ts:30-35` names the trap: putting non-generic spine rows back into that universe *"is the data-loss bug that scoping closed."* `MIRROR_SCOPED_TYPE` had **zero production callers** and is now WIRED into the live fetch, with a DO-NOT-WIDEN header and a test whose only job is to fail if someone widens it. `mirrorFingerprintCount` is untouched.
- **IN FLIGHT: PRINT-PARITY unit 1, the box label family.** Handoff issued `to-cc/260826-1445_print-parity-box.md`; CC live. Autonomous shape — four safety hard-stops absolute, **ambiguous evidence is log-and-skip**. One commit at the end.
- **NEXT AFTER IT: 2-IMP-c** (clone links by recompute), then **2-MIG-c** (SPLITOF-NO-ARM).
- **R-7 · CABLE LABEL SETS, ruled by Daniel Aug 26.** v1's `Number of Small/Big Labels` and the five `tails` label columns are counts of **SETS**, not of ends — v1 script `201_4.5 Cable Labels.txt` duplicates the whole label record *"until we have a copy for each set of labels"*, and v1's own column is named `Sets of Line Labels`. v2 already prints one set as two cells, one per end (P7), and its cable UI is a checkbox with no count. **v2 prints ONE set; the count collapses to a boolean; NO migration.** 32 corpus rows are affected and they are a **ruled deprecation, not a loss**.
- **⚠ A deprecated capability makes round-trip inequality EXPECTED**, and the acceptance bar must NAME it rather than fail on it — otherwise the next session reads a deprecation as a regression and fixes it back. R-6's `Wire Type` is the precedent; R-7 joins it.
- **Counts at `e17fd97`:** suite **2268 tests across 128 test files, ZERO skipped** · frozen **3/3 vs `be0769de`** · typecheck 0 · dependency gate empty · build clean · visual **INTERMITTENT at GATE-THEMEGLYPH — run 1 26/28, run 2 28/28 on the SAME tree, both recorded, no baseline written.**
- **⚠ COUNT NOTATION (TESTCOUNT):** `2268/128` is **TESTS / TEST FILES**, never passing / skipped.
- **⚠ `npm run lint` CANNOT RUN.** `next lint` is a removed command and no eslint config is tracked. Any handoff naming a lint gate names an unsatisfiable gate. Registered under **LINT**.
- **Arch Prompt v32 installed, retiring v31.** A single-rule amendment: **the `COMMIT APPROVED:` phrase now authorises the PUSH as well as the commit**, one step, and every WF-1a commit closes with a plain-text **`_CLOSE.txt`** handoff for Arch. **Both are INERT until FENCE-PUSH lifts the two enforcement layers** — `git push` is denied in `.claude/settings.json` AND in the bash fence, which calls it *"Strat invariant 1"*, so the lift is a Strat-tier ruling carried down, not Arch's. **Consequence stated rather than left inferable: a WF-1a commit becomes a production DEPLOY.**
- **⚠ Two new standing rules, both earned by measurement.** **TENSE-IS-A-CLAIM:** *an expectation written in the past tense is indistinguishable from a measurement to whoever reads it next* — CC wrote a `28/28` it had good reason to expect into four places including `CLAUDE.md`'s run fence, then found and corrected all four itself. And: **a symbol with no production callers is not "low blast radius" — it is DEAD CODE, and reading it as authoritative is how an instruction gets written against a module that governs nothing.**
- **⚠ GATE-THEMEGLYPH reproduced TO THE DIGIT and is owed a diagnosis.** Topbar theme-toggle glyph, **19 judged px, 172 and 3706 measured, max Δ42, bbox `1273,14–1307,32`**, light frames only — identical to the Aug-21 record, five days apart on a different tree, where the same tree then passed 28/28. The intermittency is visible **inside** the two runs: light frames in run 1, dark in run 2. **NEVER register it.** Scoped as its own unit.
- **Install path (Arch v32):** the Arch seat writes close files to the mount **and** to claude.ai project knowledge. Daniel does not. Archives excluded.
- **Pre-open:** refs from ref files, never git · check for an orphaned `index.lock` · migration ledger **55** · Vercel READY at `e17fd97`. One untracked stray remains at `docs/reference/evidence/equipment/`.
- **Rollover:** clear. Session Log at 6 entries.
- **Bulk data (R-AL, standing):** never route rows through a model context. *The Aug-26 Ledger append was made on disk under this rule.*
- **Gate standing notes:** `npm run test:visual` does not run — use `node --env-file=.env.local scripts/visual-capture.mjs --gate` (VIS-ENVFILE). **`--force-load` forbidden** (GATE-LOAD-AUDIO). **NEW: the harness calls any listener on `:3000` a dev server without checking (GATE-DEVCHECK) and has no port override (GATE-PORT)** — together they cost two fail-harded runs measuring a production build.
- **At Daniel's desk:** **R8-DRILL, OVERDUE — SIX DAYS** · **OQ-1, the colour-table ruling** (blocks every `minotaurColors.ts` edit) · **FENCE-PUSH**, a Strat-tier lift · **PRINT-FOUNDSET, now amended by R-7** · **METRIC-UNRUN's browser gate** (input half testable now: type `150m` on an imperial show) · the CAND-4 texts · **PROJ-CLEAN-2** · GIT-CFG · commit + push `Minotaur-Cowork`.

## Lineage (full change-log lives in the Ledger)

| Version | Date | Closed | Retires |
|---|---|---|---|
| **v4.7** | Aug 26 | **2-MIG-b APPLIED** (ledger 54→55) · **2-IMP-b closed at `e17fd97`** · **R-7 ruled** · CABLE-IDENTITY-GAP's mult-line half · BRANCH-NO-ARM · LINES-PRINTLIST-NOEXPORT · LEN-INPUT-SUFFIX · LABELCOUNT-BOOL (→R-7) · **Arch Prompt v32** · **§2.2 withdrawn — the delete universe does NOT widen** · SPLITOF-NO-ARM, FENCE-HEREDOC, FENCE-PUSH, GATE-DEVCHECK, GATE-PORT, LINECOLOR-ZERO, TENSE-IS-A-CLAIM registered · PRINT-PARITY unit 1 issued | v4.6 |
| v4.6 | Aug 24 | **2-MIG APPLIED** (ledger 52→54) · **2-IMP-a closed at `af04251`** · **FENCE-COMMITA at `9a140ca`** · DEFTAILS-OVERBROAD · CC-BASHWRITE closed harness-side · DOMAIN-NOT-CHECK registered · the worktree question closed NO | v4.5 |
| v4.5 | Aug 23 | PORT-COV leg 2 SCOPED (5 units) · 2-EXP closed at `9c41b37` · eight rulings · two dangle figures struck · OQ1: re-import is a product requirement | v4.4 |
| v4.4 | Aug 22 (evening) | MIRROR-SYSMETHOD + METHOD-DUP/CAT-DUP at `d39179a` · HISTID-UUID + FENCE-STALE at `41d1002` · the first complete BVSC NY mirror import · GATE-NEST-UPGRADE ruled | v4.3 |

## Current Status (August 26, 2026)

Live at `https://minotaur.app` at **`e17fd97`**, pushed (`9c41b37..af04251..9a140ca..e17fd97`). Migration ledger **55**. Counts: suite **2268 tests / 128 test files, zero skipped** · frozen **3/3 vs `be0769de`** · typecheck 0 · dependency gate empty · build clean · visual **intermittent at GATE-THEMEGLYPH, recorded as such**. Governing set: **Arch Prompt v32** (retiring v31) · Strategy v14 · **Roadmap v4.7** (retiring v4.6) + Ledger v1.0 (Aug-26 append). Session Log at **6 entries, rollover clear.** **In flight:** PRINT-PARITY unit 1. **Next:** 2-IMP-c → 2-MIG-c, then **R8-DRILL, overdue, six days**.

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
| PORT-COV leg 2 — 2-MIG, the RPC arms | ✅ | ledger 53 + 54, rehearsal-first |
| PORT-COV leg 2 — 2-IMP-a (types + bundles) | ✅ | `af04251` · round-trip 100% |
| FENCE-COMMITA — the bulk-staging guard | ✅ | `9a140ca` · a false NEGATIVE open since the fence was written |
| **PORT-COV leg 2 — 2-MIG-b, the gap migration** | ✅ **APPLIED** | **ledger 55**, rehearsal-first, pre-flight carried INSIDE the migration · five arms, all Arch's |
| **PORT-COV leg 2 — 2-IMP-b (cables + lines + tails)** | ✅ **CLOSED** | `e17fd97` · 33 files · **162 columns** · round-trip **100% on all three corpora** · own insert/update-only partitions, delete universe unchanged |
| **PRINT-PARITY unit 1 — the box label family** | **IN FLIGHT** | `to-cc/260826-1445_print-parity-box.md` · autonomous, log-and-skip · one commit at the end · needs no fresh v1 print run |
| **PORT-COV leg 2 — 2-IMP-c (clone links, by recompute)** | **NEXT** | carries CLONE-TOKEN and the `mult_line` link vocabulary; depends on R-2 |
| **2-MIG-c — the second gap migration** | QUEUED | **MIGRATION.** SPLITOF-NO-ARM. Trigger B |
| **GATE-THEMEGLYPH — the diagnosis** | QUEUED | its own unit; **never register it** |
| **FENCE-PUSH — lift the two push layers** | QUEUED | Strat-tier ruling; + `chmod +x`, + a battery proving bulk staging STILL blocked |
| PRINT-PARITY — the CABLE family | BLOCKED | **fresh v1 prints owed, normalised to one label set per R-7**, with a stated found set |
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
| R8-DRILL | Backup restore drill per R8 runbook; unblocks PORT-READY, feeds addendum §B, gates account/project cleanup | **OVERDUE** — hard stop before September (**6 days**) |
| **OQ-1 COLOUR-TABLES** | **NEW, and it blocks work.** v1 has TWO colour tables that agree on four values and disagree on two — Green **#66B132** (cable) vs **#008F00** (box labels), Red **#D90B00** vs **#FF2712**. v2 has one. Does v2 keep one (which?) or gain a second keyed to record type? **Blocks every `minotaurColors.ts` edit** | Before PRINT-PARITY's palette work |
| **PRINT-FOUNDSET** | **AMENDED BY R-7.** Fresh v1 cable print runs with a **stated found set**, print-to-PDF at 100%, **and label counts normalised to ONE SET** — otherwise the comparison reports a ruled deprecation as a defect. The July-11 run is 794 of 1,119 cables and is unreconstructable | Before PRINT-PARITY's cable family |
| **FENCE-PUSH** | **NEW.** Lift `Bash(git push *)` from `.claude/settings.json` and the `git push` matcher from `bash-fence.sh`, `chmod +x` the hooks, restart CC, and run a battery proving bulk staging and `commit -a` are STILL blocked. **The fence calls this "Strat invariant 1" — a Strat-tier ruling** | Before Arch v32's push clause is live |
| CAND-4 | Four personal texts to the named beta candidates | This week |
| HERO-PLURAL | `HERO_BID_TO_OPENING` goes plural | When Vape! Chicago opens |
| COMMS-REWRITE | R-W: Comms Prompt v9 deleted, rewritten from scratch | Before next Comms deliverable |
| LEGAL-SEP | September attorney engagement; addendum §F scope | September 2026 |
| COMMS-Q | October announcement to the v1 list | October |
| TOK-VC | Vercel token rotation | Private-beta start; hard ~Nov 8 |
| LIC-NOV · VERHIST | Licensing subsystem (+ ownership transfer) · durable version history | ~November |
| BRIEF-12 | Brief v1.2: terms-before-third-party-access · signup-state history · Communications section | Strat scheduling |
| GIT-CFG | git identity · Next 16 `middleware`→`proxy` · stray trees · the two `ORPHANED-index.lock.*` files in `Minotaur/.git/` | Housekeeping |
| PROJ-CLEAN-2 | The test user's dashboard carries **~20** projects, most of them `Amend2`/`FIX1`/`S3G-2` leftovers | Daniel's desk |

### EVENT

| ID | One line | Trigger |
|---|---|---|
| **PORT-COV-REIMPORT** | A v1 re-import path is a product requirement (Daniel, Aug 23): *if something doesn't work in v2, the user reverts to v1 immediately.* Acceptance is round-trip, not column order. **2-IMP-b met it: 100% on all three corpora**, with two ruled non-round-trips named rather than failed | Standing, binds every export unit |
| **SPLITOF-NO-ARM** | **NEW.** `cable_details.split_of_id` exists and the export emits `Split of` as a NAME, but `import_apply_v1` has no insert column and no second pass for it. Refused on import rather than emitting a key the RPC ignores; the loss is reported. **3 rows corpus-wide, all BVSC NY, all resolvable** | **Rides 2-MIG-c** |
| **FENCE-HEREDOC** | **NEW, and it is the SECOND hole in this guard in three days.** `bash-fence.sh` blocks `sed -i` and redirects but does NOT match `python3 - <<'EOF'` opening and rewriting a file. The Aug-13 scope widening covers the mechanism in words; the matcher does not cover it in fact. **Test the guard, do not read it** | Arch's, with FENCE-PUSH |
| **GATE-THEMEGLYPH** | Δ42 at the topbar theme-toggle glyph, **19 judged px, 172/3706 measured, bbox `1273,14–1307,32`**, light-only. Reproduced to the digit Aug 21 → Aug 26 on different trees; the same tree fails then passes. **NEVER register it** — Δ42 is not the Δ1 SUBPIXEL-WANDER the registry exists for, and DIFF-EXC-BOUND's bound is owed first | **Its own diagnosis unit** |
| **GATE-DEVCHECK** · **GATE-PORT** | **NEW.** The harness calls any listener on `:3000` a "dev server" without checking, and `BASE_URL` has no port override. Together they spent two fail-harded gate runs measuring a production `npm start` | BATCH-HARNESS |
| **LINECOLOR-ZERO** | **NEW.** `lines.xlsx`.`Line Color` carries v1's null-marker `'0'` on 59 BVSC NY and 27 JOY rows — 86 total. Not one of the fourteen colours, so it imports blank AND emits a variance line. Same idiom already ruled for `def tails`.`Method` | 2-IMP-c or BATCH-HOUSEKEEPING |
| **TENSE-IS-A-CLAIM** | **NEW standing rule.** An expectation written in the past tense is indistinguishable from a measurement to whoever reads it next. Earned when a `28/28` that had not happened reached four documents including `CLAUDE.md`'s run fence | Standing, binds both tiers |
| **DEAD-CODE-IS-NOT-SAFE** | **NEW standing rule.** A symbol with no production callers is not "low blast radius" — it is dead code. Reading `MIRROR_SCOPED_TYPE` as authoritative produced an Arch instruction to widen a delete universe the module did not govern | Standing, binds Arch |
| **CLONE-FLAG-DIVERGE** | **OPEN QUESTION, unproven.** Recompute reproduces v1's `Has Clones` on 19 of 23 cable fields; four Source/Destination Device and Connection columns over-assert. **The patch-relationship hypothesis must not enter a handoff as a fact** | Rides 2-IMP-c |
| **CLONE-TOKEN** | **RULED Aug 23.** Synthesise the `Link X` token deterministically from the link group's id | Rides 2-IMP-c |
| **R-7 LABEL SETS** | **RULED Aug 26.** v1's label counts are SETS; v2 prints one. The count collapses to a boolean. 32 corpus rows, reported as a deprecation | ✅ applied in 2-IMP-b |
| **METRIC-UNRUN** | All 27 live projects are `imperial`. The per-row metric path has **never met real data**. **The input half is now testable: a typed `150m` on an imperial show commits metres** (LEN-INPUT-SUFFIX, closed) | Daniel's browser gate |
| **LINK-ORPHAN** | `link_group_members.item_id` has no FK and is **100% orphaned live** — 210 members, 0 resolving. 2-MIG defends it at WRITE | BATCH-BOX or 2-IMP-c |
| **LEN-SCALE** | `cable_details.length_value` 853 rows at scale 1 vs 7 at scale 0; `bundles` 97 vs 2. **MECHANISM CORRECTED Aug 26:** the carried claim that PostgREST hides it is right in conclusion, wrong in mechanism — `to_jsonb(150.0::numeric)::text` is `"150.0"`, so the scale IS on the wire and JS `JSON.parse` is what normalises it. A non-JS consumer or a raw-text comparison WOULD see it | Standing caution |
| **HISTENTRY-NOTID** | `History Entry ID` is 100% non-UUID and **not unique** (279 distinct over 1,084). A timestamp despite the name. Never map it to an id column | Standing caution |
| **JOY-NAME-HYGIENE** | JOY carries 29 blank `cable.Name` rows and 40 with leading/trailing whitespace. **Do not trim cable names** — `coerceTextEmpty` was found TRIMMING them in 2-IMP-b and a verbatim coercion was added for that one column | ✅ defended in 2-IMP-b |
| **CABLE-AUDIT-TIME** | `_Create Time` / `_Modify Time` are real Excel **datetime** cells at second resolution. `*Person` has no v2 counterpart | Next export touch |
| **EXPRPT-STALE** | The export report lists **4 filenames of 14**, hardcoded at `settings/page.tsx:478`. Its at-rest hint text sits inside gate frame 06 | Its own small pass |
| **LINES-NOFK** | `lines.sourceID` / `destinationID` are 0-populated in all three corpora; the DDR confirms no relationship joins on them | Standing |
| **BOX-REPARENT** · **IMPRPT-COPY** · **BUILDSHEET-CMT** · **BOX-NAME-UNIQ** · **BOX-TYPES-DIM-DROP** · **BOX-ALPHA-UNSAMPLED** · **BVSC-RF** · **EQUIP-LABELS-2** · **HISTID-HASH-COST** · **SMOKE-LOGIN-HYDRATION** | unchanged from v4.6 | |
| **GATE-LOAD-AUDIO** · **REPRO-SUSPECT** · **SENT-BUNDLE** | unchanged from v4.6 | |
| **GATE-PDF** | **BUILT, and it stays OUT of the repo for now.** `handoffs/parallel/tools/pdfgeom2.py` — mode 1 (geometry) valid on any print; mode 2 (pixel diff) needs matched found sets and is not built. **It imports `pdfplumber`, so porting it into the repo is a DEPENDENCY CHANGE** — a CC hard-stop — and is its own unit. Carries a real fix: FileMaker and Chrome store font size differently, so a naive read of rotated output gives fractional garbage | Its own port unit |
| **BOX-TYPE-VOL** · **BOX-LABEL-COUNTS** · **BOX-EXPORT-ORDER** · **SHOP-ORDER-NOTES** · **BUNDLE-FIND** · **SED-GUARD** · **DEV-SERVER-AGE** · **REPO-WEIGHT** | unchanged from v4.6 | |
| DIFF-EXC-BOUND | Bound registry sites by area × maxPixels | **Owed before ANY Δ>1 site is admitted — GATE-THEMEGLYPH is why** |
| METHOD-FIX · PRINT-REDO · PARITY-PAIR · GATE-OL25WR · GATE-C4 · S504 · CONCEPT-A · UNALLOC · EFFGRP · DOOR-V1LINK · CABLE-LOADER | unchanged from v4.6 — **PRINT-REDO and PARITY-PAIR fold into PRINT-PARITY** | |
| RULINGS-WANTED | REV-STAMP · (ff) tab strip · (dddd) `#` headings · IMP-SORT · BAND-EDITOR sequencing · `no_box_needed` vs the yellow | Icebox sweeps |

### CLOSED THIS SESSION

**2-MIG-b** (ledger 55) · **2-IMP-b** (`e17fd97`) · **BRANCH-NO-ARM** (`def ends` now imports all twelve columns; self-references written, not filtered) · **DOMAIN-COLOR-BARE** · **MATCHED-BUNDLE-ID** · **BUNDLE-BOX-ONINSERT** · **BUNDLE-RENAME** (through a collision guard, so a rename cannot abort a whole import) · **CABLE-IDENTITY-GAP's mult-line half** (the third `export_mint_identity` partition — re-importing `lines.xlsx` used to ADD its lines a second time) · **LINES-PRINTLIST-NOEXPORT** · **LEN-INPUT-SUFFIX** · **LABELCOUNT-BOOL** (→ R-7, closed the day it opened) · **the two 2-MIG-b-stale bundle reports**.

### BATCH

| Batch | Members |
|---|---|
| **BATCH-HARNESS** | H3 · GATE-THEMEGLYPH *(promoted out — its own diagnosis unit)* · **GATE-DEVCHECK** · **GATE-PORT** · GATE-COUNTWAIT · GATE-DLGRACE · GATE-FIXDIRTY · GATE-LOADPROXY · VIS-ENVFILE · DEV-SERVER-AGE · GATE-LOAD-AUDIO |
| **BATCH-AC** (after private beta starts, R-AG) | unchanged from v4.6 |
| **BATCH-BOX** (post-private-beta) | unchanged · BOX-NAME-UNIQ · BOX-REPARENT · **LINK-ORPHAN** |
| **BATCH-EXPORT** | ~~leg 1~~ ✅ · ~~ARCH-MIG-BOX~~ ✅ · ~~leg 1b~~ ✅ · ~~MIRROR-SYSMETHOD~~ ✅ · ~~HISTID-UUID~~ ✅ · ~~**2-EXP**~~ ✅ · ~~**2-MIG**~~ ✅ · ~~**2-IMP-a**~~ ✅ · ~~**2-MIG-b**~~ ✅ · ~~**2-IMP-b**~~ ✅ · **2-IMP-c** · **2-MIG-c** |
| **BATCH-PREBETA** | SHARE (build-prep DONE) · (ppp) settings header · ADM-1 · AUTH-DOMAIN · 3TL · DEPS · CL-HILITE · GCM · **EXPRPT-STALE** |
| **BATCH-HOUSEKEEPING** | **LINT** · **FENCE-HEREDOC** · **FENCE-PUSH** · **LINECOLOR-ZERO** · SRGRANT sweep · ST-RACE · CTF-SEED · SLOT-AUDIT residue · REPO-WEIGHT · BOX-TYPES-DIM-DROP · PROJ-CLEAN-2 |

### ICEBOX

Unchanged from v4.6.

## ❓ Open Questions (live only)

- **PRINT-PARITY's five, and OQ-1 blocks work:** **OQ-1 — v1 has TWO colour tables**, disagreeing on Green and Red; does v2 keep one or gain a second keyed to record type? **Blocks every `minotaurColors.ts` edit.** · **OQ-2** — Black has no measured hex on either side; do not assume `#000000` · **OQ-3** — does the SMALL box layout's Box Name carry a Conditional Formatting rule? A screenshot of the dialog settles it at source · **OQ-4** — are the cut rules wanted in v2? · **OQ-5** — which cell edge is the parity target, the printed rect or the FileMaker layout body?
- **Should un-boxing round-trip?** A blank box name does not clear an existing link on either the equipment or the bundle side, so a row removed from its box in v1 stays boxed in v2. Consistent across both sides deliberately; Daniel's ruling to change it.
- **Should "blank means clear" be ONE rule?** `branch_cable_type_id` and `tail_method_id` clear on an explicit blank; `box_id` on both sides does not. Each follows the precedent beside it in the same statement.
- **What actually drives the four over-asserting clone flags?** (CLONE-FLAG-DIVERGE.) Unproven.
- **Do the 39 boxes whose types BOX-TYPE-LIB created want dimensions?** Not blocking.
- **Does the operator need the report to say a system row was protected?** Not blocking.
- **Should the HISTID-HASH-COST wording be sharpened?**
- **What actually moves the theme-toggle glyph?** Now reproduced twice, five days apart, on different trees — and still undiagnosed.
- The own-truck vs resolve-up reading on box labels is unobservable by construction.
- `box_default_large_labels` 5 (OQ4 ruled) vs the v1 panel's `#Big Labels 2`.
- v1 continuation header · cover-page body size → **PRINT-PARITY**.
- Script 551 extraction · cable Change All checkbox eligibility · house-wide Cancel semantics · Used∩Ignored · empty-string note · link `field_name` CHECK backstop · cable-type RENAME affordance · CL a-1 uploads · d2_01 red Members count · CL multi-letter-per-project · stale-category healing · CC credit-budget policy · OQ#2b own-band pendency · band-cascade harmonization.

**CLOSED this session:** ~~Does a cable that prints 2 small labels in v1 need to print 2 in v2?~~ **NO — R-7: v1's count is SETS, v2 prints one, the count collapses to a boolean.** ~~Is the label-count collapse a data loss needing a migration?~~ **No — it is a ruled deprecation.** ~~Should 2-IMP-b widen the delete universe?~~ **NO — withdrawn mid-unit; own insert/update-only partitions instead.** ~~Does making cables deletable need a Daniel ruling?~~ **Already ruled, twice — boxes at leg 1b, bundles at 2-IMP-a; the posture is insert/update only.**

---

*End of Roadmap v4.7 — August 26, 2026. **Retires Roadmap v4.6**. Units of record: **2-MIG-b** (migration ledger 54→55) and **2-IMP-b** (`9a140ca..e17fd97`, 33 files, 162 columns). Suite 2191 → 2268 tests across 126 → 128 files. Governing set: **Arch Prompt v32** (retiring v31) · Roadmap v4.7 · Session Log at 6. Migration package of record: `drafts/260825_2-MIG-b_assembled.sql`. Scope of record for the cable side: `drafts/260823_portcov_leg2_scope.md`. In flight: PRINT-PARITY unit 1, `to-cc/260826-1445_print-parity-box.md`. History: `Minotaur_v2_Ledger_v1_0.md`.*
