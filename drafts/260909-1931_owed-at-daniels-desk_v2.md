# Owed at Daniel's desk — v2, 2026-09-09

*Supersedes `260908-2007_owed-at-daniels-desk.md`. Sorted by what it blocks. **Discharged since v1: the FINDPARITY-UNTYPED sweep — all 25 fields typed and exact (`260908-2044_findparity-sweep_COMPLETE.md`).***

---

## ⛔ THE ONE THING BLOCKING EVERYTHING — leg 3a cannot commit

**Built, uncommitted, 13 files. All machine gates green:** suite 2926/153 · typecheck 0 · frozen 3/3 · build clean · dependency clean · visual 28/28 at 0.0000% · migration ledger 57 unchanged.

⚠ **The blocker is the browser gate, and it is a real precondition, not ceremony.** A WF-1a push is a **production deploy** — Vercel builds every push to `main` — so a defect the gate would have caught is a defect already live. And the record is not ambiguous about what that gate catches: the Tail Panel labels (63 of 137 wrong, after four green machine runs), CATNOTE-RULE (found on paper after a probe reported its absence), three defects in the equipment list that no machine gate saw, Change All blanking the box column on live data. **Five separate occasions where the machines were green and the unit was wrong.**

### Daniel has three ways out, and they are genuinely different

**A · Approve the browser pane for `http://localhost:3000`** (one click, on the machine). Arch then pre-screens the three checkable items — where focus lands after ⌥⇧E and the toolbar Delete, whether a bundled cable's Group is read-only and reads `Bundles-Backstage`, whether ⌥⇧F defaults to the focused inspector field — **plus whether the equipment dropdown actually portals into `document.body`, which is DOM-measurable rather than visual.** That leaves only the *look* of the dropdown near the bottom of the screen, and the ⌥⇧D landing decision. **Smallest ask, most evidence.**

**B · Waive the gate for this unit by explicit ruling.** He has done this before and it was correct: on leg 1 he answered *"n/a, no rendering surface"* and it was recorded verbatim. ⚠ **But leg 3a is not that unit — it changes what he sees on two screens.** If he waives, he should know what goes unverified: the dropdown's on-screen behaviour, and the ⌥⇧E / toolbar-Delete non-regression, **which is the single most plausible way this unit breaks something that already worked.**

**C · It waits.** ⚠ The registered cost: *a close that ends with an uncommitted tree has not ended*, and this tree sat four days once before with the database ahead of the code.

**Arch recommends A, then B with the evidence in hand.**

### And one ruling that rides with it — ⌥⇧D's landing

Built as **the clone's Quantity**, on the file's own band-exit precedent. His CDMX note said *"duplicating from the Model field should land back in Model"* — **but there is no Model cell on a row** (model is edited only in the band header), so a duplicate has no Model of its own. The live alternative is *stay in the Model band editor*, which may be a no-op since the copy joins the same band. **His call; CC flagged it rather than deciding quietly.**

---

## ⛔ BLOCKING — version history, and it is ONE MESSAGE

**Seven rulings. Arch leans yes on all seven and will take them on his word.**

R-V1 fork-only restore · R-V2 hourly with skip-if-unchanged, retention hourly-48h / daily-30d / weekly-beyond · R-V3 snapshot before Change All, Delete Found/All, import apply, plus a manual Save version · R-V4 History under ⚙ PROJECT → History · R-V5 sequenced after DARKMODE-PASS · **+1 if the snapshot fails, the destructive gesture REFUSES** (Arch: a net the operator believes is there and is not is worse than none) · **+2 does the equipment LIBRARY belong in a snapshot** — it is **32% of every snapshot**, 1.71 MB of 5.38 MB, but a fork without it has an empty autocomplete.

⚠ **Measured, and it sharpens R-V2:** a snapshot of the largest show is **5.3 MB**, the storage format compresses it by nothing, and one active editing day is **40–50 MB before thinning** against a 34 MB database today. **Skip-if-unchanged is not an optimisation; it is what makes the design viable.**

---

## 📋 NOT BLOCKING

**Unrun acceptances on shipped work** — still only two: the **5167 sheet against a real Avery blank** (deferred 2026-08-31) and the **Tail Panel reprint**.

**Rulings:** CHANGEALL-NAALIAS · BOXBAND-DOCTRINE · BOXBAND-DUPKEY's band identity · CATCOUNT-COLUMN · EQUIPLIST-DOTRULE · EQUIPLIST-CLMARGIN · BUNDLE-LINK-IMPORT · CABLE-TAB-BUNDLE-METHOD · the library's absent Tab order · the `CLAUDE.md` rulings-list relocation · **bundle `name`'s uncited Change All exclusion** · **`in_box`'s findability** · **the three unportalled autocompletes** (measured: none has a clipping ancestor, so the reported defect cannot occur there).

**Dated:** ⚠ **CAND-4 — OVERDUE** · **LEGAL-SEP is September, i.e. now** — and it has TWO items: version history's retention window, and ⚠ **`equipment_list_revisions`, which holds 2.78 MB in SEVEN ROWS (~400 KB per revision) and grows on every revision print with no retention rule** · SPENDCAP-BETA before public beta.

**Open, from last night's measurement:** ⚠ **the parity fixture's `num_labels` is zero on every row** where three documents record 150 twos / 57 ones. A single bulk write on **2026-09-01 at 09:03** touched 1,329 of 1,335 generic rows. **The live shows are unaffected — checked.** Arch's advice stands: **do not re-import to fix it before someone looks at what ran at 13:03 UTC**, because the re-import overwrites the only evidence.

**Housekeeping:** `_to_delete/260906_arch-stray-outputs/` · the untracked `Claude outputs/` and `docs/reference/evidence/equipment/` · GIT-CFG's remainder.
