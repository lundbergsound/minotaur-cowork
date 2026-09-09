# Owed at Daniel's desk — consolidated 2026-09-08

*Everything currently waiting on Daniel, in one place, sorted by what it blocks rather than by when it was raised. Written because today's items landed across three drafts and a chat, and a list scattered across four places is a list nobody works through.*

**Discharged today, so it is not below:** production READY at `1276cc4` (CC's pre-open returned `LATEST READY`) · the Cowork docs push (`65c34cf`) · the `box_number` spelling (delegated to Arch, ruled `box_number`) · boxes and bundles held to the field contract · APPLY-TIMEOUT unparked.

---

## ⛔ BLOCKING — FIELD-CONTRACT leg 3a is BUILT and CANNOT COMMIT without these

**The tree is uncommitted with 13 changed files. All machine gates are green: suite 2926/153, typecheck 0, frozen 3/3, build clean, dependency clean, visual 28/28 at 0.0000%, migration ledger 57 unchanged.** GATE-BEFORE-COMMIT makes the browser gate a precondition, not a follow-up — a WF-1a push is a production deploy, so a defect the gate would catch is a defect already live.

⚠ **A close that ends with an uncommitted tree has not ended.** This sat four days once before, with the database ahead of the code.

### 1 · The browser gate — five checks

1. **Autocomplete near the bottom of the list.** Open a Method or Box cell on a row near the BOTTOM — the menu should be fully visible and flip upward. Same for the two band editors and the two New Defaults fields. *(This is the "auto fill is cut off by bottom of screen" note.)*
2. **⌥⇧D from the Model band editor.** It now duplicates and lands the cursor in the clone's **Quantity**. Before this it landed nowhere. **See ruling 2 below.**
3. ⚠ **⌥⇧E and the toolbar Delete must be UNCHANGED.** From a row cell they land in the same cell on the next record; from a band editor, in Quantity. **This is the non-regression that matters most** — it is the one thing the build could plausibly have broken.
4. **A bundled cable's Group** in the inspector: read-only text carrying the BUNDLE's group, Tab skipping it (Method → Box). An unbundled cable unchanged and still editable.
5. **⌥⇧F from a cable inspector field** should default Find to that field — Color, Category, Method, Group, Public/Private Notes, ETA.

### 2 · ⚠ THE ONE RULING THAT GATES THE COMMIT — where should ⌥⇧D land?

**Your CDMX note said "duplicating from the Model field should land back in Model."** That did not reach the handoff — Arch passed on the symptom and not the criterion — so CC chose a landing and flagged it rather than deciding quietly.

**Measured since, and it makes the note ambiguous rather than wrong: there is no Model cell on a row.** Model is editable ONLY in the band header (`EquipmentItemRow.tsx:923` — *"Model editing moved to the model row"*; no `data-equip-field="model"` anywhere in the row component). A duplicated row has no Model of its own — it inherits the band's.

**So the question is what you want after ⌥⇧D from the model band:**

- **(a) the new row's Quantity** — as built, on the file's own precedent: the band-editor Tab-out already lands in the active record's quantity, and the four flags land there too. Lets you type a count immediately.
- **(b) stay in the Model band editor** — the truer reading of "preserve the focused field," but arguably a no-op: the clone is in the SAME band as its source, so it is the editor you were already in.

---

## ⛔ BLOCKING — version history cannot be designed further

### 3 · Seven rulings, answerable in one reply

| # | Ruling | Arch's lean |
|---|---|---|
| **R-V1** | Restore is **fork-only** ("Open as new production") for the first cut; in-place restore its own later unit | Yes |
| **R-V2** | **Hourly with skip-if-unchanged**; retention default hourly-48h / daily-30d / weekly-beyond, pending LEGAL-SEP | Yes |
| **R-V3** | Automatic snapshot **before** Change All · Delete Found/All · import apply, plus a manual **Save version** | Yes |
| **R-V4** | History lives in **⚙ PROJECT → History**, one action per row; read-only viewer deferred | Yes |
| **R-V5** | **VERHIST-MIG** (Arch, Trigger B) then **VERHIST-UI** (CC), placed after DARKMODE-PASS | Yes |
| **+1** | ⚠ **If the safety snapshot FAILS, does the destructive gesture proceed?** | **NO — refuse and say why.** A net the operator believes is there and is not is worse than none |
| **+2** | ⚠ **Does the equipment LIBRARY belong in a snapshot?** *(new, from the payload measurement)* | Undecided — it is **32% of every snapshot** (1.71 MB of 5.38 MB), but a fork without it has an empty autocomplete |

**Arch will take all seven on your word if you would rather delegate, as with the box spelling.**

---

## 📋 NOT BLOCKING — real, registered, waiting

### From today

- **The find sweep.** 25 fields made searchable by static analysis only; a wrong one returns an empty find, which reads as missing data. Checklist at `drafts/260908-1649_findparity-untyped_sweep-checklist.md`. **Before CDMX leans on it.**
- **The three unportalled autocompletes** — print options ×2, previous revisions ×1. **Measured: none has a clipping ancestor, so the cut-off defect cannot occur at any of them**; only the viewport half applies, and all three scroll at document level. Close them or leave them.
- **bundle `name`** is excluded from bulk edit with **no citation and no operator-facing sentence** — the code says so about itself. Boxes render their exclusions to the operator; bundles do not. Rule it, then say it.
- **`in_box`** is the one box field Find cannot reach — correct under the subset rule, but you may want it findable anyway.
- **CABLE-TAB-BUNDLE-METHOD.** Bundle is row-chain #3, Method is inspector-chain #3. **Current behaviour is correct for the ruled order**; joining the chains is an unruled change.

### Carried, none blocking

**Unrun acceptances on shipped work** — still the only two: hold a printed 5167 sheet against a real Avery blank (deferred 2026-08-31) · the Tail Panel reprint (owed since PANEL-CLIP).

**Rulings:** CHANGEALL-NAALIAS · BOXBAND-DOCTRINE · BOXBAND-DUPKEY's band identity · CATCOUNT-COLUMN · EQUIPLIST-DOTRULE · EQUIPLIST-CLMARGIN · BUNDLE-LINK-IMPORT · the library's absent Tab order · whether to relocate the 34,808-character rulings list out of `CLAUDE.md`.

**Dated:** ⚠ **CAND-4 — OVERDUE** (four personal texts to the named beta candidates) · **LEGAL-SEP is September, i.e. now** — and it has grown a second item: ⚠ **`equipment_list_revisions` holds 2.78 MB in SEVEN ROWS, ~400 KB per revision, growing on every revision print with no retention rule**, so it belongs in the same conversation as version history's retention window · SPENDCAP-BETA review before public beta.

**Evidence still owed:** a fresh v1 Bundle Summary print (BUNDLESUM-MARKS) · OQ-B, one more Box-in-Box card · three box print reprints · a v1 export from a show that uses cable SPLITS · METRIC-UNRUN's browser gate · STRAT-record entries.

**Housekeeping, whenever:** `Minotaur-Cowork/_to_delete/260906_arch-stray-outputs/` · the untracked `Claude outputs/` and `docs/reference/evidence/equipment/` in the code repo · GIT-CFG's remainder.
