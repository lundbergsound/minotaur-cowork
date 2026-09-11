# VERHIST-GUARD — AMENDMENT 1

Tier: 3 (Claude Code)
Session: CONTINUE — same unit, same session as `260911-0130_verhist-guard.md`.

⚠ **This amendment was written while the base round was running and is declared here as round 2.** It changes the guard's signature and replaces the refusal string. Apply it to whatever state the base round reached: if the guard is already written, amend it; if it is not, build it this way from the start.

---

## A1-1 · RULED (Daniel, 2026-09-11) — the snapshot has a ROW THRESHOLD

**A bulk edit only takes a backup when it touches MORE THAN 20 records.** Daniel's words: *"thinking about change all and delete found, this is too many backups. Only implement on those if we're bulk editing more than 20 records."*

The reasoning, so it does not get rationalised away later: a Change All across a whole show is unrecoverable by hand and a Change All across eleven rows is not, and every snapshot that buys nothing still costs a write and a row the operator has to scroll past in their History list. **The hourly timer is what covers the small edits** — the threshold trades a narrow gap (an edit of twenty rows or fewer, inside the last hour, that the operator wants back) for a History list that is readable.

**The policy, exactly:**

| Gesture | `reason` | Snapshot? |
|---|---|---|
| Change All | `change_all` | **Only when affected rows > 20** |
| Delete Found | `delete_found` | **Only when affected rows > 20** |
| Delete All | `delete_all` | ⚠ **ALWAYS — see A1-2** |
| Import apply | `import_apply` | Always (next unit) |
| Save Version | `manual` | Always |

⚠ **`> 20`, not `>= 20`.** Twenty records takes no backup; twenty-one does. The operator-facing sentence says "more than 20," and the code and the sentence must agree or one of them is a lie.

Put the threshold in ONE exported constant beside the message constant:

```ts
/** Bulk gestures below this row count are covered by the hourly snapshot, not by their own. */
export const SNAPSHOT_ROW_THRESHOLD = 20
```

## A1-2 · Delete All is exempt from the threshold — RULED (Daniel, 2026-09-11)

Daniel named **Change All and Delete Found** for the threshold and has **confirmed that Delete All always takes a backup regardless of count.**

The reason, on the record: Delete All is the only gesture that empties the production entirely, and on a small list a snapshot costs almost nothing — a 292-row production's payload is a fraction of the 0.58 MB measured on the largest one. The gesture most likely to be regretted is not the one the threshold should silently exclude.

⚠ **Settled. Do NOT raise it in OPEN QUESTIONS.**

## A1-3 · The guard signature changes

```ts
export type GuardResult =
  | { ok: true; snapshotId: string | null; skipped?: 'below_threshold' }
  | { ok: false; message: string }

export async function snapshotBefore(
  supabase: SupaClient,
  projectId: string,
  reason: 'change_all' | 'delete_found' | 'delete_all' | 'import_apply' | 'manual',
  affectedRows: number,
  label?: string,
): Promise<GuardResult>
```

- `reason` is `change_all` or `delete_found` **and** `affectedRows <= SNAPSHOT_ROW_THRESHOLD` → return `{ ok: true, snapshotId: null, skipped: 'below_threshold' }` **without calling the database at all.** No round trip, no row.
- Everything else is unchanged from the base handoff, including the rule that matters most: **a `null` return from the RPC with no error is SUCCESS** (nothing changed since the last snapshot), and only an `error` is a failure.

⚠ **Three distinct "no snapshot was written" outcomes now exist and only one of them refuses the gesture.** Below threshold → proceed. Nothing changed → proceed. Error → refuse. A test for each, and a test proving the caller proceeds in the first two and does not write in the third.

## A1-4 · The refusal message — RULED (Daniel, 2026-09-11), replaces the base handoff's §4 proposal

The base handoff's wording is **withdrawn**. It said the backup failed without ever saying why a backup was involved, so the operator could not connect it to what they had just done. Ship exactly this:

⚠ **The constant already exists and is named `SNAPSHOT_REFUSAL_MESSAGE`** (`src/lib/verhist/guard.ts:115`, verified at source by Arch). **Replace its VALUE in place. Do not add a second constant and do not rename it** — the name is referenced at four sites in `guard.ts` and five in `guard.test.ts`.

```ts
export const SNAPSHOT_REFUSAL_MESSAGE =
  'Minotaur makes an auto backup before changing more than 20 records at once. ' +
  'Minotaur just tried to make a backup, but it didn\'t work. Nothing has been changed. ' +
  'Please check your internet connection and try again.'
```

Delete the comment above it that marks the string as unruled — it has pedigree (a) now.

⚠ **Daniel's words, verbatim, with a closing period added and nothing else altered.** Do not tighten it, do not de-duplicate the two "Minotaur"s, do not reword "check your internet connection" into something more technically exhaustive. The repetition is doing work: it names the product as the actor twice, which is what makes "nothing has been changed" credible. **This string has pedigree (a) — a Daniel ruling — and an edit to it silently removes that pedigree.**

⚠ **The first sentence and `SNAPSHOT_ROW_THRESHOLD` must agree.** Add a test that fails if the constant changes without the sentence changing — the number appears in both and this is exactly how the two drift apart.

## A1-5 · What this does NOT change

- The census in Checkpoint A still inventories **every** destructive commit point, including the ones below the threshold. **The threshold is a runtime decision, not a scoping one** — a commit point that usually affects three rows still needs the guard on it, because the same gesture on a bigger found set crosses twenty.
- Every hard stop in the base handoff stands.
- The success condition in the base handoff stands, plus: the threshold tests and the message/constant agreement test.
- The commit is still WF-1a, and Daniel's browser gate is still a precondition of it rather than a follow-up.

**AMEND-DECLARES-PER-ROUND: this is round 2. Declare it in the return.**
