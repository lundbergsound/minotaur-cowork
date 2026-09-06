# NEXT SESSION OPENER — Cowork-Arch, MAIN LINE

**Written 2026-09-06 at the close of the session that shipped CAT-ADMIN at `1a54c3b`, discovered the category screen had existed all along as a switched-off tab, proved v1's category and method editors byte-identical twins, took Daniel's CATNOTE-CELL and CATNOTE-AUTOSIZE rulings, had its own data rule proven on production by his browser gate, and drove `CLAUDE.md` 11,200 characters over its limit before bringing it 15,236 under.**

**⚠ THE ROLLOVER IS NOT DUE. The log stands at 5 and fires at 10. Last archived 2026-09-01.**

---

## 0 · SEAT CHECK

Cowork, three mounts reachable: `Minotaur` · `Minotaur-Cowork` · `Minotaur_v1_exports`. **If not, STOP and say so.**
**Mounts do NOT persist between sessions — expect to grant all three at open.** They live at `~/Developer/Minotaur`, `~/Developer/Minotaur-Cowork`, `~/Minotaur_v1_exports`.

No parallel session is live. **CC is IDLE. Nothing is in flight.**

## 1 · READ ORDER

`Architecture_Prompt_v34.md` → `Minotaur_v2_Roadmap_v4_20.md` (WHOLE) → `Minotaur_v2_Session_Log.md` (STATE OF PLAY + the Sep-6 entry) → this opener → then, **on citation only**, the Ledger's **Sep-6 fifth append** (it carries the propagation list, the new standing rules, and the retired fence archive) and `from-cc/260906-0830_cat-admin.md` with its `_CLOSE.txt`.

**Verify state from files, never by running git.** **⚠ Read `.git/refs/heads/main` — NOT `.git/packed-refs`, which carries `be0769de`, now SEVENTEEN commits stale, and is also the frozen-gate baseline so it looks plausible.** HEAD should read **`1a54c3b`**. **Migration ledger 57** — live-read it and byte-match; last version `20260901043028`. **⚠ IT HAS NOT MOVED IN TWO UNITS — do not assume 58.** Suite **2743 across 146**.

⚠ **PRODUCTION READY AT `1a54c3b` IS UNCONFIRMED AND IS THE FIRST THING THIS SESSION SETTLES.** CC read Vercel **BUILDING** fourteen seconds after the push, with the previous READY still at `6deb411`. **Run `node scripts/vercel-preopen.mjs` and require exit 0 before any build work.** ⚠ Note the standing caveat cuts the other way this time: the check is normally *not* seat-verifiable from Cowork (the token is unreachable), so **this one is Daniel's to run or CC's, not this seat's** — say so rather than asserting a deploy state.

**⚠ THE APPROVAL PHRASE IS A PRODUCTION DEPLOY.** FENCE-PUSH is live: a bare `git push` is CC's on `COMMIT APPROVED:`, and Vercel builds every push to `main`.

⚠ **`CLAUDE.md`'s LIMIT IS IN CHARACTERS, NOT BYTES.** It closed at **134,764 characters — 15,236 under the 150,000 limit** — while `wc -c` reports **136,136 bytes**. A reader checking with `wc -c` on a fuller file will believe it is over when it is not.

**Pre-open drift check:** confirm `Minotaur-Cowork` carries this close.

## 2 · THE SEQUENCE IS RULED, AND TWO ITEMS REMAIN IN IT

**⚠ CDMX-SEQUENCE (Daniel, 2026-09-05):** *"we're doing things pertaining to the category note management, category note printing, and print parity. nothing else before those are finished."*

Items 1 and 2 are **CLOSED at `1a54c3b`**. What remains, in order: **CAT-NOTE's PRINT half** → **EQUIP-LIST-PARITY**. Then, queued by Daniel on 2026-09-06: **ROADMAP-REFACTOR**.

**⚠ NOTHING ELSE. Not APPLY-TIMEOUT, not FIELD-CONTRACT, not a housekeeping batch, however live or docketed.** *A driver ruling outranks a docket item's urgency.*

## 3 · FIRST ACTION — CAT-NOTE'S PRINT HALF

**⚠ THE TYPE SPEC IS MEASURED (CATNOTE-TYPE). Do not re-derive it.**

- Category note **12.00 pt ITALIC** — the same size as a body item line.
- Item sub-note **10.00 pt italic**. **Two note levels at two different sizes; they cannot share a style.**
- The note sits **between the category heading and the first item, flush with the heading's left edge**; items are indented and sub-notes indented further — **three levels, not two**.
- **It does NOT repeat when a category continues onto a following page.**
- **It DOES print again when the same category appears in a different LIST** — `8.0 Power` carries its note in both `Main List` and `Production Only`.

**What is already in place, verified at source 2026-09-06 — do not re-derive:**

- `PrintEquipmentListClient.tsx` **already sections by category**, so the note slots into a heading structure that exists.
- `PrintPageLoader` **already fetches the notes** — `fetchCategories` selects `'*'`, so `categories.notes` is in hand on the print surface. **No query change.**
- `normalizeLineBreaks` (`src/lib/utils.ts:62`) is **already called by this very file** at two sites. **IMPORT-LINEBREAK-CR's requirement is one call, not a mechanism to build** — and it is display-time only, never written back.

**⚠ CATNOTE-RULE — a LEAD, not a finding, and check it against the artifact before building it.** v1's order/print layouts carry **fourteen colour-keyed 2 pt full-width `Object type="Line"` rules**, each hidden unless `Temporary Variables::Minotaur Color` matches **AND** `Categories::Notes ≠ ""` — so v1 appears to draw a rule in the show's paperwork colour **only where a category carries a note**. The note object itself carries the plain `Categories::Notes = ""` hide condition, so **an empty note prints nothing at all, not a blank line.** **DDR-IS-THE-SOURCE cuts both ways: the source states intent, the artifact states behaviour.**

⚠ **AND READ THE DDR WITH THE RIGHT INSTRUMENT.** `docs/reference/v1_ddr.xml` is **UTF-16LE** (`iconv -f UTF-16LE`), **and it names the same field TWO ways**: layout field objects use `<FieldObj><Name>Table::Field</Name>` and `<DDRInfo><Field name= id= repetition= maxRepetition= table=/>`, while calculations and hide conditions use `<Field table= id= name=>`. **A search written for one form finds none of the other** — that error concluded "v1 has no category editor" last session. **Before concluding absence, prove the search finds a known-present instance.** And **measure an extract's boundaries**: layout 317 runs 83384–83528, and taking it to 84500 silently swallows three more layouts.

## 4 · THEN — EQUIP-LIST-PARITY

**⚠ THE TYPE RATIO IS MEASURED AT EXACTLY 0.750 ON EVERY ELEMENT CLASS. DO NOT RE-DERIVE IT.** Item 12.00→9.00 · sub-note italic 10.00→7.50 · category heading 12.00→9.00 · show name / title / list band 14.00→10.50 · footer 10.00→7.50. **The page die is already right** (v1 x 25.98→584.96, v2 x 27.00→584.99).

- **⚠ THE OPEN WORK IS THE LEADING.** Body row pitch reads v1 ≈ 19.97 against v2 ≈ 17.25, ≈ **0.86** — **PROVISIONAL, four samples on one page**, re-measured across both documents before it becomes a constant. **One die with TWO derived numbers, not one scale.**
- **⚠ CONTCAT-DIVERGE is a RULED exception and STAYS** at 0.900. **Do not "fix" it back by citing the artifact.**
- **⚠ THE COVER LETTER MAY WANT ITS OWN SCALE.** v1's is **a Word document appended by hand**, not FileMaker output. **The `.docx` is a better arbiter than any print.** RULED (Daniel, 2026-09-05): v2's cover-letter design is good; this is a scale job only.
- **⚠ EQUIPVIEW-UNSAFE must not be discovered mid-build:** `v_equipment_list` does not filter `type` and exposes `ip_address` while hiding `address`, populated on **261** rows against `ip_address`'s **1**, and v1's equipment output prints Address.

**The matched pair, both landed:** v1 `equipment/260905-1159_v1_equipment-list_BVSC-Tour_FILEMAKER.pdf` (31 pages) · v2 `parity-pairs/260905_equipment-list-pair/260905-2202_v2_equipment-list_BVSC-Tour_CHROME.pdf` (24 pages).

**Pinned, and NONE of it runs before §3 and §4 are finished:** **ROADMAP-REFACTOR** (first after) · **APPLY-TIMEOUT** · **FIELD-CONTRACT** and its four CDMX-DEFERRED cable findings · **CAT-MERGE** · **RENAME-HASHDRIFT** · **CATNOTE-EXPORT-LF** · **CATCOUNT-COLUMN** · **AMEND-ROUND-TENSION** · **ADMIN-NEWDUP** · METHOD-SORT-ORDER · PREVIEW-CLIP · CHANGEALL-SPEED · CHANGEALL-NAALIAS · CHANGEALL-METHODDOCTRINE · CREATEMETHOD-BLINDERR · RLS-INITPLAN · MARKER-OVERHANG's fix · SMALLNAME-STEP · QTY-ITALIC · BOXLABEL-ZERO · CORPUSBOUND-AUDIT · 2-MIG-c · LINT-DEAD · EVIDENCE-UNTRACKED · FENCE-HEREDOC.

## 5 · OWED BY DANIEL

1. **Hold a printed 5167 sheet against a real Avery blank.** Deferred 2026-08-31, still owed. **It is the only unrun acceptance on a SHIPPED unit**, and five outputs are being built onto that die.
2. **A ruling on CHANGEALL-NAALIAS** — a typed `0` in Method creates a method literally named `0`.
3. **A ruling on BOXBAND-DOCTRINE** — should the sort-band editor's Box arm offer to create, or does its silent no-op-revert stand?
4. **A ruling on BUNDLE-LINK-IMPORT** — do v1's bundle-field link groups come into v2, or never? Ships complete and enrolls nothing; not importing is the reversible direction.
5. **CATCOUNT-COLUMN** — should the Categories tab show an item count? **None is rendered.** ⚠ If it ever is, the count is unfiltered by `type`, so `13.0 Cable` on BVSC reads **1,480 spine rows**.

*(None of 2–5 blocks §3.)* Then, all pinned: the **Tail Panel reprint** owed since PANEL-CLIP · a fresh **v1 Bundle Summary** print (BUNDLESUM-MARKS) · **OQ-B** one more Box-in-Box card · **OQ-3's optional confirmation** · three **box** print reprints · a v1 export from a show that uses **cable SPLITS** · a **STRAT-record entry retiring WF-1's push clause** and **one for the Pro upgrade** · METRIC-UNRUN's browser gate · CAND-4 · GIT-CFG's remainder · **Big Cable Labels' stock assignment**.

**Discharged 2026-09-06: CATNOTE-CELL · CATNOTE-AUTOSIZE · the declared `05-gcm` baseline event · the `CLAUDE.md` fence repair riding the commit · the browser gate, ninth time · success condition 2 on BVSC.**

## 6 · ARCH'S OWN, AND NOT RULED YET

- **⚠ AMEND-ROUND-TENSION.** *"One declaration per unit"* and *"never restore baselines"* pull against each other the moment a unit takes an amend round that re-baselines: **H2 computes the moved set against the baselines ON DISK**, so re-declaring a unit whole after a round's writes have landed trips **rule 2 (declared but not moved)** on every already-adopted frame. Resetting to the **committed** state to declare once is not the retired scoped-restore workflow but is the nearest thing. **Rule it before the next unit that takes an amend round.**
- **2-MIG-c** (SPLITOF-NO-ARM + APPLY-TIMEOUT) is still owed and still Arch's, sequenced behind the CDMX work.
- **The retired fence archive** is in the Ledger's Sep-6 append: R3, R4, R8 and R9 kept verbatim; R1, R2, R5, R6 and R7 dropped with reasons. **The dropped sections are recoverable from `from-cc/260906-0830_cat-admin.md` §A9** if a future session disagrees.

## 7 · DO NOT RE-DERIVE, AND DO NOT REPEAT

- **⚠ CATNOTE-TYPE and EQUIP-LIST-SCALE's TYPE ratio are MEASURED — §3 and §4 have both. The LEADING is the thing still to measure.**
- **⚠ THE CATEGORIES TAB IS LIVE and its note cell is a MULTI-LINE box that grows as you type** (CATNOTE-CELL + CATNOTE-AUTOSIZE, Daniel 2026-09-06). **It is a deliberate divergence from v1's fixed 21 pt scrolling field — do not "fix" it back by citing layout 317.** The exemption from the Enter-advance grammar is enforced by `categoryNoteCellScope.test.ts`, which reads bytes and **permits `onInput` by name**.
- **⚠ THE NOTE'S SAVE RULE IS PROVEN ON PRODUCTION.** Seed through `normalizeLineBreaks`, compare the blur against the **SEED**, never the stored bytes, and write what the control gives, uncoerced. **An untouched note is not a write at all.** Do not "harmonise" line endings on write.
- **⚠ BVSC's `8.0 Power` NOTE NO LONGER MATCHES ITS v1 SOURCE** — 153 chars / 1 CR → 154 / 2 LF, from Daniel's own gate on 2026-09-06. **A future round-trip comparison must not report it as a defect.** `9.0 Hardware and Rigging` and `13.0 Cable` are untouched.
- **⚠ THERE IS NO `merge_categories`.** A rename collision on the Categories tab refuses and reverts by design. Building the merge is **Trigger B, Arch's, rehearsal-first** (CAT-MERGE).
- **⚠ A SEARCH IS AN INSTRUMENT, AND A FORMAT HAS MORE THAN ONE FORM.** Prove the search finds a known-present instance before concluding absence. Fourth occurrence on this project.
- **⚠ AN EXTRACT WHOSE BOUNDARIES WERE NOT MEASURED IS NOT AN EXTRACT.**
- **⚠ A DEFECT UNREACHABLE BY CONSTRUCTION BECOMES REACHABLE THE MOMENT THE CONSTRUCTION CHANGES** (GCMTAB-STALE).
- **⚠ TIGHTEN THE ASSERTION; NEVER LOOSEN IT TO ADMIT YOUR OWN NEW CODE.** When a guard's wording stops describing what it protects, the wording is the defect.
- **⚠ FENCE-ONEUNIT. The run fence carries ONE unit, not a history** — `git log` is the closed-and-pushed list. **Every handoff that touches the fence says REPLACE THE BODY, DO NOT APPEND**, because the one that only said "bring it current" cost 9,313 characters.
- **⚠ A PROBE THAT MEASURES THE WRONG TRANSITION REPORTS A WORKING FIX AS BROKEN** — 1→2 lines needs no growth; 2→3 is the decisive one.
- **⚠ "BVSC NY" IN ANY OLDER DOCUMENT MEANS `Cable Parity Fixture`.** **24 projects live.** The v1 export folders on disk are intact and are the parity arbiters.
- **⚠ APPLY-TIMEOUT's settings are measured and it is PINNED. Do not open it.**
- **⚠ `Cable Parity Fixture` and `Matched Pair Fixture` are RLS-invisible to any harness CC drives** — and so is `Buena Vista Social Club` (HARNESS-RLS-CORPUS). **Anything needing BVSC on screen is Daniel's gate, not CC's.**
- **⚠ Never re-import into `Buena Vista Social Club`** — it is loaded and verified.
- **⚠ `docs/reference/v1_ddr.xml` IS UTF-16LE.** **It states NO TAB ORDER anywhere.** Do not search again.
- **⚠ HASH-FREEZE-LABELS. `labels_done` STAYS.**
- **Do not re-litigate:** the RPC route · the separate-units ruling · HASH-FREEZE-LABELS · blank-for-0 on export · the folder-label ORDER · the palette · the Avery stock assignments · **Q-1 · Q-2 · Q-3 · Q-4 · OQ-1 · OQ-2 · OQ-3 · OQ-4 · OQ-5** · the spend cap ON · CONTRAST-PAIR · MENU-DEPRECATE · BUNDLE-LINK-IMPORT's shape · **the row count staying off the screen** · **CONTCAT-DIVERGE** · **CDMX-SEQUENCE** · **CATNOTE-CELL** · **CATNOTE-AUTOSIZE**.

## 8 · NOT THIS SESSION

**Everything in §4's pinned list**, and in particular **APPLY-TIMEOUT** and **FIELD-CONTRACT** · CONTRAST-PAIR · WAITLIST-NOTIFY · DEEP-ARCHIVE · GATE-THEMEGLYPH's diagnosis · the `0` vocabulary-row fold · S4-late · EXPORT-HISTID-DROP · the other seven queued layouts · DEVICE-FK-LINK · **FENCE-HEREDOC** · **Big Cable Labels**.

## 9 · CONDUCT — what this session's record says

1. **Read the surface before designing against it — including the screens.** Two governing documents said the category page did not exist. It existed, switched off, and reading it merged two units and removed a navigation decision.
2. **Prove the search before trusting its absence.** The DDR names one field two ways; a search for one form returned the opposite of the truth.
3. **Measure an extract's boundaries.** One taken without checking held four layouts.
4. **An instruction is a surface.** "Bring the fence current" is not "replace the body" — and the seat that quoted FENCE-COUNTS broke it one section later.
5. **Tighten a guard rather than loosen it to admit your own code**, and probe it both ways — a control that crashes is not a control either.
6. **Daniel's gate has now found what the machine gates could not NINE times running.** Budget for a gate round, and **run it BEFORE the approval phrase, because the phrase deploys** (GATE-BEFORE-COMMIT). This time it also proved a data rule on production that no throwaway could have.

---

*Governing set at this close: **Arch v34** + `Architecture_Provenance.md` · **Roadmap v4.20** (retires v4.19) · Ledger v1.0 (Sep-6 fifth append, carrying the retired fence archive) · `CLAUDE.md` current at `1a54c3b`, **15,236 characters under its limit** · Session Log at **5, rollover CLEAR**. HEAD **`1a54c3b`**, pushed; **production READY UNCONFIRMED — check it first.** **Migration ledger 57 — UNCHANGED for two units.** Suite **2743 / 146**. Visual gate **28/28 at 0.0000%** after the declared `05-gcm` adoption. In flight: nothing. **Next: CAT-NOTE's PRINT half → EQUIP-LIST-PARITY → ROADMAP-REFACTOR, and nothing else until the first two are finished.***
