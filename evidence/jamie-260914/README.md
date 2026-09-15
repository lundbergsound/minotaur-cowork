# Jamie Tippett — first-night findings, 2026-09-14

Intake 2026-09-15 by the Arch seat. Frames relayed by Daniel; capture times unknown,
so the folder is dated to the night of the findings, not to intake.

## jamie_01_equiplist-blank-row.png

**What it shows, read at face value.** The equipment list in category sort. Category
band `2.0 Speakers` (the name carries its v1 sort prefix), model band `d&b E0`, and
one record beneath: Qty `30`, method chip `Rent-Main`, Rem `0`, the five flag
checkboxes, and **every free-text cell on the record blank** — Description, Group,
Public Notes, Private Notes, Circuit, IP Address.

**What it corroborates — GROUPCELL-BLANK.** The Box cell renders a visible `—` when
empty; Group and both Notes render nothing at all. That asymmetry is the defect
Jamie reported: a cell with no content and no height floor has no click target. The
root cause is `src/components/equipment/EquipmentItemRow.tsx:497`, where the
non-wrap branch of `InlineText`'s display span carries `h-full` but not the
`min-h-[1.125rem]` floor its wrap branch and two sibling cells carry.

**What it also shows — the row-height question, answered in the direction expected
but NOT measured here.** This is the all-blank-cells case, the only candidate for a
row-height change when the floor is added, and the row still renders at ordinary
height: the Qty text and the checkbox column already floor it. That is an
expectation from one frame, not a measurement. The visual gate decides
(TENSE-IS-A-CLAIM).

**What it does NOT show, and this matters.** No dropdown is open anywhere in the
frame. **It is not evidence for AUTOCOMPLETE-NOPORTAL**, whose Roadmap row is stale:
the equipment list's six autocomplete call sites were portalled on 2026-09-08 and
`src/lib/autocompletePortalScope.test.ts` pins the census. Whatever Jamie hit on the
autocomplete is still uncaptured and no fix should be written for it until it is.
