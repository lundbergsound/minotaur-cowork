# NEXT SESSION OPENER — Cowork-Arch, MAIN LINE

**Written 2026-08-31 23:45 EDT at the close of the session that shipped CHANGEALL-METHODNEW at `e3a336a`, measured CHANGEALL-FOUNDSET into a byte ceiling and reshaped it, split a ruled unit on evidence that did not exist when the ruling was made, verified the `equip.xlsx` re-import end to end, and watched a negative control PASS.**
**⚠ THE ROLLOVER IS DUE. Run it at the pre-open, before anything else. Then this session opens on CHANGEALL-FOUNDSET, properly scoped.**

---

## 0 · SEAT CHECK

Cowork, three mounts reachable: `Minotaur` · `Minotaur-Cowork` · `Minotaur_v1_exports`. **If not, STOP and say so.**
**Mounts do NOT persist between sessions — expect to grant all three at open.** They live at `~/Developer/Minotaur`, `~/Developer/Minotaur-Cowork`, `~/Minotaur_v1_exports`.

No parallel session is live.

## 1 · ⚠ ROLLOVER — DUE. RUN IT AT THE PRE-OPEN.

Session Log stands at **9 entries**; rollover fires at 10. Last archive `Session_Log_Archive_2026-08-27.md`.
**Pause and run it before any work:** say so → deliver the archive (oldest 8 entries, frozen, byte-exact, `Session_Log_Archive_YYYY-MM-DD.md` → `session-log-archives/`) → deliver the fresh log (header carried over, count reset, Rollover "clear", most recent 2 entries retained; the fresh file REPLACES the live log) → **wait for Daniel's confirm before installing either.** Overwriting the live log IS the install. (O-10.)

## 2 · READ ORDER

`Architecture_Prompt_v34.md` → `Minotaur_v2_Roadmap_v4_17.md` (WHOLE) → `Minotaur_v2_Session_Log.md` (STATE OF PLAY + the Aug-31 late-evening entry) → this opener → then, **on citation only**, `drafts/260901_changeall-foundset_error-captured.md` (**the sharpest document for the unit — every number below is in it**), `handoffs/to-cc/260831-2212_changeall-methodnew.md`, `handoffs/from-cc/260831-2258_changeall-methodnew.md` and its `_CLOSE.txt`.

**Verify state from files, never by running git.** **⚠ Read `.git/refs/heads/main` — NOT `.git/packed-refs`, which carries `be0769de`, now FOURTEEN commits stale, and is also the frozen-gate baseline so it looks plausible.** HEAD should read **`e3a336a`**. **Migration ledger 56 — it did NOT move last session.** Suite **2634 across 140**. **CC is IDLE. Nothing is in flight.**

**⚠ Production READY is NOT seat-verifiable** — `scripts/vercel-preopen.mjs` needs a token the Cowork seat cannot reach. Say so rather than asserting a deploy state.

**Pre-open drift check:** `Minotaur-Cowork` sat at **`5239def`** when this close was written. **This close is not in it.** Confirm whether Daniel has committed and pushed it.

**⚠ THE APPROVAL PHRASE IS A PRODUCTION DEPLOY.** FENCE-PUSH is live: a bare `git push` is CC's on `COMMIT APPROVED:`, and Vercel builds every push to `main`.

## 3 · FIRST ACTION — CHANGEALL-FOUNDSET, AND IT IS TWENTY-PLUS CALL SITES, NOT ONE

**⚠ THE NAME IS A MISNOMER, RETAINED ONLY SO EXISTING CITATIONS RESOLVE. It is not the found set and it is not the database.**

**Measured 2026-09-01 from the Arch seat — do NOT re-measure any of this:**

- A rejected call returns a bare **`400`, body `Bad Request`, NO `server` header** — rejected at the **edge, before PostgREST**. A passing call returns PostgREST JSON with `server: cloudflare`.
- **581 quoted ids pass / 582 fail** (22,741 → 22,780 chars). **676 unquoted pass / 677 fail** (25,094 → 25,131). **Same ≈25.0 KB wire ceiling — it is BYTES, not rows** (supabase-js quotes each uuid; the browser encodes `"` as `%22`, 43 wire bytes against 37). **The budget is shared with every header, so a real session JWT lowers it.**
- **The database is exonerated: 1,368 rows update in 62.6 ms** as `authenticated`, rehearsed inside a forced rollback with a clean residue check. **`statement_timeout` is 8s and was never close.**
- Corroborated independently by the **empty `{}` error object** in Daniel's live console.

**⚠ THE OPENING RULING, AND IT DECIDES WHO DOES THE WORK.** Two routes:

- **(A) Chunk the ids client-side.** No migration, CC's. **Costs atomicity** — N requests, and a failure at request 4 leaves 1–3 written while the optimistic revert restores *all* ids, so the screen would disagree with the database. **Needs a deliberate partial-failure story, and it must land as a shared helper, not a local patch.**
- **(B) One RPC taking the id array in the POST body.** No ceiling ever, one statement, one transaction, atomic — and **62.6 ms measured**. But it is a schema change: **Trigger B, rehearsal-first, Arch's, and it cannot ride inside a CC run.** **It is also the only route that fixes the deletes.**

**Put that ruling first, then get out of the way.**

**⚠ THE CALL SITES — swept 2026-09-01, and a fix landing only in `runPlainChangeAll` fixes one of them.**
`EquipmentListClient:1830 · 2115 · 2141` · `CableListClient:875 · 891 · 914 · 920 · 939 · 1911 · 1913 · 3035 · 3339 · 3544` · `LineListClient:1119` · `TailListClient:790` · `EquipmentLibraryClient:322` · `BoxListClient:879 · 889 · 915 · 1269`.
**⚠ FIVE `.delete()` ON THE SAME SHAPE:** `TailListClient:670` · `CableListClient:2880 · 3007 · 3043` · `BoxListClient:1089`. **A delete that silently does nothing above the ceiling is worse than an update that flashes red, and none of these has ever been tested above ~582 rows.**
**⚠ `BundleListClient.tsx` READS AS BINARY TO GREP** (the CONTRAST-PAIR rider) and is **unswept** — sweep it with a different instrument before scoping, or the scope is wrong by however many sites it holds.

**⚠ Two things that must not be discovered mid-build.** `updateItem` is in the FROZEN gate (`EquipmentListClient.tsx` vs `be0769de`, 1125 chars) — **frozen-layer contact is a CC hard-stop.** And several of these surfaces are captured gate frames, so a UX-visible change is a **declared baseline event**: CC measures which frames move, Arch does not predict.

## 4 · THEN

**FIELD-CONTRACT** — RULED, all five list surfaces in ONE unit (equipment · cable · lines · tails · library), with its three banked findings and `num_labels`'s real Tab position. **It now also owns CHANGEALL-METHODDOCTRINE** (below).

· **CHANGEALL-NAALIAS** (needs Daniel's ruling first) · **MARKER-OVERHANG's fix** (v1 wraps; we do not) · **SMALLNAME-STEP** (48 pt to 17 chars, 36 pt from 18) · **the three measured-but-unbuilt cable documents** — Cable Checklist (bottom margin 15.80 vs v1's 45.52) · Tail Checklist (row pitch 24.75 vs 26.00) · Bundle Sheets (right margin 27.00 vs 61.04), banked in `cableGeometry.ts`, one unit not three · **BOX-DOC-PARITY** · **BOXLABEL-ZERO** · **OQ-4's cut rules** and the staged box residuals · **BUNDLE-LINK-IMPORT** (reader first, flags second) · **2-MIG-c** without the split arm · **CORPUSBOUND-AUDIT** · **CREATEMETHOD-BLINDERR** · **RLS-INITPLAN** · **the small clearing unit** · **Equipment Labels** — ⚠ **now UNBLOCKED, the re-import is done and verified** · **CABLE-SPLIT's Trigger A block** once a corpus with splits exists.

## 5 · OWED BY DANIEL

1. **Hold a printed 5167 sheet against a real Avery blank.** Deferred 2026-08-31, still owed. **It is the only unrun acceptance on a SHIPPED unit**, and five outputs are being built onto that die.
2. **A ruling on CHANGEALL-NAALIAS** — a typed `0` in Method now creates a method literally named `0`. **Not hypothetical: `Cable Parity Fixture` already carries methods named `0` and `i` from the import.** Both the Change All arm and the band editor's bulk arm want the same fix in the same pass.
3. **Clear the fixture's browser-gate residue** — four Grey methods with zero rows (`Rent-SAI`, `Rent-Taco`, `Rent-Burrito`, `Rent-Moose`), `Samburg` on 1 row, and 1 row with an empty Method.

Then: **the Tail Panel reprint** owed since PANEL-CLIP · a fresh **v1 Bundle Summary** print (BUNDLESUM-MARKS) · **OQ-B** one more Box-in-Box card · **OQ-3's optional confirmation** · delete BVSC NY's two junk boxes · three **box** print reprints · a v1 export from a show that uses **cable SPLITS** · a **STRAT-record entry retiring WF-1's push clause** and **one for the Pro upgrade** · METRIC-UNRUN's browser gate · CAND-4 · GIT-CFG's remainder · **Big Cable Labels' stock assignment**.

**Discharged 2026-08-31 (late): the `equip.xlsx` re-import, verified end to end · the browser gate for CHANGEALL-METHODNEW · the separate-units ruling.**

## 6 · DO NOT RE-DERIVE, AND DO NOT REPEAT

- **⚠ CHANGEALL-FOUNDSET's ceiling is MEASURED — §3 has every number. Do not re-measure it, and do not record a row count as the fact.**
- **⚠ A CONTROL THAT PASSES IS NOT A CONTROL.** CC's first negative control ran the toolbar button, whose `mousedown` reaches `AutocompleteInput`'s outside-click handler and **commits the cell first**, auto-creating the method — so pre-fix code passed all four cases. **Only ⌥⇧\ exposes the defect.** A negative control earns its name by reproducing the defect, never by passing.
- **⚠ A THRESHOLD RECORDED IN THE WRONG UNIT GOES STALE SILENTLY.** Record the mechanism and derive the number.
- **⚠ THE SURFACE RULE BINDS OUR OWN DOCUMENTS.** Last session's one shipped Arch error was asserting `CLAUDE.md`'s fence stale from a Docket row **without opening the file — and this seat's own Session Log said it was current.** A Docket row is a measurement with a date on it, not a present-tense claim.
- **⚠ A GOVERNING DOCUMENT'S FOOTER BUMPS WITH ITS H1 AND FILENAME.** v4.16's footer carried v4.15's trailer verbatim for a full session. A stale footer gives orders exactly as a stale run fence does.
- **⚠ HASH-FREEZE-LABELS. `labels_done` STAYS**, produces exactly today's value **including its failure on `"2"`**, and is one of `computeRowHash`'s frozen fourteen. **Do not drop it, do not stop writing it, do not "tidy" the boolean and the integer into one.** Now proven by a REAL second import: 1,368 of 1,368 identity rows matched, zero minted. Its removal is **LABELSDONE-RESIDUE**, a separate ruled destructive step.
- **⚠ A SHAPE SHARED WITH v1 IS NOT A BEHAVIOUR SHARED WITH v1** · **THE SOURCE STATES INTENT; THE ARTIFACT STATES BEHAVIOUR; WHERE THEY DISAGREE THE ARTIFACT WINS** · **NAME THE BEHAVIOUR, NOT THE SYMBOL** · **MOVING A FIELD OUT OF ONE BRANCH'S VOCABULARY WITHOUT GIVING IT ANOTHER** is the defect class CHANGEALL-METHODNULL was.
- **⚠ `docs/reference/v1_ddr.xml` IS UTF-16LE.** A byte-oriented grep finds **nothing**; read via `iconv -f UTF-16LE`. **And it states NO TAB ORDER anywhere** — searched, 0 hits. Do not search again.
- **⚠ RLS-INITPLAN IS NOT CHANGEALL-FOUNDSET's CAUSE.** 53 tables carry unwrapped `auth.uid()` and the linter is right to flag it, but at today's scale it is 62.6 ms. **Do not cite it as the cause.**
- **⚠ STOCK-IS-DIE PROVED A DIE MATCH, NOT A STOCK MATCH.** A low reading on the owed sheet is **new information, not a regression** of `9a333cc`.
- **⚠ LINKGROUP-CORPUS** — do not cite 913/2,036 or 54/210 against BVSC NY until it is explained; live, BVSC NY holds zero.
- **⚠ `gridColumnWidthPx`, `gridColumnHeightPx` and `GridColumns` are DEAD** (DEADEXPORT-GRIDCOL).
- **⚠ `Cable Parity Fixture` AND `Matched Pair Fixture` are RLS-invisible to any harness CC drives.** Counts come from a labelled reproduction on a throwaway, from Daniel, or from the Arch seat's own database reads.
- **⚠ Never re-import into BVSC NY** — 1,119 INSERTS, doubles the show.
- **⚠ Capture-flake entry (2) is NOT dark-only.** Invariant **1451200 px at bbox 0,93–1599,999**. It stays PROSE.
- **Do not re-litigate:** HASH-FREEZE-LABELS · CHANGEALL-METHODNEW's four branches and its live-cache read · **the separate-units ruling** · blank-for-0 on export · the 16 px Labels cell · STOCK-IS-DIE's cell origin · the folder-label ORDER · the palette (**v2 colours everywhere**, Black `#000000`) · the Avery stock assignments · **Q-1 · Q-2 · Q-3 · Q-4 · Q-11 · OQ-1 · OQ-2 · OQ-3 · OQ-4 · OQ-5** · the spend cap ON · CONTRAST-PAIR · MENU-DEPRECATE · BUNDLE-LINK-IMPORT.

## 7 · NOT THIS SESSION

CONTRAST-PAIR · WAITLIST-NOTIFY · DEEP-ARCHIVE · GATE-THEMEGLYPH's diagnosis · the `0` vocabulary-row fold · S4-late · EXPORT-HISTID-DROP · the eight layouts' BUILD · DEVICE-FK-LINK (post-public-beta) · **FENCE-HEREDOC** (needs its own scoping — §4 does NOT contain it, deliberately) · **Big Cable Labels** (blocked on a stock assignment).

## 8 · CONDUCT — what the last session's record says

1. **A checkpoint written as a hard return can often be closed as a measurement instead.** The FOUNDSET error was captured from the Arch seat in twenty minutes — a browser probe and a rolled-back rehearsal — and that turned a return into a finding that reshaped a defect and split a unit.
2. **Write every unmeasured claim as a LEAD that must be proven.** Three leads died at first measurement last session and none reached Daniel as a finding. The one error that shipped was the one claim written as a conclusion.
3. **Check our own documents at source, exactly as we check the code.**
4. **Pre-compute the acceptance number before the measurement.** 150/57/357 was stated before the re-import was read and came back exactly.
5. **Flag a reversal as a reversal, and name why the original ruling held.** The separate-units ruling landed in one turn because the guard it protected was named alongside it.
6. **Put the plain-language version first when a ruling is Daniel's.** The first attempt at the split ruling was refused as unreadable; the second, written in plain terms with the mechanism explained, was ruled in one word.
7. **A green suite is not the acceptance.** Daniel's gate has now found what the machine gates could not **six times running.** Budget for a gate round — **and run it BEFORE the approval phrase, because the phrase deploys** (GATE-BEFORE-COMMIT).

---

*Governing set at this close: **Arch v34** + `Architecture_Provenance.md` · **Roadmap v4.17** (retires v4.16) · Ledger v1.0 (Aug-31 third append) · `CLAUDE.md` **current — CC brought the run fence to measured numbers inside the unit's own commit** · Session Log at **9, ⚠ ROLLOVER DUE at the next pre-open**. HEAD **`e3a336a`**, pushed. **Migration ledger 56, unchanged.** Suite **2634 / 140**. Visual gate **28/28 at 0.0000%, all byte-clean, no baseline event.** In flight: nothing.*
