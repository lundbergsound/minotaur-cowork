Tier: 3 (Claude Code)
Session: FRESH — the previous run's context is gone with the machine. That is the point of this file.

# CHANGEALL-FOUNDSET — RESUME. This is a VERIFY-AND-CLOSE pass, NOT a rebuild.

## What happened

A CC run executed `to-cc/260901-0704_changeall-foundset.md` for ~32 minutes, finished the work, and **the machine shut down at the moment it was about to write its return file.** Read that handoff for the unit's scope and success condition — it is still the specification.

## What Arch measured on the tree after the shutdown, before you were started

**The work survived. Nothing was committed.**

```
HEAD = origin = e3a336a          (unchanged; last ref movement is CHANGEALL-METHODNEW, 2026-08-31)
.git/index.lock                  absent
MERGE_HEAD / rebase state        absent
```

Present and byte-coherent — every file brace-balanced, no truncation, **zero NUL bytes anywhere**:
`src/lib/bulkWrite.ts` · `bulkWrite.test.ts` · `bulkWriteGuard.ts` · `bulkWriteGuard.test.ts` · the six list clients + `EquipmentLibraryClient` · `boxPackCascade.ts` · `methodChangeAll.ts` · `src/types/database.generated.ts` (all four RPCs present) · `CLAUDE.md` (fence carries CHANGEALL-METHODNEW `e3a336a`, migration ledger **57**, `20260901043028_changeall_foundset_bulk_write_rpcs`).

65 helper call sites across seven files. The only `.in(` idioms left in client code are **inside `selectByIdsChunked` closures**, taking a bounded `chunk` — the intended end state. The two `.or(...in.(...))` sites are inside chunked closures at `ID_CHUNK_SIZE_DOUBLED` with `dedupeBy: r => r.id`.

## ⚠ THE RULE FOR THIS PASS

**An interrupted run's own belief that something passed died with its context. The tree is evidence; its memory is not.** No gate result, no test run, no measurement from before the shutdown counts for anything. **Every number in your return is measured on this machine, now, or it is not written.**

Equally: **do not rebuild what is already there.** Read the working tree first. If a step in the original handoff is already satisfied, verify it and say so — re-implementing it risks undoing work that is correct.

## What to do, in order

1. **Confirm the environment came back clean.** Nothing stale listening on `:3000` before any gate run (GATE-DEVCHECK / GATE-PORT have already cost this project three fail-harded runs). `npm ci` only if `node_modules` is damaged — a dependency change is a hard-stop and `git diff e3a336a -- package.json package-lock.json` must stay empty.

2. **Read the tree against the original handoff's §9 success condition** and report, item by item, PASS or what is missing. Do not assume; open the files.

3. **Run the FULL machine gate set from zero** — build · strict typecheck · `npm run test` · `node scripts/frozen-gate.mjs` (expect **3/3**; the frozen regions are `updateItem` at `EquipmentListClient.tsx` and the two `save-error-flash` blocks in `globals.css`) · dependency gate · the visual gate. **GATE-NOGREP: never pipe a gate run through a filter — write it to a file and read the file.**

4. **Prove the guard actually guards.** Reintroduce a raw write idiom in a scratch edit, watch `bulkWriteGuard` fail, revert it, watch it pass. *A control that passes is not a control* — this project has already paid to learn that once.

5. **The visual gate's frame movement is MEASURED, not predicted.** This unit should be UX-invisible, so expect no frames to move; if any does, that is a declared baseline event and you report which frames and why before touching a reference image.

6. **Write the return file and the CLOSE.txt** that the shutdown ate: `from-cc/YYMMDD-hhmm_changeall-foundset.md` — DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT — and `..._CLOSE.txt`.

**Raw Output Rule.** Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every line. The architect cannot verify correctness from a summary.

## The commit, unchanged

**⚠ GATE-BEFORE-COMMIT.** Daniel's browser gate runs **BEFORE** the approval phrase, not after. A WF-1a push is a production deploy. Do not ask for the phrase until he has gated the tree.

Stage by explicit filename; commit only on `COMMIT APPROVED: <first words of the subject>`; the phrase authorises the bare `git push`. Bulk staging stays fence-blocked.

Return to Arch with the file path as your last terminal line.
