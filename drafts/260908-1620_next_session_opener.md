# NEXT SESSION OPENER — Cowork-Arch, MAIN LINE

**Written 2026-09-08 at the close of the session that shipped FIELD-CONTRACT's first two legs — the census at `44e206d` and FIND-PARITY at `1276cc4` — turned the field contract from an intention into 83 measured cells across seven surfaces, had FOUR of its own §1 claims corrected by CC, and folded in a VERHIST scope whose payload estimate it corrected by 3×.**

**⚠ THE ROLLOVER IS NOT DUE. The log stands at 9 and fires at 10.** Last archived 2026-09-01. **This session's close will trip it, so expect to run it at the open AFTER this one.**

---

## 0 · SEAT CHECK

Cowork, three mounts reachable: `Minotaur` · `Minotaur-Cowork` · `Minotaur_v1_exports`. **If not, STOP and say so.**
**Mounts do NOT persist between sessions — expect to grant all three at open.** They live at `~/Developer/Minotaur`, `~/Developer/Minotaur-Cowork`, `~/Minotaur_v1_exports`.

No parallel session is live. **CC is IDLE. Nothing is in flight.**

## 1 · READ ORDER

`Architecture_Prompt_v34.md` → `Minotaur_v2_Roadmap_v4_24.md` (WHOLE) → `Minotaur_v2_Session_Log.md` (STATE OF PLAY + the Sep 8 morning–afternoon entry) → this opener → then, **on citation only**, the Ledger's **Sep 8 NINTH append**, `docs/reference/field-contract-census.md` in the code repo, and `drafts/260908-1150_boxband-dupkey_measurement.md`.

⚠ **THE ROADMAP'S SHAPE IS UNCHANGED** — v4.23's three tables (RM-8) stand and every row was carried verbatim again. **Seven rows are new** and **VERHIST is split out of LIC-NOV and promoted**. **No row retired; the index is unchanged at 26.**

**Verify state from files, never by running git.** **⚠ Read `.git/refs/heads/main` — NOT `.git/packed-refs`, which carries `be0769de`, twenty-two commits stale, and is also the frozen-gate baseline so it looks plausible.** HEAD should read **`1276cc4`**, origin identical. **Migration ledger 57** — live-read it and byte-match; last version `20260901043028`. **⚠ UNCHANGED FOR SEVEN UNITS — do not assume 58.** Suite **2908 across 151**. `CLAUDE.md` **109,135**, 40,865 under.

⚠ **NOTHING IS OWED ON THE CODE REPO** — `1276cc4` is pushed and origin-identical. **The Cowork docs push from this close may still be owed; the commands are in the Session Log's next-action block.** If `Minotaur-Cowork/.git/refs/heads/main` still reads `0242174`, say so plainly and do not start a unit on top of an uncommitted close.

⚠ **A PUSH TO `main` IS A PRODUCTION DEPLOY.** FENCE-PUSH is live: a bare `git push` is CC's on `COMMIT APPROVED:`, and Vercel builds every push.

## 2 · THE FIRST UNIT IS FIELD-CONTRACT LEG 3, AND IT OPENS ON TWO RULINGS

**Legs 1 and 2 are shipped and gated. Leg 3 is the repairs, and every item in it was measured rather than recalled.**

⚠ **ASK THESE TWO BEFORE SCOPING — the census put them to Daniel and he has not answered:**
1. **`box_number` or `number`?** One concept, two spellings. The rekey already made the marker, the registry and the find map agree (and fixed a live ⌥⇧F defect doing it), but **which spelling is correct is unruled.**
2. **Do boxes and bundles join the contract?** Both are censused and in the test today, marked OUTSIDE the ruled five. **Saying no costs one line each.**

**What leg 3 carries:**

- ⚠ **THE MODEL GAP, and it is one attribute in one array.** The model band editor wears `data-find-field="model"` (`EquipmentListClient.tsx:3453`); **three of the four equipment resolvers already read it. Exactly one cannot — `captureFocusedField` (`:1244`, `:1259`)** — which is why ⌥⇧D from Model lands nowhere. ⚠ **`data-equip-field` is NOT the fix:** `AM-3` (`:373-376`) kept it off the band editors deliberately, because Enter-advance reads that attribute. **The question is whether `captureFocusedField` should read the find attribute — not whether the split should exist.** That resolver also serves ⌥⇧↑↓ and the single-record delete.
- **AUTOCOMPLETE-NOPORTAL** — `portalDropdown` on 24 call sites and on ZERO equipment ones (`EquipmentItemRow.tsx:745`, `:805`; `EquipmentListClient.tsx:2808`, `:2860`, `:3315`, `:3457`). Daniel's cut-off dropdown; the component's own comment says the portal exists for exactly this.
- **CABLE-FINDDEFAULT** — `CableListClient.tsx:476` reads `[data-b2-field]` only, so the seven inspector fields FIND-PARITY made findable cannot seed ⌥⇧F from focus. **Created by succeeding.**
- **CABLEGROUP-EDITOR** — a bundled cable's Group becomes inherited text (Daniel, 2026-09-08). The find half already shipped.
- **CHANGEALL-NAALIAS · CHANGEALL-METHODDOCTRINE · BOXBAND-DOCTRINE** · the four **CDMX-DEFERRED** cable findings · the steck marker/column split · the library's missing Tab order · the two uncited Change All refusals.

**Then: DARKMODE-PASS. Then MMM-CAT or BATCH-HOUSEKEEPING. VERHIST once ruled.**

## 3 · ⚠ RULINGS OWED BY DANIEL — ask, batch them, do not infer them

**VERHIST, five from the parallel plus two Arch added, and they gate a Trigger B migration:**

1. **R-V1** restore is fork-only ("Open as new production") for the first cut · **R-V2** hourly with skip-if-unchanged, retention per §4 pending LEGAL-SEP · **R-V3** automatic snapshot before Change All / Delete Found / Delete All / import apply, plus a manual Save version · **R-V4** History lives in ⚙ PROJECT → History with one action · **R-V5** sequencing after DARKMODE-PASS. *(Arch leans yes on all five; R-V5 is the one worth pushing on, since VERHIST-MIG is itself gated on APPLY-TIMEOUT.)*
2. ⚠ **ARCH'S ADDITION 1 — IF THE SNAPSHOT FAILS, DOES THE DESTRUCTIVE GESTURE PROCEED?** The parallel put APPLY-TIMEOUT only on the restore. **The snapshot has the same 8-second exposure and it sits in front of Change All.** Arch's position: **NO — refuse the gesture and say why.** A net the operator believes is there and is not is worse than none.
3. ⚠ **ARCH'S ADDITION 2 — HAS APPLY-TIMEOUT'S PIN LAPSED?** It was pinned *"behind the CDMX work"* and **CDMX-SEQUENCE is discharged.** One word unblocks **2-MIG-c AND VERHIST's restore path** together.

**Also owed, none blocking:** the **BOXBAND-DUPKEY band-identity ruling** · **CATCOUNT-COLUMN · EQUIPLIST-DOTRULE · EQUIPLIST-CLMARGIN · BUNDLE-LINK-IMPORT** · the rulings-list relocation question.

## 4 · OWED BY DANIEL — the two unrun acceptances, and one new one

1. **Hold a printed 5167 sheet against a real Avery blank.** Deferred 2026-08-31, still owed. **An unrun acceptance on a shipped unit**, and five outputs are built on that die.
2. **The Tail Panel reprint**, owed since PANEL-CLIP — verified by DOM and PDF extraction only, which is not parity evidence for the printed page.
3. ⚠ **NEW — a browser sweep of the 21 unchecked find fields.** See §6.

Then, all pinned: a fresh **v1 Bundle Summary** print · **OQ-B** one more Box-in-Box card · three **box** print reprints · a v1 export from a show that uses **cable SPLITS** · **STRAT-record entries** · METRIC-UNRUN's browser gate · CAND-4 (**overdue**) · **LEGAL-SEP is September — now, and VERHIST's retention window belongs in it** · GIT-CFG's remainder · Big Cable Labels' stock assignment. **Also his to clear:** `Minotaur-Cowork/_to_delete/260906_arch-stray-outputs/`, and the untracked `Claude outputs/` and `docs/reference/evidence/equipment/` in the code repo.

## 5 · ARCH'S OWN, NOT RULED YET

- **⚠ FENCE-FORMS.** The ruled list of forms to block is a description being patched one spelling at a time by reading rather than testing. **TEST THE GUARD, DO NOT READ IT.** ⚠ **New sighting: `node -e '…m => m[1]…'` was BLOCKED as "redirect target 'm[1]'" — the matcher reads a JS arrow's `>` as a shell redirect.** It will recur for any inline `node -e` containing `=>`. A false POSITIVE this time, which is the other failure direction and belongs in the battery.
- **⚠ EQUIPLIST-WHOEST · REVGROUP-SPLIT · 2-MIG-c · CORPUSBOUND-AUDIT** — unchanged, all Arch's.
- **PROJECT-NAME-NOT-UNIQUE's harness fix** — `scripts/visual-capture.mjs:122` finds its fixture by name, `.first()`, substring. **Never "fix" it by making the name unique.**

## 6 · ⚠ THE HAZARD THIS SESSION LEAVES LIVE

**FIND-PARITY IS PROVEN BY STATIC ANALYSIS ONLY.** The contract test proves the four structures agree. **It proves nothing about what any of the 25 new fields does when typed.** Daniel's gate covered **four** checks on **one** project; **21 fields are live across seven surfaces unchecked at the keyboard.** ⚠ **A wrong accessor returns an EMPTY FIND, which an operator reads as missing data rather than as a defect.** (FINDPARITY-UNTYPED.) **Put the sweep to him early — it is ten minutes and it is before CDMX leans on it.**

## 7 · DO NOT RE-DERIVE, AND DO NOT REPEAT

- **⚠ AN INSTRUMENT MUST NOT INHERIT THE CLAIM'S PARAMETERS — CENSUS THE CLASS, THEN NARROW.** *Earned again, on this seat: three universal negatives ("does not exist anywhere in `src/`") were asserted from a grep for TWO attribute names, on a surface carrying THIRTEEN. One of them was contradicted by Arch's own grep output at the moment it was written.* Same shape as the CATNOTE-RULE `linewidth >= 2.0` probe. **Fifth occurrence; second to reach a handoff.**
- **⚠ A RULE WHOSE ONLY HOME IS THE THING THAT GETS THROWN AWAY HAS A DELETION DATE ON IT** — and the corollary now has a second instance: **`handoffs/` IS GITIGNORED. The git index carries ZERO handoff files.** Anything measured in a return dies with the working tree unless Arch carries it into the Ledger, the Roadmap or `drafts/`.
- **⚠ A BAND'S IDENTITY MUST BE THE COMPARATOR'S EQUALITY CLASS, NOT THE RAW STRING IT DISPLAYS.** (BOXBAND-DUPKEY.) **And never fix it with a unique React key** — that silences the warning and leaves two bands the sort believes are one.
- **⚠ GRAPH-BEATS-RERUN CAPS AT TWO RUNS, AND THE GRAPH IS THE STRONGER INSTRUMENT.** A fourth visual run was declined this session rather than asked to overrule an import graph that had already settled the question.
- **⚠ THE GATE RUNS WHERE CC CANNOT SEE IT.** CC refused twice to infer it — once from silence, once from a green machine gate. **Relay Daniel's words VERBATIM into the CLOSE.txt.** A green machine gate is not consent.
- **⚠ ARCH CANNOT RUN THE TEST SUITE FROM THIS SEAT.** The mount is macOS and `device_bash` is Linux, so `node_modules`' native bindings will not load. Suite verification is CC's or Daniel's; the seat can corroborate the FILE count independently.
- **⚠ ARCH CAN READ THE DATABASE WHEN CC CANNOT.** HARNESS-RLS-CORPUS makes the parity corpus invisible to any harness CC drives; the Supabase MCP at this seat is not subject to it. **That is the one measurement this seat can take that CC cannot — use it.**
- **⚠ EVERY CITATION OF A PROJECT NAMES AN ID.** `cf780353-448d-4b15-a054-973f577b215c` Mexico City · `57874c69-06b6-41b1-91d8-6a00e5255110` US Tour · `dbf56057-0447-41a9-81b1-a8842a83b958` Cable Parity Fixture.
- **⚠ `docs/reference/v1_ddr.xml` IS UTF-16LE** and states NO TAB ORDER anywhere. **Do not search again.**
- **⚠ HASH-FREEZE-LABELS. `labels_done` STAYS. APPLY-TIMEOUT is measured and PINNED — but see §3.3.**
- **Do not re-litigate:** the RPC route · blank-for-0 on export · the folder-label ORDER · the palette · the Avery stock assignments · **Q-1…Q-4 · OQ-1…OQ-5** · the spend cap ON · CONTRAST-PAIR · MENU-DEPRECATE · **CATNOTE-CELL · CATNOTE-AUTOSIZE · EQUIP-LIST-FULLSIZE · NOTE-GROUPING · CONTCAT-DIVERGE · CONTCAT-SIZE**.

## 8 · NOT THIS SESSION

Everything behind leg 3 and DARKMODE-PASS — **APPLY-TIMEOUT** · EQUIPLIST-ESTIMATE-PAGINATOR's conversion · EQUIPLIST-WHOEST · REVGROUP-SPLIT · FENCE-FORMS · WAITLIST-NOTIFY · DEEP-ARCHIVE · GATE-THEMEGLYPH · S4-late · EXPORT-HISTID-DROP · the eight queued layouts · DEVICE-FK-LINK · Big Cable Labels · **CAPFLAKE-LIBLIGHT, which is H3's**.

## 9 · CONDUCT — what this session's record says

1. **Split the unit before building it when the surface has not been counted.** The census cost one deploy and caught four wrong Arch claims on its first pass.
2. **Let the instrument name the work.** FIND-PARITY's assertion was written first and run against the unmodified tree; the failure list WAS the scope. A ruling became a machine check rather than a list Arch typed.
3. **Check the cheap thing before recommending the expensive one.** The checkbox ruling looked like an engine change; `flagFace` was already exported and already in use.
4. **A better control, declared, beats the one that was asked for.** CC substituted a static control plus an executable reproduction and said so.
5. **Count what a cap counts — including in the close itself.** This close first wrote "rollover due at the next open" and was wrong by one; the rule reads the LIVE log, which stands at 9.

---

*Governing set at this close: **Arch v34** + `Architecture_Provenance.md` · **Roadmap v4.24** (retires v4.23) · Ledger v1.0 (Sep-8 NINTH append) · **`CLAUDE.md` at 109,135 characters, 40,865 under** · Session Log at **9**, rollover CLEAR and not due next open. HEAD **`1276cc4`**, pushed, origin identical — **nothing owed on the code repo**. **Migration ledger 57 — UNCHANGED for seven units.** Suite **2908 / 151**. Visual gate **28/28 at 0.0000%**. In flight: nothing. **Next: FIELD-CONTRACT leg 3, which opens on two rulings — and VERHIST is waiting on seven.***
