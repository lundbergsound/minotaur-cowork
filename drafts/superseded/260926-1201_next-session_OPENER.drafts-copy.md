# NEXT SESSION — opener

*Written 2026-09-26 12:01 ET under **Architecture Prompt v39**; retires `260926-1150_next-session_OPENER.md`.
Governing set: Brief v1.2 · Roadmap **v4.51** · the Ledger on citation · the Session Log.*

**Daniel's priority is Will Pickens's eight.** His words, 2026-09-26: *"nothing about this unit is my priority —
anything here can be a ride along or much later. my priority is will's eight."* And: *"plan to have Arch issue the
largest, most bundled handoff possible in its first turn. once I confirm CC is running, have it spin off parallel
sessions for any open arch design work."*

## First turn: the seat check in one line, then the handoff

State at close (verify from files, never git): code **`cef0949`** = origin · migration ledger **83** (live-read it)
· no CC session live · nothing uncommitted in the code repo.

**Handoff WILL-A: the two of Will's eight that CC can build today.**

1. **CABLETYPE-ADD.** Add cable types from the Cable Types screen. Spec:
   `handoffs/parallel/260922-1237_cabletype-add_TO-MAINLINE.md`.
2. **LIBRARY-DELETE.** Delete a library row, and Delete All, with a button and a shortcut. Spec:
   `handoffs/parallel/260922-1237_library-delete_TO-MAINLINE.md`. Its prerequisite, *"library should be in version
   history"*, is already true. **Arch's assumption, stated to Daniel in one line with the handoff:** it ships
   before any version restore exists, like every other delete in the app today. He strikes it in a word.
3. **Ride-along, last checkpoint: METHOD-CREATE-CABLE.** On the cable list, a new method name is created, as v1
   does, replacing the refusal Daniel rejected (*"Adding a method called Nutes should make that a method that
   appears in GCM"*). Mirror the equipment list's CHANGEALL-METHODNEW path.

Re-measure every citation at `cef0949`. ⚠ **PROPOSAL-ASKS-FIRST:** a user-visible choice that is neither Daniel's
words nor v1 evidence stays out of the handoff and is asked in plain words. ⚠ **JOY-READ-ONLY:** gate steps that
write use the Cable Parity Fixture or a `daniel+test01` show, never JOY. Write each step as what Daniel clicks and
what he sees.

**WILL-B, the moment WILL-A commits: SHORTCUT-HELPER** (`260922-1237_shortcut-helper_TO-MAINLINE.md`). It ships
alone because it re-baselines the top bar (HANDOFF-BUNDLE).

## Once Daniel says CC is running: the rest of Will's eight

Parallel openers (`handoffs/parallel/` plus `drafts/` copies, real-clock stamps):

- **LIBRARY-PANEL**: design the read path (the LIBRARY return's one open call; v1 layout 26).
- **BUNDLE-CLONE-EXT**: take Daniel through R4–R8 (`260922-1502_bundle-clone-ext_RETURN.md`), quoting each one, and
  list the v1 Add-Extension frames he still owes. R1–R3 are ruled.

On the main line, which is the only seat that may touch the schema:

- **IP-ONE-FIELD**: rehearse the migration, then Daniel's Trigger B, then its CC half as WILL-C.
- **SEED-DEFAULTS + DEFAULTS-ADMIN**: all rulings are in (Ledger 2026-09-24/26). Rehearse the global box-types
  migration. First check whether the licence parallel has returned, because the admin check is its surface.

## Later, not this session

The CHANGEALL leftovers (TAB-AFTER-SCOPE, MMM-CAT-GATE, LENGTH-WORDS), STALE-WRITE, the box family and cable
splits. These can ride along if a unit touches the same screen.

## Traps

- **Hand work to CC first; don't narrate.** No git status and no state report beyond one line, unless a check
  fails.
- **One unit, one handoff.** If a gate fails, re-scope in a sentence rather than chaining addenda.
- **Write to Daniel in plain words**; jargon stays in CC handoffs. MAILGATE holds, so Daniel is the one who writes
  to Will.

---

## For Daniel

Next session opens with Will's list. CC gets adding cable types and library delete straight away, with the
new-method fix riding along. The shortcut helper follows as soon as that commits. While CC works, side sessions
design the library panel and take you through the bundle rulings, and I rehearse the IP address and defaults
changes with you. Everything else from this week waits.
