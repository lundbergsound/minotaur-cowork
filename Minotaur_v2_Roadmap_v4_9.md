# 🗺️ ROADMAP — Minotaur v2 (v4.9)

**Version 4.9 • August 27, 2026 • Forward-only file — history lives in `Minotaur_v2_Ledger_v1_0.md`**

## 🧭 Next Sessions (RM-6 — plain English. **HARD CAP: six bullets.** Every detail, ID and measurement lives in the Docket below and in the Ledger's dated appends. If a bullet needs a gloss to be read, it belongs in the Docket instead.)

- **Just shipped:** the last piece of the v1 import work. **All eight cable spreadsheets now import.** Live in production at `0468a5d`, deploy verified.
- **Next up:** one small database change (**2-MIG-c**). It carries two fixes — a missing import path for split cables, and the timeout below.
- **Broken, and a real user would hit it today:** importing a whole show **times out after 8 seconds and refuses.** Nothing is written when it does, so no data is at risk — but the import does not complete. This is the most urgent thing on the list.
- **Broken, quieter:** exporting leaves the identity tag off about a quarter of the cables, so exporting and re-importing **loses clone links**. No user has hit it. It is not the fault of the unit just shipped.
- **Cable printing is unblocked** — no more v1 printing is owed. Four of the eight cable printouts select the **wrong records**; fixing the selection comes before any layout work. Fully scoped and ready to hand off.
- **On Daniel's desk:** the **R8 backup drill** (overdue, five days) · whether v1's bundle links should import at all · three box-label reprints.

## Lineage (full change-log lives in the Ledger)

| Version | Date | Closed | Retires |
|---|---|---|---|
| **v4.9** | Aug 27 | **PORT-COV LEG 2 CLOSED — 2-IMP-c shipped at `0468a5d`** · CLONE-FLAG-DIVERGE closed against a UTF-16 DDR read · APPLY-TIMEOUT · EXPORT-HISTID-DROP · ROUNDTRIP-INMEM · ORIENT-FIXFAILED · both parallels folded in · the palette closed by Daniel's rulings | v4.8 |
| **v4.8** | Aug 26 (eve) | **PRINT-PARITY unit 1 CLOSED at `8c6b2e0`** · DEVICE-VM-IS-NOT-CC and CLOSE-THEN-CONTINUE registered · the Inspector-vs-print finding · the cable-parity evidence parallel opened · an Arch gate found unrunnable by any CC session | v4.7 |
| v4.7 | Aug 26 | **2-MIG-b APPLIED** (ledger 54→55) · **2-IMP-b closed at `e17fd97`** · **R-7 ruled** · CABLE-IDENTITY-GAP's mult-line half · BRANCH-NO-ARM · LINES-PRINTLIST-NOEXPORT · LEN-INPUT-SUFFIX · LABELCOUNT-BOOL (→R-7) · **Arch Prompt v32** · **§2.2 withdrawn — the delete universe does NOT widen** · SPLITOF-NO-ARM, FENCE-HEREDOC, FENCE-PUSH, GATE-DEVCHECK, GATE-PORT, LINECOLOR-ZERO, TENSE-IS-A-CLAIM registered · PRINT-PARITY unit 1 issued | v4.6 |
| v4.6 | Aug 24 | **2-MIG APPLIED** (ledger 52→54) · **2-IMP-a closed at `af04251`** · **FENCE-COMMITA at `9a140ca`** · DEFTAILS-OVERBROAD · CC-BASHWRITE closed harness-side · DOMAIN-NOT-CHECK registered · the worktree question closed NO | v4.5 |
| v4.5 | Aug 23 | PORT-COV leg 2 SCOPED (5 units) · 2-EXP closed at `9c41b37` · eight rulings · two dangle figures struck · OQ1: re-import is a product requirement | v4.4 |
| v4.4 | Aug 22 (evening) | MIRROR-SYSMETHOD + METHOD-DUP/CAT-DUP at `d39179a` · HISTID-UUID + FENCE-STALE at `41d1002` · the first complete BVSC NY mirror import · GATE-NEST-UPGRADE ruled | v4.3 |

## Current Status (August 27, 2026)

Live at `https://minotaur.app` at **`0468a5d`**, pushed, Vercel READY (`8c6b2e0..0468a5d`). Migration ledger **55**, unchanged. Counts: suite **2374 tests / 132 test files, zero skipped** · frozen **3/3 vs `be0769de`** · typecheck 0 · dependency gate clean · build clean · visual **intermittent, with one uncharacterised failure recorded as a gap**. Governing set: **Arch Prompt v32** · Strategy v14 · **Roadmap v4.9** (retiring v4.8) + Ledger v1.0 (Aug-27 append). Session Log at **8 entries, rollover clear.** **In flight: nothing. CC is IDLE; both parallels have returned.** **Next on the main line:** 2-MIG-c (SPLITOF-NO-ARM + APPLY-TIMEOUT) → EXPORT-HISTID-DROP → the staged box residuals → the cable selector pass. **R8-DRILL is overdue, five days.**

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
| **PRINT-PARITY unit 1 — the box label family** | ✅ **CLOSED** | `8c6b2e0` · worst element 51.35 pt → **0.63 pt** · geometry measured off the v1 PDFs, not derived from page ÷ grid |
| **CABLE-PARITY EVIDENCE — the parallel** | ✅ **CLOSED** | three returns · all 17 outputs data-derived · 11 grids measured in points · 3 sorts recovered · 8 v2 pairs measured · no repo writes, no CC handoff |
| **PORT-COV leg 2 — 2-IMP-c (clone links, by recompute)** | ✅ **CLOSED** | `0468a5d` · 31 files · 913 groups / 2036 members on BVSC NY · mult-line and bundle vocabularies ship COMPLETE and GATED · CLONE-TOKEN's export half landed · **leg 2 closed entire** |
| **2-MIG-c — the second gap migration** | **NEXT ON THE MAIN LINE** | **MIGRATION.** SPLITOF-NO-ARM **+ APPLY-TIMEOUT**. Trigger B; rehearsal-first; Daniel confirms before the apply |
| **EXPORT-HISTID-DROP — the cable export's identity projection** | QUEUED, and it blocks round-trip acceptance | 852 of 1,119 `HistoryID`s emitted against 1,119 identity rows live · 2-EXP / 2-IMP-b's, not 2-IMP-c's |
| **PRINT-PARITY unit 2 — the box residuals** | **STAGED, UNISSUED** | `handoffs/_staging/260826-1845_print-parity-box-ADDENDUM-1_DRAFT.md` · Stack underline · dashed grey cut rules (OQ-4) · Box-in-Box suppresses the Stack · revert `MC.BUNDLE_FLAG` |
| **GATE-THEMEGLYPH — the diagnosis** | QUEUED | its own unit; **never register it** |
| **FENCE-PUSH — lift the two push layers** | QUEUED | Strat-tier ruling; + `chmod +x`, + a battery proving bulk staging STILL blocked |
| **PRINT-PARITY — the CABLE family** | **UNBLOCKED and SCOPED** | **no fresh v1 print owed** · selectors → orientation → geometry · 4 content defects, ORIENT-FIXFAILED, 11 measured grids |
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
| R8-DRILL | Backup restore drill per R8 runbook; unblocks PORT-READY, feeds addendum §B, gates account/project cleanup | **OVERDUE** — hard stop before September (**5 days**) |
| **BUNDLE-LINK-IMPORT** | **NEW, and it is the one decision 2-IMP-c deferred.** v1's bundle-field link groups exist and were USED — **19 / 42 / 26** groups across BVSC NY / BVSC / JOY. `BUNDLE_LINK_VOCABULARY` ships complete with `enroll: false` on all eight and a DO-NOT-ENROLL test. Import them, or leave them out permanently? Flipping is 8 flags. **Arch's read: it is a PRODUCT question — v2 has no bundle lockstep surface, so a group imported today is a row nothing reads and nothing maintains** | Daniel's desk; not blocking |
| **OQ-1 COLOUR-TABLES** | **NEW, and it blocks work.** v1 has TWO colour tables that agree on four values and disagree on two — Green **#66B132** (cable) vs **#008F00** (box labels), Red **#D90B00** vs **#FF2712**. v2 has one. Does v2 keep one (which?) or gain a second keyed to record type? **Blocks every `minotaurColors.ts` edit** | Before PRINT-PARITY's palette work |
| **PRINT-FOUNDSET** | **PREMISE WITHDRAWN 2026-08-27 — all seventeen v1 cable outputs are DATA-DERIVED and none is Find-driven, so the July-11 PDFs are valid arbiters and NO fresh v1 cable print is owed. The two optional re-prints buy exactness, not access, and one needs Q-2 first. Previously read:** **AMENDED BY R-7.** Fresh v1 cable print runs with a **stated found set**, print-to-PDF at 100%, **and label counts normalised to ONE SET** — otherwise the comparison reports a ruled deprecation as a defect. The July-11 run is 794 of 1,119 cables and is unreconstructable | Before PRINT-PARITY's cable family |
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
| **APPLY-TIMEOUT** | **NEW, and it blocks a real user importing a real show.** `authenticated` carries `statement_timeout = 8s`; a full BVSC NY apply exceeds it and aborts. **Nothing is written — the single-transaction guarantee held under a real abort.** Last successful full apply was Aug 22, before cables had mappers; the payload has since roughly doubled. **REHEARSE: `SET LOCAL statement_timeout` inside the function may not extend a timeout already armed on the calling statement** | **Rides 2-MIG-c.** Trigger B |
| **EXPORT-HISTID-DROP** | **NEW.** `cable.xlsx` emits `HistoryID` on **852 of 1,119** cables though all 1,119 carry an identity row live (1,112 v1 + 7 assigned); blanks scattered over 203 runs, so a join that misses. Round trip drops **913 → 585 groups** and **2,036 → 1,276 memberships**. `cable clone links.xlsx` is faithful and blanks exactly those 267. **v1's `Import Show` is 28 `Method: Add` steps, so NO duplicates in v1 — the loss is identity continuity** | Its own unit; 2-EXP / 2-IMP-b's |
| **APPLY-PROMISE-GAP** | **NEW.** Dry run promised 913 groups / 2,036 memberships; the database holds **912 / 2,034**. One group and two memberships short, silently — the class the unit's own rule 6 was written against. One measurement, no guess | With EXPORT-HISTID-DROP |
| **ROUNDTRIP-INMEM** | **NEW standing rule.** The three-corpus round trip runs in memory against the same identity map and never calls the RPC or writes a byte of `.xlsx`. It proves the mappers, not the product. **Round-trip through the files and a fresh project.** Third gate this week found measuring something adjacent to what ships | BATCH-HARNESS |
| **GATE-NOGREP** | **NEW standing rule.** A visual-gate run piped through `grep` lost its verdict detail and its diff PNGs were overwritten, costing the only characterisation of a 26/28 failure. **Never pipe a gate run through a filter — write it to a file and read the file.** The Raw Output Rule's operational form | Standing, binds both tiers |
| **ORIENT-FIXFAILED** | **NEW.** Three landscape cable outputs print portrait with content rotated 90°, though `landscape` reaches BOTH `DocPrintCss` and `DocPage` in all three clients and `docChrome.tsx:209-222` already carries the explicit-dimensions fix — **whose own comment describes the symptom it failed to prevent.** One untested lead: a second top-level `@page { size: letter portrait }` at `PrintEquipmentListClient.tsx:912`; **whether it is ever mounted on a cable route was NOT measured** | Cable print unit, orientation pass |
| **STECK-ZERO** | **NEW.** `source_steck_count` / `destination_steck_count` are 0 on all 1,119 v2 cables where v1 carries 342. Mapped at `cableSheets.ts` and asserted in `cableRoundTrip.test.ts`, so inside 2-IMP-b's scope. Likeliest cause is that BVSC NY was seeded by `to-cc/bvscny-load.mjs` rather than run through the engine — **unverified** | Before Steck Labels is built |
| **HIST-BLIND** | **NEW.** v1's field-level audit lives entirely in OnObjectSave triggers, which `Replace Field Contents` does not fire. **Any scripted mass edit is invisible to `history`.** This bounds what that table can ever prove — and it is why Q-1's intent can never be closed from data | Standing caution |
| **CLONELINK-ROWSET** | **NEW, and named so it is not "fixed back."** v2 emits one clone-link row per cable and one per mult line — 1,671 for BVSC NY against v1's 596 — because **what selects v1's 596 is still unexplained** (not all cables, not all lines, and 28 of the 284 cable rows are in no group). A ruled divergence, not a defect | Standing |
| **LINKJOIN-FENCE** | **NEW.** `historyJoinKey` carries a comment saying it must never be used for identity. `MIRROR_SCOPED_TYPE`'s precedent says that wants a test whose only job is to fail if someone uses it | Next touch of the import mappers |
| **CLAUDE-HARNESS-STALE** | **NEW.** `CLAUDE.md`'s harness section still describes SUBPIXEL-WANDER site 4 as `provisional: true` with a `refineBy`; GATE-NEST-UPGRADE dropped both on the second observation and `screenshots/diff-exceptions.json` already carries the corrected reasoning. **Arch's stewardship; CC correctly refused to fix it inside a clone-links commit** | Rides the next handoff |
| **AUTH-REFRESH-HANG** | **NEW.** A failed Supabase refresh blocks every matched route for **~90 seconds** before falling through, because `src/middleware.ts` calls `getUser()` on everything but static assets. The user sees *"the app is broken"* where the truth is *"please sign in"* — and these users work in dark rooms under time pressure | BATCH-PREBETA |
| **PARALLEL-CLOCK** | **NEW, minor.** A parallel return named `260827-0020` and headed EDT was written at 20:04 EDT the previous evening, so it sorts ahead of openers written after it. The `YYMMDD-hhmm` convention is the ordering key | Standing, binds parallel openers |
| **PORT-COV-REIMPORT** | A v1 re-import path is a product requirement (Daniel, Aug 23): *if something doesn't work in v2, the user reverts to v1 immediately.* Acceptance is round-trip, not column order. **2-IMP-b met it: 100% on all three corpora**, with two ruled non-round-trips named rather than failed | Standing, binds every export unit |
| **SPLITOF-NO-ARM** | **NEW.** `cable_details.split_of_id` exists and the export emits `Split of` as a NAME, but `import_apply_v1` has no insert column and no second pass for it. Refused on import rather than emitting a key the RPC ignores; the loss is reported. **3 rows corpus-wide, all BVSC NY, all resolvable** | **Rides 2-MIG-c** |
| **FENCE-HEREDOC** | **NEW, and it is the SECOND hole in this guard in three days.** `bash-fence.sh` blocks `sed -i` and redirects but does NOT match `python3 - <<'EOF'` opening and rewriting a file. The Aug-13 scope widening covers the mechanism in words; the matcher does not cover it in fact. **Test the guard, do not read it** | Arch's, with FENCE-PUSH |
| **GATE-THEMEGLYPH** | Δ42 at the topbar theme-toggle glyph, **19 judged px, 172/3706 measured, bbox `1273,14–1307,32`**, light-only. Reproduced to the digit Aug 21 → Aug 26 on different trees; the same tree fails then passes. **NEVER register it** — Δ42 is not the Δ1 SUBPIXEL-WANDER the registry exists for, and DIFF-EXC-BOUND's bound is owed first | **Its own diagnosis unit** |
| **GATE-DEVCHECK** · **GATE-PORT** | **NEW.** The harness calls any listener on `:3000` a "dev server" without checking, and `BASE_URL` has no port override. Together they spent two fail-harded gate runs measuring a production `npm start` | BATCH-HARNESS |
| **LINECOLOR-ZERO** | **NEW.** `lines.xlsx`.`Line Color` carries v1's null-marker `'0'` on 59 BVSC NY and 27 JOY rows — 86 total. Not one of the fourteen colours, so it imports blank AND emits a variance line. Same idiom already ruled for `def tails`.`Method` | 2-IMP-c or BATCH-HOUSEKEEPING |
| **TENSE-IS-A-CLAIM** | **NEW standing rule.** An expectation written in the past tense is indistinguishable from a measurement to whoever reads it next. Earned when a `28/28` that had not happened reached four documents including `CLAUDE.md`'s run fence | Standing, binds both tiers |
| **DEAD-CODE-IS-NOT-SAFE** | **NEW standing rule.** A symbol with no production callers is not "low blast radius" — it is dead code. Reading `MIRROR_SCOPED_TYPE` as authoritative produced an Arch instruction to widen a delete universe the module did not govern | Standing, binds Arch |
| ~~**CLONE-FLAG-DIVERGE**~~ | ✅ **CLOSED 2026-08-27, with a mechanism.** It is **17 of 23 agreeing, not 19**, and **SIX** columns over-assert, not four — the six whose v1 calculation adds INVERT and mult-line cross-sums a one-group-per-field model cannot express, cited from the DDR. The other seventeen are the plain self-join form, **which is R-2's recompute rule written in FileMaker.** The patch-relationship hypothesis is superseded, not merely unproven | closed |
| ~~**CLONE-TOKEN**~~ | ✅ **APPLIED in 2-IMP-c.** Every row carries a token for every `Link <Field>` column as v1 does; group members share the group's token, non-members get a per-row-unique one, `<Field> Has Clones` is an explicit 1/0, and every value stays inside IEEE-754 integer-exact range | closed |
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

**2-IMP-c** (`0468a5d`) and with it **PORT-COV LEG 2, entire** · **CLONE-TOKEN**, applied · **CLONE-FLAG-DIVERGE**, closed with a cited mechanism rather than left unproven · **PRINT-FOUNDSET's premise**, withdrawn — the cable family was never blocked on paper · **OQ-1's colour half**, discharged by Daniel's palette rulings, unblocking `minotaurColors.ts` · **Q-3**, retired by measurement (three July-11 sort settings recovered from the printed output instead of asked) · **the CABLE-PARITY EVIDENCE parallel**, closed on its third return · **the `mult_line` link vocabulary**, shipped complete and importing zero, which is the measured answer and not an omission.

**Not closed, and named rather than left to be inferred:** the visual gate's **one uncharacterised failure**; **BUNDLE-LINK-IMPORT**, deferred to Daniel; the browser gate's steps 4–6, which passed only on a **cable-side subset** because APPLY-TIMEOUT blocks the full corpus.

### BATCH

| Batch | Members |
|---|---|
| **BATCH-HARNESS** | H3 · GATE-THEMEGLYPH *(promoted out — its own diagnosis unit)* · **GATE-DEVCHECK** and **GATE-PORT** *(promoted — they have now cost THREE runs; a listener check and a port override are both small)* · **ROUNDTRIP-INMEM** · **GATE-NOGREP** · GATE-COUNTWAIT · GATE-DLGRACE · GATE-FIXDIRTY · GATE-LOADPROXY · VIS-ENVFILE · DEV-SERVER-AGE · GATE-LOAD-AUDIO |
| **BATCH-AC** (after private beta starts, R-AG) | unchanged from v4.6 |
| **BATCH-BOX** (post-private-beta) | unchanged · BOX-NAME-UNIQ · BOX-REPARENT · **LINK-ORPHAN** |
| **BATCH-EXPORT** | ~~leg 1~~ ✅ · ~~ARCH-MIG-BOX~~ ✅ · ~~leg 1b~~ ✅ · ~~MIRROR-SYSMETHOD~~ ✅ · ~~HISTID-UUID~~ ✅ · ~~**2-EXP**~~ ✅ · ~~**2-MIG**~~ ✅ · ~~**2-IMP-a**~~ ✅ · ~~**2-MIG-b**~~ ✅ · ~~**2-IMP-b**~~ ✅ · **2-IMP-c** · **2-MIG-c** |
| **BATCH-PREBETA** | SHARE (build-prep DONE) · (ppp) settings header · ADM-1 · AUTH-DOMAIN · 3TL · DEPS · CL-HILITE · GCM · **EXPRPT-STALE** · **AUTH-REFRESH-HANG** · **IMPRPT-COPY** |
| **BATCH-HOUSEKEEPING** | **LINT** · **FENCE-HEREDOC** · **FENCE-PUSH** · **LINECOLOR-ZERO** · SRGRANT sweep · ST-RACE · CTF-SEED · SLOT-AUDIT residue · REPO-WEIGHT · BOX-TYPES-DIM-DROP · PROJ-CLEAN-2 |

### ICEBOX

Unchanged from v4.6.

## ❓ Open Questions (live only)

- **PRINT-PARITY's remaining, with OQ-1 now DISCHARGED:** ~~OQ-1 the two colour tables~~ — **CLOSED by Daniel's rulings; the palette is the parity target, not v1's render, and `minotaurColors.ts` is unblocked** · **OQ-2** — Black has no measured hex on either side; do not assume `#000000` · **OQ-3** — does the SMALL box layout's Box Name carry a Conditional Formatting rule? A screenshot settles it, **and note the Inspector disagreed with FileMaker's own print: a rendered STYLE value the engine ignores is not evidence of what prints; a BEHAVIOURAL rule still is** · **OQ-4** — are the dashed grey cut rules wanted in v2? **Now fully specified**: `x 22.00 → 590.00` at `y 395.50`, 1.0 pt, `#ADADAD`, dash `[3.005291, 3.005291]`, phase `0.5` · **OQ-5** — which cell edge is the parity target · **OQ-B** — does Box-in-Box suppress fields other than the Stack? One more card answers it.
- **Should un-boxing round-trip?** A blank box name does not clear an existing link on either the equipment or the bundle side, so a row removed from its box in v1 stays boxed in v2. Consistent across both sides deliberately; Daniel's ruling to change it.
- **Should "blank means clear" be ONE rule?** `branch_cable_type_id` and `tail_method_id` clear on an explicit blank; `box_id` on both sides does not. Each follows the precedent beside it in the same statement.
- ~~What actually drives the over-asserting clone flags?~~ **ANSWERED** — INVERT and mult-line cross-sums, cited from the DDR. Six columns, not four. (CLONE-FLAG-DIVERGE, closed.)
- **Do v1's bundle-field link groups come into v2, or never?** (BUNDLE-LINK-IMPORT.) Built, gated, awaiting Daniel.
- **Do the five disabled v2 cable outputs get built, or are they deprecated?** (Q-4.) It sets the cable print unit's size.
- **What selects the 596 rows in v1's `cable clone links.xlsx`?** Not all cables, not all lines, not "items with a link." (CLONELINK-ROWSET — divergence named, not chased.)
- **What zeroed the three v1 count fields between July 11 and Aug 20?** (Q-1.) v2's booleans match v1's counts on all seven label columns, so v2's empty Big and Balun outputs are faithful. **HIST-BLIND means only Daniel's memory can ever close intent.**
- **Do the 39 boxes whose types BOX-TYPE-LIB created want dimensions?** Not blocking.
- **Does the operator need the report to say a system row was protected?** Not blocking.
- **Should the HISTID-HASH-COST wording be sharpened?**
- **What actually moves the theme-toggle glyph?** Now reproduced twice, five days apart, on different trees — and still undiagnosed.
- The own-truck vs resolve-up reading on box labels is unobservable by construction.
- `box_default_large_labels` 5 (OQ4 ruled) vs the v1 panel's `#Big Labels 2`.
- v1 continuation header · cover-page body size → **PRINT-PARITY**.
- Script 551 extraction · cable Change All checkbox eligibility · house-wide Cancel semantics · Used∩Ignored · empty-string note · link `field_name` CHECK backstop · cable-type RENAME affordance · CL a-1 uploads · d2_01 red Members count · CL multi-letter-per-project · stale-category healing · CC credit-budget policy · OQ#2b own-band pendency · band-cascade harmonization.

**CLOSED this session:** ~~What drives the over-asserting clone flags?~~ **INVERT + mult-line cross-sums, cited from the DDR — six columns, not four, and 17 of 23 agree, not 19.** ~~Is the cable print family blocked on an unreconstructable found set?~~ **NO — all seventeen v1 outputs are data-derived; no fresh v1 print is owed.** ~~Does v2 keep one colour table or gain a second?~~ **One. The product palette is the parity target and v1's printed swatches are drift.** ~~Which sorts did the July-11 operator use where the filename does not say?~~ **All three recovered by measurement.**

---

*End of Roadmap v4.9 — August 27, 2026. **Retires Roadmap v4.8**. Unit of record: **2-IMP-c** (`8c6b2e0..0468a5d`, 31 files) — **PORT-COV leg 2 CLOSED entire.** Suite 2291 → 2374 tests across 129 → 132 files. Migration ledger **55**, unchanged. Governing set: **Arch Prompt v32** · Strategy v14 · **Roadmap v4.9** · Ledger v1.0 (Aug-27 append) · Session Log at **8**, rollover clear. Handoff of record: `handoffs/to-cc/260826-2006_portcov-leg2-imp-c.md`; return `handoffs/from-cc/260827-0916_portcov-leg2-imp-c.md`. Scope of record for the cable side: `drafts/260823_portcov_leg2_scope.md`, **§4 SUPERSEDED** on the clone-link partition. Cable-parity evidence: `handoffs/parallel/260826-1545`, `260826-1754`, `260827-0020`. Staged and unissued: `handoffs/_staging/260826-1845_print-parity-box-ADDENDUM-1_DRAFT.md`. In flight: nothing. History: `Minotaur_v2_Ledger_v1_0.md`.*
