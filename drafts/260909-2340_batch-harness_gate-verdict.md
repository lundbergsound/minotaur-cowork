# BATCH-HARNESS's gate — two runs, two DIFFERENT registered flakes, and the graph settles it

*Cowork-Arch, 2026-09-09. Daniel ran the gate twice on a quiet machine (loads 2.50 and 3.56, both legally under the 5.00 ceiling, no override). **Both runs returned 27/28. Neither failure reproduced.***

## 1 · The two failures are not the same failure

| Run | Load | Failing frame | Judged | Measured @ch0 | bbox |
|---|---:|---|---:|---:|---|
| 1 · `23-34-10` | 2.50 | `05-gcm-light` | 105,388 px (6.5867%) | **252,007 px, max Δ248** | `0,48–1599,351` |
| 2 · `23-37-30` | 3.56 | `06-settings-light` | 28,675 px (1.7922%) | **1,451,200 px, max Δ248** | `0,93–1599,999` |

⚠ **BOTH MATCH A REGISTERED ENTRY TO THE DIGIT, AND THEY ARE DIFFERENT ENTRIES.**

- **Run 1 is flake (7)** — the GCM paint race **CC registered in this very unit**, from its own sighting: `252007 px @ch0, max Δ248, bbox 0,48–1599,351`. Identical.
- **Run 2 is flake (2)**, the whole-frame theme race, whose **recorded invariant is `1451200 px at bbox 0,93–1599,999`** — the figure the Roadmap's CAPFLAKE-LIBLIGHT row cites when ruling that a different signature was NOT the theme race. Identical.

**Both light-only. Both max Δ248. Neither recurred on the other run.** *A flake that reproduces is not a flake — but these did not reproduce; two different known intermittents fired once each.*

## 2 · ⚠ THE GRAPH IS DECISIVE, AND IT IS STRONGER HERE THAN IT HAS EVER BEEN

**This unit changed NO application code.** CC's `git diff HEAD --stat` says so, and **Arch verified it independently at source rather than accepting the claim**: `find src/ -newermt "2026-09-09 15:36"` returns **nothing**. The only files touched since leg 3a's commit are `scripts/visual-capture.mjs`, three new files under `scripts/lib/`, `docs/reference/visual-capture-harness.md`, and two build artefacts.

**So no captured frame CAN have moved for a code reason.** Every route in the gate is byte-identical to the tree that produced the baselines.

⚠ **The two-run cap is reached and a third run must NOT be asked for.** GRAPH-BEATS-RERUN: *a re-run says whether a failure recurs; an import graph says whether the frame could ever have seen the change, and gives the same answer either way.* The precedent is FIND-PARITY, which shipped on exactly this reasoning — **and its graph argument was WEAKER than this one**: four changed modules to reason about, against zero here.

**Arch's verdict: the gate's verdict is uninformative about this unit, and the graph has already answered the question the gate was asked.**

## 3 · ⚠ THE FINDING THAT MATTERS MORE THAN THE VERDICT

**The unit built to stop the gate taxing every unit has been blocked from committing by the gate's own unreliability — by the two races it deliberately declined to fix.**

Run 1 is §C's GCM route, which has no bounded wait. **Run 2 is the theme race — and §B is an un-awaited, never-restored theme write.** CC left both, and its reasoning was sound *at the time it was written*: awaiting the `profiles` PATCH changes settle timing at the exact site of GATE-THEMEGLYPH, undiagnosed three times, and §6 forbade moving a frame.

⚠ **Two gate runs on a quiet machine have now re-weighted that.** The cost of leaving them is no longer "occasional noise" — it is **a gate that could not close twice in four minutes at loads of 2.50 and 3.56.** That is not a loaded-machine problem any more.

**Recommendation: the theme write and the GCM wait stop being H3's and become the next harness unit's, ahead of FENCE-FORMS.** They are the difference between a gate that gives an answer and a gate that gives a coin-flip.

## 4 · What Daniel is being asked to rule

**Commit BATCH-HARNESS on the graph, with the gate at 27/28 twice.**

- **For:** zero app modules changed, verified at source · both signatures match registered entries exactly · different frames, neither reproducing · the two-run cap forbids a third · direct precedent in FIND-PARITY on weaker evidence.
- **Against, stated honestly:** *no run of this tree has ever come back 28/28.* The claim being accepted is "no frame moved," and it rests on the graph rather than on a green run. **If he would rather have a green run, the answer is not a third attempt — it is fixing §B and §C first, then gating.**

**Arch recommends committing.** The alternative spends the next unit's slot re-litigating a question the graph has answered.
