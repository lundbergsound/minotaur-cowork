# Owed at Daniel's desk — v3, 2026-09-10

*Supersedes `260909-1931_owed-at-daniels-desk_v2.md`. **Discharged since v2:** leg 3a, BATCH-HARNESS, HARNESS-SETTLE and DARKMODE-PASS are all built, committed and deployed — the "one thing blocking everything" in v2 is gone. **Nothing in this list blocks CC.** It is sorted by cost of leaving it.*

---

## ⚠ 1 · THE ONE TIME-SENSITIVE ITEM — rotate the test-user password

A credential was printed to disk by CC during this session, disclosed immediately and remediated in the tree. **The rotation itself is still owed and only Daniel can do it.** Everything else on this page can wait a week; this one gets worse by sitting.

## ⛔ 2 · Browser gates — POSTPONED, NOT WAIVED (Daniel's words)

Three units shipped with the machine gates green and the browser gate deferred by explicit ruling: **leg 3a**, **HARNESS-SETTLE**, **DARKMODE-PASS**. He understood and accepted that this means going back to edit something already in production if a gate finds a defect.

**What is unverified, in order of how likely it is to matter:**

1. **DARKMODE-PASS's look.** Whether `#8a8580` is legible *enough*, and ⚠ **the orange button — its Orange case exists only on Daniel's own project**, so the fixture (Blue) left every frame identical. **Machine-unverifiable by construction.**
2. **leg 3a's ⌥⇧E and toolbar-Delete landing** from inside a band. The single most plausible way that unit broke something that already worked.
3. The equipment dropdown's on-screen behaviour near the bottom of the screen.

⚠ **The record is not ambiguous about what this gate catches:** Tail Panel labels (63 of 137 wrong after four green machine runs) · CATNOTE-RULE · three equipment-list defects no machine saw · Change All blanking the box column on live data. **Five occasions where the machines were green and the unit was wrong.**

**Smallest possible ask when he has ten minutes:** approve the browser pane for `http://localhost:3000` once. Arch can then pre-screen everything DOM-measurable and leave him only the two *look* judgements above. ⚠ **BROWSER-NOPRINT: the pane does the behavioural half, never the printed half.**

## ⛔ 3 · Version history — still ONE message, seven rulings

Unchanged from v2 and still the largest thing gated on a single reply. **Arch leans yes on all seven and will take them on his word.** R-V1 fork-only restore · R-V2 hourly with skip-if-unchanged, retention 48h/30d/weekly · R-V3 snapshot before Change All, Delete Found/All, import apply, plus manual Save · R-V4 History under ⚙ PROJECT → History · R-V5 sequenced after DARKMODE-PASS (**now shipped, so this is unblocked**) · **+1 if the snapshot fails, the destructive gesture REFUSES** · **+2 does the equipment LIBRARY belong in a snapshot** — 32% of every snapshot, 1.71 MB of 5.38 MB, but a fork without it has an empty autocomplete.

⚠ **Measured, and it sharpens R-V2:** the largest show snapshots at **5.3 MB**, compresses by nothing, and one active editing day is **40–50 MB before thinning** against a 34 MB database. **Skip-if-unchanged is not an optimisation; it is what makes the design viable.**

## 📋 4 · New rulings owed, from this session only

- ⚠ **DEADCLASS-SURFACE — which of the 105 dead `text-surface-*` sites SHOULD be dim.** Not machine-decidable: the class emits no CSS, so there is no intent to recover from the code. **No sweep until he rules.**
- **Muted dark, priced:** as built `#8a8580` (WCAG 4.07–4.85) · `#9a958f` (5.0–6.0) · `#a8a39c` (5.9–7.1). Cost of each is glare, not density.
- **Light mode:** untouched at 1.45–1.67. Adopting `#6f6b64` gives 4.61–5.30 — ⚠ **a bigger visual change than the dark half, and it moves all fourteen light frames.**
- **Chrome type 9px → 11 or 12px:** measured on the running page, **costs THREE PIXELS and ZERO ROWS.** The density objection does not survive measurement. ⚠ Boundary of that measurement, stated: **chrome bands only** — text inside rows was not measured, because no note asks for it.
- **NOTE 8's hit target:** the ✕ measures **9 × 18 px** against a 24 × 24 minimum in every guideline that names one.
- ⚠ **GREEN, where the ruled palette and the live app already disagree.** `MINOTAUR_COLORS` pairs Green `#70AF46` with **white**; both luminance fallbacks say **black**; black measures **7.91** against white's **2.66**, and `contrastColor()` already returns black. **The app diverges from the palette today.** Not silently reconciled — it belongs to CONTRAST-PAIR's own close.
- **⌥⇧D's landing** — built as the clone's Quantity on the file's own band-exit precedent, because **there is no Model cell on a row**. Still his call.

## 📋 5 · Carried forward, unchanged

**Unrun acceptances:** the 5167 sheet against a real Avery blank · the Tail Panel reprint.

**Rulings:** CHANGEALL-NAALIAS · BOXBAND-DOCTRINE · BOXBAND-DUPKEY's band identity · CATCOUNT-COLUMN · EQUIPLIST-DOTRULE · EQUIPLIST-CLMARGIN · BUNDLE-LINK-IMPORT · CABLE-TAB-BUNDLE-METHOD · the library's absent Tab order · the `CLAUDE.md` rulings-list relocation · bundle `name`'s uncited Change All exclusion · `in_box`'s findability · the three unportalled autocompletes (**measured: none has a clipping ancestor, so the reported defect cannot occur there**).

**Dated:** ⚠ **CAND-4 — OVERDUE** · ⚠ **LEGAL-SEP is now**, and it carries TWO items: version history's retention window, and `equipment_list_revisions`, which holds **2.78 MB in SEVEN ROWS** and grows on every revision print **with no retention rule** · SPENDCAP-BETA before public beta.

⚠ **Do not re-import the parity fixture** to restore `num_labels` before someone looks at what ran **2026-09-01 13:03 UTC** — the re-import overwrites the only evidence. **The live shows are unaffected; this was checked, not assumed.**

**Housekeeping:** `_to_delete/260906_arch-stray-outputs/` and `_to_delete/260910_arch-scratch/` · the untracked `Claude outputs/` and `docs/reference/evidence/equipment/` · GIT-CFG's remainder.
