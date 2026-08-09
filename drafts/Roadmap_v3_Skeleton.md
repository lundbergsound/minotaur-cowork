# Roadmap v3 Skeleton — Two-File Architecture (Strat decision 6)

*(DRAFT — produced in the 2026-08-09 parallel drafting session. STRUCTURE
ONLY: no content is migrated here, because v2.47 does not exist yet and
anything drafted against v2.46 is stale on arrival. The post-S3-G
housekeeping session executes the migration against v2.47 using the
procedure at the bottom of this file.)*

---

## Plain summary

The Roadmap splits into two files. **File 1 (the Roadmap)** is
forward-only and stays small: what's true now in ten lines or fewer, the
sprint plan, one unified docket of every open item, and the live open
questions. **File 2 (the Ledger)** is the memory: rulings, corrections,
lineage, completed units — written every close, read only when something
needs citing. The v2.4x single-file format grew because history and
future shared one document; v3 separates them so the working file stops
growing.

---

# FILE 1 SCAFFOLD — `Minotaur_v2_Roadmap_v3_0.md`

```
# 🗺️ ROADMAP — Minotaur v2 (v3.0)

## Current Status (<date>)
<HARD CAP: 10 lines. What is live, HEAD hash, gate state, what is in
flight, the single next action. Lineage chains, commit narratives, and
per-unit detail live in the Ledger — a status line may cite a Ledger
entry, never reproduce it.>

## 🏗 Sprint Plan (scope of record)
<Current sprint scope + the named next-sprint basket. Completed sprints
retire to the Ledger's Completed Units at each sprint close.>

## 📌 Unified Docket (the ONE register of open items)
<Every open item in the project, one row each, in the schema below.
This absorbs the v2.4x Punch List (open rows), both Registered Units
sections (open units), the workstream queues, and any dated errand.
Nothing open lives outside this table.>

| ID | Item (one line) | Status | Owner | Trigger |
|----|-----------------|--------|-------|---------|

## ❓ Open Questions (live only)
<Questions awaiting a ruling, one line each, cross-referenced to a
docket ID where one exists. Resolved questions move to the Ledger's
Rulings with the ruling that resolved them.>
```

## Docket schema (decision 6, operationalized)

Every row carries exactly: **ID · Item · Status · Owner · Trigger.**

- **ID** — permanent, never reused. Existing identifiers survive
  migration unchanged: punch letters keep their letters (the
  letters-permanent rule of record is preserved, not retired), named
  units keep their names (S3-G-2, GS-C, D-2b, FR-1…), dated errands get
  `E-<YYMMDD>-<n>` at migration.
- **Status** — one word from a fixed vocabulary. Proposed set (Daniel
  may trim or rename at execution): `OPEN` (registered, not started) ·
  `GATED` (waiting on a named gate or design gate) · `AWAITING-RULING`
  (waiting on Daniel) · `IN-BUILD` (an active session owns it) ·
  `BLOCKED` (waiting on an external dependency).
- **Owner** — exactly one of `Daniel` / `Arch` / `CC`. The owner is who
  moves it next, not who cares about it.
- **Trigger** — when it goes live: a date, a named event ("Sprint 4
  open", "post-ADM-1", "at the next declared baseline event"), or
  `unscheduled`. The Docket Sweep's "triggers went live" check (decision
  5) reads this column — vague triggers make the sweep blind, so every
  trigger must be checkable in one glance.

## Worked example rows (ILLUSTRATIVE — values as of v2.46; every value
## restated against v2.47 at migration, never copied from here)

| ID | Item (one line) | Status | Owner | Trigger |
|----|-----------------|--------|-------|---------|
| R8-DRILL | Backup restore drill per the R8 runbook; F4 result feeds the attorney retention number | OPEN | Daniel | Before Aug-10 shop prep |
| S3-G-2 | Residual v1 outputs (Shop Orders Basic/Detailed + remaining reports) — Sprint-4 home recommended | AWAITING-RULING | Daniel | One-word confirm |
| FR-1 | Find-and-replace mode on every find panel; design-gate questions banked | OPEN | Arch | Post-Sprint-4, post-ADM-1 |
| E-260805-1 | Residual s504 delete-variant frames (3 of 4); gates only D-2b's gate detail | BLOCKED | Daniel | When v1 cooperates |

Why these four: they exercise the full schema — three owners, all three
trigger shapes (dated / event / unscheduled-external), and both
ruling-shaped and build-shaped items.

---

# FILE 2 SCAFFOLD — `Minotaur_v2_Ledger_v1_0.md`

```
# 📒 LEDGER — Minotaur v2 (v1.0)

<Write-mostly; read on citation. Sessions APPEND here at close (the
Docket Sweep and close package name what was appended); nothing here is
edited after it lands except to mark supersession — prior entries are
immutable in the Session Log manner. This file may grow without limit;
its size is not a defect.>

## 📐 Rulings of Record
<The v2.4x rulings register, carried forward whole, then appended per
close. Each ruling keeps its ID; supersessions annotate, never delete.>

## 🧾 Corrections of Record
<The rolling corrections register, same discipline.>

## 🔗 Lineage
<Commit chains and per-unit build narratives — the material currently
inflating Current Status. Organized by unit/window, append-only.>

## ✅ Completed Units (retained for citation)
<Every built unit's citation block: what shipped, commit(s), rulings it
carries, riders discharged. Absorbs the "Retained for citation only"
rows from both v2.4x Registered Units sections and the Complete bullet
of Current Status.>

## 📚 Reference registers
<Stable non-item registers that are neither status nor docket: the UX
Reference Catalog, the v1 export corpus inventory, evidence-commit
index. Pointer-style — the artifacts themselves live in the repo.>
```

---

# MIGRATION PROCEDURE — v2.47 → v3.0 (executed by the housekeeping
# session; every step against the LIVE v2.47, never against v2.46)

Plain summary: walk v2.47 top to bottom, send every section to exactly
one destination, then prove nothing was dropped by reconciling counts.

**Step 0 — preconditions.** v2.47 exists (the S3-G close package
landed); Daniel has ruled on the Status vocabulary and any destination
flagged OPEN below. The migration is one session, one sitting — a
half-migrated roadmap is worse than either format.

**Step 1 — section map.** Each v2.4x section, its v3 destination:

| v2.4x section | v3 destination |
|---------------|----------------|
| Current Status | Roadmap → Current Status, REWRITTEN to ≤10 lines. All lineage chains, per-unit narratives, gate histories, and the evidence-corpus inventory → Ledger (Lineage / Completed Units / Reference registers). Nothing from the old Status is pasted forward; the 10 lines are written fresh. |
| 🗺 Build Order | Forward remainder (unbuilt sequence) → Roadmap Sprint Plan. Completed-pass history and findings of record → Ledger (Completed Units / Rulings). Standing constraints embedded in it (e.g. autocomplete-from-day-one) → the docket or Sprint Plan as standing rules, per item. |
| 📌 Punch List | Open punches → Unified Docket rows, LETTERS PRESERVED as IDs. Closed punches → Ledger Completed Units. The letters-permanent rule is restated at the top of the docket. |
| 📐 Rulings of Record (+ dated rulings blocks) | Ledger → Rulings of Record, carried whole. |
| 🧩 Registered Units (first section) | Open units → Unified Docket rows. "Retained for citation only" units → Ledger Completed Units. |
| 🏗 Sprint Plan | Roadmap → Sprint Plan (current + basket). Closed sprints → Ledger. |
| 🔀 Parallel Workstreams | Open queue items (CLAUDE.md queue, Brief v1.2 queue, Comms/Legal dated items) → Unified Docket rows with owners and triggers. Narrative framing → Ledger if worth keeping, else dropped with Daniel's confirm. |
| 📚 UX Reference Catalog | Ledger → Reference registers. **[DESTINATION FLAGGED — Daniel may prefer it stays in the Roadmap for at-hand reference; rule at execution.]** |
| 🧾 Corrections of Record | Ledger → Corrections of Record, carried whole. |
| 🧾 Registered Units (second section — v2.46 carries TWO sections of this name) | Same split as the first: open → docket, citation-only → Ledger. The duplicate-name defect dies here; v3 has one docket. |
| ❓ Open Questions | Live questions → Roadmap Open Questions, cross-linked to docket IDs. RESOLVED-since lines → Ledger Rulings. |

**Step 2 — docket population.** Build the Unified Docket from the four
inbound streams (punch list, both registered-units sections, workstream
queues, open-questions items that are really items). Every row gets all
five fields; a row that can't name its owner or trigger goes to Daniel
as a numbered batch before the migration closes.

**Step 3 — reconciliation (the no-drop proof).** Count v2.47's open
punches + open registered units + open queue items + live open
questions. Count v3 docket rows + v3 open questions. State both counts
and account for every difference by name (merged rows, dissolved items,
items Daniel retired at migration). A silent count mismatch fails the
migration.

**Step 4 — close.** v2.47 is archived byte-exact alongside the Session
Log archives (it is the last single-file roadmap; it is never edited
again). The close package (with its Docket Sweep — the first one runs
against the new docket) records the migration. Governing-document
references to "the Roadmap" now mean File 1; citations of historical
material name the Ledger.

**Open questions carried to the fold-in sheet:** Status vocabulary
confirm · UX Reference Catalog destination · whether the Ledger starts
at v1.0 or inherits the Roadmap's version line.
