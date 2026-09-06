# NEXT SESSION OPENER — Cowork-Arch, MAIN LINE

**Written 2026-09-05 at the close of the session that shipped CHANGEALL-BOXNULL at `6deb411`, took Daniel's rulings on BOXNULL-TOOLBAR and CONTCAT-DIVERGE, got the BVSC Tour into v2 after APPLY-TIMEOUT stopped a real import, measured EQUIP-LIST-SCALE at exactly 0.750, and corrected three of its own claims — one of which had already reached a governing file, and one of which was its own proposal for what to build next.**

**⚠ THE ROLLOVER IS NOT DUE. The log stands at 4 and fires at 10. Last archived 2026-09-01.**

---

## 0 · SEAT CHECK

Cowork, three mounts reachable: `Minotaur` · `Minotaur-Cowork` · `Minotaur_v1_exports`. **If not, STOP and say so.**
**Mounts do NOT persist between sessions — expect to grant all three at open.** They live at `~/Developer/Minotaur`, `~/Developer/Minotaur-Cowork`, `~/Minotaur_v1_exports`.

No parallel session is live. **CC is IDLE. Nothing is in flight.**

## 1 · READ ORDER

`Architecture_Prompt_v34.md` → `Minotaur_v2_Roadmap_v4_19.md` (WHOLE) → `Minotaur_v2_Session_Log.md` (STATE OF PLAY + the Sep-5 evening entry) → this opener → then, **on citation only**, `Minotaur_v1_exports/equipment/_PROVENANCE.md` (**its 2026-09-05 section is the sharpest document for the opening unit — the category-note anatomy and the correction are both in it**), and `handoffs/from-cc/260905-2040_changeall-boxnull.md` with its `_CLOSE.txt`.

**Verify state from files, never by running git.** **⚠ Read `.git/refs/heads/main` — NOT `.git/packed-refs`, which carries `be0769de`, now SIXTEEN commits stale, and is also the frozen-gate baseline so it looks plausible.** HEAD should read **`6deb411`**. **Migration ledger 57** — live-read it and byte-match. **⚠ IT DID NOT MOVE LAST SESSION, and the two units before it both did — do not assume 58.** Suite **2719 across 144**.

**⚠ Production READY is NOT seat-verifiable** — `scripts/vercel-preopen.mjs` needs a token the Cowork seat cannot reach. Say so rather than asserting a deploy state.

**⚠ THE APPROVAL PHRASE IS A PRODUCTION DEPLOY.** FENCE-PUSH is live: a bare `git push` is CC's on `COMMIT APPROVED:`, and Vercel builds every push to `main`.

**Pre-open drift check:** confirm `Minotaur-Cowork` carries this close.

## 2 · THE SEQUENCE IS RULED, AND IT IS THE WHOLE SESSION

**⚠ CDMX-SEQUENCE (Daniel, 2026-09-05):** *"we're doing things pertaining to the category note management, category note printing, and print parity. nothing else before those are finished."*

In order: **CAT-NOTE's data and editing half** → **CAT-ADMIN** → **CAT-NOTE's PRINT half** → **EQUIP-LIST-PARITY**.

**⚠ NOTHING ELSE. Not APPLY-TIMEOUT, not FIELD-CONTRACT, not a housekeeping batch, however live or docketed.** This ruling exists because the previous close proposed APPLY-TIMEOUT as the next unit on the strength of its severity, and Daniel overruled it: **the import is done, the workaround shipped the show, and a migration does not come before the production work this Roadmap is sequenced by.** *A driver ruling outranks a docket item's urgency.*

## 3 · FIRST ACTION — CAT-NOTE, AND IT IS SMALLER THAN THE OLD ROADMAP SAID

**Read v4.19's CAT-NOTE entry rather than remembering the old one: two of its blocking claims were WRONG and are corrected there.**

**⚠ THE FIELD, THE IMPORT AND THE EXPORT ALL ALREADY EXIST. NO MIGRATION. NO NEW TABLE.**

- `categories.notes` is `text`, nullable, present on every row.
- `src/lib/import/map.ts:780` reads v1's `Notes`; **`import_apply_v1` carries it on BOTH its insert and its update arm** (the `createMissing` arm does not, and correctly has no note to carry — reading only that one is what produced the wrong claim).
- `buildSheet.ts` `CategoryExportRow.notes` emits it, so the round trip is already closed.
- **All six of Daniel's BVSC Tour notes are LIVE in `Buena Vista Social Club` right now.** `4.1 Microphone Hardware` · `8.0 Power` · `9.0 Hardware and Rigging` · `11.0 Racks and Boxes` · `13.0 Cable` · `13.1 Tails`.

**RULED (Daniel, 2026-09-05): ONE note per category.** Multi-line notes are line breaks **inside that one field**, not separate records — proved on the v1 export, where Power, Hardware and Rigging and Cable each carry two lines inside a single value.

**⚠ IMPORT-LINEBREAK-CR — build this in, do not discover it.** Stored notes are **carriage-return separated**: on the BVSC Tour import, **210 equipment public notes, 15 library notes and 3 of the 6 category notes carry CR, and ZERO carry LF.** A bare CR is not a line break in a browser and `split('\n')` will not see it. **Call `normalizeLineBreaks` at display time, exactly as the equipment print already does — and NEVER write it back, because the frozen row-hash contract depends on the stored bytes.**

**What is actually missing is display and editing.** There is **no category admin surface in v2 at all** today — `src/lib/queries/categories.ts` is a read and nothing more.

## 4 · THEN, IN THE RULED ORDER

**CAT-ADMIN** — rudimentary category management, and the surface a note is edited on. **Copy `MethodsAdminClient.tsx` (634 lines, route at `/equipment/methods`); do not invent.** Same shape, same doctrines — merge, duplicate-guard, system-row protection. "Rudimentary" is Daniel's word and it bounds the scope: manage the list, not a new information architecture.

**CAT-NOTE's PRINT half** — **⚠ THE TYPE SPEC IS MEASURED (CATNOTE-TYPE). Do not re-derive it.**

- Category note **12.00 pt ITALIC** — the same size as a body item line.
- Item sub-note **10.00 pt italic**. **Two note levels at two different sizes; they cannot share a style.**
- The note sits **between the category heading and the first item, flush with the heading's left edge**; items are indented and sub-notes indented further — **three levels, not two**.
- **It does NOT repeat when a category continues onto a following page.**
- **It DOES print again when the same category appears in a different LIST** — `8.0 Power` carries its note in both `Main List` and `Production Only`.
- The surface already sections by category (`PrintEquipmentListClient.tsx`), so the note slots into a heading structure that exists.

**EQUIP-LIST-PARITY** — **⚠ THE TYPE RATIO IS MEASURED AT EXACTLY 0.750 ON EVERY ELEMENT CLASS. DO NOT RE-DERIVE IT.** Item 12.00→9.00 · sub-note italic 10.00→7.50 · category heading 12.00→9.00 · show name / title / list band 14.00→10.50 · footer 10.00→7.50. **The page die is already right** (v1 x 25.98→584.96, v2 x 27.00→584.99).

- **⚠ THE OPEN WORK IS THE LEADING.** Body row pitch reads v1 ≈ 19.97 against v2 ≈ 17.25, ≈ **0.86** — **PROVISIONAL, four samples on one page**, and it is re-measured across both documents before it becomes a constant. **One die with TWO derived numbers, not one scale.**
- **⚠ CONTCAT-DIVERGE is a RULED exception and STAYS.** v2's continued-category line is better than v1 and is the one element off 0.750, at 0.900. **Do not "fix" it back by citing the artifact.**
- **⚠ THE COVER LETTER MAY WANT ITS OWN SCALE.** v1's cover letter is **a Word document appended by hand**, not FileMaker output. One ratio fitted to two source applications leaves one of them wrong. **The `.docx` is a better arbiter than any print — Word stores its styles as text.** RULED (Daniel, 2026-09-05): v2's cover-letter design is good; this is a scale job only.
- **⚠ EQUIPVIEW-UNSAFE must not be discovered mid-build:** `v_equipment_list` does not filter `type` and exposes `ip_address` while hiding `address`, populated on **261** rows against `ip_address`'s **1**, and v1's equipment output prints Address.

**The matched pair, both landed:** v1 `equipment/260905-1159_v1_equipment-list_BVSC-Tour_FILEMAKER.pdf` (31 pages) · v2 `parity-pairs/260905_equipment-list-pair/260905-2202_v2_equipment-list_BVSC-Tour_CHROME.pdf` (24 pages).

**Pinned, not dropped — and NONE of it runs before §3 and §4 are finished:** **APPLY-TIMEOUT** · **FIELD-CONTRACT** and its four CDMX-DEFERRED cable findings (CABLE-NAME-COMMIT · CABLE-CHANGEALL-BOX · CABLE-TAB-BUNDLE-METHOD · BOXBAND-DOCTRINE) · METHOD-SORT-ORDER · PREVIEW-CLIP · CHANGEALL-SPEED · CHANGEALL-NAALIAS · CHANGEALL-METHODDOCTRINE · CREATEMETHOD-BLINDERR · RLS-INITPLAN · MARKER-OVERHANG's fix · SMALLNAME-STEP · QTY-ITALIC · BOXLABEL-ZERO · CORPUSBOUND-AUDIT · 2-MIG-c · LINT-DEAD · EVIDENCE-UNTRACKED · FENCE-HEREDOC.

## 5 · OWED BY DANIEL

1. **Hold a printed 5167 sheet against a real Avery blank.** Deferred 2026-08-31, still owed. **It is the only unrun acceptance on a SHIPPED unit**, and five outputs are being built onto that die.
2. **A ruling on CHANGEALL-NAALIAS** — a typed `0` in Method creates a method literally named `0`. *(Pinned; does not block §3.)*
3. **A ruling on BOXBAND-DOCTRINE** — should the sort-band editor's Box arm offer to create, or does its silent no-op-revert stand? *(Pinned; does not block §3.)*

Then, all pinned: the **Tail Panel reprint** owed since PANEL-CLIP · a fresh **v1 Bundle Summary** print (BUNDLESUM-MARKS) · **OQ-B** one more Box-in-Box card · **OQ-3's optional confirmation** · three **box** print reprints · a v1 export from a show that uses **cable SPLITS** · a **STRAT-record entry retiring WF-1's push clause** and **one for the Pro upgrade** · METRIC-UNRUN's browser gate · CAND-4 · GIT-CFG's remainder · **Big Cable Labels' stock assignment**.

**Discharged 2026-09-05: the new-box-dialog question (never new — it was his own ruling 1 of 2026-08-19) · BOXNULL-TOOLBAR · CONTCAT-DIVERGE · one-note-per-category · CDMX-SEQUENCE · CHANGEALL-SPEED's target · the browser gate, eighth time · the v1 FileMaker print, the cover-letter `.docx`, the categories export and the full BVSC Tour export, all landed · BVSC NY's junk boxes and JOY's deletion are moot — those projects no longer exist.**

## 6 · DO NOT RE-DERIVE, AND DO NOT REPEAT

- **⚠ CATNOTE-TYPE and EQUIP-LIST-SCALE's TYPE ratio are MEASURED — §4 has both. The LEADING is the thing still to measure.**
- **⚠ The corpus CAN arbitrate CAT-NOTE** — `BVSC/2026-07-12_1608/categories.xlsx` and `JOY/2026-07-12_1610/categories.xlsx` both carry populated `Notes`. The earlier "no category notes anywhere" reading searched printed PDFs for a field that lives in a workbook.
- **⚠ "BVSC NY" IN ANY OLDER DOCUMENT MEANS `Cable Parity Fixture`.** A previous session renamed it; JOY and Our Town in Space were deleted by Daniel. **24 projects live**, measured as `postgres` with RLS not applied and zero orphan rows. The v1 export folders on disk are intact and are the parity arbiters.
- **⚠ APPLY-TIMEOUT's settings are measured and it is PINNED.** `authenticated` = 8s, `anon` = 3s, `import_apply_v1` has no override. **Do not open it.** When it is eventually run: Postgres arms the timeout when the statement BEGINS, so the in-function fix may not re-arm it — that is a rehearsal, not a patch — and **chunking the apply is not a candidate, because atomicity is what made the failure harmless.**
- **⚠ A CONTROL DERIVED FROM THE SPECIFICATION FINDS ONLY WHAT THE SPECIFICATION IMAGINED.** CHANGEALL-BOXNULL's case 3 was not in the handoff.
- **⚠ A CONTROL THAT PASSES IS NOT A CONTROL.** The toolbar-plus-matched-name case passes against the broken tree — twice now, in two units.
- **⚠ READING ONE ARM OF A FUNCTION AND GENERALISING IS THE SURFACE RULE FAILING IN MINIATURE.** `import_apply_v1` has two category write arms; reading one produced a wrong claim that reached `_PROVENANCE.md`.
- **⚠ ABSENCE OF DATA IS NOT ABSENCE OF A CODE PATH.**
- **⚠ AN EXTRAPOLATION IS A MEASUREMENT'S SHADOW AND MUST BE LABELLED AS ONE.**
- **⚠ A DRIVER RULING OUTRANKS A DOCKET ITEM'S URGENCY** — §2 exists because this seat forgot that about its own document.
- **⚠ A PDF'S PRODUCER IS PART OF ITS PEDIGREE.** FileMaker is v1's own engine · Preview/Quartz measures the operating system · Word is a third thing.
- **⚠ A GUARD OVER ZERO FILES ALWAYS PASSES**, and a guard one byte can silence is not a guard.
- **⚠ A SUMMARY IS A SURFACE** · **A SHAPE SHARED WITH v1 IS NOT A BEHAVIOUR SHARED WITH v1** · **THE SOURCE STATES INTENT; THE ARTIFACT STATES BEHAVIOUR** · **NAME THE BEHAVIOUR, NOT THE SYMBOL** · **DEAD-CODE-IS-NOT-SAFE** · **GATE-NOGREP** · **TEST THE GUARD, DO NOT READ IT** · **A SEARCH RUN WITH THE WRONG INSTRUMENT RETURNS ABSENCE**.
- **⚠ HASH-FREEZE-LABELS. `labels_done` STAYS** — one of `computeRowHash`'s frozen fourteen. Its removal is LABELSDONE-RESIDUE, a separate ruled destructive step.
- **⚠ `docs/reference/v1_ddr.xml` IS UTF-16LE** — read via `iconv -f UTF-16LE`. **It states NO TAB ORDER anywhere.** Do not search again.
- **⚠ `Cable Parity Fixture` and `Matched Pair Fixture` are RLS-invisible to any harness CC drives.**
- **⚠ Never re-import into `Buena Vista Social Club`** — it is loaded and verified.
- **Do not re-litigate:** the RPC route · the separate-units ruling · HASH-FREEZE-LABELS · blank-for-0 on export · the folder-label ORDER · the palette · the Avery stock assignments · **Q-1 · Q-2 · Q-3 · Q-4 · OQ-1 · OQ-2 · OQ-3 · OQ-4 · OQ-5** · the spend cap ON · CONTRAST-PAIR · MENU-DEPRECATE · BUNDLE-LINK-IMPORT · **the row count staying off the screen** (uncited = unbuilt) · **CONTCAT-DIVERGE** · **CDMX-SEQUENCE**.

## 7 · NOT THIS SESSION

**Everything in §4's pinned list**, and in particular **APPLY-TIMEOUT** and **FIELD-CONTRACT** · CONTRAST-PAIR · WAITLIST-NOTIFY · DEEP-ARCHIVE · GATE-THEMEGLYPH's diagnosis · the `0` vocabulary-row fold · S4-late · EXPORT-HISTID-DROP · the other seven queued layouts · DEVICE-FK-LINK · **FENCE-HEREDOC** · **Big Cable Labels**.

## 8 · CONDUCT — what this session's record says

1. **A driver ruling outranks a docket item's urgency.** This seat proposed a migration ahead of the show in a roadmap it had just written "sequenced by BVSC-MX" into. Daniel caught it.
2. **Read the file before asserting its state — including our own openers.** The last opener was wrong about the box-creation doctrine; reading the source made the unit smaller and removed a question from Daniel's desk.
3. **Read ALL the arms.** One of two category write arms produced a wrong claim that reached a governing file.
4. **Label an extrapolation.** A projection in the tense of a measurement cost Daniel a ruling on a defect he had never seen.
5. **Make scope a test, not a comment.** "Equipment surface only" as a failing test turned four gate findings into a one-read triage.
6. **Run the real gesture in the control.** The specification imagined two failure modes; the gesture had three.
7. **Daniel's gate has now found what the machine gates could not EIGHT times running.** Budget for a gate round, and **run it BEFORE the approval phrase, because the phrase deploys** (GATE-BEFORE-COMMIT).

---

*Governing set at this close: **Arch v34** + `Architecture_Provenance.md` · **Roadmap v4.19** (retires v4.18) · Ledger v1.0 (Sep-5 fourth append) · `CLAUDE.md` current at `6deb411` · Session Log at **4, rollover CLEAR**. HEAD **`6deb411`**, pushed. **Migration ledger 57 — UNCHANGED.** Suite **2719 / 144**. Visual gate **28/28 at 0.0000% TWICE**, loads 3.86 and 3.57, no frame moved, no baseline event. In flight: nothing. **Next: CAT-NOTE → CAT-ADMIN → CAT-NOTE's print half → EQUIP-LIST-PARITY, and nothing else until they are finished.***
