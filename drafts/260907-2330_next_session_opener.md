# NEXT SESSION OPENER — Cowork-Arch, MAIN LINE

**Written 2026-09-07 at the close of the session that shipped EQUIP-LIST-PARITY at `c525a55` after six rounds and one deploy, discharged CDMX-SEQUENCE entire, found that the equipment list had been dropping 42 blocks in production, learned that the 0.750 every governing document called a die was a units defect, and had three defects found on paper by Daniel that no machine gate saw.**

**⚠ THE ROLLOVER IS NOT DUE. The log stands at 7 and fires at 10. Last archived 2026-09-01.**

---

## 0 · SEAT CHECK

Cowork, three mounts reachable: `Minotaur` · `Minotaur-Cowork` · `Minotaur_v1_exports`. **If not, STOP and say so.**
**Mounts do NOT persist between sessions — expect to grant all three at open.** They live at `~/Developer/Minotaur`, `~/Developer/Minotaur-Cowork`, `~/Minotaur_v1_exports`.

No parallel session is live. **CC is IDLE. Nothing is in flight.**

## 1 · READ ORDER

`Architecture_Prompt_v34.md` → `Minotaur_v2_Roadmap_v4_22.md` (WHOLE) → `Minotaur_v2_Session_Log.md` (STATE OF PLAY + the Sep 6–7 entry) → this opener → then, **on citation only**, the Ledger's **Sep 6–7 seventh append**, `drafts/260907-2210_equip-list-parity_registered-for-the-close.md` (everything registered across the six rounds) and `drafts/260907-2330_cdmx-sprint-notes_triage.md` (Daniel's seventeen sprint notes, triaged at source).

**Verify state from files, never by running git.** **⚠ Read `.git/refs/heads/main` — NOT `.git/packed-refs`, which carries `be0769de`, now TWENTY commits stale, and is also the frozen-gate baseline so it looks plausible.** HEAD should read **`c525a55`**, and `.git/refs/remotes/origin/main` the same. **Migration ledger 57** — live-read it and byte-match; last version `20260901043028`. **⚠ IT HAS NOT MOVED IN FIVE UNITS — do not assume 58.** Suite **2827 across 149**. ⚠ **`CLAUDE.md` 149,997 characters — THREE under its limit** (`wc -m`; `wc -c` reports more and **the limit is CHARACTERS**).

**⚠ PRODUCTION READY AT `c525a55` IS NOT CONFIRMED.** One deploy went out at the close and the check has not run since. **It is NOT seat-verifiable from Cowork** — the token is unreachable here — so it is Daniel's or CC's. **The command needs its `cd` or he has to reconstruct it:**
```
cd ~/Developer/Minotaur
node scripts/vercel-preopen.mjs
```
*(Last session handed him a bare `node scripts/…` with no `cd` and cost a round. The close rule says a named action without its command is one he has to reconstruct — that is what it means.)*

**⚠ THE APPROVAL PHRASE IS A PRODUCTION DEPLOY.** FENCE-PUSH is live: a bare `git push` is CC's on `COMMIT APPROVED:`, and Vercel builds every push to `main`.

**Pre-open drift check:** confirm `Minotaur-Cowork` carries this close.

## 2 · ⚠ THE FIRST ACTION IS FORCED, AND IT IS NOT A BUILD UNIT

**⚠ `CLAUDE.md` HAS THREE CHARACTERS OF HEADROOM.** 149,997 against a 150,000 limit, from 17,947 under three closes ago. The run fence is REPLACED not appended (FENCE-ONEUNIT) and **still grows per unit**; the hard-stop fired once inside EQUIP-LIST-PARITY at 150,582 and was honoured. **The next build unit cannot write its first finding into the fence**, and **three of the last unit's findings are already recorded as NOT in it** — including one load-bearing constant that survives only because a test asserts it.

⚠ **A file over the limit loses its TAIL, and the tail of this one is the Return Handoff File Protocol** — the same failure FENCE-ONEUNIT was written to fix.

**So: ROADMAP-REFACTOR, carrying CLAUDEMD-ATLIMIT as its first item** — Arch's recommendation, taken, because they are the same family and ROADMAP-REFACTOR was already queued next, so nothing is re-ordered. **NO BUILD UNIT RUNS BEFORE IT.**

The Roadmap half is unchanged from v4.21's scoping: the forward-only header is not obeyed (closed items live inline as strikethrough rows), a **superseded duplicate lives inside the Docket** (APPLY-TIMEOUT appears twice), and the single Docket lacks the Sprint Plan's three-table discipline. **Not in scope unless Daniel says so:** the 🧭 block, which RM-6 bounds at six bullets and which works.

**Then: FIELD-CONTRACT. Then DARKMODE-PASS.**

## 3 · ⚠ TWO QUESTIONS OWED TO DANIEL AT FIELD-CONTRACT — ASK THEM, DO NOT INFER THEM

Both are from his CDMX sprint notes and **he was asked and said *"I don't know — ask again when we get to this unit."*** **The artifact cannot answer either; only the gesture can.**

1. **When a category change on the last row lost focus — was the list sorted BY CATEGORY at the time?** That decides whether it is one defect with the next item or two.
2. **The category band that would not edit — does it reproduce on a NAMED category, or only on `Uncategorized`?** A sort-dependent editor and a band with no row to write to are different defects with different fixes.

⚠ **Do not derive either from the code. ASK.**

## 4 · WHAT IS ALREADY MEASURED — DO NOT RE-DERIVE

- ⚠ **AUTOCOMPLETE-NOPORTAL.** `AutocompleteInput`'s `portalDropdown` branch renders into `document.body`, flips upward when there is no room below and clamps `maxHeight`; the fallback is `absolute top-full max-h-56` with no viewport awareness. **`portalDropdown` is passed on 24 call sites across tail, line, cable, bundle, box, cable-type and inspector — and on ZERO equipment ones** (`EquipmentItemRow.tsx:745`, `:805`; `EquipmentListClient.tsx:2808`, `:2860`, `:3315`, `:3457`). That is Daniel's cut-off dropdown, and **the component's own comment says the portal exists for exactly this.**
- **`duplicate_item_v1`.** `duplicateItem` (`EquipmentListClient.tsx:1196-1231`) makes **three sequential round trips** — `SELECT *` → `INSERT … select('id')` → `SELECT *` from `v_equipment_list` — and the ⌥⇧D handler adds a fourth wait before them, **awaiting `lastCommitRef` so the copy cannot race an in-flight update; that one is load-bearing and STAYS** (it fixed a real race, recon 260717-2217). Daniel: *"not very long, but noticeable."* ⚠ **It is a MIGRATION — Trigger B, Arch's, rehearsal-first — and must not ride a UI batch.**
- **DARKMODE-PASS is ONE unit.** Every item resolves to a named token in `src/theme/hcTheme.ts`'s `buildHCEquipPalette(trimHex, 'dark')`. **Two are not colour values:** the found-count bar staying light is a **missed theme wiring**, and the orange default button is not derived from `hue` at all — **CONTRAST-PAIR already ruled its mechanism**, so building it discharges part of CONTRAST-PAIR. ⚠ **Declared baseline event — the equipment list and project menu are captured frames. CC measures which move; Arch does not predict.**
- **The tab title is `Minotaur: <Project> // <Screen>`** (Daniel, 2026-09-07, offered as *"maybe?"*). ⚠ **Arch's reading, named so it is corrected in one word: the third part is the SCREEN, not the print document's list band.** `src/app/layout.tsx:10` carries a `'%s — Minotaur'` template whose own comment says an absolute title needs `title: { absolute }`.

## 5 · OWED BY DANIEL

1. **⚠ Run the Vercel check** — §1 has the command with its `cd`.
2. **Hold a printed 5167 sheet against a real Avery blank.** Deferred 2026-08-31, still owed. **The only unrun acceptance on a shipped unit**, and five outputs are built on that die.
3. **The Tail Panel reprint**, owed since PANEL-CLIP — verified by DOM and PDF extraction only, which is not parity evidence for the printed page.
4. Rulings, none blocking: **CHANGEALL-NAALIAS** · **BOXBAND-DOCTRINE** · **BUNDLE-LINK-IMPORT** · **CATCOUNT-COLUMN** · **EQUIPLIST-DOTRULE** (dotted vs solid row separators — v2 draws **176,527 objects against v1's 690** and it is unruled either way) · **EQUIPLIST-CLMARGIN**.

Then, all pinned: a fresh **v1 Bundle Summary** print · **OQ-B** one more Box-in-Box card · three **box** print reprints · a v1 export from a show that uses **cable SPLITS** · **STRAT-record entries** retiring WF-1's push clause and for the Pro upgrade · METRIC-UNRUN's browser gate · CAND-4 · GIT-CFG's remainder · **Big Cable Labels' stock assignment**. **Also his to clear when convenient: `Minotaur-Cowork/_to_delete/260906_arch-stray-outputs/`, and the untracked `Claude outputs/` folder in the code repo.**

## 6 · ARCH'S OWN, NOT RULED YET

- **⚠ FENCE-FORMS.** Unchanged and **not exercised this unit** — the Sed Ledger read clean in every round. The ruled list of forms is still **a description being patched one spelling at a time by reading rather than testing**, and it wants a battery the way FENCE-PUSH was proved at 34 cases. Its own small unit.
- **⚠ EQUIPLIST-WHOEST.** The cover letter's `estimateWhoHeight` **models a retired layout** — over by 119 px on a six-row block — **and is blind to a wrapping row** (measured 48 px, the estimator did not move). **Safe today because it over-counts, and the obvious correction is the one that clips.** Wants the treatment `textMetrics.ts` gave the sub-note column, in its own scoped round.
- **⚠ REVGROUP-SPLIT.** Revision-mode print does not split on note. `pairRevision` matches old rows by model alone and `buildRevisionSnapshot` **writes persisted JSON**; bringing it onto the `(model, note)` key means deciding **what a new row pairs against in an OLD snapshot written model-only**. A question about historical data, not an implementation detail.
- **2-MIG-c** (SPLITOF-NO-ARM + APPLY-TIMEOUT) still owed, still Arch's.
- **PROJECT-NAME-NOT-UNIQUE's harness fix** — `scripts/visual-capture.mjs:122` finds its fixture by name, `.first()`, substring. **Never "fix" it by making the name unique.**

## 7 · DO NOT RE-DERIVE, AND DO NOT REPEAT

- **⚠ A GAP IS NOT A WRAP UNTIL THE LINE ABOVE IT IS MEASURED.** v1's 126 sub-note gaps at 12.00 were called soft wraps without the lines above them being measured; **119 of 126 end more than 60 pt short of the wrap edge.** *New standing rule; the wrong model reached the measurement of record, a governing amendment and the build.*
- **⚠ THE ACCEPTANCE INSTRUMENT FOR TYPE AND LEADING IS THE EMITTED PDF, NOT THE DOM.** A solve correct at weighted RMS 0.114 px printed two values on four of eight transitions. *An instrument that cannot see the quantum reports a solved system.*
- **⚠ A DISCLOSED DEVIATION IS NOT A HALT.** When a fence makes its own acceptance unreachable, the move is still to stop and say so — the seat that set it can widen it in one line.
- **⚠ AN INSTRUMENT MUST NOT INHERIT THE CLAIM'S PARAMETERS. A MEASUREMENT'S BOUNDARY IS A CLAIM TOO.** Both fired again this unit.
- **⚠ THE `.docx` STATES INTENT; THE PRINTED ARTIFACT STATES BEHAVIOUR.** On the cover letter they disagreed, and the boundary had been flagged in advance.
- **⚠ THE PAGE DIE DOES NOT SCALE.** `MARGIN_X`/`MARGIN_Y` 36 px is 27.00 pt against v1's 25.98 — already correct. Only type, leading and rule weights take the 4/3.
- **⚠ CONTCAT-DIVERGE AND CONTCAT-SIZE ARE BOTH RULED AND BOTH STAY.** The separate line (2026-09-05) and the full heading size (2026-09-07). **Do not "fix" either back to v1 by citing the artifact.**
- **⚠ EQUIPLIST-ROWH-BIMODAL.** v1's body row takes **two heights, 19.97 and 20.97**, and the discriminator is **measured and unexplained** — indent, digit count, description length, right edge, descenders and punctuation all tested and none separates them. 19.97 is taken.
- **⚠ `docs/reference/v1_ddr.xml` IS UTF-16LE** (`iconv -f UTF-16LE`) **and names the same field TWO ways.** ⚠ **It states NO TAB ORDER anywhere. Do not search again.**
- **⚠ EVERY CITATION OF A PROJECT NAMES AN ID.** `cf780353-448d-4b15-a054-973f577b215c` is **Mexico City**, `57874c69-06b6-41b1-91d8-6a00e5255110` is the **US Tour**. **Two productions sharing one show name is a RULED must-have feature.**
- **⚠ HASH-FREEZE-LABELS. `labels_done` STAYS.** **⚠ APPLY-TIMEOUT is measured and PINNED. Do not open it.**
- **⚠ `Cable Parity Fixture`, `Matched Pair Fixture` and BOTH Buena Vista projects are RLS-invisible to any harness CC drives.** Anything needing them on screen is Daniel's gate.
- **Do not re-litigate:** the RPC route · HASH-FREEZE-LABELS · blank-for-0 on export · the folder-label ORDER · the palette · the Avery stock assignments · **Q-1 · Q-2 · Q-3 · Q-4 · OQ-1 · OQ-2 · OQ-3 · OQ-4 · OQ-5** · the spend cap ON · CONTRAST-PAIR · MENU-DEPRECATE · the row count staying off the screen · **CONTCAT-DIVERGE** · **CATNOTE-CELL** · **CATNOTE-AUTOSIZE** · **EQUIP-LIST-FULLSIZE** · **NOTE-GROUPING**.

## 8 · NOT THIS SESSION

Everything behind ROADMAP-REFACTOR — and in particular **APPLY-TIMEOUT** · the CDMX-DEFERRED cable findings · EQUIPLIST-ESTIMATE-PAGINATOR's conversion to measured pagination *(the estimate is now measured per header shape and per wrap column, but the document still paginates by estimate)* · EQUIPLIST-WHOEST · REVGROUP-SPLIT · FENCE-FORMS · CONTRAST-PAIR · WAITLIST-NOTIFY · DEEP-ARCHIVE · GATE-THEMEGLYPH · S4-late · EXPORT-HISTID-DROP · the eight queued layouts · DEVICE-FK-LINK · **Big Cable Labels**.

## 9 · CONDUCT — what this session's record says

1. **Ask the question the record cannot answer.** The 0.750 had two readings that gave different numbers for every line on the page, and the unit's own name is not evidence. It went to Daniel and he ruled in one word.
2. **Measure the line above the gap.** Three of five Arch errors were correct measurements inside a boundary nobody measured — the second session running that this was the dominant shape.
3. **The instrument must be able to see the thing.** A DOM solve correct to 0.114 px was wrong about a page that cannot paint fractional advances.
4. **Correct a wrong claim in place, in the file that carries it.** The measurement of record was rewritten twice mid-unit, because a heading that states a wrong claim gives orders.
5. **A fence is a principle, not an enumeration.** Two of this unit's five Arch errors were scope lists that omitted something the Roadmap already had riding the unit.
6. **Daniel's gate found three defects on paper across four prints and the machine gates found none of them** — and **two of the three were wrong measurements of record rather than wrong code.** Budget for a gate round, run it BEFORE the approval phrase because the phrase deploys, and **report the result where CC can see it** — which is now built, and worked.

---

*Governing set at this close: **Arch v34** + `Architecture_Provenance.md` · **Roadmap v4.22** (retires v4.21) · Ledger v1.0 (Sep 6–7 seventh append) · `CLAUDE.md` current at `c525a55`, **THREE characters under its limit** · Session Log at **7**, rollover CLEAR. HEAD **`c525a55`**, pushed, origin identical; **production READY UNCONFIRMED — run the pre-open check**. **Migration ledger 57 — UNCHANGED for five units.** Suite **2827 / 149**. Visual gate **28/28 at 0.0000%**. In flight: nothing. **Next: ROADMAP-REFACTOR carrying CLAUDEMD-ATLIMIT — and no build unit runs before it.***
