# METHOD-SORT-BLANK: migration 79 rehearsed under forced rollback

*Arch, 2026-09-19 ~10:45 ET. Migration ledger 78 (live). No CC session is writing. Daniel's ruling,
verbatim, 2026-09-18: **"blank should sort after anything with a value. 0 should sort before 1"**.*

## The finding it serves

- v1 keeps the user's value in `Sort Override Manual`, which is **blank** on every method that shows
  0.
- `Sort Override` is v1's calculation, which turns empty into 0. v2 imports that calculation
  (`map.ts:679`), so every v1 blank lands as a real 0 and prints **first**.
- Measured live, 2026-09-19: every `sort_order = 0` row was created by an import run (the created_at
  falls inside an `import_runs` window), and **none was ever edited**.
- The one exception is Visual Gate Fixture's `Rent-Main`, a 2026-07-07 seed. It is left alone so the
  gate doesn't move.

## The sequence: three steps, so the app never meets a blank it can't handle

| # | What | Who | Effect on users |
|---|---|---|---|
| **79** | `methods.sort_order` may be blank. `import_apply_v1` stops forcing blank to 0, both on insert and on update. **The default stays 0.** | Arch · **Trigger B** | **None.** No payload sends a blank today, so nothing changes until the CC pass. |
| CC pass | Regenerate types. Every reader of a method's sort order handles blank, sorting it last on screen and on paper. The Methods admin lets a user clear the field, and clearing it saves blank. The importer reads `Sort Override Manual` (blank → blank). Change All's create-missing sends blank. Section numbering for blank methods: report it, don't redesign it. | CC | Blank becomes possible. |
| **80** | Backfill: the import-created zeros become blank, count-guarded, excluding Visual Gate Fixture. The column default is dropped, so a new method starts blank. The import's create-missing methods insert blank instead of "after the current maximum". | Arch · **Trigger B** | Blank methods print last. |

**Arch inference, stated so it can be corrected in a word:** a method the import creates because v1
never listed it has no v1 value, so it is **blank**, not ranked after the maximum. IMP-8 ruled that
the method is *created*. It never ruled its position.

## Migration 79, the candidate (the file of record at apply)

```sql
-- 79 · methods_sort_order_nullable · METHOD-SORT-BLANK step 1 of 3
-- Daniel 2026-09-18: "blank should sort after anything with a value. 0 should sort before 1"
alter table public.methods alter column sort_order drop not null;

do $mig$
declare
  v_oid regprocedure := 'public.import_apply_v1(uuid,jsonb,jsonb,text,text,jsonb,jsonb)'::regprocedure;
  v_def text := pg_get_functiondef(v_oid);
  a_old text := $s$r->>'shop_order_header', coalesce((r->>'sort_order')::int,0)$s$;
  a_new text := $s$r->>'shop_order_header', (r->>'sort_order')::int$s$;
  b_old text := $s$sort_order = coalesce((r->>'sort_order')::int, m.sort_order)$s$;
  b_new text := $s$sort_order = case when r ? 'sort_order' then (r->>'sort_order')::int else m.sort_order end$s$;
begin
  if (length(v_def) - length(replace(v_def, a_old, ''))) / length(a_old) <> 1 then
    raise exception 'A: expected exactly one site'; end if;
  if (length(v_def) - length(replace(v_def, b_old, ''))) / length(b_old) <> 1 then
    raise exception 'B: expected exactly one site'; end if;
  execute replace(replace(v_def, a_old, a_new), b_old, b_new);
end $mig$;
```

The update arm changes in one respect. A key that is **present but blank** now clears the value. A
key that is **absent** still keeps the existing value.

## Rehearsal: forced rollback, raw

```
FORCED ROLLBACK | nullable=YES default=0 | src 428085532e6ac7d89dae1d3a59cd850d -> 86af03b73062651175cd2afb62379247
| exec_md5=f35f2edfe31658d1afb986314f30f775 | acl same=t cfg same=t | new A=1 B=1 old A=0 B=0
| case null=NULL absent=7 val=3 | insert=NULL
```

- **Column:** blank allowed; the default is still 0.
- **The RPC:** both sites were replaced exactly once and no old text remains. Grants
  (`{postgres=X/postgres,authenticated=X/postgres}`) and `search_path` are unchanged.
- **The update expression:** present-blank gives blank, absent keeps the existing value (7), and a
  value is taken (3).
- **A method with a blank sort order inserts** (Visual Gate Fixture, inside the rolled-back
  transaction).

**Residue check, after:** the column is NOT NULL again, the RPC md5 is back to `4280855…`, 0 rehearsal
rows, 0 blanks. **Clean.**

**Not proven by this rehearsal:** a full `import_apply_v1` call. The function recompiled, and both
edited statements are proven by expression. The first real import after apply is the end-to-end
proof, and the CC pass runs one on a throwaway.

**Apply-time gate:** Daniel says "apply METHOD-SORT-BLANK 79". Arch applies it, then checks
`list_migrations`, the RPC md5 (`86af03b7…`), the grants and the column.
