# NEXT SESSION OPENER — Cowork-Arch, MAIN LINE

**Written 2026-09-05 at the close of the session that shipped CHANGEALL-FOUNDSET at `ba0058f`, applied the migration that made it possible (ledger 56 → 57), ran the Session Log rollover, recovered a machine shutdown mid-run without losing anything, and took Daniel's ruling that the roadmap now serves BUENA VISTA SOCIAL CLUB, MEXICO CITY.**

**⚠ THE ROLLOVER IS NOT DUE. The log stands at 3 and fires at 10. Last archived 2026-09-01.**

---

## 0 · SEAT CHECK

Cowork, three mounts reachable: `Minotaur` · `Minotaur-Cowork` · `Minotaur_v1_exports`. **If not, STOP and say so.**
**Mounts do NOT persist between sessions — expect to grant all three at open.** They live at `~/Developer/Minotaur`, `~/Developer/Minotaur-Cowork`, `~/Minotaur_v1_exports`.

No parallel session is live. **CC is IDLE. Nothing is in flight.**

## 1 · READ ORDER

`Architecture_Prompt_v34.md` → `Minotaur_v2_Roadmap_v4_18.md` (WHOLE) → `Minotaur_v2_Session_Log.md` (STATE OF PLAY + the Sep 1–5 entry) → this opener → then, **on citation only**, `drafts/260905_daniel-gate-findings-and-bvsc-mx-redirect.md` (**the sharpest document for the opening unit — every number below is in it**), `drafts/260901_changeall-foundset_rpc_design_and_rehearsal.md`, and `handoffs/from-cc/260901-0824_changeall-foundset.md`.

**Verify state from files, never by running git.** **⚠ Read `.git/refs/heads/main` — NOT `.git/packed-refs`, which carries `be0769de`, now FIFTEEN commits stale, and is also the frozen-gate baseline so it looks plausible.** HEAD should read **`ba0058f`**. **Migration ledger 57** — live-read it and byte-match. Suite **2679 across 142**.

**⚠ Production READY is NOT seat-verifiable** — `scripts/vercel-preopen.mjs` needs a token the Cowork seat cannot reach. Say so rather than asserting a deploy state.

**⚠ THE APPROVAL PHRASE IS A PRODUCTION DEPLOY.** FENCE-PUSH is live: a bare `git push` is CC's on `COMMIT APPROVED:`, and Vercel builds every push to `main`.

**Pre-open drift check:** confirm `Minotaur-Cowork` carries this close. **The previous session ended with four days of gated work uncommitted — check both repos, not just one.**

## 2 · FIRST ACTION — CHANGEALL-BOXNULL. IT IS LIVE DATA LOSS AND IT IS SMALL.

**Measured 2026-09-05 at source — do NOT re-derive:**

`EquipmentListClient.tsx:2368-2372` — the box arm of Change All reads **`sourceRow.box_id`, the STORED value, and ignores the typed draft entirely**:

```js
} else if (field === 'box_name') {
  const boxId = sourceRow.box_id ?? null
  dbPatch = { box_id: boxId }
```

The capture path never resolves a box draft. **`category_name` gets resolve-or-revert (`:2277`) · `method_name` gets `planMethodChangeAll` (`:2335`) · box gets NEITHER** and falls through the plain-text branch that updates `box_name` while leaving `box_id` untouched.

- **A new box name on a BOXLESS row → `box_id: null` across the entire found set.** This is what Daniel saw.
- **A new box name on a row that HAS a box → the OLD box id replicated to every row.** No blank, no error, wrong box everywhere — **quieter and worse, and nobody has looked for it in the data yet.**

**⚠ IT IS NOT A REGRESSION FROM CHANGEALL-FOUNDSET.** That unit changed the transport; this is the payload, and the arm sits in the same if/else chain as METHODNEW's own comment. **It is `e3a336a`-era and live in production right now.**

**⚠ THE FIX SHIPS ONLY BEHIND A NEGATIVE CONTROL THAT REPRODUCES THE BLANKING.** The template is one branch over: CHANGEALL-METHODNEW's control passed at first because it used the toolbar button, whose `mousedown` commits the cell first. **Only ⌥⇧\ exposed it.** A control that passes is not a control.

**⚠ AND THERE ARE TWO CLAIMS IN DANIEL'S SENTENCE — SEPARATE THEM BEFORE DESIGNING.** The blanking is a defect. The absent **new-box dialog** may be correct as built: **box creation is ⊕-only by deliberate doctrine** (`:1900-1912`, in the band editor's own comment). Creating a box from the cell is a **NEW RULING**, not a bug — and **CHANGEALL-METHODDOCTRINE should answer first**, since equipment/method now creates while cable/method reverts and box reverts everywhere. **Put that ruling to Daniel in plain language before writing any code.**

## 3 · THEN — and the order is Daniel's ruling, not a preference

**FIELD-CONTRACT, WIDENED TO FIND** — *"Look at every field in every layout to verify search works and change all works, like v1"* (Daniel, 2026-09-05). All five list surfaces in ONE unit, every editable cell, and now **the Find vocabulary as well as Change All**, with a test that fails when a rendered cell is absent from either.

**⚠ The steck field is the proving case and its mechanism is MEASURED — do not re-derive:** `CHANGE_ALL_FIELD_LABELS` (`src/lib/cable/cableChangeAll.ts:48-64`) holds **fifteen** fields and neither steck; the gate at `CableListClient:3112` drops the cell and says so at `:3121`; and the marker `source_steck` does not share a name with the column `source_steck_count` — **two vocabularies, one field.** `CableRow.tsx:62` records the original intent (click-entry only, outside the ruled tab order) and **that exclusion carried unexamined into both features.**

Then, in Daniel's stated priority order for **BVSC-MX**:

**CAT-NOTE** — a note attached to a **CATEGORY**, printed between the heading and its first item, **more than one per category**. ⚠ **The data half can start; the PRINT half is BLOCKED — BVSC NY carries ZERO category notes across 125 headings (instrument proved first), so a fresh v1 print from a show that uses them is owed.** ⚠ **Not the existing item-level notes** — those already exist as indented sub-lines under items.

**CAT-ADMIN** — rudimentary category management. **Copy `MethodsAdminClient.tsx`; do not invent.**

**EQUIP-LIST-PARITY** — the equipment list **and its cover letter**, one measured scale. ⚠ **The "75%" is Daniel's recollection, not a measurement — measure the real ratio off a matched v1/v2 pair (PDF-CHROME-PATH) before anything is scaled.** ⚠ **EQUIPVIEW-UNSAFE must not be discovered mid-build:** `v_equipment_list` does not filter `type` and exposes `ip_address` while hiding `address` — populated on **261** rows against `ip_address`'s **1**, and v1's equipment output prints Address.

**Pinned, not dropped (BVSC-MX):** CHANGEALL-NAALIAS · CHANGEALL-METHODDOCTRINE · CREATEMETHOD-BLINDERR · RLS-INITPLAN · MARKER-OVERHANG's fix · SMALLNAME-STEP · the three measured-but-unbuilt cable documents · BOX-DOC-PARITY · BOXLABEL-ZERO · CORPUSBOUND-AUDIT · 2-MIG-c · LINT-DEAD · EVIDENCE-UNTRACKED · FENCE-HEREDOC.

## 4 · OWED BY DANIEL

1. **Hold a printed 5167 sheet against a real Avery blank.** Deferred 2026-08-31, still owed. **It is the only unrun acceptance on a SHIPPED unit**, and five outputs are being built onto that die.
2. **A fresh v1 print from a show that USES category notes** — print-to-PDF at 100% through Chrome's own destination. **CAT-NOTE's print half cannot be specified without it.**
3. **A ruling on the new-box dialog** — should a box be creatable from the cell, or does ⊕-only stand?
4. **A ruling on CHANGEALL-NAALIAS** — a typed `0` in Method now creates a method literally named `0`; `Cable Parity Fixture` already carries methods named `0` and `i` from the import.
5. **Clear the fixture's browser-gate residue** — four Grey methods with zero rows (`Rent-SAI`, `Rent-Taco`, `Rent-Burrito`, `Rent-Moose`), `Samburg` on 1 row, 1 row with an empty Method.

Then: the **Tail Panel reprint** owed since PANEL-CLIP · a fresh **v1 Bundle Summary** print (BUNDLESUM-MARKS) · **OQ-B** one more Box-in-Box card · **OQ-3's optional confirmation** · delete BVSC NY's two junk boxes · three **box** print reprints · a v1 export from a show that uses **cable SPLITS** · a **STRAT-record entry retiring WF-1's push clause** and **one for the Pro upgrade** · METRIC-UNRUN's browser gate · CAND-4 · GIT-CFG's remainder · **Big Cable Labels' stock assignment**.

**Discharged 2026-09-05: the CHANGEALL-FOUNDSET commit and push · the browser gate that found BOXNULL and the steck gap.**

## 5 · DO NOT RE-DERIVE, AND DO NOT REPEAT

- **⚠ CHANGEALL-BOXNULL's mechanism is MEASURED — §2 has the lines. Do not re-measure it; DO reproduce it with a negative control before fixing it.**
- **⚠ The steck mechanism is MEASURED — §3 has it. Do not re-derive; do check v1's behaviour against the DDR before building.**
- **⚠ CHANGEALL-FOUNDSET's ceiling is BYTES, ~25.0 KB, and has been measured at TWO different row counts by two instruments (581/582 Arch; 582 passing on CC's JWT). Do not record a row count as the fact.**
- **⚠ AFTER AN INTERRUPTION, THE TREE IS EVIDENCE AND THE RUN'S MEMORY IS NOT.** Verify from files; never resume on a summary; never rebuild what measurement says is already correct.
- **⚠ A CONTROL THAT ONLY CHECKS FOR ABSENCE CANNOT TELL "ROLLED BACK" FROM "NEVER RAN."** A residue check wants a positive control.
- **⚠ A GUARD OVER ZERO FILES ALWAYS PASSES**, and a guard one byte can silence is not a guard (GREP-NULBYTE).
- **⚠ A CLOSE THAT ENDS WITH AN UNCOMMITTED TREE HAS NOT ENDED.** Four days of gated work sat on one laptop while the database ran ahead of it.
- **⚠ A SUMMARY IS A SURFACE.** Two Arch counting errors this session were in prose that contradicted the enumerated list beside it. **The Surface Rule binds our own documents.**
- **⚠ A FEATURE THE CORPUS DOES NOT EXERCISE CANNOT BE BUILT AGAINST THE CORPUS.** Prove the instrument, then report the absence — `pdftotext` extracted 58,996 characters and 125 headings before "no category notes" was written down.
- **⚠ A CONTROL THAT PASSES IS NOT A CONTROL** · **A THRESHOLD RECORDED IN THE WRONG UNIT GOES STALE SILENTLY** · **A GOVERNING DOCUMENT'S FOOTER BUMPS WITH ITS H1 AND FILENAME** · **A SHAPE SHARED WITH v1 IS NOT A BEHAVIOUR SHARED WITH v1** · **THE SOURCE STATES INTENT; THE ARTIFACT STATES BEHAVIOUR** · **NAME THE BEHAVIOUR, NOT THE SYMBOL** · **DEAD-CODE-IS-NOT-SAFE** · **GATE-NOGREP** · **TEST THE GUARD, DO NOT READ IT**.
- **⚠ HASH-FREEZE-LABELS. `labels_done` STAYS** — one of `computeRowHash`'s frozen fourteen, proven by a real second import at 1,368 of 1,368 matched and zero minted. Its removal is LABELSDONE-RESIDUE, a separate ruled destructive step.
- **⚠ `docs/reference/v1_ddr.xml` IS UTF-16LE** — a byte-oriented grep finds nothing; read via `iconv -f UTF-16LE`. **It states NO TAB ORDER anywhere.** Do not search again.
- **⚠ `Cable Parity Fixture` and `Matched Pair Fixture` are RLS-invisible to any harness CC drives.** Counts come from a labelled reproduction on a throwaway, from Daniel, or from this seat's own database reads.
- **⚠ Never re-import into BVSC NY** — 1,119 INSERTS, doubles the show.
- **Do not re-litigate:** the RPC route · the separate-units ruling · HASH-FREEZE-LABELS · blank-for-0 on export · the folder-label ORDER · the palette (v2 colours everywhere, Black `#000000`) · the Avery stock assignments · **Q-1 · Q-2 · Q-3 · Q-4 · OQ-1 · OQ-2 · OQ-3 · OQ-4 · OQ-5** · the spend cap ON · CONTRAST-PAIR · MENU-DEPRECATE · BUNDLE-LINK-IMPORT · **the row count staying off the screen** (uncited = unbuilt).

## 6 · NOT THIS SESSION

CONTRAST-PAIR · WAITLIST-NOTIFY · DEEP-ARCHIVE · GATE-THEMEGLYPH's diagnosis · the `0` vocabulary-row fold · S4-late · EXPORT-HISTID-DROP · the eight layouts' BUILD (**except EQUIP-LIST-PARITY, which BVSC-MX promotes**) · DEVICE-FK-LINK · **FENCE-HEREDOC** · **Big Cable Labels**.

## 7 · CONDUCT — what this session's record says

1. **Read the file before asserting its state — including our own documents.** Both Arch errors this session were prose contradicting an enumerated list in the same document.
2. **When a run is interrupted, measure the tree; do not trust the run and do not rebuild.** Eight minutes of verification replaced a 32-minute rebuild that would have risked undoing correct work.
3. **Prove the instrument before reporting an absence.** 58,996 characters and 125 headings extracted first; only then "BVSC NY has no category notes."
4. **A residue check wants a positive control.** 359 rows carrying real values is what proved the rollback ran.
5. **Put the plain-language version first when a ruling is Daniel's.** The chunk-versus-RPC ruling landed in one word because the deciding reason — *a delete that half-completes is gone* — was written in plain terms.
6. **Daniel's gate has now found what the machine gates could not SEVEN times running.** Budget for a gate round, and **run it BEFORE the approval phrase, because the phrase deploys** (GATE-BEFORE-COMMIT — honoured this session).
7. **Finish the close by finishing the commit.** This session's own lesson.

---

*Governing set at this close: **Arch v34** + `Architecture_Provenance.md` · **Roadmap v4.18** (retires v4.17) · Ledger v1.0 (Sep-5 append) · `CLAUDE.md` current at `ba0058f` · Session Log at **3, rollover CLEAR**. HEAD **`ba0058f`**, pushed. **Migration ledger 57.** Suite **2679 / 142**. Visual gate **28/28 at 0.0000%, 6 px on one registered wander site, no baseline event.** In flight: nothing.*
