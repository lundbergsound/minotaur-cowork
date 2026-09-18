-- METHODS-PALETTE. Migration 78, applied 2026-09-18 on Daniel's Trigger B ("apply METHODS-PALETTE").
-- Each off-palette method colour returns to its own NAME's shared-palette hex (src/theme/minotaurColors.ts).
-- Touches only hexes not in the palette. Rehearsed under forced rollback: defaults 8, methods 62, strays left 0.
-- Record: Minotaur-Cowork/drafts/260918-1315_methods-palette_REHEARSAL.md.
-- Body below is byte-identical to schema_migrations.statements: md5 878186d0d5cf741c702ca7cb31a2f245.

with pal(name, hex) as (values ('Red','#D80B00'),('Orange','#EEA036'),('Yellow','#FFF002'),('Green','#70AF46'),('Blue','#0070A3'),('Purple','#AF1F7B'),('Black','#000000'),('Grey','#C2C3C3'),('White','#FFFFFF'),('Brown','#975400'),('Pink','#F6C6D8'),('Aqua','#94E3FE'),('Chartreuse','#B8D586'),('Sand','#E4BF8F'))
update public.global_default_methods g set color_hex = p.hex from pal p
 where p.name = g.color_name and upper(g.color_hex) not in (select upper(hex) from pal);

with pal(name, hex) as (values ('Red','#D80B00'),('Orange','#EEA036'),('Yellow','#FFF002'),('Green','#70AF46'),('Blue','#0070A3'),('Purple','#AF1F7B'),('Black','#000000'),('Grey','#C2C3C3'),('White','#FFFFFF'),('Brown','#975400'),('Pink','#F6C6D8'),('Aqua','#94E3FE'),('Chartreuse','#B8D586'),('Sand','#E4BF8F'))
update public.methods m set color_hex = p.hex from pal p
 where p.name = m.color_name and m.color_hex is not null and upper(m.color_hex) not in (select upper(hex) from pal);
