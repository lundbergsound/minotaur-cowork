# VERHIST-GUARD — the snapshot guard, the census, and equipment as the proving surface

Tier: 3 (Claude Code)
Session: FRESH — no CC session is live, and this opens a new unit.

---

## 0 · What landed today, and what you are building on

Migration ledger moved **57 → 58** this session: `20260911002959_verhist_mig_project_snapshots_and_blobs`, applied from the Arch seat after a proof run with forced rollback.

It created, in `public`:

- **`project_snapshots`** — one row per snapshot. `payload` holds the production spine (20 tables) inline; `payload_hash`, `library_hash`, `identity_map_hash`; `reason`; `label`; `created_by`; `created_at`.
- **`project_blobs`** — `(project_id, kind, content_hash)`, `kind` in `('library','identity_map')`. Append-only for `authenticated` (SELECT + INSERT only, no UPDATE, no DELETE, no TRUNCATE). Never expired.
- **`snapshot_project_v1(p_project_id uuid, p_reason text, p_label text default null) returns uuid`** — SECURITY INVOKER, `search_path=public`, EXECUTE granted to `authenticated` and `postgres` only, `anon` refused.

⚠ **`reason` is CHECK-constrained.** Allowed values, exactly: `'hourly'`, `'manual'`, `'change_all'`, `'delete_found'`, `'delete_all'`, `'import_apply'`. Anything else raises.

⚠ **A `NULL` return is SUCCESS, not failure.** It means nothing changed since the last snapshot, so none was written. Treating `NULL` as a failure would refuse a gesture for the commonest possible reason. **Only a thrown error / a Supabase `error` object is a failure.**

Measured from the Arch seat, as `authenticated` with RLS on and the 8-second statement timeout armed, on BVSC US Tour (`57874c69-06b6-41b1-91d8-6a00e5255110`, the largest production, 2,591 spine rows): **~570 ms**, four repeat runs 383 / 323 / 315 / 318 ms for the build-and-hash half. The generated types do not describe these objects yet — **`types/database.generated.ts` predates migration 58**, so the RPC call needs the same escape hatch `import_apply_v1` already uses at `ImportV1Client.tsx:1044-1051`. Regenerating types is NOT in this unit.

---

## 1 · The ruling this implements, verbatim

**VERHIST is ruled seven of seven (Daniel, 2026-09-10 and 09-11).** The half that binds you:

> **Snapshot before Change All, Delete Found, Delete All and import apply, plus a manual Save Version.** ⚠ **If the snapshot fails, the gesture REFUSES.**

"Refuses" means the destructive write **does not run at all** and the operator is told why. Not a warning they can click past; not a degraded "we tried." A safety net the operator believes is there and is not is worse than no net.

---

## 2 · Why this is a census before it is a wiring job — measured, not assumed

Arch measured the call sites at source this session rather than guessing, and the obvious seam is the wrong one:

- ⚠ **`src/lib/bulkWrite.ts` is NOT the seam.** All four bulk RPCs funnel through it, which makes it look ideal — but it carries **every** batched write in the app, not the four ruled gestures, and it never sees a `project_id`. Snapshotting there would fire on routine edits dozens of times a session and would still not know which production to snapshot.
- The real commit points are **per surface, and there are more than a dozen**. Change All appears on equipment, library and cable with separate registries (the field-contract census already records **seven Change-All registries in three shapes**, five of them declared inline inside multi-thousand-line clients). Delete Found / Delete All appears on `EquipmentListClient`, `CableListClient`, `BundleListClient`, `TailListClient` and `CategoriesAdminClient`. Import apply is called from **three** places: `ImportV1Client.tsx:1051`, `WorkbookImportModal.tsx:204`, `WorkbookLibraryImportModal.tsx:160`.

**The last time a scope of this shape was estimated rather than counted, it came back seven registries where three were named.** So this unit produces the count first and wires one surface to prove the mechanism — the same census-then-fan-out shape that worked for FIELD-CONTRACT legs 1 and 2. The remaining surfaces are the next unit, and they are cheap once the guard exists and the census pins them.

---

## 3 · The unit — three checkpoints

### Checkpoint A — the census

Produce `docs/reference/verhist-guard-census.md`: **every destructive commit point in the app**, one row each, with `file:line`, which of the four `reason` values it maps to, where the `project_id` is in scope at that point, and whether it is wired yet.

⚠ **The commit point is the moment AFTER the operator confirms and BEFORE the write** — not where the dialog is requested. On equipment, `requestDeleteFound()` (`EquipmentListClient.tsx:2674`) only *opens* the confirm; snapshotting there would snapshot on a dialog the operator then cancels.

Back it with `src/lib/verhist/guardCensus.test.ts`, in the shape `src/lib/fieldContract/` already uses: a static source analysis that **fails when a destructive commit point exists that the census does not list**. The repo has `vitest` and `playwright` and no DOM package — static analysis is the right instrument here and adding `jsdom`/`happy-dom` is a hard stop, exactly as it was for the field contract.

⚠ **The test must be honest about what is not wired yet.** A census row marked `wired: false` is expected and passing for the surfaces this unit does not touch. A green suite that is green because it only looks at equipment is the failure this checkpoint exists to prevent.

### Checkpoint B — the guard

`src/lib/verhist/guard.ts`, one exported function, no React in it so it is testable:

```ts
export type GuardResult = { ok: true; snapshotId: string | null } | { ok: false; message: string }

export async function snapshotBefore(
  supabase: SupaClient,
  projectId: string,
  reason: 'change_all' | 'delete_found' | 'delete_all' | 'import_apply' | 'manual',
  label?: string,
): Promise<GuardResult>
```

- Calls `snapshot_project_v1`.
- **`data === null` with no error → `{ ok: true, snapshotId: null }`.** Nothing changed; proceed.
- Any `error` → `{ ok: false, message }`. Do not retry, do not degrade.
- Never throws. Every call site in this app reverts optimistic paint on a value, not an exception — `bulkWrite.ts` says so in its own words and gives the reason.

Unit tests against a faked client: success, skip, error, and — the one that matters — **a test proving the caller does not write when `ok` is false.**

### Checkpoint C — wire the EQUIPMENT surface only

Two commit points, both in `EquipmentListClient.tsx`:

1. **Change All.** The plain arm's final write is `runPlainChangeAll` (`:2247`), called at `:2543`. ⚠ **There is a second arm: `applyModelChangeAll`** (declared `:2277`) — the Model Change All path does not go through `runPlainChangeAll`. **Both are commit points.** The guard runs once per gesture, before the first write, not once per arm — if a gesture can take either arm, snapshot before the branch.
2. **Delete Found / Delete All / ⌥⇧E.** These share `requestDelete(ids, message)`; the commit point is the **confirm handler** that `requestDelete`'s dialog resolves to. Find it at source and name it in the census; do not assume its line.

`reason` is `'change_all'` for Change All, and `'delete_found'` vs `'delete_all'` by whether a narrowing is active — the toolbar already branches on exactly that to relabel itself (`:3013`).

On `{ ok: false }`: **abort the gesture before any optimistic paint**, and show the refusal. See §4 — the wording is not yours or mine to choose.

---

## 4 · The one string that is NOT yours to invent

The refusal message is what the operator reads when the net fails, and **v1 has no equivalent gesture, so there is no artifact to cite.** Under the Parity Rule that makes it a Daniel ruling or an OPEN QUESTIONS proposal, never a silent choice.

**Arch's proposal, awaiting Daniel — ship it only if this handoff's cover note says he approved it, otherwise use his wording:**

> *"Couldn't save a version of this production, so the change was not made. Nothing has been altered. Try again in a moment."*

Put it in ONE exported constant, so changing it later is one edit and not a grep.

---

## 5 · Hard stops — return to Arch, do not proceed

- **Any schema need whatsoever.** The migration is done; if you find you want a column, stop.
- **Regenerating `types/database.generated.ts`.** Use the existing escape hatch.
- **Any new dependency**, DOM packages included.
- **Wiring any surface other than equipment.** Census it, mark it unwired, leave it.
- **The import-apply sites.** ⚠ Arch has a specific constraint for them — the snapshot must be its own request completed *before* the apply begins, because the apply already exhausts its 8-second budget and must keep its single-transaction atomicity. That is next unit's, and doing it early without that constraint in front of you will get it wrong.
- Anything raising an OS-permission or OAuth dialog; credentials; destructive or irreversible operations.

---

## 6 · Success condition — the exact state at which you stop and return

1. `npx tsc --noEmit` → **0 errors**.
2. `npm test` → all green, and the count has **moved up from 2,980 tests / 157 files**. Report the new pair. (Count notation is TESTS / TEST FILES, never passing / skipped.)
3. `npm run build` → clean.
4. `node scripts/frozen-gate.mjs` → **3/3 against `be0769de`**. ⚠ Do not use `.claude/hooks/frozen-check.sh` as evidence of anything — it exits 0 when it cannot run and compares against HEAD rather than the baseline. Run the gate.
5. The visual gate is **not** expected to move — this unit adds no rendered element except a refusal message on a failure path no frame exercises. If any frame moves, that is a finding: stop and report it rather than declaring a baseline event.
6. `docs/reference/verhist-guard-census.md` exists, and `guardCensus.test.ts` fails when a commit point is removed from it. **Probe it in both directions and restore byte-identically** — delete a row, watch it fail, put it back.

⚠ **You cannot verify that a snapshot row actually appeared.** No harness in this repo can read the database — that is a standing constraint, not a gap in this handoff. **Do not claim the guard works end to end.** Report what the tests prove; the row-appeared check is Daniel's browser gate, reported to Arch, and Arch queries the table from its own seat.

**Raw Output Rule — for every command above:** *Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every line. The architect cannot verify correctness from a summary.*

Return to `~/Developer/Minotaur-Cowork/handoffs/from-cc/YYMMDD-hhmm_verhist-guard.md` — DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT.

**Commit is WF-1a: stage by explicit filename, and commit only on Daniel's terminal phrase `COMMIT APPROVED: <first words of the subject>`. ⚠ The phrase authorises the push too, and a push to `main` is a production deploy — so Daniel's browser gate is a PRECONDITION of the commit, not a follow-up.**
