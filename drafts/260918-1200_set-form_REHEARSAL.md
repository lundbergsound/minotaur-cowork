# SET-FORM — rehearsal record, 2026-09-18 (Arch, pre-apply)

Status: rehearsed under forced rollback, NOT applied. Awaiting Daniel's Trigger B.
Ledger before: 76 (live-read). Policies 120, md5 8e4f52933062cac0e338679f28badcc7. Grants (public tables) 648, md5 739fb917eb943cf89ada907b34b4e0bb.

## What it does
One SECURITY DEFINER set function `readable_project_ids()` (owner OR accepted member — the same two arms as `can_read_project`), EXECUTE to `authenticated` only (mirrors the helpers' ACL). The READ policy on 26 tables tests membership in that set, which the planner evaluates ONCE per query instead of calling the helper once per row. Write policies untouched. `projects` and `project_members` untouched (the New Project outage family).
- 23 tables: `project_id in (select public.readable_project_ids())`
- equipment_library_items: owner arm kept, wrapped `(select auth.uid())`
- box_details, rf_device_details: SCALAR correlated form `(select ei.project_id from equipment_items ei where ei.id = <t>.id) in (select readable_project_ids())` — PK lookup per row, no helper call.
  ⚠ The EXISTS form was rehearsed first and REJECTED: the planner pulled it up into a hashed semi-join over ALL visible equipment_items (seq scan, 5,433 rows for the editor) — the grows-with-other-people's-shows shape migration 75 removed. The scalar form cannot be pulled up.

## Rehearsal (forced rollback, final form)
Synthetic in-transaction memberships on Cable Parity Fixture: a viewer (fec211cc) and an UNACCEPTED editor (c88a33b0). Identities: owner 82695c57, real editor 9f16ae29, viewer, unaccepted, non-member 23af3c17.
- **140 found sets compared (28 tables × 5 identities, incl. projects and project_members as controls) by md5 of sorted ids: 0 differ.**
- Editor box_details 181 / `c806be4465eda355b6acdaa5c5566845` — the same hash migration 75 recorded.
- Editor INSERT…RETURNING equipment_items 1 · UPDATE…RETURNING 1 · INSERT/DELETE…RETURNING categories 1/1.
- New Project path as the non-member: project INSERT…RETURNING ok; first item INSERT…RETURNING ok; non-member reads CPF items 0.
- Viewer INSERT refused 42501.
- Plans: set evaluated loops=1 on equipment list and box list; box list = equipment_items_pkey lookup ×247.
- Residue after: projects 19, members 16, probe rows 0, function absent, policies md5 unchanged.

## Before (settled, warm, 5 runs, real RLS, not in a DDL txn) — Cable Parity Fixture, 2,784 items
- editor equipment list: 63.92 65.76 65.94 65.29 65.93 ms
- editor box_details: 10.67 10.72 10.60 10.61 10.66 ms
- owner equipment list: 48.55 48.38 47.52 47.67 47.54 ms
- owner box_details: 9.04 8.90 8.83 8.70 8.79 ms
PREDICTION (not a measurement): equipment list ≈2–3 ms for both; box list ≈1–2 ms. Migration 75's prediction missed 3.5×; this one is stated to be checked.

## Reversal — the 26 read policies as captured before apply (POLICY-CAPTURE-FIRST)
```sql
alter policy box_details_read on public.box_details using ((EXISTS ( SELECT 1 FROM equipment_items ei WHERE ((ei.id = box_details.id) AND can_read_project(ei.project_id)))));
alter policy box_types_read on public.box_types using (can_read_project(project_id));
alter policy bundles_read on public.bundles using (can_read_project(project_id));
alter policy cable_details_read on public.cable_details using (can_read_project(project_id));
alter policy cable_mult_lines_read on public.cable_mult_lines using (can_read_project(project_id));
alter policy cable_types_read on public.cable_types using (can_read_project(project_id));
alter policy cast_members_read on public.cast_members using (can_read_project(project_id));
alter policy categories_read on public.categories using (can_read_project(project_id));
alter policy circuits_read on public.circuits using (can_read_project(project_id));
alter policy cover_letters_read on public.cover_letters using (can_read_project(project_id));
alter policy equipment_items_read on public.equipment_items using (can_read_project(project_id));
alter policy equipment_library_items_read on public.equipment_library_items using (((owner_id = auth.uid()) OR can_read_project(project_id)));
alter policy equipment_list_revisions_read on public.equipment_list_revisions using (can_read_project(project_id));
alter policy import_identity_map_read on public.import_identity_map using (can_read_project(project_id));
alter policy import_runs_read on public.import_runs using (can_read_project(project_id));
alter policy link_group_members_read on public.link_group_members using (can_read_project(project_id));
alter policy link_groups_read on public.link_groups using (can_read_project(project_id));
alter policy maintenance_history_read on public.maintenance_history using (can_read_project(project_id));
alter policy methods_read on public.methods using (can_read_project(project_id));
alter policy project_blobs_read on public.project_blobs using (can_read_project(project_id));
alter policy project_features_read on public.project_features using (can_read_project(project_id));
alter policy project_snapshots_read on public.project_snapshots using (can_read_project(project_id));
alter policy rf_device_details_read on public.rf_device_details using ((id IN ( SELECT ei.id FROM equipment_items ei WHERE can_read_project(ei.project_id))));
alter policy tail_details_read on public.tail_details using (can_read_project(project_id));
alter policy walkie_assignments_read on public.walkie_assignments using (can_read_project(project_id));
alter policy walkie_channels_read on public.walkie_channels using (can_read_project(project_id));
-- then: drop function public.readable_project_ids();
```

## The candidate migration (md5 of body file ab70e129f80f7731bbec47134395e1b8)

File: `drafts/260918-1200_set-form_CANDIDATE.sql` (committed beside this record). ⚠ The file of record in `supabase/migrations/` is read back from `schema_migrations` after apply, never this copy.

## APPLIED — 2026-09-18 16:07Z, migration 77 `20260918160720_rls_read_policies_set_form`, on Daniel's "apply SET-FORM"
- Pre-apply: ledger 76, policy md5 unchanged since rehearsal, 0 other active backends.
- Executed statements md5 **ab70e129f80f7731bbec47134395e1b8** = the rehearsed candidate. Ledger 77.
- Policies 120 (unchanged count); 26 SELECT policies on the set; 2 still on the helper (projects, project_members — intended). Grants 648, md5 739fb917… unchanged. Function ACL `{postgres=X, authenticated=X}`, SECURITY DEFINER, STABLE, search_path "" — mirrors the helpers.
- Live found sets, post-apply: owner / editor / non-member hashes on equipment_items, library and box_details identical to the rehearsal.
- **MEASURED, settled, 5 runs, real non-owner editor, CPF 2,784 items: equipment list 63.9–65.9 → 1.98–2.08 ms; box_details 10.6–10.7 → 1.19–1.38 ms. Owner: 47.5–48.6 → 1.94–2.00; 8.7–9.0 → 1.23–1.33.** Prediction (2–3 / 1–2 ms) held.
- File of record written to `supabase/migrations/`, body md5 verified against schema_migrations. Not committed — rides CC's next commit.
