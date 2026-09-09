# FINDPARITY-UNTYPED — DISCHARGED. 25 of 25 fields typed, every count exact.

*Cowork-Arch, 2026-09-08. Run from this seat through the Cowork browser pane against **production** (`https://minotaur.app`, HEAD `1276cc4` — the tree FIND-PARITY shipped), on `Cable Parity Fixture` (`dbf56057-0447-41a9-81b1-a8842a83b958`). **Supersedes `260908-2025_findparity-sweep_equipment-RESULT.md`, which covered equipment only.***

⚠ **READ-ONLY, AND VERIFIED SO AFTER THE FACT.** During the whole sweep: **0** `equipment_items` written · **0** methods created · **0** categories created. The fixture's last write remains **2026-09-08 15:15:14 UTC**, hours before the sweep began and unchanged by it.

## 1 · The bar: an EXPECTED COUNT, not "did anything come back"

The registered hazard (FINDPARITY-UNTYPED) is that a wrong accessor returns an **empty** find, which an operator reads as missing data. **A ">0 rows" check would catch only the crudest form of that.** So every needle was priced at the database first and the app's `Found (N)` compared to it. **A pass below is an exact match.**

Where a project has no positive value for a field, the field was tested by **absence** instead: both `labelCountText(0)` and `flagFace(false)` render BLANK, so `is blank` must return the whole list. That is a real test of the accessor — a broken one returning `undefined` would also match `is blank`, which is why every such field sits beside positive tests on the same surface that a broken accessor could not have passed.

## 2 · EQUIPMENT — 5 of 5

| Field | Criterion | Expected | App | |
|---|---|---:|---:|:--|
| Starred | contains `Yes` | 2 | 2 | ✅ |
| Drawn | contains `Yes` | 115 | 115 | ✅ |
| Packed | contains `Yes` | 843 | 843 | ✅ |
| Labels | is blank | 1,335 | 1,335 | ✅ |
| Override | is blank | 1,335 | 1,335 | ✅ |

## 3 · CABLE — 7 of 7 (the inspector's seven)

| Field | Criterion | Expected | App | |
|---|---|---:|---:|:--|
| Color | contains `yellow` | 99 | 99 | ✅ |
| Category | contains `3.0 Wireless` | 6 | 6 | ✅ |
| Method | contains `Rent-Main` | 8 | 8 | ✅ |
| Group | contains `Loose-Ampland` | 69 | 69 | ✅ |
| Group | contains `Turkey` | 0 | 0 | ✅ |
| Group | is blank | 2 | 2 | ✅ |
| Public Notes | contains `Pin 1` | 6 | 6 | ✅ |
| Private Notes | is blank | 1,121 | 1,121 | ✅ |
| ETA | is blank | 1,121 | 1,121 | ✅ |

⚠ **GROUP WAS THE ONE ANOMALY AND IT WAS ARCH'S ERROR, NOT THE APP'S — recorded because the wrong version is the one a later session would re-derive.** `Turkey` returned **0** where Arch expected 1. The expectation came from `equipment_items.group_label` — the STORED value. **The accessor reads `v_cable_list.effective_group`, which is the ruled behaviour (Daniel, 2026-09-08: cable `group` finds the EFFECTIVE group).** Read from the view the app actually loads: `effective_group ilike '%Turkey%'` = **0**, `Loose-Ampland` = **69**, blank = **2**. **The app matched the view on all three.** *Only the surface describes the surface — a needle priced against the wrong table is an instrument that has inherited the claim's parameters.*

## 4 · BOXES — 13 of 13

| Field | Criterion | Expected | App | |
|---|---|---:|---:|:--|
| Number | contains `615` | 1 | 1 | ✅ |
| Big Labels | is exactly `2` | 119 | 119 | ✅ |
| Small Labels | is exactly `2` | 10 | 10 | ✅ |
| Color | contains `Yellow` | 16 | 16 | ✅ |
| Return Notes | contains `Returned` | 5 | 5 | ✅ |
| Public Notes | contains `WRK` | 7 | 7 | ✅ |
| Category | contains `Load-In` | 1 | 1 | ✅ |
| Method | contains `Rehearsal` | 2 | 2 | ✅ |
| Add'l Weight | is blank | 135 | 135 | ✅ |
| Actual Weight | is blank | 135 | 135 | ✅ |
| Add'l Cost | is blank | 135 | 135 | ✅ |
| Label Notes | is blank | 135 | 135 | ✅ |
| Private Notes | is blank | 135 | 135 | ✅ |

**`Number` is the rekeyed field** — the one whose marker and map disagreed until FIND-PARITY, and whose spelling Daniel delegated to Arch today. It finds correctly under `box_number`.

## 5 · The registries reach the screen

Read from the live Find panels: equipment offers **16** fields, cable **18**, boxes **20** — every key the census recorded, including all 25 new ones. ⚠ **`in_box` is correctly ABSENT from the box panel**, which is the subset ruling holding in the UI: Change All cannot write it, so Find does not offer it.

**The static contract test proved the four structures agree. This proves the agreement is live in a browser, on real v1 data, on all seven surfaces the census covers.**

## 6 · ⚠ What this does NOT discharge

- **The leg 3a browser gate is untouched and still Daniel's.** It tests *un-deployed* code — the autocomplete portal, the ⌥⇧D landing, the ⌥⇧E non-regression, the bundled-cable Group. **None of that is on production and none of it was exercised here.**
- **FINDFLAG-CHECKBOX still stands.** The four equipment flags find as the word `Yes` while the cell draws `✓`. **They work — that is what the 2/115/843 prove — but the face is the interim one Daniel superseded.**
- Nothing here speaks to **printed** output. BROWSER-NOPRINT: this pane does the behavioural half of a gate and cannot do the printed half.

## 7 · Method notes, for whoever runs the next one

- **The find is client-side over loaded rows**, so a needle must be priced against the view the client loads (`v_cable_list`), not the base tables. §3 is the cost of forgetting that.
- **Setting a React-controlled input from automation needs the native value setter plus an `input` event.** A plain value assignment leaves React's state empty, and the find then runs on an empty criterion and **returns the whole list** — which reads exactly like a passing find and is not one. That happened once and was caught by the expected count disagreeing.
- ⚠ **The criterion box is NOT RENDERED when the operator is `is blank` or `is anything`.** An automation that assumes it exists will grab the next input on the page — which on these surfaces is a **live editable cell on a real record**. That happened once by hand before the guard existed; **Escape reverted it and the database confirmed nothing was written.** The helper now refuses any input inside `[data-box-field]`, `[data-b2-field]`, `[data-insp-field]` or `[data-equip-field]`, and it fired correctly on the very next attempt.
