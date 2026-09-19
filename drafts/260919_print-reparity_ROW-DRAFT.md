# PRINT-REPARITY — the Docket row, proposed for Roadmap v4.47, and how the old unit was lost

*Arch, 2026-09-19. Daniel: "go look at every session log, and figure out where this fell off the roadmap
and how … then, we'll queue it next. I'll upload a fresh project from Joy to v2 and print several things
that should be identical."*

## The row, installed at the close as ACTIVE row 2, directly after PAPERWORK

| ID | What it is | Who · what it needs |
|---|---|---|
| **PRINT-REPARITY** | ⚠ **Restored 2026-09-19. It fell off at v4.28 without a ruling.** A thorough v1-against-v2 comparison of **every print v2 already ships**, object by object, the method Bundle Summary and Line List passed on 2026-09-18. It covers the equipment list (basic and detailed), the box labels, Box List and Contents List (**absorbs BOX-DOC-PARITY**), and the whole cable label and document family. **It carries PRINT-PARITY unit 2's staged box residuals**: the Stack underline, the dashed grey cut rules (OQ-4, fully specified), Box-in-Box suppressing the Stack (OQ-B), and reverting `MC.BUNDLE_FLAG`. It also carries OQ-3, OQ-5, the v1 continuation header and the cover-page body size. The evidence is a **matched pair from one fresh JOY**: a v1 export plus v1 prints, and a v2 import of that same export plus Chrome prints, as test01. **Why now:** the fallback typeface, the row-rule and page-frame changes, and the shared cable header/footer found 12 pt high and 35 pt low on 2026-09-18 all postdate the 2026-08-30 cable round. | **Daniel** makes the matched pair · then **CC** measures and fixes, one unit per family · **next, before the find screen** |

## How it fell off, measured from the Roadmap files

1. **v4.5 (23 Aug):** PRINT-PARITY was entered as one unit covering all print and preview parity.
2. **v4.8 (26 Aug):** unit 1, the box label family, closed at `8c6b2e0`. The worst element went from
   51.35 pt to 0.63 pt. The cable rounds followed and closed on 30 Aug.
3. **v4.19 to v4.27 (6 to 10 Sep):** **PRINT-PARITY unit 2, the box residuals**, sat in the **Sprint
   Plan's PINNED queue** as "STAGED, UNISSUED"
   (`handoffs/_staging/260826-1845_print-parity-box-ADDENDUM-1_DRAFT.md`, still on disk).
4. **v4.28 (11 Sep), the readability rewrite:** the Roadmap went down to four sections, and **the Sprint
   Plan was deleted as history**. The rewrite checked that **Docket rows** carried over byte-identical.
   **The Sprint Plan's queue was not in the Docket, so nothing checked it.** Unit 2's row vanished.
   **MMM-CAT** vanished the same way. That is the category band being editable under every sort, which
   Daniel hit live on 2026-09-08; it was never built, and today it has zero mentions in the Roadmap.
   The six v1 sections found on 2026-09-18 (RF, Maintenance and the rest) were lost in the same edit.
5. **v4.28 to v4.42:** what survived was one trailing bullet, "PRINT-PARITY's remaining", naming a unit
   that no longer existed. BOX-DOC-PARITY's trigger read "after cable parity", a condition already met
   on 30 Aug. So the row sat, with nothing to start it.
6. **v4.43 (17 Sep):** the bullet went, and with it the cut rules, OQ-3, the continuation header and the
   cover-page size.
7. **v4.45 (18 Sep):** BOX-DOC-PARITY was folded into PAPERWORK step 1. The Tail Panel reprint, OQ-B
   and BOX-REPRINT stopped being mentioned at all.

**The pattern:** each shortening pass checked only the part of the file it was told to carry over.
The 2026-09-18 guard checks the Brief's section list, and **it would not have caught this.** It checks
sections, not units.

**The proposed guard, one line:** a Roadmap rewrite censuses **every unit ID** in the version it
retires against the new one. Each ID must be present, closed in the Ledger, or retired by a quoted
ruling. It replaces the narrower Brief-section census rather than adding to it.

## Also to restore at the close

**MMM-CAT**, as its own ACTIVE row after PRINT-REPARITY: "The category band on the Equipment List can
be edited only when the list is sorted by category. Ruled, never built. Daniel hit it live on
2026-09-08."
