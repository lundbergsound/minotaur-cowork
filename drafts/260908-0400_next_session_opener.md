# NEXT SESSION OPENER — Cowork-Arch, MAIN LINE

**Written 2026-09-08 at the close of the session that shipped ROADMAP-REFACTOR carrying CLAUDEMD-ATLIMIT, took `CLAUDE.md` from THREE characters of headroom to 44,996, found that the run fence could not simply be deleted because eighteen of twenty standing rules lived only there, gave the Docket three tables, and deleted a second superseded duplicate the scoping did not know about.**

**⚠ THE ROLLOVER IS NOT DUE. The log stands at 8 and fires at 10. Last archived 2026-09-01.**

---

## 0 · SEAT CHECK

Cowork, three mounts reachable: `Minotaur` · `Minotaur-Cowork` · `Minotaur_v1_exports`. **If not, STOP and say so.**
**Mounts do NOT persist between sessions — expect to grant all three at open.** They live at `~/Developer/Minotaur`, `~/Developer/Minotaur-Cowork`, `~/Minotaur_v1_exports`.

No parallel session is live. **CC is IDLE. Nothing is in flight.**

## 1 · READ ORDER

`Architecture_Prompt_v34.md` → `Minotaur_v2_Roadmap_v4_23.md` (WHOLE) → `Minotaur_v2_Session_Log.md` (STATE OF PLAY + the Sep 8 entry) → this opener → then, **on citation only**, the Ledger's **Sep 8 EIGHTH append** and `drafts/260907-2330_cdmx-sprint-notes_triage.md` (Daniel's seventeen sprint notes, triaged at source — **FIELD-CONTRACT's acceptance criteria live there**).

⚠ **THE ROADMAP HAS A NEW SHAPE AND ROWS HAVE MOVED.** The Docket is now **▶ ACTIVE · ⏸ HELD · 📐 STANDING** plus a retirement index (RM-8). **129 live rows were sorted VERBATIM — nothing was rewritten — and 26 closed rows left the file for the Ledger.** If you remember a row and cannot find it, it is in another table or in the index, not gone.

⚠ **AND `CLAUDE.md` HAS A NEW SECTION.** `Standing rules — earned by units, owned by none` now holds what the run fence used to carry: FENCE-HEADLINE · FENCE-ONEUNIT · FENCE-COUNTS · TESTCOUNT · TENSE-IS-A-CLAIM · GATE-NOGREP · GATE-DEVCHECK · GATE-LOAD-AUDIO · GATE-THEMEGLYPH · GRAPH-BEATS-RERUN · AMEND-DECLARES-PER-ROUND · GATE-REPORTING · PDF-CHROME-PATH · PRINTPROBE-MEDIA · RECT-VS-FLOW · both print quanta · A GAP IS NOT A WRAP · DDR-IS-THE-SOURCE — plus an **Open, carried across units** block (AC-HANDLED · BOXBAND-DOCTRINE · 2-MIG-c · `BUNDLE_LINK_VOCABULARY` · EQUIPLIST-QTYCOL · EQUIPLIST-WHOEST · HARNESS-RLS-CORPUS · what Daniel owes). **The Visual-Capture Harness is no longer in `CLAUDE.md`** — it is `docs/reference/visual-capture-harness.md`, verbatim, and it must be OPENED before any gate run or baseline declaration.

**Verify state from files, never by running git.** **⚠ Read `.git/refs/heads/main` — NOT `.git/packed-refs`, which carries `be0769de`, twenty commits stale, and is also the frozen-gate baseline so it looks plausible.** **Migration ledger 57** — live-read it and byte-match; last version `20260901043028`. **⚠ IT HAS NOT MOVED IN FIVE UNITS — do not assume 58.** Suite **2827 across 149**.

⚠ **THE HEAD YOU EXPECT DEPENDS ON WHETHER DANIEL RAN THE CODE-REPO BLOCK.** If he did, HEAD is a NEW commit whose subject begins `docs: CLAUDEMD-ATLIMIT discharged`, and **that push was a production deploy — run the pre-open check.** If he did not, HEAD is still `c525a55` and **`CLAUDE.md` plus `docs/reference/visual-capture-harness.md` are sitting UNCOMMITTED in the working tree** — say so plainly and do not start a unit on top of them.

```
cd ~/Developer/Minotaur
node scripts/vercel-preopen.mjs
```
*(Not seat-verifiable from Cowork — the token is unreachable here. It is Daniel's or CC's. The command carries its `cd` because a named action without its command is one he has to reconstruct.)*

**⚠ THE APPROVAL PHRASE IS A PRODUCTION DEPLOY.** FENCE-PUSH is live: a bare `git push` is CC's on `COMMIT APPROVED:`, and Vercel builds every push to `main`.

**Pre-open drift check:** confirm `Minotaur-Cowork` carries this close, and check `CLAUDE.md` with `wc -m` — **it should read 105,004, and building is safe above about 110,000 of headroom-consuming work.**

## 2 · THE FIRST UNIT IS FIELD-CONTRACT, AND IT IS A BUILD UNIT AGAIN

**Nothing blocks a build unit any more.** Ruled 2026-08-31, widened 2026-09-05 (*"look at every field in every layout to verify search works and change all works, like v1"*), and its acceptance criteria have arrived from real use: **six of Daniel's CDMX sprint notes are FIELD-CONTRACT findings** — duplicate landing back in the Model field · focus lost when a category change re-sorts the last row · ⌘J out of a find · the category band · the split dialog's initial selection · the find panel not re-running on edit.

**⚠ THE STECK FIELD IS THE PROVING CASE AND ITS MECHANISM IS MEASURED:** `CHANGE_ALL_FIELD_LABELS` holds fifteen fields and neither steck; the gate at `CableListClient:3112` drops the cell "naturally" in its own words; and the marker (`source_steck`) does not share a name with the column (`source_steck_count`) — **two vocabularies, one field.** An exclusion from the ruled TAB order (`CableRow.tsx:62`, click-entry only) carried unexamined into Change All and Find.

**Also riding it, all registered and measured:** **AUTOCOMPLETE-NOPORTAL** (`portalDropdown` is passed on 24 call sites across tail, line, cable, bundle, box, cable-type and inspector — and on **ZERO** equipment ones: `EquipmentItemRow.tsx:745`, `:805`; `EquipmentListClient.tsx:2808`, `:2860`, `:3315`, `:3457` — Daniel's cut-off dropdown, and the component's own comment says the portal exists for exactly this) · **CHANGEALL-NAALIAS** · **CHANGEALL-METHODDOCTRINE** · **BOXBAND-DOCTRINE** · the four **CDMX-DEFERRED** cable findings.

**Then: DARKMODE-PASS. Then BATCH-HOUSEKEEPING and `duplicate_item_v1`.**

## 3 · ⚠ TWO QUESTIONS OWED TO DANIEL AT FIELD-CONTRACT — ASK THEM, DO NOT INFER THEM

Both are from his CDMX sprint notes and **he was asked and said *"I don't know — ask again when we get to this unit."*** **The artifact cannot answer either; only the gesture can.**

1. **When a category change on the last row lost focus — was the list sorted BY CATEGORY at the time?** That decides whether it is one defect with the next item or two.
2. **The category band that would not edit — does it reproduce on a NAMED category, or only on `Uncategorized`?** A sort-dependent editor and a band with no row to write to are different defects with different fixes.

⚠ **Do not derive either from the code. ASK.**

## 4 · OPEN, AND IT IS DANIEL'S — PUT IT TO HIM EARLY

**Whether to relocate `CLAUDE.md`'s `Rulings of record` (34,808 characters) to `docs/reference/` as well.** The measured position: everything outside the run fence is **102,285**, and EQUIP-LIST-PARITY's own fence was **40,156** — so a unit of that length lands near **142,400, about 7,600 under the limit.** It works and it no longer compounds, because the fence is discardable in full now. Moving the rulings would leave such a unit **~35,000 clear** instead. ⚠ **The risk is real and is why it was not just done: the rulings list is what CC checks every UX pedigree against, and a pointer could make it read less.** Not blocking; ask once, take the answer.

## 5 · OWED BY DANIEL

1. **Hold a printed 5167 sheet against a real Avery blank.** Deferred 2026-08-31, still owed. **The only unrun acceptance on a shipped unit**, and five outputs are built on that die.
2. **The Tail Panel reprint**, owed since PANEL-CLIP — verified by DOM and PDF extraction only, which is not parity evidence for the printed page.
3. Rulings, none blocking: **CHANGEALL-NAALIAS** · **BOXBAND-DOCTRINE** · **BUNDLE-LINK-IMPORT** · **CATCOUNT-COLUMN** · **EQUIPLIST-DOTRULE** (dotted vs solid row separators — v2 draws **176,527 objects against v1's 690** and it is unruled either way) · **EQUIPLIST-CLMARGIN** · **the rulings-list question in §4**.

Then, all pinned: a fresh **v1 Bundle Summary** print · **OQ-B** one more Box-in-Box card · three **box** print reprints · a v1 export from a show that uses **cable SPLITS** · **STRAT-record entries** retiring WF-1's push clause and for the Pro upgrade · METRIC-UNRUN's browser gate · CAND-4 · GIT-CFG's remainder · **Big Cable Labels' stock assignment**. **Also his to clear when convenient: `Minotaur-Cowork/_to_delete/260906_arch-stray-outputs/`, and the untracked `Claude outputs/` folder in the code repo.**

## 6 · ARCH'S OWN, NOT RULED YET

- **⚠ FENCE-FORMS.** The ruled list of forms to block is **a description being patched one spelling at a time by reading rather than testing**, and it wants a battery the way FENCE-PUSH was proved at 34 cases. **TEST THE GUARD, DO NOT READ IT.** Its own small unit.
- **⚠ EQUIPLIST-WHOEST.** `estimateWhoHeight` **models a retired layout** — over by 119 px on a six-row block — **and is blind to a wrapping row** (measured 48 px, the estimator did not move). **Safe today because it over-counts, and the obvious correction is the one that clips.** Wants the treatment `textMetrics.ts` gave the sub-note column.
- **⚠ REVGROUP-SPLIT.** Revision-mode print does not split on note. `pairRevision` matches old rows by model alone and `buildRevisionSnapshot` **writes persisted JSON**; bringing it onto the `(model, note)` key means deciding **what a new row pairs against in an OLD snapshot written model-only.** A question about historical data, not an implementation detail.
- **2-MIG-c** (SPLITOF-NO-ARM + APPLY-TIMEOUT) still owed, still Arch's, still pinned.
- **PROJECT-NAME-NOT-UNIQUE's harness fix** — `scripts/visual-capture.mjs:122` finds its fixture by name, `.first()`, substring. **Never "fix" it by making the name unique.**
- **CORPUSBOUND-AUDIT** — how many other "resolved by corpus scan" dispositions rest on BVSC + JOY alone? Not audited. Arch's.

## 7 · DO NOT RE-DERIVE, AND DO NOT REPEAT

- **⚠ A RULE WHOSE ONLY HOME IS THE THING THAT GETS THROWN AWAY HAS A DELETION DATE ON IT.** *New standing rule, earned by this session: FENCE-ONEUNIT was unexecutable for two days because eighteen of twenty standing rules lived only in the fence it told you to discard.* **At a unit's close, its earned rules move UP into `Standing rules` BEFORE the fence body is discarded.**
- **⚠ A MARKED DUPLICATE IS A NUISANCE; AN UNMARKED ONE IS HOW A WRONG CLAIM GETS CITED.** APPLY-TIMEOUT was marked and known; `LINKGROUP-CORPUS` was not, and was still asserting a premise its own discharge had contradicted.
- **⚠ A GAP IS NOT A WRAP UNTIL THE LINE ABOVE IT IS MEASURED.**
- **⚠ THE ACCEPTANCE INSTRUMENT FOR TYPE AND LEADING IS THE EMITTED PDF, NOT THE DOM.**
- **⚠ AN INSTRUMENT MUST NOT INHERIT THE CLAIM'S PARAMETERS. A MEASUREMENT'S BOUNDARY IS A CLAIM TOO.**
- **⚠ A DISCLOSED DEVIATION IS NOT A HALT** — the seat that sets a fence is the one that widens it, in one line.
- **⚠ THE `.docx` STATES INTENT; THE PRINTED ARTIFACT STATES BEHAVIOUR.**
- **⚠ THE PAGE DIE DOES NOT SCALE.** Only type, leading and rule weights take the 4/3.
- **⚠ CONTCAT-DIVERGE AND CONTCAT-SIZE ARE BOTH RULED AND BOTH STAY.** **NOTE-GROUPING** and **EQUIP-LIST-FULLSIZE** likewise — all four are now in `CLAUDE.md`'s Rulings of record.
- **⚠ EQUIPLIST-ROWH-BIMODAL.** v1's body row takes **two heights, 19.97 and 20.97**, and the discriminator is **measured and unexplained**. 19.97 is taken.
- **⚠ `docs/reference/v1_ddr.xml` IS UTF-16LE** and names the same field TWO ways. ⚠ **It states NO TAB ORDER anywhere. Do not search again.**
- **⚠ EVERY CITATION OF A PROJECT NAMES AN ID.** `cf780353-448d-4b15-a054-973f577b215c` is **Mexico City**, `57874c69-06b6-41b1-91d8-6a00e5255110` is the **US Tour**. **Two productions sharing one show name is a RULED must-have feature.**
- **⚠ HASH-FREEZE-LABELS. `labels_done` STAYS. ⚠ APPLY-TIMEOUT is measured and PINNED.**
- **⚠ `Cable Parity Fixture`, `Matched Pair Fixture` and BOTH Buena Vista projects are RLS-invisible to any harness CC drives** (HARNESS-RLS-CORPUS). Anything needing them on screen is Daniel's gate.
- **Do not re-litigate:** the RPC route · HASH-FREEZE-LABELS · blank-for-0 on export · the folder-label ORDER · the palette · the Avery stock assignments · **Q-1 · Q-2 · Q-3 · Q-4 · OQ-1 · OQ-2 · OQ-3 · OQ-4 · OQ-5** · the spend cap ON · CONTRAST-PAIR · MENU-DEPRECATE · the row count staying off the screen · **CATNOTE-CELL** · **CATNOTE-AUTOSIZE** · **EQUIP-LIST-FULLSIZE** · **NOTE-GROUPING**.

## 8 · NOT THIS SESSION

Everything behind FIELD-CONTRACT and DARKMODE-PASS — and in particular **APPLY-TIMEOUT** · EQUIPLIST-ESTIMATE-PAGINATOR's conversion to measured pagination · EQUIPLIST-WHOEST · REVGROUP-SPLIT · FENCE-FORMS · CONTRAST-PAIR · WAITLIST-NOTIFY · DEEP-ARCHIVE · GATE-THEMEGLYPH · S4-late · EXPORT-HISTID-DROP · the eight queued layouts · DEVICE-FK-LINK · **Big Cable Labels**.

## 9 · CONDUCT — what this session's record says

1. **Read the file before you predict what is in it.** The saving was stated to Daniel as a number before the fence had been read, and it was wrong by 22,000 characters. **The Surface Rule applies to this seat on the unit whose whole job is reading a file.**
2. **A claim of verification is a claim.** "The Ledger holds all 26" was written before it was checked; it held 24. Checked, corrected, and the two carried in — rather than left standing.
3. **Sweep after the write, not only before it.** Three identifiers went missing in a mechanical edit and one of them was live and load-bearing. The sweep found it on the first pass.
4. **Move whole lines; never retype them.** 129 rows were sorted by script with an assertion that every one landed in exactly one table, and the count was reconciled before anything was written.
5. **Count what a cap counts.** The RM-6 six-bullet cap was counted, not assumed — as the close rule says in its own words.

---

*Governing set at this close: **Arch v34** + `Architecture_Provenance.md` · **Roadmap v4.23** (retires v4.22) · Ledger v1.0 (Sep-8 EIGHTH append, carrying the retired fence text) · **`CLAUDE.md` at 105,004 characters, 44,996 under its limit** · Session Log at **8**, rollover CLEAR. HEAD **`c525a55`** unless Daniel ran the code-repo block, in which case it is one commit later **and that was a production deploy — run the pre-open check**. **Migration ledger 57 — UNCHANGED for five units.** Suite **2827 / 149**. Visual gate **28/28 at 0.0000%**. In flight: nothing. **Next: FIELD-CONTRACT, and it owes Daniel two questions that must be ASKED.***
