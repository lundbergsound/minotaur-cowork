# METHODS-PALETTE — rehearsed, awaiting Daniel's Trigger B (Arch, 2026-09-18 13:15 ET, ledger 77)

Ruled 2026-09-15: "METHODS-PALETTE: the shared palette, with the seven-hex mapping approved as proposed." The mapping itself was not found in any file; re-derived by measurement: **every stray carries a colour NAME that is a shared-palette name, so each stray hex maps to its own name's palette hex. No method changes name or meaning.**

| name | stray hex | palette hex (`src/theme/minotaurColors.ts`) |
|---|---|---|
| Chartreuse | #80FF00 | #B8D586 |
| Pink | #FF69B4 | #F6C6D8 |
| Aqua | #00FFFF | #94E3FE |
| Sand | #C2B280 | #E4BF8F |
| Grey | #808080 | #C2C3C3 |
| Yellow | #FFE800 | #FFF002 |
| Orange | #FFA500 | #EEA036 |

Live census today: `global_default_methods` 8 of 9 stray (House/Black clean). `methods`: **62** stray (was 54 on 2026-09-15; Warriors Broadway, created 2026-09-17, added 8 — the defaults table is still seeding saturated). Real shows: Liberation 6 · Memoirs 8 · Warriors Broadway 8. Test/others: Comet Fall '26 8 · tesr 8 · Test (Haggerty) 8 · Test (Cooper) 8 · Matched Pair Fixture 8. Visual Gate Fixture: 0 (gate unaffected).

Rehearsed under forced rollback: defaults updated 8 · methods updated 62 · strays left 0 / 0 · method row count 215 unchanged. Condition touches only hexes NOT in the palette, so a method deliberately set to another palette colour is never altered.

```sql
with pal(name, hex) as (values ('Red','#D80B00'),('Orange','#EEA036'),('Yellow','#FFF002'),('Green','#70AF46'),('Blue','#0070A3'),('Purple','#AF1F7B'),('Black','#000000'),('Grey','#C2C3C3'),('White','#FFFFFF'),('Brown','#975400'),('Pink','#F6C6D8'),('Aqua','#94E3FE'),('Chartreuse','#B8D586'),('Sand','#E4BF8F'))
update public.global_default_methods g set color_hex = p.hex from pal p
 where p.name = g.color_name and upper(g.color_hex) not in (select upper(hex) from pal);
-- second statement, same CTE:
update public.methods m set color_hex = p.hex from pal p
 where p.name = m.color_name and m.color_hex is not null and upper(m.color_hex) not in (select upper(hex) from pal);
```
Visible effect: those shows' method colours on screen and paper turn from saturated to the pale shared palette (Jamie's reported symptom, fixed).

## APPLIED 2026-09-18 17:15Z — migration 78 `20260918171501_methods_palette_strays_to_shared_palette`, on Daniel's "apply METHODS-PALETTE"
Ledger 78. Executed md5 878186d0d5cf741c702ca7cb31a2f245. Verified: default strays 0, method strays 0, methods 215 (unchanged). File of record staged at `drafts/20260918171501_…sql` (body md5 verified), crosses into `supabase/migrations/` with the next CC unit (ONE-WRITER-HOLDS — BATCH-HOUSEKEEPING was live).
