# HARNESS-SETTLE — Arch's read and four rulings, one of which corrects Arch

*Cowork-Arch, 2026-09-10. **Carried out of `handoffs/from-cc/260910-0100_harness-settle.md`, which is GITIGNORED.** Unit BUILT, uncommitted. Two files, 255/−9, **no app code.***

## 1 · The acceptance was met in full

**FIVE consecutive 28/28 gate runs. No frame moved in any of them. `--update-baselines` was never run and nothing was rebaselined to make the gate green.** Fixture state read live afterwards: `equipment_sort_mode = 'category'`, `theme_preference = 'dark'`, both as found.

**That is the first time this tree has closed the gate at all** — BATCH-HARNESS committed on the import graph precisely because it could not.

**The root-cause call held and was under-scoped, in the useful direction.** §1's three fixes were built; **two more bounded waits and a matcher repair were measured into existence by the unit's own runs** — the library and settings routes, and a hole in HARNESS-SORTLEAK where the awaited response matched on URL only, so it resolved on the *method* write still in flight and let the navigation abort the *category* one. Same defect class, found by running rather than by reading.

**The read is now bounded on a real observable**, chosen by elimination rather than convenience: TopBar's mount effect sets state, toggles the `<html>` class and writes `localStorage` in one synchronous block, so **the localStorage write is the last statement and observing it proves the class before it is already correct.** ⚠ **The alternatives were CHECKED and rejected on measurement** — the button title and the class derive from the same value, so they agree both before and after the re-sync and neither can witness it.

## 2 · ⚠ RULING — flake (2)'s register entry SPLITS, and this corrects Arch

**CC's finding:** flake (2)'s stated invariant is `1451200 px at bbox 0,93–1599,999`. **1,451,200 is 1600 × 907 — the settings body region.** A region-sized diff says *this whole region differs*, which is equally true of content that is **blank** and content that is **mistinted**. ⚠ **The invariant identifies WHERE, not WHY, and every prior sighting was attributed by its numbers.**

**RULED:** the entry becomes **two** — **(2a) unpainted content in the CORRECT theme** (what this unit measured and fixed) and **(2b) content painted in the WRONG theme** (the mechanism the entry is named for). ⚠ **Prior sightings attributed on the number alone are marked UNATTRIBUTED rather than retro-assigned to either.** Inventing an attribution to tidy the register is the error the register exists to prevent.

⚠ **AND IT CORRECTS ARCH DIRECTLY.** On 2026-09-09 this seat told Daniel that BATCH-HARNESS's second gate failure was *"flake (2)'s registered theme-race invariant, to the digit."* **The number matched; the MECHANISM was never established, and the invariant could not have established it.** The commit verdict stands — it rested on the import graph (zero app modules changed, verified at source), not on the attribution — **but the confidence in the attribution was not earned.** *A measurement's boundary is a claim too — fourth occurrence, and the first on this seat since the leg-3a needle.*

**Evidence at risk:** the failing capture, its baseline and the diff PNG were left in CC's session scratchpad on the Mac. **Not reachable from this seat and session-scoped, so assume gone unless Daniel moved them.** The finding survives on its arithmetic regardless.

## 3 · RULING — §C ratified, and it earns a rule

Acceptance run 4-then-5: a run **REFUSED at load 6.20 before capturing anything**. `--force-load` not used; the machine was allowed to settle to 3.36 and the run retaken, passing at 3.44.

⚠ **The load was raised BY THE RUNS THEMSELVES** — four back-to-back gate runs each spawn a dev server and a browser. **New rule: a reliability measurement must let the machine settle BETWEEN runs, or it measures its own wake.** And, per the rule ratified 2026-09-09: **a refusal captures nothing, so it is neither a pass nor a fail and is never folded into a count.** CC reported it separately rather than quietly making it five-of-six. Correct.

## 4 · RULING — §B recorded, NOT diagnosed

**GATE-THEMEGLYPH's Δ42 signature did not appear once in six complete runs.** ⚠ **Six clean runs is absence of evidence and this seat will not let it be quoted as a diagnosis** — the register's own rule is that one green run does not settle that site, and six do not either.

**One new observation goes to H3 verbatim:** acceptance run 3, `01-project-menu-dark`, **20 px, max Δ1, bbox `1127,18–1307,32`** — overlapping GATE-THEMEGLYPH's registered box and extending ~146 px further left, at Δ1 rather than Δ42, on one run of six. **Not judged, not registered, not proposed for registration.** ⚠ It must not enter `screenshots/diff-exceptions.json`; DIFF-EXC-BOUND is owed first.

## 5 · RULING — §D agreed, all three left

- **The FAIL path still does not restore SORT mode** (theme now does). Window narrower, leak still real. **Its own scoping, not a third patch here.**
- **The `count()`-without-wait sweep** was not run. ⚠ **Correct: it is a CENSUS and should be one** — the same shape that made FIELD-CONTRACT work. Its own unit.
- **The 150 ms settle after the frame-03 sort click** untouched — moving it moves frame 03.

## 6 · NEXTENV-CHURN — half done, and the half that is owed is stated

`.gitignore:14` carries the rule with its reasoning as a comment. ⚠ **The untracking is NOT done and could not be here:** `git rm --cached` stages, and the standing gate is nothing-staged-before-the-phrase. **It rides the commit block as step 1a.**

**Proven rather than asserted, both halves:** `git check-ignore -v` exits 1 with no output (it consults the index, so a tracked file is not reported — *that is the demonstration that the ignore rule alone is inert*), `--no-index` reports `.gitignore:14`. **And regeneration proven by deletion:** the file removed, `npm run build` run, and it returned **byte-identical to HEAD**, with build and typecheck both clean after.
