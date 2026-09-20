
---

## Twenty-ninth append — 2026-09-19/20, Cowork-Arch main line

**Four production deploys across the two days, and the private beta opened.**
`fa050c2` PRINT-REPARITY-LABELS · `7b3a15c` STECK-EQUIP-LABELS · `1982063` PALETTE-V1-HUES, on top of the
twenty-eighth append's `6a8f3d4`. **Migrations 81, 82 and 83 applied by this seat**, each rehearsed with a
forced rollback and a residue check before Daniel's go-ahead, each with a file of record read back from
`supabase_migrations.schema_migrations` and md5-matched.

### Migrations

- **81 `20260919190044_v_equipment_list_address_and_print_settings_default`**, md5 `146a3b9a…`. The view gains
  `address` as its last column; `projects.print_list_settings` defaults to `'{}'::jsonb`. Introspection first:
  `security_invoker=true`, no dependent views, grants `authenticated: SELECT`. `CREATE OR REPLACE` keeps both,
  so this was not a recreate. Rehearsed: 5,541 rows before and after, 146 with an address.
- **82 `20260919193946_import_apply_v1_trim_name_lookups`**, md5 `28f004ba…`; the function's own md5 moved
  `547d47f9…` → `cfb2c794…`. **IMPORT-TRAILSPACE's root cause, measured:** `import_apply_v1` stored
  `r->>'cable_name'` untrimmed (fn 419, 447) and then compared it against `nullif(trim(…),'')` at every
  lookup, so a cable named `Drive B ` could never be found. **Mult lines were DROPPED** (`cable_id` is NOT
  NULL, fn 537); tails kept a null parent (fn 750, 764). The client plan trims both sides
  (`cableDataPlan.ts:311/393/448/505`), so the pre-apply dialog warned about nothing. JOY: 40 of 432 v1 cable
  names carry a trailing space, four of them multicores holding **33 mult lines and 8 tails**.
  648 − 33 − 12 (`cPreview`, v1's own stray) = **603**, exactly what v2 held. Fixed by trimming the stored
  side at all 16 name lookups (cable, box and device), leaving stored bytes untouched so the export round
  trip and the row hashes do not move; no index exists on either column, so no plan changed. Guarded: the
  migration refuses unless the live function is the rehearsed source. **Proof: Daniel re-imported JOY
  (`0d329963…`) at 20:13 UTC — 636 lines and 5 parentless tails, against 603 and 13.**
- **83 `20260920145244_palette_v1_hues_purple_blue_yellow`**, md5 `de9324bc…`. Purple `#AF1F7B` → `#7A3F8E`
  (C65 M90), Blue `#0070A3` → `#184F9B` (C100 M75), Yellow `#FFF002` → `#FFEF35` (C0 M0 Y85), each in
  FOGRA39 gamut. Only three columns store a hex: `methods` 20 rows, `global_default_methods` 1,
  `projects.paperwork_color` 7 (including `Visual Gate Fixture` and `Cable Parity Fixture`). Everything else
  stores the NAME. Rehearsed 28 rows, 0 old values left.

### Colour, measured rather than argued

v1's chip fills read from `260919-1057_v1_cable-labels-by-cable_JOY_FILEMAKER.pdf`: purple `#AE00F0`, blue
`#0044FE`, yellow `#FFFF33`, against v2's `#AF1F7B` (a magenta), `#0070A3` (teal-leaning) and `#FFF002`
(warm, 2% magenta). **v1's purple and blue are outside CMYK gamut** — through FOGRA39, relative colorimetric,
they print `#81529B` and `#3E529E` — so the match target is the printed colour, not the screen one. Yellow
needed no hue change: v1 prints `#FCEB16` and v2 `#FBE708`; the warmth was the magenta, removed. **Daniel,
2026-09-20: *"color change approved, one palette everywhere"***, which also ruled that Minotaur's own default
trim follows Blue. `Minotaur v2 Colors.rtf` replaces `Minotaur Colors.rtf`: the old file's RGB triplets were
v1's beside v2's hexes, and its Bundle Flag was the pre-measurement `#FDD1CF`.

### The printer, and what it does not mean

Daniel's Brother MFC-J6935DW prints **about 3/64" low on v1 and v2 alike**. Both place the first row at
36.00 pt, which is Avery 5167's own top margin, so the offset is the printer's feed. **No layout change**,
and shortening every label for one printer was refused. PRINT-NUDGE is held until a second report.
Measured for the record: the white space above a sticker's chip is **1.50 pt in v2, 1.43 in v1**; below the
lowest ink, **0.8–1.6 pt in v2, 0.5–1.9 in v1**. At 3.4 pt of drift the bottom line can cross the die cut —
on either version.

### The grey rule: a render defect, not a die defect

Both dies already said 0.50 pt. CC's five-mechanism probe: a CSS border and a fractional filled div both
emit **0.75 pt at every authored weight**; an SVG **stroke** emits `0 w`, a device hairline; a scaled 1 px
div and an SVG **rect** are exact. Rect chosen, **no `viewBox`** (with one, Chrome snaps the element box to
1/64 px and the sheets measured 0.492). Rule lengths moved ≤0.5 pt **toward** the die, because a div's layout
width was being snapped up to a whole CSS pixel. Accepted by Arch as a correction.

### Arch's errors, this session — five

1. **Ran `git status` in the docs repo**, against the prompt's own rule. No lock file was left; disclosed at
   once.
2. **Gate item 5 named Tail Line Labels**, which draws no grey rule — `panelRule` renders only for
   `kind === 'panel'`. Daniel found it by looking for a rule that was not there. CC copied the claim into its
   fence without reading it at source; the wrong sheet name was Arch's.
3. **Told CC the Model prints on the Equipment Label sticker.** Layout 279 puts it in a heading row above the
   stickers, which is how CC built it.
4. **Predicted JOY's Steck counts would rise after the re-import.** They did not: 167 on both copies; the
   restored lines carry no Steck counts.
5. **Wrote that migration 82 "fixed trailing-space cable names".** It trims lookups; the stored names still
   carry their v1 bytes.

### Counts at the close

Suite **3,699 across 200 files** · typecheck clean · lint exit 0, 265 warnings · frozen 3/3 · build clean ·
visual **28/28 after one declared event covering all 28 frames**, adopted on the first write run · census 0 ·
**10 deletion controls** on the last unit alone. PALETTE-V1-HUES' auditor classified **every** differing
pixel on all 28 frames — the trim's hue drives 74 fixed (s,l) pairs through `buildHCSkin`, so a colour change
is not a blend — and was negative-controlled against six injected changes, including two unruled hues.

### The beta's first day

Invites went out 2026-09-19, 14:35–14:54 ET, all by Daniel's own hand from his own mail; **MAILGATE was never
engaged, because MAILGATE binds the system and CC, not Daniel.** 20 cohort members plus 3 early sign-ups; 19
roster display names written by this seat on his *"names approved"*. Four sign-ins by 2026-09-20, and the
set-password mail is arriving, which retires the Porkbun sending-limit worry. **BETA-BAR ruled:** the
v1-holder beta waits on two people running each core workflow, not on a date.

### Recovered

The Strat parallel's return (`260920-1329_strat-bigpicture_RETURN.md`) named files it had written to
`handoffs/parallel/` and `drafts/`. **Neither existed.** Recovered from project knowledge into both, with a
main-line amendment: its "still owed" item was ruled and shipped, and IMPORT-TRAILSPACE's name-lookup half
was already closed.
