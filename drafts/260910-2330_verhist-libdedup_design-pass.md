# VERHIST-LIBDEDUP — the design pass, measured

*Cowork-Arch, 2026-09-10 23:30 UTC. Opened as VERHIST's first act, per the ruling of 2026-09-10 that VERHIST is the next unit and that its seventh question is a LEAN, not a ruling. **Every number below is a live read from `musfmquwwjlggyxckpos` taken in this session; nothing is carried.***

---

## 0 · Where it lands

**The trade Daniel was asked to weigh is not the trade.** The question was posed as *dedup saves 1.71 MB of every 5.38 MB snapshot, at the cost of reference-counted expiry inside the retention path R-V2 depends on.* ⚠ **Measured, the cost disappears — because the equipment library essentially never changes, library blobs can simply NEVER BE EXPIRED, and retention stays a plain date delete.** No reference counting, no orphan class, no new failure mode in the path a restore depends on.

**This did not need a decision. It needed a measurement.**

---

## 1 · The measurements

| # | Measure | Value |
|---|---|---|
| **M1** | Library payload, BVSC **US Tour** `57874c69` | **2,594 rows · 1,712,688 bytes of JSON text** — confirms the carried "1.71 MB" exactly |
| **M1b** | Library payload, BVSC **Mexico City** `cf780353` | **2,634 rows · 1,738,082 bytes** — *larger* than the US Tour, and the carried figure named only the Tour |
| **M2** | ⚠ **Stored `jsonb` cost after TOAST — the number the parallel left UNMEASURED and the one retention actually needs** | **~26–28% of JSON text length.** 56 real stored rows in `equipment_list_revisions`, band **22.9% – 30.3%**, aggregate **28.0%** |
| **M3** | ⚠ **Library CHURN — the decisive one** | **Across all EIGHT projects holding a library, THREE ROWS IN TOTAL have ever been edited after creation** (`updated_at > created_at + 2s`: 0 · 0 · 1 · 1 · 1 · 0 · 0 · 0). Libraries arrive with the import and are left alone |
| **M4** | `equipment_list_revisions` today | **56 rows** · 5,936,043 bytes text · **1,661,898 bytes stored** · relation 1952 kB |
| **M5** | `equipment_library_items` relation | **8336 kB** across all projects |
| **M6** | Database | **40 MB** of 8 GB |

### ⚠ M2a — my own first instrument was wrong, and I caught it by going to a stored column

The first attempt measured `pg_column_size(jsonb_agg(to_jsonb(l)))` over the library and returned **96.6% of text length** — i.e. "TOAST buys nothing." **That is false, and the reason is that `pg_column_size` on a COMPUTED, in-memory datum reports the uncompressed value: TOAST compression happens on WRITE, so only a value that has actually been stored can report its stored cost.** Re-measured against a real stored `jsonb` column — `equipment_list_revisions.snapshot`, 56 rows written by the product itself — the answer is **~26%**.

*A measurement taken on an object that was never stored cannot report a storage cost.* Same family as this session's other four: **an instrument that answers a question adjacent to the one asked.** Recorded rather than quietly corrected.

### ⚠ M4 is a correction — and running the propagation check turned it into a SECOND, WORSE finding that is mine

**The claim I first wrote here was that `equipment_list_revisions` "holds 2.78 MB in seven rows" appears in the Docket's LEGAL-SEP row and in Roadmap v4.26's Docket Sweep.** ⚠ **Both were false, and I asserted them from memory instead of searching. *A memory of where a claim lives is not a search* is the propagation check's own opening line, and this is the fifth instance of this session's shape — the first one committed by this seat tonight.**

Searched: the string exists in **exactly one place in the corpus — `Minotaur_v2_Roadmap_v4_25.md`'s Docket Sweep line**, and v4.25 is retired. `LEGAL-SEP`'s own Docket row reads only *"September attorney engagement; addendum §F scope"* in both v4.25 and v4.26 and has never carried the detail. The Session Log carries it nowhere.

⚠ **WHICH MEANS THE REAL FINDING IS A LOSS I INTRODUCED TONIGHT.** v4.26's Docket Sweep is a line I wrote, replacing v4.25's — and in replacing it I dropped *"LEGAL-SEP now carries TWO items: version history's retention window and `equipment_list_revisions`, which grows on every revision print with no retention rule."* **That fact is now recorded in no live document.** Retiring a Roadmap moves its sweep line out of reach, so **a fact carried only in a sweep line dies with the version that carried it.**

**OWED AT THIS SESSION'S CLOSE, with the text written out so it cannot be missed** — `LEGAL-SEP`'s Docket row becomes:

> `| LEGAL-SEP | September attorney engagement; addendum §F scope. ⚠ **It now carries TWO technical items:** VERHIST's **retention window**, and **`equipment_list_revisions`, which grows on every revision print and has NO retention rule** — measured 2026-09-10 at **56 rows / 5,936,043 bytes of JSON text / 1,661,898 bytes stored**, against the **"2.78 MB in seven rows"** of record, which was stale by 8× on the count | September 2026 |`

⚠ **NOT fixed by bumping to v4.27 tonight.** v4.26 is thirty minutes old, committed and pushed; a version bump for one row is the churn KNOW-HYG exists to avoid. **But a correction that lands only in a draft is inert, so this is registered as owed AT THE CLOSE rather than deferred to a session that might not read this file.** *A row is durable; a sweep line is not.*

---

## 2 · What the numbers actually say

Restated in **stored** bytes rather than JSON text length, which is the only unit retention can be sized in:

| | JSON text | Stored (at 26%) |
|---|---|---|
| Whole snapshot, US Tour | 5,390,551 B (5.39 MB) | **≈ 1.40 MB** |
| — of which the library | 1,712,688 B (1.71 MB) | **≈ 0.45 MB** |
| — everything else | 3,677,863 B | ≈ 0.96 MB |

**The library is 31.8% of the payload** — the ratio the carried framing gave — **but the absolute numbers are roughly FOUR TIMES SMALLER than the text-length framing implies.** A year of hourly snapshots was never going to be measured in gigabytes.

**And M3 is what changes the design.** If the library never changes, then a content-hash blob table produces **one row per project, ever.** Dedup is not "save 1.71 MB per snapshot at the cost of complexity" — it is **"store 0.45 MB once instead of 0.45 MB every hour," and the complexity is optional.**

---

## 3 · The shape, and why it needs nothing new in the retention path

- **`project_library_blobs (project_id, content_hash, payload jsonb, created_at)`**, primary key `(project_id, content_hash)`.
- **`snapshot_project_v1`** hashes the library rows, `INSERT … ON CONFLICT DO NOTHING` into the blob table, and writes `library_hash` onto the snapshot row. **One extra statement, no read-modify-write, no lock held across the hash.**
- **Restore ("Open as new production")** joins the blob back by `(project_id, library_hash)`.
- ⚠ **Retention is UNCHANGED: `delete from project_snapshots where …` on date alone. Blobs are never deleted.**

**That is the whole point.** Reference-counted expiry was the cost, and it is declined rather than paid: **the failure mode it introduces — deleting a blob a live snapshot still needs, which silently corrupts every snapshot referring to it — is exactly the class R-V2's viability cannot absorb, and it buys back a quantity measured at 0.45 MB.**

**Bounding the unbounded growth by measurement rather than by machinery:** at the measured edit rate a project accrues ~1 blob. **A pathological user re-importing weekly for a year reaches 52 × 0.45 MB ≈ 23 MB for that project** — against 8 GB, and observable with one `count(*)`.

---

## 4 · ⚠ The honest limits, stated WITH the recommendation and not after it

1. **The 26–28% ratio is measured on PRINT-SHAPED revision snapshots, not on the DATA-SHAPED payload VERHIST will write.** The shapes are similar — repetitive objects with shared keys, which is what compresses — so ~26% is a reasonable **expectation**. ⚠ **It is not a measurement of the object VERHIST creates. Re-measure on the first real snapshot before retention is sized.** (TENSE-IS-A-CLAIM.)
2. ⚠ **"The library never changes" is measured on EIGHT projects over THREE months, every one of them Daniel's own or a fixture.** A beta user who curates a library is **not in that sample.** The *design* survives a higher edit rate — more blobs, each small, retention still untouched — but **the number does not transfer and must not be quoted as if it did.** (CORPUSBOUND-AUDIT, which is precisely this.)
3. **A table that never expires wants a WATCH, not a bound.** One Docket row: re-measure blob count and total size at private-beta start.
4. **Not measured and not asserted:** whether hashing ~2,600 library rows inside `snapshot_project_v1` fits the `authenticated` 8-second statement timeout alongside everything else the snapshot does. ⚠ **That is APPLY-TIMEOUT's exposure on the SNAPSHOT half, already registered, and it is a prerequisite of this function rather than of the restore.** It gets rehearsed, not assumed.

---

## 5 · Rulings

**Arch rules, and it is recorded as Arch's:** ⚠ **The equipment library is content-hash deduped into `project_library_blobs`, and library blobs are NEVER EXPIRED — retention stays a date-only delete on snapshots.** Storage architecture inside the tooling is engineering structure, so this is Arch's under the Parity Rule rather than Daniel's, and **it is his to overrule.** *Not asked, so not "approved" — stated, so it is on the record before it is built.*

**Daniel's, and it is one word:** his **lean** that the equipment library belongs in snapshots at all. The measurement supports it at **≈0.45 MB once per project** rather than per snapshot. ⚠ **Until he says so it stays a LEAN and the Parity Rule holds: nothing is built against it.**

**Unblocked by this pass:** VERHIST-MIG (Arch, Trigger B, rehearsal-first) can be scoped as soon as that one word lands.

---

*End of the VERHIST-LIBDEDUP design pass. HEAD `31b4c26`; `Minotaur-Cowork` `f46860f`. Migration ledger **57**. ⚠ **THREE things owed at this session's close, two of them this seat's own errors caught inside this pass:** (1) `LEGAL-SEP`'s Docket row gains the text in §1, because v4.26 dropped it — **a fact carried only in a sweep line does not survive the version that carried it**; (2) the standing note that **`pg_column_size` on a computed value does not report a storage cost — TOAST happens on write**; (3) the watch row re-measuring blob count and size at private-beta start.*
