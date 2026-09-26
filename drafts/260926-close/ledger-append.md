
---

## 2026-09-24/26 — Cowork-Arch, the MAIN LINE — CHANGEALL-REFUSAL (`cef0949`) · defaults and bundle rulings

### Open

Seat check passed except one fact: the 2026-09-24 17:58 opener said CHANGEALL-NEWMETHOD was uncommitted at
`d25d366`. The ref files, CC's CLOSE, Roadmap v4.50 and the Session Log all showed `3809860` committed and pushed at
17:52, six minutes before the opener was written. Flagged at the open; the opener alone was stale.

### Rulings of record, Daniel

- 2026-09-24: CHANGEALL-REFUSAL scope *"yes, go ahead"* (Arch's four-bullet proposal, including the empty-find
  greying and the length refusal).
- 2026-09-24, DEFAULTS (`handoffs/parallel/260922-1857_defaults_RETURN.md` §7): **Q1 "B"** — a *Defaults* show and
  a Publish button · **Q3 "replace"** — Publish makes the shelf exactly what is in *Defaults*, the confirmation
  naming the counts · **Q4 "ticked"** — Equipment Library stays on by default on the new-show screen · **Q6** —
  Daniel writes the switch descriptions; his text, with two copy fixes he approved (*"two fixes approved"*) and the
  italic lines confirmed as on-screen text (*"yes, italic, like v1"*):
  - Default Categories — *What is it?* — "Includes Daniel's default categories for equipment, e.g., 1.0 Consoles,
    2.0 Speakers, 13.0 Cable, etc."
  - Default Methods — *Where do you get it?* — "Includes Daniel's default methods, e.g., Rent-Main, Rent-Cable,
    etc."
  - Equipment Library — "Includes all of the equipment Daniel and his colleagues have used on shows for the past
    10 years, from microphones to consoles to speakers to adapter cables. Makes filling in your production's
    equipment list faster."
  - Default Cable and Tail Types — "Includes common cables (XLR, Ethercon, Edison, Powercon) and multicable found
    in New York shops. You can start with these defaults and edit them to suit your needs."
  - Default Box Types — "Includes the racks and roadcases common in New York shops."
  Q2 and Q5 were ruled 2026-09-23. **Q7 (the five sets' content) is asked at build time.**
- 2026-09-24, BUNDLE-CLONE-EXT (`handoffs/parallel/260922-1502_bundle-clone-ext_RETURN.md`): **R1 + R2** *"same
  strip with keyboard shortcuts"* — Clone and Ext join the Bundle List row strip after Delete · Duplicate, with
  ⌥⇧G and ⌥⇧X · **R3 "v1"** — a cloned bundle's mults arrive with no tails and no lines. **R4–R8 still open.**
- 2026-09-24: CP5.2 (the equipment Category fallback) *"fold it in"*.
- 2026-09-26, the CHANGEALL-REFUSAL gate, verbatim: (1) *"this is accurate, but I have no idea why a dialog would
  appear that says " there's no method called 'Nutes'" — this isn't v1 behavior and I didn't approve this. Adding
  a method called Nutes should make that a method that appears in GCM."* (2) *"Fail — it's the same dialog about
  no method."* (3) *"That's true, but I have no idea where this dialog came from, and it's not useful. Fifty is a
  length, it's just not a number string. If we want the user to do something, the dialog should be
  understandable."* (4) *"pass"* (5) *"pass"* (6) *"pass"* (7–9) *"I'm not changing data on JOY"*.
- 2026-09-26: *"no more amendments to this — I don't know what we're working on or why. write a concise handoff to
  CC where it will finish committing this without asking a follow up question."* Committed as `cef0949` on
  *"COMMIT APPROVED: CHANGEALL-REFUSAL"*.
- 2026-09-26, next session's shape: *"plan to have Arch issue the largest, most bundled handoff possible in its
  first turn. once I confirm CC is running, have it spin off parallel sessions for any open arch design work."*
  (SESSION-SHAPE, reaffirmed in his words.)

### Evidence filed

- `~/Minotaur_v1_exports/layouts/260924-1815_v1_layout_welcome-new-project-defaults.png` — v1's *Welcome to
  Minotaur.* dialog: five Include/Ignore pairs, italic *What is it?* / *Where do you get it?* lines, and a header
  naming "the Daniel's Defaults folder" as v1's import route.
- `~/Minotaur_v1_exports/layouts/260924-1835_v1_layout_bundle-list-clone-ext-strip.png` — v1 Bundle List, row strip
  `- Delete · + Duplicate · + Clone · + Ext`; Bundle Defaults panel with Invert Extensions.
- `docs/reference/evidence/equipment/changeall_refusal_gate_05_category_subband.png` (in `cef0949`) — the category
  sub-band circled: method bar `Rental` › sub-band `11.0 Consoles` › model line `1 CL5`.

### Measurements that cost something to get, and must not be re-derived

- **Why Daniel saw "nothing happens" on 2026-09-24:** the refusal was set inside the Enter keydown; React rendered
  `ConfirmDialog` and ran its effect in the same dispatch; the effect's `window` keydown listener heard the same
  Enter, confirmed, and closed it. No dialog was ever visible on the Enter path. Fixed in `cef0949`: a dialog
  ignores key events created before it opened (`e.timeStamp < openedAt`).
- **A production defect found and fixed in `cef0949`:** Enter on an unknown cable Model silently SAVED a New Cable
  Type and assigned it (same mechanism, `NewCableTypeDialog.tsx`, byte-identical at `3809860`). Browser-reproduced
  with the guard removed: `C2` gained `NoSuchType`, no dialog seen.
- **The equipment list had the Nutes fallback on Category** (`captureEquipDraftRow`, `EquipmentListClient.tsx:
  2556-2558` at `3809860`): *"…replace the "Category" field of these 5 records with "11.0 Consoles"?"*. Method and
  Model are free text there (CHANGEALL-METHODNEW creates; 694). Fixed in `cef0949`, both category editors and the
  single-edit path.
- **TAB-AFTER-SCOPE, measured:** after the equipment scope prompt ("Just This One"), focus is DROPPED to `<body>`
  (`resolveConfirm`, `EquipmentListClient.tsx:2022-2029` at `3809860`); Tab lands in the Category filter, then the
  Method filter.
- **Still latched:** equipment (`:3264`) and library (`EquipmentLibraryClient.tsx:542`) Change All buttons are
  `disabled={!changeAllArmed}` with the arm-once latch. The cable list's now also requires a current row.
- **Same fallback shape, unfixed:** equipment Quantity's NaN arm (`:2544`, unreachable by typing letters into a
  `type=number` input) and a BLANK category draft + Change All.
- **DIALOG-OPENING-KEY:** 28 files carry a `window` keydown listener that names a dialog (coarse grep, in
  `CLAUDE.md`); New Box measured clean; the rest unmeasured.
- Counts at `cef0949`: suite 3,888 / 211 · tsc clean · lint 265 warnings · frozen 3/3 · visual 28/28, no event ·
  16 deletion controls RED · census 0 · no migration, ledger 83.

### Arch errors — five

1. **An Arch proposal carried as a ruling.** The method refusal was Arch's own pedigree (c) in
   `260923-1120_changeall-newmethod.md` §1. The CHANGEALL-NEWMETHOD CLOSE listed *"whether typing a new method
   name should CREATE it"* as Daniel's. This session wrote two more handoffs on the refusal without putting that
   question to him; he first met the behaviour at the gate and rejected it (*"I didn't approve this"*). Standing
   rule added: PROPOSAL-ASKS-FIRST.
2. **Gate steps that wrote data on JOY** (steps 7–9). Daniel does not change data on JOY. Standing rule added:
   JOY-READ-ONLY.
3. **CP1 listed Model's Enter path**, contradicting ruled CP-2 (Enter on an unknown model opens New Cable Type). CC
   bounced it correctly.
4. **CP1 assumed the dialog showed on Enter.** It never did; the 2026-09-24 "nothing happens" was a dialog closing
   itself, not a quiet message. CC found it by measuring first.
5. **The unit sprawled** — one bug, five inbound handoffs over four days (MMM-CAT → ADDENDUM → ADDENDUM-2 →
   NEWMETHOD → REFUSAL + ADDENDUM + COMMIT). Daniel: *"I don't know what we're working on or why."*

### What closed

CHANGEALL-REFUSAL (`cef0949`): no mass write of a stored value on either list; a dialog never answers the key that
opened it; Change All greys with nothing current on the cable list; the category sub-band screenshot. **What shipped
that Daniel rejected:** the cable-list refusals for an unknown method and an unreadable length — the method one is
replaced by METHOD-CREATE-CABLE, the length one by LENGTH-WORDS. CHANGEALL-EMPTYFIND (cable), LENGTH-FALLBACK,
INSPECTOR-ARM and PARALLEL-CLOCK-STAMP close.
