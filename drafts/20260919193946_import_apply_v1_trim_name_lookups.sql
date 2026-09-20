-- IMPORT-TRAILSPACE (Daniel, 2026-09-19: "apply TRAILSPACE").
-- import_apply_v1 stores cable names and descriptions as sent (untrimmed) but looked them up
-- against a trimmed key, so a name with a trailing space never resolved: mult lines were dropped,
-- tails kept a null parent. Every name lookup now trims the stored side too (16 sites). Stored
-- values keep their v1 bytes. Guarded: runs only against the exact source it was rehearsed on.
do $mig$
declare d text; nd text; n int;
begin
  select pg_get_functiondef(p.oid) into d from pg_proc p where p.proname = 'import_apply_v1';
  if md5(d) <> '547d47f95e45b53dcddae611eb3bc1a2' then
    raise exception 'import_apply_v1 is not the rehearsed source (md5 %)', md5(d);
  end if;
  n := (select count(*) from regexp_matches(d, '(cd\.cable_name|e\.description|b\.description) = nullif\(trim', 'g'));
  if n <> 16 then raise exception 'expected 16 lookup sites, found %', n; end if;
  nd := regexp_replace(d, '(cd\.cable_name|e\.description|b\.description) = nullif\(trim', 'trim(\1) = nullif(trim', 'g');
  execute nd;
end
$mig$;
