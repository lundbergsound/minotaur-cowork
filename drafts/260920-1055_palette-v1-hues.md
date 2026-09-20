# PALETTE-V1-HUES: Purple, Blue and Yellow closer to v1 and CMYK-true, v1's hairline weight, and the import-too-big message

Tier: claude-opus-5
Model: claude-opus-5
Session: FRESH

*Arch, main line, 2026-09-20. Code is at `7b3a15c`, which is `origin/main`. The migration ledger is **83**. Read
HEAD and origin from the ref files, and read the ledger live (expect 83). Line numbers were read at `7b3a15c`
today.*

**Migration 83 is applied.** It is `20260920145244_palette_v1_hues_purple_blue_yellow`. Its file of record is in
`supabase/migrations/`, untracked, md5 `de9324bc…`, and it rides this commit. Do not edit it. It rewrote the three
places that store a colour as a HEX:

- `methods.color_hex`: 20 rows;
- `global_default_methods.color_hex`: 1 row;
- `projects.paperwork_color`: 7 rows. **These include `Visual Gate Fixture` and `Cable Parity Fixture`**, both now
  `#184F9B`.

Every other colour column stores the NAME (the `cable_color` domain, `box_details.color_name`), so those follow
the code.

**Three parts, one unit**, on Daniel's standing instruction to bundle small fixes.

**⚠ Every answer you need is in this file. There is no blank for anyone to fill in.**

## §0 · HARD STOPS

1. **No migrations and no SQL writes.**
2. **Test shows only**: JOY `0d329963…` and the other `daniel+test01@` projects, or seeded throwaways. **Never
   Buena Vista Social Club.**
3. **Visual gate: a large, expected event.** The fixture's trim colour changed in the database, and the default
   trim changes in code. So **every frame that shows the project trim, a Purple/Blue/Yellow chip, or the default
   blue may move.**
   - Emit the declaration, then look at every moved frame.
   - Confirm that each one differs **only** in those colours.
   - Declare them as this unit's one baseline event.
   - **A frame that moves for any other reason is a stop.**
4. Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT
   section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every
   line."*
5. GATE-NOGREP. Commit only on Daniel's `COMMIT APPROVED: <first words>`, after his gate.

## §1 · Rulings of record

- **Daniel, 2026-09-20, verbatim:** *"update purple, blue, and yellow throughout the database to be closer to v1
  while CMYK"*. Then: *"color change approved, one palette everywhere."* "One palette everywhere" answered whether
  the app's own default trim follows Blue. It does.
- **Daniel, 2026-09-20, on Small Cable Labels:** the "@ device" line looks crowded against the grey rule. *"this
  is minor. Look to ride along whenever."*
- **Daniel, 2026-09-19:** *"message for too big import approved"*, with the wording quoted verbatim in §4.

## §2 · CP1: the palette (pedigree (a))

| Name | Old | **New** | CMYK (FOGRA39) | Text on it |
|---|---|---|---|---|
| Purple | `#AF1F7B` | **`#7A3F8E`** | C65 M90 Y0 K0 | white |
| Blue | `#0070A3` | **`#184F9B`** | C100 M75 Y0 K0 | white |
| Yellow | `#FFF002` | **`#FFEF35`** | C0 M0 Y85 K0 | black |

1. **`src/theme/minotaurColors.ts` carries the palette three times:** `MINOTAUR_COLORS` (lines 10–13), the named
   constants (48, 50 and 51, where `MAGENTA` is Purple's constant), and `MINOTAUR_PALETTE` (124–127).
   - Change all three.
   - **Rename `MAGENTA` to `PURPLE`**, updating every reference.
   - **If you can make two of the copies derive from the third without moving behaviour, do it**, and report
     which way you went.
2. **The default trim ("Minotaur Blue") becomes `#184F9B` everywhere.**
   - `globals.css:74` (`--project-color`);
   - `lib/utils.ts:67-70`, including its comment. The "ruled the only default blue" note gains Daniel's
     2026-09-20 words;
   - `settings/page.tsx:65`, `:103` and `:184`;
   - every `paperwork_color ?? '#0070A3'` fallback: grep found 13 of them, plus `ImportV1Client.tsx:899`'s initial state. **Route them through ONE exported
     constant** instead of repeating the literal.
3. `settings/page.tsx:29` `LIGHT_SWATCHES`: `#FFF002` becomes `#FFEF35`.
4. Check `textOn()` (`minotaurColors.ts:74-84`) against the three new hexes, and report what it returns. The
   table above says what it should be.
5. **The v1 export and import.** Confirm that method and cable colours travel by NAME in both directions, so a v1
   round trip is unaffected. If any path writes or reads a hex that this change breaks, fix it and report it.
6. **Tests:**
   - update the three that pin old hexes (`importEngine.test.ts`, `entityDiffPlan.test.ts`,
     `methodChangeAll.test.ts`), with a note of why;
   - add a test that no source file outside `minotaurColors.ts` (and the historical migration files) contains
     `#AF1F7B`, `#0070A3` or `#FFF002`;
   - add a deletion control.

## §3 · CP2: v1's hairline weight on the label sheets (pedigree (b))

**What was measured**, on Daniel's JOY Small Cable Labels print against
`260919-1057_v1_cable-labels-by-cable_JOY_FILEMAKER.pdf` p2:

- v2's rule prints **0.75 pt**; v1's prints **0.50 pt**. Chrome paints a 0.5 pt border as one whole pixel.
- The text does not overlap in either file. v2's "@" line sits about 0.4 pt higher than v1's.
- The heavier rule is what reads as crowding.

1. **Make the rule print at 0.50 pt** wherever v2 draws v1's `#DEDEDE` hairline on a label sheet:
   - `smallCableLabels.ts:69`;
   - `tailCellGeometry.ts:382` (`TailLabelsPrintClient.tsx:254`);
   - any other label sheet you find.

   An SVG line, or a 1 px rule scaled by 0.667, both get under Chrome's pixel. Your choice.
2. **Leave `equipListDie.ts:709` (the equipment list row rule) alone.** v1 draws that one at 1.00 pt.
3. **Success:** on an emitted PDF, the rule measures 0.50 ± 0.10 pt at the same y as before, and every other
   element of the sheet is unmoved.
4. **Report the gap from the "@" line's ink to the rule**, v1 against v2.

## §4 · CP3: the import-too-big message (pedigree (a))

- At `ImportV1Client.tsx:1100-1103`, database errors print verbatim, and they must stay verbatim, because the
  fingerprint-abort message depends on it.
- **Add exactly one exception:** when the error is the statement timeout (`canceling statement due to statement
  timeout`, SQLSTATE `57014`), show Daniel's approved wording **instead**, verbatim:

  > This show is too big for Minotaur to import in one go. The import ran for 90 seconds and stopped. Nothing has been imported, and nothing in your show has changed. Please email info@minotaur.app and we'll get it in for you.

- Match on the SQLSTATE if the client error carries it. Otherwise match the exact text.
- Every other error still prints verbatim.
- Test both branches.

## §5 · Left out, and why

- **The import-from-v1 button on the new-project screen** (Daniel, 2026-09-19). It needs a look at the create →
  import flow first, and it is Arch's to design.
- **The Product Brief's Design System palette** is a governing document, updated by Arch at the close.

## §6 · Close

- Run the full suite, typecheck, lint, build, frozen 3/3, the visual gate (§0.3) and the dependency gate.
  Census 0.
- Update the fence (FENCE-ONEUNIT).
- Return DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT, plus the COMMIT BLOCK.

**Daniel's gate, on JOY only.** Restart `:3100` first.

1. **Any screen of JOY.** Its purple trim is now a violet, clearly different from red.
2. **Methods admin.** The Yellow, Blue and Purple swatches show the new colours, and a method set to Blue shows
   the new royal blue.
3. **Project Settings → colour picker.** The same three new colours.
4. **Small Cable Labels.** The grey rule under the "@" line is visibly finer. Purple, Blue and Yellow chips show
   the new colours.
5. **Tail Line Labels.** The grey rules are finer too, and nothing else moved.

Proposed subject: `PALETTE-V1-HUES: Purple, Blue and Yellow closer to v1 and CMYK-true; v1's 0.5 pt label
hairline; the import-too-big message`.
