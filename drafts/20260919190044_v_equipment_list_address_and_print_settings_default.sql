create or replace view public.v_equipment_list with (security_invoker = true) as
  SELECT e.id, e.project_id, e.description, e.group_label, e.quantity, e.remaining_quantity,
    e.public_notes, e.private_notes, e.sort_order, e.labels_done, e.starred, e.drawn, e.packed,
    e.sort_override, e.ip_address, e.circuit, e.box_id,
    c.name AS category_name, c.sort_order AS category_sort,
    m.name AS method_name, m.color_hex AS method_color, m.shop_order_header,
    COALESCE(bundle_box.description, own_box.description) AS box_name,
    e.model, e.type, e.num_labels, e.address
   FROM equipment_items e
     LEFT JOIN categories c ON c.id = e.category_id
     LEFT JOIN methods m ON m.id = e.method_id
     LEFT JOIN cable_details cd ON cd.id = e.id AND e.type = 'cable'::text
     LEFT JOIN bundles bnd ON bnd.id = cd.bundle_id
     LEFT JOIN equipment_items bundle_box ON bundle_box.id = bnd.box_id
     LEFT JOIN equipment_items own_box ON own_box.id = e.box_id;
alter table public.projects alter column print_list_settings set default '{}'::jsonb;
