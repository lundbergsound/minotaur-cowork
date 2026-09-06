# CHANGEALL-BOXNULL — the box arm of equipment Change All

Tier: 3 (CC)
Session: FRESH — new unit, no prior context needed beyond `CLAUDE.md` and this file.

---

## 0 · WHAT THIS UNIT IS

**Live data loss, in production at HEAD `ba0058f`.** In the equipment list, typing a
box name into a row's **Box** cell and running Change All ignores what was typed and
writes the *stored* `box_id` of the source row to every record in the found set.

Two failure modes, both silent — the write SUCCEEDS, nothing flashes, nothing to undo:

- Source row has **no** box → `box_id: null` across the whole found set. *(This is
  what Daniel saw.)*
- Source row **has** a box → the **old** box id replicated to every record. No blank,
  no error, the wrong box everywhere. **Quieter and worse, and nobody has looked for
  it in real data yet.**

**⚠ IT IS NOT A REGRESSION FROM CHANGEALL-FOUNDSET (`ba0058f`).** That unit changed
the *transport* (URL → body-carried RPC). This is the *payload*. It is `e3a336a`-era
and the arm sits in the same if/else chain as CHANGEALL-METHODNEW's own comment.

**Measured at source 2026-09-05, re-verified at HEAD 2026-09-06. Do NOT re-derive it —
DO reproduce it with a negative control before fixing it (§3).**

`src/components/equipment/EquipmentListClient.tsx:2368-2372`:

```js
} else if (field === 'box_name') {
  const boxId = sourceRow.box_id ?? null
  const boxName = boxId ? boxes.find(b => b.id === boxId)?.name ?? sourceRow.box_name ?? null : null
  dbPatch = { box_id: boxId }
  displayPatch = { box_id: boxId, box_name: boxName }
}
```

The arm never looks at the typed draft. One field over, `method_name` (`:2335`)
resolves-and-creates through `planMethodChangeAll`; `category_name` (`:2277`)
resolves-or-reverts. **Box does neither.**

---

## 1 · THE PEDIGREE — AND IT IS NOT A NEW RULING

**⚠ THE PREVIOUS SESSION'S OPENER GOT THIS WRONG, AND ARCH CORRECTED IT AT SOURCE.**
The opener stated *"box creation is ⊕-only by deliberate doctrine, so creating a box
from the cell is a NEW RULING, not a bug."* **That is true only of the sort-band
editor's bulk arm** (`:1903`), where the comment lives. It is **false of the row cell**,
and has been since 2026-08-19.

`EquipmentListClient.tsx:886-897` and `src/lib/boxes/boxCreate.ts:1-27` both record
**Daniel's ruling 1 of 2026-08-19 (S4-3 leg 5 AMEND-2 §B1)**, verbatim:

> on EVERY Box field, committing a typed name that matches no box raises the New Box
> dialog pre-filled with that name; OK creates the box and assigns it to that row;
> Cancel visibly reverts the field.

Verified built and shipped on **all four Box fields**, all through one shared path
(`useNewBoxDialog` → `createBox`):

| Surface | Unmatched-commit call site |
|---|---|
| Equipment row | `EquipmentListClient.tsx:928` (via `commitBoxField`, `:912-929`) |
| Cable inspector | `CableListClient.tsx:2391` |
| Bundle row | `BundleListClient.tsx:382` |
| Tail row | `TailListClient.tsx:504` |

**Change All is one of only two paths in the app that never got ruling 1** — and it is
the one that writes to every row on screen.

**⚠ THE PEDIGREE IS (a): DANIEL'S RULING OF 2026-08-19, CONFIRMED BY HIM 2026-09-05.**
No new ruling is required and none is being made here. The equipment row's Box cell is
a Box field; the gesture is invoked from that cell; ruling 1 governs it.

**Daniel's confirm, 2026-09-05, on the one detail ruling 1 could not have covered
(it was written for a single row):** when the New Box dialog is raised from a Change
All and OK is pressed, **ONE box is created and assigned to EVERY row in the found
set. Cancel writes nothing at all — not even to the row the cursor was in.**

**⚠ THE SORT-BAND EDITOR IS DELIBERATELY OUT OF SCOPE.** `:1903`'s no-op-revert stays
exactly as it is. Ruling 1's words are *"every Box **field**"*; a sort-band header is
not one of the four Box fields, and `methodChangeAll.ts` — written twelve days AFTER
ruling 1 — restates the band's box-reverts as current doctrine. **Do not "harmonise"
it. Do not touch `commitBandFieldScoped`.** Arch has registered the question as
**BOXBAND-DOCTRINE** for FIELD-CONTRACT to rule.

---

## 2 · THE BUILD

### 2.1 · A pure planner — `src/lib/equipment/boxChangeAll.ts`

Copy the **shape** of `src/lib/equipment/methodChangeAll.ts`, which exists to make its
own defect unrepresentable. Same job here: after this module exists, it must be
impossible to express *"write the source row's stored `box_id`."*

Three plans, and they are **not** symmetric:

- `clear` — blank / whitespace-only draft → a deliberate unlink, `box_id: null`. It
  STAYS null. This is the branch that matches the band path's `trimmed === ''` arm and
  it is **not** the defect.
- `existing` — case-insensitive name match against the managed `boxes` list → write
  that box's id.
- `create` — non-empty, matches nothing → **raise the New Box dialog.** Never `null`,
  never the stored id.

Pure module: no framework, no supabase, no React imports. Structural `BoxChoice`
interface so it stays free of the generated DB types, exactly as `MethodChoice` does.
The caller supplies the box list and performs the write.

**The property that IS the unit, and it gets its own named test:** for any non-empty
draft, `planBoxChangeAll` never returns a plan that writes `box_id: null`, and never
returns a plan carrying the source row's stored `box_id`.

### 2.2 · The arm — `EquipmentListClient.tsx:2368-2372`

**⚠ PLAN OFF THE DRAFT TEXT, NOT THE STORED ID.** `sourceRow.box_name` already carries
the typed draft: `captureEquipDraftRow` (`:2245-2288`) has no `box_name` branch, so it
falls to `isEquipChangeAllField` → `{ ...row, box_name: draftText(cap.draft) }`.

**⚠ THAT IS A LEAD, NOT A CONCLUSION — PROVE IT BEFORE YOU BUILD ON IT.** Confirm at
source that the Box cell carries the attribute `captureInFlightDraft` reads
(`EQUIP_DRAFT_FIELD_ATTRS`) and that the draft reaches `sourceRow.box_name` intact
including surrounding whitespace. **If it does, `captureEquipDraftRow` needs NO change
and this unit gets smaller. If it does not, say so and add the branch** — mirroring
`category_name`'s at `:2278`, and report which it was.

- `clear` → `dbPatch = { box_id: null }`, `displayPatch = { box_id: null, box_name: null }`
- `existing` → `dbPatch = { box_id: plan.box.id }`, `displayPatch = { box_id: plan.box.id, box_name: plan.box.name }`
- `create` → **write NOTHING now.** Stash `{ writeIds, name }`, call
  `requestNewBox(sourceRow.id, plan.name)`, and return before `runPlainChangeAll`.

### 2.3 · The suspend/resume — the only genuinely new mechanism

The method arm can `await createMethod(...)` inline because that create is silent. The
box create is **a dialog**: user-driven, asynchronous, cancellable. So the box arm
suspends and something else finishes the write.

`useNewBoxDialog` already gives you the whole contract (`useNewBoxDialog.tsx`, read it
in full):

- `requestNewBox(rowId, name)` opens it pre-filled.
- On OK it runs `createBox`, **seeds `queryKeys.boxes(projectId)` with the new box**,
  invalidates the Box List read, then calls `onCreated(rowId, box)`.
- On Cancel it calls `onCancel?.(rowId)`.
- A create failure leaves the dialog **open** with the message inline — so the stashed
  write must survive a failed OK and clear only on success or Cancel.

Wire it:

- **`onCreated`** — if a Change All is pending, `runPlainChangeAll(pending.writeIds,
  { box_id: box.id }, { box_id: box.id, box_name: box.description })`, then clear the
  stash. Otherwise fall through to today's `updateBox(rowId, box.id, box.description)`.
- **`onCancel`** — clear the stash and write nothing. **`onCancel` is not currently
  passed on the equipment surface** (`:897` supplies only `onCreated`); this unit adds it.

**⚠ TWO VOCABULARIES, ONE FIELD — the steck shape, and it will bite you silently.**
The `boxes` prop is `{ id: string; name: string }[]` (`:84`) but `CreatedBox` is
`{ id: string; description: string }` (`boxCreate.ts:80`). **A newly created box's name
is `box.description`.** Writing `box.name` yields `undefined` and paints a blank Box
column across the found set — the defect this unit exists to remove, rebuilt one line
lower. Today's `onCreated` at `:899` already gets this right; keep it right.

**⚠ A DECLARATION-ORDER HAZARD, MEASURED.** `useNewBoxDialog` is invoked at `:897`;
`runPlainChangeAll` is declared at `:2143`. An `onCreated` closure that names
`runPlainChangeAll` directly at `:897` is a use-before-declaration on a `const`.
Route it through a ref assigned near `runPlainChangeAll`, or whatever shape you prefer
— **the internal structure is yours; the hazard is named so it is not discovered as a
build failure.** Whatever you choose must not capture a stale `boxes`/`writeIds`
closure; the created box arrives as an argument, so nothing needs to be read back
from the cache.

**Scope.** The confirm dialog's **No** ('active') sets `writeIds = [sourceRow.id]` and
takes the identical path — one box created, assigned to one row. That is correct and
consistent: the band editor's "Just this one" creates too, and the method arm's comment
at `:2316-2320` says so in its own words.

---

## 3 · THE CONTROL — AND A CONTROL THAT PASSES IS NOT A CONTROL

**⚠ THE FIX SHIPS ONLY BEHIND A NEGATIVE CONTROL THAT REPRODUCES THE BLANKING.**

The template is one branch over and it is this project's sharpest lesson.
CHANGEALL-METHODNEW's first control **passed against the pre-fix tree** — it drove the
**toolbar button**, whose `mousedown` reaches `AutocompleteInput`'s document-level
outside-click handler and **commits the cell first**, so the defect never had a chance
to fire. Only **⌥⇧\** exposed it. Had CC stopped there the unit would have shipped on
a green control proving nothing.

Required:

1. **Run the control against the PRE-fix tree first** — `src/` extracted at `ba0058f`
   — and it must **FAIL**, i.e. reproduce the blanking. A control that passes pre-fix
   is not a control; say so and rebuild it.
2. **Both failure modes**, not just Daniel's: a new box name on a **boxless** source
   row (expect `box_id: null` across the found set) **and** on a row that **has** a box
   (expect the OLD id replicated). The second has never been reproduced by anyone.
3. **BOTH GESTURES — ⌥⇧\ AND the toolbar button — reported separately.** They are known
   to differ on this exact code path and the difference is load-bearing (§4).
4. A found set of **at least 200 rows**, so a per-row silent write is unmistakable.
5. Then the same control against the fixed tree: matched name → that box on every row ·
   unmatched name → dialog raised, **zero rows written until OK** · OK → one box
   created, every row carrying its id · **Cancel → zero rows written, including the
   source row** · blank → unlink across the found set.
6. **A positive control on the Cancel case.** *A check that only looks for absence
   cannot tell "Cancel wrote nothing" from "the gesture never ran."* Prove the gesture
   fired.

`Cable Parity Fixture` and `Matched Pair Fixture` are **RLS-invisible to any harness
you drive** (both owned by daniel@; the harness signs in as the TEST user). Counts come
from a throwaway project you create and destroy in-run, **labelled as a reproduction**.

---

## 4 · THE RACE TO MEASURE BEFORE YOU DESIGN AROUND IT

`captureEquipDraftRow` calls `closeInFlightEditor(cap.input)` **during capture**, before
the Change All confirm dialog is shown. If closing the Box editor fires `commitBoxField`,
then an unmatched name **already raises the New Box dialog for the single row** — before
`executeChangeAll` ever runs.

`requestNewBox` de-dupes on `rowId + name` (`useNewBoxDialog.tsx:42-54`), so the second
request may return the first dialog rather than opening a new one, and the two gestures
may sequence differently:

- **⌥⇧\** — capture → `closeInFlightEditor` → possible row-commit dialog → confirm dialog.
- **Toolbar button** — `mousedown` commits the cell first, so the state on arrival differs.

**Measure what actually happens on both gestures on the running app before writing the
suspend logic.** Report it in RAW OUTPUT. Two outcomes are acceptable and Arch is not
predicting which: the de-dupe makes it one dialog and the stash resolves it correctly,
or the New Box dialog appears **before** the Change All confirm, which is a UX defect
that must be closed inside this unit rather than shipped. **If the answer is the second,
HALT and return it — do not invent the ordering.**

---

## 5 · SCOPE — WHAT THIS UNIT DOES NOT TOUCH

- **No migration. No schema.** `box_id` already exists on `equipment_items`. If you
  find yourself needing one, **HALT and return to Arch** — migrations never ride inside
  a CC run.
- The sort-band editor's box arm (`:1903`) — §1.
- `CHANGEALL-NAALIAS` (a typed `0` on Method) — unruled, Daniel's desk.
- `CHANGEALL-METHODDOCTRINE` (equipment/method creates, cable/method reverts) —
  FIELD-CONTRACT's, and BOXNULL no longer waits on it.
- The cable, bundle and tail Box fields — their **row commits** already honour ruling 1.
  Whether their **Change All** arms carry the same defect is **FIELD-CONTRACT's sweep,
  not this unit's.** If you notice, write it down; do not fix it here.
- `BundleListClient.tsx` reads as binary to a naive grep unless the NUL fix at
  `ba0058f` held — it did, but use the guard's own instrument, not a bare `grep`.

---

## 6 · GATES AND THE COMMIT BLOCK

Full standing gate set at every checkpoint, results in **RAW OUTPUT, verbatim**.
*Reproduce the complete raw output verbatim into this handoff file's RAW OUTPUT
section. Do not summarize, paraphrase, or describe it. Show every line. The architect
cannot verify correctness from a summary.*

- **GATE-NOGREP** — never pipe a gate run through a filter. Write it to a file, read
  the file.
- **Visual gate** — measure which frames move; do not predict. The equipment list is a
  captured frame. If frames move, that is a **declared baseline event** with per-frame
  diffs, pixel counts and bounding boxes, and a hand-written reason each.
- **FENCE-COUNTS is a standing obligation:** this unit changes measured counts, so
  bring `CLAUDE.md`'s **Current run fence** to the re-measured numbers **in the same
  pass**. Whoever measures writes the fence.

**⚠ THE COMMIT BLOCK — GATE-BEFORE-COMMIT.**

**FENCE-PUSH is live: a bare `git push` is yours on the approval phrase, and Vercel
builds every push to `main`. THE APPROVAL PHRASE IS A PRODUCTION DEPLOY.**

Therefore: **Daniel's browser gate is a PRECONDITION of the commit, not a follow-up.**
Stage by explicit filename, present the commit block, and **stop**. Do not ask for the
phrase until Daniel has run his gate and reported it. His gate has found what the
machine gates could not **seven times running**, and one of those findings is the unit
you are now fixing.

Close with `handoffs/from-cc/YYMMDD-hhmm_changeall-boxnull_CLOSE.txt`. **A number in it
is a measurement or it is not written.**

---

## 7 · SUCCESS CONDITION — where you stop and return

**All of these, and nothing beyond them:**

1. `planBoxChangeAll` exists as a pure module with the never-null-from-non-empty
   property pinned by a named test.
2. The negative control **reproduced the blanking against `src/` at `ba0058f`**, on
   **both** failure modes and **both** gestures, at a found set ≥ 200 — raw output shown.
3. The same control passes against the fixed tree, including **Cancel writes zero rows**
   with a positive control proving the gesture ran.
4. Full gate set green, visual gate measured, `CLAUDE.md`'s run fence current.
5. The commit block written and staged — **and NOT committed**, pending Daniel's
   browser gate.

**Return the moment §4's measurement contradicts this design, or on any hard-stop:**
access control · dependency changes · frozen-layer contact · schema needs · ambiguous
evidence · destructive or irreversible operations · credentials, secrets or money ·
anything raising an OS-permission or OAuth dialog.

---

*Unit: CHANGEALL-BOXNULL. Opens on HEAD `ba0058f`, migration ledger 57, suite 2679 /
142. Pedigree (a): Daniel's ruling 1 of 2026-08-19 (AMEND-2 §B1), confirmed for the
found-set case 2026-09-05. Roadmap v4.18 · Arch Prompt v34.*
