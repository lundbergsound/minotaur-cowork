# CHANGEALL-MMMCAT — ADDENDUM 2: the find ruling, and the three confirmations

Tier: claude-opus-5
Model: claude-opus-5
Session: CONTINUE

*Arch, main line, 2026-09-22 18:55 ET. Against your addendum round in
`from-cc/260922-1250_changeall-mmmcat.md`. Nothing is committed yet. Code base `d25d366`. Every hard stop in
`260922-1255_changeall-mmmcat.md` §0 still applies: no migration, no SQL writes, the frozen layer stays closed.*

## B1 · The find ruling (your OPEN QUESTIONS 2)

**Daniel, 2026-09-22: "yes to find behavior"** — to Arch's proposal: **after any find on the cable list, the first
cable of the results becomes the current one; when nothing matches, nothing is current and the panel greys.**

- Pedigree: v1. FileMaker makes the first record of a found set current after a Perform Find, and this is the same
  rule A1 just applied at open. One rule, two moments.
- It applies to the cable list, the surface this unit is on. **Do not touch the equipment list** (A3 stands: Daniel
  matches the two lists by his own ruling, later).
- **Measure before you choose the mechanism**, and say which you chose and why: re-seating the current row when the
  narrowed set changes, versus deriving `currentRow` from the displayed set. The landing seam's precedence from A1
  holds — a live seam still wins.
- Change All's `ids.length === 0` early return then becomes unreachable from this path; leave the guard, and say in
  DONE that it is now belt-and-braces rather than the only stop.
- Regression tests pin: a find with results makes its first row current; a find with no results leaves nothing
  current and the whole inspector greyed, Change All included. Deletion control RED for each.

## B2 · Confirmations — nothing owed, nothing to build

1. **The 30.50 px editor-open band height (your Q1): nothing owed.** Your own comparison rows settle it — the two
   untouched band editors measure the same, so it is the app's editor height, not the sub-band's. The A5 sticky
   chain reads the at-rest 28.00, which is unchanged in both themes. Arch registers the 2.5 px as an observation;
   it is not this unit's.
2. **Change All arming from the sub-band (your Q3): correct as built.** It matches the outer category band's own
   behaviour. Flagging it rather than assuming it was right.
3. **Four fields, not five (A2): your measurement stands.** Group is an `InspectorText` and already greyed. Arch's
   addendum said five; the count was carried from the CP1 diagnosis. The panel greying as one is the ruling.
4. **The addendum's path (your Q4): not yours to chase.** Arch wrote it to `handoffs/to-cc/` and to `drafts/`; a
   third copy appeared in `Claude outputs/`. Both of Arch's copies exist and are byte-identical. Registered for the
   housekeeping row.

## Close

As the handoff's §3, with the fence updated (FENCE-ONEUNIT). Return the second addendum round in the same file, with
its RAW OUTPUT and the updated COMMIT BLOCK.

**Daniel's gate, on JOY.** Restart `:3100` first. Gate step 2 is rewritten; the rest stand.

1. **Cable list.** It opens with the first cable selected and the bottom panel filled in. Type a method there,
   choose Change All: it's live, and every cable showing takes it.
2. **A find that matches no cables.** Nothing is selected, and the whole bottom panel is greyed — Colour, Category,
   Method, Box and the rest.
3. **A find that matches some cables.** The first of them is selected, and the panel shows that cable.
4. **Equipment list, sorted by Method.** Click a category band under one method and change it: only that method's
   rows change; the same category under another method doesn't.
5. **⌥⇧I** on a model band in method sort opens the category band; ⌥⇧I again goes back.
6. **Sorted by Category:** the category band edits exactly as before.

Proposed subject: `CHANGEALL-MMMCAT: the cable list follows its found set; the category sub-band edits in every sort`.
