
---

## SEPTEMBER 11, 2026 — THIRTEENTH APPEND — VERHIST'S SCHEMA APPLIED (LEDGER 57 → 58, THE FIRST MOVE IN ELEVEN UNITS) AND VERHIST-GUARD SHIPPED AT `951557c` · ⚠ THE PROOF RUN CAUGHT A `TRUNCATE` GRANT IN ARCH'S OWN MIGRATION THAT RLS DOES NOT FILTER · ⚠ A CORPUS FACT OF RECORD WRONG BY 3.5× ON THE DRIVER PRODUCTION, AND THE CAUSE PROVEN BENIGN BY ARITHMETIC THAT CLOSED EXACTLY · THE DEDUP PROVEN IN PRODUCTION RATHER THAN ESTIMATED · ⚠ THE ROADMAP RESTRUCTURED ON DANIEL'S RULING AND THE ARCHITECTURE PROMPT REWRITTEN TO STOP IT RE-BLOATING · SIX ARCH ERRORS, FOUR CAUGHT BEFORE THEY REACHED ANYTHING (append block)

### 1 · What shipped

**VERHIST-MIG — the schema.** Migration **`20260911002959_verhist_mig_project_snapshots_and_blobs`**, Arch-applied to `main` after a proof run with forced rollback and a clean residue check. **Migration ledger 57 → 58, the first move in ELEVEN consecutive units.** Creates `project_snapshots`, `project_blobs` and `snapshot_project_v1` — SECURITY INVOKER, `search_path=public`, EXECUTE to `authenticated` and `postgres` only.

**VERHIST-GUARD — the safety net.** `951557c`, one production deploy, 8 files, +1893/−11. Two rounds: the base handoff and AMENDMENT 1. Suite **2980/157 → 3088/160**. Frozen 3/3, visual 28/28 with no baseline event, dependency gate clean.

### 2 · ⚠ THE PROOF RUN CAUGHT A REAL DEFECT IN ARCH'S OWN MIGRATION, AND IT IS THE GRANT CLASS ENGINEERING STANDARDS NAMES

The migration granted exactly what was intended on both new tables. **The privilege-level check afterwards showed `TRUNCATE` on both, for `authenticated` and `service_role`.** Supabase's default privileges grant `TRUNCATE`, `REFERENCES` and `TRIGGER` on every new table in `public`, so **a `grant` does not narrow that — it adds to it.** ⚠ **`TRUNCATE` IS NOT FILTERED BY RLS**, so as first written any signed-in user could have emptied version history for every production in the database, and it would have added two more objects to the ten `GRANT-TRUNCATE` already records.

Fixed by **revoking from `public, anon, authenticated, service_role` FIRST**, then granting. **Re-proved by RUNNING the attack rather than reading the grant table** — `TRUNCATE` denied on both, `DELETE` on the blobs denied. *The standing rule is TEST THE GUARD, DO NOT READ IT; this is the first time it was applied to a grant.*

### 3 · ⚠ A CORPUS FACT OF RECORD WRONG BY 3.5× ON THE DRIVER PRODUCTION

The Roadmap and the Session Log both stated **BVSC Mexico City (`cf780353`) carries 1,024 spine rows.** Measured live: **292**, all `generic`.

Reconstructed from the product's own revision snapshots: at **2026-09-06 16:03 UTC** the list held **1,059 items**; by **22:44** the same day, **288**. The import identity map holds **1,059 rows for that project of which 823 point at equipment that no longer exists — 77.7%, against the US Tour's ZERO of 2,591.**

⚠ **The cause was NOT asserted; Daniel was asked and answered, and the arithmetic then closed exactly.** He seeded Mexico City with the Tour's entire equipment list and cut it down. **The Tour's `generic` population is exactly 1,059** — identical to CDMX's pre-prune count — and **all 1,059 CDMX identity rows match a Tour row by content hash, 100%.** 1,059 seeded − 823 cut = 236 survivors, + 56 rows created by hand = **292 today, to the row.** The PDF of 2026-09-07 matches the database on three independent numbers (183 printed rows, 292 spine items, total quantity 908) and says it in its own first note: *"This list replaces the BVSC US Tour equipment list."*

**No data was lost. The figure of record was simply never re-checked** — CORPUSBOUND-AUDIT's shape on the driver show. Registered as **IDMAP-ORPHAN-REIMPORT**: the residue is the normal by-product of an ordinary workflow every beta user will perform, and what a re-import does when it meets it is unmeasured.

### 4 · Measurements, all live and all re-checkable

- **`snapshot_project_v1` on the largest production, as `authenticated`, RLS on, the 8-second timeout ARMED: ~570 ms.** Four repeat runs of the build-and-hash half: 383 / 323 / 315 / 318 ms. ⚠ **The APPLY-TIMEOUT exposure on the snapshot half is discharged with ~18× headroom**, so "if the snapshot fails the gesture refuses" is safe.
- ⚠ **Stored `jsonb` on a REAL data-shaped payload: 16.4% of JSON text for the spine, 18.1% for the library** — better than the 26–28% expected from print-shaped revisions. **A snapshot is 0.58 MB, not the 1.40 MB the design pass projected.** This discharges VERHIST-BLOBWATCH's "re-measure on the actual object" and converts TENSE-IS-A-CLAIM's expectation into a measurement.
- ⚠ **THE DEDUP IS PROVEN IN PRODUCTION, NOT ESTIMATED.** Three snapshots on a live project share **ONE** library blob and **ONE** identity-map blob: **1.88 MB total where carrying both inline would have been 3.15 MB**, and every further snapshot now adds zero for either.
- ⚠ **The identity-map blob is 384 KB — LARGER than the library's 283 KB.** Arch's first sketch carried the identity map inline in every snapshot; measuring it before writing it is the only reason it is not now costing 384 KB an hour, per production, forever.
- **The definitive payload table set is SETTLED at 20 tables.** ⚠ **`box_details` and `rf_device_details` carry NO `project_id`** — they are keyed on the equipment spine id — so a snapshot filtering on `project_id` alone would have captured **no boxes at all**, silently, and the loss would have surfaced only at a restore.
- **`pgcrypto` is already installed**, and `sha256()` is built in regardless, so the migration installs no extension. `pg_cron` remains **1.6.4 available, not installed.**

### 5 · The census, and a scope Arch again estimated low

**SEVENTEEN destructive commit points, measured: 7 Change All, 7 bulk delete, 3 import apply.** Arch's handoff said "more than a dozen" and named five bulk-delete surfaces. ⚠ **There are seven — `BoxListClient` and `MethodsAdminClient` reach it under the label "Delete Unused", which is v1's word for the same branch, so a text search for "Delete All" misses them.** `LineListClient` has Change All and no bulk delete; `BoxTypesAdminClient` has neither — both recorded as deliberately absent so gaining one is a test failure rather than a discovery. *Same shape as FIELD-CONTRACT: Arch estimates, CC counts, the count is higher.*

### 6 · Rulings (Daniel, 2026-09-11)

- ⚠ **A bulk gesture only takes a backup when it touches MORE THAN 20 records.** *"This is too many backups."* Strictly greater — 20 takes none, 21 does. Applies to Change All and Delete Found; the hourly timer covers smaller edits.
- ⚠ **Delete All is EXEMPT and always snapshots**, whatever the count — Arch's recommendation, confirmed. It is the only gesture that empties a production, and on a small list the snapshot costs almost nothing.
- **The refusal message, his words verbatim:** *"Minotaur makes an auto backup before changing more than 20 records at once. Minotaur just tried to make a backup, but it didn't work. Nothing has been changed. Please check your internet connection and try again."* ⚠ **A refusal must say WHY the backup was triggered, not merely that it failed** — Arch's proposed wording did not, and the operator could not connect the backup to what they had just done. A test fails if the threshold drifts from the sentence naming it.
- ⚠ **No Architecture Prompt rewrites or additions without removals, unless there is a very good reason.**
- **The Roadmap must show what is being done now and what is next plainly at the top, then the technical sequence — no history at the top.**

**Closed by arithmetic rather than by ruling:** whether Change All's **"No — just this record"** should snapshot. It writes one row, one is below twenty, so it never does. *The threshold answered a question Daniel was never asked.*

### 7 · ⚠ THE ROADMAP AND THE PROMPT

**Daniel had given the same note for a fortnight and the file kept re-bloating. Measured rather than assumed:** v4.27 was **161,971 characters**; the plain-English block he reads was **1,546 — one percent**; **Lineage was 22,728 (14%)** inside a file whose own header read *"Forward-only — history lives in the Ledger"*; and **he scrolled past 28,000 characters of history to reach the sequence.**

⚠ **THE CAUSE WAS THIS PROJECT'S OWN PROMPT, NOT A DISCIPLINE FAILURE.** Architecture Prompt v34 bounded exactly one thing — six bullets on that one-percent block — and bounded nothing else, while every close instruction ADDED (a Ledger append, a Roadmap update, a Docket Sweep line, a propagation list, a Session Log entry) and **none removed.** The two largest history sections were governed by no rule at all. **The file was growing exactly as written; the note landed on the seat each time and the structure re-bloated the next session.**

**Roadmap v4.28** — four sections, in order: **▶ NOW · ⏭ NEXT · 🏗 THE SEQUENCE · 📌 THE DOCKET.** Lineage, SHIPPED and the closed-session sections **deleted outright**. **161,970 → 119,008 characters, −42,962.** Every carried Docket row is **byte-identical by construction** — the file was assembled from v4.27 by extraction, not retyped — verified by hashing the carried blocks and confirming all 72 ACTIVE rows survive.

**Architecture Prompt v35** — the Roadmap rule replaced with the four sections, the two caps (head ≤ 8,000 characters; file ≤ its stated cap, ratcheting DOWN only), and its reason carried. ⚠ **Two rules DELETED to pay for it: the Docket Sweep line** — SWEEPLINE-NOT-DURABLE proved a fact carried only there dies with the version that carried it — **and "read the Roadmap WHOLE"**, which sounded like diligence and was the reason nothing ever forced the file to be short enough to read. **It is only safe to delete alongside the caps.** Net **+856 characters**, disclosed rather than shaved.

⚠ **What this did NOT fix, registered as DOCKET-ROWLENGTH:** row length. The Docket is still 61% of the file and several rows are multi-paragraph essays that belong here with a one-line pointer there. **Pruning it is what lets the file cap ratchet down.**

### 8 · ⚠ Six Arch errors, four caught before they reached anything

1. ⚠ **A `TRUNCATE` grant in the migration** (§2) — caught by its own proof run, but it was in the delivered file.
2. ⚠ **The commit-point count estimated at "more than a dozen" and measured at seventeen** (§5).
3. ⚠ **The identity map nearly carried inline**, at 384 KB per snapshot forever — caught only by measuring it (§4).
4. ⚠ **Daniel was handed the CC handoff and a gate question in the SAME message, with the action first.** He started Claude Code before reaching the question, and the round-1 return correctly recorded the refusal string as unruled. *"Never hand Daniel an action he cannot take yet" exists for exactly this ordering.*
5. ⚠ **A symbol named in AMENDMENT 1 without checking it at source** — `SNAPSHOT_REFUSED_MESSAGE` against the built `SNAPSHOT_REFUSAL_MESSAGE`. Caught before the amendment was pointed at, and it would have created a second constant. *A Surface Rule miss on a four-character difference.*
6. ⚠ **THE REGISTER FAILED A FOURTH TIME.** The paragraph explaining the prompt deletions was written in seat shorthand and Daniel answered *"what does this mean? is this a good thing or a bad thing?"* — while the subject of that very paragraph was making documents readable. **Rewritten from first principles, not annotated.**

### 9 · CC's disclosed discipline defects, and one stale fact corrected

⚠ **FOUR single-file repo writes in round 1 went through bash heredocs instead of the Edit tool**, two of them without the immediate frozen-gate run the rule requires. Disclosed by CC itself with a full ledger; round 2 made none. The tree is not in question — every write is in the diff and the gate was 3/3 at every point — but **a bash write bypasses the PostToolUse frozen-check hook, which is the whole reason for the rule.** Registered as **CCSED-260911**, and it feeds **SEDRULE-REMAINDER** and **WF1A-SUNSET** directly: *the rule was broken by the seat that had just been handed it, in the pass that quoted it.*

⚠ **GREP-NULBYTE IS STALE AND IS CORRECTED HERE.** The record says `BundleListClient.tsx` carries a NUL byte that makes `grep` treat it as binary. **Measured independently by CC and re-measured by Arch: 75,051 bytes, ZERO NUL bytes, and `file` reports plain UTF-8 text.** True of the record, no longer true of the repo. **Any future sweep that skips that file citing this rule is skipping it for a reason that no longer exists.**

### 10 · New rows

**VERHIST-TIMER · VERHIST-FANOUT · VERHIST-UI** (in THE SEQUENCE) · **DOCKET-ROWLENGTH** · **CHANGEALL-MODEL-SERIAL** — `applyModelChangeAll` is a `for` loop with an `await` inside it, so a model Change All across 341 records is 341 sequential round trips where every other field is one statement; **found by Daniel on the running app, measured at source, and NOT introduced by VERHIST-GUARD** — the guard's ~0.5 s pause merely made a long-standing loop visible · **IDMAP-ORPHAN-REIMPORT** · **VERHIST-RESTORE-IDENTITY** — restore is fork-only, so the fork's rows get new ids and the identity map must be carried, dropped or REMAPPED; the bytes are captured either way · **CCSED-260911**.

### 11 · What this session did not touch

The import-apply sites · the fifteen unwired commit points · the Save Version button · FIELD-CONTRACT leg 3b · MMM-CAT · 2-MIG-c · AUTH-RESETPAGE · the eight queued layouts · DOCKET-STALEACTIVE's six closed-but-live rows.

---

*End of the September 11, 2026 thirteenth append. HEAD **`951557c`**, pushed, origin identical — ONE production deploy. `Minotaur-Cowork` carries this close. **Migration ledger 58.** Suite **3088 / 160**, zero skipped. Frozen **3/3 vs `be0769de`**. Visual **28/28**, no baseline event. `CLAUDE.md` **115,579 of 150,000**, untouched. **Roadmap v4.28 retires v4.27; Architecture Prompt v35 retires v34.** In flight: **nothing.***
