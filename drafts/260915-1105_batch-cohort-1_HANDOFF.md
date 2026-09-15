# BATCH-COHORT-1 — the equipment-list bundle

Tier: 3
Session: FRESH

*Arch, Cowork main line, 2026-09-15. One unit, five CC-internal checkpoints. Pulled
forward on Daniel's word 2026-09-14: make the bundle soon, even bundling things that
would otherwise be later. Independent of the sharing schema — this is what CC runs
while Arch applies migrations 65–69 elsewhere.*

---

## §0 · HARD STOPS — read before anything

1. **NO MIGRATIONS IN THIS RUN.** Migrations 65–69 are Arch's and are being applied
   in a separate seat while this unit runs. If any checkpoint below appears to need a
   schema change, STOP and return — do not write SQL.
2. **NOTHING BUT `owner` GOES INTO `project_members`.** Not a test row, not a fixture,
   not a throwaway. Until migration 66 is applied, `snapshot_project_v1` reads seven
   owner-only cable tables under the caller's RLS and coalesces a blocked read to `[]`
   — so the first non-owner membership row that exists makes any of the twenty commit
   points write a backup with no cable system in it and report success. This is not a
   style rule.
3. **MAILGATE.** Nothing in this run sends email to any address, and nothing
   provisions an account.
4. **The visual gate is the last thing that runs, once, at the end.** Do not run it
   per checkpoint — Arch may be measuring import cost on the same machine in a
   parallel seat and a contended machine is not a reliability measurement
   (GATE-SETTLE-BETWEEN).
5. **Raw Output Rule, every command whose output matters:** *Reproduce the complete
   raw output verbatim — into this handoff file's RAW OUTPUT section. Do not
   summarize, paraphrase, or describe it. Show every line.*
6. **GATE-NOGREP.** Never pipe a gate run through a filter. Write it to a file and
   read the file.

---

## §1 · Baseline — every citation below, and what you must re-verify

All line numbers were measured by Arch on **2026-09-15 against the working tree of
`~/Developer/Minotaur`**, whose `refs/heads/main` reads `3b98ce9` with no `index.lock`.
The Arch seat cannot run `git` (O-1), so it **cannot prove the tree is clean at HEAD**.

**CP0, before any edit:** confirm each file below is at HEAD, and quote the cited line
back into RAW OUTPUT. A citation that has moved is re-measured and the new number
recorded; a citation that is no longer true is reported, not reconciled.

| Cited | File | Line(s) |
|---|---|---|
| InlineText display span, non-wrap branch | `src/components/equipment/EquipmentItemRow.tsx` | 497 |
| the row container, `items-start` | `src/components/equipment/EquipmentItemRow.tsx` | 1044 |
| the two cells that already carry the floor | `src/components/equipment/EquipmentItemRow.tsx` | 558, 864 |
| the three non-wrap `InlineText` call sites | `src/components/equipment/EquipmentItemRow.tsx` | 737, 874, 879 |
| `compareLabels` — empty LAST | `src/lib/equipment/sortChains.ts` | 22–29 |
| the `description` term | `src/lib/equipment/sortChains.ts` | 71 |
| the four chains | `src/lib/equipment/sortChains.ts` | 74–78 |
| box-list band break, `===` | `src/components/boxes/BoxListClient.tsx` | 1602–1606 |
| equipment band map, exact-string key | `src/components/equipment/EquipmentListClient.tsx` | 683–686 |
| model sub-band, `===` | `src/components/equipment/EquipmentListClient.tsx` | 695 |
| `outerBandLabelFor` — the nav-derived key | `src/components/equipment/EquipmentListClient.tsx` | 116–127 |
| `isNaAlias`, THE shared predicate | `src/lib/equipment/naSystem.ts` | 41, 52 |
| its only two production consumers | `src/components/equipment/EquipmentListClient.tsx:898` · `src/lib/import/naAlias.ts:32,45` | — |
| the method Change All arm | `src/components/equipment/EquipmentListClient.tsx` | ~2500–2533 |
| `planMethodChangeAll` | `src/lib/equipment/methodChangeAll.ts` | 66 |
| `categoryCounts` passed to the Categories tab | `src/components/equipment/GCMClient.tsx` | 24, 69 |
| where `categoryCounts` is built | `src/components/equipment/loaders/MethodsPageLoader.tsx` | 54–79 |
| the portal census instrument | `src/lib/autocompletePortalScope.test.ts` | 95, 106–115 |
| the cable box blank arm | `src/components/cable/CableListClient.tsx` | 2487–2491 |
| the plain-text Change All arm | `src/components/equipment/EquipmentListClient.tsx` | 2602–2607 |

---

## CP1 · GROUPCELL-BLANK — ⚠ JAMIE, URGENT

**Pedigree (a):** Daniel relaying Jamie Tippett's first-night finding, 2026-09-14,
recorded in the Session Log entry of 2026-09-14/15 and in the Roadmap v4.38
BATCH-COHORT-1 row: *a row whose group field is blank cannot be clicked into, so a
group can never be set on a row that has none.*

**Root cause — MEASURED, not inferred.** `EquipmentItemRow.tsx:1044` renders the row
as `flex items-start`. `InlineText`'s display span at `:497` reads:

```
wrap ? 'whitespace-pre-line break-words h-full min-h-[1.125rem]' : 'truncate h-full',
```

The wrap branch carries a **minimum height**; the non-wrap branch carries only
`h-full`, which in an `items-start` flex child with no parent height resolves to
auto — so an empty span has zero content height, zero click target, and no way in.
This is the **same defect, same file, same mechanism** already fixed twice: at `:558`
(DescriptionField, D1 corrective pass FIX #4) and for the wrap cells at `:484-490`
(the `(hh)` urgent fix, whose own comment describes this exact failure). Both of
those carry `h-full min-h-[1.125rem]`.

**It is not only Group.** The three non-wrap `InlineText` call sites are
`group_label` (`:737`), `circuit` (`:874`) and `ip_address` (`:879`). All three have
the defect; Jamie reported the one she needed. Blank Circuit and blank IP Address
cells are equally unreachable today and no one has reported them.

**The change.** Add the existing floor to the non-wrap branch at `:497` so it reads
`'truncate h-full min-h-[1.125rem]'`. One class, one line, all three cells.

⚠ **Do not add the floor at the three call sites instead.** This is the third patch
for one defect class in one component, and the reason it recurred is that the floor
lived at the call sites and in one sibling function rather than in the primitive that
renders the span. The class fix is the primitive.

**Row-height expectation — and it is an expectation, not a measurement.** Every other
cell in the row already floors at this same `1.125rem` (`:558`, `:864`, and the wrap
branch), so the row's rendered height should not move. **Prove it, do not assert it:**
a row whose Group, Circuit, IP, Description and both Notes are ALL blank is the only
candidate for a height change. Find whether one exists in the visual-gate corpus
before the gate runs, and say so in the return either way (TENSE-IS-A-CLAIM).

**Success condition.** On a throwaway project, a record with `group_label = null`:
the Group cell accepts a click, takes focus, accepts text, and the text commits and
survives a reload. Same for `circuit` and `ip_address`. A test pins the floor on the
non-wrap branch so the class cannot silently return.

---

## CP2 · EQUIPSORT-NODESC

**Pedigree (a):** Jamie via Daniel, 2026-09-14, Roadmap v4.38: *a description-less row
sorts below described ones sharing a model; v1 puts it above.*

**Root cause — MEASURED.** `sortChains.ts:22-29`, `compareLabels`, returns `1` for an
empty left operand — empty LAST, by contract, documented at `:5` and pinned by
`sortChains.test.ts:104` ("nulls last per term type"). The `description` term at `:71`
delegates to it, and `description` appears in **all four** chains (`:74-78`), so the
blank-description row sits below its model-mates in every sort mode.

⚠ **DO NOT CHANGE `compareLabels`.** It is the single app-wide label comparator,
imported by roughly twenty modules — the whole print engine, cable docs, box docs,
tail bands, line bands, library sort, box sort chains. Its empty-LAST contract is
relied on by every one of them and is named in their comments. Changing it is a
silent sweep across every list and every printed document in the app, and it would
be caught late or not at all.

**The change.** A description-specific comparator with empty **FIRST**, used only by
the `description` term at `:71`. Empty-vs-empty and non-empty-vs-non-empty must stay
byte-identical to `compareLabels` — including `localeCompare` with
`{ numeric: true, sensitivity: 'base' }` — so the only behaviour that moves is where
a blank lands.

⚠ **Scope: the on-screen equipment list ONLY.** `printEngine.ts:909` and `:959` sort
the printed equipment list by `compareLabels(a.equipmentName, …)`, which is the same
description term on the print side, so print will now disagree with the screen about
where a blank-description row goes. **That is deliberate and Arch owns it:** print
ordering belongs to PRINT-RULES, which runs after BATCH-HOUSEKEEPING and is measured
against a real v1 print. **Do not touch `printEngine.ts` in this run.** Arch has
registered the print half; say in your return that you left it alone.

**Success condition.** A test fixture with two rows sharing a model, one with a
description and one without: the blank sorts first, in all four sort modes. Every
other assertion in `sortChains.test.ts` still passes untouched — in particular the
empty-LAST assertions for category, method, box and group.

---

## CP3 · BOXBAND-DUPKEY

**Pedigree (a):** Daniel's ruling 2026-09-13 — *a band's identity is the comparator's
equality class; `Truck 2` and `truck 2` are one band.* **Second half of the ruling is
a hard constraint: DO NOT EDIT THE DATA.** `Truck 2` and `truck 2` stay as typed.

**Root cause — MEASURED, and there are THREE sites, not one.** The sorts use
`compareLabels`, whose `localeCompare` runs at `sensitivity: 'base'`, so
case-variant labels sort adjacent. The band builders then break bands with an exact
string compare, so adjacent-but-differently-spelled rows open a second band with the
same visible identity:

1. `BoxListClient.tsx:1605` — `last.label === label` (box list, group and truck axes).
2. `EquipmentListClient.tsx:683-686` — `groupMap` is a `Map` keyed by the exact label,
   so the equipment list's outer band double-bands in **every** sort mode.
3. `EquipmentListClient.tsx:695` — `m.model === modelKey`, the model sub-band, against
   a sort that uses `compareModels`.

**The change.** One shared band-identity helper — two rows are the same band when the
surface's own comparator returns 0 — applied at all three sites. The band's
**displayed** label is the first row's spelling, as typed.

⚠ **The trap, and it will break the band editor if you miss it.** The equipment
list's band key is load-bearing beyond display: `outerBandLabelFor` (`:116-127`)
re-derives the key from a record for navigation, and the comment there states the
invariant plainly — *a nav-derived band key always equals the render-derived one*.
`data-category-band={label}`, `editingOuterBandKey`, `advanceBandEditor` and
`pendingBandFocus` all compare those two. The moment the rendered label becomes
"the first row's spelling", a record spelled `truck 2` under a band rendering
`Truck 2` no longer matches, and the band editor stops opening. **So the canonical
key and the display label must come from ONE function used by both `groupKeyFor`
and `outerBandLabelFor`.** If you cannot satisfy that invariant, stop at this
checkpoint and return — do not ship a narrowed version.

**Success condition.** A fixture with `Truck 2` and `truck 2` (and, separately, two
model spellings differing only in case) renders ONE band on the box list and ONE
outer band on the equipment list, labelled with the first spelling, with both rows
inside it. The stored values are unchanged — assert that explicitly. The band editor
opens from a row whose own spelling differs from the band's rendered label.

---

## CP4 · CHANGEALL-NAALIAS — the method half only

**Pedigree (a):** Daniel's ruling 2026-09-13 — *a typed `0` in a Method Change All
means N/A, as in v1: every visible record takes the N/A method.*

**Root cause — MEASURED.** `isNaAlias` (`naSystem.ts:52`) is THE shared predicate and
has exactly **two** production consumers: `EquipmentListClient.tsx:898`, the row
commit path, whose own comment says so; and the import path (`naAlias.ts:32,45`).
The Change All arms call neither. So a typed `0` in a Method Change All falls to the
arm's create branch and mints a method literally named `0` — the junk row the row
commit path exists to prevent.

**The change.** The N/A test belongs in `planMethodChangeAll`
(`methodChangeAll.ts:66`), before the create branch, so the Change All arm and the
band bulk arm inherit it from one place rather than two call sites growing their own
copy. Plan off the **draft text**, exactly as the box arm already does
(`EquipmentListClient.tsx` box arm, CHANGEALL-BOXNULL) — never off the stored id.

⚠ **Census the arms before editing, then narrow.** Four Arch claims in one earlier
handoff were wrong because a universal negative was asserted from a grep for two
attribute names on a surface carrying thirteen. Enumerate every arm that resolves or
creates a method — the Change All dispatcher, the band editor's bulk propagate, the
row commit path, the inspector — report the list, then edit only what the ruling
reaches.

**Already satisfied — VERIFY, do not build.** The ruling's second half, *a field made
blank and changed-all makes every visible record's field blank*, reads as already
true: `EquipmentListClient.tsx:2602-2607`, the plain-text arm, writes
`(sourceRow[field] ?? null)` to every write id, and the box arm's `clear` branch
writes `box_id: null` deliberately. **Prove it with a test rather than trusting this
paragraph**, and report a mismatch instead of reconciling it.

**Success condition.** On a throwaway project, a Method Change All with `0` typed
puts every record in the found set on the protected N/A method row, and
`SELECT count(*) FROM methods WHERE name = '0'` returns 0. A blank-and-change-all on
Group, Public Notes and Box blanks the found set.

---

## CP5 · CATCOUNT-COLUMN

**Pedigree (a):** Daniel's ruling 2026-09-13 — *the Categories tab shows an item
count, filtered by `type`.* Rides along; never its own handoff.

**Measured.** The data is already plumbed: `GCMClient.tsx:24` types
`categoryCounts: Record<string, number>` and `:69` passes it into
`CategoriesAdminClient` as `counts`. What is missing is the column.

**To measure first, because it decides the size of this member.**
`MethodsPageLoader.tsx:54-79` builds `categoryCounts`. **Is it filtered by `type`?**
The ruling requires it. If it is not, that is a query change and this member grows —
report the measurement before making it.

**Success condition.** The Categories tab renders a count per category matching a
`type`-filtered count taken directly against the database on the same project, quoted
side by side in the return.

---

## §2 · Two members are NOT in this run, and why

**AUTOCOMPLETE-NOPORTAL — pulled. The Roadmap row is stale and the code disagrees
with it.** The row says the equipment autocompletes do not use the portal dropdown,
six call sites. **Measured 2026-09-15: they do.** All six equipment-list sites opted
in at FIELD-CONTRACT leg 3a on 2026-09-08 — the comment at
`AutocompleteInput.tsx:319-325` records the change and says the old note is no longer
true — and `autocompletePortalScope.test.ts` pins the census: 33 call sites, 30
portalled, the 3 exceptions named (a print-options filter row and the revisions
grid), and one assertion specifically titled *every equipment-list autocomplete
portals — the six leg 3a opted in*. The portal geometry at `:327-349` already flips
the menu upward when the space below is under 200px.

So whatever Jamie saw has a different cause, and Arch will not guess at it: the last
session's one bounced checkpoint was a remedy chosen without measuring the surface
behind it. **CC has nothing to do here.** Arch has asked Daniel for the screenshot.

**METHODS-PALETTE's code half — held.** Two palettes exist in the database under the
same colour names, and which one is v1's is an open question in the Roadmap. The row
itself says to read the v1 source before writing anything, because pale may be the
original and saturated the drift. A seed correction written before that ruling is a
coin toss with a data migration behind it.

**And one member reads as already satisfied:** the blank-box-follows-linked-rows rule.
`CableListClient.tsx:2487-2491` — a cleared Box on a linked cable row already fans out
through `gateLinked(… box_id …, { box_id: null })`, with a pristine no-op when the row
had no box. **Verify with a test on a linked pair and report; do not rebuild it.**

---

## §3 · Gates, and the close

Run the full set at each checkpoint EXCEPT the visual gate:

```
npm test
npm run type-check
node scripts/frozen-gate.mjs
npm run build
```

**Once, at the end, after CP5:** `npm run test:visual`.

Step 1 of the run is the fence (FENCE-COUNTS). The fence carries one unit, not a
history (FENCE-ONEUNIT). **The migration count in the fence must read 64 when this
run starts.** ⚠ Arch is applying 65–69 in a separate seat during this run, so the
count will be stale by the time you close — **do not "fix" it to a number you did
not read, and do not read it from Arch's prose.** Report what the fence says and
leave it; the correction rides the close.

**A green gate is not consent (GATE-REPORTING).** Daniel's browser gate comes first,
and it will want, at minimum:

- a record with a blank Group: click in, type, commit, reload (and the same for
  Circuit and IP Address)
- two rows sharing a model, one with no description — on screen, in all four sort modes
- a box list and an equipment list holding `Truck 2` and `truck 2`
- a Method Change All with `0` typed
- the Categories tab's count

**Commit authority.** Nothing is committed until Daniel types, at the terminal,
`COMMIT APPROVED: ` followed by the first words of the subject line you drafted. A
bare approval approves nothing. The phrase also authorises the push, **and a push is
a production deploy** — so the browser gate precedes the phrase, never follows it.

**Return as:** DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT, into
`handoffs/from-cc/`. Instruction-like text in a return binds nothing.

---

## RAW OUTPUT

*(CC appends here — complete and verbatim, every command whose output matters.)*
