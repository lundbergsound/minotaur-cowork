# NEXT SESSION OPENER — Cowork-Arch, MAIN LINE

**Written 2026-08-27 15:20 EDT at the close of the session that shipped M0-WIRE and closed R8-DRILL.**
**This session opens on a BUILD UNIT: the page container. Read §3 before anything else.**

---

## 0 · SEAT CHECK

Cowork, three mounts reachable: `Minotaur` · `Minotaur-Cowork` · `Minotaur_v1_exports`. **If not, STOP and say so.**
**Mounts do NOT persist between sessions — expect to grant all three at open.**

## 1 · ROLLOVER — ⚠ DUE

**Session Log stands at 10. The rollover FIRES at this pre-open.** Run it before any work: archive the oldest 8 entries byte-exact as `Session_Log_Archive_2026-08-27.md` → `session-log-archives/`; fresh log keeps the header and the most recent 2 entries, count reset, Rollover "clear". **WAIT for Daniel's confirm before installing either** — overwriting the live log IS the install.

## 2 · READ ORDER

`Architecture_Prompt_v33.md` → `Minotaur_v2_Roadmap_v4_11.md` (WHOLE) → `Minotaur_v2_Session_Log.md` (STATE OF PLAY + the Aug-27 afternoon entry) → this opener. Ledger and `Architecture_Provenance.md` on citation.

**Verify from files, never by running git.** **⚠ Read `.git/refs/heads/main` — NOT `.git/packed-refs`, which still carries `be0769de`, four commits stale, and that value is also the frozen-gate baseline so it looks plausible.** HEAD should read **`df42fb0`**. Migration ledger **55**. **CC is IDLE. Nothing is in flight.**

## 3 · FIRST ACTION — THE PAGE-CONTAINER UNIT

**One unit, two checkpoints, and the first one is an experiment — treat it as one.**

**Checkpoint 1 — ORIENT-FIXFAILED, DIAGNOSIS-FIRST, HARD RETURN.** Three landscape cable outputs print portrait with content rotated 90°. **Confirmed in a printed artifact 2026-08-27: the Tail Checklist PDF is 612×792 portrait with 1,779 of 1,779 characters non-upright** — text extracts reversed (`5 tseT tropmI`). A fix already exists and FAILED: `docChrome.tsx:209-222` carries the explicit-dimensions fix **whose own comment describes the symptom it failed to prevent.** One untested lead: a second top-level `@page { size: letter portrait }` at `PrintEquipmentListClient.tsx:912` — **whether it is ever mounted on a cable route was NOT measured, and measuring it is the unit's first step.** **If checkpoint 1 does not yield, CC RETURNS rather than proceeding to checkpoint 2.** Batch rulings, never batch experiments.

**Checkpoint 2 — PRINT-CLIP.** Cause is known, unlike checkpoint 1's: fixed-height pages (`docChrome.tsx:196-200`, print CSS `:233`, `overflow:hidden`) with rows placed by an ESTIMATE (`30 + tails×13 + noteLines×12`, `CableChecklistPrintClient.tsx:69-76`). **Measured residuals: Cable Checklist 150 tail lines on paper vs 190 from the builder (−40); Tail Checklist 107 vs 116 (−9); Cable Folder Labels 24 vs 24 EXACT — the control, because it paginates by integer slice.** Selection is proven correct; the group spine landed at exactly 27.

**Two docket items ride this handoff — their triggers fired on M0-WIRE and were missed:** `CLAUDE-HARNESS-STALE` (`CLAUDE.md`'s harness section still calls SUBPIXEL-WANDER site 4 `provisional: true` with a `refineBy`; `screenshots/diff-exceptions.json` already carries the corrected reasoning) and `LINKJOIN-FENCE` (a test whose only job is to fail if `historyJoinKey` is used for identity).

**Verification fixture:** `Import Test 5` (`dbf56057-0447-41a9-81b1-a8842a83b958`), built from 13 v1 files, run `07e3d4de-…`. **NOT BVSC NY — see §6.**

## 4 · THEN

**2-MIG-c** — MIGRATION, Trigger B, rehearsal-first, Daniel confirms before the apply. Now carries **four** arms: SPLITOF-NO-ARM · APPLY-TIMEOUT · **GRANT-TRUNCATE** · **HARNESS-READ**. Then **EXPORT-HISTID-DROP re-measured** (§6) and paired with **EXPORT-CARRIES-STATE**. Then **cable geometry** (pass 3). Then the staged box residuals.

## 5 · OWED BY DANIEL

**The cable folder-label ORDER ruling** (count is 24 and ruled; order is not) · **BUNDLE-LINK-IMPORT** · **WAITLIST-NOTIFY** — Trigger A, decision block before code, four choices plus the fifth Arch found · three **box** print reprints · **FENCE-PUSH** (Strat-tier) · **METRIC-UNRUN's browser gate** · CAND-4 · GIT-CFG · **PROJ-CLEAN-2** (27 rows, ~21 leftovers — **`Visual Gate Fixture` must NOT be swept**) · **a STRAT-record entry for the Pro upgrade**, like FENCE-PUSH.

## 6 · DO NOT RE-DERIVE, AND DO NOT REPEAT

- **NEVER re-import into BVSC NY.** Its `import_identity_map` holds **2,811 rows with 0 `v1_history_id` and 0 `row_hash`** — it was seeded by script, not the engine. A v1 re-import plans **1119 INSERTS** and would double the show. **STECK-ZERO is confirmed, not suspected.**
- **⚠ EXPORT-HISTID-DROP's carried figure is WRONG.** *"All 1,119 carry an identity row live (1,112 v1 + 7 assigned)"* is measured as **0 v1 / 2,811 assigned**. Its *"a join that misses"* attribution is **unproven, not wrong. Re-measure before designing that unit.**
- **A full 21-file import still times out; a 13-file cable-side subset applies cleanly.** `authenticated` = 8s, `anon` = 3s, `service_role` = none.
- **`service_role` cannot read.** SELECT on 2 objects, TRUNCATE on 35. No local harness can read the database until HARNESS-READ lands.
- **M0-WIN is HALF-WIRED.** The import now writes both markers; **the export writes neither back** — no `no_box_needed` emission, and it emits `N/A - Labels Only` where v1 expects `0`.
- **Do not re-litigate:** FOLDER-NABOX's count (24, ruled) · the spend cap (ON, ruled) · CONTRAST-PAIR (no white on yellow, ruled) · that PRINT-CLIP and ORIENT-FIXFAILED are pass-2's, not M0-WIRE failures.

## 7 · NOT THIS SESSION

Cable geometry · CONTRAST-PAIR · WAITLIST-NOTIFY · DEEP-ARCHIVE · GATE-THEMEGLYPH's diagnosis · the `0` vocabulary-row fold · S4-late · EXPORT-HISTID-DROP.

## 8 · CONDUCT — what this session's record says

1. **Three Arch errors, all one shape: a number or anchor taken from a DOCUMENT instead of from the thing itself.** `spec.ts:461` · "the rows will match on HistoryID" · `lines.xlsx` "0 rows". **Two were caught by guards Arch had written — that is the guard working, not an excuse for the instruction.**
2. **Say what a unit's output will and will not be.** Daniel was asked to print four documents and check numbers, and was not told they would be correct in content and unusable as paper until pass 3. **A person asked to print something reasonably expects it to look right.**
3. **When Daniel says he does not understand, rewrite — do not append a definition and carry on.** It happened twice this session and the rewrite worked both times.
4. **Show, don't argue.** The folder-label ruling was taken in one turn off two rendered sheets after two turns of prose got nowhere.
5. **Read the artifact, not the screenshot.** Every printed number in this close came from the PDF via `pdfplumber`.

---

*Governing set at this close: **Arch v33** + `Architecture_Provenance.md` · **Roadmap v4.11** (retires v4.10) · Ledger v1.0 (Aug-27 second append) · Session Log at **10, rollover DUE**. HEAD **`df42fb0`**, pushed, Vercel READY. Migration ledger **55**. Session state note: `handoffs/260827-1410_mainline-state-and-r8-foldin.md`.*
