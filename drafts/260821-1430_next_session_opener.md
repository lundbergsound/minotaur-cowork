# NEXT SESSION OPENER — ARCH-MIG-BOX, then PORT-COV leg 1b

**Written 2026-08-21 by Cowork-Arch at the PORT-COV leg 1 close. Session type: Cowork-Arch, main line. Tier: strongest reasoning, high effort — state the configured MODEL NAME at open, not just the effort (WF-2; the leg-1 handoff got this wrong and CC flagged it).**

---

## OPEN PROTOCOL

Read in this order, whole, before writing anything:

1. **`Architecture_Prompt_v30.md`** from the Minotaur-Cowork root — installed and governing.
2. **`Minotaur_v2_Roadmap_v4_2.md`** — WHOLE. It retires v4.1.
3. **`Minotaur_v2_Session_Log.md`** — the STATE OF PLAY block and **entry 9**.
4. **`drafts/260821-1500_arch_migration_package_box_side.md`** — WHOLE. It is the first action.
5. **On citation only:** the Ledger's **Aug-21 second append** (this session), the **Aug-14** block (the seven PORT-COV rulings), the **Aug-11–12** block (SHARE-R1..R7), the **Aug 4–7** block (STRAT-ADM-R1..R8).

**State verified 2026-08-21 — re-verify at open from ref files, never by running git from the Cowork seat:**

```
Minotaur         HEAD = origin/main = a243867   (8b078b2..a243867 pushed)
Minotaur-Cowork  close package to be committed by Daniel (verify)
migration ledger 51  (live-read and byte-match at open; leg 1 carried no schema)
Vercel           READY expected at a243867 — not seat-verifiable; CC probes
Working tree     `M next-env.d.ts` (never committed) + untracked `docs/reference/evidence/equipment/` (pre-existing stray)
```

Mounts: `Minotaur` · `Minotaur-Cowork` · `Minotaur_v1_exports`.

---

## FIRST ACTION — ARCH-MIG-BOX. It is written, measured, and unapplied.

`drafts/260821-1500_arch_migration_package_box_side.md`. **Trigger B: Daniel's explicit confirm, R-R precedent stated. Ledger 51 → 52.**

**Read §1.2 before anything else.** The naive `box_number::text` cast would change 100+ printed box labels from `201` to `201.0`, because bare `numeric` preserves the scale it was inserted with and the live column holds both `201` and `201.0` for the same box numbers. The package's normalizing cast reproduces `String(Number(x))` exactly, and it carries a pre-flight tripwire on the 162 populated rows.

**Two decisions owed at open:**

1. **Branch or straight to main?** Arch recommends applying to a Supabase branch, running §3's verification there, then merging — this rewrites the only apply RPC in the schema. It costs money. Daniel's call.
2. **§1.5's code pass schedules WITH the migration, not after it.** ~20 real edits across 71 `box_number` mentions. Applying the widening without it leaves the app type-checking against a column that no longer matches.

---

## THEN — PORT-COV leg 1b, the box IMPORT half

Against the migrated RPC. Carries: the §1.5 code pass · **IMP-BOXCOL** · the natural-sort comparator (**reuse `compareLabels` in `sortChains.ts:22`; do not fork one**) · the `box_details`/`box_types` mapping layer moving out of `REGISTER_NOT_IMPORTED` · **BOX-LABEL-COUNTS**.

**A test currently fails the build if anyone moves the box sheets out of `REGISTER_NOT_IMPORTED` without the RPC** (`fieldOrder.test.ts`). That is deliberate and CC added it unprompted. Leg 1b retires it in the same commit that earns the right to.

**The sample problem is real and must be stated in leg 1b's handoff, not discovered in it:** the only v1 box sample is JOY's 23 boxes, with **zero nesting, zero Truck Manual, zero Box Color, zero Box Stack**. BVSC Broadway has no boxes at all. **BVSC NY — 134 boxes, 22 nested — is not in `~/Minotaur_v1_exports/`.** Nested-box import will be built against synthetic fixtures only. A green suite does not imply corpus coverage.

---

## WHAT LEG 1 SETTLED (do not re-derive; re-verify before building on)

- **EXPORT-ORDER's 38-vs-36 is RECONCILED.** 566's boxes clause names 38 fields; `Box Logo` (771) and `Picture` (790) are containers FileMaker never exports; 38 − 2 = 36, which is what JOY's file carries. **567's printed "Source field N" is NOT a source column position** — one line proves it: 567 maps *"Source field 1 → …::Category"* while `Category` is column 5 of `equip.xlsx`. **566 governs. The file v1 writes is the file v1 reads.**
- **FINDING 2 resolved, reading (a).** BVSC Broadway has zero boxes (0/835 equip, 0/249 cable), so v1 omitted the empty sheet exactly as v2 does. The corpus is reliable. **And the semantics were already ruled July 14** in Mapping Spec §1, with BVSC's absent `boxes.xlsx` as the named example.
- **FINDING 1 discharged** — ONE mutable site (`spec.ts:266`), not the three the list named. The doc site carries sheet names only.
- **IMP-SPINE-2 CLOSED** on measured grounds. The unscoped `equipment_items` count at `fetchCurrentState.ts:21` is **load-bearing, not a defect** — it must match `import_apply_v1`'s all-types `count(*)`, and scoping it would abort every workbook apply on any project owning a single cable, tail, box or rf_device row.
- **Rulings taken (Daniel, Aug 21):** BOX-NUM-TYPE → **widen to TEXT**, sort naturally (`199a` after `20`, before `200`), following the categories idiom · WIRE-TYPE → **deprecate Wire Type AND the Wiring Schedule** · `RF Cities` → **`RF City List`** (both filename and display name).
- **WIRE-TYPE's scope, measured:** `Wire Type` 0-populated in both corpora · `Wire Type Quantity` is a **summary field** (one constant per file) · v1's `Wire Types` table has **`records: 0`** · layouts 293 and 300 were already `DEPRECATED` under R-12. **One live consequence: `MenuPageLoader.tsx:189` ships a disabled "Wire Types" menu entry — a dead affordance for a deprecated feature. It should come out; ride it on the next menu-touching unit.**

---

## GATE-THEMEGLYPH — read this before running any visual gate

**Four completed runs, same tree by verified fingerprint (`63ab04f8…`):**

| Run | Tree | Load | 01/02-light |
|---|---|---|---|
| 1 | diff applied | 4.01 | **FAIL** — 19 px judged, Δ42, bbox `1273,14–1307,32` |
| 2 | diff applied | 3.94 | **FAIL** — identical to the pixel |
| 3 | clean `8b078b2` | 4.59 | PASS |
| 4 | diff applied | 3.58 | **PASS — byte-clean** |

**The same tree produces both outcomes. It is intermittent.** It is a different site from the registered Δ1 wander at `1582,18–1583,27`, which the registry excludes separately on the same frames — so they are two phenomena, not one read two ways.

**NEVER register it in the diff-exception registry.** Δ42 is a real visual difference; DIFF-EXC-BOUND exists to prevent exactly that masking, and its bound is owed before any Δ>1 site is admitted. **It wants diagnosis (H3), not tolerance.**

**The reasoning lesson, earned twice in one session and in both directions — REPRO-SUSPECT:** *a byte-identical reproduction is strong evidence but not proof of determinism; one contrary run refutes it, and one confirming run does not establish it.* Run 3's single pass was treated as a discriminating control and was not one.

---

## STANDING NOTES

**Stash-window rule, new:** any gate run inside a stash window spawns `next dev`, which regenerates `next-env.d.ts` and blocks the restore. **`git checkout -- next-env.d.ts` immediately before the restore is a routine step**, and the cycle is **`apply` → verify fingerprint → `drop`, never bare `pop`** — `pop` deletes the safety net on a restore that may only look clean.

**DEV-SERVER-AGE is satisfied by construction** when :3000 is free — the harness spawns its own fresh server. There is nothing to restart, and an instruction to restart it is wrong on the facts.

**GATE-LOADPROXY has two new instances:** three different flakes admitted *below* the 5.00 ceiling on fresh servers, and one refusal at 5.96. The ceiling is both under-sensitive and blocking on a proxy that does not predict capture stability.

**Bulk data (R-AL):** generator → payload file → loader where the network lives → one verification query. `bvscny-load.mjs` is the reference implementation.

**Commit authority:** phrase-bound, `COMMIT APPROVED: <subject>`, subject-quoting. `git push` is always Daniel's own paste. No trailers — the `commit-msg` hook enforces it and CC's harness defaults fight it; the grep is the proof, not an assurance.

**`next-env.d.ts` is never committed.** Verify it unstaged at every commit gate.

---

## A PROCESS CORRECTION THAT IS DANIEL'S, AND IT BINDS THIS SEAT

**Batch rulings. Do not batch experiments.** This session sent CC three pasteable blocks at once — a restore, a preservation step, and a two-run diagnosis with branching outcomes. Daniel stopped it: *"This is too many steps at once."* He was right, and the distinction is now standing:

- **Pre-rule everything the unit cannot discover for itself** — that is what makes a handoff run long without stalling.
- **Hand over exactly one thing whose outcome changes the next step.** An experiment whose result determines what happens next is a decision point, and decision points are handed over one at a time.

A second correction the same session: **Arch drifted into prose and stopped producing handoffs.** The unit turned into an investigation and was never converted back into an instruction. *"Both Arch and CC write prose with no clear next action."* When a unit becomes an investigation, it still exits as a handoff.

**And plain language is not optional.** Daniel asked twice for jargon and roadmap codes to be defined on first use. Every ID in a message to him gets a short gloss, or it does not appear.

---

## NOT THIS SESSION

S4-late (GS-C · LINE-STECK · S3-G-2 · ALLOC) — deferred, not dropped. BATCH-AC (after private beta *starts*). BATCH-BOX. The harness line (R-V puts it after SHARE) — **except that GATE-THEMEGLYPH's diagnosis may earn its own slot if it recurs.** PRINT-REDO. **BOX-REPRINT is Daniel's, not the session's.**

---

## OWED BY DANIEL

- **R8-DRILL — OVERDUE.** Hard stop before the September attorney engagement; gates the account/project cleanup; feeds the addendum's retention number. **It has been the top line for five sessions and today did not touch it. Nothing in this opener competes with it.**
- **The migration confirm** (Trigger B) and **branch-or-main**.
- **BOX-REPRINT** — v2's five box outputs at 100% against the arbiters. Still the only valid parity evidence for AMEND-1/2/3.
- **SENT-BUNDLE** — derive from `cable_details.labeled`, or drop as a recorded divergence.
- **SHARE's four open questions** (`drafts/260821-1145_share_build_prep.md` §5): roster visibility · confirm the admin-issued account path · can an admin invite an admin · does a viewer see private notes.
- The CAND-4 texts · `HERO_BID_TO_OPENING` plural when Vape! Chicago opens · GIT-CFG strays.
