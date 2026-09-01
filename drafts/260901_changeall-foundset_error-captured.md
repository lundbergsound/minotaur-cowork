# CHANGEALL-FOUNDSET — THE ERROR, CAPTURED

*Arch, Cowork seat, 2026-09-01. The checkpoint the opener made a hard return:
capture the error before designing the fix. It is captured. **It is a
request-size answer, so this is the "chunk the ids" branch, not the hard
return.***

## 1 · The answer

**An edge request-size ceiling on the URL. Not a timeout, not the database,
not PostgREST.**

A rejected request returns a bare **`400` with the plain-text body
`Bad Request`** and **no `server` header**. A request one id smaller returns a
**PostgREST JSON error** with `server: cloudflare`. The rejection therefore
happens at the edge, *before* PostgREST is reached — which is why nothing in
`runPlainChangeAll` could ever have explained it, and why no database-side
instrument would have found it.

Measured in Daniel's browser against the live project, `GET` and `PATCH` alike,
random UUIDs, publishable key:

| encoding | method | last pass | first fail |
|---|---|---|---|
| quoted uuids (supabase-js's own) | GET | **581 ids**, 22,741 chars | **582 ids**, 22,780 chars |
| quoted uuids | PATCH | **581 ids**, 22,731 chars | **582 ids**, 22,770 chars |
| unquoted uuids | GET | **676 ids**, 25,094 chars | **677 ids**, 25,131 chars |

**⚠ THE THRESHOLD IS BYTES ON THE WIRE, NOT A ROW COUNT.** supabase-js wraps each
uuid in `"`, which the browser percent-encodes to `%22` — 43 wire bytes per id
against the unquoted 37. Both encodings fail at **≈25.0 KB of encoded request
target**: 582 × 43 ≈ 25,026 and 677 × 37 ≈ 25,049. The two row counts differ by
95 and the byte figure agrees to within 25 bytes.

**So "the threshold is somewhere in (72, 1368]" is not merely imprecise — it is
the wrong SHAPE of fact, and recording a row number would go stale on the next
thing that touches the URL.** The budget is shared with every header on the
request, so **a real user's session JWT (~800 chars) buys a LOWER ceiling than
the 40-character publishable key used here.** 582 is an upper bound on what
Daniel sees, not the number he sees.

At 2,000 ids (78 KB) the connection is refused outright rather than answered.

## 2 · Three leads formed and DISPROVED, none of which reached a finding

1. **nginx's 8 KB request line.** Predicted the cliff at ~205 ids. **Wrong** — a
   53,434-character URL reaches PostgREST unauthenticated and is answered 401.
2. **`statement_timeout = 8s` on `authenticated`** (the setting is real, and
   APPLY-TIMEOUT is on the Docket for it). **Wrong by three orders of
   magnitude.** Rehearsed as `authenticated` with the JWT claim set, inside a
   transaction forced to roll back: **72 rows 28.5 ms · 1,368 rows 62.6 ms.**
   Residue check after rollback: 1,368 generic rows, 150 twos, **zero rows with
   `updated_at` after the probe.**
3. **RLS cost.** `equipment_items_read` and `equipment_items_write` both call
   `auth.uid()` unwrapped, and Supabase's own linter flags both by name
   (`auth_rls_initplan`, WARN — **53 tables project-wide**). Real, worth its own
   housekeeping row, and **not the cause of this**: see the 62.6 ms above.

*Recorded because the mitigation that keeps working is writing a claim as a lead
that must be proven. All three were written that way and all three died at the
first measurement.*

## 3 · ⚠ A CONTRADICTION AT THE BOUNDARY, NOT RESOLVED — AND IT IS TWO ROWS WIDE

`Cable Parity Fixture` today holds **584 generic rows** whose method name
contains `main` (593 across all four types; the equipment list's found set is
`filtered`, the whole set, confirmed at `EquipmentListClient.tsx:2163` — no
windowing).

**Daniel's METHODNULL experiment was `Method contains "main"` and the write
SUCCEEDED**, blanking the found set. **584 is above the 582 ceiling, and a real
session JWT lowers the ceiling further.** By this measurement that request
should have been rejected.

Not guessed. The candidates, in order of cheapness to settle:

- the found set at the time was smaller than it is now — tonight's re-import
  restored the blanked methods and need not have restored exactly the prior set;
- the ceiling moves with the request, and something in that request was smaller.

**One experiment settles it and it takes a minute: run Method Change All on a
found set of ~100 rows on a throwaway and confirm it blanks.** Until then, the
*mechanism* above is measured and the *exact row at which Daniel crosses it* is
not.

## 4 · ⚠ WHAT THIS DOES TO THE EXPOSURE — IT IS MUCH WIDER THAN RECORDED

Three governing documents say the masking makes this safe at scale: *"at 1,368
the write fails so nothing is blanked; at 72 it succeeds and blanks silently."*
**The true reading is that everything below roughly five hundred rows is already
unmasked and losing data** — which is most real working found sets, not a narrow
edge. Daniel's two experiments happened to straddle the ceiling within two rows,
and that coincidence is why the two defects read as one story.

**The sequencing ruling is unchanged and is now better supported:** chunking the
ids removes the ceiling entirely, after which METHODNULL blanks at *every* size.
METHODNULL's guard lands first or with it.

## 5 · ⚠ BLAST RADIUS — THE IDIOM IS ON EVERY LIST SURFACE, AND SOME OF IT DELETES

`.update(...).in('id', ids)` / `.delete().in('id', ids)` is the standing
fan-out idiom project-wide, not an equipment-list local:

- `EquipmentListClient.tsx:1830` (`propagateFieldToIds`), `:2115`
  (`runPlainChangeAll`), `:2141`
- `CableListClient.tsx:875 · 891 · 914 · 920 · 939 · 1911 · 1913 · 3035 · 3339 · 3544`
- `LineListClient.tsx:1119` · `TailListClient.tsx:790` ·
  `EquipmentLibraryClient.tsx:322` · `BoxListClient.tsx:879 · 889 · 915 · 1269`
- **⚠ DELETES on the same shape:** `TailListClient.tsx:670` ·
  `CableListClient.tsx:2880 · 3007 · 3043` · `BoxListClient.tsx:1089`
- `BundleListClient.tsx` **reads as BINARY to grep** (the CONTRAST-PAIR rider)
  and is unswept here.

**Every one of these fails the same way above the same ceiling, and a delete that
silently does nothing is worse than an update that flashes red.** A fix that
lands only in `runPlainChangeAll` fixes one call site out of twenty-plus.

## 6 · THE FIX HAS A PRECEDENT ALREADY SHIPPING, ONE BRANCH OVER

**CHANGEALL-METHODNEW is not new code.** The band editor's bulk path already
does exactly what Daniel ruled, in the same file:

```
EquipmentListClient.tsx:1893
const m = resolved ?? await createMethod(trimmed) // auto-create composes with All N
```

`createMethod` is at `:793`. So the doctrine — **method auto-creates; box and
category revert on no match** (`:1897-1899`, creation is ⊕-only) — is already
built, deliberate, and commented. `executeChangeAll` at `:2254-2262` is the one
path that has none of it and nulls the FK instead.

**That is the recorded defect class exactly** — a field needing a resolve
doctrine sitting in the arm that has none — and it means the fix copies a
shipping behaviour rather than inventing one.

## 7 · THE ONE THING THAT IS DANIEL'S

Two ways to lift the ceiling, and they differ in who does the work:

**(A) Chunk the ids client-side.** No migration, CC can do it today. **Costs
atomicity:** 1,368 rows becomes N requests, and if request 4 fails, 1–3 are
already written while `runPlainChangeAll` reverts *all* ids optimistically — the
screen would then disagree with the database. That is a new defect the naive fix
introduces, and it needs a deliberate partial-failure story.

**(B) One RPC taking the id array in the POST body.** No URL ceiling ever, one
statement, one transaction, atomic — and the database does 1,368 rows in
**62.6 ms measured**. But it is a schema change: **Trigger B, Arch's, rehearsal
first, and it cannot ride inside a CC run.**

**Either way, `runPlainChangeAll` must stop discarding the error** — it reads
only `error` and paints the flash. Had the message ever been surfaced, this
would have been a five-minute finding rather than a two-session one.

---

*Measured 2026-09-01 from the Cowork seat: browser probes in the in-app browser
against `musfmquwwjlggyxckpos.supabase.co` (read-only `GET`, and `PATCH` with
random UUIDs against a role holding no grant — `42501` on every reaching
request, so nothing was written); database timings as `authenticated` inside a
transaction forced to roll back, with a residue check after. No git run in
either mount.*
