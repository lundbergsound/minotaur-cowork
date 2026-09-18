# PARALLEL OPENER — PAPERWORK's find-or-options screen (LAYOUT-FINDSCREEN)

*Written by the Cowork-Arch main line, 2026-09-18 12:15 ET, while CC runs BATCH-FRONTDOOR. Governing
set: **Architecture Prompt v39** · **Roadmap v4.45** · Brief v1.2 · Session Log. Read them first, in
the prompt's order.*

## Your one scope

**Design, once, the find-or-options screen that six of the nine PAPERWORK layouts land on in v1
before they print, including the `Add Blank Records` skip-N offset four of them want.** v2 has
built none of them. Design only: no build, no CC handoff.

## Rules of this seat (Architecture Prompt v39, Parallel sessions)

- **ONE-WRITER-HOLDS: a CC session is live.** Write nothing to the code repo, not even
  `docs/reference/`. Read it freely.
- No CC handoff, no schema, no migration, no governing-document edit. **Never run git** in either
  repo folder. Read HEAD from `.git/refs/heads/main`.
- Your return goes to `handoffs/parallel/` **and** a copy to `drafts/`, because `handoffs/` is gitignored.
- Filenames carry the time of writing (PARALLEL-CLOCK).
- **Write to Daniel, not to yourself.** Every ruling you need from him is one plain question he
  can answer in a word, with the v1 behaviour quoted, not paraphrased.

## State at writing — verify it

- Code `fcdeb2a` = `origin/main` (BATCH-FRONTDOOR in flight, so HEAD may move; re-measure any
  citation you lean on). Migration ledger **77** (SET-FORM applied 12:07 ET). Live-read it.

## What is already known — do not re-derive

- **The eight August designs** (now nine with Bundle Labels ruled in):
  `handoffs/parallel/260828-1430_remaining-layouts-design.md` (+ `…-questions.md`). Every found set is
  reconciled to a real v1 print there. The options-screen evidence per layout is in that file:
  Group Parts (§4.1, Find on Category · Group · Method, multi-request OR find from Daniel's
  screenshot), Device Patch (§4.2, Group · Device), Equipment Labels (§4.3, `Search-Equipment
  Labels Options` id 281, sort + `Add Blank Records`, then Find on Description · Group · …),
  Bundle Labels (`Search-Bundle Options`, three sorts + `Add Blank Records`), Steck Labels (three
  sorts, Model-before-Name, `Add Blank Records`), Tail Folder Labels (`Add Blank Records`). Bundle
  Summary and Line List have **no** find screen in v1.
- **The v1 scripts behind them:** `Minotaur/docs/reference/v1-cable-box-catalog/extracted/scripts/`
  (e.g. `464_Layout-Equipment Labels.txt`, `397_Layout-Steck Labels.txt`,
  `218_Layout-Bundle Labels.txt`, `719_Layout-Tail Folder Labels.txt`) and `Minotaur_v1_UX_Catalog.md`.
  DDR-IS-THE-SOURCE: the design report beats any screenshot.
- **Ruled already (Ledger, OQ9):** adopt live-narrowing results under the find fields, and Truck as a
  box find field; **v1's three separate label menu entries stand** (no one-page type radio); **Box
  Contents gets no options screen**.
- **`SkipLabelsDialog` already exists on four surfaces** (HELD row SKIP-LABELS). The offset is to be
  designed as one thing, reusing or replacing that, with its reason stated.
- **The stock is the die** (STOCK-IS-DIE): 5167 is 4 × 20; 5160 is 3 × 10. Skip-N counts cells on
  that stock. Daniel's print on real 5167 stock is still owed and settles three open questions;
  **do not design around a guess at its answer.** Name what it settles and leave those slots open.

## Who it serves

A crew member in a dark shop printing labels onto a part-used sheet. Prefer what needs no
configuration: sensible defaults that print everything, one control for the offset, and nothing
the operator must understand to get a correct sheet.

## Deliverable

`handoffs/parallel/<YYMMDD-hhmm>_paperwork-findscreen_DESIGN.md` + `drafts/` copy:

1. One screen, specified per layout: which find fields, which sorts, whether the offset shows,
   and the default. Every choice carries a pedigree: (a) a Daniel ruling by ID, (b) evidence by
   file and frame or script number, or (c) a clearly marked proposal. Uncited = unbuilt.
2. The skip-N control specified once, against the die.
3. What it costs the visual gate (new frames or a declared event), measured from
   `scripts/visual-capture.mjs`, not predicted.
4. **The rulings Daniel owes, batched, one plain line each.** Trigger A applies: this is a new flow.
5. A plain-English block at the top that Daniel can read on its own.

The main line folds it in and writes the build handoff. **Not before Daniel's PAPERWORK
walkthrough sets the order inside the unit.**
