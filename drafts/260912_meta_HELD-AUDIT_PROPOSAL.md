# PROPOSAL — HELD-IS-NOT-FORGOTTEN: the full audit, once

*Written 2026-09-12 by the META parallel (Cowork-Arch). Member 12. Audits ⏸ HELD in `Minotaur_v2_Roadmap_v4_31.md` against the standing rule of 2026-09-11 — **a ⏸ HELD row without a named release trigger is illegal, and every close checks whether any trigger has fired.** Proposal only; the main line installs.*

---

## Plain English, first

**41 HELD rows. 23 are legal. 13 name no trigger that can fire. 4 have triggers that have already fired and should be ▶ ACTIVE today.** And one trigger names a unit that was retired at v4.30, so it can never fire at all.

Three structural problems, in order of what they cost:

1. **Three rows bundle 20 further IDs under a trigger column that reads only "unchanged from v4.6"** — and a fourth group of the same shape, carrying 11 more, sits in the BATCH table, for 31 in total. That is a provenance note, not a release trigger — v4.6 was five weeks and twenty-five Roadmap versions ago. Under the standing rule these are the clearest illegal rows in the file, and within ⏸ HELD alone they are illegal 22 times over, not 5.
2. **Four rows' triggers have fired and nobody moved them.** `AUTH-REFRESH-HANG` and `EXPRPT-STALE` are both members of `BATCH-PREBETA`, which ⏭ NEXT names as part of the very next CC bundle. `FENCE-HEREDOC` and `WF1A-PHRASE` are both named members of the META batch, which is this session. **Their release triggers fired before this audit started.**
3. **Two rows' own text says "⚠ NEW, ACTIVE"** — `FROZENCHECK-FAILOPEN` and `HARNESS-SIGNOUT` — while they sit under the ⏸ HELD heading. A row that contradicts the table it lives in will be read by whichever half the reader happens to trust.

⚠ **And the dangling one, which is the failure the rule exists to prevent:** `CHANGEALL-METHODDOCTRINE`'s trigger is *"With FIELD-CONTRACT"*, and FIELD-CONTRACT was **retired at v4.30** (2026-09-11, fifteenth Ledger append). The trigger cannot fire, so the row is held forever by a unit that no longer exists. `AUTOCOMPLETE-NOPORTAL` in ▶ ACTIVE has the same trigger and the same problem.

---

## The audit — all 41 rows

Verdicts: **LEGAL** = names a unit, batch, date or event that can fire · **FIRED** = its trigger has already fired · **VAGUE** = names a class of future work, not a trigger · **NONE** = no trigger at all · **DANGLING** = names something retired.

| # | Row | Trigger column, as written | Verdict |
|---|---|---|---|
| 1 | FROZENCHECK-FAILOPEN | Rides BATCH-HOUSEKEEPING or its own pass | LEGAL ⚠ *own text says ACTIVE* |
| 2 | HARNESS-SIGNOUT | BATCH-HARNESS / H3, or the next touch of the harness | LEGAL ⚠ *own text says ACTIVE* |
| 3 | HARNESS-THEMEWRITE | BATCH-HARNESS / H3 | LEGAL |
| 4 | EQUIPLIST-QTYCOL | With a later print unit | **VAGUE** |
| 5 | RENAME-HASHDRIFT | Pairs with any export-integrity unit | **VAGUE** |
| 6 | ADMIN-NEWDUP | BATCH-HOUSEKEEPING | LEGAL |
| 7 | CHANGEALL-SPEED | Private beta (Daniel's ruling) | LEGAL |
| 8 | CAT-NOTE — the PRINT half | NEXT. BVSC-MX | LEGAL ⚠ *BVSC-MX retired at v4.30 as a driver; verify the trigger still reads* |
| 9 | LINT-DEAD | BATCH-HOUSEKEEPING | LEGAL |
| 10 | PRINT-FOUNDSET | Before PRINT-PARITY's cable family | LEGAL |
| 11 | CHANGEALL-METHODDOCTRINE | With FIELD-CONTRACT | ⚠ **DANGLING — FIELD-CONTRACT retired at v4.30** |
| 12 | CREATEMETHOD-BLINDERR | BATCH-HOUSEKEEPING | LEGAL |
| 13 | SMALLNAME-STEP | With the box residuals | **VAGUE** |
| 14 | BOXLABEL-ZERO | Its own small unit | **NONE** — a size, not a trigger |
| 15 | DEADEXPORT-GRIDCOL | BATCH-HOUSEKEEPING | LEGAL |
| 16 | DEVICE-FK-LINK | Post-public-beta, beside DOOR-V1LINK | LEGAL |
| 17 | SKIP-LABELS | With the first 5167 output pass | LEGAL |
| 18 | CATSORT-NATURAL | With Group Parts | LEGAL |
| 19 | EQUIPVIEW-UNSAFE | With whichever equipment output lands first | **VAGUE** |
| 20 | BOX-DOC-PARITY | After cable parity | LEGAL |
| 21 | SPLITEND-DAISY | With CABLE-SPLIT | LEGAL |
| 22 | MENU-DEPRECATE | Rides a UX unit with a working gate | **VAGUE** |
| 23 | **WF1A-PHRASE** | Pairs with FENCE-PUSH's battery | ⚠ **FIRED** — named META member; FENCE-PUSH retired 2026-08-30 |
| 24 | BUNDLE-NA-UNTESTED | Before another corpus exercises it | **VAGUE** |
| 25 | EXPORT-CARRIES-STATE | Pair with EXPORT-HISTID-DROP as one export-integrity unit | LEGAL |
| 26 | EXPORT-HISTID-DROP | Its own unit; 2-EXP / 2-IMP-b's | LEGAL |
| 27 | APPLY-PROMISE-GAP | With EXPORT-HISTID-DROP | LEGAL |
| 28 | ROUNDTRIP-INMEM | BATCH-HARNESS | LEGAL |
| 29 | LINKJOIN-FENCE | Next touch of the import mappers | **VAGUE** |
| 30 | **AUTH-REFRESH-HANG** | BATCH-PREBETA | ⚠ **FIRED** — ⏭ NEXT bundles it into the next CC unit |
| 31 | SPLITOF-NO-ARM | Rides 2-MIG-c | LEGAL |
| 32 | **FENCE-HEREDOC** | Arch's, with FENCE-PUSH | ⚠ **FIRED** — named META member; FENCE-PUSH retired 2026-08-30 |
| 33 | GATE-DEVCHECK · GATE-PORT | BATCH-HARNESS | LEGAL |
| 34 | LINECOLOR-ZERO | 2-IMP-c or BATCH-HOUSEKEEPING | LEGAL |
| 35 | LINK-ORPHAN | BATCH-BOX or 2-IMP-c | LEGAL |
| 36 | CABLE-AUDIT-TIME | Next export touch | **VAGUE** |
| 37 | **EXPRPT-STALE** | Its own small pass | ⚠ **FIRED** — a named `BATCH-PREBETA` member, which ⏭ NEXT bundles next |
| 38 | BOX-REPARENT · IMPRPT-COPY · BUILDSHEET-CMT · BOX-NAME-UNIQ · BOX-TYPES-DIM-DROP · BOX-ALPHA-UNSAMPLED · BVSC-RF · HISTID-HASH-COST · SMOKE-LOGIN-HYDRATION | *unchanged from v4.6* | ⚠ **NONE — 9 IDs** |
| 39 | GATE-LOAD-AUDIO · REPRO-SUSPECT · SENT-BUNDLE | *unchanged from v4.6* | ⚠ **NONE — 3 IDs** |
| 40 | GATE-PDF | Its own port unit | **NONE** — a size, not a trigger |
| 41 | BOX-TYPE-VOL · BOX-LABEL-COUNTS · BOX-EXPORT-ORDER · SHOP-ORDER-NOTES · BUNDLE-FIND · SED-GUARD · DEV-SERVER-AGE · REPO-WEIGHT | *unchanged from v4.6* | ⚠ **NONE — 8 IDs** |

**Plus, in the BATCH table, a fourth group of the same shape:** `METHOD-FIX · PRINT-REDO · PARITY-PAIR · GATE-OL25WR · GATE-C4 · S504 · CONCEPT-A · UNALLOC · EFFGRP · DOOR-V1LINK · CABLE-LOADER | unchanged from v4.6` — **11 IDs**, and `BATCH-AC` reads *"unchanged from v4.6"* as its entire member list.

**Totals: 23 LEGAL · 8 VAGUE · 5 rows carrying NONE · 4 FIRED · 1 DANGLING = 41.** The five triggerless rows cover **22 IDs** (rows 38, 39 and 41 bundle 9, 3 and 8; rows 14 and 40 are single), and **31** counting the BATCH table's group of 11.

⚠ **Two rows are both FIRED and structurally odd:** WF1A-PHRASE and FENCE-HEREDOC name `FENCE-PUSH` as their trigger, and FENCE-PUSH appears in the ✅ RETIRED index as closed at `9a333cc`/`0bf6df3`. So those triggers are *simultaneously* fired (the unit shipped 2026-08-30) and dangling (the unit is retired). Either way the rows should not still be HELD — and today's META pass measured both of them, so they are ACTIVE in fact whatever the table says.

---

## PROPOSAL 1 — the four moves to ▶ ACTIVE, this close

| Row | Why its trigger has fired |
|---|---|
| **AUTH-REFRESH-HANG** | `BATCH-PREBETA` member; ⏭ NEXT item 1 bundles BATCH-PREBETA into the next CC unit |
| **EXPRPT-STALE** | `BATCH-PREBETA` member, same bundle. Its trigger column ("its own small pass") also contradicts its batch membership — fix both |
| **FENCE-HEREDOC** | Named META member; measured today. Battery in `drafts/260912_meta_FENCE-AND-PUSH_PROPOSAL.md` |
| **WF1A-PHRASE** | Named META member; measured today, same file |

⚠ **`IMPRPT-COPY` is a fifth, and it is hiding.** It is a `BATCH-PREBETA` member *and* one of the nine IDs inside row 38's "unchanged from v4.6" group. Its trigger has fired and it has no trigger column of its own to fire — which is exactly how a grouped row loses a member.

## PROPOSAL 2 — the five triggerless rows: give each one, or move it to ICEBOX

⚠ **22 IDs is too many to rule in one sitting, and that is the finding, not an excuse.** The standing rule makes them illegal today; the honest options:

- **(a) Give each of the 22 a trigger.** Correct, and it is a Daniel-and-Arch sitting of real length — many of these are five weeks old and some may simply be done or moot.
- **(b) Move the three grouped rows to ICEBOX as-is**, which is currently empty (34 characters), and take them out of HELD wholesale. ICEBOX carries no trigger obligation, so the rule stops being violated, and nothing is lost — the IDs and their text stay in the file.
- **(c) Split the groups into individual rows first, then (a).** Highest fidelity, highest cost, and it grows the Docket at the exact moment DOCKET-ROWLENGTH is trying to shrink it.

**Position: (b) now, (a) at the first close after the private beta.** ⚠ **The reason is the priority ruling, not convenience:** the private beta is ≈Sept 18 and none of the 22 blocks it. (b) takes ten minutes, makes the Docket honest against its own standing rule the same day, and leaves the ruling work for a week when it is not competing with three build jobs. **What (b) must not become is a way of losing them** — so it carries one condition: the move names ICEBOX's own release trigger, *"reviewed at the first close after the private-beta invite,"* or (b) has merely relabelled the problem.

⚠ **The BATCH table's group of 11 is a separate decision.** `BATCH-AC`'s entire member list reads *"unchanged from v4.6"* and the `METHOD-FIX · PRINT-REDO · PARITY-PAIR …` group carries 11 IDs the same way. Those are batch definitions rather than HELD rows, so the standing rule does not reach them — but they are the same rot, and they should be read in the same sitting.

**And the smaller fix that should happen regardless:** `BOXLABEL-ZERO` ("its own small unit"), `GATE-PDF` ("its own port unit") and `EXPRPT-STALE` ("its own small pass") describe a *size*, not a trigger. ⚠ **Propose a note in the Architecture Prompt's Roadmap section: "its own unit" is not a release trigger** — it says how big the work is, not what releases it, and three rows have been held by it.

## PROPOSAL 3 — the eight VAGUE rows: one word each

Each names a class of future work rather than a trigger. Every one is fixable by naming the unit that already exists:

| Row | Reads | Should read |
|---|---|---|
| EQUIPLIST-QTYCOL | With a later print unit | With **PRINT-PARITY**'s equipment family |
| RENAME-HASHDRIFT | Pairs with any export-integrity unit | With **EXPORT-CARRIES-STATE / EXPORT-HISTID-DROP** (the export-integrity unit, already named in rows 25–27) |
| SMALLNAME-STEP | With the box residuals | With **BATCH-BOX** |
| EQUIPVIEW-UNSAFE | With whichever equipment output lands first | With **EQUIP-LABELS-2** |
| MENU-DEPRECATE | Rides a UX unit with a working gate | With **BATCH-HOUSEKEEPING** |
| BUNDLE-NA-UNTESTED | Before another corpus exercises it | **At the private-beta invite** — the cohort imports real shows, which IS another corpus |
| LINKJOIN-FENCE | Next touch of the import mappers | With **2-IMP-c** |
| CABLE-AUDIT-TIME | Next export touch | With **2-EXP** / the export-integrity unit |

⚠ **Each of these is a guess from the corpus, not a ruling.** They are offered so the sitting is a review of eight proposals rather than eight open questions — but BUNDLE-NA-UNTESTED's is the one with real content, because "another corpus" arrives on ≈Sept 18 whether or not anyone schedules it.

## PROPOSAL 4 — the dangling trigger, and the check that catches the next one

**`CHANGEALL-METHODDOCTRINE`** and **`AUTOCOMPLETE-NOPORTAL`** both read *"With FIELD-CONTRACT."* FIELD-CONTRACT retired at v4.30; `FIELDCONTRACT-3B` is its live successor and is itself HELD with trigger *"after the invite."* Propose both triggers become **"With FIELDCONTRACT-3B"**, which chains them correctly to a row that can fire.

**And the check, for the close instruction:**

> **At every close, every trigger named in ⏸ HELD and ▶ ACTIVE is resolved against the file.** A trigger naming a row in ✅ RETIRED is a defect — the row is either released or re-pointed at the retired row's successor, never left. ⚠ **The reason: at v4.31 two rows were held by FIELD-CONTRACT, which had been retired one version earlier, and the retirement's own line named its successor.** The information needed to catch it was in the same document.

This is a five-minute mechanical check — every trigger is a string, and every ID in the file is a string — and it is the half of HELD-IS-NOT-FORGOTTEN that can be done without a ruling.

## PROPOSAL 5 — the two rows whose text fights their table

`FROZENCHECK-FAILOPEN` and `HARNESS-SIGNOUT` both open *"⚠ NEW, ACTIVE"* while sitting in ⏸ HELD. Both have legal triggers, so the fix is the text, not the placement: strike the word ACTIVE from each. ⚠ **`FROZENCHECK-FAILOPEN` is the one to be careful with** — it is a control found failing open, its own text says *"do not build on it and do not count it as a control until this is fixed,"* and a reader who trusts the word ACTIVE will assume someone is on it. Nobody is.
