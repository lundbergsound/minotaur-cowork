# 🗺️ ROADMAP — Minotaur v2 (v3.6)

**Version 3.6 • August 11, 2026 • Forward-only file — history lives in `Minotaur_v2_Ledger_v1_0.md`**

*(v3.6, Aug 11: the S4-3 box family opens — **leg 0 (P12 method render treatment) + leg 1 (Box List browse) COMPLETE**; migrations **45–48** Arch-applied (ledger 44 → 48); the P12 box side ruled to a FLAG; the `0`-alias cleanup; the fixture gains boxes. **The equipment-list print-parity cycle ran five hotfix passes and was REVERTED to its Aug 4 state at `9c3932f` on Daniel's ruling** — everything measured survives in `docs/reference/Minotaur_v1_Print_Spec_Measured.md` + the project findings doc; **PRINT-REDO** registered for Sprint-4 close at the earliest. The revision-notes fix shipped and is Daniel-confirmed. New: CLAUDE-FIX · MULT-DUP · UNALLOC · PARITY-PAIR; LINT amended (no config exists at all). New standing rule: **no print-parity judgement from a dev-server export.** v3.5, Aug 10–11: the S4-2 close — S4-AUTO COMPLETE at `1f06092`, the Cowork maiden build.)*

**Migration of record (Daniel-confirmed fold path, Aug 9):** v3.0 folds **Roadmap v2.46 + Sync Sheet #1 + Sync Sheet #2 directly.** This file carries only what is live (status ≤10 lines · sprint plan · ONE unified docket · live open questions); everything historical exits to **Ledger v1.0**. Completed docket items EXIT to the Ledger; there is deliberately no DONE status. Structure rule RM-5 carries forward; **RM-6: every Roadmap delivery opens with the 🧭 Next Sessions block.**

---

## 🧭 Next Sessions (RM-6 — plain English, kept current)

- **Now: install this close package** (Roadmap v3.6 · the Ledger append · the Session Log), commit + push Minotaur-Cowork, Sync now. **Confirm CLAUDE-FIX** — the fixture pristine-state text is stale twice over and the next CC session's first gate run will misread the fixture without it.
- **Next: the box family continues.** Leg 1 (Box List browse) is in. Legs 2–6 remain: Box Types admin, Contents/Assignments, the three box PDFs. **Daniel has signalled leg 4 (Box Types: width/depth/height/volume) as the next target** — if that is deliberate rather than shorthand for "the next box leg," the handoff should say so, because it skips legs 2 and 3.
- **Print is CLOSED and stays closed.** The equipment-list layout is back at its Aug 4 state and produces correct revised lists. PRINT-REDO opens only on Daniel's word, and only with a single agreed target ruled first.
- **At your desk, independent of sessions:** the two emptied `0` methods to clear via GCM Delete Unused (JOY, Vape!) · the R8 backup drill before the September attorney engagement · TOK-VC rotation · **attach the four owed evidence frames** (EVID-LAND) · and, for PRINT-REDO whenever it comes, dig out a **v1 preliminary list** and a **v2 revision-mode print from early August** (PARITY-PAIR).

---

## Current Status (August 11, 2026)

Live at `https://minotaur.app`. HEAD **`5dec8eb`**, production READY. **S4-3 legs 0–1 COMPLETE** — the P12 N/A system-row render treatment (method side) and the Box List browse surface. **Migrations 45–48 Arch-applied; ledger 44 → 48.** The P12 box side is a flag (`equipment_items.no_box_needed`), not a row. The Previous Revisions notes fix shipped and is **Daniel-confirmed working**. **The equipment-list print layout was REVERTED to its Aug 4 state** after five hotfix passes — findings preserved, thread closed. Suite **1325/92** · frozen **3/3 vs `be0769de`** · visual **18/18 @ 0.0000%** (frame 09 box-list added) · fixture now carries 4 boxes + 3 box_types. **Eight commits** this window, `6b2868e` → `5dec8eb` (CLAUDE-FIX landed the fixture-state amendment at `5dec8eb`). **Two files untracked and deliberately uncommitted:** `docs/reference/Minotaur_v1_Print_Spec_Measured.md` and `docs/reference/evidence/print/parity/v1_elephantshoes_boxlist_bytruck.pdf` — one `docs:` commit whenever wanted. Governing set: **Arch Prompt v29** · Strategy v14 · **Roadmap v3.6** + Ledger v1.0 (Aug-11 append). Session Log at 4 entries. **Next action:** install the close package · confirm CLAUDE-FIX · open the next box leg.

## 🏗 Sprint Plan (scope of record)

**Sprints 0–3: CLOSED.** **Sprint 4 — Boxes + the basket:** **S4-1** decks-clear — COMPLETE Aug 10 → **S4-2** S4-AUTO — COMPLETE Aug 10–11 at `1f06092` → **MMM-CAT** — handoff written (`to-cc/260811-0216_mmm-cat.md`); **status to confirm at open, no return on file** → **S4-3 the box unit family — IN BUILD**, legs 0–1 complete at `9c3932f`; legs 2–6 remain (Box Types admin · Contents/Assignments · the three box PDFs); the three at-desk print gates stay non-blocking → **S4-mid** D-2b + BASE-EVT · FOCUS-MP in headroom → **S4-late** GS-C (SPL-C, (mmmm)/(nnnn)/(oooo), **+ MULT-DUP**) → LINE-STECK (+STECK-COLOR) → S3-G-2 (+UNFLAG-WARN) → ALLOC → **S4-close** EXPORT+GBD → WF1A-SUNSET + auto-mode-rider review + COWORK-PORT + the (rrrr) box-⊕ adjudication **+ PRINT-REDO if Daniel opens it** → KKK-PASS after. **The S4-3 overnight structure held its first real test:** CC halted twice on preconditions rather than building past a red gate, and the GATE-QUEUE/no-commits discipline worked as designed. **PORT-CRIT ruled (Aug 10):** ports wait for the box family, then PORT-COV. Standing constraints carry; auto-mode rider EXPIRES at Sprint 4 close. **Post-Sprint-4 / post-beta:** GCM completion · Maintenance · Spreadsheet Export · RF/Walkies/Circuits · IAS Frequency Import · real-time collaboration · licensing (~Nov) · PWA/offline.

## 📌 Unified Docket (the ONE register of open items)

| ID | Item (one line) | Status | Owner | Trigger |
|----|-----------------|--------|-------|---------|
| CLAUDE-FIX | CLAUDE.md fixture pristine-state is stale twice (the N/A method row; then 4 seeded boxes + 3 `box_types`) — text proposed in `from-cc/260811-1250` | **OPEN — do first** | Daniel | Before the next CC session's first gate run |
| PRINT-REDO | Equipment-list print parity, re-attempt. Opens ONLY on Daniel's word: one agreed target ruled first · measurement harness built before any layout change · both cascades made to agree so frame 07 can guard the surface. Spec: `docs/reference/Minotaur_v1_Print_Spec_Measured.md` | GATED | Daniel | Sprint 4 close at the earliest |
| PARITY-PAIR | Missing references that would make PRINT-REDO tractable: a **v1 preliminary** list and a **v2 revision-mode print from early August**. Every comparison this cycle was mode-mismatched | OPEN | Daniel | Before PRINT-REDO |
| S4-3-LEGS | Box family legs 2–6: Box Types admin (w/d/h/volume/weight) · Contents/Assignments · the three box PDFs. **Daniel has signalled leg 4 next — confirm whether that deliberately skips 2–3** | IN-BUILD | Arch | Next unit |
| BOX-ROLLUP | **OQ-M — three Box List rollups are not computable as specified.** `equipment_items` carries no weight, cost or volume; those live only on `equipment_library_items`, reachable from an item solely by matching model TEXT to a library row that may not exist. Today weight renders with **no member term**, cost is `additional_cost` only, %-full is blank; all three sites carry `// UNRULED:`. **N4's ruling that v2 fixes v1's cable-cost omission is not buildable as written** — likely a schema question | **AWAITING-RULING** | Daniel/Arch | **Before the leg that builds Contents/rollups** (`from-cc/260811-1722` §3) |
| BOX-NAV | **OQ-N — the Box List is URL-only and undiscoverable.** `/project/<id>/boxes` has no nav entry; `ListPageHeader.defaultNavItems` still renders "Boxes" disabled, and that array is shared by every equipment route — enabling it moves frames **02, 03, 04, 05, 07 and 08**. A six-frame declared event, Arch's to declare, and it should be taken deliberately by whichever leg takes it | OPEN | Arch | Next box leg |
| ZERO-CLEAR | Two emptied methods named `0` (JOY, Vape!) now sit in GCM Delete Unused — Daniel clears them through the product, by design | OPEN | Daniel | At convenience |
| MULT-DUP | Duplicating a mult cable does not offer to duplicate its lines and tails; v1 asks. Needs the v1 dialog's verbatim wording from the Cable catalog first | OPEN | Arch | → GS-C, S4-late |
| UNALLOC | Unallocate may not return a cable (and perhaps tails) to a generic item. Cable path exists and flips `type→'generic'`; suspects = no tail equivalent, or a cache-invalidation gap | OPEN | Arch | Needs a reproduction from Daniel |
| METHOD-FIX | Fixture debt, two gaps, both cheap if folded into a leg already declaring a fixture event: (a) **no method band on the printed fixture** — so `METHOD_HDR_H` is the one pagination constant derived rather than measured, and **no by-method print is covered by any gate**; (b) **no fixture row is both changed AND note-bearing** — so the OQ-T notes-on-white rule is built and unit-tested but never photographed. One such row closes (b) and the `\r` hydration path together | OPEN | Arch | Next fixture-touching declared event |
| GATE-PDF | Three-PDF interactive Save-as-PDF measurement packet (Bundle Sheet · Equipment List · Small Cable Labels) | GATED | Daniel | At printer/show |
| GATE-OL25WR | OL25WR die-cut stock re-gate | GATED | Daniel | At a printer |
| GATE-C4 | C4 equipment-print pagination confirm on a live show | GATED | Daniel | **Superseded in practice by the revert — re-scope if PRINT-REDO opens** |
| R8-DRILL | Backup restore drill per the R8 runbook | OPEN | Daniel | Before the September attorney engagement |
| COWORK-P2b | Boxes evidence digest from the full local v1 corpus | IN-BUILD | Daniel | Parallel session; fold-in on return |
| COWORK-REV | Keep/expand/revert review of the Cowork pilot — Arch seat-report EXPAND delivered | AWAITING-RULING | Daniel | Daniel's confirm |
| COWORK-PORT | Memorialize the Cowork workflow portable across projects | OPEN | Daniel | Sprint 4 close |
| EVID-LAND | Land the four owed S4-AUTO evidence frames | OPEN | Daniel | Next convenient |
| MMM-CAT | Category sub-band editable under method/box/group sorts incl. ⌥⇧I — **handoff written, no return on file; confirm status at open** | OPEN | Arch | Confirm before re-scheduling |
| TOK-VC | Vercel token rotation + ~November renewal | OPEN | Daniel | At convenience |
| PORT-COV | Import/export coverage extension to equipment+cable+box | OPEN | Arch | After the box family; merged into EXPORT |
| D-2b | Bundle Clone/Ext linkage | OPEN | Arch | S4-mid, cable-side leg 1 |
| S504 | Residual s504 delete-variant frames | BLOCKED | Daniel | When v1 cooperates |
| GS-C | Cable completeness: SPL-C · INS-1 · (bbbb) · (qqq)/(sss) · (mmmm) · (nnnn) · (oooo) Method-0 design gate · **MULT-DUP** | OPEN | Arch | S4-late, cable-side leg 2 |
| S3-G-2 | Residual v1 outputs (Shop Orders Basic/Detailed + remaining reports) | OPEN | Arch | S4-late, after LINE-STECK |
| FOCUS-MP | Focus/nav mini-pass | OPEN | Arch | S4 between-units headroom |
| UNFLAG-WARN | Unflagged-cables print warning | OPEN | Arch | Rides S3-G-2 |
| EFFGRP | effective_group / grouped-bundle-group view defect | AWAITING-RULING | Daniel | Ruling → four-step migration |
| LINE-STECK | Line/steck label unit | OPEN | Arch | S4-late, after GS-C |
| STECK-COLOR | Steck-color verify | OPEN | Arch | Rides LINE-STECK |
| CMDK | ⌥⇧K command palette | OPEN | Arch | Post-Sprint-4 |
| LAT | Latency/optimistic unit | OPEN | Arch | Post-basket |
| DEPS | Dependency maintenance | OPEN | Arch | Pre-October beta |
| SHARE | Sharing-UI + membership layer | OPEN | Arch | Private-beta prerequisite |
| ADM-1 | Beta admin panel | OPEN | Arch | Post-SHARE, pre-October |
| FR-1 | Find-and-replace mode | OPEN | Arch | Post-Sprint-4, post-ADM-1 |
| EP | Equipment Projection unit proper | OPEN | Arch | Post-basket |
| 665-BR | 665 cable-form branch follow-on | OPEN | Arch | Unscheduled |
| EXPORT | v2→v1 export unit revival (+ PORT-COV's export half) | OPEN | Arch | End of Sprint 4 |
| GBD | Guarded bulk-delete | OPEN | Arch | End of Sprint 4 |
| M0-WIN | Method-0 windowing equivalent check | OPEN | Arch | Pre-port |
| 3TL | Three-tier library architecture | OPEN | Arch | Pre-beta |
| BASE-EVT | Declared baseline-event session | OPEN | Arch | S4-mid, rides D-2b |
| ALLOC | Allocate as type-conversion (D9) | OPEN | Arch | S4-late |
| CONCEPT-A | Print-header unit | BLOCKED | Daniel | Gated on the a-1 uploads |
| LIB-RENDER | Library-grid render pass (+ (pppp)) | OPEN | Arch | Post-Sprint-4 |
| GCM-LAND | GCM→list focus landing | OPEN | Arch | Post-Sprint-4 |
| EST-AUDIT | Estimator-audit / measured pagination — **the print revert restored the Aug-4 estimator; this unit now inherits the measured constants recorded in the print spec** | OPEN | Arch | Unscheduled |
| UNDO | Session Undo/Redo | OPEN | Arch | Unscheduled |
| VERHIST | Durable Version History | OPEN | Arch | ~November |
| TRASH | Trash/Archive unit | OPEN | Arch | Post-Sprint-4 |
| AUTH-DOMAIN | Custom-domain auth email | OPEN | Arch | Pre-public-beta |
| BINGO | Bingo disposition | OPEN | Daniel | Post-private-beta |
| RTL | Hook-test + RTL/component-test infra | OPEN | Arch | Someday-maybe |
| (rrrr) | New Box ⊕ UX: create latency + apparent create without explicit ⊕ | GATED | Arch | End of Sprint 4 |
| (ppp) | Settings page: project menu bar joins the fixed header | OPEN | Arch | Next settings-touching unit |
| TYPE-TOG | Equipment-list type-visibility toggle | OPEN | Arch | Post-Sprint-4 / EP |
| SEED | Fresh-project seeding — **note: v1 ships 56 Box Types as catalog data; ours is empty. That port belongs here** | OPEN | Arch | Unscheduled |
| KKK-PASS | Narrow-window responsive pass | OPEN | Arch | Immediately after Sprint 4 |
| NOTES-NL | Library-page notes fields strip newlines | OPEN | Arch | Unscheduled |
| GROUP-RES | Equipment grouping/sort engine residue | OPEN | Arch | Unscheduled |
| HARNESS | Harness pass: fail-hard leaks the dev server · frame-03 sort-flake · theme-toggle intermittent · load sensitivity · `--update-baselines` per-frame scope flag · settle-wait family · (qqqq) · scroll-state frames · **the 02/03-dark byte-drift-on-refresh recurrence (restored by `git checkout --` three times this window)** | OPEN | Arch | Own small pass |
| REV-STAMP | Revision-stamp labels deliberately screen-sized | AWAITING-RULING | Daniel | Unscheduled |
| MPP-COS | Multi-page print preview cosmetic whitespace | OPEN | Arch | Unscheduled |
| REV-SPRINT2 | Equipment Change All cross-surface constraints inheritance check | OPEN | Arch | Opportunistic |
| (q) | Consolidate Zite source into ONE reference folder | OPEN | Daniel | Unscheduled |
| (u) | Snapshot-fetch failure surfaces console-only | OPEN | Arch | Unscheduled |
| (ff) | Tab strip renders no selected button on revisions/settings | AWAITING-RULING | Daniel | Unscheduled |
| (yy) | Methods admin non-rename fields swallow DB errors | OPEN | Arch | Unscheduled |
| (aaa) | ⌥⇧F find-seeding misses Model | OPEN | Arch | Unscheduled |
| (bbb) | Autocomplete inline-completion Enter commit | OPEN | Arch | Unscheduled |
| (ccc) | Quantity Escape-revert missing | OPEN | Arch | Unscheduled |
| (eee) | Exact-match autocomplete suppression | OPEN | Arch | Unscheduled |
| (fff) | REM column → editable quantity text field | OPEN | Arch | Unscheduled |
| (hhh) | Editing a category with its band header off-screen | OPEN | Arch | Unscheduled |
| (jjj) | Remaining-cell save-error-flash gap | OPEN | Arch | Unscheduled |
| (vvv) | Inverted-extension end DISPLAY may be un-swapped | OPEN | Arch | Unscheduled |
| (dddd) | `# ` autoformat headings print literally | AWAITING-RULING | Daniel | If it chafes |
| (ffff) | New Defaults Method/Group inputs render DARK in light mode | OPEN | Arch | Unscheduled |
| SNAP-CHK | Any production snapshots lacking `items`? — **partially answered: 12 revisions surveyed, all carry `items`; the legacy no-items fallback is still the safe path** | OPEN | Arch | Opportunistic |
| CONTRAST | Contrast recon | OPEN | Arch | Unscheduled |
| DASH-FRAME | /dashboard capture frame | OPEN | Arch | Future baseline event |
| TAB-BRIDGE | Cross-band Tab bridge design question | OPEN | Arch | Unscheduled |
| GIT-CFG | Real `git config user.name/email` · Next 16 `middleware`→`proxy` | OPEN | Daniel | Housekeeping |
| LINT | **Amended Aug 11: there is NO ESLint config anywhere in the repo.** Next 16 removed `next lint`, the only thing supplying one — lint has never run in v2. Standing it up is config authoring, not a fix | OPEN | Arch | Post-Sprint-4 chore |
| ST-RACE | Minor `setTimeout` race in error-flag cleanup | OPEN | Arch | Low |
| CTF-SEED | CTF edit-dialog seed helper unused by the grid | OPEN | CC | Opportunistic |
| IMP-SORT | Import sheet order → sort_order | AWAITING-RULING | Daniel | Unscheduled |
| SRGRANT | `service_role` GRANT restore sweep | OPEN | Arch | Housekeeping |
| BRIEF-12 | Brief v1.2 pass | OPEN | Daniel | Strat scheduling |
| COMMS-Q | Comms queue | OPEN | Daniel | October announcement |
| LEGAL-SEP | September attorney engagement | OPEN | Daniel | September 2026 |
| LIC-NOV | Licensing subsystem design | OPEN | Daniel | ~November 2026 |
| WF1A-SUNSET | WF-1a commit pilot + auto-mode rider sunset review (**+ the overnight-run commit-authority question; + the Aug-11 Arch push-instruction correction is a datapoint for it**) | GATED | Daniel | Sprint 4 close |
| PRUNE-CHK | Claude.ai project-file hygiene (**v3.5 superseded by v3.6**) | OPEN | Daniel | Next convenient open |

## ❓ Open Questions (live only)

*(The S4-3 close moved: OQ-E · OQ-F · OQ-G · OQ-H · OQ-I · OQ-J · OQ-K · OQ-Q · OQ-R · OQ-S · OQ-T · OQ-U all discharged — Ledger. The note-column and highlight questions were answered by measurement, not ruling.)*

- **What the box Warn/Over Volume thresholds are measured against** — `projects.box_warn_volume` (23) / `box_over_volume` (27) are live, but 23/27 read as absolute ft³ rather than percentages, while the column is `%-full (volume vs. type volume)`. **Leg 1 ships the %-full column unstyled with a `// UNRULED:` marker pending Daniel.**
- **`box_default_large_labels` defaults to 5; the v1 panel reads `#Big Labels 2`.** OQ4 ruled 5 and was not overridden — 2 may be one show's value. Flagged, not acted on.
- **The categorized-box print case is unexercised** — the fixture's boxes carry no category, so "a box prints under whatever category it carries" is ruled but unproven at the gate. Needs a category added as its own declared event.
- **The v1 continuation header** (category name repeated at the left of the green band on continued pages) is real v1 behaviour we do not have. → PRINT-REDO.
- **The cover page** is v2-only with no v1 counterpart, body at 8.25pt; Daniel reports it reads small relative to the list. → PRINT-REDO.
- Script 551 extraction · Cross-surface checkbox eligibility for CABLE Change All · House-wide Cancel semantics · Used∩Ignored semantics · Empty-string note decision · Link `field_name` CHECK backstop · Cable-type RENAME affordance · CL a-1 evidence uploads · d2_01 red Members count · CL multi-letter-per-project · Stale-category-text healing · CC credit-budget standing policy · Comms Prompt structure · OQ#2b own-band pendency · Band-cascade harmonization · **Seat consolidation** (rule at or after COWORK-PORT).

---

*End of Roadmap v3.6 — August 11, 2026. History: `Minotaur_v2_Ledger_v1_0.md`. Print findings: `docs/reference/Minotaur_v1_Print_Spec_Measured.md` + the project doc `Minotaur_Print_Parity_Findings_2026-08-11.md`.*
