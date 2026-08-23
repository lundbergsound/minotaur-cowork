# NEXT SESSION OPENER — PORT-COV (the v1↔v2 coverage unit) + SHARE build-prep

**Written 2026-08-21 by Cowork-Arch at the S4-3 leg 6 close. Session type: Cowork-Arch, main line. Tier: strongest reasoning, high effort — state the configured model at open.**

Daniel's direction (2026-08-21): *"let's work on v1 to v2 import and export with the new tables, and on admin/sharing in the next session."*

---

## OPEN PROTOCOL

Read in this order, whole, before writing anything:

1. **`Architecture_Prompt_v30.md`** from the Minotaur-Cowork root — installed and governing.
2. **`Minotaur_v2_Roadmap_v4_1.md`** — WHOLE. It retires v4.0.
3. **`Minotaur_v2_Session_Log.md`** — the STATE OF PLAY block and **entry 8** (leg 6).
4. **On citation only:** the Ledger's **Aug-14** block (the seven PORT-COV rulings, ruling 4 = script 567's map, EXPORT-ORDER, WIRE-TYPE), the **Aug-15** block (IMP-SPINE closed in the corrected shape; IMP-SPINE-2 registered), the **Aug-11–12** block (SHARE-R1..R7), and the **Aug 4–7** block (STRAT-ADM-R1..R8).

**State verified from ref files, 2026-08-21 00:31 — do NOT re-derive by running git from the Cowork seat:**

```
Minotaur         HEAD = origin/main = 8b078b2   no index.lock
Minotaur-Cowork  close package committed by Daniel (verify)
migration ledger 51  (live-read at open and byte-match; leg 6 carried no schema)
Vercel           READY at 8b078b2 — not seat-verifiable; CC probes
```

Mounts available to the Cowork seat: `Minotaur` · `Minotaur-Cowork` · **`Minotaur_v1_exports`** (the v1 corpus — it is a mount now, not a claim).

---

## FIRST ACTIONS, in order

**1. The confirming visual gate for AMEND-3 (R-AM). Restart the dev server first.** Report it as a **standalone line** — not folded into a unit's gate set. `node --env-file=.env.local scripts/visual-capture.mjs --gate`.

> **If it comes back non-green on a quiet machine: HALT AND MEASURE. Do not re-run.** A non-green quiet run means the flake families are mis-scoped, which is a larger finding than the amendment it was meant to confirm, and it is the only thing that would reopen leg 6.

**2. Take the sequencing ruling below.** It is a genuine fork and it is Daniel's.

**3. Then scope the unit.** Read at source before writing the handoff — the leg-6 record has three fresh instances of what happens otherwise.

---

## THE SEQUENCING RULING (Daniel, at open)

**What just changed:** **PORT-CRIT** (Daniel, Aug 10) ruled that the v1↔v2 port *waits until the box unit family is finished*, and that one coverage unit — **PORT-COV** — then extends both the import engine and the export to carry equipment + cable + box data, with ports opening only after it. **Leg 6 closed the box family at `8b078b2`. PORT-COV's precondition cleared three days early.** Daniel's ask is not a reordering of that ruling; it is the ruling firing.

**What it does reorder:** Roadmap v4.1's sprint table puts **S4-late** (GS-C → LINE-STECK → S3-G-2 → ALLOC) *before* S4-close's EXPORT slot, where PORT-COV's export half lives. Running PORT-COV now pulls it ahead of all four.

**Arch recommends taking it, on four grounds** — stated so the ruling is made against the argument rather than the convenience:

1. **PORT-CRIT gates *ports* on PORT-COV, and ports are what private beta needs.** PORT-READY leg 5 is "PORT-COV complete." Nothing in S4-late unblocks anything downstream of itself.
2. **R-V already sequences it this way** — the harness line runs after the box unit, *then the v1 import/export work*, *then* SHARE. S4-late was never named in that chain.
3. **STRAT-ADM-R4 makes the sharing unit load-bearing for support**: per-incident read-only support access is *user-initiated via project sharing*, because no admin content surface exists by design. Until SHARE ships there is no supported way to help a beta user with their own data.
4. **ADM-1 is dated post-sharing / pre-October**, and October carries COMMS-Q. Sharing slipping pushes a dated commitment. **STRAT-ADM-R6's decoupling contingency exists precisely for this** — ADM-1's true minimum has zero sharing dependency and can be split out to protect October if SHARE slips.

**The honest counter, which Arch does not think wins but Daniel should hear:** S4-late is user-visible feature work and PORT-COV is plumbing that nobody sees until they port a show. If the private-beta candidates would be more impressed by GS-C and LINE-STECK than by a working port, that is a real argument and it is Daniel's to weigh.

### The scope fork inside it

**These are two units and one session cannot hold both.** PORT-COV extends thirteen unparsed sheet classes across an import engine *and* an exporter; SHARE carries four roles, an RLS delta and a migration. Attempting both produces two half-units and a gate set that proves neither.

**Arch recommends: PORT-COV is the build unit; SHARE build-prep runs in the same session as a design round.** SHARE build-prep needs no code — it is REV-B plus three inputs that are already owed (below) — so it costs a design pass, not a build, and it means SHARE opens next session with nothing blocking it. **Daniel's ask reads either way** (*"and on admin/sharing in the next session"* attaches to either clause); rule it at open.

---

## UNIT A — PORT-COV, the coverage extension

### Measured at source, 2026-08-21 (use these; do not re-assert them without re-measuring)

**The importer maps four sheets.** `src/lib/import/spec.ts:196-232` — `equip.xlsx` → `equipment_items` (53 corpus columns) · `library.xlsx` → `equipment_library_items` (25) · `methods.xlsx` → `methods` (9) · `categories.xlsx` → `categories` (6).

**Thirteen always-present sheets are registered and never parsed** (`REGISTER_NOT_IMPORTED`, `spec.ts:247-259`): `groups · cable · tails · bundles · lines · cable clone links · bundle clone links · boxes · box types · def ends · def tails · history · temp`. Nine more are conditionally absent (`Shop IDs · Circuits · RF Frequencies · RF Gear · RF Roles · RF Cast · RF Cities · Bingo Words · Bingo Boards`).

**4 mapped + 13 always-present register-only = 17.** This confirms the Ledger's "the importer covers 4 of 17 export sheets" **at source**, which had never been re-checked since it was measured on Aug 12.

**The exporter writes the same four**, each cited to script 566 line ranges in `src/lib/export/fieldOrder.ts:19,76,105,118`, and **omits a sheet entirely when its class is empty** (`buildWorkbookSet.ts:52,57,62,67` — `if (input.equip.length > 0)`).

File sizes for scoping: `fieldOrder.ts` 126 · `runExport.ts` 290 · `import/spec.ts` 314 · `runImport.ts` 196 · `workbook/fetchCurrentState.ts` 49.

### Two findings from the pre-read — both real, neither previously registered

**FINDING 1 — PORT-COV ruling (7)'s propagation is UNDISCHARGED, at the exact line the ruling cited.** The Aug-14 ruling took the `RF Cities.xlsx` → `rf city list.xlsx` filename correction *with its propagation list*, naming Mapping Spec §1 · **`spec.ts:266`** · the opener family. **`spec.ts:266` today still reads `{ name: 'RF Cities', file: 'RF Cities.xlsx', conditionallyAbsent: true }`.** Low blast radius — the sheet is conditionally absent and neither corpus contains it — but v1's re-ingest is positional and filename-keyed, so this is a contract error sitting in the contract file. **Discharge it in this unit and check the other two sites in the same pass.** Register the meta-lesson: *a propagation list is discharged when it is measured discharged, not when it is written.* This is the second time in eight days a propagation list has been found undischarged or wrong (cf. DOOR-SEO, Aug 18).

**FINDING 2 — the two v1 corpora are NOT uniform, and the difference is a box sheet.** Both exported within two minutes of each other on 2026-07-12:

```
Minotaur_v1_exports/JOY/2026-07-12_1610   18 files — includes boxes.xlsx (+ JOY.mino)
Minotaur_v1_exports/BVSC/2026-07-12_1608  16 files — NO boxes.xlsx (box types.xlsx present)
```

**Do not assume why.** The plausible readings are (a) v1 omits an empty sheet exactly as v2's exporter does, and BVSC's Box List was empty at export time, or (b) the BVSC export is partial. **(a) and (b) have opposite consequences for this unit**: under (a) the importer must handle a legitimately absent sheet for a class the show *does* use, which is a design question about missing-sheet semantics; under (b) the corpus is unreliable and JOY is the only complete sample. **Resolve it at source** — open both `box types.xlsx` files and BVSC's `equip.xlsx` Box column, and check whether BVSC Broadway has boxes at all. Note the tension: the BVSC Broadway *set* was the AMEND-1 box parity arbiter, which suggests boxes exist. **This is an OPEN QUESTION, not a finding, until it is measured.**

### Scope, in the order the evidence supports

**A0 — discharge FINDING 1 and resolve FINDING 2 before scoping the rest.** FINDING 2 changes the missing-sheet design; scoping around it is scoping on a guess.

**A1 — read v1's own re-ingest at source. Script 567 "Import Show" is the specification.** Ruling 4 of record: **every re-ingest is positional, and the field map's deliberate gaps ARE the derived columns.** The hash-input set is *a list to read, not a principle to apply*, with the one precision that 567 imports both members of the three ` Original` pairs, so that suffix is excluded. **Read 567 whole before mapping a single new sheet.**

**A2 — the import half: extend the engine to the cable and box classes.** Cable-side (`cable · tails · bundles · lines · cable clone links · bundle clone links · def ends · def tails`) and box-side (`boxes · box types`). The cable-side DDR-format extraction is **net-new work** and was flagged as such when PORT-CRIT was ruled — do not scope it as if the equipment path generalises for free. `groups`, `history` and `temp` need a disposition each, not a default.

**A3 — the export half: emit the same classes**, subject to **EXPORT-ORDER**. Column order is part of the contract because the re-ingest is positional. The known divergence of record: **567's boxes map runs to source field 38 where v1's own `boxes.xlsx` carries 36 columns** — v1's import expects a wider file than v1's export writes. Reconcile it rather than reproducing either half blindly. `box types.xlsx` field order is confirmed byte-for-byte in both corpora: **Box Count · Box Type · Depth · Height · Volume · Width** (alphabetical, count first), 61 data rows each.

**A4 — WIRE-TYPE gets its ruling before it gets code.** `cable.xlsx` exports `Wire Type` and `Wire Type Quantity`; 567 maps field 60 → `Cable::Wire Type`; **v2 has no column for either** in `cable_details` or `cable_types`. Confirmed three ways, not inferred from absence. **Rule port-or-omit first** — porting it is schema, omitting it is a recorded divergence, and building either without the ruling is the mistake.

**A5 — the leg-6 residue that belongs here.** **IMP-BOXCOL**: the importer does not carry Box on equipment rows (found while backfilling JOY, where 401 of 416 assignments resolved and **none were guessed**). **BOX-NUM-TYPE** (`199A`): v1 box numbers are Text, v2's column is numeric — this is a schema decision, it is live in printed output today, and it lands squarely in this unit's path because the importer has to choose a representation. **IMP-SPINE-2**: two secondary type-unscoped reads at `workbook/fetchCurrentState.ts:21,26` — the count is *correct as is* because it matches the RPC, and the `max(sort_order)` is cosmetic and cannot delete anything. Close it or re-affirm the reasoning; do not leave it registered on stale grounds.

**A6 — the read-the-consumers check is MANDATORY on this unit.** Standing-correction instance **eleven** was earned on this exact file: adding `.eq('type','generic')` to `fetchCurrentState` would have broken every mirror apply, because that array also feeds the plan's staleness fingerprint which `import_apply_v1` compares against an all-types count. **Every widened read on the import path gets its consumers enumerated at source before the change is written.**

### Fences

No migration without Daniel's explicit confirm and the R-R precedent stated. Frozen layers untouched. Full gate set. **A declared event is likely** — the import surface has captured frames — so measure it, do not assume it. `--force-load` remains forbidden.

---

## UNIT B — SHARE build-prep (design round, no code)

The design is **already ruled**: SHARE-R1..R7 (Aug 11–12). Four roles **owner / admin / editor / viewer** (admin = edit + roster + settings; Daniel's addition over the proposed three) · invites by owner + admin · project settings owner + admin, editors excluded · ownership transfer deferred past public beta · **phase-1 invites auto-accept** for existing accounts, in-app, no email, with a courtesy dashboard notice · default invite role **editor** · **phase 2 (email invites, `project_invites`) strictly after AUTH-DOMAIN**. Libraries travel with the project; 3TL inherits the personal-library leak-proof flag.

**Three things are owed and each one blocks the build:**

1. **REV-B — the RLS delta**, plus an **ADM-1 sketch for the fourth role**. Registered as owed since Aug 12 and never delivered. This is the actual gate.
2. **The closed-signup interaction, which is an INPUT and must not be a discovery.** Public signup closed Aug 15. SHARE phase 1 auto-accepts invites *for existing accounts* — and there is now no public path to become an existing account. The Aug-15 Strat close routed this to Arch explicitly as *intent ruled, mechanism deferred*: invites need an account path that does not route through the public form (admin-issued / invite-created). **Design it here.**
3. **STRAT-ADM-R4's dependency, stated plainly:** per-incident, read-only, user-initiated support access runs *through project sharing*, because no admin content surface exists by design. So SHARE is not only a feature — it is the support mechanism for the private beta, and its roster surface is where that access is granted and revoked.

**Deliverable:** a SHARE build handoff ready to open cold, carrying REV-B, the account-path mechanism, the four-role RLS delta, and the phase-1/phase-2 fence. **No code this session.**

---

## STANDING NOTES

**Bulk data (R-AL):** never route rows through a model context. Generator → payload file → loader executed where the network lives → one verification query. `bvscny-load.mjs` is the reference implementation, and its three properties are load-bearing: the `authenticated` privilege path (a `service_role` grant was declined and stays declined), deterministic v5 UUIDs for idempotence, and the **recursive 409 split** that stops a mixed batch from silently dropping rows. **This unit will be tempted** — a coverage extension invites "just load the corpus and see." Load it with the loader.

**Evidence discipline, after instance twenty-two:** artifacts are **opened before they are named**. A filing operation on evidence is an evidentiary operation, not a clerical one — a misfiled evidence file does not fail loudly, it sits in the corpus asserting its own provenance until something is built on it.

**Inference discipline, new at leg 6:** *an absence measured on one artifact is not a rule.* A negative parity claim requires two artifacts or it is an open question. **FINDING 2 above is exactly this rule applying to the corpus itself.**

**Gate notes:** `npm run test:visual` does not run — use `node --env-file=.env.local scripts/visual-capture.mjs --gate` (VIS-ENVFILE). THEMERACE (Δ42 topbar): re-run once, never register. DLGRACE: re-run. **Restart the dev server before any gate** (DEV-SERVER-AGE, two supporting instances). Load ceiling honored; **`--force-load` forbidden**. Declarations: plain flags, reasons by hand, rule 9 per-dimension 1.75/8.

**`next-env.d.ts` is never committed.** Next-generated, self-declares "should not be edited", flips with build-vs-dev. Verify it unstaged at every commit gate.

**Commit authority:** phrase-bound, `COMMIT APPROVED: <subject>`. `git push` is always Daniel's own paste. Watch the bash fence on subjects containing `>=` — it parses as a redirect; use `≥`, which matches the code comments anyway (leg 6 precedent).

---

## NOT THIS SESSION

S4-late (GS-C · LINE-STECK · S3-G-2 · ALLOC) — deferred by the sequencing ruling, not dropped. BATCH-AC (R-AG: after private beta *starts*). BATCH-BOX (post-private-beta). The harness line (R-V puts it after SHARE). PRINT-REDO. **BOX-REPRINT is Daniel's, not the session's.**

---

## OWED BY DANIEL

- **R8-DRILL — OVERDUE.** Hard stop before the September attorney engagement; gates the account/project cleanup; feeds the addendum's retention number. It has been the top line for four sessions. **Nothing in this opener competes with it.**
- **BOX-REPRINT** — v2's five box outputs at 100%, matching paper size and orientation, against the arbiters in `docs/reference/evidence/print/parity/`. Three amendments of parity work are confirmed by construction and against the v1 side only; **nothing is confirmed against a v2 render.**
- **SENT-BUNDLE** — derive the Contents column from `cable_details.labeled`, or drop it as a recorded divergence. Prints empty today, 80-for-80.
- **The sequencing ruling and the scope fork**, above, at open.
- **WIRE-TYPE port-or-omit** (A4) and **BOX-NUM-TYPE** (`199A`, A5) — both are schema decisions the unit cannot make for him.
- The CAND-4 texts · `HERO_BID_TO_OPENING` goes plural when Vape! Chicago opens · GIT-CFG strays.
