# Main line, 2026-09-19 afternoon: notes for the close (Arch). These are not a governing document.

## Daniel's words, verbatim, to carry into the Roadmap, Ledger and Log

- "relative, first": EQUIP-PARITY-2 item 11 stays heading-relative, and Small Cable Labels print `Not Grouped` first.
- "names approved": 19 roster display names written 15:2x ET, 19 of 19 rows.
- "message for too big import approved". The wording, verbatim: *"This show is too big for Minotaur to import in
  one go. The import ran for 90 seconds and stopped. Nothing has been imported, and nothing in your show has
  changed. Please email info@minotaur.app and we'll get it in for you."* It rides the next CC unit that touches
  the import.
- "apply ADDRESS-VIEW": migration 81, `20260919190044`, md5 `146a3b9a…`.
- "apply TRAILSPACE": migration 82, `20260919193946`, md5 `28f004ba…`. The function's md5 went from `547d47f9…`
  to `cfb2c794…`.
- **Feature request, logged for a UI ride-along:** *"when making a new project, add an import from v1 button to
  the new project screen"*. Needs a Docket row. It rides the next UI-touching unit.

## Measured

- **TRAILSPACE was proven by a re-import.** JOY was re-imported to `daniel+test01@` at 20:13 UTC as new project
  `0d329963…`:
  - 636 mult lines, where the old JOY had 603;
  - 33 of those lines sit on the four trailing-space multicores, where the old JOY had 0;
  - 5 parentless tails, where the old JOY had 13. The remaining 5 are v1's own strays.
- **The old JOY `b04ab9b5…` no longer exists.** The JOY id moves to `0d329963…` in every handoff and gate from
  here on.
- Versioning Test (`87ccc246…`) still carries the defect's data: 603 lines and 13 orphaned tails. It is a test
  show. Re-import it only if it is needed.

## For the Roadmap at the close

- A4-LAYOUTS goes directly after CABLE-SPLIT (`drafts/260919-1450_a4-layouts_ROW-DRAFT.md`).
- COHORT-ACCOUNTS: done, 20 leads plus 3 early sign-ups.
- BETA-INVITE: sent.
- The new terms-version line goes on the LEGAL packet.
- IMPORT-TRAILSPACE: the name-lookup half is closed. What is left: `cPreview`, and the Sand/Chartreuse end
  colours.
- The EQUIP-PARITY-2 row wrongly listed the 20-page count in place of the struck-through notes. The row
  closes, and its page-count note moves to a row of its own: Main List prints 11 pages to v1's 10.

## Added 2026-09-20 (after STECK-EQUIP-LABELS)

- **SMALLCABLE-HAIRLINE, a ride-along, not urgent (Daniel: "this is minor. Look to ride along whenever").**
  Daniel's report: the "@ device" line on Small Cable Labels looks like it touches the grey rule. Measured on his
  print against v1 JOY by-cable p2: the text does not overlap in either PDF. v2's "@" line sits about 0.4 pt
  higher than v1's. The v2 rule is **0.75 pt against v1's 0.50**, because Chrome paints it as one whole pixel.
  So v2's rule is half again as heavy, and it reads as crowding.
  - Fix: draw the rule at v1's 0.50 pt. An SVG line, or a scaled 1 px rule, gets under Chrome's pixel.
  - Then re-measure the gap from the "@" line to the rule.
  - The same 0.75 rule probably appears on the other label sheets that carry v1's hairline. Census them in the
    same pass.
- **The STECK-EQUIP-LABELS gate** passed on JOY `0d329963…` (Daniel: "this is generally good"). His prints are
  in `Archive 19` (Steck, Steck skip, Equip by group, Equip by description, Small Cable).

## Added 2026-09-20: the printer test and label colours

- **The printer test** (Daniel): v1 and v2 both print about **3/64" (~3.4 pt) low** on his printer. First he
  reported 1/6", then corrected it to 3/64". Both programs put the first row at 36.00 pt, the Avery 5167 top
  margin (`AVERY_5167.top`). The same offset on both points to the printer's paper feed, inside ordinary printer
  tolerance. **No layout change.** A per-user print nudge is a possible later feature; nobody has asked for one.
- **Label colours, measured from the chip fills.** v1 JOY Small Cable Labels against Daniel's v2 print.
  **Proposal, pending Daniel:**
  - **Purple:** v1 `#AE00F0` is a violet; v2 `#AF1F7B` is a magenta that sits near Red `#D80B00`. v1's violet is
    out of CMYK gamut; through FOGRA39 (relative colorimetric) it prints `#81529B`. Proposed in-gamut violet
    **C65 M90 Y0 K0 = `#7A3F8E`**.
  - **Blue:** v1 `#0044FE` prints `#3E529E`. v2 `#0070A3` leans teal. Proposed **C100 M75 Y0 K0 = `#184F9B`**.
  - **Yellow:** v1 `#FFFF33` prints `#FCEB16`; v2 `#FFF002` prints `#FBE708`. Effectively the same, so no change.
  - Other chips: v1 orange `#FD9A00` against v2 `#EEA036`; green `#66B132` against `#70AF46`; grey `#D6D6D6`
    against `#C2C3C3`. Not raised by Daniel.
  - **Cost if ruled:** the cable colours are stored by NAME, so those are a code constant only
    (`src/theme/minotaurColors.ts`, which carries two copies: `MINOTAUR_COLORS` and the named constants). But
    `methods.color_hex` stores the HEX, so the method rows using Purple or Blue need a data migration (Trigger B),
    as METHODS-PALETTE did. The v1 export and import colour mapping must be checked for name↔hex round-trip.

## Added 2026-09-20 afternoon

- **PALETTE-V1-HUES shipped, `1982063`.** Migrations 81, 82 and 83 are all committed as files of record.
  Daniel's gate: *"1-4 pass. I'm not sure where the grey rule in tail line labels is."* then *"step 5
  passes."* and *"OK, gate passes. commit."*
- ⚠ **Arch error for the Ledger:** the handoff's gate item 5 said **Tail Line Labels**. That sheet draws no
  grey rule — `panelRule` renders only for `kind === 'panel'`. It should have said **Tail Panel Labels**.
  CC copied the claim into the fence and the terminal gate list without reading it at source, and Daniel
  found it by looking for a rule that was not there. Arch wrote the wrong sheet name; the Surface Rule
  applies to Arch's own handoff text.
- **The Strat parallel's return existed only in project knowledge.** Its own "files this session wrote"
  named `handoffs/parallel/` and `drafts/`; neither was on disk. Recovered into both at 14:05 ET, with a
  main-line amendment appended: the import-too-big message is ruled AND shipped, IMPORT-TRAILSPACE's
  name-lookup half is closed by migration 82, and no print leaves a trace in the database.
- **From that return, for the Roadmap:** BETA-BAR (the v1-holder beta waits on two people running each
  core workflow, not on a date; mid-October becomes a forecast) · LEGAL splits, privacy policy its own
  row · TERMS-V1_1, with the §11 notice question · REGISTRY-REST superseded by the licence-management
  parallel, and V1-ISSUE named again · STRAT-OWED, including the Vercel token rotation at ~2026-11-08.
- **Install order it asks for:** the Arch licence-management return first (it carries a handoff and a
  migration), then the Strat terms/privacy return, then itself.
