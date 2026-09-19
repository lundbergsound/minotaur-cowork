# REVLIST-REGRESSION — parallel Arch return (diagnosis only)

*Parallel Arch seat (Cowork), 2026-09-19 11:05 EDT. Scope: the REVISED (Show Revisions) equipment-list print, plus the v1/v2 paperwork parity list Daniel asked for. No CC handoff issued, no schema or SQL writes, nothing written to the code repo, git never run. State read from files: HEAD = origin/main = `4fe0af9`, no `index.lock`; migration ledger **79** (latest `20260919144200`), read live. A METHOD-SORT-BLANK CC run is open (`to-cc/260919-1050_method-sort-blank.md`); this seat wrote nothing it touches.*

---

## For Daniel — where this lands

**The revised list is not broken by last night's print unit, and rolling back would not bring it back.** It fails because of how v2 has matched an old revision against the current list since July, and today was the first time you used it the way v1 lets you: save the baseline from one kind of print (by category) and compare in another (by method).

What happened on your print, in one line: v2 looked for each old row inside a section named *"Main List | 1.0 Consoles"*, but the 10:34a revision you compared against was saved from a by-category print, so its sections are named just *"1.0 Consoles"*. Nothing matched. Every current row printed as **added** (green, no "From" number), and every old row printed as **deleted** — all 299 of them, dumped after the Cable list as pages 19–34. That is the 34-page print.

- **v1** matches old rows by model alone, whatever sort the list is in. **v2** matches by model *inside a section*, and a by-method section's name includes the method group — so a by-category revision can never match a by-method print. The other direction (by-method revision, by-category print) works. Same-sort comparisons work, which is why the 9/18 gate print was fine and why it looked fine on 8/12.
- **It has been this way since the pairing module landed on 2026-07-12** (`bb66bb3`, "Revision-compare Pass A"). That file has had exactly one version since. PAPERWORK-1 did not touch it; I ran the same data through the code at both `7c96904` and `4fe0af9` and got identical results (0 of 305 rows paired at both).
- **The fix is small and read-side only:** before pairing, re-sort the old revision's rows into the print's own sections using the method each old item already carries. The 10:34a revision has that per-item method on all 299 rows. Tested in a harness against your real data: **291 of 305 rows get their "From" number, 35 deletions land in their sections, 0 orphans — the same 35 deletions the by-category print finds today.** A CC handoff is drafted below, not issued; the main line issues it.
- **Rollback of `4fe0af9`: not warranted.** Measured: the revised print is identical at the commit before it. A rollback would lose the solid row rules, the name-wrap fix, the widened Current column, Bundle Summary and Line List, and buy nothing. Your call, but the trade is all cost.
- **Until the fix ships, the workaround is: compare in the same sort mode the revision was saved in.** Your 10:34a revision pairs correctly in a by-category print (264 of 278 rows, 35 deletions). Or save a fresh baseline from a by-method print and compare by method.

One more thing I found on the way, smaller: a **brand-new project opens Print Options with no sort radio selected and no time in the footer date**, because the database seeds a new project's print settings with old Zite-era values (`sort: "by_category"`, an old date-format string) that v2's print page doesn't recognise. That is why your first print today was a by-category "Detailed List" and why the 9/18 gate print's footer reads "9/18/2026" with no time. Same handoff, two lines.

**Next step for you:** read the parity list in §6 and mark each numbered item approve / don't approve. Nothing else is needed from you for the fix.

---

## §1 · What Daniel reported, in his words

> "see comparisons from v1 and v2. each time, I filtered the search to method 'rent'. we've lost the revised equipment functionality that worked as recently as 8/12."

Prints supplied (one fresh JOY, filed as a matched pair at `~/Minotaur_v1_exports/parity-pairs/260919_revlist-regression/`):

| Print | v1 (FileMaker 17.0.1) | v2 (Chrome 152, Skia/PDF) |
|---|---|---|
| Basic by method | `260919-1036_v1_basic-by-method_JOY_FILEMAKER.pdf` · 19 pp | `260919-1037_v2_basic-by-method_JOY_CHROME.pdf` · 19 pp |
| **Revised** basic by method | `260919-1039_v1_revised-basic-by-method_JOY_FILEMAKER.pdf` · 19 pp | `260919-1040_v2_revised-basic-by-method_JOY_CHROME.pdf` · **34 pp** |
| Detailed | `260919-1040_v1_detailed-by-category_JOY_FILEMAKER.pdf` · 55 pp, **by category** | `260919-1041_v2_detailed-by-METHOD_JOY_CHROME.pdf` · 54 pp, **by method** (settings read from the revision row saved with it: `sort: by-method-category`) — this pair is not sort-matched, see §6 |

The v2 revision rows behind these prints (`equipment_list_revisions`, project `b04ab9b5`, read live):

| Saved | Name | Settings | Sections |
|---|---|---|---|
| 14:34:14Z | Before import: v1 export 2026-09-19 | — | 0 |
| 14:34:39Z | Rev 9/19/2026 10:34a `16ebe6f9` | `sort: "by_category"` · type detailed · title "Detailed List" · dateFormat `"M/D/YYYY h:mmp"` · search method `rent` | **17, all `methodName: null`** (by category) |
| 14:37:59Z | Rev 10:37a | `by-method-category` · basic · revisions none | 29 |
| 14:40:16Z | Rev 10:40a (the revised print) | `by-method-category` · basic · **revisions: show · revisionId `16ebe6f9`** · revColumnTitle "9/18" | 29 |
| 14:41:49Z | Rev 10:41a (the "detailed by category" print) | `by-method-category` · detailed | 29 |

So the revised print compared a **by-method** current list against a **by-category** snapshot.

## §2 · Root cause, with measurements

**Mechanism.** `src/lib/print/revisionPairing.ts` (`pairRevision`, :214–272) matches old rows to current rows **inside a section key** (`computeSectionKey`, :82–87): by-method-category → `` `${methodName}|${header}` ``, by-category → `header`. Old sections are bucketed by the same key (`buildOldGroups`, :99–137). An old section whose key matches no current section becomes an **orphan section** (:254–269), which `PrintEquipmentListClient.tsx` (:879–927) appends after the last section sharing its `methodName` — for `(No Method)` that is the end of the document, under whatever list band is current (the Cable band on p.19). A by-method current section carries `methodName` = the method's **shop-order header** (`buildSections` → `groupKeyOf`, `printEngine.ts:952–955`: "Main List", "Production Only", …). A by-category snapshot carries no `methodName` at all (`revisionSnapshot.ts:143–147` writes `sec.methodName`, which the by-category branch of `buildSections` never sets, `printEngine.ts:1041`).

**Measured with the repo's own code** (the ten source files staged from `4fe0af9`, run under Node 22 type-stripping with a path-alias loader — no test runner, nothing written to the repo; data = JOY's live `v_equipment_list` 1,318 rows, `methods` 22 rows, snapshot `16ebe6f9` 17 sections / 299 rows / 1,112 items; search `method: rent` → 1,109 current items):

| Case | Current rows | "From" filled | Deletions in-section | Orphan sections (rows) |
|---|---|---|---|---|
| **As printed:** 10:34a snapshot, by-method print, `4fe0af9` | 305 | **0** | 0 | **17 (299)** |
| Same, at `7c96904` (pre-PAPERWORK-1) | 305 | **0** | 0 | **17 (299)** |
| Same snapshot, **by-category** print | 278 | 264 | 35 | 0 |
| Synthetic: today's list snapshotted **by method**, printed by category | 278 | 278 | 0 | 0 |
| Synthetic: today's list snapshotted **by category**, printed by method (identical data) | 305 | **0** | 0 | 17 (278) |

Section keys, first three — current: `Main List|1.0 Consoles`, `Main List|1.1 Processing`, `Main List|1.2 Personal Monitoring`; old: `(No Method)|1.0 Consoles`, `(No Method)|1.1 Processing`, `(No Method)|1.2 Personal Monitoring`. **0 of 17 old keys match any of 29 current keys.**

The printed artifact agrees: `pdftotext` of the v2 revised print shows the column header `9/18 Current` 74 times with the "9/18" column empty on pp.1–19 (every row bold on a green band = added), then sections `1.0 Consoles … 13.1 Tails` restarting mid-page 19 under the **Cable** band with every row struck through and the quantity in the "9/18" column (= orphan deletions), through p.34. 19 + 15 = 34 pages.

**Why it "worked 8/12" and on the 9/18 gate.** Same-sort comparisons pair correctly (rows 3–4 of the table). The 9/18 gate print (`parity-pairs/260918_paperwork-1_gate/joy revised.pdf`, "v1 | Current", Main List band, DiGiRack rows struck) was a by-method print against a by-method snapshot. Today is the first time this seat can find a by-category baseline compared in a by-method print. It is v1's normal workflow — v1 (FileMaker) keys the revision compare on model alone and ignores sort — and it is also how Zite, the port source, behaved: `docs/reference/zite-src/…/PrintEquipmentListPage.tsx:1082–1093` builds `oldQtyMap` by model **globally**, and :1227–1239 carries an explicit *"Cross-sort-mode fallback … handles the case where the snapshot was saved in by-category mode … but we're now viewing in by-method-category mode."* The Pass A port scoped the old quantity to the matched section (the module header calls this a declared PORT-MAP deviation "per Daniel's Pass A ruling" — ⚠ that ruling is **not quoted anywhere in the Ledger or Session Log archives**, so per the Prompt it is not treated here as his) and did not carry the fallback across. The scoping has a real reason (Zite double-counts a model that appears in two sections); the fallback's absence is the defect.

**Secondary finding — the seed that put the baseline in by-category mode.** `projects.print_list_settings` has a column DEFAULT (read live from `information_schema.columns`):
`{"sort": "by_category", "type": "detailed", "title": "Detailed List", "dateFormat": "M/D/YYYY h:mmp", "showRemaining": false, "showRevisions": false, "showCoverLetter": false, "showTableOfContents": false}`.
`PrintEquipmentListClient.tsx:1966–1973` spreads that over `DEFAULT_SETTINGS` with no normalisation. `'by_category'` matches neither radio (`:321–322`), so a new project's Print Options show **no sort selected**; `buildSections` treats any non-`by-method-category` value as by-category (`printEngine.ts:948`); `fmtDate` (`:785–796`) treats the unknown format as date-only. Corroboration: the 10:34a revision's stored settings are exactly the seed values, and the 9/18 gate print's footer reads `9/18/2026` with no time, while today's later prints (after the format was touched) read `9/19/2026 10:37a`. The cable print family already normalises this seed (`cablePrintSettings.ts:69`); the equipment print does not.

## §3 · Which commit introduced it

- `bb66bb3` — 2026-07-12 03:10Z — *"Revision-compare Pass A: snapshot writer emits per-item id (o-B …); pure revisionPairing …"*. First commit carrying `src/lib/print/revisionPairing.ts`; read from the git objects (loose + pack, no git run). **One blob version in the whole first-parent history (270 commits)** — the file has never changed since.
- **Not PAPERWORK-1.** `4fe0af9`'s FILES CHANGED (from-cc return, 22 files) does not include `revisionPairing.ts` or `revisionSnapshot.ts`; both are byte-identical between `7c96904` and `4fe0af9` (`cmp`). The pairing measurement is identical at both commits (§2 table). None of the five prime suspects in the opener (REV_CURRENT_COL_W, chipBorderBleed, DOTRULE, NAMEWRAP, compareDescriptions/REVGROUP-SPLIT) is involved; they are layout and sort, not pairing.
- The print-settings seed dates from the column's creation (`20260805175521 dev2_r2_project_sort_and_print_options_persistence`, Aug 5). Not measured further; it is a one-line normalisation either way.

## §4 · Rollback of `4fe0af9`?

**Not warranted, and it would not help.** The defect reproduces byte-for-byte at `7c96904`. A rollback would remove EQUIPLIST-DOTRULE, EQUIPLIST-NAMEWRAP, the widened Current column (your "Curren" clip), the colourless-chip row loss fix, SETTINGS-PAPERWORK-PREVIEW, Bundle Summary and Line List — all gated and passed on 2026-09-19 10:22 — and leave the revised print exactly as it is. Daniel's call; the trade-off is: rollback = every PAPERWORK-1 gain lost, zero change to the revised list. Interim: compare in the sort mode the revision was saved in (the 10:34a baseline pairs at 264/278 in a by-category print).

## §5 · Proposed fix — CC handoff DRAFT, ⚠ NOT ISSUED (the main line issues it)

```
# REVPAIR-CROSS-SORT: an old revision pairs in any print sort, and a new project's print settings are v2's

Tier: claude-opus-5
Model: claude-opus-5
Session: FRESH

*Arch, 2026-09-19. HEAD `4fe0af9` = `origin/main`. Migration ledger 79. No migration rides this unit.*

**⚠ Every answer you need is in this file. There is no blank for anyone to fill in.**

## §0 · HARD STOPS

1. **No migrations and no SQL writes.** The `projects.print_list_settings` column default stays as it is
   this unit; the app normalises what it reads. Changing the default is Arch's (Trigger B), later.
2. **The persisted snapshot shape does not change.** `revisionSnapshot.ts` writes exactly what it writes
   today (REVGROUP-SPLIT, Arch 2026-09-07: `buildRevisionSnapshot` writes persisted JSON; its shape is not
   a print unit's to change). The fix is READ-side, in the pairing.
3. **Test shows only** (JOY and the other `daniel+test01@` projects, or seeded throwaways). **Never Buena
   Vista Social Club.**
4. **Expected gate: 28/28, no baseline event.** Frame 07 is the DETAILED revision view against the
   fixture's "Baseline Rev" — a same-sort pair, which pairs today and must pair identically after. If a
   frame moves, stop.
5. Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the handoff file's RAW
   OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it.
   Show every line."*
6. GATE-NOGREP. Commit only on Daniel's `COMMIT APPROVED: <first words>`, after his gate.

## §1 · The defect, as measured (evidence: `parity-pairs/260919_revlist-regression/harness/`)

A revision saved from a BY-CATEGORY print has sections with no `methodName`. A BY-METHOD print keys
sections `${methodName}|${header}` (`revisionPairing.ts:82-87`), so 0 of 17 old sections match 29 current
ones: every current row prints as added, every old row (299) as an orphan deletion after the last list
(`PrintEquipmentListClient.tsx:879-927`). Measured on JOY `b04ab9b5`, snapshot `16ebe6f9`, search
`method: rent`, at both `7c96904` and `4fe0af9`: current rows 305, "From" filled 0, orphan sections 17.
The reverse direction (by-method snapshot, by-category print) already pairs: `computeSectionKey` drops the
method in by-category mode and `buildOldGroups` sums a model across its method groups.

Pedigree for the change: **(b) v1** — the revision compare keys on model regardless of the print's sort
(Daniel's v1 print `260919-1039_v1_revised-basic-by-method_JOY_FILEMAKER.pdf` pairs a by-category baseline
in a by-method list); **(b) Zite** `docs/reference/zite-src/src/pages/data/PrintEquipmentListPage.tsx:1227-1239`
("Cross-sort-mode fallback"). The section-scoped old quantity (no cross-section double count) is kept.

## §2 · CP1: re-bucket the old revision into the print's sections before pairing

In `src/lib/print/revisionPairing.ts` (or a sibling pure module it imports — your structure), add a pure
step that runs on the old sections BEFORE `buildOldGroups`, given the print's `sort` and `methodsList`:

- `sort === 'by-category'` → no change (today's behaviour is already correct there; prove it, do not touch it).
- `sort === 'by-method-category'` and every old section carries a `methodName` → no change.
- `sort === 'by-method-category'` and an old section has no `methodName` → for each of its rows that has an
  item breakdown, split the row's items by the method GROUP of each item's own `method`, using the SAME
  rule the current side uses (`buildSections`' `groupKeyOf`, `printEngine.ts:952-955`: the method's
  `shopOrderHeader`, trimmed, else the method name), and emit one old section per `${group}|${header}` with
  `quantity` and `remainingQuantity` re-summed from the items it keeps. Color: the group's method colour
  from `methodsList`, else the snapshot's `methodColorName`. A row with NO item breakdown (legacy, o-B)
  keeps today's path: it stays under `(No Method)|${header}` and orphans as it does now — do not guess a
  group for it.
- A method name the current `methodsList` no longer knows falls back to the raw name as its group, exactly
  as `groupKeyOf` does — it will orphan under that name. Report how many old items hit this on JOY.

Wire it at the one call site: `PrintEquipmentListClient.tsx:820-823` (`paired` memo), after
`filterOldRevisionRows` and before `pairRevision`. `pairRevision`'s signature may grow a `methodsList`
parameter or the client may call the new step first — your call; every existing test of `pairRevision`
must pass unchanged.

**Success condition, measured on JOY `b04ab9b5` against revision `16ebe6f9` with search `method: rent`
(a harness like `parity-pairs/260919_revlist-regression/harness/run2.ts`, or a test with that data):**
current rows 305, "From" filled **291**, deletions in-section **35**, orphan sections **0**; and the set of
deleted `(header|model)` pairs is IDENTICAL to what the same snapshot yields in a by-category print (35).
Then the browser gate: Print → Show Revisions → `Rev 9/19/2026 10:34a` → by method, search `rent`:
**19 pages**, DiGiRack ×5 / SD10 GPI / SD10 GPO / SD10T / Galileo 616 struck through inside 1.0 Consoles
and 1.1 Processing, HMA 10m reads `1 → 2`, no sections after 13.1 Tails.

Tests (REPORTED where v1 evidence is silent): the three branches above; the legacy no-items row; the
double-count guard (a model present in two method groups in the OLD revision gets each group's own
quantity, and their sum in a by-category print); the reverse direction unchanged.

## §3 · CP2: a new project's print settings are v2's from the first open

`PrintEquipmentListClient.tsx:1966-1973` spreads `projects.print_list_settings` over `DEFAULT_SETTINGS`
with no check. The column's DEFAULT (live) is Zite-shaped: `sort: "by_category"`, `dateFormat:
"M/D/YYYY h:mmp"`, `title: "Detailed List"`, `show*` keys. Result on a fresh project: no sort radio
selected (`:321-322`), the footer date prints without a time (`fmtDate`'s fall-through, `:796`), and the
first revision the user saves is a by-category one whatever they think they chose.

Normalise on read, in one pure function with a test: an unknown `sort` → `DEFAULT_SETTINGS.sort`; an
unknown `dateFormat` → `DEFAULT_SETTINGS.dateFormat` (the cable family already does this —
`cablePrintSettings.ts:69`, `readPrintDateFormat`; reuse it rather than write a second copy); `type`,
`title` and the booleans pass through when their type is right; unknown keys are ignored. Do not write the
normalised settings back until the user changes something (the existing debounced save, `:1982-1993`, does
that already).

Gate: a new throwaway project's Print Options open with **By Category** selected and the preview footer
carrying the time. Delete the throwaway (census 0 by name, 0 by id).

## §4 · Not this unit

- The persisted `print_list_settings` DEFAULT itself (Arch, Trigger B).
- Orphan sections' placement and band when a WHOLE method group has gone (they still append at the end
  under the last band) — report what you see on JOY after CP1; if it is 0 orphans, nothing to see.
- Struck-through notes on deleted rows (v1 strikes them, v2 does not) — parity list item, separate.

## RETURN
`from-cc/<stamp>_revpair-cross-sort.md`: DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT, with the
§2 success-condition numbers and the §3 gate screenshot named. Then wait for Daniel's browser gate.
```

**[CRITIQUE]** Re-bucketing by per-item method assumes the old items' method names still map to today's groups; a method renamed since the revision was saved orphans under its old name, which is honest but ugly. The alternative — writing `methodName` per item group into every snapshot — changes a persisted shape for a read-side problem and does nothing for the revisions already saved.
**[BLAST RADIUS]** One pure step before `pairRevision`, a no-op for every same-sort comparison (frame 07 guards the detailed one); CP2 only changes what a fresh project's Print Options open with.

## §6 · v1 ↔ v2 paperwork parity — for Daniel's approve / don't-approve

Method: `pdftotext -layout` diffs of the two by-method pairs; page-1 and page-10/16 renders of every pair; `pdfplumber` font/position measurements on page 1. Rulings looked up in the Ledger (`Minotaur_v2_Ledger_v1_0.md`) by ID and keyword; anything I could not find a ruling for is in list A. The detailed pair is **not sort-matched** (v1 by category, v2 by method — the revision row saved with the v2 print says so), so its list covers layout only, not order or per-list quantities.

### A · Differences with no ruling found — approve or not

1. **The revised list itself** — a by-category revision compared in a by-method print pairs nothing (§2). v1 pairs by model in any sort. *Proposed fix above.*
2. **Deleted rows' notes are not struck through in v2.** v1 strikes the model AND its sub-notes (`spare`, `One HMA Loop`, `Waves Card`, …, v1 revised p.1); the v2 gate print (`260918_paperwork-1_gate/joy revised.pdf` p.1) and today's orphan pages (p.19) strike the model only.
3. **Detailed list: the method chip truncates.** v2 prints the method at 8.5 pt on ONE line with an ellipsis — every chip on JOY reads `Rent-Main-…`, so `Rent-Main-Masque`, `-PRG`, `-PRG-SAI`, `-PRG-SAI-54`, `-SAI` are indistinguishable. v1 prints 8.0 pt and wraps to two lines (`Rent-Main-Masque- / PRG-SAI`), chip x0 327 vs v2 376.5.
4. **Detailed list: model-line quantities are italic in v2, roman in v1.** Measured p.1: v1 model-line qty `CenturyGothic` 12.0 (9 chars); v2 `CenturyGothic-Italic` 12.0 (12 chars). QTY-ITALIC was ruled and built from the *basic* arbiter ("universal — 2,045 italic characters"); on v1's *detailed* layout the model-line quantity is roman. Sub-row quantities are 10 pt roman in both.
5. **Detailed list: sub-note and sub-item indents.** v1 indents a model's sub-note 9 pt in from the model (`on reel` x0 40.0 vs model 31.0) and the sub-item name 18 pt (`FOH` 49.0); v2 prints the sub-note flush with the model (33.0 / 33.0) and the sub-item at 39.0. (The basic list's indent ladder was fixed under EQUIP-LIST-PARITY; the detailed layout was not in that scope.)
6. **Detailed list: no `Qty` column title.** v1 prints `Qty` bold at the right of every category heading (x0 563.4); v2 prints none.
7. **Footer page number: `Page 1 of 19` (v2) vs `1 of 19` (v1)**, both 10 pt. No ruling found.
8. **Racks and Boxes prints boxes by NAME in v2, by TYPE in v1.** v1 p.10: `10 Masque Double Diamond`, `10 Masque Grey`, `2 Stage 3 Workbox`, and one nameless `1`; v2 p.10: 23 rows at qty 1 — `Ampland`, `Band Signal`, … `Work Box`. Same 23 boxes, different projection. Ordering from this list, the shop needs the type and count. No ruling found (the box family's print rulings are about box documents, not the equipment list).
9. **A cable with no model prints `16 (Unknown)`** in v2 (Cable, p.15) where v1 prints a bare `16` (p.15). EP-P1 registered "(Unknown)" as the blank-model rendering it was replacing for composed cables; this row is a cable that has no model at all. Either strip it (match v1) or leave it as a data flag — your call.
10. **Long sub-notes wrap one word later in v2** (`…DPA 4091, Earthworks M23` on one line; v1 breaks before `M23`; the Dell monitor note likewise). The note column is a few points wider. Cosmetic; changes line counts, hence pagination, on note-heavy shows.
11. **Model column starts 3.24 pt further left in the basic list** (v1 model x0 59.98, v2 56.74; sub-note 69.0 vs 70.02). Within the measured die's tolerance? Not ruled that I can find; listing it because 2–4 reads it.
12. **Fresh project print settings** (§2, secondary) — no sort radio selected, footer date without time, first print is a by-category "Detailed List". *CP2 of the draft.*

### B · Differences already ruled — noticed, ignored

- **Solid grey row rule** in place of v1's dotted one — EQUIPLIST-DOTRULE (Daniel, 2026-09-13; built PAPERWORK-1).
- **Continued category on its own line at full heading size** (`1.2 Personal Monitoring (continued)`), the list band repeated without the small category label v1 puts inside it — CONTCAT-DIVERGE (Daniel, 2026-09-05) and CONTCAT-SIZE (Daniel, 2026-09-07).
- **Numeric-aware model order** — `6-Pair` before `12-Pair`/`19-Pair`; `RG6` < `RG59` < `RG213`; the 6-Pair tails first — S-4 / `compareModels` (sort unit, July; Ledger S-1..S-4).
- **Cable rows composed as `[Model], [Length]'`** (so v1's data typo `6-Pair, 150ft'` prints as `6-Pair, 150'`) — EP-P1 (Daniel, Aug 3–4).
- **Quantities italic on the basic list** — QTY-ITALIC, built under EQUIP-LIST-PARITY (measured on the basic arbiter; see A-4 for the detailed layout).
- **Basic-list indent ladder, type scale, heading rule weight, page header block** — EQUIP-LIST-PARITY (closed; Ledger "all three named things plus four more").
- **Current column 61 px** — PAPERWORK-1, "sized to its title" (the gate print's `Curren` clip).
- **Revision print keeps model-only grouping** — REVGROUP-SPLIT (Arch, 2026-09-07).
- **Category note flush under the heading rule** — CAT-NOTE / CATNOTE-TYPE (2.00 pt indent), unchanged here.
- **Page count and row pitch** — both basic prints 19 pp; PAPERWORK-1 measured row pitch 27 px ×109 unchanged. v2 fits one more row on p.1 (PreSonus HP4) and carries `6 ClearSonic` onto p.10 where v1 starts p.10 at 11.0; page counts match (19/19). Cause not measured here; PAPERWORK-1 measured the row pitch unchanged, so this is the page budget, which EQUIP-LIST-PARITY and NAMEWRAP already own.

### C · Not deviations — data, or the operator's own settings

- Titles `Basic Equipment by Method` / `Revised Basic by Method` and column title `From 9/18` vs `9/18` are typed by the operator (`settings.title`, `settings.revColumnTitle`), not layout.
- `Roland OCTA-CAPTURE` (Quiet Time Only) is on v2's current list and not on v1's; v1's own revised print shows it as deleted. Data, edited after the import.
- v1's nameless `1` under Racks and Boxes is a box with no type in v1's data.
- The v2 "detailed by category" print was sorted by method; `DiGiCo HMA Cable, 150m` reads 2 there (the Production Only pair lives in its own list) against v1's 4. Sort, not layout.

## §7 · Evidence index

- `~/Minotaur_v1_exports/parity-pairs/260919_revlist-regression/` — the six prints, convention-named (§1 table).
- `…/harness/` — `equip.json` (JOY `v_equipment_list`, 1,318 rows, 8 columns), `snapshot_sections.json` (revision `16ebe6f9`, notes stripped), `methods.json`, `run.ts` (both commits, both sorts), `run2.ts` (both directions + the re-bucketing prototype), `loader.mjs` (the `@/` alias loader), `harness_output.txt` (every number in §2 and §5, verbatim).
- The 9/18 gate revised print: `parity-pairs/260918_paperwork-1_gate/joy revised.pdf` (a working same-sort pair; `Curren` clip; footer without time).
- Source at both commits was read from `.git/objects` (loose objects and the pack, with delta resolution) by a Python reader; `cmp` against the working tree confirmed `4fe0af9` = working copy for the three files that matter.
- from-cc: `260918-1748_paperwork-1.md` (FILES CHANGED, 22 files; OPEN QUESTIONS 1–13) and `260919-1022_paperwork-1_CLOSE.txt` (gate passed 10:22; migrations 78 at close, 79 now).

*End of parallel return. The main line closes.*
