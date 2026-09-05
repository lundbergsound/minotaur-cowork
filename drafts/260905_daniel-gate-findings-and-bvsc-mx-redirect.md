# Daniel's gate findings (2026-09-01→05) + the BVSC Mexico City redirect

**Logged 2026-09-05 from the Arch seat. Daniel's browser gate found THREE things, two of them on surfaces this session touched. Each is recorded with the mechanism measured at source, or explicitly marked as a LEAD that must be proven. Nothing here is fixed.**

---

## ⚠ 0 · THE STATE FINDING THAT COMES FIRST — CHANGEALL-FOUNDSET IS STILL UNCOMMITTED

Read from the ref files 2026-09-05:

```
Minotaur        main = origin/main = e3a336a     (unchanged since 2026-08-31)
Minotaur-Cowork main = b1c7ad3                   (the Aug-31 close; the Sep-1 rollover is NOT in it)
migration ledger = 57                            (APPLIED 2026-09-01)
```

**The client half of CHANGEALL-FOUNDSET — 14 files, gated green on 2026-09-01 at suite 2679/142, frozen 3/3, visual 28/28 with no baseline event — has been sitting in the working tree, uncommitted and unpushed, for four days.** So has the Session Log rollover in `Minotaur-Cowork`.

**⚠ THE DATABASE IS AHEAD OF THE CODE.** Ledger 57 carries the four bulk-write RPCs; production serves `e3a336a`, which calls none of them. That direction is harmless — the functions are additive and unreferenced. **The reverse would not be**, and this is exactly the state that must never be left ambiguous across a gap this long.

**⚠ WHICH BUILD DANIEL TESTED IS NOT SEAT-VERIFIABLE AND MUST NOT BE ASSUMED.** Production at `minotaur.app` runs the PRE-fix code. A local dev server runs the fixed tree. The three findings below read differently depending on which one was in front of him, and **the seat cannot tell from any file.** Arch's inference, stated for correction in one word: he gated the local tree, which is what the handoff asked for. *(Recorded as an assumption, not a measurement — TENSE-IS-A-CLAIM.)*

---

## 1 · ⚠ CHANGEALL-BOXNULL — **MEASURED 2026-09-05, no longer a lead. LIVE IN PRODUCTION.**

**⚠ UPGRADED FROM LEAD TO MEASURED. The defect is at `EquipmentListClient.tsx:2368-2372` and it ignores the typed draft entirely:**

```js
} else if (field === 'box_name') {
  const boxId = sourceRow.box_id ?? null
  const boxName = boxId ? boxes.find(b => b.id === boxId)?.name ?? sourceRow.box_name ?? null : null
  dbPatch = { box_id: boxId }
  displayPatch = { box_id: boxId, box_name: boxName }
```

`sourceRow.box_id` is the **stored** value on the source row. The capture path never resolves a box draft — `category_name` gets a resolve-or-revert branch at `:2277-2279` and `method_name` gets `planMethodChangeAll` at `:2335`; **box gets neither, and falls through the plain-text branch that updates `box_name` while leaving `box_id` untouched.** So:

- **Source row has NO box + a new name typed → `dbPatch = { box_id: null }` written across the entire found set.** That is Daniel's blanking, exactly, and it is the CHANGEALL-METHODNULL mechanism on the box field.
- **Source row HAS a box + a different name typed → the OLD box_id is replicated to the whole found set.** A second, quieter failure in the same arm: no blanking, no error, and the wrong box on every row.

**⚠ IT IS NOT A REGRESSION FROM THE UNCOMMITTED TREE, AND THAT MATTERS FOR THE COMMIT.** Daniel confirms he was on a local dev server, so the question was live. But this block computes the PAYLOAD; CHANGEALL-FOUNDSET changed only the TRANSPORT (`.update(patch).in('id', ids)` → `bulkUpdate`). The arm sits inside the same if/else chain as CHANGEALL-METHODNEW's comment, which shipped at `e3a336a`. **The defect is live at HEAD and in production right now**, and committing the gated tree neither introduces nor worsens it.

**Still owed before any fix ships: a negative control that REPRODUCES the blanking.** A control that passes is not a control — this project has paid for that lesson once already, in the unit directly beside this one.

---

## 1b · The original report, and the two claims inside it

**Daniel, verbatim:** *"I went to enter a new box then change all in equipment, and it made everything blank rather than bringing up new box dialog."*

**There are TWO claims inside that sentence and they have different answers.**

**(a) It blanked the found set. If reproduced, that is silent data loss and it is a defect, full stop.** It is the same shape as CHANGEALL-METHODNULL, which shipped its fix at `e3a336a` **on the method branch only**. Nothing in that unit touched box.

**What Arch measured, and what it does NOT prove.** The **band editor's** box arm (`EquipmentListClient.tsx:1900-1912`) is CORRECT and carries the doctrine in its own comment: *"A no-match non-empty box name is a no-op-revert (creation is ⊕-only) → no change, no dialog."* Its bulk arm writes only when the name resolves, or when the draft is empty:

```
if (trimmed === '') { await propagateFieldToIds(ids, 'box_id', null, { box_name: null }); return }
if (resolved) await propagateFieldToIds(ids, 'box_id', resolved.id, { box_name: resolved.name })
```

**That is the band editor, and Daniel's report is about the ROW-CELL Change All path — a different arm.** The asymmetry between those two arms is precisely what CHANGEALL-METHODNEW existed to close for method. **LEAD, to be proven at the row-cell Change All arm, not at :1900:** the box branch there falls through to a null write on an unmatched non-empty draft, exactly as `method_name` did. **Prove it with a negative control that reproduces the blanking — a control that passes is not a control** — and measure it before designing the fix.

**(b) It did not offer a new-box dialog. That may be correct by ruling, not a defect.** Box creation is **⊕-only, deliberately**, and the source says so. If Daniel wants a box creatable from the cell the way a method now is, that is a **new ruling and a divergence from the current doctrine**, not a bug report — and it wants CHANGEALL-METHODDOCTRINE's answer first, since equipment/method now creates, cable/method reverts, and box reverts everywhere.

---

## 2 · FIELD-CONTRACT-FIND — the steck field, and the mechanism is a VOCABULARY GAP

**Daniel, verbatim:** *"change all doesn't work in the steck field of the cable view, and the steck field doesn't appear in search. Look at every field in every layout to verify search works and change all works, like v1."*

**Measured at source 2026-09-05 — this one is not a lead, the mechanism is in the files:**

- The steck cells exist and ARE marked: `CableRow.tsx:721` and `:781` carry `data-b2-field="source_steck"` and `"destination_steck"`.
- Change All gates on **`field in CHANGE_ALL_FIELD_LABELS`** (`CableListClient.tsx:3112 · 3125 · 3182`).
- **`CHANGE_ALL_FIELD_LABELS` (`src/lib/cable/cableChangeAll.ts:48-64`) holds FIFTEEN fields and NEITHER steck is among them:** `cable_name · description · model · length · source_device_text · source_connection · destination_device_text · destination_connection · group · eta · public_notes · private_notes · color · category · method`.
- So the gate drops the steck cell — and the code says so in its own words at `:3121`: *"the `in CHANGE_ALL_FIELD_LABELS` gate drops it naturally."*
- **A second, separate gap:** the attribute value is `source_steck` while the database column is `source_steck_count` (`CableListClient:2126`). **The marker and the column do not share a name**, so even adding a label keyed by column name would not resolve the lookup. Two vocabularies, one field.
- `CableRow.tsx:62` states the original intent: *"steck counts are NOT in the ruled order (click-entry only)."* **An exclusion from the ruled TAB order appears to have carried, unexamined, into the Change All and Find vocabularies as well.**

**This is FIELD-CONTRACT's defect class exactly — MOVING A FIELD OUT OF ONE BRANCH'S VOCABULARY WITHOUT GIVING IT ANOTHER — and it is the seventh time Daniel's browser gate has found what the machine gates could not.**

**⚠ FIELD-CONTRACT WIDENS.** It was ruled as a registry of every editable cell and its wirings (Enter-advance · ⌥⇧ record movement · ruled Tab order · Change-All draft capture · Escape-reverts · display-and-edit-agree). **Daniel's instruction adds FIND to that list and makes the registry's coverage the acceptance: every field, every layout, both behaviours, judged against v1.** The test that fails when a rendered editable cell is absent from the registry now also fails when it is absent from the Find vocabulary.

**⚠ Whether steck SHOULD be Change-All-able and findable is a v1-parity question, and v1 is the arbiter.** Daniel says v1 does both. That is a ruling from the person who owns the v1 knowledge; it still gets checked against the DDR before it is built, because the source states intent and the artifact states behaviour.

---

## 3 · What Daniel confirmed WORKING

*"Change All works where I tested it."* Recorded as a pass on the surfaces he exercised, with the build ambiguity in §0 attached to it. **It is not a clean bill for all seven surfaces** — the gate list in the CC return named equipment · cable · bundle · line · tail · box · library plus Delete Found, a cable delete owning tails, an unallocate, a box pack cascade and Clear Remaining, and there is no record of which of those ran.

---

## 4 · THE REDIRECT — urgent production fixes for BUENA VISTA SOCIAL CLUB, MEXICO CITY

**Daniel's ruling 2026-09-05: the roadmap reprioritises to what this production needs. Everything else takes a pin.** Two named items:

### 4.1 · CAT-NOTE + CAT-ADMIN — a category note, and a rudimentary category management page
*"We must add a category note, and a rudimentary category management page. See these notes under the cable."*

**⚠ OPEN: "see these notes under the cable" is not resolvable from the seat** — it may mean a notes field on the cable row, a note Daniel left in a document, or a photograph not yet uploaded. **Asked, not guessed.** Scope, schema and the meaning of "rudimentary" all depend on it. Precedent to build against: `MethodsAdminClient.tsx` is the existing admin surface for the sibling vocabulary and is the obvious shape to copy rather than invent.

### 4.2 · EQUIP-LIST-PARITY — the equipment list and cover letter, uniformly scaled
*"another visual parity pass on the equipment list using the techniques we learned in box labels and cable labels. Previous PDFs have been 75% I think, and our previous fix attempts were patches on top of patches. If we can uniformly scale the list and cover letter so that font sizes look and feel like v1, that'd be good."*

**The technique named is the one that worked twice: measure the artifact, derive the die, drive everything from ONE constant.** STOCK-IS-DIE replaced three drifted geometries with a single `AVERY_5167`; CELL-AND-ROW collapsed a nine-value row ladder to one. **"Patches on top of patches" is the diagnosis, and the cure is a measured scale factor, not another patch.**

**⚠ The 75% is Daniel's recollection and is explicitly NOT a measurement — "I think".** The first step is measuring the actual ratio off a matched v1/v2 pair, print-to-PDF at 100% through Chrome's own destination (PDF-CHROME-PATH), not adopting 75% as a constant. **A threshold recorded in the wrong unit goes stale silently: record the mechanism and derive the number.**

**Two things this pass must not discover mid-build:** `v_equipment_list` does not filter `type` and exposes `ip_address` while hiding `address` (EQUIPVIEW-UNSAFE — `address` is populated on 261 rows, `ip_address` on 1, and v1's equipment output prints Address) · and the cover letter is its own document with its own geometry.

---

## 5 · Sequencing — Arch's read, for Daniel's ruling

1. **CHANGEALL-FOUNDSET's commit.** Four days of green, gated work is uncommitted and the gate that closes it has now been run. **Nothing else should be built on a tree with fourteen uncommitted files in it.**
2. **CHANGEALL-BOXNULL.** Silent data loss on a surface that will be used on a real show. **This does not belong behind a parity pass**, and it is small if the lead proves out — the method fix beside it is the template.
3. **FIELD-CONTRACT, widened to Find.** Daniel's instruction is an audit of every field in every layout; it is the unit that makes findings 1 and 2 structurally impossible rather than fixed one at a time.
4. **CAT-NOTE + CAT-ADMIN**, once the notes are in hand.
5. **EQUIP-LIST-PARITY.**

*Items 4 and 5 are Daniel's stated production priorities; items 1–3 are what stands between them and a tree that can be built on. The ordering is Arch's recommendation and Daniel's to overrule.*


---

# ADDENDUM — measured 2026-09-05 after Daniel's reply

## A · The build question is ANSWERED and then DISSOLVED

Daniel: *"I was on a local dev server when I put in those notes, never committed."* So the observation was made against the uncommitted fixed tree. **The question mattered and no longer does** — §1 shows the defect is upstream of anything CHANGEALL-FOUNDSET touched. Transport changed; payload did not.

## B · CAT-NOTE is DEFINED from the artifact — and the corpus CANNOT arbitrate it

"See these notes under the cable" means **notes under the Cable category heading**. From Daniel's screenshot of a v1 parts list, a category note is:

- **Attached to a CATEGORY, not an item**, and rendered **between the category heading rule and the first item row**
- **Italic, indented to the heading's left edge**, set smaller than the heading
- **More than one per category** — `8.0 Power` carries two, `9.0 Hardware and Rigging` two, `13.0 Cable` two
- Free prose, and operationally load-bearing: *"Production will use L21-30 and Powercon distribution to all equipment as needed — no Socapex"* · *"Confirm truss quantity and model with production engineer before purchasing"* · *"Monoprice SlimRun preferred for short lengths of category cable"* · *"15-Pair may be substituted for 12-Pair"*

**⚠ MEASURED ABSENCE, with the instrument proved first.** `pdftotext -layout` extracts **58,996 characters** and all **125** numbered headings from `260829-1734_v1_group-parts_BVSCNY_blank-find.pdf`, so the reader works. Searching every PDF in `~/Minotaur_v1_exports/` for the note strings returns **ZERO hits**, and scanning all 125 headings for a non-item line beneath them finds **only four, all page footers**. **BVSC NY carries no category notes at all.**

**So the reference corpus cannot serve as this feature's parity arbiter, and the screenshot is a screenshot — valid for on-screen anatomy only, never for geometry (the PDF rule).** A fresh v1 print-to-PDF at 100% through Chrome's own destination, from a show that actually uses category notes, is **OWED before CAT-NOTE's print half is specified.** Same shape as PRINT-FOUNDSET and CABLE-SPLIT: a feature the corpus does not exercise cannot be built against the corpus.

**What the corpus DOES show, and it is a different thing:** indented italic sub-lines under individual items (*"on reel"* · *"One HMA Loop"* · *"or 32-Bit Analogue Input Card"*). Those are **item-level notes and already exist**. The category note is a new level, not an extension of that one — do not conflate them when scoping.

## C · Sequencing, revised on the measurement

The commit is **safe and should go first** — §1 removes the regression risk that would have blocked it. CHANGEALL-BOXNULL then leads the BVSC Mexico City work, because it is live data loss on the equipment surface Daniel is about to use for a real show.
