# REVPAIR-TAILSORT: a revision pairs in any print sort, a new project's print settings are v2's, and "by model" tail labels sort by model

Tier: claude-opus-5
Model: claude-opus-5
Session: FRESH

*Arch, main line, 2026-09-19. METHOD-SORT-BLANK is committed and pushed (`afd4e03`), and **migration 80 is applied**
(`20260919162802_methods_sort_order_blank_backfill`; 21 import-created zeros → blank, the column default dropped,
import createMissing methods now insert blank). **Its file of record is written to `supabase/migrations/`, untracked,
and rides this commit.** Read HEAD and origin from the ref files, and read the ledger live (80 expected).
Two units are bundled here on Daniel's word ("bundle them"). Both are small, ready and approved, and they
touch separate files.*

- Part 1 is **REVPAIR-CROSS-SORT**, from the parallel return
  `handoffs/parallel/260919-1105_revlist-regression_RETURN.md` §5. It is carried here verbatim in
  substance.
- Part 2 is **PRINT-REPARITY-TAILSORT**, from `handoffs/parallel/260919-1124_print-reparity_RETURN.md`
  §8 B.

**⚠ Every answer you need is in this file. There is no blank for anyone to fill in.**

## §0 · HARD STOPS

1. **No migrations and no SQL writes.** The `projects.print_list_settings` column default is not changed
   in this unit; the app normalises what it reads. Changing the default is Arch's, later, under
   Trigger B.
2. **The persisted revision snapshot shape does not change.** `revisionSnapshot.ts` writes exactly what
   it writes today (REVGROUP-SPLIT, Arch 2026-09-07). The fix is on the read side.
3. **No label geometry changes.** Part 2 is order and paging only. A regression test pins the cell
   numbers.
4. **Test shows only**: JOY `b04ab9b5…` and the other `daniel+test01@` projects, or seeded throwaways.
   **Never Buena Vista Social Club.**
5. **Expected gate: 28/28, no baseline event.** Frame 07 is a same-sort pair and must pair identically.
   If a frame moves, stop.
6. Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the handoff file's
   RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or
   describe it. Show every line."*
7. GATE-NOGREP. Commit only on Daniel's `COMMIT APPROVED: <first words>`, after his gate.

## §1 · Rulings of record

- **Daniel, 2026-09-19:** *"OK, revision fix and parity measures approved."*
- **Daniel, 2026-09-19, on the cable comparison:** *"2. sort as number approved"*. v2's number-aware
  model order stands (6-Pair, 12-Pair, 19-Pair). It is a named divergence from v1's text order: write it
  into the source with its date, so nobody "fixes" it back from a v1 print.
- **The tail label sheets keep the 2026-08-30 ruling:** a model section starts a page. This is recorded
  at `TailLabelsPrintClient.tsx:684-686`. Quote the Ledger line when you touch it. Arch did not find
  Daniel's own words there; say so if you can't either.

## §2 · CP1: re-bucket the old revision into the print's sections before pairing (REVPAIR, part 1)

**The defect (measured).** A revision saved from a BY-CATEGORY print has sections with no `methodName`.
A BY-METHOD print keys its sections `${methodName}|${header}` (`revisionPairing.ts:82-87`). So 0 of 17
old sections match any of the 29 current ones:

- every current row prints as added;
- all 299 old rows print as orphan deletions after the last list (`PrintEquipmentListClient.tsx:879-927`).

Measured on JOY `b04ab9b5`, snapshot `16ebe6f9`, search `method: rent`, at both `7c96904` and `4fe0af9`.
It has been present since `bb66bb3` (2026-07-12). The reverse direction already pairs.

**Pedigree (b):**

- v1, Daniel's `260919-1039_v1_revised-basic-by-method_JOY_FILEMAKER.pdf`: v1 pairs by model whatever
  the sort.
- Zite, `docs/reference/zite-src/src/pages/data/PrintEquipmentListPage.tsx:1227-1239`
  ("Cross-sort-mode fallback").

The section-scoped old quantity is kept, so there is no cross-section double count.

**The step.** It is a pure step on the old sections, run BEFORE `buildOldGroups`, given the print's
`sort` and `methodsList`:

- `sort === 'by-category'`: no change. Prove it; don't touch it.
- `by-method-category`, and every old section carries a `methodName`: no change.
- `by-method-category`, and an old section has no `methodName`:
  - Split each row that has an item breakdown by the method GROUP of each item's own `method`. Use the
    same rule as `buildSections`' `groupKeyOf` (`printEngine.ts:952-955`: the shop-order header,
    trimmed, else the method name).
  - Emit one old section per `${group}|${header}`, with `quantity` and `remainingQuantity` re-summed
    from the items it keeps.
  - Colour: the group's method colour from `methodsList`, else the snapshot's `methodColorName`.
  - A row with NO item breakdown (legacy o-B) keeps today's path. Don't guess a group for it.
- A method name that today's `methodsList` doesn't know falls back to the raw name as its group, and
  orphans under that name. Report how many old items hit this on JOY.

Wire it at the one call site, the `paired` memo (`PrintEquipmentListClient.tsx:820-823`), after
`filterOldRevisionRows` and before `pairRevision`. Every existing `pairRevision` test passes unchanged.

**Success condition, on JOY against `16ebe6f9`, search `method: rent`:**

- current rows **305**, "From" filled **291**, deletions in-section **35**, orphan sections **0**;
- the deleted `(header|model)` set is IDENTICAL to the by-category print's 35;
- the harness is `~/Minotaur_v1_exports/parity-pairs/260919_revlist-regression/harness/run2.ts`, or a
  test built on the same data.

**Tests** (REPORTED where v1 is silent):

- the three branches;
- the legacy no-items row;
- the double-count guard: a model in two method groups in the OLD revision gets each group's own
  quantity, and their sum in a by-category print;
- the reverse direction unchanged.

## §3 · CP2: a new project's print settings are v2's from the first open (REVPAIR, part 2)

`PrintEquipmentListClient.tsx:1966-1973` spreads `projects.print_list_settings` over `DEFAULT_SETTINGS`
unchecked. The live column default is Zite-shaped: `sort: "by_category"`, `dateFormat: "M/D/YYYY
h:mmp"`. So on a fresh project:

- no sort radio is selected (`:321-322`);
- the footer date has no time (`:796`).

**Normalise on read, in one pure function with a test:**

- an unknown `sort` → `DEFAULT_SETTINGS.sort`;
- an unknown `dateFormat` → reuse `cablePrintSettings.ts:69`'s `readPrintDateFormat`; don't write a
  second copy;
- `type`, `title` and the booleans pass through when their type is right;
- unknown keys are ignored.

Don't write anything back until the user changes something.

**Gate:** a new throwaway's Print Options open with **By Category** selected, and the preview footer
carries the time. Census 0 afterwards.

## §4 · CP3: "By model" tail labels sort by model (PRINT-REPARITY-TAILSORT)

**The defect (read at source by the parallel).** `TailLabelsPrintClient.tsx:213-225` sorts by model.
Then every builder re-sorts each run with `byParentThenEnd` (`cableLabels.ts:180 / 214 / 240 / 274`),
so "by model" comes out in cable-name order with a page break at every model change. On JOY:

| Sheet | v2 today | v1 |
|---|---|---|
| Small Tail Block Labels | **14 sheets** | 2 |
| Tail Line Labels by model | **40 pages** | 26 |

1. **The model order must survive the builders.** Either the builders take a comparator, or "by model"
   sorts inside them; your structure. Model order is number-aware (§1): 6-Pair, 12-Pair, 19-Pair. Add
   the dated divergence comment. Within a model, cables keep today's `byParentThenEnd`.
   - Evidence: `~/Minotaur_v1_exports/parity-pairs/260919_print-reparity/`, the v1 Small Tail Block file
     pp. 1–2 (44 + 59 labels) and the v1 Tail Line by-model-include file (26 pp).
2. **Move "Include / Don't Include Small Tail Block Label" to the Tail Line sheet**, where v1 offers it.
   v2 shows it on the Small Tail Block sheet, where it does nothing, and always includes the blocks on
   Tail Line.
   - Evidence: the v1 Tail Line by-cable file (no block cells) against the by-model-include file.
   - Read frame 040 of the v2 screen before moving the control, and quote it.
3. **No geometry change.** Add a regression test that pins §4.5 and §4.6 of the reparity return (block
   cell, line cell, model marker, page header).
4. **Blast radius:** Tail Panel uses the same sorted list (`panelBreaks`). It passed parity on
   2026-09-19 and must pass again. Pin it.

**Success, on JOY:**

- Small Tail Block **≤ 3 pages**: one per model, by the 2026-08-30 ruling;
- Tail Line by model **≤ 27 pages**;
- **one** marker per model;
- Tail Panel output byte-identical to before.

## §4b · CP4: how blank methods and (No Method) order (METHOD-SORT-BLANK's OQ1 and OQ2, now ruled)

**Daniel, verbatim, 2026-09-19:** *"two blank methods should order between themselves alphabetically. no method should go ahead of them."*

- **OQ1, blanks between themselves:** two blank methods order **alphabetically by method name**. This
  applies at every site `compareMethodSortOrder` serves:
  - the screen chain, the filter pulldown and the method bands (`EquipmentListClient.tsx`);
  - the Methods admin;
  - both print branches: the by-method group order in `buildSections`, **ahead of** its category term;
  - every method pulldown (`fetchMethods`: order nulls last, then name, not id).

  Put the name tiebreak inside the one comparator (or a companion that every site uses) rather than at
  each site. **Equal numbered values keep today's next term.** The ruling is about blanks. Report any
  site where a name tiebreak would also reorder two methods that share a number, and don't change it.
- **OQ2, "(No Method)":** it sorts **ahead of the blank methods**: after every numbered method, before
  the first blank.
  - Arch's reading of *"no method should go ahead of them"* is **(No Method) is placed before the
    blanks**. That reading is named in the return so Daniel can correct it in a word.
  - On screen, the band's old `999` currently sorts it before the N/A row (≥1000). Print and the chain
    currently tie it with blanks. **Make all three agree:** numbered (0 first) → N/A row at its fixed
    rank → **(No Method)** → blank methods A–Z.
  - If putting (No Method) after the N/A row changes where it sits on screen today, report the before
    and after. The ruling places (No Method) against the blanks only.
- **OQ3 (section numbers)** stays report-only. Don't redesign it.
- **Tests:** two blanks out of name order come back A–Z at every site; (No Method) lands between the last
  numbered method and the first blank. Add a deletion control.
- **Gate item for Daniel, on JOY:** clear two methods' Sort Override, choosing names out of alphabetical
  order, and print by method. Both come after the numbered methods, A–Z, with any (No Method) section
  directly before them. Put them back.

## §5 · Close

- Run the full suite, typecheck, lint, build, frozen 3/3, the gate 28/28 with no event, and the
  dependency gate. Census 0.
- Update the fence (FENCE-ONEUNIT, with this bundle as the one unit).
- Return DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT, plus the COMMIT BLOCK.

**Daniel's gate, on JOY only.** Restart `:3100` first.

1. Print → Show Revisions → `Rev 9/19/2026 10:34a` → **by method**, search `rent`:
   - **19 pages**;
   - DiGiRack ×5, SD10 GPI, SD10 GPO, SD10T and Galileo 616 struck through inside 1.0 Consoles and 1.1
     Processing;
   - HMA 10m reads `1 → 2`;
   - nothing after 13.1 Tails.
2. **Small Tail Block Labels**, by model: 3 pages or fewer, in number order.
3. **Tail Line Labels**, by model: 27 pages or fewer. The include-blocks choice is on this sheet.

The COMMIT BLOCK includes `supabase/migrations/20260919162802_methods_sort_order_blank_backfill.sql`.

Proposed subject: `REVPAIR-TAILSORT: revisions pair across print sorts; print settings normalised; tail
labels sort by model; blank methods A-Z`.
