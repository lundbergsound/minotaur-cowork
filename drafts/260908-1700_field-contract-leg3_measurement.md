# FIELD-CONTRACT leg 3 — the measurement of record

*Cowork-Arch, 2026-09-08. Every line:line below re-measured at `1276cc4` in the session that wrote the leg-3 handoff (the Surface Rule). **The opener's figures were carried from the leg-2 close and THREE of them are wrong** — corrected here rather than in the handoff alone, because `handoffs/` is gitignored and `drafts/` is not.*

## 1 · Corrections to the opener's §2

| Claim in `260908-1620_next_session_opener.md` | Measured at `1276cc4` |
|---|---|
| model band editor at `EquipmentListClient.tsx:3453` | **`:3476`** |
| `captureFocusedField` at `:1244`, `:1259` | **`:1265`** (the function opens there) |
| `AM-3` at `:373-376` | **`:395`** (listener) and **`:3473`** (the band sibling comment) |
| AUTOCOMPLETE-NOPORTAL: six equipment call sites | ⚠ **NINE sites carry no `portalDropdown`, out of 33 total** — the six named, plus `PrintEquipmentListClient.tsx:427` and `:437` and `PreviousRevisionsClient.tsx:1017` |
| CABLE-FINDDEFAULT at `CableListClient.tsx:476` | **`:490`** |
| CABLE-TAB-BUNDLE-METHOD is "the ruled tab order, the same family as the steck exclusion" | ⚠ **NOT a wiring gap — it is an unruled UX question.** See §3 |

⚠ **The autocomplete miscount is the same shape the leg-2 close registered: an instrument narrower than the claim.** The opener's six came from a search for the equipment files; censusing all 33 call sites found three more on two other surfaces. *Census the class, then narrow* — sixth occurrence.

## 2 · THE MODEL GAP — confirmed, and the "three of four" holds

The four equipment resolvers and the attributes each reads, all re-read at source:

| # | Resolver | Reads | Sees the band editor? |
|---|---|---|---|
| 1 | `lastFocusedFieldRef` focusin listener (`:400-401`) | `[data-equip-field], [data-find-field]` | **yes** |
| 2 | Change-All invoker band path (`:2204-2206`) | `[data-find-field]` | **yes** |
| 3 | `captureInFlightDraft(EQUIP_DRAFT_FIELD_ATTRS)` (`:2334`) | `['data-equip-field', 'data-find-field', 'data-equip-check']` (`rowFields.ts:50-52`) | **yes** |
| 4 | **`captureFocusedField` (`:1265`)** | `[data-equip-field]`, then `[data-equip-check]` gated on `isInFlightEditable` | ⚠ **NO** |

The marker is real: `data-find-field="model"` at `:3476`, with its own comment naming it "the ONLY Model edit surface." **The fix is a third branch in one function.** `data-equip-field` remains the wrong instrument — AM-3 (`:395`) keeps it off the band editors deliberately, and `captureFocusedField` also serves ⌥⇧↑↓ and the single-record delete, so the branch must not disturb the existing two.

## 3 · ⚠ CABLE-TAB-BUNDLE-METHOD IS A RULING, NOT A REPAIR — it comes OUT of leg 3a

Daniel's note (2026-09-05): *"Tab does not move from the Bundle pull-down to the Method pull-down."*

Measured: **they are in two different tab chains, and the current behaviour is correct for the ruled order.**

- `CableRow.tsx:67-71` — `TAB_ORDER` is nine ROW fields: `cable_name · description · bundle · model · length · source_device_text · source_connection · destination_device_text · destination_connection`. **Bundle is #3; Tab from it goes to Model, as ruled.** (`:450` drops Length on a bundled row.)
- `CableInspectorPanel.tsx:45-46` — `INSPECTOR_ORDER` is five PANEL fields: `color · category · method · group · box`. **Method is #3 of that chain.**

So Method is not missing from a chain — it is in the other one. Making Bundle→Method work means either reordering the ruled row order or joining the two chains, and **both are UX-affecting with no pedigree.** Registered for leg 3b as a question for Daniel, not built.

## 4 · CABLE-FINDDEFAULT — confirmed, and the pedigree is in the same file

`CableListClient.tsx:490` — the focus-aware find default listener resolves `closest('[data-b2-field]')` only, so the seven inspector fields FIND-PARITY made findable cannot seed ⌥⇧F from focus.

**The pedigree for the fix is eight hundred lines below it:** `:3215` already reads BOTH markers — `captureInFlightDraft(['data-b2-field', 'data-insp-field'])`. One surface, two markers, and only one of its resolvers knows.

## 5 · CABLEGROUP-EDITOR — ruled, and it is the one item that MOVES THE CONTRACT TEST

Daniel, 2026-09-08: *"A bundled cable shouldn't have a group field — its group should be text instead, inherited from the bundle."* The find half shipped in FIND-PARITY. This is the editor half.

Measured: Group is inspector field #4 (`INSPECTOR_ORDER`, `CableInspectorPanel.tsx:46`), committed through `onCommitText('group', raw)` at `:329-336`.

⚠ **A cell leaving the editable set changes `cellsOf(cable)`, so `fieldContract.test.ts` will move.** That is the machinery working. It must be answered with an exception carrying a reason and Daniel's citation — **never by deleting the assertion.**

## 6 · What leg 3 still owes Daniel before it can finish

**Rulings:** `CHANGEALL-NAALIAS` · `CHANGEALL-METHODDOCTRINE` · `BOXBAND-DOCTRINE` · `BOXBAND-DUPKEY`'s band identity · the library's absent Tab order · **CABLE-TAB-BUNDLE-METHOD (§3, new)** · and two his boxes-and-bundles ruling created: the **bundle `name`** exclusion has no citation and no operator sentence (the exception says so of itself), and **`in_box`** is the one box field Find cannot reach.

**Unrun:** the FINDPARITY-UNTYPED browser sweep (`drafts/260908-1649_…_sweep-checklist.md`) — put to him 2026-09-08, **declined for now and still owed.**
