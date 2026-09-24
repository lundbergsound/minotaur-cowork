# DEVPATCH-JOIN-CASE: Device Patch's device-to-equipment join is case-insensitive, as v1's is

Tier: claude-opus-5
Model: claude-opus-5
Session: FRESH

*Arch, main line, 2026-09-22 11:30 ET. Code is at `d12b80d`, which is `origin/main` (GROUP-DEVICE-PATCH, shipped).
The migration ledger is **83**. Read HEAD and origin from the ref files, and read the ledger live. No migration;
no SQL writes. Test shows only — JOY `0d329963-dcd1-403d-a5ad-1f78f0b9a425` and throwaways, never BVSC, never a
cohort member's show. Raw Output Rule, verbatim: *"Reproduce the complete raw output verbatim — into the
handoff file's RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or
describe it. Show every line."* GATE-NOGREP. Commit only on Daniel's `COMMIT APPROVED: <first words>`.*

**What this is.** A defect in the unit that just shipped, and the error is Arch's. The design (remaining-layouts §4.2)
said Relationship 344 joins on **exact** text. The JOY matched pair shows it is **case-insensitive**, and
`devicePatch.ts:189-198` (`buildDeviceJoin`, keyed on the raw description) builds it exact.

**Evidence, pedigree (b):**

- `~/Minotaur_v1_exports/parity-pairs/260922_group-device-patch_gate/260921-2344_v1_device-patch_JOY_FILEMAKER.pdf`
  vs `…/260922-0844_v2_device-patch_JOY_chrome-savepdf.pdf` (made before the addendum; the join is unchanged).
- Daniel's v1 JOY screenshot, 2026-09-22: the six Galileos' **Description reads `Gal 1` … `Gal 6`** (model Meyer
  Galileo 616).
- JOY v2's cable/line end texts, read live (SELECT only): `GAL 1` ×3, `Gal 1` ×2, `GAL 2` ×3, `Gal 2` ×2, `Gal 3`
  ×5, `GAL 4` ×8, `Gal 4` ×3, `Gal 5` ×2, `GAL 11` ×1.

**What v1 printed:** `GAL 1`, `GAL 2`, `Gal 3`, `GAL 4`, `Gal 5` in the **joined** band, each with `Model: Meyer
Galileo 616`. `GAL 2` carries both spellings' rows under ONE heading, as does `GAL 4`. So `GAL n` joins the item
described `Gal n`. **v2 printed** `Gal 1/2/4` joined and `GAL 1/2/4` as separate **unjoined** headings with no
model — 3 devices split in two, 3 models missing.

(v1 also prints a separate unjoined `Gal 1` with no model. That is two of the cable ends whose v1 text must differ
by a character that doesn't print — IMPORT-TRAILSPACE, since v2 trims on import. Not this unit's; say whether
anything else supports it.)

## The fix

1. `buildDeviceJoin` and the lookup match with FileMaker's `=`, i.e. the existing `fmEqual` sensitivity (case-
   insensitive, `devicePatch.ts:210`), still **the first related record in creation order** among the
   case-folded matches. Update the header comment (lines 35 and 47-48): the join and the heading break are
   **both** case-insensitive.
2. **Measure** which spelling a merged heading prints: v1 prints `GAL 2` and `GAL 4` over mixed-case rows. Read the
   rows and state the rule (the first row in print order, most likely). Do not guess.
3. ⚠ **The BVSC count check, before you trust the fix.** The design measured BVSC NY at **127 exact matches,
   129 "if case and surrounding whitespace are ignored"**, and v1's BVSC print shows **127** model values. Count
   the case-only match (untrimmed) against the design's corpus workbooks, not the live BVSC project. If it is
   **127**, the two extra were whitespace, and both prints agree. If it is **not 127**, **stop** and report both
   numbers with the device names. The two prints would then disagree, and that is Arch's to resolve.

## Success

- A throwaway seeded with the Galileo case (item `Gal 2`; ends `GAL 2` and `Gal 2`) prints ONE joined heading
  with `Model: Meyer Galileo 616` and all the rows, in the joined band.
- The existing tests that pin an **exact** join are rewritten to pin the case-insensitive one; deletion control
  (revert to exact) goes RED.
- Full suite, typecheck, lint, build, frozen 3/3, visual gate (no event expected: no frame shows Device Patch),
  dependency gate, census 0. Return DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT + COMMIT BLOCK.

**Daniel's gate, on JOY.** Restart `:3100`. Device Patch, blank find: `GAL 1`, `GAL 2` and `GAL 4` sit near the
top with `Model: Meyer Galileo 616`, and each appears once, with no second model-less copy further down.

Proposed subject: `DEVPATCH-JOIN-CASE: Device Patch joins a device to its equipment case-insensitively, as v1 does`.
