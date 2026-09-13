# CHANGEALL-MODEL-SERIAL — the model Change All in two writes, not n

Tier: 3 (Claude Code)
Session: **FRESH.** AUTH-LINKCLICK + AUTH-SIGNIN-CONTRAST closed at `3416650`, pushed and READY. Open clean.

**Unit:** ⏭ NEXT 3's CHANGEALL-MODEL-SERIAL (Daniel's sequencing, Roadmap v4.33), with two ruled one-line riders bundled under HANDOFF-BUNDLE, plus the run-fence replacement (FENCE-COUNTS). Three checkpoints, one commit. No schema, no migration, no mail, no middleware, no dependency.

- **CP1 — CHANGEALL-MODEL-SERIAL.** A model Change All over 341 records makes 341 sequential writes. It becomes at most two.
- **CP2 — VERHIST-MANUALLEAD.** Ruled 2026-09-12: rename `SAVE_VERSION_REFUSAL_PROPOSAL` and rewrite its comment to cite the ruling.
- **CP3 — EXPRPT-HINT.** Ruled 2026-09-12: the export hint on the settings page takes Daniel's sentence. **Frame 06 will move; that is expected and declared, not adopted.**

VERHIST-SWEEPWATCH, which the Roadmap bundles here, is **not in this unit**: the sweep log has RLS on and no policies, so no app surface can read it without a schema change (Trigger B). Arch is proposing a scheduled watch outside the repo instead. Do not touch it.

---

## Precondition — return at once if it fails

`HEAD` = `refs/heads/main` = `refs/remotes/origin/main` = **`3416650`** (subject `feat(auth): AUTH-LINKCLICK …`), tree clean but for the two pre-existing untracked trees (`"Claude outputs/"`, `docs/reference/evidence/equipment/`). Read the ref files; never run git for this. Migration ledger live-read, expected **59** (`20260911165516`). `CLAUDE.md` `wc -m`, expected **109,988**. No `.git/index.lock` (the two `ORPHANED-index.lock.*` files are registered, not yours).

---

## 0 · What exists today — measured by Arch on 2026-09-13 at `3416650`

Re-measure every line at your open. The Surface Rule outranks this section.

**The serial loop**
- `src/components/equipment/EquipmentListClient.tsx` — **3,832 lines.** `applyModelChangeAll` at **`:2295-2329`**. Its shape: `ensureLibraryModel(newModel)` once (`:2296`); the library category resolved once (`:2297-2299`); **the category pre-read is already batched** — `selectByIdsChunked` over `equipment_items.id, category_id` (`:2310-2311`), 200 ids per chunk (`bulkWrite.ts:87`), into a `catById` map (`:2318`). Then **`for (const id of ids)` at `:2319`, one `await updateItem(id, patch)` per record at `:2323`**, and a per-row `setItems` for the category display at `:2325-2327`. The per-row decision is `(catById.get(id) ?? null) == null && fillCat` (`:2322`) — it reads only the pre-read map, so nothing in the loop depends on an earlier iteration's write. **That is why it can be batched.**
- The comment above it (`:2288-2294`) says the loop is v1's script 694 "First→Loop→Next", steps 1-3 and 5-6 per record, and that calling the frozen `updateItem` there is licensed. The licence is not the reason the loop is serial; the loop is serial because it was transcribed that way.
- `updateItem` at **`:765-795`** is a **FROZEN symbol** (`node scripts/frozen-gate.mjs`, vs `be0769de`). This unit stops calling it from `applyModelChangeAll`; **its bytes do not change.** One `.update().eq('id', id)` per call, optimistic row patch, revert and a 2,500 ms `rowErrors` flash on failure.
- The batched idiom already exists in the same file: `runPlainChangeAll` at **`:2261-2280`** — optimistic `applyPatchToIds`, one `bulkUpdate(supabase, 'equipment_items', ids, dbPatch)`, `restoreRows` + `flashSaveError(ids, keys)` on error. **`bulkUpdate` is `src/lib/bulkWrite.ts:118-133`, one `bulk_update_v1` RPC per call**, and the whole id list rides in the RPC body (CHANGEALL-FOUNDSET closed the size ceiling; re-read that function's header before relying on it).
- The guard runs before the branch: `snapshotBefore(supabase, projectId, 'change_all', writeIds.length)` at `:2443`; the model branch is `:2447`. **Nothing about the guard changes.**
- No test names `applyModelChangeAll` except the guard census (`src/lib/verhist/guardCensus.test.ts`); read what it pins before moving a line.

**The riders**
- `src/lib/verhist/guard.ts:228` — `export const SAVE_VERSION_REFUSAL_PROPOSAL`, referenced at `:182`, `:236`, `:239`; pinned in `guard.test.ts:5, :345-358`. The text it holds is the ruled sentence: *"Minotaur tried to save this Project Version, but it didn't work. Nothing has been saved. Please check your internet connection and try again."* (Ledger, seventeenth append §1; confirm the constant's value matches it byte for byte before renaming — if it does not, stop and return).
- `src/app/project/[projectId]/settings/page.tsx:451` — `hint="Generates a v1-compatible .xlsx set (equip/library/methods/categories) as a .zip — reviewable here before you download it"`.

---

## 1 · CP1 — batch the model Change All

**Pedigree:** CHANGEALL-MODEL-SERIAL, Roadmap v4.33 ⏭ NEXT 3 (Daniel), absorbing CHANGEALL-SPEED (ruled 2026-09-05: fix around private beta). No UX changes: the same records end with the same model and the same category as today; only the number of round trips and the failure shape change.

**Measure first, on a throwaway at the production's topology.** Before any edit: seed a throwaway project with ≥300 equipment rows of mixed models where roughly a third have a blank category, run a model Change All over the whole found set from the browser, and record the request count and wall time from the network log. Then again after. **Both numbers verbatim in the return.** If the before-count is not ≈ n + 1 + ⌈n/200⌉, the diagnosis of record is wrong — stop and return.

**Build:**
1. In `applyModelChangeAll`, after `catById` is built, partition `ids` into **`plainIds`** (category already set, or `fillCat` is null) and **`fillIds`** (category blank and `fillCat` set). Same predicate as `:2322`, evaluated once per id, no writes inside.
2. **Two writes at most:** `bulkUpdate(supabase, 'equipment_items', plainIds, { model })` and `bulkUpdate(supabase, 'equipment_items', fillIds, { model, category_id: fillCat.id })`. Run them concurrently (`Promise.all`); `bulkUpdate` already returns without a request for an empty list.
3. **Optimistic display first, in the `runPlainChangeAll` idiom:** one `setItems` applying `{ model }` to `plainIds` and `{ model, category_name, category_sort }` to `fillIds`, with the previous rows captured for revert. On either write's error: `restoreRows` for that write's ids and `flashSaveError(ids, keys)` for its keys, and `console.error` with the same `[change-all]` tag and fields the plain path uses (`:2272`). A failure of one write must not revert the other's rows.
4. Rewrite the block comment at `:2288-2294`: keep the E2 attestation (model + silent CAT-1..4 blank-fill only, notes untouched, steps 4 and 7 skipped), state that the pre-read decides the partition and two batched writes carry it, and cite CHANGEALL-MODEL-SERIAL with the date. Drop the "calling the frozen updateItem here is licensed" sentence — it no longer applies.
5. **`updateItem` is not edited.** The frozen gate proves it.

**Tests:** extract the partition into a pure function in `src/lib/equipment/` (e.g. `modelChangeAllPlan.ts`: `(ids, catById, fillCat) → { plainIds, fillIds }`) with its own test file: a set category is never overwritten (CAT-1), a blank one is filled only when `fillCat` exists, order preserved, disjoint and complete. Add a source-scan pin that `applyModelChangeAll` no longer contains `updateItem(` and does contain two `bulkUpdate(` calls (positive control: `runPlainChangeAll` contains one). Deletion controls: reintroduce the loop → the scan pin goes red; flip the predicate → the CAT-1 test goes red.

**Smoke:** the before/after measurement above, plus: a Change All where every row already has a category makes **one** write; one where `ensureLibraryModel` resolves no category makes **one** write and fills nothing; one where the RPC is forced to fail flashes the right rows and leaves the others patched. Census 0 by name at the end, re-verified by SELECT.

## 2 · CP2 — VERHIST-MANUALLEAD

**Pedigree (a):** Daniel, 2026-09-12 — the Save Version refusal wording approved as proposed. Rename `SAVE_VERSION_REFUSAL_PROPOSAL` → `SAVE_VERSION_REFUSAL` at every site (`guard.ts:182, :228, :236, :239`; `guard.test.ts:5, :345-358`; grep the repo for any other). Rewrite the constant's comment: the sentence is **ruled** (Daniel, 2026-09-12), no longer a proposal; keep the paragraph explaining why its shape differs from the gesture refusals. The string itself does not change by one character; the test at `:345` still pins it.

## 3 · CP3 — EXPRPT-HINT

**Pedigree (a):** Daniel, 2026-09-12 (Ledger, seventeenth append §1). Replace the hint at `settings/page.tsx:451` with, verbatim:

`Generates a v1-compatible .xlsx set — equipment, library, methods, categories, boxes and the cable sheets — as a .zip, reviewable here before you download it.`

⚠ **The visual gate's frame 06 is the settings page and will move.** Measure the per-frame diff and its bounding box, confirm the box sits on the hint line and nowhere else, and **return it as a declared baseline event**. Never `--update-baselines`; Daniel authorises the new baseline in the same run, as on 2026-09-08, and only after your measurement is in the return.

## 4 · Step 1 of the run — the fence

Replace the whole body under `## Current run fence` in `CLAUDE.md` with this unit's (unit, the commit it follows, counts measured at close, browser gate DEFERRED with the checks in §6). Quote the removed body verbatim in RAW OUTPUT. `wc -m` after ≤ before; report both.

## 5 · Hard stops — return, do not proceed

Schema, function, RLS or grant needs · any dependency change · a new environment variable · **any byte of `updateItem` or of any frozen symbol** · the middleware · the guard (`snapshotBefore`) and its threshold · a change to which category a row ends up with · anything raising an OS-permission or OAuth dialog · `--update-baselines`.

⚠ **Single-file edits go through the Edit tool, no exceptions** (CCSED-260911).

## 6 · Gates and close

`npm test` · `npm run type-check` · `node scripts/frozen-gate.mjs` · `npm run build` · `npm run test:visual`, plus the smoke in §1 on a throwaway created and destroyed in-run. **Raw Output Rule — verbatim:** *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every line."* **A number in the return is a measurement or it is not written.**

**Expected FILES CHANGED** (a difference is reported, not absorbed):
```
CLAUDE.md
src/components/equipment/EquipmentListClient.tsx
src/lib/equipment/modelChangeAllPlan.ts            (new)
src/lib/equipment/modelChangeAllPlan.test.ts       (new)
src/lib/verhist/guard.ts
src/lib/verhist/guard.test.ts
src/app/project/[projectId]/settings/page.tsx
```
plus the visual baseline file(s) for frame 06 **only once Daniel has authorised the baseline event**, listed by name.

**Commit — WF-1a.** Follow the COMMIT BLOCK in `CLAUDE.md`, including step 0. Subject begins `perf(equipment): CHANGEALL-MODEL-SERIAL`. Commit on `COMMIT APPROVED: perf(equipment): CHANGEALL-MODEL-SERIAL`. **HOLD the push behind Daniel's browser gate on this unit.**

**Daniel's browser gate — three checks on localhost:**
1. On a real show, select a model in the equipment list, change it, Change All over the found set: it finishes at once rather than row by row, every row shows the new model, and rows that had a category keep it.
2. ⚙ PROJECT → History → Save Version still works (the renamed constant is on that path).
3. Settings → Export to v1 shows the new hint sentence.

**Success condition:** a model Change All over n records makes at most two writes, measured before and after; `updateItem` is byte-identical to `be0769de`; the constant is renamed and its comment cites the ruling; the hint reads Daniel's sentence with frame 06's movement measured and declared; the fence carries this unit; the commit exists with `origin/main` still `3416650`; the `_CLOSE.txt` names the gate.
