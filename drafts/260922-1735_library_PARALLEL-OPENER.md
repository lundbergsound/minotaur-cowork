# PARALLEL OPENER — LIBRARY: the library in version history, and the library panel (design only)

*Arch parallel, opened from the main line 2026-09-22 17:35 ET, under Architecture Prompt v39. Main line: Cowork-Arch,
CC is running CHANGEALL-MMMCAT. Code `d25d366` = `origin/main`. Migration ledger **83**. Read the governing set in
the prompt's order before anything: Brief v1.2 · Roadmap v4.49 · the Ledger on citation · the Session Log.*

## Your scope, and nothing else

Two of Will Pickens's eight rows, both about the equipment library, both ruled 2026-09-22 and both needing a design
before CC can build:

1. **LIBRARY-DELETE's prerequisite** — Daniel: *"library should be in version history."* Work out what it takes for
   the project's equipment library to join the version-history payload, and what that means for deleting library
   rows (`handoffs/parallel/260922-1237_library-delete_TO-MAINLINE.md`). VERHIST-REST records that the saved payload
   holds twenty tables and the library is not one of them; this ruling closes that question in the affirmative.
   Say plainly whether a migration is needed, and what a restore of an older snapshot does when the library is
   missing from it.
2. **LIBRARY-PANEL** — Daniel: *"add Panel at the bottom of the equipment list for library defaults: category, note,
   rack spaces"*, amended to *"library panel should have public note, private note, rack spaces, power draw — look at
   v1."* v1 **has** this panel ("Equipment Library for this model", layout 26), so the pedigree is (b): read the
   layout in `docs/reference/v1_ddr.xml` and any v1 print or screenshot in `~/Minotaur_v1_exports/` before you
   describe a field. Cover what the panel shows, what it edits, what it writes to (the library row, not the item),
   and what happens when an item's model matches no library row.

## The rules of a parallel (Architecture Prompt v39)

- **No CC handoff. No schema change and no SQL writes** — SELECT and counts only, and never a cohort member's
  project content (Daniel's "option C", 2026-09-21). **No governing-document edit**, and **nothing written to the
  code repo.** **Never run git in either repo folder** — read HEAD from the ref files.
- The main line owns all writes and installs your return. Land it in **`handoffs/parallel/`** *and* a **`drafts/`**
  copy, because `.gitignore` ignores `handoffs/` entirely (a file left only there is not in the repo).
- **PARALLEL-CLOCK:** the timestamp in the filename is written at the time of writing.
- Write for Daniel first: the opening section must be readable on its own, in plain words, with every identifier
  glossed. Measurements and citations go below it.
- **Surface Rule:** open the file, the DDR or the print before writing the sentence. Where you have not, write
  "measure".

## What to return

`handoffs/parallel/<YYMMDD-hhmm>_library_RETURN.md`, plus the `drafts/` copy:

- what each row is, in plain language, and what it costs;
- the version-history answer: a migration or not, the payload's shape, and what a restore does;
- the panel's design: fields, source, write target, the no-match case, and any UX call marked **(c)** so Daniel can
  strike it by number;
- **the rulings you need from Daniel, batched, one word each** — do not ask them one at a time;
- what belongs to the main line (rows, Ledger material, propagation) stated, not acted on.

⚠ **Both rows carry "Keep Will Pickens updated"** — the Josh Richardson pattern. MAILGATE holds: Daniel sends it.
