# PAPERWORK-1 — ADDENDUM (Arch's reply to the 17:48 return)

Tier: claude-opus-5
Model: claude-opus-5
Session: CONTINUE

*Arch, 2026-09-18 18:20 ET. Reply to `from-cc/260918-1748_paperwork-1.md`. The tree is uncommitted.
The migration ledger stays at 78. §0 of the original handoff still binds. OQ11 is accepted: `Tier:` now
names the model.*

## §1 · Rulings on your OPEN QUESTIONS

- **OQ1 · METHOD-SORT-ORDER — Daniel, verbatim, 2026-09-18: *"blank should sort after anything with a
  value. 0 should sort before 1"*.**
  - Your engine already does exactly this: a null override goes last and 0 counts as a value. **So
    the code stays as built, and there's no change in this unit.**
  - The defect is in the **data**. Arch measured it: v1's user field is `Sort Override Manual`, which is
    **blank** on every live 0, across all seven exports. `Sort Override` is v1's calculation, empty→0,
    and it is what `map.ts:679` imports.
    - `methods.sort_order` is NOT NULL, default 0.
    - `import_apply_v1` coalesces to 0.
    - Live: 23 methods at 0, **none of them ever edited**.
  - This becomes its own unit, **METHOD-SORT-BLANK**: Arch's migration (nullable, no default, backfill,
    and the RPC), under Trigger B, then a CC pass (the importer reads `Sort Override Manual`, the admin
    allows blank, a screen census, and the types). **Not here.**
  - The section-number collision (`3.0, 4.0, 3.0`) goes with it. Keep the REPORTED test.
- **OQ2 · PREVIEW-CLIP.** It moves to Daniel's browser gate. If he doesn't see it on production Safari,
  it closes as fixed by FONT-URBANIST. Nothing to do.
- **OQ3 · the detailed layout loses a row per page on paper.** A lost row is a hard-stop-class defect,
  so **it's fixed in this unit, §2.**
- **OQ4 · `Current` overflow** is registered (BATCH-HARNESS / CONTRAST). Not here.
- **OQ5** is closed as quantum residuals.
- **OQ6 · Line List line order: match v1, in the Line List only.** Pedigree (b): the arbiter pp. 24–60
  print `AC, 1, 2`, and p.1 prints `F, M` in creation order. Build in §3.
- **OQ7 (i)–(v)** stand. **OQ8** is endorsed: omit the stray Arial `1`, and fill the box from the data.
- **OQ9:** no new frame. Registered to BATCH-HARNESS.
- **OQ10** (Settings shows blue while print falls back to pink) is registered. Not here.
- **CP5** stays skipped. The box documents' round is a follow-up.

## §2 · The detailed-row clip (OQ3)

1. **Root cause first.** Confirm or refute that the ~2 px is the method chip's `0.5px solid #ccc` border
   on a colourless method. Measure a detail row's FLOW, production build, print media, 816×1056, on
   **both** a coloured-method row and a colourless one. Quote both.
2. **Preferred fix:** make the row's flow **invariant to the chip's border**, so both shapes measure
   20.328. Draw the border so that it doesn't add layout height. The chip must look the same, which you
   prove with a screenshot of each shape before and after. `DETAIL_ROW_H` then stays **byte-unchanged**.
3. Raise the constant only if step 2 can't be done without changing what the chip looks like. Say which
   route you took and why.
4. Re-run your probe. **0 blocks lost per page in the detailed layout, in print**, on the same shapes
   that lost 1 before. Deletion control.
5. Frame 07 is the detailed view, and it is already declared. If it moves again, show the new diff
   region under the same event. Any other frame moving is a stop.

## §3 · Line List within-mult order (OQ6)

In `lineList.ts` **only** (`compareLines` stays byte-unchanged), sort a mult's lines the way v1's
`Line Sort Number = GetAsNumber(Line)` does:

- lines whose number is **empty** come first, in creation order;
- then ascending by the numeric value;
- ties keep creation order.

Pin it against the arbiter: `AC, 1, 2` (pp. 24–60) and `F, M` (p.1). Invert your REPORTED test. Add a
deletion control.

## §4 · Close, as before

Run the full suite, typecheck, lint, build, frozen 3/3, and the gate (only 07 moves, as declared). Put
the numbers in RAW OUTPUT and add the COMMIT BLOCK. **Daniel's browser gate**, plainly:

1. Print Equipment List on Buena Vista Social Club:
   - solid lines;
   - the new hint line;
   - with Show Revisions on, no row missing at the foot of any page.
2. **In Safari as well:** does anything look cut off in the on-screen preview? (This is PREVIEW-CLIP.)
3. Project Settings → the Paperwork Example at the bottom matches the printed header.
4. Menu → Bundle Summary and Line List both open and print.

Proposed subject is unchanged.
