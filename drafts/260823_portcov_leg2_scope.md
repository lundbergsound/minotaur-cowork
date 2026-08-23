# PORT-COV LEG 2 — THE CABLE SIDE · SCOPE

**Written 2026-08-23 0300 UTC, Cowork-Arch main line, off `handoffs/260822-2355_next_session_opener.md`. Governing set: Arch v31 · Roadmap v4.4 · Session Log at 3 entries. Repo state at scoping: `Minotaur` HEAD = origin = `41d1002`; migration ledger 52.**

**Status: SCOPE, not a handoff. All six rulings taken 2026-08-23 (§7) — R-3 and R-4 are Daniel's, both amended after their first reading, the other four his approval of the recommendation. One item flagged back to him inside R-3 (orphaned tails). Nothing here has been built. Next artifact is the 2-EXP handoff.**

---

## 0 · What this is, in plain language

Leg 1 taught v2 how to read and write v1's box sheets. Leg 2 does the same for the cable side — eight spreadsheets covering cables, the lines inside a mult, tails, bundles, the two per-model definition tables, and two "clone links" sheets that turn out not to contain data at all.

Everything below was **measured** this session: all 24 files (eight sheets × three real shows), the live database, and the RPC body. Where a number contradicts something the record already says, the contradiction is called out rather than smoothed over.

**The headline: the cable side is bigger than both box legs put together and cannot be one unit.** `cable.xlsx` alone carries 97 columns against `equip.xlsx`'s 53 and `boxes.xlsx`'s 36; the eight sheets carry 281 columns and 5,332 rows across the three corpora.

---

## 1 · The corpus, measured

Row counts, all three corpora, full population — no sampling:

| Sheet | BVSC NY | BVSC | JOY | Columns | Dead in all 3 |
|---|---:|---:|---:|---:|---:|
| `cable.xlsx` | 1,119 | 249 | 461 | 97 | 10 |
| `lines.xlsx` | 552 | 161 | 648 | 31 | 3 |
| `tails.xlsx` | 190 | 62 | 175 | 34 | 5 |
| `bundles.xlsx` | 71 | 45 | 26 | 29 | 5 |
| `def ends.xlsx` | 50 | 56 | 48 | 12 | 1 |
| `def tails.xlsx` | 12 | 20 | 12 | 9 | 2 |
| `cable clone links.xlsx` | 596 | 126 | 610 | 51 | 2 |
| `bundle clone links.xlsx` | 6 | 23 | 14 | 18 | 0 |
| **Total** | **2,596** | **742** | **1,994** | **281** | **28** |

**The header row is byte-identical across all three corpora for all eight sheets** — same strings, same capitalisation, same order, same count. The export field orders can be pinned from the corpus and cross-checked against script 566, exactly as leg 1 pinned `boxes.xlsx` at 36 columns.

**BVSC is structurally the thinnest corpus.** Beyond the 28 corpus-wide dead columns it carries ~40 more at zero population that hold data in BVSC NY or JOY — the whole Box, Connection, Device and Flagged-End families. **Scoping on BVSC alone would miss them.** BVSC NY is the arbiter, as it was for boxes.

---

## 2 · Two claims struck by re-measurement

Both were in the first measurement pass and both are **wrong**. They are recorded because the mistake is instructive, not to pad the document.

**(a) "`cable.Box` dangles 689 times." Struck.** `Cable::Box` is a calculated field — `If ( Bundle ≠ "" ; Bundle List::Box ; Box Manually Added )` — and resolves against the **box list**, not against `bundles`. Re-measured against `boxes.xlsx`'s `Box Name`: **every box reference in both corpora that has a box list resolves. Zero dangles.** 562 of the BVSC NY values are the literal `'0'`, which is BOX-NOBOX's already-ruled no-box marker, and 138 more sit on `tails.Box`. BVSC has no `boxes.xlsx` and needs none — its three `Box` columns are 0-populated.

**(b) "`Box Number Name` dangles 1,224 times between `cable` and `bundles`." Struck.** It is not a reference. On `cable` the value is exactly `<Box Number> & " " & <Box>` — **1,051 of 1,051 and 173 of 173, zero exceptions**. On `bundles` it is the box's number with the trailing digit of the box's name appended — **70 of 70 and 25 of 25, zero exceptions** (`'Ceiling Runs 1'` / 202 → `2021`; `'Backstage Runs'` / 210 → `210`). Two different renderings of two different things, neither carrying information absent from `Box Number` + `Box`.

**The lesson is the Surface Rule aimed at data:** a join measured between two columns that share a header is not evidence that the source system makes that join. Both figures would have reached CC as scary numbers demanding a fix that had nothing to fix.

---

## 3 · What actually threatens a cable import

Ranked by measured blast radius.

**3.1 — Non-UUID HistoryIDs: 13 rows, and they are the same four values propagating.** `cable.HistoryID` carries 7 FileMaker timestamps in BVSC NY and 2 in BVSC; `tails.HistoryID` 2; `cable clone links.historyID` 2 + 2 — **and the clone-link values are the same literal timestamps as the cable ones**, so the corruption is inherited, not independent. Verbatim: `'10/24/2024 11:08:42.548455 AM'`, `'12/26/2024 9:52:04.205908 AM'`, `'7/6/2026 5:41:04.156167 PM'`. This is HISTID-UUID on two more sheets, and `import_apply_v1` casts `(r->>'v1_history_id')::uuid` at two sites — the abort is total, the transaction rolls back everything.

Also measured: **every well-formed HistoryID in the cable corpus is UPPERCASE** — 1,112 / 247 / 461 on `cable`, 100% on `lines`, `bundles` and both clone sheets, zero lowercase, zero mixed. `isUuidShape` is already case-insensitive, so this costs nothing; it is recorded because an Arch handoff asserted "case-insensitive, because v1 emits uppercase" last session and CC had to count it.

**Two structural facts about the existing guard:** `resolveHistoryId` is **module-private** in `map.ts` and its `sheet` parameter is typed `SheetName`, the closed six-member union. It cannot be called for a cable sheet until both are widened. `isUuidShape` is exported and needs nothing.

**3.2 — `History Entry ID` is not an identifier.** 100% non-UUID in all three corpora (1,084 / 249 / 459 values), all FileMaker decimal seconds (`'63869347862.370186'`), and **not unique** — 279 distinct across 1,084 values in BVSC NY. Despite the name it is a timestamp. It must never be mapped to an id column.

**3.3 — Cable-name collisions, and the blast radius is far smaller than the duplicate count.** `cable.Name` duplicates: 108 values / 159 excess rows (BVSC NY), 10 / 10 (BVSC), 40 / 61 + 29 blanks (JOY). v1 attaches lines and tails to a cable **by that name** (`Mult Lines::MULT = Cable::Name`, rel 28; `Mult Tail List::Mult = Cable::Name`, rel 113).

But measured against the children, the ambiguity almost never materialises:

| Corpus | lines matching >1 cable | tails matching >1 cable | lines matching 0 | tails matching 0 |
|---|---:|---:|---:|---:|
| BVSC NY | **6** of 552 | **2** of 190 | 0 | 0 |
| BVSC | **16** of 161 | **8** of 62 | 0 | 0 |
| JOY | **31** of 648 | **6** of 175 | **12** | **5** |

**Only 7 distinct names in the entire corpus produce any ambiguity, and every one has exactly two candidate cables — no group of three.** In all 7 the two cables share a `Model` and differ only in `Bundle`: `'uSM DESK'` (both `6-Pair`, bundles `SM Desk 1` / `SM Desk SL 1`), `'spElec 3'`, `'cTech Com Ext.'` (JOY's worst, 19 lines over 2 candidates), and four more. **53 child rows corpus-wide are ambiguous and 17 are orphaned** — and nothing in a line or tail row can break the tie, because `lines.sourceID` and `lines.destinationID`, the only real FK columns v1 has, are **0-populated in all three corpora**. The DDR says the same at source: *"`sourceID`/`destinationID` (23/24, Number) exist and no relationship joins on them."* Ruling owed — §7 R-3.

**No v2 constraint fires here.** There is no unique index on `cable_details(project_id, cable_name)` — confirmed against `pg_constraint` and `pg_indexes`. v2 already permits what v1 has.

**The 17 orphans are real, and normalisation does not rescue them.** Re-measured at four levels — exact, trimmed, trimmed + case-folded, and internal-whitespace-collapsed — the count stays **12 lines + 5 tails in JOY and 0 in both other corpora at every level**. JOY's 40 whitespace-padded cable names are a genuine hygiene problem and are **disjoint** from these three orphan names. Two look-alikes exist (`'Cat SL Sub 3'` ↔ `'SL Cat Sub 3'`, a pure word transposition; `'cALD #1'` ↔ `'cALD 1'`, one character) and **both candidates already carry their own complete source+destination tail pair**, so re-pointing would give them three and four tails against the one-source-one-destination pattern that holds for all 87 other JOY mults. They are look-alikes, not recoverable references. `'cPreview'` has no candidate at any distance — zero JOY cable names contain "Preview" in any casing.

**The orphans are fully-specified cables whose parent row was never created, not corrupt data.** The 12 `cPreview` lines are a clean 12-line run (`Line` 1–12, all `Panel SD-6` → `Tech Rack`, real descriptions) matching its two `12-Pair` tails. **Each orphan's model is inferable from its own tails** — `cPreview` = `12-Pair`, `Cat SL Sub 3` = `Combo`, `cALD #1` = `6-Pair` — so a synthesized parent is derived from evidence rather than invented. Ruled — §7 R-3.

**3.4 — Length is text, and one column already holds the answer.** `cable.Length` is stored as text in all three corpora. Non-integer values, complete: `'150m'` ×2 and `'x'` ×2 (BVSC NY), `'150ft'` ×1 (JOY), none in BVSC. A parser reading "integer + optional ft/m" fails on exactly **2 rows corpus-wide**, both `'x'` (cables `TC6K Net` and `TF Rack Net`).

**`Length for Summary` is a complete, already-parsed numeric-feet column with zero text contamination in any corpus.** v1 converts `150m` → `492.126` (150 × 3.28084, exact) and `'x'` → `0`. But taking it would **destroy the metre unit on the two rows that have one**, and that is a print-parity loss: v1 prints `150m` on a physical label. Ruled — §7 R-4: parse the text, keep the unit.

**v2 already models the mixed-unit case, and it is built and tested.** Read at source rather than assumed:

- `projects.units` is `'imperial' | 'metric'`, NOT NULL, and `defaultLengthUnit()` (`cableLength.ts:17`) maps it to the project's default.
- `cable_details.length_unit` is **per cable**, `CHECK ('ft','m')` — so *a 150m cable inside an imperial show* is not an edge case, it is the modelled case: project units imperial, that one cable's unit `'m'`.
- `formatCableLength()` (`cableLength.ts:26`) renders **v1's suffix convention verbatim** — feet → `50'`, metres → `15m` — and `printProjection.ts:67-83` reproduces v1's `Model & ", " & Length with Unit` composition. Labels print identically **because the renderer already does this**, not because the storage is text.
- Sorting and every rollup already normalise: `cableSortChains.ts:118` converts `'m'` → feet at ×3.28084 before comparing, and `bundleList.ts:103` / `bundleBands.ts:200` route through the same `toFeet()` for bundle volume and the green/warn/over area thresholds (R-10).

Live, the unit column is clean: **860 `ft` and 751 null on `cable_details`, and the 751 nulls are exactly the 751 null lengths** — unit is null if and only if value is null. No `'m'` row exists yet.

**One real defect, and it is at the input layer.** `parseLengthInput()` (`cableLength.ts:49`) strips a typed `m`/`'` suffix and **discards it** — the comment says so deliberately: *"the unit is unit-column-owned, not retyped per edit."* So an operator on an imperial show who types `150m` into a Length cell today gets **150 feet, silently**, which is the exact scenario this leg has to support. Registered as **LEN-INPUT-SUFFIX**; the fix is at the commit path, not in the schema.

One more artefact, already known in shape: `Length with Unit` appends `'` unconditionally, so **625 BVSC NY and 23 JOY rows render as a bare apostrophe** and one JOY row as `150ft'`. That column is 100% populated, so a null check never catches it. It is a rendered display string and should not be imported.

**3.5 — Models used but never defined.** `def tails.Cable Model` is a **strict subset** of `def ends.Cable Model` in all three corpora — zero rows need a `cable_types` row `def ends` never described, so the merged table is exactly the `def ends` count (50 / 56 / 48). But the data sheets reach past both: **`cable.Model` names 13 distinct models absent from `def ends` (40 rows, BVSC NY only)** and **`tails.Model` names 17 distinct absent from `def tails` (39 rows), 8 in JOY, 2 in BVSC**. This is BOX-TYPE-LIB on the cable side, one lap larger. Ruling owed — §7 R-5 — though the precedent points one way.

**3.6 — What does NOT threaten it.** `bundles.Bundle Name` is clean — 0 duplicates, case-sensitive and case-insensitive, in all three corpora. `def ends.Cable Model` and `def tails.Cable Model` likewise. Those are the only two cable-side tables carrying a unique constraint (`bundles_project_id_bundle_name_key`, `cable_types_project_id_model_name_key`), so **the METHOD-DUP class does not repeat here** — the dedupe those two mappers need is a **guard** in the CAT-DUP sense, not a fix. `cable_details`, `cable_mult_lines`, `tail_details` and `link_groups` have no unique constraint at all.

---

## 4 · The clone-link sheets, and why they are not what they look like

Neither sheet contains data. Per the DDR and the D-2b recon, every `Link <Field>` column is a Number whose auto-enter is **`Get(CurrentTimestamp) + Random`** — minted once per row and then **copied verbatim onto every clone**. Rows sharing a value are a link group for that one field. *"Cloning is sharing a link-group ID, never copying rows."* There is no group table in v1; the shared value **is** the group.

This is why the first pass measured all 25 `Link *` columns dangling 100% against every candidate parent: **they were never foreign keys.** Daniel blessed **recompute** as a third import class on Aug 14 precisely for these sheets. v2 already implements the target model — `link_groups (entity_type, field_name)` + `link_group_members`, with a CHECK domain of exactly `cable | bundle | mult_line`, and JOY carries 54 live groups across **19 distinct `field_name` values**, matching the 19 tokens `linkFields.ts` declares.

**The recompute check, measured per column, all three corpora.** For each `Link X`, count the rows in a group of size ≥2 and compare against the rows where v1's companion `X Has Clones` flag is 1:

| Sheet | Columns | Agree exactly |
|---|---|---|
| `cable clone links` (BVSC NY) | 23 flagged of 25 | **19** |
| `cable clone links` (BVSC) | 23 | **21** |
| `cable clone links` (JOY) | 23 | **17** |
| `bundle clone links` (all three) | 8 | **4** |

The disagreements are two distinct mechanisms, and one of them is already ruled:

- **`Link Line` and `Link Mult` cross in both directions** (BVSC NY: 192 rows grouped-but-unflagged *and* 53 flagged-but-ungrouped, simultaneously). The mechanism is in the DDR: those two flags are summed through **`Cable Clone Links to Mult Lines` (rel 261, `historyID = Mult Lines::historyID`)** — a different relationship context over the mult-line population, while the exported sheet has one row per cable. **They are also already out of scope**: `linkFields.ts` excludes them from the cable vocabulary by ruling, assigning them to `entity_type = 'mult_line'` and the mult/line unit. No action; the crossing is explained.
- **Source/Destination Device and Connection (4 columns), plus the four Flagged-End/Colour columns on bundles, over-assert.** The recomputed group set is a **strict subset** of the flagged set in every case — recompute never invents a link, it only misses ones v1's flag claims. Direction verified per column: 0 grouped-but-unflagged, 97–145 flagged-but-ungrouped in BVSC NY. **The mechanism is not established.** The plausible reading is that those flags are computed through the two-predicate patch relationships (rels 300/301) rather than the plain self-join, which would make them patch indicators rather than link-group indicators — **a hypothesis, unproven, and it must not enter a handoff as a fact.** Ruling owed — §7 R-2.

`Link Bundle` forms **zero groups** in all three corpora (596/596, 126/126, 610/610 distinct) and `Bundle Has Clones` is a constant 0 — bundle-field linking exists in the schema and was never used.

**A live consequence worth registering.** `link_group_members.item_id` has **no foreign key at all**, and live it is **100% orphaned**: 210 members across 54 groups, of which **0** resolve against `equipment_items`, `cable_details`, `cable_mult_lines` or `bundles` — verified by direct query, not inferred. This is known and defended at read time (`CableListClient.tsx:685-688` filters memberships to live cable ids so a phantom cannot inflate a group past the ≥2 lockstep threshold). But it means **a mirror re-import that deletes and re-inserts cables orphans every membership permanently**, with nothing to clean them up. Registered as **LINK-ORPHAN**.

---

## 5 · The v2 side, measured

**5.1 — There is no cable import path and no cable export path.** `import_apply_v1`'s body contains the substring `cable` **zero times** (measured on the live definition, not grepped from a file). `runExport` emits exactly six files and reads the spine as `.eq('type','generic')`, so the 1,611 cable and 369 tail spine rows are excluded by construction. All seven cable sheets plus both `def` sheets sit in `REGISTER_NOT_IMPORTED` — counted, never parsed.

**5.2 — Nothing would abort if a cable sheet were fed to today's RPC. It would silently drop.** The function dereferences only hard-coded `ops.<known-table>` paths; an `ops.cable_details` key is never read. **This is the exact condition leg 1b raised a hard stop over** — a dry-run promising "will import 1,119 cables" while apply writes none. The guard test that made "mapped without an RPC arm" a red build **retired at `4c234dd`**; `spec.test.ts` now asserts only column accounting and mentions neither `REGISTER_NOT_IMPORTED` nor any cable sheet. **Nothing in the suite would go red today.** That guard has to come back before any cable sheet leaves the register list.

**5.3 — The delete universe and the fingerprint are already separated, and the mechanism holds.** `MIRROR_SCOPED_TYPE = 'generic'` governs the row set; `mirrorFingerprintCount(allTypesRowCount)` returns the count unchanged. Leg 2 widens the first to include `'cable'` and `'tail'` and **must not touch the second** — that separation is what IMP-SPINE and MIRROR-SYSMETHOD cost two sessions to establish. `RawSpineRow.type` already fails closed: a row whose type cannot be read is never a delete candidate.

**Four tables need a new fingerprint key** — `cable_types`, `bundles`, `cable_mult_lines`, `link_groups` — and each follows `box_types`' conditional pattern (`if p_plan#>>'{fingerprint,X}' is not null`), so an old plan skips rather than aborts. Cables and tails need none: they are spine rows and the all-types `equipment_items` count already covers them.

**5.4 — The mirror's delete path, checked per table, as the opener requires.** No cable table carries a seeded system row. Measured two ways: `seed_project_na_rows` inserts into **`methods` and nothing else** (read at source — the function body is a single insert), and **`is_system` exists on exactly one table in the entire database, `methods`.** **MIRROR-SYSMETHOD does not repeat here, and the reason is stronger than "no guard" — there is no system row to protect.** The real delete hazard is different and it is `cable_details`' FK graph — the spine delete CASCADEs `cable_details`, `tail_details` and `cable_mult_lines` and SET NULLs `bundles.box_id`, six `cable_details` reference columns and both patch-line columns, none of which the pre-apply snapshot covers (it is `buildRevisionSnapshot` over `v_equipment_list`, a printed-list artefact, not a backup of the spine).

**5.5 — The scale defect is live in cable data, and it is NOT the box case.** `cable_details.length_value` is bare `numeric`: **853 rows at scale 1, 7 at scale 0**; `bundles.length_value` **97 at scale 1, 2 at scale 0**. Same magnitudes stored two ways. Unlike `box_number` this column stays numeric — PostgREST serialises numeric as a JSON number, so the mixed scale is invisible today. **That last sentence is carried from the Aug-21 box measurement, not re-measured here, and CC re-verifies it at build before anything depends on it.** No migration is proposed; the importer writes a normalised scale and the caution is registered as **LEN-SCALE**.

**5.6 — RLS: exactly seven owner-only tables, and `import_apply_v1` is SECURITY INVOKER** (`prosecdef = false`, verified). `bundles`, `cable_details`, `cable_mult_lines`, `cable_types`, `link_groups`, `link_group_members`, `tail_details` each carry one `FOR ALL` policy keyed on `projects.owner_id = auth.uid()`, with no `project_members` arm and no separate read policy. **This blocks nothing today** — only owners import — but it means a cable arm written now works for owners only, silently, and SHARE's REV-B sweep and leg 2 must not be built in ignorance of each other. Not a dependency; a sequencing note.

**5.7 — What already exists to build on.** 30 cable-related test files outside the import/export tree (`src/lib/cable/` 19, `src/lib/tail/` 5, `src/lib/print/` 4, plus two more), including `linkMembership`, `linkEnroll`, `linkFields` and `cableLength` — the link-group model and the length pair are already implemented and tested on the app side. **Zero cable test files exist under `src/lib/import/` or `src/lib/export/`.**

---

## 6 · Proposed decomposition

Leg 1's shape — export half, then the migration, then the import half — holds, but the cable side needs the import half split three ways. Five units:

| Unit | Scope | Migration? | Notes |
|---|---|---|---|
| **2-EXP** | All 8 sheets, export only. Pin the field orders against the corpus and script 566; widen `SheetName`; omit empty classes | no | `Record<SheetName,…>` in `fieldOrder.ts` is total, so widening the union fails the build until every order is written — the coupling works for us |
| **2-MIG** | The RPC's cable arms + 4 conditional fingerprint keys. Carries **MIRROR-SYSMETHOD (b)**, **DIV-AMBIG-CLEAR** and, if ruled, **BOX-NOBOX** | **yes**, ledger 52 → 53 | Trigger B; rehearsal-first per the ARCH-MIG-BOX pattern |
| **2-IMP-a** | `def ends` + `def tails` → `cable_types`; `bundles.xlsx` → `bundles` | no | Both have unique constraints and clean keys; `mapMethods` idiom, as guards |
| **2-IMP-b** | `cable.xlsx` + `lines.xlsx` + `tails.xlsx` → spine + `cable_details` + `cable_mult_lines` + `tail_details` | no | The big one. 162 columns. Widens `MIRROR_SCOPED_TYPE`; carries R-3's synthesized parents and the **LEN-INPUT-SUFFIX** fix |
| **2-IMP-c** | Both clone-link sheets → `link_groups` + `link_group_members`, by recompute | no | Depends on R-2 |

**Restore the retired guard test in 2-EXP**, not later: a failing test that stops any cable sheet leaving `REGISTER_NOT_IMPORTED` before its RPC arm exists. CC wrote that mechanism unprompted at leg 1 and it retired at `4c234dd`; leg 2 re-earns it.

---

## 7 · Rulings — all six taken, 2026-08-23

**R-1 · Decomposition. RULED: five units as §6.** 2-EXP first — mechanical, no migration, and pinning the field orders is what makes every later unit checkable.

**R-2 · Clone-link recompute. RULED: recompute only.** Groups are derived from shared `Link X` values, which never invents a link. One variance entry per row where v1's flag asserts a link the values do not carry (Source/Destination Device and Connection on cables; the four Flagged-End/Colour columns on bundles). **The patch-relationship hypothesis stays an OPEN QUESTION and must not enter a handoff as a fact.** The rejected alternative — trusting the flag and minting singleton groups to match it — would have fabricated 484 memberships in BVSC NY alone on unproven grounds.

**R-3 · Line and tail parentage. RULED (Daniel), amended: first-wins for which parent to link to; orphaned lines are NOT imported, and a dialog tells the operator so before the apply.** Nothing is synthesized — the earlier reading of "all lines get imported" is withdrawn.

- **Ambiguity** — the 53 child rows matching two cables attach to the first match in source row order, mirroring `mapMethods`, with a variance entry naming both candidates.
- **Orphaned lines are dropped, and the schema is why there is no third option.** `cable_mult_lines.cable_id` is **NOT NULL** with an FK to the spine (verified live), so a line with no parent cannot exist in v2 at all.
- **The dialog is the ruling, not a nicety.** It fires at dry-run review, **before** the apply — after the apply it is too late to fix the data in v1. It names the count and the offending cable names (JOY: 12 lines under `cPreview`). **A variance entry alone would not discharge this:** BVSC NY's variance report already runs to **314 entries**, so one more row in it is invisible. Blocking confirm, Continue / Cancel.
- **Orphaned tails are a different case and DO import.** `tail_details.parent_cable_id` **is nullable**, and an unparented tail is not a ghost row — `TailListClient.tsx:170` renders a null parent as a blank Mult cell, and the Mult cell is an editable re-parent pop-up (R-15). So the 5 orphan tails import with a blank Mult, visible and fixable in the app, and are named in the same dialog under what *will* import rather than what won't. **CONFIRMED by Daniel 2026-08-23: orphaned tails import.** Dropping data the schema can hold would be a loss the lines case does not share.
- **Not done automatically:** merging `Cat SL Sub 3` → `SL Cat Sub 3` or `cALD #1` → `cALD 1`. Both targets already carry a complete source+destination tail pair, so the merge would over-fill a mult. Available to Daniel as a data-hygiene call in v1; never an importer normalisation rule.

**R-4 · Length. RULED (Daniel): the FUNCTION is what matters — a metric cable on an imperial show always displays in metres with the `m` suffix, an imperial cable on a metric show always displays in feet, and it round-trips through v1 import/export. Field type is not the requirement.**

**Measured verdict: the function is already implemented at storage, view and display. Two ends are missing, and they are exactly the two Daniel named.**

Already true, read at source rather than assumed:

- **Storage** — `cable_details.length_unit` and `bundles.length_unit`, both `CHECK ('ft','m')`, both **per row**. `projects.units` supplies the default only.
- **The view resolves it** — `v_cable_list` computes `effective_length_unit` as *bundle's unit if bundled, else the cable's own*, which is D-1's four-wide inheritance carrying the unit with the length. Its `weight_lbs` column converts `'m'` → feet at ×3.28084 **before** multiplying by weight-per-foot, so the rollups are already unit-correct.
- **Display is already per-row in both directions** — every consumer (`CableRow.tsx:486`, `CableBands.tsx:208`, `TailBands.tsx:61`, `LineBands.tsx:48`, `CableListClient.tsx:3107`) calls `formatCableLength(effective_length_value, effective_length_unit, fallbackUnit)`, and the project fallback applies **only when the row's own unit is null**. A metric cable on an imperial show already renders `150m`; an imperial cable on a metric show already renders `150'`.
- **Sorting normalises** — `cableSortChains.ts:118`, and `bundleList` / `bundleBands` route volume and the R-10 area thresholds through the same `toFeet()`.

Missing, and this is 2-IMP-b's and 2-EXP's actual work:

1. **Input — LEN-INPUT-SUFFIX.** `parseLengthInput()` strips and discards a typed `m` / `'`, so **an operator cannot create a metric cable on an imperial show today**: typing `150m` commits 150 feet, silently. A typed suffix must SET the unit. This is the blocker for the ruling as stated.
2. **Import must set the unit from v1's text**: `150m` → (150, `m`), `150ft` → (150, `ft`), bare integer → **`ft`, not the project default** — evidence-backed, because v1's own `Length for Summary` treats bare as feet and converts only the suffixed metre rows (`150m` → `492.126`).
3. **Export must re-emit the suffix**: `150m` for a metric row, a bare integer for feet — which is what v1 stores (measured: 490 / 249 / 437 bare against 3 suffixed corpus-wide).
4. **The metric path has never run.** All **27 live projects are `imperial`** — the code exists and has never met real metric data. The browser gate for 2-IMP-b must include a metric project and a metric cable on an imperial project, both directions, through display, print and export.

**Field type stays `numeric` + unit** — not for its own sake but because it is what delivers the function: widening to text would break `toFeet()` in four modules and with it bundle volume, the R-10 thresholds and the weight rollup, while buying nothing the unit column does not already provide. The corpus agrees there is nothing else to store: of 1,176 populated lengths, five are non-integer — `'150m'` ×2, `'150ft'` ×1 (all modelled) and `'x'` ×2 (import as null + variance).

**The `box_number` precedent was considered and does not transfer, on the measurement.** `199A` was a real alphanumeric box number Daniel confirmed exists; length has no such vocabulary. And the two are different kinds of value: a box number is an identifier, a length is arithmetic — it drives bundle volume, the R-10 area thresholds and the weight rollups through one `toFeet()` helper in four modules, consumers a box number never had. **A type widening is safe when the rendered value is proven unchanged; here the rendered value is already right and the arithmetic is what would break.**

**R-5 · Models used but never defined. RULED: create them**, symmetric with BOX-TYPE-LIB (Aug 22) — 13 cable models over 40 rows, 17 tail models over 39. **The trap that nearly killed the box version applies verbatim:** `createMissing` covers categories and methods only, so a `cable_types` key handed to it would be **ignored in silence**. They ride `ops.cable_types.inserts`.

**R-6 · `Wire Type` / `Wire Type Quantity`. RULED: both to IGNORED** in the sheet spec, citing R-12 and the measurement. WIRE-TYPE's deprecation is a UI and output ruling, not a column removal — script 566 still exports both as the last two `cable.xlsx` columns and 567 re-imports `Wire Type` at source field 60 — but `Wire Type` is **0-populated in all three corpora** and `Wire Type Quantity` is a summary constant (558 / 177 / 673).

---

## 8 · Registered from this scoping

- **LINK-ORPHAN** — `link_group_members.item_id` has no FK; 210 live members, 0 resolving, all in JOY. Defended at read (`CableListClient.tsx:685-688`); a mirror re-import orphans memberships permanently.
- **LEN-SCALE** — `cable_details.length_value` 853/7 and `bundles.length_value` 97/2 split by stored scale. Invisible while the column stays numeric; re-verify the PostgREST serialisation claim at build.
- **CABLE-HISTID** — 13 non-UUID HistoryIDs across `cable`, `tails` and `cable clone links`; the clone-link values are the same literals as the cable ones. `resolveHistoryId` needs exporting and `SheetName` widening.
- **HISTENTRY-NOTID** — `History Entry ID` is a non-unique FileMaker timestamp on every row of every corpus. Never map it to an id.
- **CABLE-GUARD-GONE** — the leg-1b test that made "mapped without an RPC arm" a red build retired at `4c234dd`; nothing enforces it today.
- **LINES-NOFK** — `lines.sourceID` / `destinationID` exist in v1 and are 0-populated in all three corpora; the DDR confirms no relationship joins on them. The name-key tax is structural, not a corpus accident.
- **LEN-INPUT-SUFFIX** — `parseLengthInput()` strips and discards a typed `m`/`'` suffix, so `150m` typed on an imperial show commits 150 **feet**, silently, with no error and no variance. Directly contrary to R-4's requirement. Rides 2-IMP-b.
- **CABLE-ORPHAN** — 17 child rows in JOY name three cables that do not exist under any normalisation (trim, case, internal whitespace all measured at 0 effect). Under R-3 the 12 lines are dropped behind a pre-apply dialog and the 5 tails import with a blank Mult. BVSC NY and BVSC carry zero orphans, measured at every normalisation level.
- **METRIC-UNRUN** — all 27 live projects are `imperial`. The per-row metric path exists through storage, view, display, sort and weight rollup and **has never met real data**. 2-IMP-b's browser gate must exercise it in both directions.
- **JOY-NAME-HYGIENE** — JOY carries 29 blank `cable.Name` rows (26 loose XLR stock, 3 bundled Ethercons; all 29 hold a valid UUID HistoryID) and 40 names with leading or trailing whitespace. Disjoint from CABLE-ORPHAN. **Trimming on import would create additional name collisions beyond the 61 already measured** — so the importer must not trim cable names without a ruling.

## 9 · Corrections of record

- **The run fence is one unit stale.** `CLAUDE.md`'s `## Current run fence` reads `HEAD is d39179a` with counts measured at `d39179a` (1961 tests) and `THIS UNIT IS HISTID-UUID` — a unit that closed at `41d1002` with 1975. The opener's claim that the fence is "CURRENT as of `41d1002`" is wrong in its HEAD line, its counts block and its unit line. **Folded into leg 2's first handoff** (Daniel, this session). Same disease as FENCE-STALE at one unit instead of three, and caught by the fence's own amended rule: whoever measures updates it in the same pass.
- **`1975/121` re-verified independently.** 118 test files under `src/` plus 3 under `scripts/` (`declaredEvent`, `pngDiff`, `export-compare`) = **121 test files**. The Roadmap and the fence are right; a src-only count is what makes it read as 118.
- **Two dangle figures struck** — see §2.

---

*End of scope. Written from measurement: 24 corpus files opened in full (plus `boxes.xlsx` on the re-measure), the live schema and RPC body read at source, the repo read at `41d1002`. Nothing built. Six rulings taken. Next: the 2-EXP handoff, carrying the run-fence correction and GATE-NEST-UPGRADE.*
