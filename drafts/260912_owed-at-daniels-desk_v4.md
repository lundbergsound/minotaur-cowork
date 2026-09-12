# Owed at Daniel's desk — v4, 2026-09-12

*Retires `260910-1913_owed-at-daniels-desk_v3.md`. Written by the Cowork-Arch main line. Gate items first, because ≈Sept 18 is the driver.*

---

## ⚠ 1 — THE PREBETA-FRICTION BROWSER GATE, DEFERRED BY DANIEL 2026-09-12 AND OWED

**Deferred deliberately, logged here so it is not lost.** The unit is green on every machine gate; this is the human one, and **GATE-REPORTING says a green machine gate is never a substitute for it.**

⚠ **It is also the only place CC's central speed claim becomes real.** `Versioning Test` is Daniel's own production and is **RLS-invisible to the test user** (HARNESS-RLS-CORPUS), so CC could not delete a cable there. Every timing in the return is a **reproduction on a seeded throwaway carrying that production's measured topology** — correctly labelled as one by CC. **Until this gate runs, "six seconds became half a second" is proven on a replica and nowhere else.**

**On `Versioning Test`, three things:**

1. **Delete a cable that sits in link groups, and time it.** ⚠ **A real delete of a real cable** — the fixture is Daniel's, the row does not come back. The measured shape there: 574 groups, 1,278 memberships, 80 of 459 cables linked, **median 16 groups per linked cable**. Expect the wait to drop from ~6 s to well under one.
2. **Run a v1 export from the settings page and count the filenames.** Expect **14**, with the spaces intact in `box types.xlsx` and the four cable multiword names.
3. **Look at the export hint text while that screen is open** — see item 3 below.

**Until it runs:** the unit may commit, but **it must not be pushed** — a push is a production deploy. See the amendment of record.

## 2 — THE FIVE CARRIED GATE ITEMS FOR ≈SEPT 18

- ⚠ **Beta terms in force before a single outsider touches v2** — his own 2026-08-15 rule, and **the hardest gate on the list**. This week.
- **The invite note** and the one-page cohort brief, carrying CAND-4. Then tell the sixteen.
- **A cable label print on real stock**, and the 5167 sheet with it.
- **The production READY check** — permanently his; the seat has no egress and no mount fixes it.
- **The cohort's email addresses**, for provisioning under SHARE-R8 (ruled 2026-09-12).

## 3 — RULINGS OWED, SMALLEST FIRST

**EXPRPT-HINT (new, 2026-09-12).** The export hint at `settings/page.tsx:451` still reads *"(equip/library/methods/categories)"* — the same four-of-fourteen staleness as the report, but in operator-facing text. **CC correctly refused to rewrite it: new wording with no pedigree.** Arch's marked proposal, his to accept or replace:

> Generates a v1-compatible .xlsx set — equipment, library, methods, categories, boxes and the cable sheets — as a .zip, reviewable here before you download it.

**CABLEDEL-FAILMSG (new, 2026-09-12).** The pre-delete cascade's failure message reads *"Delete aborted — the pre-delete cleanup failed: …"*. It does not say that some link groups may already have changed. **True before this unit as well as after it** — the path was never atomic — so this is a standing wording gap surfaced by the fix, not caused by it.

**INSPECTOR-ARM.** The other half of his 2026-09-11 gate pair, and **still the only thing blocking it**. `method` lives only in the inspector, which arms Change All **only when a row is selected**; with none selected the field is clickable and typeable, the button stays disabled **with no explanation on screen**, and clicking does nothing. **Two fixes, both UX-affecting, both unruled:** arm against the row the inspector is showing, or make the button say why it is disabled. **One word chooses it and CC can build it the same day.**

**DEADCLASS-SURFACE.** Which of the 105 dead `text-surface-400/500/600/700` sites *should* be dim. Not machine-decidable — the class emits nothing, so there is no intent to recover from the code. **No sweep until then.**

**BOXBAND-DUPKEY.** Which spelling shows when `Truck 2` and `truck 2` merge into one band. ⚠ **Do not correct `More Hardware`'s truck string** — plausibly genuine v1 data and the only known live reproducer.

**VERHIST-MANUALLEAD.** Save Version's refusal sentence, shipped as a marked PROPOSAL. **A gate: no further Save Version work until the wording is ruled.**

**SEDRULE-REMAINDER.** Whether the auto-mode rider expires on schedule at Sprint 4 close. **His alone; Arch lays out the options and does not decide.**

## 4 — CARRIED FROM v3, UNCHANGED

- The two postponed browser gates — FIELD-CONTRACT leg 3a's ⌥⇧E / toolbar-Delete non-regression, and DARKMODE-PASS's orange button, whose Orange case exists only on his own project.
- The Tail Panel reprint.
- Three ignore lines in the code repo. ⚠ **One correction found 2026-09-12: `session-log-archives/` is TRACKED, so an ignore line does nothing to it** — that one needs a `git rm --cached`, not an ignore.
