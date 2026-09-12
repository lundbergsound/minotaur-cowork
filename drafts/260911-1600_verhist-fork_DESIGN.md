# VERHIST-UI Leg 2 — the fork. Design from live introspection, 2026-09-11 16:00

**Status: DESIGNED, NOT REHEARSED, NOT APPLIED.** Trigger B. Arch's. Daniel confirms before any apply, and the rehearsal comes first.

**What it is:** `restore_snapshot_as_new_project_v1` — "Open as new production." A snapshot becomes a NEW project alongside the current one. Fork-only, never in place (Daniel, 2026-09-10).

---

## 1 · What a snapshot actually contains — measured, not remembered

Read from the newest live snapshot. The payload is **nineteen arrays plus a `project` object plus `schema_version`**, with the library and the identity map living outside it as content-hashed blobs.

`box_details` · `box_types` · `bundles` · `cable_details` · `cable_mult_lines` · `cable_types` · `cast_members` · `categories` · `circuits` · `cover_letters` · `equipment_items` · `link_group_members` · `link_groups` · `maintenance_history` · `methods` · `rf_device_details` · `tail_details` · `walkie_assignments` · `walkie_channels`.

Row counts on that snapshot, as a sense of scale: equipment 659 · link_group_members 1,342 · link_groups 606 · cable_mult_lines 603 · cable_details 461 · tails 175 · box_types 61 · cable_types 48 · categories 29 · bundles 26 · box_details 23 · methods 23. **≈4,000 rows for a mid-size production**, and the Tour is larger.

⚠ **`schema_version` exists in the payload and the restore MUST check it and refuse a payload it does not understand.** A restore that silently best-efforts an older shape is how a fork quietly loses a table.

---

## 2 · The two traps, both found by introspection before a line was written

⚠ **TRAP 1 — a new project seeds itself.** `seed_na_rows` is an AFTER INSERT trigger on `projects` calling `seed_na_rows_on_project_insert()`. **The instant the fork's project row is inserted, the new project already has N/A rows** — and the payload contains the source project's N/A rows too. Insert both and the fork has duplicates; the fork's whole promise is that it is the same production.

⚠ **TRAP 2 — and you cannot fix trap 1 by deleting the seeded rows.** `guard_system_method` is a BEFORE DELETE OR UPDATE trigger on `methods` firing `WHEN (old.is_system)`. **The seeded system rows refuse to be deleted or updated.**

**So the design is forced, and that is a good sign rather than a constraint:** the restore **maps** the payload's system rows onto the freshly seeded ones instead of inserting them. The seeded N/A method's new id becomes the remap target for the payload's N/A method id, and every child row pointing at the old one lands on the new one. The same question must be asked of categories and box types — whichever the seed function actually creates is measured in the rehearsal, not assumed here.

---

## 3 · The real work: a nineteen-table id remap in FK order

Every row in the payload carries its original UUID and those UUIDs are still in use by the source production, so **nothing can be inserted with its original id.** The restore mints a new id per row and rewrites every reference through one remap table, in dependency order — equipment spine first, then the details keyed on it (`box_details` and `rf_device_details` key on the spine id and carry NO `project_id`, which is the trap that would have captured zero boxes if the snapshot had filtered on `project_id` alone), then link groups before link group members, bundles before the cables that belong to them.

**The identity map is CARRIED and REMAPPED, not dropped** — Arch's call, and cheaper than it looked once everything is being remapped anyway. Dropping it makes the fork permanently un-re-importable against its v1 source; carrying it un-rewritten would point it at the source project's rows. Rewriting it through the same remap costs one more pass and leaves the fork a first-class production. The orphaned-identity-row residue (77.7% on CDMX) is a pre-existing condition of the source and is copied as-is, not repaired — repairing it here would make a restore silently different from what was backed up.

---

## 4 · The measurement the rehearsal has to make first

**Roughly 4,000 rows across nineteen tables, in one transaction, against an 8-second statement timeout.** `snapshot_project_v1` reads the same data in ~570 ms, but a write with per-row id minting and nineteen dependent rewrites is a different cost, and the Tour is several times this size.

⚠ **If it does not fit, the answer is not a bigger timeout.** The candidates, in preference order: a `SECURITY DEFINER` restore run outside the `authenticated` statement timeout; or a job row the client polls, which is a bigger product decision because it changes what the operator sees. **The rehearsal decides this and nothing is written until it has.**

## 5 · Sequence from here

Live introspection — **done, this document.** → proof-run in a transaction against a real production with a forced rollback → residue check proving the rollback clean → Daniel's explicit confirm → apply → post-apply verification including grants and privilege level, by running the calls rather than reading the grant table.

**Nothing is owed by Daniel until the confirm.**
