

---

## Thirtieth append — 2026-09-20/21, Cowork-Arch main line

**Three production deploys, no migration.** `d2c897b` PRINT-REPARITY-DOCS · `128d7a6` BUNDLE-TAILFOLDER-LABELS ·
`5ccd009` NOTES-ONELINE, on top of the twenty-ninth append's `1982063`. Migration ledger **83, unchanged**. The
session opened on Daniel's word that the previous session's opener had run without the Architecture Prompt, so
its work was audited before anything else.

### The audit of the 2026-09-19/20 session

Every claim reachable from files and the live database held: `1982063` = origin; the three deploys are commits by
Daniel; migrations 81, 82 and 83 are byte-for-byte what executed (file md5 = `schema_migrations` md5:
`146a3b9a…`, `28f004ba…`, `de9324bc…`); `v_equipment_list`'s last column is `address`; `print_list_settings`
defaults to `'{}'`; `import_apply_v1` is at `cfb2c794…`; JOY `0d329963…` holds **636 mult lines and 5 parentless
tails**; the old JOY is gone; Roadmap v4.48 installed, v4.47 retired; the Strat return recovered to both paths.
The v4.47 → v4.48 census found five IDs absent: PRINT-REPARITY, PRINT-REPARITY-LABELS and STECK-EQUIP-LABELS
shipped and named in the twenty-ninth append; **BETA-INVITE and COHORT-ACCOUNTS** closed in substance ("The
beta's first day") but not by name — closed here.

**One stale row, not a false claim.** A cohort member's project (created 2026-09-20 16:37 UTC) carried
`paperwork_color = '#FFF002'`, the old yellow. Migration 83 ran at 14:52 UTC; the deploy carrying the new palette
went live at 17:37 UTC; the project was created in the gap by the old client. Corrected 2026-09-20 18:18 UTC by a
one-row `UPDATE` (data, not schema; no migration, no file of record). **Lesson: a colour that lives in both the
database and the client has a window between apply and deploy, and the residue check runs before it.**
Sign-ins had moved from four to eight since the invite.

### PRINT-REPARITY-DOCS — `d2c897b`, 14 files, +1,880 / −362

Five checkpoints and two addenda in one commit. The parity tables of the 2026-09-19 return (§4.1–4.3) were
re-measured on a reproduction: **153 object rows, none outside 0.75 pt**. PRINT-CLIP 0 rows lost on six documents.
Suite 3,753 / 202. Visual 28/28 byte-clean, no event. 25 deletion controls.

- **The logo** prints on all five cable documents from `projects.top_right_image_url` in v1's 171.64 × 34.00 box
  (x 409.98 portrait / 556.98 landscape; y 24.98 Cable Checklist, 26.00 Tail Checklist, 60.00 Bundle Sheet, and
  measured by CC: **25.00 Bundle Summary, 24.98 Line List**). JOY had no logo after the re-import; Daniel uploaded
  the top-right and box logos 2026-09-20 15:47 ET.
- **"Not in Bundles" is a data question.** v1 prints the band 15 times on JOY, v2 printed 0, because the code
  printed it only in a group mixing bundled and loose cables and **no JOY group is mixed** (`Bundles` 178 bundled;
  fifteen other groups loose only). CC's scan of the July arbiter's 54 pages: every `Loose-…` group carries the
  band on its first page and never on a continuation — the arbiter agrees with the JOY pair.
- **`Vor`/`vor`** printed as three sections because `compareLabels` folds case and the section break did not; one
  normalised key now serves both the Checklist and the grouped Small Cable Labels.
- **ADDENDUM 1, Daniel's gate:** text in the Bundle Sheet's flagged column stayed black on a palette fill. On the
  three Green pages (p5, p17, p19) v1 prints white. Measured across all 26 pages: eleven fill/text pairings on the
  name chips, identical on both sides; the flagged column had never applied the rule. Fixed by column, not by
  variable (`inFlagColumn`). Right margin checked: rules 729/733, length right edge 728.98, identical.
- **ADDENDUM 2, Daniel's gate:** `Flagged: Tech Com Rack` ran 27 pt past the fill (no width, `nowrap`); v1 wraps
  after `Com` on a 15.00 line pitch. **Ruled, a deliberate divergence (FLAGGED-HEAD-BOTTOM):** *"make the flagged
  end header bottom-aligned, so one-line flagged ends are even with the non-flagged end and other headers, and they
  wrap upward when they're two-line."* Built with one derived constant; the last line lands at 185.64 against
  `BlackBox` at 185.64 for one, two or three lines. Width 120.00, not the 121.00 Arch wrote — the text starts one
  point inside the fill.
- **Open, placed:** a project with both a logo and a credit line overprints on the two landscape documents
  (LANDSCAPE-CREDIT-LOGO); the Bundle Summary continuation title is pinned by test, not print.
- **CC disclosed** two stream edits that should have been Edit-tool calls (its own ledger, entries 3 and 5), frozen
  gate green after each; and that it first claimed the July arbiter was absent without looking for it.

### BUNDLE-TAILFOLDER-LABELS — `128d7a6`, 16 files, 7 new

PAPERWORK step 3: the last two label outputs, on Avery 5160 through one column-major placement
(`flowColumnUnits`) that Cable Folder Labels now shares. Parity on the emitted PDF: **Bundle Labels 1,110 measures
against the JOY v1 print, worst 0.42; Tail Folder 51 against BVSC, worst 0.29.** Daniel's own By-Group print,
measured by this seat against the 2026-09-19 JOY file: **305 of 305 text objects within 0.75 pt**, 28 centre ticks
on both, cell for cell. Suite 3,793 / 204. Visual 28/28, no event.

**Read at source by CC, corrected against the handoff:** Tail Folder's population is the **parent mult's model**
(DDR script 728, `Cable::Model`, grouped export), not `DocTail.model`; bundle names shrink 18 → 14 pt at 15
characters (layout 172, conditional format), a count not a width; the grey centre tick is `#DEDEDE` and on no
heading cell; a bundle's two stickers differ by 1.00 pt in name x and 2.00 in length y; blank group prints
`Not Grouped` and blank box `No Box`, unfilled and right-aligned; a box heading wraps and its fill grows to 46.00;
the `FOLDER` grid is v1's measured die (14.00 / 198.42), not Avery's published 5160 (13.50 / 198.00), ≤ 1.34 pt at
column 3 — STOCK-IS-DIE has never been applied to 5160 (STOCK-5167-CHECK gains a 5160 sheet). **Emitted-PDF
mechanism, now standing:** Chrome floors a `lineHeight: 1` baseline onto a whole CSS pixel at `top + 0.875 × size`;
`emittedTopFor` places by the rounded baseline.

**Open for Daniel (BUNDLE-SKIP-UNITS):** skip counts stickers as built; v1's script 83 adds one record per skip and
a Bundle Labels record is one two-sticker body, so v1's "skip 3" most likely blanks six. No v1 skip print exists.

### NOTES-ONELINE — `5ccd009`, 10 files, 1 new

Jamie Tippett's request, never in the Docket; ruled by Daniel 2026-09-21: *"making multi-line notes condense to one
line unless selected in the equipment list … I'd like to move it to the next handoff and deploy ASAP."* One
component. Rulings taken by CC in the terminal, quoted in the source: **"Yes, condense all"** — long single-line
notes too, superseding gate amendment H on non-current rows; and the hidden-lines marker, **"combine ideas 1 and
3, where it indicates a carriage return before the number"** → `↵+N`; then at Daniel's gate, *"move the glyph to
the right, and make it clearer that it isn't part of the note"* → a grey pill at the cell's right edge, chosen by
Daniel from two previews. Measured: a three-line-note row is **21 px not current, 52.5 px current** (unchanged
from before for the current row). Stored bytes unchanged through render-select-deselect. The visual fixture holds
two long notes, so frames 02/03/08 moved in both themes — one declared event, each frame looked at; the addendum
moved nothing (the fixture's notes are single-line and never show the marker). Suite 3,797 / 205.

### Rulings of record, Daniel, 2026-09-20/21

- *"fix the yellow"* (the one stale row).
- *"flagged text should follow color rules, e.g., white text on green chips. check right margin of bundel sheets
  against v1."*
- FLAGGED-HEAD-BOTTOM, verbatim above.
- NOTES-ONELINE, verbatim above; *"Yes, condense all"*; *"combine ideas 1 and 3 …"*; the pill.
- *"with offline functionality, make a note in the roadmap to keep Josh Richardson updated."*
- *"change all from a multi-line note seems not to do anything"* — CHANGEALL-NOTE, batched with INSPECTOR-ARM.
- *"write a handoff to the mainline to update this text"* (the import report's device warning, via the tech-support
  parallel) — rides NEWPROJ-IMPORT.
- From the terms parallel, 2026-09-21: *"path A, although review to see if anyone has actually signed an agreement
  about 90 days"* · *"option C"* · *"I have a max plan with share settings off"*.

### Parallels folded in

- **Import device note** (`260921-1027_import-device-note_TO-MAINLINE.md`): the import report warns about
  cable-source-device matches nothing reads (`source_device_id` has no reader outside the import); on JOY 3 of
  120 named sources link, 6 skips counted, 21 destination skips never shown. Remove the line; keep the other five.
- **Terms v1.1 and privacy** (`260921-1214_terms-privacy_RETURN.md`): drafts on disk in both paths (checked).
  Findings placed: TERMS-GATE must accept 1.0 and 1.1; no admin screen exists (§4's sentence rewritten as
  practice); customer exports are tracked on GitHub; account deletion is blocked by RESTRICT / NO ACTION keys
  (ACCOUNT-DELETION); the acceptance record dies with the account; a `/privacy` route; the user-data rule gates
  publication (USER-DATA-RULE — an Architecture Prompt swap for Daniel's confirmation); sixteen packet lines
  (22–37). Auth mail measured through **Porkbun**, not Resend. Ten acceptors on "90 days".
- **Offline** (`260921-1239_offline_MAINLINE-HANDOFF.md`, from the General Advisor seat): Josh Richardson's ask,
  Daniel *"I agree this is important."* Three rows OFFLINE-1/2/3 entered; three rulings owed. The only prior
  mention was "PWA/offline (v3 candidate)" in the post-BVSC list — dropped the same way RF was at v4.28.
- **Licence management (Arch parallel):** still not returned as of the close. REGISTRY-REST waits.

### Measured, for the record

- Cohort imports to 2026-09-21: five, all equipment-library spreadsheets (Pickens, Sweetser, Tracey, Tippett,
  Brion); **no v1 show imported by anyone but Daniel**. BETA-BAR's import leg untouched.
- JOY `v_cable_list` groups: `Bundles` 178 bundled / 0 loose; fifteen other groups loose only; `Vor` 2 + `vor` 1.
- JOY has 30+ multi-line public notes (CC's SELECT).

### Arch's errors, this session — seven

1. Told CC the notes addendum would move frames 02/03/08; the fixture's notes are single-line and never show the
   marker. Predicted, not read.
2. Named `DocTail.model` as Tail Folder's population; v1 uses the parent mult's model. CC bounced it.
3. Told CC to add Tail Folder to STOCK-IS-DIE's list, which is the 5167 list; Tail Folder is 5160.
4. Wrote "two new sort settings"; none were needed.
5. Wrote the flagged header's width as the fill's 121.00; the text starts one point inside, so 120.00.
6. Wrote "centre tick on every cell, heading cells included"; v1 draws none on a heading.
7. Wrote "blank group first, as the shipped folder page does"; that page puts it last. The instruction was right,
   the comparison was wrong.

### Counts at the close

Code `5ccd009` = origin. Suite **3,797 across 205 files** · typecheck clean · lint 0 errors, 263 warnings · frozen
3/3 · visual 28/28 after one declared event (02/03/08 × 2) · `CLAUDE.md` 127,901 characters · migrations 22 files,
ledger 83. Session Log at 4 entries. Roadmap **v4.49**.
