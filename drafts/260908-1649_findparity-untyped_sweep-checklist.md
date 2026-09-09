# FINDPARITY-UNTYPED — the browser sweep checklist

*Written 2026-09-08 by Cowork-Arch, at the open of the FIELD-CONTRACT leg 3 session. Field names below are the LABELS as they appear in each screen's Find panel, read at source from the three find maps at `1276cc4`.*

## Why this exists

FIND-PARITY (`1276cc4`) added 25 new searchable fields across three screens. The test that proves it is a **static source analysis** — it proves the four structures agree, and it proves nothing about what any field does when typed into. Daniel's gate covered four checks on one project.

⚠ **The failure mode is silent.** A wrong accessor returns an EMPTY find, which reads to an operator as missing data rather than as a defect.

## The method — the same for every row

1. Open the Find panel on that screen.
2. Choose the field.
3. Type a value you know exists on at least one record.
4. **You are only checking that rows come back.** Zero rows on a value you know is there = a defect. Note it and move on.

## Equipment list — 5 fields

- [ ] **Labels** — a sticker count. Try `2`.
- [ ] **Override** — a flag. Type `Yes`.
- [ ] **Starred** — a flag. Type `Yes`.
- [ ] **Drawn** — a flag. Type `Yes`.
- [ ] **Packed** — a flag. Type `Yes`.

⚠ The four flags render as a `✓` glyph in the cell but find as the word `Yes` (blank when unchecked). That is the interim face — FINDFLAG-CHECKBOX replaces it with a real checkbox in its own unit.

## Cable list — 7 inspector fields

- [ ] **Color**
- [ ] **Category**
- [ ] **Method**
- [ ] **Group** — reads the EFFECTIVE group, so a bundled cable finds by its bundle's group.
- [ ] **Public Notes**
- [ ] **Private Notes**
- [ ] **ETA**

## Box list — 13 fields

- [ ] **Number** — the one that was rekeyed. Also worth testing from focus: click into a box's Number cell, then open Find; it should default to Number.
- [ ] **Big Labels**
- [ ] **Small Labels**
- [ ] **Color**
- [ ] **Add'l Weight**
- [ ] **Actual Weight**
- [ ] **Add'l Cost**
- [ ] **Label Notes**
- [ ] **Public Notes**
- [ ] **Private Notes**
- [ ] **Return Notes**
- [ ] **Category**
- [ ] **Method**

## What to report back

Only the rows that returned nothing, and what you typed. That is enough to name the accessor.

*Registered as FINDPARITY-UNTYPED. Owed before CDMX leans on the find.*
