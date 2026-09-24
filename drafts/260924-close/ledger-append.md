
---

## 2026-09-21/24 — Cowork-Arch, the MAIN LINE — GROUP-DEVICE-PATCH · DEVPATCH-JOIN-CASE · CHANGEALL-MMMCAT (uncommitted)

### Rulings of record, Daniel

- 2026-09-21: *"bundle labels skip stickers, not pairs."* BUNDLE-SKIP-UNITS closes as built; no code change; the
  pin is `bundleLabels.test.ts:89`.
- 2026-09-22: *"yes"* to the cable list opening on its first cable, in answer to his own *"why not have the first
  cable selected by default?"* — v1's rule (FileMaker always has a current record).
- 2026-09-22: *"yes to find behavior"* — after any find the first result becomes current; nothing matched means
  nothing current and the inspector greys.
- 2026-09-22: Will Pickens's eight rows placed *"right after cable splits"*, then **moved ahead of the box family
  and cable splits** later the same day: *"move Will's eight, including library delete and IP address, to next
  session."*
- 2026-09-22: *"library should be in version history"* · DEFAULTS-ADMIN *"ask me for it when building it"* ·
  LIBRARY-PANEL fields: public note, private note, rack spaces, power draw, v1 layout 26.
- 2026-09-23 (Aaron Hanna): ALLOCATE as a new row after A4 (absorbs UNALLOC, amends Brief v1.1) · RF-COMMS after
  ALLOCATE · LIVE-COLLAB split out of V1-SECTIONS, after RF-COMMS; "Keep Aaron Hanna updated" on all three.
- 2026-09-23: defaults are copied at creation and never linked; a later change to a default never reaches an
  existing show. *"No need to map a pull defaults right now — I don't think that's an important feature after the
  project is created."*
- 2026-09-24, at the gate: *"3 fail — nothing happens, it reverts."*

### Measurements that cost something to get, and must not be re-derived

- **Device Patch's page order, measured on the BVSC v1 print (83 pages):** devices that join an item with a blank
  group first (14 headings, all with a Model), grouped devices next (113), devices with no join last (257, none
  with a Model). 14 + 113 = 127, the design's exact-match count.
- **Relationship 344 is CASE-INSENSITIVE.** The remaining-layouts design §4.2 said exact; v1's own BVSC print
  refutes it (`Timax/SD7 Mac` and `Dimmer Video Matrix` both print a Model; `FX A Mac ` with a trailing space does
  not, so whitespace is significant). Over the BVSC workbooks the module now gives 384 headings / 127 Models, which
  is v1's print to the digit; exact gave 385 / 126. **The design file is wrong in two places and Arch owes it an
  amendment.**
- **Group Parts on JOY:** 615 v1 lines against 614 v2, same quantities and models on every line; the differences
  are the ruled number-aware order and `150ft'` → `150'`, a stray unit in v1's data.
- **Device Patch on JOY:** 218 device headings; the missing rows are all the mult `cPreview`, which is not in v2's
  JOY at all (IMPORT-TRAILSPACE). 14 devices show a different `Model:` because several equipment items share one
  device name and **every JOY row shares one `created_at`** (636 lines, 461 cables, 665 equipment items → one
  distinct value each), so v2 cannot recover v1's entry order. Same cause as the ~30 tie-order differences.
- **Change All on 1,123 cables:** ~10.1 s cold, ~3.4 s warm. `snapshot_project_v1` 5.3 s cold / 1.7 s warm;
  `bulk_update_v1` 3.9 s. More than half the time is the version snapshot, which runs before the write by ruling.
- **Two sessions, one project (one account, two browser contexts):** no live update on either list (8–10 s, no
  change until reload); a same-cell collision silently overwrites and the loser's screen keeps showing a value that
  is no longer stored; **an edit to a row deleted by the other session is accepted on screen and never saved, with
  no message anywhere.** A second test account is owed before the sharing half can be measured at all.
- **The equipment library is in every version snapshot and always has been** (130 versions checked, no broken
  pointers). **"Open as new production" calls nothing and its database function does not exist.** Equipment List
  Revisions, import history and the per-show feature switches are in no backup at all.
- **Bundle clone/extension needs no migration**: the link tables already accept a bundle's id, the index and
  policies already cover it — measured live. The August Trigger B on that row is struck. Three of the four
  "missing" v1 frames were already committed at `docs/reference/evidence/cable/d2b_0{1,2,3}.png`; the recon said
  the directory was empty, having listed the directory.
- **The JOY box pair, content only:** Big Box Labels and Replacement Numbers match v1's text on every page; the Box
  List is missing six weights (Band Signal, SPARE COMBO, SPARE SIGNAL, Spare Network, Spare NL4, Spare Power) and
  Jump differs 181 vs 180; the Contents List prints no Packed marks (every boxed JOY row reads not packed in v2)
  and does not combine two lines of the same name (v1 `3 Listen Stations`, v2 `2` + `1`).

### Arch's errors this session, named

1. **The design's "exact join" was carried into the handoff without re-measuring**; it shipped and had to be
   fixed the next day. The Surface Rule's own failure mode: a citation inherited rather than read.
2. **A wrong stop condition.** The DEVPATCH-JOIN-CASE handoff told CC to stop unless a name count came out 127;
   the count is a heading count, the name count is 128, and CC was right to build and say so.
3. **"Five fields"** in the inspector; there are four — Group is an `InspectorText` and was already greyed.
4. **Two parallel openers stamped ~3h ahead of the clock** (PARALLEL-CLOCK says the real time of writing).
5. **A gate step written in shorthand Daniel could not run** ("the category sub-band", "⌥⇧I"), twice.
6. **Arch asked to drive a browser** to measure CHANGEALL-NOTE, carrying an instruction from the previous close
   rather than questioning it. Daniel: *"that's not how we typically work, correct?"* It is not: CC reproduces,
   Daniel gates.

### What closed

Group Parts and Device Patch (`d12b80d`), each on the equipment find grid, which is now one shared component the
Equipment List print renders through — proven unchanged by eight before/after DOM captures. The 5160 title
underline. The device-join fix (`d25d366`). CHANGEALL-NOTE is **parked** — CC could not reproduce it on twelve
gestures at HEAD and Daniel does not remember the gesture; the twelve are the record.
