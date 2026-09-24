# PARALLEL OPENER — DEFAULTS: a new project's default content, and the screen Daniel manages it from (design only)

*Arch parallel, opened from the main line 2026-09-22 17:35 ET, under Architecture Prompt v39. Main line: Cowork-Arch,
CC is running CHANGEALL-MMMCAT. Code `d25d366` = `origin/main`. Migration ledger **83**. Read the governing set in
the prompt's order first: Brief v1.2 · Roadmap v4.49 · the Ledger on citation · the Session Log.*

## Your scope, and nothing else

Two of Will Pickens's eight rows, ruled 2026-09-22, which have to be designed together because one manages what the
other seeds:

1. **SEED-DEFAULTS** — Daniel: *"new project switches should work, including my default library, methods,
   categories, cable types, tail types, and box types."*
   (`handoffs/parallel/260922-1237_seed-defaults_TO-MAINLINE.md`.) Work out, per kind, what a new project gets
   today, where that content lives, and what has to change for each switch on the new-project screen to do what it
   says. The return file names one migration (global box types); prove or correct that against the schema.
2. **DEFAULTS-ADMIN** — Daniel: *"make a management interface for me to manage the default content. ask me for it
   when building it."* (`handoffs/parallel/260922-1305_defaults-admin_TO-MAINLINE.md`.) Design the screen and the
   write policies that let **Daniel alone** edit the shared default content, with every other account reading it.

⚠ **Arch picks no content.** Daniel's ruling is that the building session asks him for each default set. Your design
says what a set is and how it is stored and edited; it never invents a method, category, cable type or library row.

## The rules of a parallel (Architecture Prompt v39)

- **No CC handoff. No schema change and no SQL writes** — SELECT, `information_schema` and counts only, never a
  cohort member's project content ("option C", 2026-09-21). **No governing-document edit**, nothing written to the
  code repo, and **never run git in either repo folder** — read HEAD from the ref files.
- A migration you specify is **written as a proposal** for the main line to rehearse and apply (Trigger B is
  Daniel's, at the main line). Include the policy set, the grants to restore, and what you would measure at
  rehearsal.
- Land the return in **`handoffs/parallel/`** *and* a **`drafts/`** copy. **PARALLEL-CLOCK:** the filename's
  timestamp is written at the time of writing.
- Write for Daniel first, in plain words, every identifier glossed; measurements below. **Surface Rule:** read the
  schema, the policies and the new-project code at source before writing a sentence about them.

## What to return

`handoffs/parallel/<YYMMDD-hhmm>_defaults_RETURN.md`, plus the `drafts/` copy:

- what a new project gets today, per kind, and what each switch actually does — measured, not predicted;
- the design: where shared default content lives, how a project is seeded from it, and what happens when Daniel
  changes a default later (existing projects untouched, unless you argue otherwise);
- the admin screen: who may write, how that is enforced at the data layer, and what it looks like for everyone else;
- the migration proposal, with its policies, grants and rehearsal measurements;
- **the questions for Daniel, batched** — including exactly which default sets he will be asked to supply, so the
  build session can ask once;
- main-line material stated, not acted on.

⚠ **Both rows carry "Keep Will Pickens updated."** MAILGATE holds: Daniel sends it.
