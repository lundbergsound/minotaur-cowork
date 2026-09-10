
## SEPTEMBER 10–11, 2026 — TWELFTH APPEND — AN ARCH-ONLY SESSION IN TWO HALVES: THE GOVERNING-DOCUMENT REPAIR THE PREVIOUS CLOSE OWED, THEN VERHIST'S OPENING DESIGN PASS · ⚠ VERHIST RULED SEVEN OF SEVEN AND FULLY UNBLOCKED · ⚠ THE COST THE SEVENTH RULING WAITED ON DISSOLVED UNDER MEASUREMENT — THE LIBRARY IS EDITED THREE TIMES ACROSS EIGHT PROJECTS, EVER, SO BLOBS ARE NEVER EXPIRED AND REFERENCE-COUNTED EXPIRY IS DECLINED RATHER THAN PAID FOR · THE `jsonb` ON-DISK COST MEASURED AT LAST AT ~26–28% OF TEXT LENGTH · ⚠ TWO ARCH ERRORS, BOTH SELF-CAUGHT INSIDE THE PASS THAT MADE THEM, BOTH NOW STANDING RULES · ⚠ A SECOND ONE-WRITER BREACH FOUND IN THE CODE REPO, RECURRING BECAUSE THE FIRST WAS MOVED RATHER THAN IGNORED · ONE-SESSION-ONE-ARC HELD AND IS RECORDED AS HELD (append block)

### 1 · What this session was

**No unit shipped. No commit to the code repo. One commit to `Minotaur-Cowork` (`f46860f`).** Two halves, and the first exists only because the previous close did not do it.

⚠ **THE PRE-OPEN RAN IN ORDER THIS TIME, AND THAT IS WORTH RECORDING BECAUSE THE LAST ONE DID NOT.** Seat check first, three mounts confirmed, then state verified from files: HEAD `31b4c26` with origin identical read from `.git/refs/heads/main` and never by running git; `Minotaur-Cowork` at `2839a73`; no orphaned `index.lock` beyond the two known `ORPHANED-` files; **the migration ledger live-read against the database and byte-matched at 57**; `CLAUDE.md` measured with `wc -m` at **115,579 characters** — which matched the close's figure exactly and confirmed the character-vs-byte correction from the eleventh append.

**Production READY was flagged as NOT seat-verifiable and left flagged.** The last recorded check is `LATEST READY c525a55` from 2026-09-08 and **five deploys have landed since**. Nothing was blocked on it because CC is idle, but it is owed at the next pre-open where a push is in prospect.

### 2 · The repair half — v4.26 and the eleventh append

Roadmap **v4.26** installed retiring v4.25, and the **eleventh append** written. ⚠ **Both were owed by the 2026-09-10 close, which installed the Session Log and nothing else** — leaving v4.25 standing as the current Roadmap while carrying neither fence unit.

**The Roadmap was built by COPYING v4.25 and editing it by line index, not by retyping it.** Every carried row is byte-identical by construction rather than by care, and the build asserted 22 line anchors before touching anything. **The Ledger append was proven append-only at the byte level: the first 788,370 bytes of the new file `cmp` clean against the old.** *Full-file delivery exists to prevent transcription drift; a copy-and-edit build removes the transcription entirely.*

⚠ **TWO HYGIENE DEFECTS FOUND BY CHECKING RATHER THAN BY ASSUMING, AND BOTH REGISTERED RATHER THAN SILENTLY REPAIRED.**

**DOCKET-STALEACTIVE.** v4.25's Docket Sweep states *"Retired to the Ledger: FIELD-CONTRACT · FINDPARITY-UNTYPED · DARKMODE-PASS · NEXTENV-CHURN — index 26 → 30."* **None of it happened.** Three are still live rows in ▶ ACTIVE, the index gained no row, and `NEXTENV-CHURN` is in no append at all. Two more sit beside them: `CLAUDEMD-ATLIMIT`, closed in the eighth append, still reads *"⚠ IMMEDIATE. No build unit runs before it"* — **an order that is false** — and `ROADMAP-REFACTOR`, closed in v4.23. ⚠ **NOT repaired in that pass, and the reason was named rather than left to be inferred: retiring FIELD-CONTRACT would drop LEG 3b, which v4.25 declared opened and gated on nine rulings and then never gave a row to.** Scoping leg 3b from the tenth append is the repair's first step, and inventing it inside a pass scoped to something else is the error this Ledger keeps recording.

**REPO-STRAY-UNTRACKED.** Three untracked trees in the CODE repo, **none in its `.gitignore`**, so each shows in `git status` and is excluded by hand on every commit. ⚠ **`Claude outputs/` IS BACK, and two of its four files were written 2026-09-10 at 20:31 and 20:38 UTC — during the FENCE-RULINGS session, while a CC session was live. That is a SECOND breach of the one-writer backstop, and it recurred for a nameable reason: September's instance was MOVED to `_to_delete/` and no ignore line was ever added.** *A breach closed by relocating the evidence is a breach that reopens.* Also: `{src/`, a brace expansion that never expanded, empty but for `.DS_Store`, dated 2026-07-04; and a stray `session-log-archives/` holding one file from before the Cowork split. ⚠ **And the measurement that explains a recurring loss: `Minotaur-Cowork/.gitignore` is TWO LINES — `.DS_Store` and `handoffs/`** — the whole handoffs directory, both directions, which is why files named explicitly in a `git add` are silently not committed.

### 3 · The design half — VERHIST-LIBDEDUP, and a trade that was not the trade

The seventh of Daniel's seven VERHIST questions was a **lean**, not a ruling: *can an unchanged equipment library be stored once across successive snapshots?* It was framed as a trade — **dedup saves 1.71 MB of every 5.38 MB snapshot, at the cost of reference-counted expiry inside the retention path R-V2's viability depends on.**

⚠ **MEASURED, THE COST DOES NOT EXIST.**

| Measure | Value |
|---|---|
| Library payload, BVSC **US Tour** `57874c69` | **2,594 rows · 1,712,688 bytes JSON text** — confirms the carried "1.71 MB" exactly |
| Library payload, BVSC **Mexico City** `cf780353` | **2,634 rows · 1,738,082 bytes** — *larger* than the Tour, which the carried figure never said |
| ⚠ **Stored `jsonb` after TOAST — UNMEASURED since VERHIST was scoped, and the number retention actually needs** | **~26–28% of JSON text length.** 56 real stored rows, band **22.9–30.3%**, aggregate **28.0%** |
| ⚠ **Library CHURN — the decisive one** | **Across all EIGHT projects holding a library, THREE ROWS IN TOTAL have ever been edited after creation** (`updated_at > created_at + 2s`) |
| `equipment_list_revisions` today | **56 rows** · 5,936,043 B text · 1,661,898 B stored · relation 1952 kB |
| Database | **40 MB** of 8 GB |

**Restated in stored bytes, which is the only unit retention can be sized in: a snapshot costs ≈1.40 MB, not 5.39 MB, and the library share is ≈0.45 MB.** The ratios everyone quoted were right — the library is 31.8% of the payload — **but the absolute numbers were roughly four times too large.**

**And the churn figure is what changes the design.** If the library is imported with the show and then left alone, a content-hash blob table produces **one row per project, ever**. So:

- **`project_library_blobs (project_id, content_hash, payload jsonb, created_at)`**, PK `(project_id, content_hash)`.
- **`snapshot_project_v1`** hashes the library, `INSERT … ON CONFLICT DO NOTHING`, writes `library_hash` on the snapshot row.
- **Restore** joins the blob back by `(project_id, library_hash)`.
- ⚠ **Retention is UNCHANGED — a date-only delete on snapshots. Blobs are NEVER deleted.**

⚠ **REFERENCE-COUNTED EXPIRY IS DECLINED RATHER THAN PAID FOR, AND THAT IS THE POINT.** Its failure mode — deleting a blob a live snapshot still needs, which silently corrupts every snapshot referring to it — sits in exactly the path a restore depends on, and it would buy back a quantity measured at 0.45 MB. **The unbounded growth is bounded by measurement instead of by machinery**, and a watch row (**VERHIST-BLOBWATCH**) replaces the bound.

**Honest limits, stated with the recommendation rather than after it:** the ~26% ratio is measured on **print-shaped** revision snapshots and not on the **data-shaped** payload VERHIST will write, so it is an **expectation** until re-measured on a real `project_snapshots` row (TENSE-IS-A-CLAIM) · **the churn measurement is taken entirely on Daniel's own projects and fixtures over three months** — a beta user who curates a library is not in that sample, and the design survives a higher rate but the *sizing* does not (CORPUSBOUND-AUDIT) · **whether hashing ~2,600 library rows fits inside `authenticated`'s 8-second statement timeout alongside the rest of the snapshot is NOT measured** — that is APPLY-TIMEOUT on the snapshot half, and it gets rehearsed.

### 4 · Rulings of record — this append

⚠ **Daniel, 2026-09-11 — THE SEVENTH AND FINAL VERHIST RULING: THE EQUIPMENT LIBRARY GOES INTO SNAPSHOTS.** Asked with the measurement in front of him — **≈0.45 MB once per production rather than per snapshot** — he answered **yes**. **VERHIST is now ruled seven of seven, the Parity Rule's bar is met, and nothing is owed from him until the apply.**

**Arch, and recorded as Arch's:** ⚠ **the equipment library is content-hash deduped into `project_library_blobs`, and library blobs are NEVER EXPIRED — retention stays a date-only delete on snapshots.** Storage architecture inside the tooling is engineering structure, so it is Arch's under the Parity Rule rather than Daniel's. **It was stated to him before it was built, and it is his to overrule.**

**Arch, sequencing:** ⚠ **VERHIST-MIG was unblocked mid-session and deliberately NOT opened.** ONE-SESSION-ONE-ARC, and this session had already installed a Roadmap, written a Ledger append and run a design pass; **the 2026-09-08/10 arc is logged four appends back as a defect for stacking four units under one session.** Separately, a migration runbook opens on **live introspection at source**, not on the notes of the session that scoped it. **It opens in a NEW session on a fresh opener.**

### 5 · ⚠ Two Arch errors this session, both self-caught inside the pass that made them

**(1) TOAST-ON-WRITE — a storage measurement that measured nothing about storage.** `pg_column_size(jsonb_agg(to_jsonb(l)))` over the library returned **96.6% of text length**, i.e. *"compression buys nothing."* ⚠ **`pg_column_size` on a COMPUTED, in-memory datum reports the UNCOMPRESSED value, because TOAST compression happens on WRITE.** Re-measured against a column the product actually writes — `equipment_list_revisions.snapshot`, 56 stored rows — the answer is **~26%**. *A measurement taken on an object that was never stored cannot report a storage cost.* **Now a standing rule.**

**(2) SWEEPLINE-NOT-DURABLE — a propagation claim asserted from memory, whose search found a loss this seat had just caused.** The draft claimed a stale figure lived in LEGAL-SEP's Docket row and in v4.26's Docket Sweep. ⚠ **Both false.** Searched, the string existed in **exactly one place: v4.25's Docket Sweep — a line v4.26 replaced.** ⚠ **So building v4.26 dropped a live fact: that LEGAL-SEP carries `equipment_list_revisions`, which grows on every revision print with no retention rule. It was then present in no live document at all**, and was found only because a propagation search was run on an unrelated correction. Repaired in v4.27, **in LEGAL-SEP's own row, where it is durable**, with the figure corrected from *"2.78 MB in seven rows"* to a measured **56 rows**.

⚠ **NEW STANDING RULE — A FACT CARRIED ONLY IN A DOCKET SWEEP LINE DIES WITH THE ROADMAP VERSION THAT CARRIED IT.** A sweep line summarises one session; the next version rewrites it and the retired file is out of reach. **Anything that must outlive one session goes in a ROW.** *And the error beneath it is the propagation check's own opening line — a memory of where a claim lives is not a search — broken by the seat that had quoted it two hours earlier.*

**Both errors share this session's own recorded shape and the previous one's: an instrument answering a question adjacent to the one asked.** *Sixth and seventh occurrences.*

### 6 · Registered this append

**VERHIST-BLOBWATCH** (ACTIVE — the watch that replaces a bound) · **TOAST-ON-WRITE** (STANDING) · **SWEEPLINE-NOT-DURABLE** (STANDING).

**Retired to the Ledger:** **VERHIST-LIBDEDUP** — the design pass ran and the cost it was registered to price does not exist. **The index table moves 28 → 29.**

**Repaired:** **LEGAL-SEP**'s row, per §5(2).

### 7 · What this session did not touch

FIELD-CONTRACT leg 3b and its nine rulings · MMM-CAT · 2-MIG-c · EXPORT-HISTID-DROP · BOX-DOC-PARITY · the eight queued layouts · CORPUSBOUND-AUDIT · **FENCE-HEREDOC, consciously left a SIXTH time** · AUTH-RESETPAGE, FROZENCHECK-FAILOPEN and HARNESS-SIGNOUT, all registered the previous session and all still open · every print item, which terminate at Daniel's printer.

---

*End of the September 10–11, 2026 twelfth append. HEAD **`31b4c26`**, UNCHANGED this session, pushed, origin identical — no code was written. `Minotaur-Cowork` **`f46860f`** at the open, and this close adds one commit. **Migration ledger 57 — UNCHANGED for TEN consecutive units.** Suite **2980 / 157**, unchanged and unrun this session. `CLAUDE.md` **115,579 characters**, untouched. Session Log **4 entries, rollover clear, fires at 10**. Roadmap installed as **v4.27, retiring v4.26**. ⚠ **Next: VERHIST-MIG — Arch's, Trigger B, rehearsal-first, Daniel confirms explicitly before the apply — in a NEW session on a fresh opener.***
