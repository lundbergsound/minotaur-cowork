# 260922-1857 · DEFAULTS · PARALLEL RETURN

*Arch parallel, opened 2026-09-22 from the main line under Architecture Prompt v39. Scope: **SEED-DEFAULTS** and
**DEFAULTS-ADMIN**, designed together. Design only — no CC handoff, no schema change, no SQL write, no
governing-document edit, nothing written to the code repo, git never run. The migration below is a **proposal** for
the main line to rehearse under Trigger B.*

**Seat check: passes.** All three mounts reachable. Code `d25d366` = `origin/main`, read from `.git/refs/`; no
`index.lock`. Migration ledger **83**, live-read from `supabase_migrations.schema_migrations`; 22 migration files on
disk. Database read SELECT-only: schema, policies, grants and aggregate counts. **No cohort member's project content
was read** (USER-DATA-RULE, your "option C" of 2026-09-21).

⚠ **One clock discrepancy, flagged not fixed.** The opener's filename says `1735` and its text says "17:35 ET", but
it landed on disk at 18:19 UTC = **14:19 ET**, and both this machine's clock and the container's now read
**14:57 ET / 18:57 UTC**. The main line appears to be stamping `handoffs/parallel/` filenames in **UTC** while the
prose says ET. I have stamped this file `1857` to stay in that series so the folder still sorts in order. The main
line should decide which clock the convention means; today the two disagree by four hours.

---

## 1 · For Daniel, in plain words

**Where I land.** Your five "Seed Defaults" switches are not really five separate jobs. They are one question —
*where do your defaults live, and how do you edit them* — and the answer I recommend needs **no new grids at all**.

Today, three of the five switches do nothing, because the shelves behind them are empty or missing. Filling those
shelves is easy. The expensive part is the screen you asked for: a place to keep your default library, methods,
categories, cable and tail types and box types up to date. Built the obvious way, that screen is **five new grids** —
rebuilds of the Library, Methods, Categories, Cable Types and Box Types screens you already have, because every one
of the existing five is welded to a specific show and cannot be pointed at shared content. That is roughly 3,200
lines of screen to fork, plus a forked spreadsheet import, and none of it would have version history or an undo.

**The cheaper answer.** Keep your defaults in **an ordinary Minotaur show** — call it *Defaults* — and edit them with
the screens you already know. When a set is how you want it, open one small admin page, tick which sets to push, and
press **Publish**. That copies them to the shared shelves every new show reads from.

You get, for a fraction of the work:

- **No new grids.** You curate in the real Library, Methods, Categories, Cable Types and Box Types screens.
- **Version history for free** on four of the five sets — categories, methods, cable types and box types are already
  in the snapshot payload, because a show is what snapshots cover. (The library is the one gap, and it is exactly
  what the sibling LIBRARY parallel is closing.)
- **Import for free.** Importing a v1 show or an equipment-library spreadsheet into a show already works. Filling a
  default set becomes "import into Defaults, then Publish."
- **"Copy from one of my projects" for free** — the source *is* a project, so any show can be the source.
- **A real undo.** Publish is one explicit act with a visible before/after count, and the source show stays intact
  behind it.
- **Nothing loosened for anyone else.** Every other account keeps reading the same shared shelves it reads today,
  by exactly the same route. No member gains the ability to read any project of yours.

**What it costs.** Two steps instead of one — edit, then publish. You could edit *Defaults* and forget to press
Publish. The screen answers that by showing, per set, the date of the last publish and how many rows have drifted
since, so an unpublished change is visible the moment you open it.

**What I need from you** is in §7 — six questions, each answerable in a word, plus the exact list of the five sets
you will be asked to supply when the build session gets there.

---

## 2 · What is true today, measured

### 2.1 The five switches

`src/app/dashboard/new/page.tsx` at `d25d366`. All five default to **on** (lines 70–74).

| Switch | Label at HEAD | Works? | Reads | Rows today |
|---|---|---|---|---|
| Default Categories | has a subtitle | ✅ lines 134–147 | `global_default_categories` | **23** |
| Default Methods | has a subtitle | ✅ lines 116–132 | `global_default_methods` | **9** |
| Equipment Library | no subtitle | ❌ `// TODO` line **149** | `global_equipment_library` | **0** |
| Default Cable and Tail Types | no subtitle | ❌ `// TODO` line **150** | `global_cable_types` (tail fields included) | **0** |
| Default Box Types | no subtitle | ❌ `// TODO` line **151** | *no global table* | — |

`to_regclass('public.global_box_types')` is **null** — the table does not exist. The SEED-DEFAULTS file's claim that
one migration is needed for global box types is **confirmed**, and the column list it proposed
(`type_name, dimensions, width, depth, height, weight_lbs, volume, notes`) matches `box_types` exactly, minus
`project_id`, `id` and `created_at`. It is correct as written.

**There are no "tail types."** Tails are fields on a cable type (`source_tail_model`, `destination_tail_model`,
the five `tail_*_label` booleans, `tail_method_*`). There is no `tail_types` table in the generated types and none in
the database. The single Cable-and-Tail-Types switch is the right shape; your wording listed six kinds, the schema
has five.

### 2.2 Three defects at HEAD, beyond the three TODOs

**(i) A failed seed is silent — this is the serious one.** Lines 120, 139 and 153 are written
`await supabase.from('methods').insert(…)` with the result discarded. `supabase-js` **returns** an error object; it
does not throw. The surrounding `try/catch` (lines 114–158) catches only what `fetchAllRows` throws, and
`fetchAllRows` throws on a failed *read*. So a refused or failed **insert** — a unique-key collision, an RLS refusal,
anything — is swallowed, and `router.push` (line 160) sends the person into a show that quietly has no methods, no
categories or no cover letter, with no error shown. The two switches that "work" work only when nothing goes wrong.
This must be fixed in the same unit; the fix is the same server-side call that wires the other three.

**(ii) `notes` is never copied.** `global_default_categories` and `global_default_methods` both carry a `notes`
column; the seed maps `name`/`sort_order` (categories) and six fields (methods) and drops `notes` in both.

**(iii) The N/A method arrives first.** Trigger `seed_na_rows_on_project_insert` calls
`seed_project_na_rows(p_project uuid)` (SECURITY DEFINER, `search_path 'public'`) on project insert, adding
`N/A - Labels Only` at `sort_order = max+1000`, **before** the client seeds the 9 defaults. The nine are
`Rent-Hardware | Rent-Main | Rent-Production | Rent-Rehearsal | Rent-Sitzprobe | Rent-QT | Rent-Cable | Buy-Shop |
House` — none collides, so this is safe today. It is recorded because `methods` has `UNIQUE (project_id, name)`: add
a default named `N/A - Labels Only` and the whole nine-row insert fails, and by (i) fails silently.

**Useful precedent:** `seed_project_na_rows` is proof that server-side seeding on project creation is already the
house idiom. The seeding RPC in §5 is the same pattern, widened.

### 2.3 Who can write the shared shelves — and the grant nobody has looked at

Policies on the four existing global tables (`pg_policies`): **one SELECT policy each**, role `authenticated`,
`qual = true`. RLS enabled on all four, not forced. No INSERT, UPDATE or DELETE policy anywhere. The 23 categories
and 9 methods arrived by migration. All of that matches the DEFAULTS-ADMIN file.

⚠ **What the DEFAULTS-ADMIN file does not say, and it changes the migration.** Adding write policies is *not enough*.
`information_schema.role_table_grants`:

| Table | `authenticated` holds |
|---|---|
| `global_default_categories` (and the other three global tables) | **SELECT only** |
| `box_types`, `cable_types`, `categories`, `methods`, `equipment_library_items` | SELECT, INSERT, UPDATE, DELETE |

The house pattern is a full DML grant to `authenticated` with RLS doing the gating. The global tables were built
read-only at the **grant** layer. A policy-only migration would leave every admin write refused with SQLSTATE
**42501 (insufficient privilege)** and the policy never consulted — and the rehearsal would "pass" if it only checked
that a non-admin write was refused. §5 takes a different route that needs no DML grant at all.

Two stray grants on the same four tables, for the record: `anon` holds REFERENCES and TRIGGER, `service_role` holds
REFERENCES, TRIGGER and **TRUNCATE** but no SELECT or DML. That is SECURITY-PREPUBLIC's "residual truncate grants"
and "grant-restore sweep" showing up here. Not this unit's to fix; named so it is not rediscovered.

### 2.4 The admin check exists and is currently false for everyone, including you

```
public.is_admin() → boolean, LANGUAGE sql, STABLE, SECURITY DEFINER, SET search_path TO ''
  select exists (select 1 from registry.admins a where a.user_id = auth.uid());
```

`registry.admins` has columns `user_id, granted_at, granted_by, note` and **0 rows**. The Roadmap's REGISTRY-REST
row says the registry tables read 0 by design until the licensing import runs. The consequence for this work is
concrete: **any policy or function keyed on `is_admin()` locks you out too, until a row exists for your account.**
That row is part of this migration (§5.4), and it is written as a lookup by your email address, not a pasted id.

`is_admin` appears in `src/types/database.generated.ts:3104` and **nowhere else in `src/`**. There is no `/admin`
route. This unit would be the first caller.

### 2.5 The five existing grids cannot be pointed at shared content

| Component | Lines | Scoping |
|---|---|---|
| `equipment/EquipmentLibraryClient.tsx` | 972 | `projectId` ×9, `snapshotBefore(supabase, projectId, 'change_all', …)`, routes to `/project/${projectId}/equipment` |
| `equipment/MethodsAdminClient.tsx` | 733 | `projectId` ×11, `queryKeys.methods(projectId)`, `.eq('project_id', projectId)` |
| `boxes/BoxTypesAdminClient.tsx` | 653 | `projectId` ×11, `queryKeys.boxTypes(projectId)`, `fetchBoxTypes(supabase, projectId)` |
| `equipment/CategoriesAdminClient.tsx` | 617 | `projectId` ×8, `snapshotBefore(supabase, projectId, reason, …)` |
| `cable/CableTypesClient.tsx` | 232 | `projectId` ×7, `queryKeys.cableTypes(projectId)` |
| `equipment/workbook/WorkbookLibraryImportModal.tsx` | 385 | `projectId`, `snapshotBefore`, RPC with `p_project_id` |

**3,207 lines of grid plus a 385-line import, every one of them keyed on a project id through
`queryKeys.<thing>(projectId)`, and three of them writing a version-history guard that has no shared-content
equivalent.** The DEFAULTS-ADMIN file's proposal to reuse "the existing grid it mirrors … not new grids" reads well
but is not available: these are not grids with a scope prop, they are project screens. Reuse here means a fork or a
re-parameterisation of all six. That measurement is the single biggest input to the recommendation in §3.

### 2.6 What version history already covers

`snapshot_project_v1(p_project_id, p_reason, p_label)` builds a payload with **20 keys**:
`box_details, box_types, bundles, cable_details, cable_mult_lines, cable_types, cast_members, categories, circuits,
cover_letters, equipment_items, link_group_members, link_groups, maintenance_history, methods, project,
rf_device_details, tail_details, walkie_assignments, walkie_channels`.

**Four of the five default kinds — categories, methods, cable_types, box_types — are already in it.**
`equipment_library_items` is read by the function only through `v_lib_hash`; it is **not** a payload key. That
confirms VERHIST-REST's "twenty tables and the project library is not one of them" and matches what the sibling
LIBRARY parallel was opened to close. If the library joins the payload, **all five** default sets get version history
under the recommendation in §3, with no work of their own.

### 2.7 Column and constraint drift between the shared shelves and the show tables

Measured in `src/types/database.generated.ts` and `pg_constraint`. Every one of these is a mapping the seed or the
publish has to make, and two are outright defects.

| | Show table | Shared table | Note |
|---|---|---|---|
| Library | `equipment_library_items` has `starred, ignored, is_rf_gear, is_equipment, has_tails` | `global_equipment_library` has none of them | The SEED-DEFAULTS file said so; confirmed. Seed writes the column defaults. |
| Cable types | `branch_cable_type_id` (FK → `cable_types`), `tail_method_id` (FK → `methods`) | `branch_cable_type_model` (text), `tail_method_name` (text) | Correct design — a shared row cannot hold a project's id. Resolution is by name in both directions. |
| Cable types | has `library_tier` | absent | Decide whether a default carries a tier. |
| Cable types | ⚠ `CHECK default_label_size IN ('big','small','both','none')` | ⚠ `CHECK default_label_size IN ('big','small')` | **Defect.** `labelSizeFromChecks` (`src/lib/cable/cableTypeForm.ts:26`) returns all four; migration `ctf_widen_default_label_size_check` widened the **show** table and left the shared one behind. A default cable type labelled "both" or "none" **cannot be stored** today. Fixed in §5.2. |
| Methods | has `is_system`, `product_cost` | absent (has `notes`) | `is_system` is correct to omit. `notes` is dropped by the seed — defect (ii). |
| Library | ⚠ **no unique key at all** | ⚠ **no unique key at all** | **Defect.** Re-publishing or re-seeding duplicates every model. Fixed in §5.3. |
| Box types | no unique key on `(project_id, type_name)` | table absent | Same class. §5.3 gives the shared table `UNIQUE (type_name)`; the show-side key is BATCH-BOX's "name uniqueness", not this unit's. |
| Categories / methods / cable types | `UNIQUE (project_id, name / model_name)` | `UNIQUE (name / model_name)` | Fine. But see §4.4 — a seed into a show that already has rows can collide, which by defect (i) fails silently. |

**Name-based resolution is already the house idiom**, so the seed does not invent one.
`src/lib/cable/cableTypeForm.ts:163` — *"FK columns (branch_cable_type_id, tail_method_id) are resolved by the CALLER
(set-existing-only, null on no-match — never invented here)"* — and `src/lib/import/map.ts:1257` resolves v1's
`Method` to `tail_method_id` **by name, server-side**, with `branch_cable_type_id` back-patched in a second pass
(migration 55). The seed uses the same shape: insert methods and cable types first, then a second pass patches
`tail_method_id` and `branch_cable_type_id` by name within the new project.

### 2.8 Scale

- `equipment_library_items`: **39,557 rows across 23 of 29 projects**; the largest single project's library is
  **2,634 rows**. So "~2,450" in the SEED-DEFAULTS file is the right order of magnitude; 2,634 is the measured
  worst case to rehearse against.
- Brief v1.2 line 266 records `global_equipment_library` as *"system-wide; empty, awaiting 2,379-item import"*.
- **Every new show seeded with the library gains ~2,500 rows at creation.** At beta scale that is nothing. It is
  stated because it is the true cost of the Equipment Library switch being on by default, and it is question Q4.

### 2.9 What the cohort has been shown

Every member who created a show was offered five switches, all pre-ticked, and got two. That is
DEAD-CONTROL-IS-A-BUG, and the SEED-DEFAULTS file states it correctly.

---

## 3 · The design: where the defaults live

Three ways to do this. I measured all three; one is clearly better.

### Path A — five admin grids over the shared tables *(what the TO-MAINLINE assumed)*

Add `global_box_types`, add write policies **and the missing DML grants** to all five shared tables, build
`/admin/defaults` with five tabs, each a fork of the project screen it mirrors, plus a forked spreadsheet import.

- **Cost:** 3,207 lines of grid + 385 lines of import to fork or re-parameterise (§2.5); a new admin shell; three to
  four CC units.
- **No version history, no undo.** Shared tables are not covered by `snapshot_project_v1`, which is per project. A
  bulk delete on a shared set is unrecoverable. That is exactly the hazard the DEFAULTS-ADMIN file raised, and its
  proposed answer — an "export this set" button — is a manual habit standing in for a backup.
- **Widens writes.** `authenticated` gains INSERT/UPDATE/DELETE on five shared tables, with RLS the only thing
  standing between any signed-in member and your defaults. One bad policy and the blast radius is every account.

### Path B — a *Defaults* show, and a Publish button *(recommended)*

Your defaults are curated in an ordinary Minotaur project. A small admin page publishes chosen sets from that
project into the shared tables. New shows keep reading the shared tables exactly as they do today.

- **No new grids.** You edit in the real screens. §2.5's 3,592 lines are used, not forked.
- **Version history for four of five sets today** (§2.6), all five once the library joins the payload.
- **Import and "copy from one of my projects" are already built** — any show can be the source, including a fresh
  v1 import.
- **Writes get *narrower*, not wider.** Publish is one `SECURITY DEFINER` function that checks `is_admin()` and
  raises otherwise. `authenticated` needs **no** DML grant on any shared table — the SELECT-only grants in §2.3 stay
  exactly as they are. Compared with today, the only new capability any account gains is EXECUTE on a function that
  refuses them.
- **Nothing about anyone's projects is exposed.** Members read the shared tables, as now. No project-scoped read
  policy changes.
- **Undo is real.** The source show is the durable copy, it has snapshots, and Publish is a single deliberate act
  with a visible before/after count.
- **Cost:** two steps instead of one, and a way to see an unpublished change. Handled in §4.2.
- **Maintenance tax, stated plainly:** two shapes to keep in step — show tables and shared tables. That tax has
  already accrued: the `default_label_size` divergence in §2.7 is what it looks like when nobody pays it. §5.6's
  drift check makes the next divergence fail loudly instead of silently.

### Path C — every account reads the *Defaults* show directly *(rejected)*

Skip the shared tables; flag one project as the defaults source and let every signed-in account SELECT its
categories, methods, cable types, box types and library rows.

Simplest on paper — one mapping instead of two, no publish step. **Rejected**, for two reasons worth your knowing:

1. It requires a **read carve-out on five project-scoped tables** so that strangers can read rows belonging to a
   project they are not members of. That is a permanent hole in the one rule the whole permission model rests on
   (`project_id in (select id from projects where owner_id = auth.uid())`, Brief v1.2 line 286), opened for the
   convenience of one project. SHARING/REV-B and your "option C" both point the other way.
2. Deleting or renaming that project would break new-show creation for every account, with no guard the schema can
   express cheaply.

### Recommendation

**Path B.** It is less work, it is the only one of the three where the defaults get version history, and it makes the
permission surface tighter than it is today rather than looser. If you would rather have the five grids after all —
because you want to edit a default without a show in the way — say so and Path A is specified and built; it is more
work, not impossible work.

**Ruling needed: Q1 in §7.**

---

## 4 · The design in detail (Path B)

### 4.1 The shapes

- **The source** is an ordinary project. Nothing marks it in the schema — the admin page remembers the last one used
  and lets you pick another, so "copy from one of my projects" is not a feature, it is the only mechanism.
- **The shelves** are the five shared tables: the four that exist, plus `global_box_types`.
- **Publish** (`publish_defaults`) copies the chosen sets from the chosen project to the shelves, replacing what is
  there per kind, inside one transaction.
- **Seed** (`seed_project_defaults`) copies the shelves into a new project, inside one transaction.

### 4.2 The admin screen

An admin-only route, proposal **(c)**: `/admin/defaults`. Refused **server-side** to non-admins — a layout-level
`is_admin()` check that returns a 404, not a hidden link. One page, no tabs, five rows:

| Set | On the shelf | In *Defaults* | Last published | |
|---|---|---|---|---|
| Categories | 23 | 24 | 12 Sep · **1 row differs** | ☐ Publish · Export |
| Methods | 9 | 9 | 12 Sep · in step | ☐ Publish · Export |
| Equipment Library | 0 | 2,634 | never | ☐ Publish · Export |
| Cable & Tail Types | 0 | 41 | never | ☐ Publish · Export |
| Box Types | — | 18 | never | ☐ Publish · Export |

- A **source picker** at the top — any project you own or are a member of.
- **Publish** takes the ticked rows only, and shows a confirmation naming what it will replace ("Replace 23 shared
  categories with the 24 in *Defaults*?"). Replacing, not merging, is the proposal **(c)**; merging is Q3.
- **Export** downloads the shelf as a spreadsheet, per the DEFAULTS-ADMIN file's proposal, kept because it is cheap
  and it is the only copy that survives you deleting the source show.
- **"In step" / "N rows differ"** is the answer to Path B's one real weakness: an unpublished change is visible the
  moment the page opens.
- No add / edit / delete on this page at all. Those happen in the show. That is the whole point.

**What every other account sees:** nothing. No link, no route, a 404 on a typed URL. Members keep reading the
shelves at project creation and never learn the screen exists.

### 4.3 What happens when you change a default later

**Existing shows are untouched. Always.** I argued the other side and it does not survive:

- A show's equipment list is a production and commercial document. A category renaming itself underneath a show that
  has already been printed and sent to a shop is the worst failure this product can have.
- Version history would show a change nobody made, which is worse than no history.
- Will's own framing points to pull, not push — the SEED-DEFAULTS file already promises him that *"existing shows can
  pull the same defaults by import."*

So: defaults are **copied at creation**, never linked. To bring a running show up to date, you pull — proposal
**(c)**: a *"Pull defaults"* action inside a show that runs the same seed against an existing project, adding only
what is missing by name and never overwriting a row that is already there. That is a small extension of the same
RPC, and it is what Will actually asked for. **Q5** is whether it rides this unit or waits.

### 4.4 Seeding, in order, and why order matters

One server-side call, `seed_project_defaults(p_project_id, p_kinds)`, replacing the three TODOs *and* the two
client-side inserts. In a fixed order:

1. **Categories** — so the library's `category` values match show categories by construction. This is what narrows
   CAT-FILL-MISS for new shows, exactly as the SEED-DEFAULTS file says.
2. **Methods** — before cable types, which reference a method by name.
3. **Equipment library** — after categories.
4. **Cable and tail types** — then a second pass resolving `tail_method_id` and `branch_cable_type_id` by name
   within the new project (§2.7).
5. **Box types.**

Two properties the RPC must have, both of which today's code lacks:

- **Atomic.** A failure at step 4 leaves a show with nothing seeded, not a show with three sets. Today a failure
  leaves a created project and the message *"Failed to seed project defaults"* — or, by defect (i), no message at
  all.
- **Idempotent.** `on conflict … do nothing` on every kind, which is what makes "Pull defaults" (§4.3) the same
  function and what makes a retry safe. This is why the shared library and box tables need the unique keys in §5.3.

**One interaction to hand to the build session.** `categories`, `methods` and `cable_types` all carry
`UNIQUE (project_id, name | model_name)`. NEWPROJ-IMPORT puts an import-from-v1 button on this same screen, so a show
can be seeded *and* imported in one gesture — and the v1 import will meet seeded rows with the same names. With
`on conflict do nothing` that is benign. Without it, and with defect (i) still in place, it is a silent half-seed.
The two rows are on the same file and the same screen; the main line should batch them, as the SEED-DEFAULTS file
already says.

### 4.5 The last small thing

Every switch gets a subtitle in the shape of the two that have one — proposal **(c)**, from the SEED-DEFAULTS file,
kept. Suggested wording is in §7's Q6, because the copy is Comms', not mine.

---

## 5 · The migration proposal

**One migration, Trigger B, rehearsed and applied by the main line, never inside a CC run.** Ledger **83** at the
time of writing, so this lands as **84**. Proposed name:
`<ts>_defaults_shared_content_publish_and_seed.sql`.

### 5.1 `global_box_types`

Mirrors `box_types` minus `project_id`. Columns, from the generated types:
`id uuid pk default gen_random_uuid()`, `type_name text not null`, `dimensions text`, `width text`, `depth text`,
`height text`, `weight_lbs numeric`, `volume numeric`, `notes text`.
Exact types are taken from `information_schema.columns` on `box_types` at rehearsal, not from the TypeScript.
`ALTER TABLE … ENABLE ROW LEVEL SECURITY`; one policy, matching the other four exactly:

```
create policy global_box_types_read on public.global_box_types
  for select to authenticated using (true);
```

`GRANT SELECT ON public.global_box_types TO authenticated;` — **and nothing else**, matching §2.3's existing shape.

### 5.2 The `default_label_size` fix

`global_cable_types`' check allows `('big','small')`; the show table allows `('big','small','both','none')`; the app
produces all four (§2.7). Drop and recreate the shared check to the four-value list. Zero rows are affected — the
table is empty — which makes this the cheapest moment there will ever be to fix it.

### 5.3 The two missing unique keys

- `create unique index … on public.global_equipment_library (model)` — today none exists, so a second publish
  duplicates every row.
- `unique (type_name)` on `global_box_types` at creation.

Both are what make `on conflict do nothing` possible in §4.4, and both are free today because both tables are empty.
If either would fail on a duplicate at rehearsal time, the rehearsal says so before anything is applied.

### 5.4 The first admin row

`registry.admins` is empty, so `is_admin()` is false for every account including yours (§2.4). One insert, written as
a lookup so no identifier is pasted by hand:

```
insert into registry.admins (user_id, note)
select id, 'defaults admin — migration 84'
from auth.users where email = 'daniel@daniellundberg.com'
on conflict (user_id) do nothing;
```

⚠ **This is REGISTRY-REST's table.** The Roadmap says the registry reads 0 rows by design until the licensing import
runs, and *"do not write competing rows."* One admin row is not a competing licence row, but it is that parallel's
surface. **The main line must check the licence-management return before this migration is applied** — if that
parallel has designed the admin shell, `/admin/defaults` is a section inside it, not a second admin area. Named as a
dependency, not resolved here.

### 5.5 The two functions

Both `SECURITY DEFINER`, `SET search_path TO ''`, matching `is_admin()` and `seed_project_na_rows`.

**`public.publish_defaults(p_project_id uuid, p_kinds text[]) returns jsonb`**

```
if not public.is_admin() then
  raise exception 'not authorised' using errcode = '42501';
end if;
```

Then, per kind in `p_kinds`, inside the one transaction: verify the caller is a member of `p_project_id`; delete the
shelf; insert from the project, mapping per §2.7 (`branch_cable_type_id` → `branch_cable_type_model` and
`tail_method_id` → `tail_method_name` by name lookup; the five library booleans dropped). Returns before/after
counts per kind as `jsonb`, which is what the screen's confirmation and the drift counter read.

**`public.seed_project_defaults(p_project_id uuid, p_kinds text[]) returns jsonb`**

Caller must own or be a member of `p_project_id`. Seeds in §4.4's order, `on conflict do nothing` throughout, second
pass for the two cable-type FKs, returns per-kind counts. Called once by the new-project screen; called again, with
the same guarantees, by "Pull defaults" if Q5 says yes.

**Grants:** `GRANT EXECUTE ON FUNCTION public.publish_defaults(uuid, text[]) TO authenticated;` and the same for
`seed_project_defaults`. **No table DML grant to `authenticated` anywhere in this migration.** `publish_defaults`
refuses non-admins in its own body and raises; `seed_project_defaults` is open to any signed-in user, because
creating a show is.

### 5.6 The drift check

A small `SELECT`-only assertion, run at rehearsal and kept as a test: for each of the five pairs, the shared table's
columns and check constraints are compared with the show table's, and any column present on the show table and
absent from the shelf that is **not** on a declared exception list (`project_id`, `owner_id`, `created_at`,
`updated_at`, `starred`, `ignored`, `is_rf_gear`, `is_equipment`, `has_tails`, `is_system`, `product_cost`,
`library_tier`, the two FK columns) fails it. This is the answer to Path B's maintenance tax — the next divergence
fails a test instead of silently refusing to store a value, which is how §2.7's `default_label_size` bug survived.

### 5.7 What to measure at rehearsal

Per O-11: live introspection → proof-run with forced rollback → residue check → Trigger B and your confirm → apply →
verify, grants included.

Inside the forced rollback:

1. **Counts before and after** on all five shared tables, and on a scratch project's five sets.
2. ⚠ **A non-admin `select publish_defaults(…)` RAISES.** SQLSTATE `42501`, not "zero rows", not a null return.
   This is the DEFAULTS-ADMIN file's own bar and it is the one test that must not be waved through: a refused write
   that returns quietly is the VIEWER-ROLE failure class, recorded on the Roadmap in those words.
3. **An admin publish moves exactly the source project's counts** — five equalities, per kind.
4. **A second publish of the same sets changes nothing** (idempotence).
5. **`seed_project_defaults` on a scratch project** yields five counts equal to the shelves; **run twice, no
   duplicates** — this is what the §5.3 unique keys are for, and it fails today on the library.
6. **Atomicity:** force a failure at step 4 of §4.4 and prove the scratch project has **zero** seeded rows, not
   three sets.
7. **Timing on the library leg at 2,634 rows** (§2.8's measured worst case), compared against the 90-second import
   ceiling. The seed is a single server-side insert-select, so it should be far under; if it is not, that is
   IMPORT-REMEASURE's territory and the main line should know before the switch ships on by default.
8. **Grants re-read after every DDL statement** — `information_schema.role_table_grants` for all five tables plus
   `has_function_privilege` for the two functions. The four existing tables must still read **SELECT only** for
   `authenticated` afterwards; if any of them has gained DML, the migration is wrong.
9. **Residue check:** no orphaned policy, index, function or grant; `supabase_migrations.schema_migrations` reads
   **84** and the file of record exists.
10. **The drift check of §5.6 passes** on all five pairs.

**Not in this migration:** the `anon` REFERENCES/TRIGGER and `service_role` TRUNCATE strays of §2.3. They belong to
SECURITY-PREPUBLIC's grant sweep. They could ride here since these tables are already open on the table — that is
your call, and my lean is **no**, because a security sweep deserves its own rehearsal rather than a ride-along.

---

## 6 · What the build session must do, and must not

**Must not:** pick any content. Not a category, not a method, not a cable type, not a library row. Your ruling of
2026-09-22 — *"ask me for it when building it"* — binds the building session, and nothing in this file proposes a
single default value.

**Must:** stop at each of the five sets and ask you for it, set by set, before loading anything. §7's Q7 is written
so that conversation happens **once**, at the top of the build, rather than five times mid-unit.

---

## 7 · The questions, batched

Seven. Each is a word, except the last, which is a list.

**Q1 · The mechanism.** **Path B** (curate in a *Defaults* show, press Publish) or **Path A** (five new admin grids)?
*My lean: B — it is less work, and it is the only one where your defaults get version history.*

**Q2 · Existing shows when you change a default later — untouched, yes?**
*My lean: yes, always. §4.3 gives the reasoning; I would need a strong reason to build it any other way.*

**Q3 · Publish replaces, or merges?** Replace = the shelf becomes exactly what is in *Defaults*. Merge = new rows
added, nothing removed. *My lean: replace, with the confirmation naming the count.*

**Q4 · Does the Equipment Library switch stay ON by default?** It adds ~2,500 rows to every new show (§2.8). The
other four are small. *My lean: yes, on — it is what makes a new show usable on day one, and the row count is
irrelevant at this scale.*

**Q5 · "Pull defaults" into an existing show — this unit, or later?** It is a small extension of the same function
(§4.3), and it is what you already promised Will. *My lean: this unit, because the function exists either way.*

**Q6 · The three missing switch subtitles** — do you want to write them, or should Comms? *My lean: Comms, in the
shape of the two you already have.*

**Q7 · The five sets — exactly what the build session will ask you for.** Answer these when the build starts, not
now:

| # | Set | Shelf | On the shelf today | What is wanted |
|---|---|---|---|---|
| 1 | **Categories** | `global_default_categories` | **23 rows** | Keep the 23, or a replacement list? These are what seeds today. |
| 2 | **Methods** | `global_default_methods` | **9 rows** | Keep the nine (`Rent-Hardware, Rent-Main, Rent-Production, Rent-Rehearsal, Rent-Sitzprobe, Rent-QT, Rent-Cable, Buy-Shop, House`), or a replacement list — with each one's shop-order header, sort order, colour and multiplier? |
| 3 | **Equipment Library** | `global_equipment_library` | **0 rows** | Which source — the `DL_Equipment_Library` spreadsheet, or a named show of yours? ⚠ **EQUIPLIB's refinement pass is mid-flight**, so this one may be worth waiting on, or publishing now and re-publishing when EQUIPLIB lands. Brief v1.2 expects ~2,379 items; the biggest real library measured is 2,634. **Your word on timing.** |
| 4 | **Cable and Tail Types** | `global_cable_types` | **0 rows** | Which source show? Note there is no separate tail-types set — tails are fields on a cable type (§2.1). |
| 5 | **Box Types** | `global_box_types` *(new)* | table does not exist | Which source show? |

---

## 8 · Main-line material — stated, not acted on

Nothing below has been written anywhere. No governing document was touched.

**Rows.** SEED-DEFAULTS and DEFAULTS-ADMIN are not yet on the Docket; the Will Pickens index has the main line
placing them after cable splits, at its next close. Both rows should carry:

- **DEFAULTS-ADMIN gains a dependency:** check the licence-management parallel's return before the migration is
  applied — the `registry.admins` row and the admin shell are REGISTRY-REST's surface (§5.4), and the index file
  already says "one admin area with two sections, not two admin areas."
- **SEED-DEFAULTS absorbs the silent-seed defect (i)**, which is not a new row — it is inside the file this unit
  rewrites and must be fixed in the same breath. It should be named in the row so it is not lost.
- **NEWPROJ-IMPORT batches with SEED-DEFAULTS** — same file, same screen, and §4.4's unique-key interaction is
  between them. The SEED-DEFAULTS file says so; this measures why.
- **CAT-FILL-MISS narrows** for new shows once categories seed before the library (§4.4). It does not close.

**Ledger material** (measurements that must land somewhere or they did not happen): §2.3's grant asymmetry, §2.4's
empty `registry.admins`, §2.5's 3,592 lines, §2.6's twenty payload keys with the library absent, §2.7's whole table,
§2.8's 39,557 / 2,634 / 23-of-29.

**Propagation.** Two claims elsewhere become wrong if Path B is ruled:

1. **Brief v1.2 line 266** — *"`global_equipment_library` (system-wide; empty, awaiting 2,379-item import)"*. Under
   Path B the import goes into a *Defaults* show and is published, and the item count comes from you, not from this
   line. The Brief's technical sections are Arch's to propose and yours to confirm.
2. **The DEFAULTS-ADMIN file's own §2** — *"policies … with grants restored and verified"* and *"reusing the
   existing grid it mirrors … not new grids"*. §2.3 and §2.5 correct both. The file stays as the record of the
   ruling; the correction lives here and in the Ledger.

**SECURITY-PREPUBLIC** gains a named item: the `anon` REFERENCES/TRIGGER and `service_role` TRUNCATE grants on the
four shared tables (§2.3), found here, deliberately not fixed here.

**VERHIST-REST's library question** is answered from this side too: `equipment_library_items` is read by
`snapshot_project_v1` only through `v_lib_hash` and is not one of the twenty payload keys (§2.6). The sibling LIBRARY
parallel owns the answer; this is corroboration from an independent read, and the two returns should agree.

**Keep Will Pickens updated.** Both rows carry it. **MAILGATE holds — Daniel sends it.** When this ships, the line to
Will covers his *"a Default Cable Type Library"* and *"a Default Box Type Library"* together, and mentions that an
existing show can pull the same defaults (§4.3, if Q5 is yes). One message, not two.

---

## 9 · Measured at

Code HEAD **`d25d366`** = `origin/main`, read from `.git/refs/heads/main` and `.git/refs/remotes/origin/main`; git
never run. Database **`musfmquwwjlggyxckpos`** (`minotaur-v2`, PostgreSQL 17.6), read-only: `pg_policies`,
`pg_constraint`, `pg_class`, `pg_proc`, `information_schema.columns`, `information_schema.role_table_grants`,
`supabase_migrations.schema_migrations`, and aggregate counts. **No project content of any cohort member was read**
(USER-DATA-RULE, "option C", 2026-09-21). Files read at source: `src/app/dashboard/new/page.tsx`,
`src/types/database.generated.ts`, `src/lib/fetchAllRows.ts`, `src/lib/cable/cableTypeForm.ts`, the five grid
components and `WorkbookLibraryImportModal.tsx` (signatures and scoping), Architecture Prompt v39, Brief v1.2,
Roadmap v4.49, Session Log header, and the two TO-MAINLINE files with their index.

*End of DEFAULTS parallel return. The main line owns every write and install named above.*
