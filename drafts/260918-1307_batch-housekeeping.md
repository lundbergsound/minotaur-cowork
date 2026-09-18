# BATCH-HOUSEKEEPING — the instrument, before PRINT-RULES measures with it

Tier: 3
Model: claude-opus-5
Session: FRESH

*Arch, Cowork main line, 2026-09-18 13:07 ET. HEAD `b07eef5` = `origin/main` (BATCH-FRONTDOOR shipped).
Migration ledger 77. **Daniel's ruling of record, 2026-09-14 (Ledger, rulings table): housekeeping and
PRINT-RULES are "Not bundled. Housekeeping repairs the fence and the frozen-check hook; PRINT-RULES
is measured by them. Housekeeping runs first."** So this unit ships alone, and PRINT-RULES follows it.*

**⚠ Every answer you need is in this file. There is no blank for anyone to fill in.**

## §0 · HARD STOPS

1. **No migrations, no SQL writes.** Reads only if you need them.
2. **MAILGATE.** Nothing sends mail.
3. **No print geometry, no source change to any print path.** That is PRINT-RULES'.
4. **Expected gate: 28/28, no baseline event.** Nothing here should move a pixel. If one moves, stop.
5. Raw Output Rule, every command whose output matters: *"Reproduce the complete raw output verbatim —
   into the handoff file's RAW OUTPUT section if the project uses one, otherwise inline. Do not
   summarize, paraphrase, or describe it. Show every line."*
6. **GATE-NOGREP.** Write gate runs to a file and read the file.
7. **Commit only on Daniel's `COMMIT APPROVED: <first words of the subject>`**, after his browser gate.
   There is almost nothing for him to see here; say so plainly in the return.

## §1 · Census

| Member | Pedigree | Rides |
|---|---|---|
| HARNESS-SORTLEAK, the durable fix | (a) Arch ruling of record, Ledger 2026-09-17: *"PIN the fixture's sort at run START rather than restore it at the end"* | ✅ CP1 |
| HARNESS-WAIT | Ledger 2026-09-17: bare `page.click` after `goto` + `setTheme` with no bounded wait (was `visual-capture.mjs:930`; re-measure) | ✅ CP1 |
| ST-RACE | Ledger, BATCH-PREBETA CP7 measurement: 16 sites clear an error/flash flag on a timer, one is guarded | ✅ CP2 |
| CTF-SEED | Ledger CP7: `cableTypeFormFromRow` (`src/lib/cable/cableTypeForm.ts:144`) and `resolveCableTypeIdByName` (`:256`) have no production caller | ✅ CP2 |
| LINT-CONFIG | Roadmap row; Daniel ruled `next lint` deleted "for now" (2026-09-15). Mechanism below is **(c) Arch proposal** | ✅ CP3 |
| The three test projects | **Discharged by Daniel 2026-09-18**: test shows live on `daniel+test01@`; `Versioning Test`, `JOY`, `JOY Import 2` all stay there. Nothing to do | — |

Out: the duplicate font literals (`printEngine.ts` ≡ `nordicSkin.ts`) are PRINT-RULES'. Wander-site span
lesson and `01-project-menu-dark` Δ1 (FRONTDOOR OQ10): **observe and report only**, do not register.

## §2 · CP1 — the harness

1. **SORTLEAK.** Today the harness restores the ruled default sort at the END of a frame
   (`visual-capture.mjs` ~759–808, "restore the ruled default sort, and WAIT FOR THE WRITE"). A restore
   only protects the next run if this one finishes. **Add a pin at run START**: before the first
   captured frame, write the fixture's ruled default sort state and wait for that write, exactly as the
   restore does. Keep the end-of-frame restore too. Fail hard if the pin's write does not land.
   **Deletion control:** leave the fixture in a non-default sort, run the gate with the pin disabled
   and show it fails at frame 03; enable it and show 28/28. Restore the fixture afterwards.
2. **HARNESS-WAIT.** Find every bare `page.click` directly after `goto`/`setTheme` with no bounded wait,
   and give each the bounded-wait idiom the file already uses. Quote each site before and after.
3. Gate ×2, settled between runs. Expected 28/28 both.

## §3 · CP2 — ST-RACE and CTF-SEED

1. **ST-RACE.** Census the 16 sites (re-measure; quote each). One idiom for all: a timer that clears a
   flag clears **only the value it set** (compare a token or the exact value before clearing), and any
   pending timer is cancelled on unmount and when a newer value replaces it. ⚠ **The worst one is
   `PreviousRevisionsClient.tsx`'s `showStatus`** (was `:377`): a success's 2.5 s timer can erase an
   ERROR set after it. After your change an error must stay until the next action. Unit-test that exact
   sequence (success, then error inside 2.5 s → error still showing at 3 s).
2. **CTF-SEED.** Census both symbols across `src/` and `scripts/` (DEAD-CODE-IS-NOT-SAFE). If the only
   callers are their own tests, delete the functions **and** their tests. If anything else calls them,
   stop that item and report.
3. Suite, typecheck, gate.

## §4 · CP3 — LINT-CONFIG, **(c) PROPOSAL**

Measured by Arch: `package.json` has `eslint ^9` and `eslint-config-next 15.1.0` against `next ^16.2.6`;
no `eslint.config.*` exists; there is no `lint` script.

1. Add a flat `eslint.config.mjs` using the Next config **matching the installed Next major**, and a
   `"lint": "eslint ."` script (ignore `.next`, `node_modules`, generated types). The dependency change is
   **permitted** for this item only; show the `package.json`/lock diff.
2. Run it once and put the full count by rule in RAW OUTPUT.
3. **Landing rule:** fix every `react-hooks/rules-of-hooks` error and anything that is a real bug. Every
   other firing rule is set to `warn` in the config, with its count in a comment, so `npm run lint`
   exits 0 today and nothing is silently disabled. **Do not mass-edit source to satisfy style rules.**
4. If the error count makes step 3 more than a small fix, stop after step 2 and return the counts; Arch
   scopes it.

## §5 · Close

Full suite, typecheck, build, frozen 3/3, visual 28/28, the new `npm run lint` exit 0. Replace the run
fence in `CLAUDE.md` with this unit (FENCE-ONEUNIT). Return to `handoffs/from-cc/` as DONE / FILES
CHANGED / OPEN QUESTIONS / RAW OUTPUT, with a COMMIT BLOCK (`git add` by filename). Proposed subject:
`BATCH-HOUSEKEEPING: sort pin at run start, timer-flag races, lint config, dead cable-type helpers`.
