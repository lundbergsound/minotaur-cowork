create function public.readable_project_ids()
returns setof uuid
language sql stable security definer
set search_path = ''
rows 20
as $fn$
  select p.id from public.projects p
   where p.owner_id = auth.uid()
  union
  select m.project_id from public.project_members m
   where m.user_id = auth.uid() and m.accepted_at is not null
$fn$;
revoke all on function public.readable_project_ids() from public, anon, service_role;
grant execute on function public.readable_project_ids() to authenticated;

alter policy box_types_read on public.box_types using (project_id in (select public.readable_project_ids()));
alter policy bundles_read on public.bundles using (project_id in (select public.readable_project_ids()));
alter policy cable_details_read on public.cable_details using (project_id in (select public.readable_project_ids()));
alter policy cable_mult_lines_read on public.cable_mult_lines using (project_id in (select public.readable_project_ids()));
alter policy cable_types_read on public.cable_types using (project_id in (select public.readable_project_ids()));
alter policy cast_members_read on public.cast_members using (project_id in (select public.readable_project_ids()));
alter policy categories_read on public.categories using (project_id in (select public.readable_project_ids()));
alter policy circuits_read on public.circuits using (project_id in (select public.readable_project_ids()));
alter policy cover_letters_read on public.cover_letters using (project_id in (select public.readable_project_ids()));
alter policy equipment_items_read on public.equipment_items using (project_id in (select public.readable_project_ids()));
alter policy equipment_list_revisions_read on public.equipment_list_revisions using (project_id in (select public.readable_project_ids()));
alter policy import_identity_map_read on public.import_identity_map using (project_id in (select public.readable_project_ids()));
alter policy import_runs_read on public.import_runs using (project_id in (select public.readable_project_ids()));
alter policy link_group_members_read on public.link_group_members using (project_id in (select public.readable_project_ids()));
alter policy link_groups_read on public.link_groups using (project_id in (select public.readable_project_ids()));
alter policy maintenance_history_read on public.maintenance_history using (project_id in (select public.readable_project_ids()));
alter policy methods_read on public.methods using (project_id in (select public.readable_project_ids()));
alter policy project_blobs_read on public.project_blobs using (project_id in (select public.readable_project_ids()));
alter policy project_features_read on public.project_features using (project_id in (select public.readable_project_ids()));
alter policy project_snapshots_read on public.project_snapshots using (project_id in (select public.readable_project_ids()));
alter policy tail_details_read on public.tail_details using (project_id in (select public.readable_project_ids()));
alter policy walkie_assignments_read on public.walkie_assignments using (project_id in (select public.readable_project_ids()));
alter policy walkie_channels_read on public.walkie_channels using (project_id in (select public.readable_project_ids()));
alter policy equipment_library_items_read on public.equipment_library_items using ((owner_id = (select auth.uid())) or project_id in (select public.readable_project_ids()));
alter policy rf_device_details_read on public.rf_device_details using ((select ei.project_id from public.equipment_items ei where ei.id = rf_device_details.id) in (select public.readable_project_ids()));
alter policy box_details_read on public.box_details using ((select ei.project_id from public.equipment_items ei where ei.id = box_details.id) in (select public.readable_project_ids()));
