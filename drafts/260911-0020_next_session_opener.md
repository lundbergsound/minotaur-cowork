# Next session opener — Cowork-Arch, written 2026-09-11 00:20 UTC

*Written at the close of the v4.26/v4.27 repair-and-design session. **Paste the block in §0 into a fresh Arch chat.** Everything below §0 is for the seat, not for Daniel.*

---

## 0 · ⚠ WHAT DANIEL PASTES — nothing else is needed

```
Open the Minotaur Arch seat.

Read, in this order, from ~/Developer/Minotaur-Cowork/:
  1. Architecture_Prompt_v34.md
  2. Minotaur_v2_Roadmap_v4_27.md
  3. Minotaur_v2_Session_Log.md
  4. drafts/260911-0020_next_session_opener.md   <- this file, §1 onward
  5. drafts/260910-2330_verhist-libdedup_design-pass.md

NO ROLLOVER IS DUE — the log stands at 4 and it fires at 10.
NO ROADMAP OR LEDGER IS OWED — v4.27 and the twelfth append are installed and current.

THE UNIT IS VERHIST-MIG. It is a MIGRATION: Trigger B, Arch's, rehearsal-first,
and I confirm explicitly before the apply. Branch-or-main is my call.

Verify state from files first (never from memory, never from packed-refs), run the
production READY check with me, then design the migration from LIVE INTROSPECTION
AT SOURCE - not from the notes in these files. Tell me in plain English where we
are before you propose anything.
```

---

## 1 · What is settled, so none of it is re-opened

**VERHIST is RULED SEVEN OF SEVEN.** Restore is **fork-only**, always a copy · **hourly with skip-if-unchanged**, retention **48h / 30d / weekly** · **snapshot before Change All, Delete Found, Delete All and import apply, plus a manual Save Version** · ⚠ **if the snapshot fails, the gesture REFUSES** · History under **⚙ PROJECT → History** · ⚠ **the equipment library IS included, content-hash deduped, and its blobs are NEVER EXPIRED** (Daniel, 2026-09-11).

**Ruled means settled. None of the seven is re-argued.** ⚠ **And nothing is owed from Daniel until the APPLY** — do not open the session by asking him to rule something he has already ruled. That failure has its own entry two sessions back.

**The shape, ruled by Arch and his to overrule:** `project_library_blobs (project_id, content_hash, payload jsonb, created_at)`, PK `(project_id, content_hash)` · `snapshot_project_v1` hashes the library, `INSERT … ON CONFLICT DO NOTHING`, writes `library_hash` on the snapshot row · restore joins the blob back · **retention is a date-only delete on snapshots and never touches blobs.**

## 2 · ⚠ State as measured at close — RE-MEASURE, do not trust these

| Measure | At close, 2026-09-11 00:20 UTC |
|---|---|
| Code repo `main` | **`31b4c26`** — UNCHANGED this session; no code was written |
| Cowork repo `main` | **`f46860f`** at the open; this close adds one commit |
| Suite | **2980 tests / 157 files** — carried, **not run this session** |
| Migration ledger | **57 — UNCHANGED for TEN units** (live-read and byte-matched at this open) |
| `CLAUDE.md` | **115,579 characters** of 150,000 — untouched |
| Session Log | **4 entries — rollover clear**, fires at 10 |
| Production READY | ⚠ **NOT VERIFIED. Last recorded is `LATEST READY c525a55`, 2026-09-08 — FIVE deploys ago** |

⚠ **Read HEAD from `.git/refs/heads/main`, never `.git/packed-refs`** (GIT-CFG). ⚠ **Never run `git` in either repo folder** (O-1). ⚠ **`CLAUDE.md`'s limit is CHARACTERS (`wc -m`); `wc -c` reads ~1,200 higher and has misled this project once.**

⚠ **RUN THE PRODUCTION CHECK EARLY.** `node scripts/vercel-preopen.mjs` is Daniel's to run and it has not been run in five deploys. **A WF-1a push is a production deploy, so the check is load-bearing the moment a commit is in prospect — and this unit ends in one.**

## 3 · ⚠ THE UNIT — VERHIST-MIG, and the three things that must be measured before it is designed

**Trigger B fires on sight: this creates tables, functions and grants.** The runbook is not optional and not reorderable: **live introspection at source → proof-run with forced rollback → residue check proving the rollback clean → Daniel confirms → apply → post-apply verification INCLUDING GRANTS AND PRIVILEGE LEVEL.**

⚠ **DESIGN FROM THE DATABASE, NOT FROM THESE FILES.** Everything below is a lead written at 00:20 on the night before; the Surface Rule says only the generated types describe the database and only a measurement describes what moved. **Re-read every object named here at source in the session that writes the migration.**

1. ⚠ **THE APPLY-TIMEOUT EXPOSURE IS ON THE SNAPSHOT HALF AND IT IS THE PREREQUISITE, NOT A FOLLOW-UP.** `authenticated` carries `statement_timeout = 8s`; the design puts `snapshot_project_v1` **in front of** Change All, Delete Found, Delete All and import apply. **Hashing ~2,600 library rows plus serialising a 5.39 MB payload inside that budget is UNMEASURED.** ⚠ **REHEARSE, DO NOT PATCH — Postgres arms the statement timeout when the statement BEGINS, so setting it inside the function may not lift a timer already running; the reliable lever is role-level and raises the ceiling for EVERY request the app makes, which is a real tradeoff and Daniel's on a measurement.** ⚠ **And the ruling makes this sharper than it looks: if the snapshot fails the gesture REFUSES — so a snapshot that times out does not degrade, it BLOCKS Change All.**
2. **`pg_cron` is 1.6.4 AVAILABLE, `installed_version` NULL** — measured 2026-09-08, re-measure. Installing an extension is part of the migration and part of Trigger B.
3. **Five tables carry no `updated_at`** (`cable_details · tail_details · box_details · link_groups · link_group_members`) — **and more than five lack it, which is why skip-if-unchanged compares CONTENT and not clocks.** Re-measure the list; the payload's definitive table set is still unsettled and the 5.39 MB figure is a **FLOOR** because thirteen tables were included.

**Engineering standards that bind this one specifically:** grants restored whenever objects are recreated, **with privilege-level verification in the migration smoke** · `SECURITY INVOKER` unless there is a stated reason otherwise, `authenticated` only, `anon` refused — the precedent is ledger 57's four RPCs · **never destructive without explicit confirmation.**

## 4 · Numbers this unit will want, measured 2026-09-11 and each one re-checkable

- Library payload: **US Tour `57874c69` — 2,594 rows / 1,712,688 bytes JSON text.** **Mexico City `cf780353` — 2,634 rows / 1,738,082 bytes**, i.e. *larger* than the Tour.
- **Stored `jsonb` after TOAST: ~26–28% of JSON text length** (56 stored rows, band 22.9–30.3%, aggregate 28.0%). **So a 5.39 MB snapshot is ≈1.40 MB stored and the library share ≈0.45 MB.**
- **Library churn: THREE rows edited after creation across ALL EIGHT projects holding a library, ever.**
- `equipment_list_revisions`: **56 rows / 5,936,043 B text / 1,661,898 B stored / relation 1952 kB.** Database **40 MB of 8 GB**.

⚠ **TWO OF THESE ARE EXPECTATIONS WEARING THE CLOTHES OF MEASUREMENTS AND THE DIFFERENCE MATTERS (TENSE-IS-A-CLAIM).** The ~26% ratio is measured on **print-shaped** revision snapshots, **not** on the data-shaped payload this unit creates — **re-measure it on the first real `project_snapshots` row before retention is sized.** And the churn figure is taken **entirely on Daniel's own projects and fixtures over three months**; a beta user who curates a library is not in that sample (VERHIST-BLOBWATCH, CORPUSBOUND-AUDIT).

⚠ **TOAST-ON-WRITE, earned by this seat getting it wrong last session: `pg_column_size` on a COMPUTED value reports the UNCOMPRESSED datum, because compression happens on WRITE.** It returned 96.6% for a payload whose real cost is ~26%. **Measure storage on a column the product has actually written, or say plainly that the number is an expectation.**

## 5 · ⚠ REGISTER — the shape that has failed three times in three sessions

**A question a seat can answer must never reach Daniel.** Twice on 2026-09-10 he was handed multiple-choice cards in seat shorthand and answered *"what does this mean?"* to both. The correction that worked was to explain from first principles in plain English **and to route the question correctly in the first place: the Parity Rule sends UX to Daniel; an enforcement boundary or a storage layout inside the tooling is engineering structure and is Arch's.**

**His standing instruction is unchanged: keep CC working on things that do not need his attention, log every gate and ruling for later, and do not ask him to run gates.** ⚠ **Every identifier gets a gloss on first use or it does not appear. Every message ends with ONE plain-language next step.**

## 6 · Do not do these

- **Do not re-open any of VERHIST's seven rulings.** They are settled, and the seventh was settled with the measurement in front of him.
- **Do not build reference-counted expiry.** It was declined on measurement, not overlooked. Blobs are never deleted; retention is a date-only delete on snapshots.
- **Do not put `snapshot_project_v1` in front of a destructive gesture until the 8-second budget is REHEARSED** — the refuse-on-failure ruling turns a slow snapshot into a blocked Change All.
- **Do not chunk the import apply.** It destroys the atomicity that made a failed import harmless. (APPLY-TIMEOUT.)
- **Do not build on `frozen-check.sh`** or count it as a control (FROZENCHECK-FAILOPEN).
- **Do not treat v4.27's ▶ ACTIVE table as fully current** — six rows in it are closed and still live, deliberately, and named in DOCKET-STALEACTIVE. ⚠ **`CLAUDEMD-ATLIMIT` still reads "IMMEDIATE. No build unit runs before it" and that is FALSE.**
- **Do not re-import the parity fixture** to restore `num_labels` before someone looks at what ran **2026-09-01 13:03 UTC** (FIXTURE-NUMLABELS-GONE).
- **Do not sweep the 105 dead `text-surface-*` classes**, and **do not add the four new dark tokens to `tailwind.config.js`** — that single edit activates ~110 dead classes app-wide.
- **Do not open FENCE-HEREDOC inside another unit.** Consciously left a sixth time.
- **Do not treat a green machine gate as consent**, and do not fold a refused run into a pass/fail count.
- **Do not write intermediates through the session output path** — they mirror into the code repo. `Claude outputs/` came back on 2026-09-10 while a CC session was live (ARCH-OUTPUTS-MIRROR, REPO-STRAY-UNTRACKED).

## 7 · Owed at Daniel's desk

⚠ **The one that gates the product: AUTH-RESETPAGE.** `minotaur.app` has **no page that completes a password reset** — measured at source; a recovery email's link is valid and lands on the sign-in page with nowhere to go. **It gates public beta on its own** and it is the only registered item whose absence a paying user can see.

⚠ **His alone, with a deadline: the auto-mode rider's Sprint 4 sunset.** While it stands, `perl -i`, `gawk -i inplace` and `ruby -i` can edit **any repo file with no control at all** — an argument for letting it expire rather than extending it (SEDRULE-REMAINDER, pinned as OPEN battery cases 15/16/136/137).

**Two minutes, and it stops a recurring annoyance:** three ignore lines and one delete in the code repo (REPO-STRAY-UNTRACKED).

**Carried, unchanged:** the browser gates **POSTPONED, NOT WAIVED** on leg 3a, HARNESS-SETTLE and DARKMODE-PASS · **DEADCLASS-SURFACE**'s ruling · the **5167 sheet against a real Avery blank**, still the only unrun acceptance on a shipped unit · the **Tail Panel reprint** · **CAND-4 overdue** · **LEGAL-SEP is now**, and it carries **two** technical items: VERHIST's retention window, and `equipment_list_revisions` growing on every revision print with **no retention rule** (measured **56 rows**, not the "seven" of record).
