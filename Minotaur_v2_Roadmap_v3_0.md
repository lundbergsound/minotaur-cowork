# 🗺️ ROADMAP — Minotaur v2 (v3.0)

**Version 3.0 • August 9, 2026 • Forward-only file — history lives in `Minotaur_v2_Ledger_v1_0.md`**

**Migration of record (Daniel-confirmed fold path, Aug 9):** v3.0 folds **Roadmap v2.46 + Sync Sheet #1 (S3-G close) + Sync Sheet #2 (Aug-9 Strat close) directly — no v2.47 was produced.** The single-file format splits here: this file carries only what is live (status ≤10 lines · sprint plan · ONE unified docket · live open questions); everything historical — rulings, corrections, lineage, completed units, reference registers — exits to **Ledger v1.0** (its own version line, starting v1.0 by ruling #11). Completed docket items EXIT to the Ledger; there is deliberately no DONE status. v2.46 is archived byte-exact alongside the Session Log archives (the last single-file roadmap; never edited again); the two Sync Sheets remain as files. Citations of any v2.4x register resolve to the Ledger. Structure rule RM-5 carries forward; **RM-6 (Aug 9, Daniel): every Roadmap delivery opens with the 🧭 Next Sessions block below — a few succinct, plain-English bullets on what the next few sessions do, kept current at every delivery.**

---

## 🧭 Next Sessions (RM-6 — plain English, kept current)

- **Finish the housekeeping session (now):** move CLAUDE.md's completed-unit history into the repo's arch-record folder, switch on the WF-1a commit pilot (CC commits on your typed confirm phrase; push stays yours), install Arch Prompt v28, then close with the Session Log + Docket Sweep.
- **Cowork pilot:** seed `~/Developer/Minotaur-Cowork/`, then run 2–3 document-production sessions in Cowork to test the edit-and-diff-review flow; keep, fix, or drop it after review.
- **Sprint-4 planning session:** write the Sprint-4 map once into the docket below; rule the port criterion and the cable-data-gap sequencing in the same sitting.
- **First Sprint-4 build session:** the official visual gate 16/16 runs FIRST, before any build — then the first basket unit opens.
- **At your desk, independent of sessions:** the R8 backup drill before the September attorney engagement; the three-PDF measurement packet + OL25WR die-cut re-gate + C4 pagination confirm whenever you're at a printer/show.

---

## Current Status (August 9, 2026)

Live at `https://minotaur.app` (Vercel prod on `main`; repo `lundbergsound/minotaur-v2`; local `~/Developer/Minotaur`). HEAD **`cc96e82`** (docs: the S3-G CLAUDE.md close fold) over **`1055e76`** — **SPRINT 3 COMPLETE** (S3-G shipped: all nine cable/tail print surfaces + the 🖨/Quick Print system + equipment print point-true fonts; lineage → Ledger). Suite **1250/89** · frozen **3/3 vs `be0769de`** · migrations unchanged (`l0_r1_drop_redundant_print_options_column` last) · fixture pristine. Visual gate **parked at amend-3** → docket **GATE-VIS** (first action of the first Sprint-4 build session). Housekeeping session in progress (this migration; then CLAUDE.md relocation · WF-1a mechanics · Arch Prompt v28). **Next action:** close housekeeping → Cowork pilot → Sprint-4 planning written once into the docket below.

## 🏗 Sprint Plan (scope of record)

**Sprints 0–3: CLOSED** — exited to the Ledger (Sprint 3 closed Aug 7–9 with S3-G under the Aug-7 compression). **Sprint 4 — Boxes + the basket** (spec-complete `abeab54`): the box unit family (list/contents/types/assignments · three PDFs) + the basket rows below (D-2b · GS-C · S3-G-2 · FOCUS-MP · S4-AUTO · BASE-EVT · ALLOC · the export/bulk-delete deadline pair) — **the full map is written ONCE into this docket at the Sprint-4 planning session** (Daniel-confirmed; the port criterion + cable-data sequencing are ruled there). Standing sprint constraints carry: box views responsive from the start · method/box autocomplete-from-day-one · auto-mode rider EXPIRES at Sprint 4 close. **Post-Sprint-4 / post-beta:** GCM completion · Maintenance · Spreadsheet Export · RF/Walkies/Circuits · IAS Frequency Import · real-time collaboration · licensing build (~Nov design) · PWA/offline (v3 candidate) — sequenced when their triggers approach.

## 📌 Unified Docket (the ONE register of open items)

Letters permanent (the v2.13 rule restated); named units keep their names; completed rows EXIT to the Ledger at each close. Registration texts of record for open units live in the Ledger's "Registration texts" section, cited by ID. Status vocabulary: OPEN · GATED · AWAITING-RULING · IN-BUILD · BLOCKED.

| ID | Item (one line) | Status | Owner | Trigger |
|----|-----------------|--------|-------|---------|
| GATE-VIS | Official visual gate 16/16 @ 0.0000% on a quiet machine (parked at S3-G amend-3; frame-07 direct-diffed 0.0000%) | GATED | CC | FIRST ACTION of the first Sprint-4 BUILD session, before any build |
| GATE-PDF | Three-PDF interactive Save-as-PDF measurement packet to Arch (Bundle Sheet · vape-show Equipment List · Small Cable Labels) — settles C2/C3/C4 numerically | GATED | Daniel | At printer/show, early Sprint 4 |
| GATE-OL25WR | OL25WR die-cut stock re-gate: Small Cable Labels (~7.7pt chip x-offset) + Tail Line Labels (~13pt first-row origin) — in-margins accept, else one scoped geometry amend | GATED | Daniel | At a printer, early Sprint 4 |
| GATE-C4 | C4 equipment-print pagination confirm on a live show (≈7pp v1 parity, per-page header/footer) | GATED | Daniel | On a live show, early Sprint 4 |
| R8-DRILL | Backup restore drill per the R8 runbook (restore-proven-yes); F4 feeds the attorney retention number | OPEN | Daniel | Before the September attorney engagement |
| VERCEL-CLI | Read-scoped Vercel CLI for CC pre-open verification | OPEN | Arch | Sprint-4 map item |
| PORT-CRIT | v1→v2 port named criterion + the cable-data-gap sequencing (equipment-only port + hand re-entry vs a cable-import extension unit; Aug-25 date retired) | AWAITING-RULING | Daniel | Sprint-4 map discussion |
| D-2b | Bundle Clone/Ext linkage (evidence banked incl. d2b_01–03 `3ffd371`; s441/s704/s504 frames; the B6 duplicate-cascade gap; Trigger B linkage schema) | OPEN | Arch | Sprint 4 |
| S504 | Residual s504 delete-variant frames (3 of 4); gates only D-2b's gate detail | BLOCKED | Daniel | When v1 cooperates |
| GS-C | Cable completeness: SPL-C split (661-wart adjudication) · INS-1 inspector tail/line summary · (bbbb) Show-Me routing · candidate (qqq)/(sss) CTF Enter hardening | OPEN | Arch | Sprint 4 |
| S3-G-2 | Residual v1 outputs (Shop Orders Basic/Detailed + remaining reports) — Sprint-4 home Daniel-CONFIRMED Aug 9 | OPEN | Arch | Sprint 4 |
| FOCUS-MP | Focus/nav mini-pass: (lll) ⌥⇧I on uncommitted model · (nnn) band-click currentRowId · (jjjj) fresh-commit ⌥⇧I → Category · (kkkk) F4-No blink · Aug-7 notes #4–#9 | OPEN | Arch | Sprint 4 |
| DWV | Dead-write verify mini-pass: grep the lazy-builder class; network-capture VERIFY each site before fixing; suspects EquipmentListClient.tsx:276 + the TopBar theme write; frozen adjacency | OPEN | Arch | Near-term, its own gated pass (early Sprint 4) |
| UNFLAG-WARN | Unflagged-cables print warning | OPEN | Arch | Sprint 4 |
| EFFGRP | effective_group / grouped-bundle-group view defect: bundled cable's own `group_manual` ignored (v1 shows the cable's own group); COALESCE(group_manual, bundle_group) proposal on the table | AWAITING-RULING | Daniel | Ruling → extraction + four-step migration (Trigger B) |
| P9-DROP | Phantom `v_cable_list.model` view-column DROP (P9 step 3; steps 1+2 landed at S3-G) | GATED | Arch | Its own Trigger-B micro-migration, early Sprint 4 |
| LINE-STECK | Line/steck label unit — ports the deferred line-row 🖨 trio (606/607/608, evidenced) | OPEN | Arch | Sprint-4 map |
| STECK-COLOR | Steck-color verify (P11 rider) | OPEN | Arch | Rides LINE-STECK |
| CMDK | ⌥⇧K command palette + top-bar shortcut icon (chord-registry verify pre-design; palette contents Parity-governed, opens with its own ruling block) | OPEN | Arch | Sprint-4 map candidate |
| LAT | Latency/optimistic unit — MANDATORY first leg = measurement recon (DB vs network vs render); candidate menu in evidence order (Ledger); absorbs (pp) remainder + item 13; frozen-region caution | OPEN | Arch | Post-basket, unscheduled |
| DEPS | Dependency-maintenance unit: the 7 pre-existing advisories · Next/postcss/sharp gated upgrade · `@supabase/ssr` 0.5.2→0.12 (likely baseline-event class) | OPEN | Arch | Pre-October beta; feeds security gate (b) |
| SHARE | Sharing-UI + membership layer (editor New-Defaults silent no-op fix; IMG-2 storage policies extend; adversarial cross-tenant isolation test = security gate (a) before ship) | OPEN | Arch | Private-beta prerequisite, pre-ADM-1 |
| ADM-1 | Beta admin panel (STRAT-ADM-R1..R8; metadata-only; manual provisioning + bare allowlist field; decoupling contingency protects October) | OPEN | Arch | Post-SHARE, pre-October |
| FR-1 | Find-and-replace mode on every find panel (design-gate questions banked in the Ledger) | OPEN | Arch | Post-Sprint-4, post-ADM-1 |
| EP | Equipment Projection unit proper (EP-R1..R6 ruled — Ledger; provenance Trigger B at open; ZA-2 rider; mixed-unit-lengths Trigger B rider; non-generic projection riders on box/RF sprints) | OPEN | Arch | At its own trigger, post-basket |
| 665-BR | 665 cable-form branch follow-on + wild-line defaults surface (`projects` wild-line default columns = its Trigger B) | OPEN | Arch | Unscheduled |
| EXPORT | v2→v1 export unit revival: Pass D v1-leg + second dry-run (EXP-6 L1) + the S-12 chain re-align | OPEN | Arch | End of Sprint 4 |
| GBD | Guarded bulk-delete (carries Library Delete Found; No-default constraint inherited) | OPEN | Arch | End of Sprint 4 (shares the EXPORT slot) |
| M0-WIN | Method-0 windowing equivalent check (gates the port-readiness "equipment-list PDF renders" criterion) | OPEN | Arch | Pre-port |
| 3TL | Three-tier library architecture (Minotaur global · user default · project) | OPEN | Arch | Pre-beta, unscheduled |
| S4-AUTO | Sprint-4 autocomplete conversion event: equipment method + box fields → autocomplete text · box field editable · (iii) filter pulldowns → autocomplete · the (mmm) method/box/group band-editability half — one idiom, one baseline event | OPEN | Arch | Sprint 4 |
| BASE-EVT | Declared baseline-event session: Bundle-List/D-2b frames + the dark cluster (yyy)(rrr)(ttt)(ggg)(xxx) + the KeyR unbind | OPEN | Arch | Sprint 4 (sanctioned session) |
| ALLOC | Allocate as type-conversion (D9) — the `allocated_from_id` consumer (landed + fenced consumer-less) | OPEN | Arch | Sprint 4 (the Allocate call) |
| CONCEPT-A | Print-header unit: top-left image · box logo · line2 + autosize · units · live preview | BLOCKED | Daniel | Gated on the a-1 uploads |
| LIB-RENDER | Library-grid render pass (hoist/memo the library row on B-6..B-9) | OPEN | Arch | Post-Sprint-4 |
| GCM-LAND | GCM→list focus landing (reuses (ss)'s param-landing machinery) | OPEN | Arch | Post-Sprint-4 |
| EST-AUDIT | Estimator-audit / measured pagination (D-3(a)) | OPEN | Arch | Unscheduled |
| UNDO | Session Undo/Redo (⚠ the note-propagation prompt is the sole guard on an unrecoverable destructive write) | OPEN | Arch | Unscheduled |
| VERHIST | Durable Version History (the cable inspector History stub joins its consumers) | OPEN | Arch | ~November |
| TRASH | Trash/Archive unit (DEL-4 successor) | OPEN | Arch | Post-Sprint-4, Trigger B |
| AUTH-DOMAIN | Custom-domain auth email (load-bearing public-beta prerequisite per STRAT-ADM-R2) | OPEN | Arch | Pre-public-beta |
| BINGO | Bingo disposition | OPEN | Daniel | Post-private-beta, pre-public-beta |
| RTL | Hook-test + RTL/component-test infra (repeatedly disclosed hard-stop dependency) | OPEN | Arch | Someday-maybe |
| MMM-CAT | (mmm) category-band-editability-under-other-sorts half | OPEN | Arch | Own pass, unscheduled |
| (ppp) | Settings page: project menu bar joins the fixed header (frame-06 declared event) | OPEN | Arch | Rides the next settings-touching unit or BASE-EVT-class session |
| TYPE-TOG | Equipment-list type-visibility toggle ((zzz) list-only filter is the interim truth; EP-R3 revisits) | OPEN | Arch | Post-Sprint-4 / EP |
| SEED | Fresh-project seeding: cable-catalog seed + the library seed-toggle 0-rows finding | OPEN | Arch | Unscheduled (mitigated by CTF in-flow creation) |
| KKK-PASS | (kkk) narrow-window responsive pass (equipment header collision · library grid overflow · the ~1508px cable-list residual) | OPEN | Arch | Immediately after Sprint 4 |
| NOTES-NL | Library-page notes fields strip newlines | OPEN | Arch | Unscheduled |
| GROUP-RES | Equipment grouping/sort engine residue (re-scope at open) | OPEN | Arch | Unscheduled |
| HARNESS | Harness pass: fail-hard path leaks the spawned dev server · frame-03 sort-flake recurrence · theme-toggle 10×10 intermittent · load-average sensitivity · `--update-baselines` per-frame scope flag · the settle-wait signature family | OPEN | Arch | Own small pass, unscheduled |
| REV-STAMP | Revision-stamp labels (Previous/Current) deliberately screen-sized to protect the D-2 layout pin — rule if point-true wanted | AWAITING-RULING | Daniel | Unscheduled |
| MPP-COS | Multi-page print preview cosmetic whitespace (screen only; prints correctly) | OPEN | Arch | Unscheduled, cosmetic |
| REV-SPRINT2 | Equipment Change All cross-surface constraints inheritance check at any future equipment Change-All touch (Sprint-2 carry) | OPEN | Arch | Opportunistic |
| (q) | Consolidate Zite source into ONE reference folder — verify status | OPEN | Daniel | Unscheduled |
| (u) | Snapshot-fetch failure surfaces console-only — wire the existing `errorMsg` banner | OPEN | Arch | Unscheduled |
| (ff) | Tab strip renders no selected button on revisions/settings — confirm acceptable or rule | AWAITING-RULING | Daniel | Unscheduled |
| (yy) | Methods admin non-rename fields swallow DB errors | OPEN | Arch | Unscheduled |
| (aaa) | ⌥⇧F find-seeding on the focused field — misses Model specifically (Zite-extraction-gated) | OPEN | Arch | Unscheduled |
| (bbb) | Autocomplete inline-completion Enter commit: typed "foo" commits the completion (Zite-extraction-gated) | OPEN | Arch | Unscheduled |
| (ccc) | Quantity Escape-revert missing — the unmount net quietly commits dirty values (H-4) | OPEN | Arch | Unscheduled |
| (eee) | Exact-match autocomplete suppression (Zite precedent check first) | OPEN | Arch | Unscheduled |
| (fff) | REM column → editable quantity text field (v1 parity; extraction-gated) | OPEN | Arch | Unscheduled |
| (hhh) | Editing a category with its band header off-screen: typed text live-updates the sticky header | OPEN | Arch | Unscheduled |
| (jjj) | Remaining-cell save-error-flash gap (contract-fenced surface — pending ruling) | OPEN | Arch | Unscheduled |
| (vvv) | Inverted-extension end DISPLAY may be un-swapped vs v1 — verify against v1 evidence | OPEN | Arch | Unscheduled |
| (dddd) | `# ` autoformat headings print literally (accepted limit; one-line hard-disable if strict print fidelity is ever ruled) | AWAITING-RULING | Daniel | If it chafes |
| (ffff) | New Defaults Method/Group inputs render DARK chrome in light mode — needs its own ruling/extraction | OPEN | Arch | Unscheduled |
| SNAP-CHK | Registered one-query check: any production snapshots lacking `items`? (feeds the legacy no-items fallback retirement) | OPEN | Arch | Opportunistic |
| CONTRAST | Contrast recon (filter-pulldown option text + producer/theater line) | OPEN | Arch | Unscheduled |
| DASH-FRAME | /dashboard capture frame (harness coverage gap) | OPEN | Arch | Candidate for a future baseline event |
| TAB-BRIDGE | Cross-band Tab bridge design question (parity ledger) | OPEN | Arch | Unscheduled |
| GIT-CFG | Real `git config user.name/email` · Next 16 `middleware`→`proxy` migration | OPEN | Daniel | Housekeeping / eventually |
| LINT | Lint entrypoint (Next 16 removed `next lint`; no flat config) — out of acceptance gates until it exists | OPEN | Arch | Unscheduled |
| ST-RACE | Minor `setTimeout` race in error-flag cleanup | OPEN | Arch | Low, unscheduled |
| CTF-SEED | CTF edit-dialog seed helper unused by the grid — retire opportunistically | OPEN | CC | Opportunistic |
| IMP-SORT | Import sheet order → sort_order, the v1-importer half (activating = reading v1's latent Sort Override; own session with v1 evidence) | AWAITING-RULING | Daniel | Unscheduled |
| SRGRANT | `service_role` GRANT restore sweep | OPEN | Arch | Housekeeping or security gate (b) |
| BRIEF-12 | Brief v1.2 pass (Strat queue items 1–8 + the stack-truth rider — the cable-table list is stale) | OPEN | Daniel | Strat scheduling |
| COMMS-Q | Comms queue: October-announcement screenshots (finished equipment section) → license-holder email by tier → university outreach → landing page → help docs → support@ → demo video · Comms Prompt v9→v10 | OPEN | Daniel | Comms sessions; October announcement |
| LEGAL-SEP | September attorney engagement: ToS · Privacy Policy · EULA · IP assignment · beta terms (R8 F4 feeds retention; addendum delivered) | OPEN | Daniel | September 2026 |
| LIC-NOV | Licensing subsystem design (concurrent sessions · demo zero-export · expiry ladders · collaborator data-fate · Century Gothic webfont licensing · license admin) | OPEN | Daniel | ~November 2026 |
| COWORK-P2 | Cowork Phase 2 pilot: seed `~/Developer/Minotaur-Cowork/` · 2–3 doc sessions · keep/expand/revert review (one-writer-on-the-repo rule standing) | OPEN | Daniel | Post-housekeeping, pre-Sprint-4 |
| WF1A-SUNSET | WF-1a commit pilot + auto-mode rider sunset review | GATED | Daniel | Sprint 4 close |
| PRUNE-CHK | Claude.ai project-file hygiene check (the Aug-9 prune executed; verify the two Aug-5 S3-G draft files gone) | OPEN | Daniel | Next convenient open |

## ❓ Open Questions (live only)

Resolved questions exit to the Ledger's Rulings with the ruling that resolved them (this migration moved: S3-G-2 home · Aug-25 · fold path · Sprint-4-planning placement · Ledger v1.0 · UX-catalog destination · status vocabulary · bundles UNIQUE · a-3 units consumer · V-1/baseline placements).

- **Script 551 extraction** — optional-future (83 steps; E2 stands on Daniel's attestation).
- **Cross-surface checkbox eligibility for CABLE Change All** — consistency question, unscheduled.
- **House-wide Cancel semantics** — V-1's Cancel=revert vs the 688 edit-stands Cancel; asymmetry accepted, revisit if it chafes.
- **Used∩Ignored semantics** — Arch: keep-current; Daniel ruling owed.
- **Empty-string note decision** — product ruling owed.
- **Link `field_name` CHECK backstop** (B6) — registered future Arch schema question.
- **Cable-type RENAME affordance** — future anatomy addition needing its own pedigree.
- **Method-field-in-list autocomplete sequencing (#3)** — pull forward vs ride S4-AUTO → docket-ruled at the Sprint-4 map discussion.
- **CL a-1 evidence uploads** (non-blocking): v1 Cover Letter CONFIG screenshot + a rendered v1 cover/title page (gates CONCEPT-A) · a-2 Lovable source optional.
- **d2_01 red Members count** ("11" on Tech Distro) — trigger unknown; rendered neutral.
- **CL multi-letter-per-project** — deliberately not built (CL-R3); future question.
- **Stale-category-text healing policy** — data-hygiene ruling, unscheduled (→ SEED-adjacent).
- **CC credit-budget standing policy** — Strat question.
- **Port-readiness gate criteria** — refined at PORT-CRIT's ruling (incl. the storage-backup addendum).
- **Comms Prompt structure** — next Strat/Comms session (COMMS-Q).
- **OQ#2b own-band pendency shape** — banked future option (CC handoff 260801-1029), supersedes ZA-3 visuals if they annoy.

---

*End of Roadmap v3.0 — August 9, 2026. History: `Minotaur_v2_Ledger_v1_0.md`. The previous format's final file, Roadmap v2.46, is archived byte-exact.*
