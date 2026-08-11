# S4-3 Schema Block — for the claude.ai Arch seat

**Authored 2026-08-11 · Cowork-Arch principal seat · Arch Prompt v29 §Seats · REV B (corrected against live generated types)**

> **STATUS: EXECUTED 2026-08-11.** Applied FROM the Cowork seat under Daniel's scoped SEAT-MIG exception, not carried to claude.ai. Migrations **41-44**; ledger 40 -> 44. Sections 1, 2, 3 and 5 are LIVE. **Still outstanding:** section 4 (the nesting cycle guard + resolve-up), the 56-row `global_default_box_types` seed (awaits Daniel's `Box Types.xlsx`), and section 7 (the Brief reconciliation, a doc edit not a migration). Kept as the design record; do not re-apply.

Design only. **No migrations were applied from Cowork.** Carry this block to the claude.ai Arch chat, where Supabase MCP applies it against the production database. Every item below is **Trigger B (Data/Security Boundary)** and gets the standing treatment: live introspection first, proof-run with forced rollback, residue check, apply, post-apply verification including a `SET LOCAL ROLE authenticated` probe and grant restoration.

**Live baseline:** migration ledger at **40**; HEAD `1f06092`. Verify both by live read before designing the migration, not from this document.

> **⚠ This block is a PREREQUISITE for the S4-3 overnight run, not a follow-on.** The Box List browse surface — the run's first leg — reads columns that do not exist yet (§1). Apply this before the run starts, or the run's first checkpoint fails.

---

## 0. What the corpus got wrong, and what v2 actually has

The P2b digest's NOTES were written from the reference corpus. Reading `src/types/database.generated.ts` directly corrects four of them:

- **N2 is half-built.** `box_details.within_box_id` exists. The nesting FK does not need creating — it needs a **cycle guard** and a **resolve-up path**.
- **OQ8 is nearly free.** `projects.box_logo_url` exists. Only the settings control and the label render are missing; no schema.
- **The defaults pattern is settled by precedent.** `projects` already carries `equip_default_*`, `cable_default_*`, `tail_default_*`, `bundle_default_*` as plain columns. Box defaults follow that shape; no new table.
- **N6's Star needs nothing.** `equipment_items.starred` already exists, and a box is an `equipment_items` row — boxes inherit it. *(This corrects REV A of this block, which proposed `box_details.starred`. Withdrawn.)*

**What a box actually has today.** Spine `equipment_items` (`type='box'`, name in `description`) supplies `starred · packed · drawn · remaining_quantity · quantity · group_label · category_id · method_id · box_id · public_notes · private_notes · model · sort_order`. Extension `box_details` supplies only `id · box_type_id · within_box_id · truck · category_override · model_override · num_large_labels · num_small_labels`.

`truck` is a plain text column — **N3 holds, no trucks table.**

There is **no `boxes` table**; the spine + `box_details` convention won (S4-AUTO leg 2). See §7.

---

## 1. `box_details` — the missing field set ⚠ BLOCKING

This is the largest and most urgent item. Ten of v1's Box List fields have no home in v2. The browse surface, the print, and the labels all read them.

| Column | Type | v1 source (`tables/Box List.md`) | Notes |
|---|---|---|---|
| `box_number` | `numeric null` | field 3 (Number) | **Must be numeric, not integer** — the Taco Truck print shows `8.5` slotting a parent between 8 and 9. Blank sorts first as its own block (evidenced). |
| `location` | `text null` | field 5 | Prints tinted with the box color (R-52). |
| `stack` | `text null` | field 4 | Free text. |
| `color_name` | `text null` | field 27 | One of the 14 Minotaur palette names. See the note below. |
| `header` | `text null` | field 17 | Auto-enters from the Box Defaults panel (§2). |
| `label_notes` | `text null` | field 9 | Distinct from the spine's public/private notes. |
| `return_notes` | `text null` | field 43 | |
| `additional_weight` | `numeric null` | field 31 | Additive fudge in the Weight rollup. |
| `actual_weight` | `numeric null` | field 36 | Manual override — wins over the rollup entirely. |
| `additional_cost` | `numeric null` | field 38 | Additive fudge in the Cost rollup. |
| `cat_photo` | `boolean not null default false` | field 53 | OQ7 ruled KEEP with a small render on the box row. |

**On `color_name` vs storing hex.** `methods` stores both `color_hex` and `color_name`. I propose boxes store **the palette name only** and resolve hex client-side from the canonical 14-color palette, because the palette is fixed in the Brief and storing hex invites the two drifting apart on a future palette edit. Named as a deliberate departure from the `methods` precedent — if the claude.ai seat's introspection shows the render path genuinely needs stored hex, follow `methods` instead and say so.

Do **not** port `Picture` (field 16) — deprecated, do-not-port, R-48. Do not port `HistoryID` — v2 has no box field-audit requirement (P2 ruled).

## 2. `projects` — the Box Defaults panel columns

**Ruling (OQ4, Daniel, Aug 11):** ship the per-project Box Defaults panel, seeded with v1's template constants. **Ruling (OQ5):** Warn/Over volume thresholds are **hard-coded at 23 / 27** and are NOT per-project — they drop off the panel entirely.

Add to `projects`, following the `equip_default_*` naming already in place:

| Column | Type | Ships as | v1 source |
|---|---|---|---|
| `box_default_large_labels` | `integer not null default 5` | 5 | template ConstantData "5" (Box List field 7) |
| `box_default_small_labels` | `integer not null default 0` | 0 | template ConstantData "0" (field 6) |
| `box_default_category_id` | `uuid null → categories` | 11.0 Racks and Boxes | Box Defaults panel |
| `box_default_method_id` | `uuid null → methods` | null | panel (BVSC ran Rent-Boxes; not a shipped constant) |
| `box_default_group` | `text null` | null | panel |
| `box_default_header` | `text null` | null | panel (field 17) |
| `box_default_set_remaining` | `boolean not null default false` | false | panel checkbox |

`box_details.num_large_labels` / `num_small_labels` already default 0 at the column level. **Leave those column defaults alone** — the panel supplies the value at insert, exactly as v1's auto-enter does. Encoding 5 as a column default would fight the panel.

**Asymmetry, disclosed not litigated:** `projects.bundle_warn_area_in2` / `bundle_over_area_in2` are per-project on the bundle side while box Warn/Over are now hard-coded. Daniel ruled the box side deliberately, and the reason is physical rather than preference: a well-packed box reads ~23% because of air and connector bodies, and past 27% it is too cramped to work in. Flagged for the record; no action proposed.

## 3. `box_types` — dimensions, volume, and the 56-row seed

Current shape: `id · project_id · type_name · dimensions (text) · weight_lbs · notes`.

**Ruling (OQ3, Daniel, Aug 11): volume is a stored, manually entered number representing the box's INTERIOR capacity. It is never computed from W×D×H, which are EXTERIOR dimensions.** These measure different things; deriving one from the other is a category error, not a simplification. Both v1 catalogs claim volume computes from W×D×H — **both are wrong**, and the DDR extraction is right (a plain editable Number, no script computes it, and it travels as its own column in the Box Types interchange). Registered as a **correction of record against Box-cat §3 and DDR-cat §1.7**.

**Consequence worth stating:** because nothing computes with W/D/H, they are **display-only** — they compose the "will it fit through the door" string and nothing else. That frees them to stay text and preserve v1's fractional entry (`14 1/2`).

- Split `dimensions` into `width · depth · height`, **all `text`**, nullable — v1's shape (`tables/Box Types.md` fields 2–4 are Text) and the reason for it. Introspect the existing `dimensions` column first: if any rows carry data, migrate it forward rather than dropping blind.
- Add `volume numeric null` — stored, user-entered, **no generated expression, no trigger**.
- Keep `weight_lbs` and `notes` (v2 additions beyond v1; no reason to remove).
- Box Size display strings (`W"xD"xH"` imperial / `W cm x D cm x H cm` metric, with graceful degradation when height or depth is blank) compose in the view or client off `projects.units`, which already exists. The v1 calcs are verbatim in `tables/Box Types.md` — port those, don't re-derive.
- **Box Count** (v1 field 5, `Count(Box List::Box Type)`) is a usage counter — a view column, not stored.

**The 56-row seed (D-9 shipped-data class).** v1 ships 56 Box Types with an Include/Ignore at first run. Follow the existing house precedent exactly: a system-wide `global_default_box_types` table seeded with the 56 rows, copied into a project's `box_types` at creation with an opt-out — the same relationship `global_default_methods` / `global_default_categories` already have. Do **not** invent a second pattern.

**Seed data dependency:** the 56 rows export from v1 via `scripts/777` to `Box Types.xlsx` (field order `Box Count · Box Type · Depth · Height · Volume · Width`). Daniel supplies that export; it is not in the corpus. **DDL and the copy-on-create path build now; the seed lands when the file does.**

## 4. `box_details` — the nesting cycle guard

`within_box_id` exists. What's missing:

- **A cycle guard.** v1 has none — the fields are free text and a loop would hang the calc chain. v2 forbids loops at write time; depth stays **uncapped** (R-50, July-11). Enforce **in the database**, not only the client: a `BEFORE INSERT OR UPDATE` trigger walking the ancestor chain and raising on self-reference or any repeat, or an equivalent recursive-CTE check. Client-side validation alone is not sufficient for a data-integrity invariant.
- **Resolve-up.** v1 computes Parent Box, Parent Number, and **Parent Truck** by walking to the **top-level ancestor** (fields 47/49/51). The by-truck print sorts on resolved `Parent Truck` while the browse sorts on the box's **own** truck — that difference is v1 truth and P6 ports it verbatim. Both keys must be available: expose the resolved ancestor values as a recursive view (or generated columns) alongside the stored `truck`. **Do not collapse them into one.**
- UX on an attempted cycle is ruled (OQ6): inline message beside the field, entry reverts, field stays open, no modal. Client-side; the trigger is the backstop.

## 5. P12 — the "N/A" system row, for methods and boxes

**Ruling (P12, Daniel, Aug 11):** the v1 magic values `Method "0"` and `Box "0"` become an **explicit state carried by a protected system row** — not a magic name, not a parallel boolean. `0` survives as an **input and search alias only**: typed into the field it commits the state, typed into find it returns those items, and the v1 importer maps incoming `"0"` strings onto it. **One shared predicate serves all three paths** — commit, find, import. Three implementations will drift; do not write three.

Strings ruled: method = **`N/A - Labels Only`** · box = **`N/A - No Box Needed`**. The shared `N/A - <reason>` prefix makes it one idiom; the tails differ because what's excluded differs.

Schema:

- `methods.is_system boolean not null default false`, plus a seeded `N/A - Labels Only` row per project, sorting last, rendering grey.
- The box side takes the **same shape**: a system `equipment_items` row of `type='box'` per project named `N/A - No Box Needed`, flagged, **filtered out of the Box List surface** but present in box pulldowns. The flag needs a home — either a `box_details` boolean or a spine-level `is_system`; the claude.ai seat picks based on live introspection.
- **Protect system rows from rename and delete at the data layer** (trigger or policy), not only in the UI. That protection is the entire advantage this design has over v1's magic record: a user cannot break the convention for a whole show.

**Why a system row rather than a boolean, stated so it can be challenged:** `box_id` and `method_id` stay plain foreign keys with no parallel flag to keep in sync; "is this N/A?" is one question asked of the referenced row in both cases; and Daniel's stated requirement — the entry sits at the bottom of every method pulldown — falls out for free. The cost is a row in the user's data they cannot see in the Box List. That cost is real and named. If live introspection surfaces a place it bites (RLS, uniqueness, the import path), raise it rather than working around it.

**Windowing semantics (M0-WIN, ruled Aug 11):** method-`N/A` items are **visible and editable on the on-screen equipment list** (banded last) and **excluded from the printed/exported equipment list, cable checklist, tail checklist, and Bundle Sheets**. The Bundle Sheet inclusion deliberately extends the 2026-07-21 rule to match what v1's `Layout-Bundle Sheets` actually does, and closes `s3g_census` §7 Q1. Box-`N/A` items are excluded from Box Contents output and do **not** trip the "things not in boxes" check. This is the PORT-READY leg-2 criterion; M0-WIN closes once built and gated.

## 6. Rollups — the cost correction

Box Weight / Volume / Cost / % Full aggregate the box's members. v1's calcs are verbatim in `tables/Box List.md` (fields 32/34/35/39) and port as-is with **one deliberate divergence**:

**Ruling (N4, Daniel, Aug 11): v1's box Cost is a bug and v2 fixes it.** v1 computes Cost as the equipment sub-summary plus the manual `additional_cost` fudge, **omitting cable member cost entirely** — a box packed with cable reads $0. v2 includes cable member cost. Registered as a deliberate v1 deviation: **box costs on cable-heavy shows will not match v1 output**, and that is the intended outcome.

Weight keeps its v1 shape exactly — `actual_weight` manual override wins; otherwise equipment members + `additional_weight` + cable members.

% Full = member volume ÷ `box_types.volume` × 100, error-guarded to empty when the type has no volume, with three hard-coded bands at `<23` / `23–27` / `≥27`.

## 7. N1 — the Brief §Data Model reconciliation

Brief v1.1 still lists project-detail tables **`cover_letters, boxes, box_types`**. Confirmed at HEAD `1f06092`: **there is no `boxes` table** in the schema. The convention of record is spine `equipment_items(type='box')` + 1:1 `box_details`.

Proposed Brief edit (technical section — Arch proposes, Daniel confirms): drop `boxes`; add `box_details` to the Equipment extension-table list alongside the other three; leave `box_types` under Project details. A Brief correction, not a schema change — it lands in the close package, not the migration.

---

## Application order

1. **`box_details` field set (§1)** — ⚠ blocking; nothing else in S4-3 renders without it.
2. `projects` box-default columns (§2) — depends on `categories`/`methods`, both live.
3. `box_types` extension (§3) — no dependencies.
4. `methods.is_system` + the two seeded system rows (§5).
5. The nesting cycle guard (§4) — last, because it is the only behavioral trigger in the set and wants a clean proof-run of its own.
6. `global_default_box_types` + copy-on-create (§3) — DDL now, 56-row seed when Daniel's `Box Types.xlsx` export lands.

Six migrations or one, at the claude.ai seat's judgment; the ledger moves from 40 accordingly.

**Sequencing consequence for the overnight run:** items 1–3 must be applied **before** the run starts. Items 4–6 can land in the morning if the run is scoped to stop short of the labels/Types-admin legs — but that scoping is Daniel's call, and the run's handoff must state which schema state it assumes and halt if it finds a different one.
