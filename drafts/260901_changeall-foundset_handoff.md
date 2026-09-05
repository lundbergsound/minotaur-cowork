Tier: 3 (Claude Code)
Session: FRESH — new unit, tree clean at `e3a336a`, and CHANGEALL-METHODNEW's context is closed. Nothing from that run is needed here.

# CHANGEALL-FOUNDSET — the client half: 36 call sites onto four RPCs and one shared helper

**The database half is DONE and APPLIED.** Migration ledger **56 → 57**, `changeall_foundset_bulk_write_rpcs`, Arch-applied from the Cowork seat 2026-09-01 on Daniel's explicit confirm, rehearsal-first with a forced rollback and a clean residue check. **This unit writes NO migration. If you find yourself needing one, HALT and return it.**

## §0 · What this unit is, in one paragraph

Every batched write in the app puts its row ids in the URL, and the edge rejects any request over **≈25.0 KB** with a bare `400 Bad Request` and no `server` header — **582 rows today, but it is BYTES not rows, and a real session JWT lowers it.** Four SECURITY INVOKER functions now take the ids in the POST body instead. Your job is to move **36 call sites** onto them through **ONE shared helper**, and to fix the reads that today swallow their own errors. **A fix landing only in `runPlainChangeAll` fixes one site of thirty-six.**

## §1 · STEP 1 — the run fence (FENCE-COUNTS)

**Checked at source by Arch in the session that wrote this instruction, not carried from a Docket row.** `CLAUDE.md`'s measured counts are **CURRENT and correct at `e3a336a`** — suite 2634/140, frozen 3/3, visual 28/28. Two things in the fence are behind, and both are yours in this unit's own commit:

1. The **closed-and-pushed list** still names `EQUIP-LABELS-2 (374a7c8)` as newest. Add **CHANGEALL-METHODNEW (`e3a336a`), closed and pushed 2026-08-31** ahead of it, newest-first as that list now runs.
2. The **migration-ledger line** reads `56, last 20260831202115_equip_labels_2_…`. It is now **57**, last `changeall_foundset_bulk_write_rpcs`, **Arch-applied 2026-09-01 from the Cowork seat, no repo commit of its own** — the same shape the fence already uses for 2-MIG and 2-MIG-b.

Re-measure and rewrite the counts at YOUR close as the fence's own rule requires: whoever measures writes it here.

## §2 · STEP 2 — regenerate the types

`npm run db:types`, then confirm `src/types/database.generated.ts` carries all four functions before writing a single call:

`bulk_update_v1(p_table text, p_ids uuid[], p_patch jsonb) → integer`
`bulk_delete_v1(p_table text, p_ids uuid[]) → integer`
`delete_tails_of_cables_v1(p_cable_ids uuid[]) → integer`
`unlink_group_members_v1(p_link_id uuid, p_item_ids uuid[]) → integer`

**Only the generated types describe the database.** If a signature here disagrees with what regeneration produces, the generated file wins and you HALT and report the difference.

## §3 · CHECKPOINT 1 — one helper module, and every error surfaces

Build **one** module (`src/lib/bulkWrite.ts` or wherever your judgment puts it — module layout is yours) exposing exactly these, each returning the **row count the database actually wrote**:

- `bulkUpdate(supabase, table, ids, patch)` → `bulk_update_v1`
- `bulkDelete(supabase, table, ids)` → `bulk_delete_v1`
- `deleteTailsOfCables(supabase, cableIds)` → `delete_tails_of_cables_v1`
- `unlinkGroupMembers(supabase, linkId, itemIds)` → `unlink_group_members_v1`
- `selectByIdsChunked(...)` for the READ sites — batched under a conservative id-count ceiling, results concatenated

**The read helper follows `src/lib/fetchAllRows.ts`'s doctrine and its exact words: "a query error THROWS here rather than degrading to an empty list — a silently empty render is the same failure class as a silently capped one."** Copy that discipline; do not invent a second one. Reads may be chunked safely because a read has no atomicity requirement; **writes may NOT be chunked — that is the route Daniel ruled against, and the RPC exists so they need not be.**

**Guards already enforced in SQL, so do not re-implement them client-side:** an empty id array returns 0 and writes nothing · a table off the allowlist raises `42501` · `id`, `project_id`, `owner_id`, `created_at`, `updated_at` are never patchable (`42501`) · an unknown column raises `42703`. A JSON `null` in the patch becomes SQL `NULL` — verified, and `BoxListClient:915` depends on it.

**Checkpoint 1 closes when:** the module exists, is unit-tested against a throwaway project including the empty-array and error paths, and `npm run test` is green. Report the RPC round-trip time you measure for a 1,368-id call. *(Arch measured **57.4 ms** on the installed function against 62.6 ms for the bare UPDATE — expect parity, and report it if you do not see it.)*

## §4 · CHECKPOINT 2 — the 27 WRITE sites

**18 updates** — `EquipmentListClient:1831 · 2128` · `CableListClient:875 · 891 · 914 · 939 · 1911 · 1913 · 3035 · 3339 · 3544` · `BundleListClient:830` · `LineListClient:1119` · `TailListClient:790` · `EquipmentLibraryClient:322` · `BoxListClient:879 · 889 · 915 · 1269`

**9 deletes** — `TailListClient:670` · `CableListClient:2679 · 2880 · 3007 · 3043` · `BundleListClient:724 · 967 · 999` · `BoxListClient:1089`

Line numbers are measured at `e3a336a` and will drift as you edit; **the shape is the identifier, not the number.** `CableListClient:1280` and `BundleListClient:999` take `unlinkGroupMembers` — **`link_group_members` HAS NO `id` COLUMN**, it is keyed `(link_id, item_id)`, which is why that function exists at all.

**⚠ The optimistic-revert story changes, and in our favour.** Today a batched write that fails leaves the screen reverted and the database untouched — correct only because the write is all-or-nothing. It still is: the RPC is one statement in one transaction. **So keep revert-all on failure; it remains truthful.** This is the exact property chunking would have destroyed.

**⚠ DO NOT surface the returned row count in the UI.** It is new information and it has **no pedigree** — no Daniel ruling, no v1 artifact. Thread it, log it, test against it; showing the operator "1,368 of 1,368 updated" is a UX change and is **unbuilt until ruled**. Raise it as an OPEN QUESTION if you think it earns a ruling.

**Checkpoint 2 closes when:** all 27 write sites route through the helper, zero `.in('id'` write idioms remain outside it, and the full machine gate set is green.

## §5 · CHECKPOINT 3 — the 7 READS and the 2 raw filters, and the silent-orphan bug

**7 reads** — `EquipmentListClient:2037 · 2156` · `CableListClient:920 · 2878 · 2884` · `BundleListClient:965 · 971`

**⚠ Two of these are select-then-delete pairs whose select error is unchecked, and this is the worst defect in the unit.** `CableListClient:2878 → 2880` and `BundleListClient:965 → 967` read tail ids for a set of cables and then delete them. Above the ceiling the select is rejected, `data ?? []` yields an empty array, `if (ids.length)` is false, **the delete silently does not run and the tail rows are orphaned** — no error, no flash, nothing on screen.

**Both pairs collapse into `deleteTailsOfCables`**, which does the read and the delete in ONE statement so there is no intermediate list to truncate. Arch rehearsed it: **79 spine rows deleted, `tail_details` cascade held at 0 remaining.** Delete the now-dead select at each site rather than leaving it feeding nothing.

**2 raw filters** — `CableListClient:2888-2890` and `BundleListClient:975-977`, both `.or(\`source_patch_line_id.in.(${idList}),destination_patch_line_id.in.(${idList})\`)`. **These spend the id list TWICE in one URL and therefore fail at roughly half the row count of every other site.** They are reads: route them through the chunked read helper, with the doubling accounted for in the chunk size.

## §6 · CHECKPOINT 4 — the guard test

A test whose only job is to **fail if the raw idiom comes back**: scan the client sources for `.in('id'`/`.in("id"` on a write builder and for `.in.(` inside a raw filter string, and fail on any hit outside the helper module. House precedent: `MIRROR_SCOPED_TYPE` and LINKJOIN-FENCE — a comment does not hold a rule; a failing test does.

**⚠ Scan by reading bytes, not with grep.** `src/components/cable/BundleListClient.tsx` contains **one NUL byte at line 1265**, inside `` `g-${band.label || '<NUL>blank'}` `` — a typo for `'blank'`. That single byte makes grep call the file binary, and it is why six of these call sites went unswept for a week (**GREP-NULBYTE**). **Fix the typo in this unit** — it is one character and it is a live tripwire for every future sweep — and make sure your guard test could not be fooled by it.

## §7 · Hard-stops, frozen layer, and the gate

**⚠ Frozen-layer contact is a hard-stop — and Arch MEASURED the intersection rather than predicting it.** The frozen regions are exactly three: the complete `updateItem` function in `EquipmentListClient.tsx` (**lines 724–754** at `e3a336a`), and the `.save-error-flash` and `@keyframes save-error-flash` blocks in `src/app/globals.css`. **None of this unit's four EquipmentListClient sites (1831, 2037, 2128, 2156) falls inside `updateItem`** — the scope does not touch the frozen layer. The hard-stop still binds: if an edit lands inside 724–754, STOP and return it. Run `node scripts/frozen-gate.mjs` and report **3/3**.

**Baseline event: this unit should be UX-INVISIBLE** — same gestures, same dialogs, same results, without a size ceiling. So expect no frames to move. **Measure it; do not predict it.** If a frame moves, that is a declared baseline event and you report which frames and why before touching a reference image.

Standing hard-stops apply unchanged: access control · dependency changes · frozen-layer contact · schema needs · ambiguous evidence · destructive or irreversible operations · credentials, secrets or money · any OS-permission or OAuth dialog.

**Raw Output Rule.** Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every line. The architect cannot verify correctness from a summary.

**GATE-NOGREP:** never pipe a gate run through a filter — write it to a file and read the file.

## §8 · The commit block

**⚠ GATE-BEFORE-COMMIT — new, and it is a precondition here rather than a follow-up.** A WF-1a push is a **production deploy** (Vercel builds every push to `main`), so Daniel's browser gate runs **BEFORE** the approval phrase, not after it. Do not ask for the phrase until he has gated the tree.

Stage by explicit filename. Commit only after Daniel types `COMMIT APPROVED: <first words of the subject>` in the terminal; the phrase authorises the bare `git push` as well. Bulk staging stays fence-blocked. Close with `handoffs/from-cc/YYMMDD-hhmm_changeall-foundset_CLOSE.txt`: unit name · commit hash and range · file count · pushed state read from the ref files, never from git · the measured counts (suite, typecheck, frozen, visual, dependency) · what closed · what stays open and who owns it · what Daniel owes. **A number in it is a measurement or it is not written.**

## §9 · Success condition — the exact state at which you stop and return

All **36** call sites route through the one helper module · the guard test **fails** on a deliberately reintroduced raw idiom and passes with it removed · both select-then-delete pairs are single-statement RPC calls with their dead selects removed · the NUL byte is gone · `CLAUDE.md`'s fence carries CHANGEALL-METHODNEW, ledger **57**, and freshly measured counts · full gate set green with **frozen 3/3** and the visual gate's frame movement **measured** · CLOSE.txt written · **and Daniel's browser gate run before you ask for the phrase.**

Return to Arch with the file path as your last terminal line.
