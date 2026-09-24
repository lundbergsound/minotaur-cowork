# 260922-1455 · LIBRARY · the library in version history, and the library panel · RETURN

*Arch parallel, opened from the main line 2026-09-22 17:35 ET under Architecture Prompt v39. Design only: no CC handoff,
no schema change, no SQL write, no governing-document edit, nothing written to the code repo, git never run. Measured at
code HEAD `d25d366` (= `origin/main`, read from `.git/refs/`), migration ledger 83, and the live database by SELECT and
aggregate counts only — no cohort member's project content was read (USER-DATA-RULE, option C). The main line installs
this; a `drafts/` copy rides alongside because `.gitignore` ignores `handoffs/` entirely.*

---

# FOR DANIEL

## The short version

**The library is already in version history.** It has been since the day version history shipped. No migration is
needed, and nothing has to be built to satisfy your ruling — it is already true. The Roadmap sentence that made this
look like an open question is describing one column and reading like the whole backup, and it should be corrected.

**What is actually missing is the other half: there is no restore at all.** "Open as new production" is a button that
calls nothing, and the database function behind it does not exist. So today a Delete All in the Equipment Library would
be *recorded* in a version, but could not be *undone* from one. That gap is the only real thing standing between here
and LIBRARY-DELETE, and it is a decision for you rather than a discovery for anyone else.

**The library panel is real and I can see it.** Your v1 equipment list has exactly the footer you asked for, and I have
the frame. I measured every field in it out of the FileMaker report. Two things the earlier pass got wrong are corrected
below. The panel is a client-only build with no migration, and v2 already has the right shape to hang it on — the cable
list's bottom inspector is the same animal, already ruled and already shipped.

## The two rows, plainly, and what they cost

**Row 1 — the library in version history.** Nothing to build. What you get for free is that every backup Minotaur has
ever taken of a production already contains that production's whole equipment library, de-duplicated so it is not stored
again when it has not changed. What you do *not* get yet is a way to put it back. Cost of the ruling: zero. Cost of the
thing it was a prerequisite for (restore): one database function, rehearsed, your Trigger B — the work already sitting
in VERHIST-REST, unchanged by today.

**Row 2 — the library panel.** A footer along the bottom of the equipment list showing the library's defaults for the
selected row's model, editable in place. Client-only, no migration, no new table, no policy change. The cost is in two
small places: the equipment list currently loads only five library columns for the whole project at once, so the panel's
extra fields need a read-path decision (below); and the panel takes vertical room from the list, which is the same
trade the cable list already made and you already accepted.

## What a restore does when the library is missing from a version

It leaves the library alone. It never empties it.

That is the rule I want written into the restore when it is built, and it matters because nothing in the database
enforces the link between a version and its library — the pointer can be blank and there is no constraint stopping it.
In practice it never is: I checked all 130 versions in the database and every single one has its library, with no
broken pointers. So this is a written rule guarding a case that has not happened, not a bug being patched.

## One thing I found that is not in my scope but is yours to know

Three things belonging to a production are in **no** backup at all: **Equipment List Revisions**, the import history,
and the per-production feature switches. The revisions one matters, because on 2026-09-11 you ruled that a restored
copy **must** carry the original's Equipment List Revisions. That ruling is still honourable — the fork can copy them
from the live production at the moment it forks, which is cheaper than storing them in every hourly backup — but it is
a requirement on the restore that nobody has written down next to the restore. It goes to the main line as a row, not
to me.

---

# 1 · THE VERSION-HISTORY ANSWER

## Is a migration needed? **No.**

`snapshot_project_v1` already captures the equipment library on every single snapshot, by every reason — hourly,
manual, and all four destructive gestures. It does it in a second arm rather than inside `payload`:

- `payload` (the jsonb column on `project_snapshots`) holds the project row plus nineteen tables.
- the library is written to **`project_blobs`** as `kind = 'library'`, content-addressed by a SHA-256 of its own rows,
  with `project_snapshots.library_hash` pointing at it. `import_identity_map` rides the same way as `kind = 'identity_map'`.
- the blob insert is `on conflict (project_id, kind, content_hash) do nothing`, so an unchanged library is stored once
  and pointed at by every later version.
- skip-if-unchanged compares **all three** hashes — `payload_hash`, `library_hash`, `identity_map_hash` — so a change
  to the library alone still writes a new version. The library is not merely stored; it is part of what makes a version.

This is the dedup design your 2026-09-10 seventh ruling was waiting on. It was built. The ruling of 2026-09-22 —
*"library should be in version history"* — is already satisfied by the code at HEAD.

**Why the Roadmap made it look open.** VERHIST-REST reads: *"The saved payload holds twenty tables and the project
library is not one of them — a question, not yet a defect."* That sentence is true about the `payload` column and
false about the backup. It should be corrected in the same package that closes this, or the next session re-opens the
same question. **(Propagation — the main line's, stated not acted on.)**

## What the payload actually holds

Twenty keys, plus `schema_version`. In the function's own order: `project`, `equipment_items`, `cable_details`,
`cable_mult_lines`, `tail_details`, `box_details`, `rf_device_details`, `box_types`, `bundles`, `categories`, `methods`,
`cable_types`, `link_groups`, `link_group_members`, `cover_letters`, `cast_members`, `circuits`, `walkie_channels`,
`walkie_assignments`, `maintenance_history`.

`box_details` and `rf_device_details` carry no `project_id` and are reached by join on the equipment spine — the
function says so in its own comment, and it is right.

Outside the payload, in blobs: `equipment_library_items`, `import_identity_map`.

**Project-scoped tables in neither arm** (measured against every table in `public` carrying a `project_id`):

| Table | Rows (est.) | Should a restore carry it? |
|---|---|---|
| `equipment_list_revisions` | 62 | **Yes — you ruled it on 2026-09-11.** Copy at fork time, not in the payload (each revision carries its own jsonb `snapshot`; inlining would balloon every hourly backup). |
| `import_runs` | 25 | Arch's lean: no. It is a log of what happened to the original, not state of the copy. |
| `project_features` | — | Arch's lean: yes, at fork time. A fork that silently loses a feature switch is a support call. |
| `project_members` | 16 | Arch's lean: **no.** A fork is a new production; its roster is the person who forked it. Copying a roster silently re-shares a production. |

`project_snapshots` and `project_blobs` themselves are deliberately not carried — a fork starts its own history.

## What a restore does about the library — the rule, written

`project_snapshots.library_hash` is **nullable**, and there is **no foreign key** from it to `project_blobs`. So the
restore has to handle three cases and must never guess:

1. **Hash present, blob found** — the normal case. Write the blob's rows into the new production as its library.
2. **Hash null** — the version predates the library arm, or was written by something that did not set it. **Leave the
   new production's library alone.** For a fork that means: it starts empty, exactly as a new production does, and the
   restore says so on screen.
3. **Hash present, blob missing** — a broken pointer. **Refuse, or restore everything else and say plainly that the
   library could not be recovered.** Never treat a missing blob as an empty library. Which of those two it is, is a
   ruling below (R-3).

**Never, in any case, empty an existing library.** Restore is fork-only by your 2026-09-10 ruling, so there is no
existing library to empty — but the rule is written so a future non-fork restore cannot get it wrong.

**Measured, so the shape of the risk is clear:** of 130 versions in the live database, **0** have a null `library_hash`,
**0** have a null `identity_map_hash`, and **0** have a dangling pointer. Case 1 is the only one that has ever
happened. Cases 2 and 3 are written rules, not defects.

## Blobs are never pruned, and that is on purpose

`prune_project_snapshots_v1` counts `project_blobs` before and after the retention delete and **raises an exception,
rolling the whole prune back**, if the count moved. So a blob outlives every version that pointed at it. Blobs only
disappear when the production does, by `on delete cascade` from `projects`.

That is the right call for safety and it is why case 3 above has never occurred. It also means there is no reaper: a
library blob for a version deleted six months ago is still stored. At today's scale that is 97 blobs and 11 MB, which
is nothing. It should be a line in the Ledger so that when it does matter, nobody re-discovers it as a mystery.

## What this does to LIBRARY-DELETE

The prerequisite is **met on the backup side and not on the undo side.**

- Enabling Delete All in the Equipment Library adds a new destructive gesture. The existing guard already snapshots
  before destructive gestures and refuses the gesture if the snapshot fails, and the snapshot already includes the
  library. So the *backup* is correct the moment the button is enabled. Nothing has to change in `snapshot_project_v1`.
- But the confirm dialog cannot honestly say the delete can be undone, because **`restore_project_v1` does not exist in
  the catalog** (measured today; the code says the same at `historyRow.ts:124–133` and `HistoryClient.tsx:33`). "Open
  as new production" is disabled and calls nothing.

So the wording of that dialog is a ruling (R-1), and so is whether LIBRARY-DELETE ships before restore does (R-2).

Arch's lean: **ship it, with honest wording.** Will Pickens cannot remove a single row of the library he imported
today. Holding the fix behind a migration you have deferred past the invite trades a live trap for a hypothetical one,
and the delete is guarded by a confirm dialog with a count. The honest sentence is that Minotaur takes a backup first —
not that the delete can be undone.

## One latent thing, named so it is not a surprise later

`equipment_library_items.project_id` is **nullable**, and the read policy has an owner arm
(`owner_id = auth.uid() OR project_id in readable_project_ids()`). The snapshot filters on `project_id` only, so an
owner-scoped library row with no project would not be captured.

**Measured: all 39,557 library rows have a `project_id`, and all 39,557 have a null `owner_id`.** The owner arm is dead
in practice. Nothing is missed today. It is written here only so that if anyone ever lights up an owner-scoped library,
they know the snapshot will not see it.

---

# 2 · LIBRARY-PANEL

## What v1 actually has — measured, and two corrections

**Evidence:** the v1 FileMaker equipment list, project-knowledge frame `02_equipment_list_populated.jpg` (show "ES TRT"),
and layout **26 "Equipment Manually Added"** in `docs/reference/v1_ddr.xml` (layout width 1224). Both opened before this
section was written.

v1's footer is permanent chrome across the bottom of the equipment list, in three zones:

- **Left — the ITEM's own fields:** Category, Model, ETA, Box No. (These are `Equipment Manually Added::` and
  `Box List::`, not library fields.)
- **Middle — the LIBRARY's fields**, eleven of them, in three rows.
- **Right — four buttons:** Allocate as Cable · Allocate as Tail · Allocate as Box · Allocate as RF.

The library block, measured field by field, with v1's own labels verbatim:

| Row (y) | v1 label | v1 field | v2 column | In your amended set? |
|---|---|---|---|---|
| 386 | Cost Each | `Equipment Library::Cost` | `cost` | — |
| 386 | Extended | `Equipment Manually Added::costSub` | *(the item's, not the library's)* | — |
| 386 | Date | `Equipment Library::Cost Date` | `cost_date` | — |
| 386 | Cost Source | `Equipment Library::Cost Source` | `cost_source` | — |
| 386 | Origin | `Equipment Library::Country of Origin` | `country_of_origin` | — |
| 426 | Weight | `Equipment Library::Weight` | `weight_lbs` | — |
| 426 | Power Draw | `Equipment Library::Power Draw` | `power_draw_watts` | ✅ |
| 426 | RU | `Equipment Library::RU` | `rack_units` | ✅ "rack spaces" |
| 426 | Depth | `Equipment Library::Depth` | `depth_inches` | — |
| 462 | URL | `Equipment Library::URL` | `product_url` | — |
| 466 | Default Category | `Equipment Library::Category` | `category` | your earlier ruling |
| 466 | Default Note | `Equipment Library::Note` | `public_note` | ✅ "public note" |
| — | *(not on this layout)* | — | `library_note` | ✅ "private note" — a v2 addition |

All library labels are 10 pt Century Gothic `#707070`; the item's Category and Model labels are 12 pt. A `<<weightSub>>`
merge sits under Weight (a summary, not a field). `Default Category` is the only library field with a value list
(`Categories`).

**Correction 1 — v1's block has no heading.** The earlier pass cited a block *"headed 'Equipment Library for this
model'"*. That text object exists in layout 26, but its bounds are `left=1321, right=1510` on a layout **1224** wide —
it is parked off to the right of the layout and does not render. The frame confirms it: there is no such heading on
screen. Only two of the layout's 171 objects sit beyond the layout width, and this is one of them. Each field carries
its own small grey label instead.

**Correction 2 — the block is not one band.** The earlier pass gave bounds *"y≈390–485"*. The library fields do run
386–485, but they are three distinct rows with their own label runs, and they sit inside a wider footer that also
carries the item's own fields on the left and the four Allocate buttons on the right. It is a record inspector, not a
library panel — which is the design question below.

**Confirmed from the earlier pass:** `Library Note` (the private note) is genuinely **not** on layout 26. All eleven
`Equipment Library::` fields on the layout are listed above. The private note is a v2 addition and its pedigree is your
word, **(a)**, not v1.

## How full these fields actually are

Measured across all 39,557 library rows in the database:

| Column | Filled | Share |
|---|---|---|
| `category` | 37,855 | 96% |
| `power_draw_watts` | 16,601 | 42% |
| `public_note` | 8,897 | 22% |
| `cost` | 6,926 | 18% |
| `library_note` | 2,994 | 8% |
| `rack_units` | 1,047 | 2.6% |
| `depth_inches` | 592 | 1.5% |
| `weight_lbs` | 416 | 1.1% |
| `product_url` | 67 | 0.17% |

This is worth a sentence of judgment. Your amended set — public note, private note, rack spaces, power draw — is the
set with something in it, plus the two you are about to fill. Weight, Depth and URL are empty 98%+ of the time and stay
that way until EQUIPLIB's Job B harvest runs. **Arch's lean, against the earlier pass's lean:** do **not** ride Weight,
Depth and URL in just because v1 had them. A footer of blank boxes in a dark theatre is chrome that costs rows and
returns nothing. They are a one-line addition after Job B lands, and the panel should be built so that adding a field
is a line of config, not a redesign. Category **does** ride, because it is exactly what Will's question needs.

That is ruling R-4.

## What the panel shows, edits, and writes to

**Follows:** the current row's **model** — the same "current row" the equipment list already tracks for ⌥⇧E and the
band editors. Empty state when nothing is selected, or when the selected row has no model.

**Shows and edits:** the library row for that model, in this project. Ruled set plus Category:
`category` · `public_note` · `library_note` · `rack_units` · `power_draw_watts`.

**Writes to:** `equipment_library_items` — **the library row, never the item.** A changed default reaches items through
the existing model-save cascade at the next model commit; it never rewrites items already on the list. This is what
"library defaults" means and it is what v1 does.

The earlier pass raised this as an open question for you. **Arch's answer, offered as a ruling to confirm rather than a
question to sit on (R-5):** library only. Rewriting the items already on the list from a footer edit would be a silent
bulk write with no confirm and no count, which is the one thing every other bulk gesture in Minotaur refuses to do.

The write is permitted: `equipment_library_items_update` is `owner_id = auth.uid() OR can_write_project(project_id)`,
so any project writer can edit the library row from the footer. No policy change.

**Power draw renders `0` and blank differently** — `0` is verified no mains draw, blank is unknown (EQUIPLIB,
2026-09-16). A blank box and a box reading `0` must not look alike.

## The no-match case

A row whose model matches no library row.

Today this is nearly unreachable: `ensureLibraryModel` (`EquipmentListClient.tsx:473`) creates the library row on the
model commit, idempotently against `equipment_library_items_project_model_ci_uniq (project_id, lower(model))`. Every
model on the list has a library row because putting the model there made one.

**It becomes reachable the moment LIBRARY-DELETE ships** — delete the library row, the item keeps its model text
(`equipment_items.model` is plain text, and no foreign key references the library table), and the panel has nothing to
show. These two rows are joined at this seam, which is the argument for designing them together.

Three candidate behaviours, and Arch's lean:

- **(c-1) Show the fields empty and disabled, with one grey line: "No library entry for this model."** No writing, no
  silent creation. — **Arch's lean.**
- (c-2) Show them empty and editable; the first edit creates the library row. Quiet, but it means a stray keystroke in
  a footer silently re-creates a row the operator just deliberately deleted.
- (c-3) Show an explicit "Add to library" button.

R-6 picks one.

## Shape — proposals, each numbered so you can strike it by number

Everything in this section is **(c)**, a clearly-marked proposal, except where it cites v1 or an existing ruling.

- **(c-A) Pinned to the bottom of the equipment list, always visible, no open/closed state.** Pedigree: v1's footer is
  permanent chrome (frame + layout 26), and this is already the ruled behaviour of the cable list's inspector
  (your gate ruling, 2026-07-24, CP-B5).
- **(c-B) It rides as a flex sibling, not as a floating panel.** The equipment list root is already
  `flex flex-col h-[calc(100vh-96px)]` (`EquipmentListClient.tsx:3015`), so the footer takes its height off the
  scrolling body and no row can hide behind it. This is the shape the cable inspector was *moved to* — its original
  viewport-fixed + spacer + ResizeObserver arrangement was retired (`CableInspectorPanel.tsx:228–230`). Do not rebuild
  the retired version.
- **(c-C) One row of fields, not three.** Five fields at the cable inspector's density (11 px, `w-20` labels) fit one
  line at any reasonable width. v1 needed three rows for eleven fields; the ruled set is five. This is the answer to
  "the panel costs rows on small screens" — at one row it costs about what the cable inspector costs, which you have
  already lived with.
- **(c-D) The two notes are textareas; Enter inserts a newline and Tab still advances** — the cable inspector's ruled
  K-2 exemption, so the two footers behave identically.
- **(c-E) Every field carries the save-error flash and invalidates the library cache on success** — the same
  affordance as the rest of the list, so a failed write is never silent.
- **(c-F) Tab order stays inside the panel and cycles; the cross-record hop happens at the end of the cycle** —
  the cable inspector's ruled tab behaviour.
- **(c-G) The keyboard chord is NOT ⌥⇧I.** ⌥⇧I is **already taken on the equipment list**: `EquipmentListClient.tsx:1887`
  binds it to the Model/Category band focus toggle. (It is the cable list's inspector chord, which is what makes the
  collision easy to miss.) The panel needs its own chord, and picking it belongs with SHORTCUT-HELPER's census rather
  than being guessed here. Proposed: **⌥⇧D** if SHORTCUT-HELPER finds it free on this route. R-7.
- **(c-H) No heading text.** Following v1 as measured, not as previously described: each field carries its own label,
  and the panel's position under the list is what identifies it.

## The one real cost: the read path

`fetchLibraryModels` (`src/lib/queries/equipment.ts:68`) selects **`id, model, category, method_hint, public_note`** and
pages through **every** library row in the project on every equipment-list mount. The average project library is 1,720
rows; the largest is 2,634.

The panel needs `library_note`, `rack_units` and `power_draw_watts` on top of that. Two ways:

- **(c-I, Arch's lean) Fetch the selected model's full library row on demand,** keyed by model, cached. One small
  round trip when the selection changes, nothing added to the mount. The footer is a detail view of one record; that is
  what a detail view should cost.
- (c-J) Widen the shared select. Simpler code, but it makes every equipment-list mount carry three more columns across
  ~1,700 rows whether or not anyone looks at the footer, and it grows again with every field added later.

R-8 picks one. This is the only decision in LIBRARY-PANEL with a measurable cost attached.

---

# 3 · THE RULINGS I NEED — BATCHED

Eight. Each answerable in a word.

| # | The question | The choices | Arch's lean |
|---|---|---|---|
| **R-1** | The Equipment Library delete confirm dialog, while no restore exists — does it say the delete can be undone? | **backup** (says only that a backup is taken) / **undo** (waits for restore) | **backup** |
| **R-2** | Does LIBRARY-DELETE ship before restore is built? | **ship** / **hold** | **ship** |
| **R-3** | A version whose library pointer is present but whose stored library is gone — what does the restore do? | **refuse** (whole restore) / **partial** (restore the rest, say so) | **refuse** |
| **R-4** | Does the panel carry Weight, Depth, URL and the cost fields as v1 did, on top of your amended set plus Category? | **all** (v1's eleven) / **ruled** (your five plus Category) | **ruled** |
| **R-5** | Does an edit in the panel change the library only, or also the items already on the list? | **library** / **both** | **library** |
| **R-6** | A row whose model has no library entry — what does the panel do? | **c-1** (empty, disabled, one grey line) / **c-2** (first edit creates it) / **c-3** (an Add button) | **c-1** |
| **R-7** | The panel's keyboard chord — settled here, or handed to SHORTCUT-HELPER's census? | **census** / **D** (⌥⇧D now, if free) | **census** |
| **R-8** | The panel's read path | **ondemand** (fetch the one row) / **widen** (widen the shared query) | **ondemand** |

And one that is not mine to lean on, because it is a scope call rather than a design call:

| # | The question | The choices |
|---|---|---|
| **R-9** | Does the fork carrying `equipment_list_revisions`, `project_features` and `import_runs` join VERHIST-REST now, or wait? | **now** / **later** |

---

# 4 · WHAT BELONGS TO THE MAIN LINE — stated, not acted on

1. **Correct the VERHIST-REST Roadmap row.** *"The saved payload holds twenty tables and the project library is not one
   of them — a question, not yet a defect"* is misleading and is the reason this question kept re-opening. Proposed
   replacement, for the main line to adopt or edit: *"The library is already in every version, stored de-duplicated
   beside the payload; ruled and closed 2026-09-22. What is left is the restore itself — a migration, deferred past the
   invite — the incomplete-backup counter, and the gesture-class residue."* **(Propagation, per the Close's propagation
   rule: check whether the same claim sits in the Ledger or `CLAUDE.md` before the package ships.)**
2. **LIBRARY-DELETE's prerequisite is met.** Its TO-MAINLINE file says Arch must measure whether the library joining
   version history needs a migration. Measured: **no migration**. The file's paragraph should be updated so CC is not
   handed a prerequisite that is already true.
3. **A new row, or a line on VERHIST-REST:** the fork must carry `equipment_list_revisions` (your 2026-09-11 ruling),
   by copying at fork time rather than by entering the payload. `project_features` and `import_runs` ride the same
   decision. Pending R-9.
4. **A Ledger line:** `project_blobs` has no reaper — `prune_project_snapshots_v1` deliberately raises and rolls back
   if the blob count moves, so blobs outlive their versions and go only with the production. 97 blobs, 11 MB today.
5. **A Ledger line:** `equipment_library_items.project_id` is nullable with a live owner-arm read policy, and the
   snapshot filters on `project_id` only. All 39,557 rows are project-scoped today, so nothing is missed; if an
   owner-scoped library is ever lit up, the snapshot will not see it.
6. **Batching.** LIBRARY-PANEL and LIBRARY-DELETE touch the same table and meet at the no-match case. SEED-DEFAULTS
   feeds the panel. The earlier index proposed designing all three together; this measurement supports it, and adds
   that the panel's chord must be settled against SHORTCUT-HELPER's census before either is handed.
7. ⚠ **Keep Will Pickens updated** — both rows carry it, the Josh Richardson pattern. **MAILGATE holds: Daniel sends
   it, not CC, not this seat.** Will raised *"The 'Delete All' button is not functional (/equipment/library)"* and
   *"Not all newly added devices auto-populate their category" / "Is there a way to update an item's category?"*
   (2026-09-22). One line each when they ship.

---

# 5 · MEASUREMENTS AND CITATIONS

Every claim above traces to one of these. Read at 2026-09-22, code HEAD `d25d366`, ledger 83.

## The snapshot function — read from the catalog, not from a migration file

`public.snapshot_project_v1(p_project_id uuid, p_reason text, p_label text)`, 5,706 characters of source, read via
`pg_proc.prosrc`. There is no file of record: `supabase/migrations/` carries 22 files covering ledger 72–83, and the
VERHIST migrations predate 72.

- Payload keys, verbatim and in order: `schema_version`, `project`, `equipment_items`, `cable_details`,
  `cable_mult_lines`, `tail_details`, `box_details`, `rf_device_details`, `box_types`, `bundles`, `categories`,
  `methods`, `cable_types`, `link_groups`, `link_group_members`, `cover_letters`, `cast_members`, `circuits`,
  `walkie_channels`, `walkie_assignments`, `maintenance_history`.
- The library arm, verbatim: `select coalesce(jsonb_agg(to_jsonb(t) order by t::text),'[]'::jsonb) into v_library from
  equipment_library_items t where t.project_id = p_project_id;`
- `v_lib_hash := encode(sha256(convert_to(v_library::text, 'UTF8')), 'hex');`
- `insert into project_blobs (project_id, kind, content_hash, payload) values (p_project_id, 'library', v_lib_hash,
  v_library) on conflict (project_id, kind, content_hash) do nothing;`
- Skip-if-unchanged compares `payload_hash` **and** `library_hash` **and** `identity_map_hash`, and exempts `manual` in
  the function's own words: *"A manual Save Version always writes: the operator pressed a button and expects a row to
  appear."*
- Reason check: `hourly`, `manual`, `change_all`, `delete_found`, `delete_all`, `import_apply`.

## Schema

- `project_snapshots`: `id`, `project_id`, `payload` (jsonb, not null), `payload_hash` (not null), **`library_hash`
  (nullable)**, **`identity_map_hash` (nullable)**, `reason`, `label`, `created_by`, `created_at`.
  PK `id`; FK `project_id → projects(id) on delete cascade`; FK `created_by → profiles(id)`;
  check on `reason`. Indexes `(project_id, created_at desc)` and `(project_id, payload_hash)`.
  **No constraint ties `library_hash` to `project_blobs`.**
- `project_blobs`: `project_id`, `kind`, `content_hash`, `payload` (jsonb, not null), `created_at`.
  PK **`(project_id, kind, content_hash)`**; FK `project_id → projects(id) on delete cascade`;
  check `kind in ('library','identity_map')`.
- `equipment_library_items`: 24 columns. `project_id` **nullable**, `owner_id` **nullable**, `model` not null.
  Unique index `equipment_library_items_project_model_ci_uniq (project_id, lower(model))` — an **expression** index,
  which is why `ensureLibraryModel` uses insert + 23505 rather than `.upsert({onConflict})`.
- `equipment_list_revisions`: `id`, `project_id`, `revision_name`, **`snapshot` (jsonb)**, `created_by`, `created_at`,
  `editable`. 62 rows.

## RLS, as it bears on this work

- `equipment_library_items_update` / `_insert` / `_delete`: `owner_id = auth.uid() OR can_write_project(project_id)`.
- `equipment_library_items_read`: `owner_id = (select auth.uid()) OR project_id in (select readable_project_ids())`.
- `project_blobs_read`: `project_id in (select readable_project_ids())`. `_insert`/`_update`/`_delete`:
  `can_write_project(project_id)`.
- `project_snapshots` the same shape.

## Counts, 2026-09-22 (aggregates only — no project content read)

| Measure | Value |
|---|---|
| `project_snapshots` rows | 130 |
| … with `library_hash` null | **0** |
| … with `identity_map_hash` null | **0** |
| … with a `library_hash` and no matching blob | **0** |
| oldest / newest snapshot | 2026-09-11 17:00 UTC / 2026-09-22 18:00 UTC |
| `project_blobs` rows | 97 (57 library, 40 identity_map) |
| library blob: total / avg / largest | 7,510 kB / 132 kB / 308 kB (2,634 rows) |
| identity_map blob: total / avg / largest | 3,389 kB / 85 kB / 647 kB |
| `project_snapshots.payload`: total / avg / largest | 17 MB / 135 kB / 801 kB |
| `equipment_library_items` rows | 39,557 across 23 projects (min 1, avg 1,720, max 2,634) |
| … with `project_id` null | **0** |
| … with `owner_id` null | **39,557** (all) |
| projects | 29 |

Storing the library inside `payload` instead of in blobs would cost roughly 130 × 132 kB ≈ 17 MB where the blob arm
costs 7.5 MB, and would break the "did the library change" question that skip-if-unchanged needs. The dedup design is
doing its job.

## Restore — measured absent

- `restore_project_v1` is **not in the catalog**: a `pg_proc` scan for `%restore%` returns only PostgreSQL's own
  `pg_create_restore_point`. The only project functions matching `%snapshot%` are `snapshot_project_v1`,
  `snapshot_all_projects_v1` and `prune_project_snapshots_v1`.
- `src/lib/verhist/historyRow.ts:124–133`: *"'Open as new production' needs a database function that restores a
  twenty-table payload into a NEW project. That is a migration and Arch's, rehearsal-first, and it does not exist …
  **This control is not a stub and not a TODO — it calls nothing at all.**"*
- `historyRow.ts:134`: `FORK_DISABLED_REASON = 'Opening a Project Version as a new production is not built yet.'`
- `src/components/verhist/HistoryClient.tsx:33`: *"`restore_project_v1` does not exist in the catalog, measured."*

## Prune

`prune_project_snapshots_v1`, read from the catalog. Manual saves are excluded from the tiered delete
(`where s.reason <> 'manual'`), and two post-conditions raise and roll back the whole prune:

- *"prune_project_snapshots_v1: blob count moved % -> %. The retention delete must never touch project_blobs. Rolled back."*
- *"prune_project_snapshots_v1: manual snapshot count moved % -> %. Manual saves are exempt from retention (Daniel, 2026-09-11). Rolled back."*

Tiers: live < 48 h keeps everything; < 30 days keeps one per day; older keeps one per week; the newest per project is
never deleted.

## v1 layout 26 — the measurement

`docs/reference/v1_ddr.xml` is UTF-16LE; converted to UTF-8 in this session's scratch (outside both repo folders,
nothing written to either). Layout 26 `"Equipment Manually Added"`, `width="1224"`, 171 objects with bounds, flat — no
groups, tab controls, slide controls or popovers in the layout.

Eleven `Equipment Library::` fields, bounds as `(top, left, bottom, right)`:

```
Cost                (386, 404, 405, 481)      Weight      (426, 404, 445, 493)
Cost Date           (386, 564, 405, 644)      Power Draw  (426, 496, 445, 585)
Cost Source         (386, 647, 405, 719)      RU          (426, 587, 445, 667)
Country of Origin   (386, 722, 405, 799)      Depth       (426, 669, 445, 749)
URL                 (462, 725, 481, 925)      Category    (466, 405, 485, 499)   [ValueList: Categories]
Note                (466, 512, 485, 712)
```

Labels in the same band, all 10 pt Century Gothic `#707070`: `Cost Each` (373,407) · `Extended` (373,484) ·
`Date` (373,564) · `Cost Source` (373,647) · `Origin` (373,721) · `Weight` (413,407) · `Power Draw` (413,495) ·
`RU` (411,586) · `Depth` (413,669) · `URL` (449,725) · `Default Category` (453,405) · `Default Note` (453,512).
`<<weightSub>>` merge at (429,414).

Item fields in the same footer: `Equipment Manually Added::Category` (374,71,396,288) with a 12 pt `Category` label at
(378,12); `::Model` (397,70,419,290) with a 12 pt `Model` label at (400,29); `::ETA` (420,71,439,160);
`Box List::Box Number` (440,71,459,129). `Equipment Manually Added::costSub` (386,484,405,561) is the item's extended
cost sitting under the `Extended` label.

The header: `<Object type="Text" key="288">`, `<Data>Equipment Library for this model</Data>`,
bounds `(390, **1321**, 408, **1510**)`, 12 pt `#707070`. Layout width is 1224. Only two of the layout's 171 bounded
objects sit at `left ≥ 1200` — this text and one button at `left=2063`. The frame confirms no heading renders.

**Frame:** project-knowledge `02_equipment_list_populated.jpg` (uploaded 2026-07-03), v1 FileMaker, show "ES TRT".
Footer visible across the bottom: `Category / Model / ETA` at the left; `Cost Each 449 · Extended 449 · Date 7/9/2020 ·
Cost Source Full · Origin US`; `Weight (blank) · Power Draw .05 · RU (blank) · Depth 5.3`;
`Default Category 1.0 Consoles · Default Note "or similar 1RU mic/line mixer, e.g., APB-…" · URL (blank)`; four
Allocate buttons at the right. The item's Category reads `1.0 Consoles` and Default Category reads `1.0 Consoles` —
two separate fields showing the same value, which is precisely the comparison Will is missing in v2.

## v2 surfaces the panel touches

- `src/components/equipment/EquipmentListClient.tsx:3015` — root is
  `className="equip-palette-scope flex flex-col h-[calc(100vh-96px)]"`. The only `h-[calc(100vh` in the file.
- `:473` `ensureLibraryModel` — resolve-or-create the library row for a model, idempotent against the expression
  unique index by insert + 23505 fallback.
- `:2200` `runModelSaveCascade` — the existing path by which a library default reaches items, on a model commit.
- `:1887` — `⌥⇧I` on the equipment list: `if (!e.altKey || !e.shiftKey || e.code !== 'KeyI') return; e.preventDefault();
  toggleModelCategoryFocus()`. **The chord is taken.**
- `:69` `interface LibraryModel { id, model, category, method_hint, public_note }` — five fields, the panel needs more.
- `src/lib/queries/equipment.ts:68` `fetchLibraryModels` — `.select('id, model, category, method_hint, public_note', { count: 'exact' })`
  over `fetchAllRows`, every library row in the project.
- `src/lib/queryKeys.ts:54` `libraryModels: (projectId) => ['project', projectId, 'libraryModels']` — the cache key to
  invalidate after a panel write.
- `src/components/cable/CableInspectorPanel.tsx` — the precedent. `:10–14` CP-B5, always visible, no open/closed state,
  v1 parity, `⌥⇧I` a client-owned focus cycle. `:228–230` — *"the cable page's fixed-viewport column (was `position:
  fixed` + a same-height page-flow spacer). The flex layout reserves its space and keeps it always visible, so the
  spacer + ResizeObserver height tracking are retired."* `:294` root is
  `border-t-2 border-surface-200 bg-surface-50 px-4 py-2`; fields at `text-[11px]` with `w-20` labels.
- `src/hooks/useNavShortcuts.ts:55–60` — the global chord set: `N` new, `E` delete, `F` find, `J` display all,
  `S` split, `G` clone. `KeyI` is **not** global; each list owns it.
- `src/components/equipment/EquipmentLibraryClient.tsx:515–521` — Delete All rendered `disabled`, title
  *"Bulk delete — guarded multi-row op, not built this run"*. `:176` registers `onNew`, `onFind`, `onDisplayAll`,
  `onSplit` — no `onDelete`.
- `src/lib/verhist/guardCensus.test.ts:209` — asserts the Delete All button **stays** disabled; flips with LIBRARY-DELETE.

## Where I did not measure

- **The panel's rendered height in v2.** (c-C claims five fields fit one row at the cable inspector's density; that is
  reasoned from the inspector's eight fields in three columns, not measured in a browser. **Measure** at build, in
  Daniel's gate.)
- **Whether v1's layout-26 library fields are editable in place.** The `FieldObj` flags are present in the DDR but I
  did not decode them, and no script or frame shows an edit. The design above makes them editable on your ruling, not
  on v1's authority. **Measure**, or let R-5 settle it.
- **The VERHIST-REST "incomplete backup" counter.** Named in the Roadmap row and in LIBRARY-DELETE's file; it is
  VERHIST-REST's own design and outside this parallel's scope. It will need to count the library arm — which, given
  the blob design, means counting two hashes and a blob row, not one payload key.

---

*End of RETURN. Nothing here is installed. The main line owns every write.*
