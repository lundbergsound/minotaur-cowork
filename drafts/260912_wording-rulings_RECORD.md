# WORDING RULINGS — 2026-09-12 (Daniel)

*Arch main line, while CC runs AUTH-RESETPAGE. Three of the four wordings are ruled; the fourth turned out not to be a wording question at all.*

## RULED — EXPRPT-HINT (Daniel, 2026-09-12): APPROVED as proposed

Pedigree (a). `src/app/project/[projectId]/settings/page.tsx:451`, the `hint` prop of the "Minotaur v1" FormRow.

- **Was:** `Generates a v1-compatible .xlsx set (equip/library/methods/categories) as a .zip — reviewable here before you download it`
- **Is:** `Generates a v1-compatible .xlsx set — equipment, library, methods, categories, boxes and the cable sheets — as a .zip, reviewable here before you download it.`

One edit, one file. CC correctly refused to write this without a ruling; it now has one. ⚠ **Rides the next unit that touches `settings/page.tsx` — it is not worth its own handoff, and it does NOT ride AUTH-RESETPAGE, which is fenced to `src/app/auth/`.**

## RULED — VERHIST-MANUALLEAD (Daniel, 2026-09-12): APPROVED as proposed

Pedigree (a). `src/lib/verhist/guard.ts:229`, `SAVE_VERSION_REFUSAL_PROPOSAL`.

> Minotaur tried to save this Project Version, but it didn't work. Nothing has been saved. Please check your internet connection and try again.

⚠ **THE GATE IS LIFTED.** "No further Save Version work until Daniel rules the wording" is discharged, so VERHIST-UI Leg 2 is unblocked on this point.

**Two housekeeping consequences for the next unit touching that file:**

1. The constant is named `SAVE_VERSION_REFUSAL_PROPOSAL` and its doc comment says three times that it is a PROPOSAL awaiting Daniel's wording. **Rename it to `SAVE_VERSION_REFUSAL_MESSAGE` and rewrite the comment to cite this ruling** — a ruled sentence sitting under a constant called `_PROPOSAL` is how a settled call gets relitigated.
2. The comment's reasoning about *why* the shape differs from the other three leads is correct and stays; only the not-ruled framing goes.

## RULED — CABLEDEL-FAILMSG (Daniel, 2026-09-12): the word "cleanup" is out

⚠ **Daniel's objection: an operator does not know what "the cleanup" means.** Correct — "pre-delete cleanup" is the internal name for the work, not a description of it. Measured at source before rewriting: the step removes the dying cable from **every link group it holds a membership in** (`planDeletePurge`, `linkMembership.ts:217`, dissolving any group left with ≤1 member) and rehomes its patch ends. So the operator-facing truth is "taking it out of its link groups."

`src/components/cable/CableListClient.tsx:3053`.

- **Was:** `Delete aborted — the pre-delete cleanup failed: ${e.message}`
- **Proposed (awaiting Daniel's yes):**

> Minotaur couldn't delete this cable. Before deleting it, Minotaur has to take it out of any link groups it belongs to, and that step didn't finish — so the cable is still here, but some of its link groups may already have changed. Open the cable and check its links before trying again.

⚠ **The raw error text: Arch's call, overridable in one word.** `${e.message}` currently lands inside the sentence. Proposal is to keep it but move it to its own trailing line as `Details: ${e.message}`, because this failure is rare and when it fires Daniel will want the cause — while a vendor string mid-sentence is exactly what §4 of the AUTH-RESETPAGE handoff forbids on new screens.

⚠ **Standing, and it survives the fix:** this path was never atomic, so the message was wrong before PREBETA-FRICTION as well as after. The fix surfaced the gap; it did not cause it.

## NOT A WORDING QUESTION — INSPECTOR-ARM's row does not match the code

⚠ **Daniel said he did not know what the row meant. Re-read at source, neither does the row.** The Docket and `260912_owed-at-daniels-desk_v4.md` both say *"`method` lives only in the inspector, which arms Change All only when a row is selected."* **Measured at `d980b73`, that is false in both halves:**

- **`method_name` is an ordinary row cell** — `EquipmentItemRow.tsx:755`, `data-equip-field="method_name"`, inside the same `[data-equip-row]` wrapper as Group, Public Notes, Circuit and IP Address.
- **It is in the Change All field set** — `equipmentChangeAll.ts:60`, `method_name: 'Method'`, one of seventeen.
- **The library screen's equivalent is the same shape** — `method_hint` at `EquipmentLibraryClient.tsx:763`, in `LIBRARY_CHANGE_ALL_FIELD_LABELS` at `equipmentChangeAll.ts:106`, inside `[data-lib-row-id]`.
- **Neither arming path asks for a "selected row."** Both read the field's own row ancestor at focus/click capture (`EquipmentListClient.tsx:2241-2246`, `EquipmentLibraryClient.tsx:683-693`). There is no selection concept in either guard.

**So the two fixes Daniel was asked to choose between are fixes to a guard that is not the guard that failed.** Ruling on either would have shipped a change to working code and left his actual defect live.

⚠ **What is NOT in doubt: Daniel hit a real defect on 2026-09-11** — a Method field that accepted typing while Change All stayed disabled with nothing on screen explaining it, and clicking did nothing. That reproduction stands. **What is wrong is the diagnosis of record**, which appears to have been written from the symptom rather than from the surface — SURFACE-RULE's shape, in Arch's own Docket row.

**Owed, and it is Arch's, not Daniel's:** one short measurement pass on the running app — which screen, which Method field, what `changeAllArmed` actually was, and whether the row ancestor resolved. **Three minutes at the browser, and it is a measurement, not a design pass.** Only then is there a fix to rule.

⚠ **Until then INSPECTOR-ARM is NOT a friction-pair item waiting on Daniel's word, and the Docket row must stop saying it is.** Its row and the `owed-at-daniels-desk` entry both change at this close.
