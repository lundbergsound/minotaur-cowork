# NEXT SESSION OPENER — Cowork-Arch, MAIN LINE

**Written 2026-08-30 at the close of the session that shipped cable pass 4 (CELL-AND-ROW at `2cc6b14`) and FENCE-PUSH at `0bf6df3`, collapsed the row ladder from nine values to one, and got the project its first matched v1/v2 print pair.**
**This session opens on STOCK-IS-DIE — the columns against the Avery cut. Read §3 before anything else.**

---

## 0 · SEAT CHECK

Cowork, three mounts reachable: `Minotaur` · `Minotaur-Cowork` · `Minotaur_v1_exports`. **If not, STOP and say so.**
**Mounts do NOT persist between sessions — expect to grant all three at open.**

No parallel session is live.

## 1 · ROLLOVER — CLEAR

Session Log stands at **6 entries**; rollover fires at 10. Last archive `Session_Log_Archive_2026-08-27.md`. Nothing to run.

## 2 · READ ORDER

`Architecture_Prompt_v34.md` → `Minotaur_v2_Roadmap_v4_14.md` (WHOLE) → `Minotaur_v2_Session_Log.md` (STATE OF PLAY + the Aug-30 afternoon–evening entry) → this opener → then, **on citation only**, `handoffs/from-cc/260830-1110_cable-pass4-anatomy-diff.md` (the nine-class diff, ~2,900 lines), `260830-1420_cable-pass4-cell-and-row.md` (the build, both amendments), `260830-1734_fence-push.md`.

**Verify state from files, never by running git.** **⚠ Read `.git/refs/heads/main` — NOT `.git/packed-refs`, which carries `be0769de`, now eleven commits stale, and is also the frozen-gate baseline so it looks plausible.** HEAD should read **`0bf6df3`**. Migration ledger **55**. Suite **2553 across 137**. **CC is IDLE. Nothing is in flight.**

**Pre-open drift check:** `Minotaur-Cowork` sat at **`c8ae063`** when this close was written — the Aug-30 morning close. **This close is not in it.** Confirm whether Daniel has committed and pushed it.

**⚠ ONE THING IS DIFFERENT ABOUT THIS SESSION AND IT CHANGES WHAT A PHRASE MEANS.** **FENCE-PUSH is LIVE.** A bare `git push` is CC's on the `COMMIT APPROVED:` phrase, so **the phrase now approves a production DEPLOY** — Vercel builds every push to `main`. Force in any spelling, a `+` refspec, `--delete`/`-d` and `--mirror` stay human-only at both layers, proven live. **Do not write a close instruction telling Daniel to paste `git push`; that instruction is stale as of `0bf6df3`.**

## 3 · FIRST ACTION — STOCK-IS-DIE: PUT THE COLUMNS ON THE AVERY CUT

**Ruled long ago, never built, and it is now the last thing between these sheets and a usable roll of 5167.**

Measured on Daniel's own 2026-08-30 print, from the chip and tint rects:

| column | rendered origin | 5167 cut left | Δ |
|---|---|---|---|
| 1 | 20.25 | 20.25 | **0.00** |
| 2 | 165.00 | 168.75 | **−3.75** |
| 3 | 310.50 | 317.25 | **−6.75** |
| 4 | ~455.6 *(projected — that corpus fills three columns)* | 465.75 | **~−10.15** |

The rendered pitch is **v1's 145.13 die**, which pass 3 matched deliberately and pass 4 did not touch. The Avery pitch is **148.50**. The error compounds left to right, so a label's ink lands progressively further onto the liner between stickers.

**The ruling is already made and is not re-litigated: parity is v1, the die constrains it in exactly one way — a label must land inside its cut — and where they collide the die wins.** This is the only place v1 is not the target.

**What the unit owes.**

1. **The die per output, measured against the artifact rather than assumed** — 5167 is label 126.00 × 36.00, left 20.25, top 36.00, pitch 148.50 × 36.00, 4 × 20; 5160 is 3 × 10, pitch 198.00 × 72.00, left 13.50, top 36.00. **Tail Panel is full sheet, crew-cut — no die, and its columns are NOT in scope.**
2. **A decision, taken explicitly rather than by default: does the CELL move onto the die, or the whole GRID?** v1's 131.04 pt chip already overhangs its 126.00 pt label by 5.04 and Daniel has ruled that overhang FINE. Moving columns onto a 148.50 pitch changes where every chip, tint and run sits. **Say which quantity is being pinned before moving anything.**
3. **Everything pass 4 built must survive it.** The ladder statistic stays one value per chip class per sheet; the justification axes stay two, end-selected; the tint, the step-downs, the markers and the rules all stay. **Re-run the pass-4 acceptance in full — geometry AND the content count under the stated rules, nothing down.**
4. **The bound: Cable Folder Labels is at parity and must not move.** Its column centres match v1 to 0.02 pt on the 5160 die.

**And name the honest limit.** Every number above is a PDF measurement. **Whether a label actually lands inside its cut is a sheet held to the light against a real Avery blank, and only Daniel can do that.** It is owed and has not been done.

## 4 · THEN

**EQUIP-LABELS-2** — Trigger B, and it blocks Equipment Labels: a v1 `Labels = 2` coerces to *false* and **72% of items vanish from that output**, with the round trip wiping the field on the way back to v1. Then **BOX-DOC-PARITY** · **2-MIG-c** *without* the split arm (APPLY-TIMEOUT · GRANT-TRUNCATE · HARNESS-READ, Trigger B, rehearsal-first) · **the four measured-but-unbuilt cable outputs**, including the Cable Checklist's **29.72 pt** bottom margin that turns 54 v1 pages into 38 · **Small Cable Labels**, which Arch recommends moving UP: it is a 5167 sheet still deriving its columns from the page width, `CableLabelsPrintClient.tsx` does not reference the geometry module at all, and `tailCellGeometry.ts` now exists to make the pass cheap · **the small clearing unit** (GATE-METHODRACE · PRINT-HINT-EQUIP · MENU-DEPRECATE · gap 14's title underline y · FENCE-HEREDOC) · **CABLE-SPLIT's Trigger A block** once a fourth corpus exists · EXPORT-HISTID-DROP re-measured · the staged box residuals · then the eight queued layouts.

## 5 · OWED BY DANIEL

**Commit + push `Minotaur-Cowork`** — it carries the Aug-30 morning close and not this one · **hold a printed 5167 sheet against a real Avery blank**, the one acceptance no measurement supplies · **a STRAT-record entry retiring WF-1's push clause**, one line: *WF-1's push clause is retired by FENCE-PUSH (Daniel, 2026-08-30); the stage and commit clauses were already retired by WF-1a on Aug 9* · **export a v1 show that actually uses cable SPLITS** · **a fresh v1 Bundle Summary print** — its July-11 sheet shows `Bundled: 1` on 71 of 71 where the workbook carries 1 · **the fresh-import fixture**, which three separate items wait on · delete BVSC NY's two junk boxes · **BUNDLE-LINK-IMPORT** · **WAITLIST-NOTIFY** (Trigger A) · three **box** print reprints · **METRIC-UNRUN's browser gate** · CAND-4 · GIT-CFG · **PROJ-CLEAN-2 — `Visual Gate Fixture` AND `Import Test 5` must NOT be swept** · **a STRAT-record entry for the Pro upgrade** · **the `fence-push_CLOSE.txt` CC never wrote** — the only WF-1a commit today without one.

## 6 · DO NOT RE-DERIVE, AND DO NOT REPEAT

- **⚠ `docs/reference/v1_ddr.xml` IS THE SOURCE THAT MADE THE INK, AND IT IS UTF-16LE.** A byte-oriented grep finds **nothing** in it; read via `iconv -f UTF-16LE`. Two behaviours that defeated every artifact correlation were quoted from it in one pass. **Before fitting a threshold to a corpus, look for the rule in there.**
- **⚠ JUSTIFY-PERCELL DOES NOT ALTERNATE.** The `@` line sits on one of **two axes selected by the tail END** — Female 67.48, Male 65.98 — 238 of 238 cells, zero exceptions. The older "alternating −2.52 / −1.02 per cell" wording is **wrong** and is corrected in the Roadmap and Session Log.
- **⚠ ROW-LADDER's old quoted baselines were EM-TOPS.** v1's Small Tail Block cell: em-tops 74.68 / 76.34 / 81.68 / 89.66 / 97.66; baselines 79.43 / 86.43 / 86.43 / 96.00 / 104.00.
- **⚠ SKIP-LABELS EXISTS IN v2**, on four surfaces, inserting exactly-36.00 pt blanks. The old "v2 has nothing like it" is false.
- **⚠ The ladder value is `+0.75`, not v1's `+1.00` / `+0.43`, and that is CORRECT.** Chrome snaps a background rect to its 0.75 pt paint grid, and the 0.57 pt separating v1's two chip classes is not expressible there. **Do not "fix" it.**
- **⚠ PAGEBREAK-MODEL is a DELIBERATE DIVERGENCE by ruling.** v1 breaks a model section to a COLUMN on the Avery sheets; Daniel ruled a PAGE break. **Do not "fix" it back by citing the artifact** — the source comment says so.
- **⚠ The line cell's end word is BLACK on every cable colour and that is v1.** Its object carries no conditional format. Only runs whose object HAS the six-colour condition take white. **A geometric rule is wrong here** and was refuted at source.
- **⚠ The yellow bands are the ordinary line-colour tint**, not a missing-description highlight. Arch inferred the latter from a correlation on one page and was wrong.
- **⚠ NO NEW FIXED-HEIGHT CONTENT BOX, and no estimate paginator.** v1's cell overlaps the next row; it does not clip. `paginateByHeight` was deleted for this and pass 3 reintroduced the class at a cost of 62 labels.
- **⚠ PDF-CHROME-PATH.** A parity print is valid evidence **only** from Chrome's own Save-as-PDF destination.
- **⚠ CHECKLIST-GROUPCOUNT is CLOSED and there was never a defect** — 27 sections on all three sources.
- **⚠ `Import Test 5` AND `Test Cable` are RLS-invisible to any harness CC drives.** Counts come from a labelled reproduction on a throwaway, or from Daniel.
- **⚠ Capture-flake entry (2) is NOT dark-only.** Three sightings; the invariant is **1451200 px at bbox 0,93–1599,999**. **Settle the next one with an import graph, two runs maximum.** It stays PROSE and never enters `diff-exceptions.json`.
- **Do not re-litigate:** the folder-label ORDER — **down then across, no-box first** · the palette — **v2 colours everywhere** · colour overlapping the label margin — **fine** · the Avery stock assignments · **Q-1 · Q-2 · Q-3 · Q-11** · Q-4's eight outputs · the spend cap ON · CONTRAST-PAIR · MENU-DEPRECATE.

## 7 · NOT THIS SESSION

CONTRAST-PAIR · WAITLIST-NOTIFY · DEEP-ARCHIVE · GATE-THEMEGLYPH's diagnosis · the `0` vocabulary-row fold · S4-late · EXPORT-HISTID-DROP · the eight layouts' BUILD · DEVICE-FK-LINK (post-public-beta) · FENCE-HEREDOC (needs its own scoping, not five minutes at the end of another unit).

## 8 · CONDUCT — what this session's record says

1. **Go to the source that made the ink.** Two triggers that defeated every artifact correlation were quoted from v1's layout definitions in one pass. A threshold fitted to one corpus reproduces that corpus by construction.
2. **An import graph beats a re-run.** It answers whether the frame could ever have seen the change, and gives the same answer either way. Two runs is the limit.
3. **Measure first, then fix.** Three passes fixed only what someone had noticed; the pass that measured the whole anatomy found three gaps nobody had named that all outrank the two that had.
4. **Report the number you got, not the number the acceptance asked for.** `+0.75` against a stated `+1.00`, with the paint grid named as the floor, was worth more than a matching claim.
5. **A rule checked at an event holds; a rule checked against a duration does not.** The return-protocol trigger is *returning control*, not thirty seconds.
6. **Stopping is a result.** CC refused to edit the file governing its own permissions, built and proved the candidates instead, and argued against the larger grant it was offered.
7. **Bouncing Arch is the job.** The geometric colour rule was refuted at source and on the artifact; the request to flip the contract early would have created a stale document inside the unit warning about stale documents.
8. **Daniel's printout found what the gates did not — again.** A field printing black on a black chip is invisible to every automated check and obvious on paper.

---

*Governing set at this close: **Arch v34** + `Architecture_Provenance.md` · **Roadmap v4.14** (retires v4.13) · Ledger v1.0 (Aug-30 evening append) · `CLAUDE.md` current at `0bf6df3` · Session Log at **6, rollover clear**. HEAD **`0bf6df3`**, pushed. Migration ledger **55**. Suite **2553 / 137**. Visual gate **28/28 at 0.0000%, all byte-clean**. Evidence: `parity-pairs/260830_cable-pass4-matched-pair/` and `parity-pairs/260830_cable-pass4-proof/`. In flight: nothing.*
