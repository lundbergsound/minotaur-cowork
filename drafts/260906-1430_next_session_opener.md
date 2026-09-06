# NEXT SESSION OPENER — Cowork-Arch, MAIN LINE

**Written 2026-09-06 at the close of the session that shipped CAT-NOTE's print half at `267d477` and CAT-NOTE-RULE at `f4192cd`, found the estimate paginator still live on the equipment list and proved it loses rows, refuted CATNOTE-RULE with an instrument that could not see it and had that reversed by Daniel on paper, and learned that two productions of one musical sharing a show name is a feature rather than a defect.**

**⚠ THE ROLLOVER IS NOT DUE. The log stands at 6 and fires at 10. Last archived 2026-09-01.**

---

## 0 · SEAT CHECK

Cowork, three mounts reachable: `Minotaur` · `Minotaur-Cowork` · `Minotaur_v1_exports`. **If not, STOP and say so.**
**Mounts do NOT persist between sessions — expect to grant all three at open.** They live at `~/Developer/Minotaur`, `~/Developer/Minotaur-Cowork`, `~/Minotaur_v1_exports`.

No parallel session is live. **CC is IDLE. Nothing is in flight.**

## 1 · READ ORDER

`Architecture_Prompt_v34.md` → `Minotaur_v2_Roadmap_v4_21.md` (WHOLE) → `Minotaur_v2_Session_Log.md` (STATE OF PLAY + the Sep-6 afternoon entry) → this opener → then, **on citation only**, the Ledger's **Sep-6 sixth append** and `drafts/260906_catnote-print_v1_measurement.md` (the v1 measurement of record — **read §2, it is a correction**).

**Verify state from files, never by running git.** **⚠ Read `.git/refs/heads/main` — NOT `.git/packed-refs`, which carries `be0769de`, now NINETEEN commits stale, and is also the frozen-gate baseline so it looks plausible.** HEAD should read **`f4192cd`**. **Migration ledger 57** — live-read it and byte-match; last version `20260901043028`. **⚠ IT HAS NOT MOVED IN FOUR UNITS — do not assume 58.** Suite **2768 across 147**. `CLAUDE.md` **132,053 characters** (`wc -m`; `wc -c` reports 133,430 bytes and **the limit is CHARACTERS**).

**⚠ PRODUCTION READY AT `f4192cd` IS NOT CONFIRMED.** Two deploys went out this session and the Vercel check was not run after the second. **It is NOT seat-verifiable from Cowork** — the token is unreachable here — so it is Daniel's or CC's: `node scripts/vercel-preopen.mjs`. **Say so rather than asserting a deploy state, and get it run before build work.**

**⚠ THE APPROVAL PHRASE IS A PRODUCTION DEPLOY.** FENCE-PUSH is live: a bare `git push` is CC's on `COMMIT APPROVED:`, and Vercel builds every push to `main`.

**Pre-open drift check:** confirm `Minotaur-Cowork` carries this close.

## 2 · THE SEQUENCE HAS ONE ITEM LEFT

**⚠ CDMX-SEQUENCE (Daniel, 2026-09-05):** *"we're doing things pertaining to the category note management, category note printing, and print parity. nothing else before those are finished."*

Items 1 and 2 closed at `1a54c3b`; item 3 closed at `267d477`/`f4192cd`. **What remains: EQUIP-LIST-PARITY.** Then, queued by Daniel: **ROADMAP-REFACTOR**.

**⚠ NOTHING ELSE. Not APPLY-TIMEOUT, not FIELD-CONTRACT, not a housekeeping batch, however live or docketed.** *A driver ruling outranks a docket item's urgency.*

## 3 · FIRST ACTION — EQUIP-LIST-PARITY

**⚠ THE TYPE RATIO IS MEASURED AT EXACTLY 0.750 ON EVERY ELEMENT CLASS. DO NOT RE-DERIVE IT.** Item 12.00→9.00 · sub-note italic 10.00→7.50 · category heading 12.00→9.00 · show name / title / list band 14.00→10.50 · footer 10.00→7.50. **The page die is already right** (v1 x 25.98→584.96, v2 x 27.00→584.99).

**⚠ THE OPEN WORK IS THE LEADING.** Body row pitch reads v1 ≈ 19.97 against v2 ≈ 17.25, ≈ **0.86** — **PROVISIONAL, four samples on one page**, re-measured across both documents before it becomes a constant. **One die with TWO derived numbers, not one scale.**

**⚠ THIS UNIT NOW OWNS THREE NAMED THINGS, NOT ONE. It is one pass, not three.**

1. **The type-and-leading rescale**, above.
2. **The heading rule's weight — v1 2.00 pt against v2's 1 px.** Measured this session: v1 draws a 2.00 pt paperwork-colour rule at `x 26.98 → 585.98` under **47 of 47** category headings. v2 draws `borderTop: 1px solid ruleColor`. ⚠ **Do NOT touch the 1.00 pt NOTE rule at `x 26.27 → 584.27` — that one is correct and shipped at `f4192cd`.** Two rules, two weights, two x ranges; they are different objects.
3. **QTY-ITALIC, and its mechanism is now known.** v1 sets the **quantity italic and the description roman ON THE SAME LINE** — `[CenturyGothic-Italic] '2' || [CenturyGothic] 'Earthworks M23 …'` — two fields, two styles. v2 sets both roman. **The Docket's old "some quantities… mechanism unknown" was a sampling artifact of reading each line's first character; do not re-derive it.**

**Riding with them: CATNOTE-FONT-DUP.** `printEngine.ts`'s `CAT_NOTE_FONT_PX = 12` is a second copy of the body item line's inline `fontSize: 12`; the item line reads no constant. **This unit is where they become one.** The `CAT_NOTE_*` comment block names the second location.

**⚠ CONTCAT-DIVERGE is a RULED exception and STAYS** at 0.900. **Do not "fix" it back by citing the artifact.**

**⚠ THE COVER LETTER MAY WANT ITS OWN SCALE.** v1's is **a Word document appended by hand**, not FileMaker output. **The `.docx` is a better arbiter than any print.** RULED (Daniel, 2026-09-05): v2's cover-letter design is good; this is a scale job only.

**⚠ EQUIPVIEW-UNSAFE must not be discovered mid-build:** `v_equipment_list` does not filter `type` and exposes `ip_address` while hiding `address`, populated on **261** rows against `ip_address`'s **1**, and v1's equipment output prints Address.

**The matched pair, both landed:** v1 `equipment/260905-1159_v1_equipment-list_BVSC-Tour_FILEMAKER.pdf` (31 pages) · v2 `parity-pairs/260905_equipment-list-pair/260905-2202_v2_equipment-list_BVSC-Tour_CHROME.pdf` (24 pages).

## 4 · ⚠ THE THREE PROBE HAZARDS ON THIS DOCUMENT — READ BEFORE WRITING ANY ACCEPTANCE

**This is the most expensive thing this session learned and it binds every measurement the next unit takes.**

- **EQUIPLIST-ESTIMATE-PAGINATOR.** The equipment list **still paginates by constant estimates** — the paginator PRINT-CLIP and BOX-PRINT-CLIP retired from the four cable and box documents, whose helper they **deleted** — into a fixed `height: PAGE_H` container whose body is `flex: 1, overflow: hidden`. **A negative control lost SIX of 120 rows off page 2 with no error, no warning and no gap in the numbering.** **Any change to type size or leading changes every height on this page.** Converting the document to measured pagination is its own unit with its own printed proof — **do not attempt it inside EQUIP-LIST-PARITY**, but budget for the fact that this unit moves every constant the estimate depends on.
- **PRINTPROBE-MEDIA.** On screen `.print-page` carries an inline `height: 1056` and flex items refuse to shrink below their content, so an over-budget page **GROWS instead of clipping**; the scissoring `overflow: hidden` is in the `@media print` block. **The screen-only probe that proved the cable and box documents reports zero blocks lost here while rows are being lost.** Every clip probe on this document runs under `emulateMedia({media:'print'})` at a true **816×1056** viewport.
- **RECT-VS-FLOW.** `getBoundingClientRect().height` excludes the last child's collapsed bottom margin. CAT-NOTE-RULE's growth measures **+3.25 by rect against +3.99 by flow**. **A probe comparing block rects to `CONTENT_H` under-counts every block on this document.** Measure flow cost — top of one block to top of the next — and print both.
- **PAGINATE-SLACK, for context not action:** `CONTENT_H` is 880 against a measured container of **910** by-category and **890** with a method band. Conservative, so slack rather than defect — but the estimate and the box disagree, and this unit is the one that will be tempted to tune them.

## 5 · OWED BY DANIEL

1. **⚠ Run `node scripts/vercel-preopen.mjs`** — two production deploys went out and the check has not run since. Not seat-verifiable from Cowork.
2. **Hold a printed 5167 sheet against a real Avery blank.** Deferred 2026-08-31, still owed. **It is the only unrun acceptance on a SHIPPED unit**, and five outputs are built onto that die.
3. **The Tail Panel reprint**, owed since PANEL-CLIP — that unit was verified by DOM and PDF-extraction only, which is not parity evidence for the printed page, and `702048b` is live.
4. **A ruling on CHANGEALL-NAALIAS** — a typed `0` in Method creates a method literally named `0`.
5. **A ruling on BOXBAND-DOCTRINE** — should the sort-band editor's Box arm offer to create, or does its silent no-op-revert stand?
6. **A ruling on BUNDLE-LINK-IMPORT** — do v1's bundle-field link groups come into v2, or never?
7. **CATCOUNT-COLUMN** — should the Categories tab show an item count? ⚠ If it ever is, the count is unfiltered by `type`, so `13.0 Cable` reads spine rows, not equipment.

*(None of 2–7 blocks §3.)* Then, all pinned: a fresh **v1 Bundle Summary** print (BUNDLESUM-MARKS) · **OQ-B** one more Box-in-Box card · **OQ-3's optional confirmation** · three **box** print reprints · a v1 export from a show that uses **cable SPLITS** · a **STRAT-record entry retiring WF-1's push clause** and **one for the Pro upgrade** · METRIC-UNRUN's browser gate · CAND-4 · GIT-CFG's remainder · **Big Cable Labels' stock assignment**. **Also his to clear when convenient: `Minotaur-Cowork/_to_delete/260906_arch-stray-outputs/`, and the untracked `Claude outputs/` folder in the code repo (ARCH-OUTPUTS-MIRROR — Arch's, not CC's).**

**Discharged 2026-09-06 afternoon: the browser gate on BOTH units · the duplicate-show-name ruling · QTY-ITALIC's observation, which is what found the mechanism.**

## 6 · ARCH'S OWN, AND NOT RULED YET

- **⚠ FENCE-FORMS.** Three sightings in four days across two binaries — `perl -0pi` and a `python3` heredoc — both single-file stream edits the fence did not match, both self-reported, both cleanly reverted with the frozen gate run on the spot. **The disclosure discipline is working; the guard is not.** The ruled list of forms is a **description being patched one spelling at a time by reading rather than testing.** It wants a **battery** the way FENCE-PUSH was proved at 34 cases. **Its own small unit, after EQUIP-LIST-PARITY.**
- **⚠ GATE-REPORTING.** Daniel's gate runs in his browser and is reported to Arch; the phrase is typed at CC. **Both of this session's units recorded the gate as never run when it had run and passed.** The rule needs a **reporting channel**, not more emphasis. **Put the gate result into the commit block as a line CC asks for and records.**
- **⚠ AMEND-ROUND-TENSION.** Still unruled. *"One declaration per unit"* and *"never restore baselines"* pull against each other the moment a unit takes an amend round that re-baselines. **Rule it before the next unit that takes one.** Neither unit this session took one.
- **2-MIG-c** (SPLITOF-NO-ARM + APPLY-TIMEOUT) is still owed and still Arch's, sequenced behind the CDMX work.
- **PROJECT-NAME-NOT-UNIQUE's harness fix** — `scripts/visual-capture.mjs:122` finds its fixture by name, `.first()`, substring match. Rides BATCH-HARNESS. **Never "fix" it by making the name unique.**

## 7 · DO NOT RE-DERIVE, AND DO NOT REPEAT

- **⚠ AN INSTRUMENT MUST NOT INHERIT THE CLAIM'S PARAMETERS.** CATNOTE-RULE was refuted by a probe that filtered `linewidth >= 2.0` **because the lead said 2 pt** — and the rule renders at 1.00 pt. The refutation reached a handoff, a governing draft, a commit message and **production**. **Census the class, then narrow.** *New standing rule; §2 of the drafts measurement is its origin of record.*
- **⚠ A MEASUREMENT'S BOUNDARY IS A CLAIM TOO.** Three of last session's four Arch errors were correct measurements inside an unmeasured boundary — the rule's weight, the project's identity, the name's uniqueness. *New standing rule.*
- **⚠ EVERY CITATION OF A PROJECT NAMES AN ID.** `cf780353-448d-4b15-a054-973f577b215c` is **Mexico City, the BVSC-MX driver**; `57874c69-06b6-41b1-91d8-6a00e5255110` is **`Buena Vista Social Club US Tour`**. **Two productions sharing one show name is a RULED must-have feature — never "fixed" by a uniqueness constraint.**
- **⚠ BVSC-8POWER-DRIFT IS ON THE US TOUR, NOT MEXICO CITY.** Mexico City is byte-clean on all six notes. **A round-trip comparison on Mexico City has no drift to excuse.**
- **⚠ CATNOTE-TYPE's TYPE SPEC IS MEASURED and the block is heading → 2 pt rule → note → 1 pt rule → item.** The note is **2.00 pt indented, not flush**. **Soft wrap 15.00, hard break 30.00 — two numbers, not one**; `white-space: pre-line` is wrong on every multi-paragraph note.
- **⚠ THE NOTE REPEATS AT EVERY OCCURRENCE OF ITS CATEGORY** (six stored → fourteen printed) and **never on a continued header**, which is unrepresentable rather than remembered.
- **⚠ VERIFY A WRITE LANDED, DO NOT TRUST THE REPORT.** A commit of the drafts measurement returned success and had not landed; caught only by reading the file back. **Read back what you install.**
- **⚠ `docs/reference/v1_ddr.xml` IS UTF-16LE** (`iconv -f UTF-16LE`) **and names the same field TWO ways.** Prove a search finds a known-present instance before concluding absence. **⚠ It states NO TAB ORDER anywhere. Do not search again.**
- **⚠ AN EXTRACT WHOSE BOUNDARIES WERE NOT MEASURED IS NOT AN EXTRACT.**
- **⚠ TIGHTEN THE ASSERTION; NEVER LOOSEN IT TO ADMIT YOUR OWN NEW CODE.**
- **⚠ FENCE-ONEUNIT. The run fence carries ONE unit, not a history.** Every handoff that touches it says **REPLACE THE BODY, DO NOT APPEND.**
- **⚠ A PROBE THAT MEASURES THE WRONG TRANSITION REPORTS A WORKING FIX AS BROKEN.**
- **⚠ "BVSC NY" IN ANY OLDER DOCUMENT MEANS `Cable Parity Fixture`.** The v1 export folders on disk are intact and are the parity arbiters.
- **⚠ APPLY-TIMEOUT's settings are measured and it is PINNED. Do not open it.**
- **⚠ `Cable Parity Fixture`, `Matched Pair Fixture` and BOTH Buena Vista projects are RLS-invisible to any harness CC drives** (HARNESS-RLS-CORPUS). **Anything needing them on screen is Daniel's gate, not CC's.**
- **⚠ HASH-FREEZE-LABELS. `labels_done` STAYS.**
- **Do not re-litigate:** the RPC route · the separate-units ruling · HASH-FREEZE-LABELS · blank-for-0 on export · the folder-label ORDER · the palette · the Avery stock assignments · **Q-1 · Q-2 · Q-3 · Q-4 · OQ-1 · OQ-2 · OQ-3 · OQ-4 · OQ-5** · the spend cap ON · CONTRAST-PAIR · MENU-DEPRECATE · BUNDLE-LINK-IMPORT's shape · the row count staying off the screen · **CONTCAT-DIVERGE** · **CDMX-SEQUENCE** · **CATNOTE-CELL** · **CATNOTE-AUTOSIZE**.

## 8 · NOT THIS SESSION

**Everything pinned behind EQUIP-LIST-PARITY**, and in particular **APPLY-TIMEOUT** and **FIELD-CONTRACT** · ROADMAP-REFACTOR (immediately after, not during) · FENCE-FORMS · EQUIPLIST-ESTIMATE-PAGINATOR's conversion · CONTRAST-PAIR · WAITLIST-NOTIFY · DEEP-ARCHIVE · GATE-THEMEGLYPH's diagnosis · S4-late · EXPORT-HISTID-DROP · the eight queued layouts · DEVICE-FK-LINK · **Big Cable Labels**.

## 9 · CONDUCT — what the last session's record says

1. **When testing a claim, do not build the test out of the claim's own numbers.** A probe keyed to "2 pt" could not see the 1 pt object it existed to find, and reported absence as refutation — into production.
2. **A correct standing rule can license a wrong conclusion.** DDR-IS-THE-SOURCE was invoked to justify the refutation, and the artifact had actually agreed with the source on everything except the one parameter the probe keyed on.
3. **Measure the boundary, not just the thing.** Three Arch errors were correct measurements inside an assumption nobody measured — a weight, a project's identity, a name's uniqueness.
4. **Do not write an inference in the tense of a measurement.** Calling a live production "an incomplete import" from a row count and a timestamp cost Daniel a correction and nearly cost him a mislabelled show.
5. **Read back what you install.** A commit reported success and had not landed.
6. **Daniel's gate has now found what the machine gates could not TEN times running** — this time on paper, on a rule four green gate runs and a full suite could not miss the absence of, because nothing was testing for it. **Budget for a gate round, run it BEFORE the approval phrase because the phrase deploys, and REPORT THE RESULT WHERE CC CAN SEE IT.**

---

*Governing set at this close: **Arch v34** + `Architecture_Provenance.md` · **Roadmap v4.21** (retires v4.20) · Ledger v1.0 (Sep-6 sixth append) · `CLAUDE.md` current at `f4192cd`, **17,947 characters under its limit** · Session Log at **6**, rollover CLEAR. HEAD **`f4192cd`**, pushed; **production READY UNCONFIRMED — run the pre-open check.** **Migration ledger 57 — UNCHANGED for four units.** Suite **2768 / 147**. Visual gate **28/28 at 0.0000%**, no baseline event on either unit. In flight: nothing. **Next: EQUIP-LIST-PARITY — the last item in CDMX-SEQUENCE — then ROADMAP-REFACTOR.***
