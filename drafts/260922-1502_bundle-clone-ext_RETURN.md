# 260922-1502 · BUNDLE-CLONE-EXT · RETURN

*Arch parallel, opened from the main line 2026-09-22. Architecture Prompt v39. Design only — no CC handoff, no
schema change, no SQL write, no governing-document edit, nothing written to the code repo, no git run.
Scope: cloning a bundle and extending a bundle (the restored D-2b).*

**Seat: passes.** All three mounts reachable. Code `d25d366` = `origin/main`, read from `.git/refs/`. No
orphaned `index.lock`. Migration ledger **83**, live-read. `supabase/migrations/` 22 files.

---

## Where this lands, in one paragraph

The design is **closed, not blocked** — and it closed for a reason nobody expected. The four v1 behaviours the
opener called missing are not missing. Three of them have been sitting in the repo since August as
`d2b_01`, `d2b_02` and `d2b_03`, uncited by anything; the fourth has its full wording in the script corpus,
so a photograph of it would buy nothing. Better: the script that actually builds a bundle extension — the
half of this row Will asked for — turned out to be in the corpus too, in full, and no one had opened it.
So the evidence errand I was sent to write is not the six-frame errand in the Ledger. It is **one gesture,
three frames, ten minutes**, and it is about extending a bundle, not cloning one.

The second finding is that **the linkage schema needs no migration at all.** Not a small one — none. The
database already allows bundle link groups, the membership table already accepts a bundle's id, the index is
already there and the security policies already cover it. The Trigger B this row has carried since the August
Sprint-4 map can be struck. That was measured live today, not inferred.

What is left for you is six choices I made without evidence, numbered so you can strike any of them by number,
and eight one-word rulings.

---

## ⚠ Three corrections before the design

**1. Three of the six "missing" frames are already banked, and nothing cites them.**

I opened the three uncited image files in `docs/reference/evidence/cable/` (committed `3ffd371`, August 5) and
looked at them:

| File | What it actually is | v1 script |
|---|---|---|
| `d2b_01.png` | **"Enter Clone Bundle Name"** — Bundle List behind it, one *Bundle Name:* input seeded `A2: The Sequel`, Cancel / OK | 441 |
| `d2b_02.png` | **"Add Cable to Cloned Bundles?"** — Cable list behind it, Cancel / OK | 704 |
| `d2b_03.png` | **"Update Cloned Bundles?"** — Cancel / **Leave** / **Delete** | 225 |

The recon at `docs/reference/evidence/cable/d2b_clone_bundle_recon.md` §5 states these have "no screenshot
anywhere" and says it confirmed that by listing the directory. The files are in that directory. This is the
same shape of error the recon itself corrected earlier about the Tails?/Lines? frames — a premise about
absence that nobody re-checked.

`d2b_03` is also mis-filed in our own record. The Ledger calls the outstanding frames "the four s504
Delete-Cable-with-Clones confirm variants" and elsewhere "the residual s504 delete-variant frames (3 of 4)",
implying one of the four is banked. None of the four is. `d2b_03` is a **different and earlier dialog** —
script 225 *Delete Mult Button*, the gate that asks whether to touch the clones **before** 504 runs. Its
three buttons set what 504 then branches on.

**2. The bundle Duplicate button's tooltip contradicts the code it sits on.**

`BundleRow.tsx:436` renders `title="Duplicate this bundle (members never ride — D2-R9)"`. Members do ride:
`BundleListClient.tsx:529` runs the two-phase ride over every member, and `bundleList.ts:135` says so in its
own comment — *"Members now RIDE via duplicateBundleWithMembers (AMEND-2 B2 — supersedes born-empty)."*
D2-R9 is the ruling that a duplicate is born unbundled/unpacked/untested, which is a different thing. A stale
tooltip, not a defect — but it is the sentence a future session would read first.

**3. The main line's parallel openers are stamped ~3h16m ahead of the clock.**

`260922-1735_bundle-clone-ext_PARALLEL-OPENER.md` was last written at **14:19 EDT** today; its sibling
`…_defaults_…` likewise. The `260922-1237_…_TO-MAINLINE.md` file, by contrast, was written at 12:40 — three
minutes off its own name, which is what PARALLEL-CLOCK expects. So the clock is fine and two filenames are
wrong. This return is stamped from the real clock, which makes it sort **before** its own opener. Worth one
line in the close so the stamping is fixed at source rather than each parallel guessing.

---

## The evidence request — one gesture, three frames

This replaces the six-item errand in the Ledger.

Everything the **clone** half needs is now in hand. What is not in hand is the naming chrome of the
**extension** half — and all of it comes from one continuous ride.

> **The gesture, once, in a live v1 session:** open a show whose bundle has **both a mult and a plain cable in
> it** (A2 in `d2b_01`/`d2b_02` is exactly such a bundle). On the **Bundle List**, with that bundle's row
> selected, press the **Add Extension** control. Then screenshot every dialog that appears, in order, without
> dismissing anything until you have shot it. There will be three, and you can Cancel out of the last one —
> nothing is written until you finish.

| # | Frame you will see | Why a photograph settles it | Script |
|---|---|---|---|
| 1 | **"Add Extension - Get Length"** — the length prompt | This is the **only one of the three whose text we do not have.** Its script (id 298) is named in the corpus index but was never extracted — it is one of 200 scripts outside the cable/box allowlist. So we have no idea what it says, what it seeds, or whether it carries a unit. Everything else in this ride is verbatim in hand. | 298 |
| 2 | **"Enter Bundle Prefix and Suffix"** — *"How would you like to name the bundle extension? Include spaces."*, two inputs | Wording in hand; the **face** is not. Two side-by-side inputs vs. stacked changes the dialog we build. | 297 |
| 3 | **"Enter Mult Prefix and Suffix"**, then **"Enter Single Cable Prefix and Suffix"** | Same — wording in hand, face not. These fire **once each per class**, not per cable, which is why the bundle must contain both kinds for both to show. | 299, 302 |

**One check that could delete item 1 entirely.** The catalog's header names its source as
`"Minotaur v1 DDR.xml"`, generated 7/2/2026, parsed from `~/Desktop/minotaur-v1-cable-box-catalog/`. That
folder is not on this machine now (I looked). **If that XML still exists anywhere — a backup, a Dropbox
copy — script 298 is a thirty-second re-extraction rather than a live v1 session,** and worth finding before
you open FileMaker.

**What I am explicitly NOT asking for, and why.** The four `504` confirm faces — *Confirm Delete Members*,
*Confirm Delete Just Cable*, *Confirm Unallocate Members*, *Confirm Unallocate Just Cable*. Their titles,
message bodies and button labels are verbatim in the corpus, word for word. Their anatomy is the plain
two-button macOS dialog already photographed at `d2_04`. And they belong to the cable **delete** path, which
this row does not touch. They should come off the gate list rather than sit on it as "the only external gate
left in Sprint 3."

---

## The design — clone a bundle

**In plain words.** You pick a bundle, we ask what to call the copy, and you get a second bundle carrying the
same cables — linked to the first, so that later edits to a linked field on one can be offered to the other.
It is the bundle-level version of the Clone you already have on a single cable (⌥⇧G).

**The shape, read from scripts 442 → 441 → 455 → 400.**

*Phase 1 — questions only, nothing written.* **One dialog**, the name. That is the whole interactive phase.
Cloning asks nothing per member — script 441's member loop has no prompt in it. This is the one place where
Clone and Duplicate diverge sharply in feel: Duplicate interrogates you once per member (rename, tails?,
lines?), Clone asks once and goes.

- Seed the field `<original name>: The Sequel` — the same seed the existing Duplicate dialog uses, and the
  seed `d2b_01` shows on screen.
- v1 silently appends `" Copy"` if you type the original name back. We already ruled the opposite for
  Duplicate (reject in-dialog, keep the dialog open, never silently rename). Same treatment here — `bundles`
  carries a UNIQUE constraint on (project, bundle name), so a collision is a hard error either way.

*Phase 2 — the writes, in order, with full unwind on any failure.*

1. **The bundle row**, copied from the source with the new name.
2. **Enrol the new bundle row** into bundle-level link groups across **all eight** bundle fields. Script 455
   duplicates the entire link-parameter record, so every token pairs; nothing is subtracted.
3. **Per member cable:** the shipped copy shape (`buildDuplicateCopies` → `createCableFlow` — the two
   functions the bundle Duplicate ride already uses), pointed at the new bundle, then enrolled into cable-level
   link groups across **the Clone set minus `bundle_id`**. Script 441 clones each member and then immediately
   re-mints its Bundle link so the two bundles' memberships do not move in lockstep — which is exactly our
   "unlink this field" operation.
4. Failure at any point unwinds member copies then the bundle row, the existing SP-6 shape.

**Two things v1 does here that v2 has nothing to do about.**

- 441 zeroes each member's *Source Panel Label* and *Destination Panel Label*. **Those columns do not exist in
  v2** — `cable_details` has no panel-label column at all (only `tail_panel_labels`, on tails and types).
  Nothing to port.
- **Cloned members carry no tails and no lines.** Script 400 `Clone Cable` is a bare record duplicate; it has
  no tail or line loop, and 441 adds none. So in v1 a cloned bundle's mults arrive empty. This is the
  important scoping consequence: **the B6 cable-Duplicate cascade gap is not this row's to close.** The
  Ledger bundles the two, but the scripts separate them cleanly — the child-copy loops belong to *Duplicate*
  (script 390), which already has them on the bundle path. Clone never had them. See ruling **R3**.

---

## The design — extend a bundle

**In plain words.** An extension bundle is a second bundle that plugs onto the end of the first: same cables,
renamed with a prefix or suffix you choose, at a length you type, and — if your Invert Extensions default is
on — with its flagged end swapped, so the extension's flags read correctly when the two are joined end to end.
This is the thing Will asked for.

**This is where the real find is.** Script **297 `Add Extension - Bundle`** is in the corpus, complete, and
was never opened by the recon or by any handoff. It is the whole mechanism.

*Phase 1 — questions only.* Up to three dialogs, and the second and third only fire if the bundle has that
kind of member:

1. Length, plus the bundle's own prefix and suffix. *(v1 asks these as two dialogs — 298 then 297's own. B6-R6
   already ruled the equivalent pair into one dialog on the cable side; same consolidation here. See **(c2)**.)*
2. Prefix and suffix for **mult** members — asked **once**, not per cable, only if a member is a mult.
3. Prefix and suffix for **plain cable** members — asked once, only if a member is not a mult.

*Phase 2 — the writes.*

1. **The extension bundle row:** a clone of the source (the same 455 primitive the Clone gesture uses — an
   extension *is* a clone in v1, with three fields then overwritten), with name = prefix + original + suffix,
   length = the length you typed, and the Ext flag set. That flag is the one the Bundle List currently renders
   disabled with the tooltip *"set by extension creation — unit D-2b"* (`BundleRow.tsx:415`). This is the unit.
2. **Enrol into bundle link groups across all eight fields minus Length.** 297 re-mints the Length link
   immediately after setting the new length — because an extension is deliberately a different length from its
   parent and must not drag the parent along. This is the exact structural analogue of the cable side's
   `EXT_UNLINKED_FIELDS`; the bundle vocabulary has no name or bundle token, so Length is the only subtraction.
3. **Per member:** the same copy shape as Clone, with the member's name rebuilt from that class's prefix and
   suffix, length set to the extension length, the Ext flag set, and enrolment across **the Clone set minus
   Name, Length and Bundle** — which is precisely today's `EXT_UNLINKED_FIELDS`, unchanged.
4. **Remaining** seeds from the Set-Remaining default, never copied from the parent. Already built (FIX-2).

**⚠ The one thing that will be got wrong if it is not said plainly: where the flag inversion happens.**

Scripts 300 and 301 — the per-member extension builders — **never invert the flagged end.** Not once. The
inversion happens exactly once, at bundle level, at the very end of 297: if the Invert Extensions default is
on, the extension's Invert flag is set to *the opposite of the source bundle's*, and then script 570
`Invert Bundle Flag` runs, which

- swaps the bundle row's flagged ↔ not-flagged **labels**, and its flagged ↔ not-flagged **colours**;
- swaps which link group the row belongs to for each of those two pairs;
- flips **every member cable's** flagged end, source ↔ destination.

Our existing `computeExtOverrides` inverts per cable. Call it with invert **off** on this ride and do the
inversion once at the bundle, or every cable inverts twice and lands back where it started.

**Two consequences worth naming.**

- **`bundles.invert` is, today, a checkbox that writes a boolean and nothing reads.** There is no v2 equivalent
  of script 570 anywhere in the source. So this unit does not "honour" an existing swap — it builds the swap.
  Confining that to the extension path (rather than also wiring the Invert checkbox to perform it) is
  **(c3)**.
- **Our cable-page Extension inverts on this same default, and v1's cable-page extension does not.** Script
  304 `Add Extension - Cable Button` calls 301, and neither inverts anything; the default is read by 297
  alone. B6-R3 ruled our behaviour and I am not reopening it — but it is now measured that in v1 this default
  is a **bundle**-extension setting only, which is the inverse of the intake's "nothing reads it for bundles
  yet." It also touches open punch **(vvv)**. Flagging, not re-arguing.

**The corpus agrees, in your own shows.** Across every project in the live database: **389 bundles, 17 marked
as extensions, 17 marked inverted — and the overlap is 17 of 17.** No extension is un-inverted; no
non-extension is inverted. Both columns come straight from v1's own `Extension` and `Invert Flag` fields
through the importer. Your v1 files say the invert-on-extension behaviour is not a corner case; it is what
every extension in your work has done.

---

## Two rules from script 442 that were not on anyone's list

Script **442 `Clone`** is the dispatcher behind the Clone gesture — Cable layout goes to `Clone Cable`, Bundle
List goes to `Clone Bundle with Members`. It also carries a refusal nobody had recorded:

> **"You May Not Clone This Cable"** — *"You may not clone a cable that's a member of a cloned bundle. If you
> need cloned cables within cloned bundles, delete the cloned bundles, make the cloned cables, and then
> reclone the bundle with the cloned cables inside. You may also choose to just duplicate this cable instead."*
> Buttons: **Cancel** / **Duplicate** (Duplicate falls through to a plain duplicate).

v1 blocks cloning a cable that sits inside a cloned bundle, and offers Duplicate as the way out. Our ⌥⇧G has
no such guard — and could not have had one, because until this row there were no bundle clone groups to test
against. Once there are, the predicate is expressible in one read. See **(c5)** and ruling **R6**.

The reverse gesture — 467 / 704, *"Add Cable to Cloned Bundles?"*, which offers to propagate a newly-added
cable into every sibling cloned bundle — is real, evidenced (`d2b_02`), and **not this row**. It lives on the
cable list's bundle-assignment commit path, not on the Bundle List. See **(c6)**.

---

## Linkage schema — the finding, and it is a short one

**No migration. Nothing to build, nothing to alter, nothing to grant.** Four measurements, taken live against
the production database today:

1. The rule that limits what kinds of thing can have link groups — `link_groups_entity_type_check` — already
   reads `cable | bundle | mult_line`. Bundles are already allowed.
2. The membership table's `item_id` column, which names the thing that belongs to a group, **has no foreign
   key at all.** It is a bare id. A bundle's id can sit in it today. (Its only constraints are on the group
   and the project.)
3. `link_group_members_item_id_idx` already exists, so looking a bundle's memberships up by its id is already
   indexed — that is the read every enrolment does first.
4. Every security policy on both tables keys on **`project_id` alone** — `can_write_project(project_id)` to
   write, `readable_project_ids()` to read. Not one mentions entity type. Bundle groups are covered as they
   stand, with no policy edit and no grant to restore.

**So the Trigger B that this row has carried since the August Sprint-4 map — *"D-2b (Trigger B linkage schema
at open)"* — does not fire.** There is no data-structure change to halt on. I would strike it from the row
rather than carry it as a ceremony with nothing behind it. See ruling **R7**.

Two things follow that are **code**, not schema:

- **`bundleLinkFields.ts` already exists** and already names the eight bundle fields, with a comment saying
  every one is switched off pending *"Daniel's ruling on importing v1 bundle link groups."* That ruling is a
  separate question — it is about the **importer**, whether a v1 file's existing bundle links come across.
  This unit creates bundle groups **from the app's own gestures** and needs no import decision. Keep the two
  apart; the import switch can stay off while this ships. See ruling **R8**.
- **Nothing cleans up after a deleted bundle.** Because `item_id` has no foreign key, deleting a bundle leaves
  its memberships behind as orphans. The cable side already learned this (the membership purge on delete).
  The bundle delete path must purge too, and a group left with one member must dissolve, the same rule cables
  follow. This is part of the build, not a migration.

**If the answer had been yes.** For the record, had a migration been needed it would have been a new
`entity_type` value plus a CHECK replacement — and the rehearsal would have been: count rows by entity type
before and after; confirm the CHECK's definition by reading it back from the catalogue, not from the migration
file; re-read every policy and grant on both tables after the constraint swap, since a constraint replacement
is where grants are quietly lost; and a forced rollback proving the old CHECK returns. None of that is owed.
The rehearsal and any Trigger B belong to the main line in any case.

---

## What I chose without evidence — strike any by number

**(c1) A cloned bundle is born unbundled, unpacked, untested**, the same reset a duplicated bundle gets
(D2-R9). v1's clone is a bare record duplicate and copies those three flags verbatim. I propose the reset
because all three mean *this physical thing has been handled*, which is not true of something that does not
exist yet — the same reasoning that earned D2-R9. **Strike (c1)** to copy them verbatim from the source.

**(c2) One dialog for the extension's length and the bundle's prefix/suffix**, then a small prefix/suffix
dialog per member class present. v1 asks length and bundle prefix/suffix as two separate dialogs; B6-R6
already ruled that pair into one on the cable side and this follows it. **Strike (c2)** for either v1's two
dialogs, or the other direction — a single dialog carrying all three prefix/suffix pairs at once, fewest
interruptions, furthest from v1.

**(c3) The flag swap runs on the extension path only.** The Invert checkbox on a bundle row keeps writing a
bare flag that nothing acts on, as it does today. Wiring that checkbox to perform the real swap is a
separate, larger change — it would reach every existing bundle. **Strike (c3)** to pull that in here.

**(c4) A colliding extension name keeps the dialog open** with the message inline, rather than silently
adjusting it — the D-2 treatment, applied to prefix+name+suffix. Member cable names collide freely; there is
no uniqueness constraint on them, so only the bundle name can fail this way.

**(c5) Port v1's refusal to clone a cable inside a cloned bundle**, wording verbatim from 442, both buttons.
**Strike (c5)** to leave ⌥⇧G unguarded as it is today.

**(c6) The reverse gesture (467/704) is out of scope**, named as its own future row rather than built here.

---

## Rulings I need — one word each

1. **R1 — Where do the two controls go?** The Bundle List row ends `− Delete · + Duplicate`. Clone and Ext
   join that strip, matching the cable list's own Clone/Ext gestures. **"strip"** or say where instead.
2. **R2 — Keyboard.** Cable uses ⌥⇧G for Clone and ⌥⇧X for Ext. Same two chords on the Bundle List, which is a
   different surface so nothing collides. **"same"** or **"none"**.
3. **R3 — Do cloned members carry their tails and lines?** v1 says no — a cloned bundle's mults arrive empty.
   That is either right, or a v1 wart you have worked around for years. You would know from using it.
   **"v1"** (empty, faithful) or **"copy"** (bring children, a deliberate divergence).
4. **R4 — Does an extension's members' *description* stay linked to the parent's?** v1 unlinks Name, Length
   and Bundle and nothing else, so yes. Confirming because it is the one that surprises people. **"yes"**.
5. **R5 — Do (c1) through (c6) stand?** Strike by number, or **"all stand"**.
6. **R6 — The 442 refusal** — port it or drop it. **"port"** or **"drop"**.
7. **R7 — Strike Trigger B from this row?** Nothing in the row touches a data structure. **"strike"**.
8. **R8 — Does the importer's bundle-link switch stay off?** It is a separate question from this unit and can
   stay off while this ships. **"stays off"** or open it as its own row.

---

## Main-line material — stated, not acted on

*None of this has been written anywhere. The main line installs it.*

- **The Docket row, restored.** *BUNDLE-CLONE-EXT (alias D-2b) — clone a bundle, extend a bundle. CC, after
  the design close. Needs: Daniel's rulings R1–R8; the three extension-naming frames (one gesture). Placed
  right after cable splits, per Daniel 2026-09-22.* **No Trigger B** — see the linkage finding.
- **Ledger material.** (a) The `d2b_01/02/03` identification, with the correction that the recon's
  "no screenshot anywhere" premise was false and that `d2b_03` is script 225's gate, not one of the four 504
  confirms. (b) The four 504 confirm frames come **off** the gate list — verbatim copy in corpus, anatomy
  already banked at `d2_04`, and outside this row's path. (c) Script 297 read in full: an extension bundle is
  a clone of the bundle row with Name, Length and the Ext flag overwritten, Length unlinked, members extended
  per class, inversion applied **once at bundle level** via 570, never per member. (d) Script 442's refusal,
  verbatim. (e) The linkage measurement: CHECK already admits `bundle`, `item_id` carries no foreign key,
  `link_group_members_item_id_idx` present, both tables' policies project-scoped only — **no migration owed**.
  (f) The live corpus count: 389 bundles / 17 extensions / 17 inverted / overlap 17. (g) Script 298 is indexed
  but unextracted — one of 200 outside the cable/box allowlist.
- **A one-line fix** to `BundleRow.tsx:436`'s tooltip, which says members never ride when they do. It can ride
  this unit's handoff rather than earn its own.
- **The clock.** Two parallel openers were stamped ~3h16m ahead of the file's own write time. Worth one line
  in the close.

⚠ **This row carries "Keep Will Pickens updated."** MAILGATE holds — **Daniel sends it.** Nothing has been
drafted or sent from this seat.

---

## Measurements

*Everything below was read at source today. Nothing is carried from an earlier session's summary.*

**⚠ One file was being written while I read it.** `CableListClient.tsx` was last written at **14:50 today** and
grew by ~54 lines between two of my reads — the live CC run (CHANGEALL-MMMCAT) is editing it now. HEAD is
still `d25d366` (the ref file was last written 12:06), so those are uncommitted working-tree changes. **Every
line number I cite in that one file is a working-tree reading, not a HEAD reading**, and is marked ⚠ in the
table below; re-measure before any of them reaches a handoff. Nothing this row depends on lives there —
`BundleRow.tsx`, `BundleListClient.tsx`, `bundleDuplicate.ts`, `bundleList.ts`, `cableWrites.ts`,
`extBuild.ts`, `linkEnroll.ts`, `linkFields.ts` and `bundleLinkFields.ts` were all last written between July
26 and September 20 and are unchanged since the last commit. Worth knowing for blast radius: the file CC is
rewriting is the one that hosts Clone, Extension and cable link enrolment.

**State (code `d25d366`).**

| What | Where | Reading |
|---|---|---|
| Bundle row controls | `BundleRow.tsx:423` (+ the header note at `:18`) | `− Delete` and `+ Duplicate` only; *"Clone/Ext land in D-2b"*, *"Clone/Ext are unit D-2b — not stubbed"* |
| Ext checkbox | `BundleRow.tsx:415` | rendered `disabled readOnly`, title *"set by extension creation — unit D-2b"* |
| Duplicate tooltip | `BundleRow.tsx:436` | *"members never ride — D2-R9"* — contradicted by `BundleListClient.tsx:529` and `bundleList.ts:135` |
| Two-phase ride | `bundleDuplicate.ts:1-162` | `collectRidePlan` (asks, zero writes) / `executeRidePlan` (writes, full unwind) / `runTwoPhaseRide` |
| Ride wiring | `BundleListClient.tsx:529-700` | phase-1 io reads + three promise-bridged dialogs; phase-2 io inserts bundle then members then children |
| Copy shapes | `cableWrites.ts:147, 190, 221` | `buildDuplicateCopies` / `buildTailCopy` / `buildLineCopy` — the only cable-copy write shapes |
| Extension builders | `extBuild.ts:1-89` | `computeExtOverrides` sets `bundle_id: null` and inverts per cable when the default is on |
| Enrolment planner | `linkEnroll.ts:29, 72` | `entityType` is a **parameter** — already entity-agnostic, reusable for bundles unchanged |
| Cable enrolment caller | `CableListClient.tsx:2857, 2877` ⚠ | hardcodes `CABLE_LINK_ENTITY`; a bundle caller is a sibling, not an edit |
| Bundle vocabulary | `bundleLinkFields.ts:76-85` | eight tokens, `enroll: false` on all eight, queued to Daniel's **import** ruling |
| Bundle invert default | `extBuild.ts:85`, `CableListClient.tsx:488` ⚠, `BundleListClient.tsx:169` | read by the cable ext and both defaults panels; **no bundle consumer** |
| Invert checkbox | `BundleListClient.tsx:382` | `updateBundleField(id, { invert: checked })` — a bare boolean write; no label/colour swap, no member flip; **no v2 equivalent of script 570 exists** |
| Bundle name uniqueness | `bundles_project_id_bundle_name_key` | UNIQUE (project_id, bundle_name) |
| Cable name uniqueness | `cable_details` constraints | primary key only — cable names may collide |
| Panel-label columns | `cable_details` | **none**; only `tail_panel_labels` elsewhere. v1's zeroing step has no v2 target |

**Live database (project `musfmquwwjlggyxckpos`, 2026-09-22, SELECT and counts only).**

- `link_groups_entity_type_check` → `CHECK (entity_type = ANY (ARRAY['cable','bundle','mult_line']))`
- `link_group_members` constraints → PK `(link_id, item_id)`; FK `link_id → link_groups ON DELETE CASCADE`;
  FK `project_id → projects ON DELETE CASCADE`. **No FK on `item_id`.**
- Indexes → `link_group_members_item_id_idx`, `link_group_members_project_id_idx`, plus the PK.
- Policies, both tables, all four commands → `can_write_project(project_id)` /
  `project_id IN (SELECT readable_project_ids())`. No entity-type term anywhere.
- Counts → link groups **4,157** (cable 4,157 · bundle **0** · mult_line **0**); memberships **8,996**;
  bundles **389**; extensions **17**; inverted **17**; extension∧inverted **17**; extension∧not-inverted **0**;
  inverted∧not-extension **0**.
- Migration ledger → **83**.

**v1 corpus** (`docs/reference/v1-cable-box-catalog/extracted/scripts/`, 402 of 602 indexed scripts extracted).

| Script | Name | What it is |
|---|---|---|
| 442 | Clone | Dispatcher: Cable → 400, Bundle List → 441. Carries the *"You May Not Clone This Cable"* refusal |
| 441 | Clone Bundle with Members | Name dialog → 455 → per member 400, set Bundle, zero panel labels, unlink Bundle. **No per-member prompt** |
| 455 | Clone Bundle in Bundle List | The bundle-row clone primitive: duplicate row, new name, new historyID, duplicate the whole link record |
| 400 | Clone Cable | Member clone primitive. Resets labeled/pulled/tested. **No tail or line loop** |
| 297 | Add Extension - Bundle | **The extension mechanism, in full.** 298 → bundle prefix/suffix → 455 → name/length/Ext + unlink Length → mults via 299+300 → plain cables via 302+301 → invert once via 570 |
| 300 / 301 | Add Extension - Mult / Single Cable | Clone, unlink Name+Length+Bundle, rename, set length, Ext=1, Remaining from default. **Neither inverts** |
| 304 | Add Extension - Cable Button | The cable-page ext. **Does not read the invert default** |
| 570 | Invert Bundle Flag | Swaps the bundle's flagged↔not-flagged labels and colours and their link ids, then flips every member's flagged end |
| 299 / 302 | prefix/suffix prompts | Two inputs each, wording verbatim in hand, faces not banked |
| 298 | Add Extension - Get Length | **Indexed, never extracted.** Text unknown |
| 225 | Delete Mult Button | The *"Update Cloned Bundles?"* gate (Cancel/Leave/Delete) — `d2b_03` |
| 504 | Delete Cable with Clones | The four confirms, verbatim. Cable delete path — outside this row |
| 467 / 704 | Add Cable to Cloned Bundle | The reverse gesture — `d2b_02` |

**Governing documents.** Roadmap v4.49 carries **no** BUNDLE-CLONE-EXT or D-2b row — confirmed by search.
Ledger line 502 carries the row's history; line 627 carries the 504-frames residual; line 250 carries the
Sprint-4 map's *"S4-mid D-2b (Trigger B linkage schema at open)"*. None edited from this seat.

---

## Critique of my own return

The weakest thing here is **R3**. I am asking you to rule from memory of using v1 whether a cloned bundle's
mults really come out with no tails, because the script says they do and that reads like a bug rather than a
design. If your memory is that they come out full, the script is not wrong — it means some other trigger fills
them, and I have not found it. Say so and I will go looking rather than build the empty version.

The second is **(c2)**. Consolidating four v1 dialogs into two is the right instinct on a dark stage, but it is
also where a design quietly stops being parity. Frame 1 of the evidence request may settle it by showing what
298 actually asks — if it carries something I am not expecting, (c2) is the choice that has to move.

---

## Next step

**Rule R1–R8 in one pass** — eight words is enough — and, when v1 is next open, run the one extension gesture
and shoot the three frames. The design closes on the rulings alone; the frames only decide what the dialogs
look like.
