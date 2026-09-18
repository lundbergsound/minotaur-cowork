# BATCH-FRONTDOOR — four front-of-house fixes and two wander sites, one unit

Tier: 3
Model: claude-opus-5
Session: FRESH

*Arch, Cowork main line, 2026-09-18 12:10 ET. HEAD `fcdeb2a` = `origin/main`. Migration ledger
**77** — SET-FORM was applied and measured by Arch minutes before this was written; **the database
is quiet and nothing else is measuring, so your visual gate may run** (GATE-SETTLE-BETWEEN
satisfied). Every citation below was read at `fcdeb2a` by Arch at the time of writing.*

**⚠ Every answer you need is in this file. There is no blank for anyone to fill in.**

---

## §0 · HARD STOPS

1. **NO MIGRATIONS, NO SQL DDL.** Ledger is 77. Nothing here changes the schema. Item (d) writes an
   ordinary row through the existing `import_runs_insert` policy.
2. **MAILGATE.** Nothing sends mail. Nothing provisions accounts.
3. **NO PRINT GEOMETRY CHANGES** beyond item (b)'s left column. Every `DIE.*` constant and every
   numeric in `src/lib/print/` stays byte-identical.
4. **Raw Output Rule, every command whose output matters:** *"Reproduce the complete raw output
   verbatim — into the handoff file's RAW OUTPUT section if the project uses one, otherwise inline.
   Do not summarize, paraphrase, or describe it. Show every line."*
5. **GATE-NOGREP.** Never pipe a gate run through a filter. Write it to a file, read the file.
6. **Expected gate result: 28/28, NO baseline event.** If any frame moves outside a registered
   wander site, that is a defect in this unit, not a baseline to write. Stop and report.
7. **Commit only on Daniel's `COMMIT APPROVED: <first words of the subject>`** at the terminal,
   after his browser gate. The push is a production deploy.

---

## §1 · Census — what rides, and what was taken out

| Member | Pedigree | Rides |
|---|---|---|
| (w) two wander-registry edits | (a) Arch ruling of record `Minotaur-Cowork/drafts/260917-1440_font-urbanist_OQ1-RULED-WANDER.md` (a)+(b), ruled in FONT-URBANIST's round and deferred to this unit | ✅ first |
| (a) CABLEDEL-FAILMSG | (a) Daniel, 2026-09-17, wording verbatim below | ✅ |
| (b) LETTERHEAD-TOPLEFT | (a) Daniel, 2026-09-17; (b) `~/Minotaur_v1_exports/equipment/220820-1346_v1_shop-perishables_1776-NY_top-left-logo_filemaker.pdf` p.1; spec `Minotaur-Cowork/drafts/260917-1145_letterhead-topleft_SPEC.md` §4 | ✅ |
| (c) BUILD-STAMP | Row ruled (Roadmap v4.45 BATCH-FRONTDOOR (c)); **the display format is (c) PROPOSAL**, marked below | ✅ |
| (d) IMPORT failure record | Ledger 26th append, "Migration 76 … ONE HALF ONLY": the surviving-record half is app code and rides this unit | ✅ |
| migration 77's file of record | Arch-landed, untracked: `supabase/migrations/20260918160720_rls_read_policies_set_form.sql` | ✅ staged into this commit by filename, unedited |

Taken out: **BATCH-HOUSEKEEPING** (its three test projects are Daniel's word, not yet given, and its
error-flag sweep is not ruled to a mechanism) · **SETTINGS-PAPERWORK-PREVIEW** and
**LETTERHEAD-COMPOSITE** (declared baseline event / Trigger A — not this unit's).

---

## §2 · CP0 — verify before any edit

Quote each of these into RAW OUTPUT and confirm it still reads as cited. If any has moved, stop.

- `src/components/cable/CableListClient.tsx:3054` —
  ``setActionError(`Delete aborted — the pre-delete cleanup failed: ${e.message}`)``
- `src/lib/cable/cableDeleteFlow.ts:140` — `return { ok: false, failedId: id, deleted, message: … }`
- `src/components/equipment/PrintEquipmentListClient.tsx:1189-1201` (left text block:
  `projectName` + `venueLine`), `:1203-1213` (right image, `maxWidth: 336, maxHeight: 48,
  objectFit: 'contain'`), `:1860-1878` (right image path → `signedUrlFor`)
- `src/components/chrome/MenuPageLoader.tsx:295` — `buildDate={new Date().toLocaleDateString(…)}`
- `src/components/chrome/MenuFooter.tsx:43` — `<div …>v {buildDate}</div>`
- `scripts/visual-capture.mjs:575-597` — `pinProjectMenuDate`, text-regex anchored `^v M/D/YY$`
- The three import-apply call sites: `ImportV1Client.tsx:1082`, `workbook/WorkbookImportModal.tsx`,
  `workbook/WorkbookLibraryImportModal.tsx` (each calls the `import_apply_v1` RPC)
- `screenshots/diff-exceptions.json` — site `subpixel-wander/box-nesting-error-single-px`,
  `frames: ["11-box-nesting-error-dark"]`, bbox `184,358`

---

## §3 · CP1 — (w) the wander registry, before any source edit

1. **Widen site 4.** `subpixel-wander/box-nesting-error-single-px` gains `11-box-nesting-error-light`
   in `frames`. Bbox, Δ and maxPixels unchanged. Rewrite its `reason` to record: seen on dark since
   2026-08-15; seen on light at the identical pixel `184,358`, Δ1, in 2 of 4 FONT-URBANIST gate runs
   (2026-09-17); widened on observation.
2. **Register site 5, provisional.** New entry `subpixel-wander/box-type-plus-mid`, `provisional:
   true`, `frames: ["12-box-type-plus-light"]`, **bbox `146,108`–`188,109`** (spans BOTH
   sightings — `146,108–185,109` in ADDENDUM-3's run and `149,108–188,109` in ADDENDUM-4's, 7 px
   each, Δ1), `maxChannelDelta: 1`, `maxPixels: 14` (double the twice-measured 7, the site-2
   convention). `refineBy`: the first gate run that measures it again, or H3. `reason` cites both
   runs by date and names the 3 px x-drift as why the box is a span, not a point.

Run the gate. Expected 28/28.

---

## §4 · CP2 — (a) the cable-delete failure message, and (d) the failed-import record

**(a)** Replace the message at `CableListClient.tsx:3054` with Daniel's words, verbatim, then the raw
error on its own line:

> Delete aborted. Minotaur hit an error partway through, so the cable is still here — but its
> tails, lines and link groups may already have changed or been removed. Reload the page and check
> them before you carry on, then try the delete again. If it keeps happening, check your connection.
>
> Details: `<e.message>`

Every claim in it is true of `runPreDeleteCascade` at HEAD: lines and tails are re-homed, a
no-survivor cable's tails are deleted outright, partner patch fields are swept and link groups
dissolved, each committed separately **before** the cable delete. If the error surface cannot show a
line break, render the two parts as two lines by whatever means that surface already supports; do
not shorten the wording. **Cable delete only** — `BundleListClient.tsx:995` also calls the cascade;
if its failure path shows a different message, leave it and name it in the return.

**(d)** Today a failed import leaves nothing to read: the `'running'` row is written inside the
transaction that rolls back (Ledger, migration 76). Add one shared helper and call it from all three
apply sites **only when the `import_apply_v1` RPC itself returns an error or throws** — not when the
pre-apply snapshot guard fails, because then the apply never started.

- Capture `startedAt = new Date().toISOString()` immediately before the RPC call.
- On failure, insert one `import_runs` row: `project_id`, `source_label` (the same value passed to
  the RPC), `file_manifest` and `counts` where the site has them (else the column defaults),
  `dry_run: false`, `status: 'failed'`, `started_at: startedAt`, `finished_at: new Date().toISOString()`,
  `created_by: <the signed-in user id>`, `notes: <the error message, verbatim>`.
  Columns and the `status` check (`running | succeeded | failed`) read live by Arch 2026-09-18.
- **Best-effort and never masking:** if the record write itself fails, `console.warn` and move on.
  The operator must still see the original import error exactly as today.
- Unit-test the helper, including that a failed record write does not replace the import error.
- **Prove it once for real:** force one apply failure on a project the harness test user owns (any
  mechanism that makes the RPC refuse — a stale fingerprint is the natural one), read the row back
  with its `id`, `status`, both timestamps and `notes`, and leave the row in place. Name the project
  and row id in the return.

Run the gate. Expected 28/28.

---

## §5 · CP3 — (b) the top-left print logo

Per spec §4, which is the whole instruction:

1. Resolve `projects.top_left_image_url` exactly as the right slot is resolved (`:1860-1878`,
   stored object path → `signedUrlFor`, including its never-blocks-print-data behaviour).
2. Render it in the header's **left** column, **left-aligned**, at `maxWidth: 336, maxHeight: 48,
   objectFit: 'contain'` — the right slot's box, other side. That is v1's stated rule: 3.5" × 0.5",
   scale, not stretch.
3. ⚠ **When a top-left image is present it REPLACES the `projectName` / `venueLine` block.** Not
   above it, not beside it.
4. When absent, the header renders exactly as today.

`Visual Gate Fixture.top_left_image_url` is null, so frame 07 photographs the no-image path.
**If frame 07 moves, the no-image path was altered — defect, not baseline.** Cable Parity Fixture has
both slots set: print its equipment list and attach the PDF (Chrome Save-as-PDF, 100%) to the return.

Run the gate. Expected 28/28.

---

## §6 · CP4 — (c) the build stamp

Today the footer's `v` is the operator's own date (`MenuPageLoader.tsx:295`). Nothing reads
`VERCEL_GIT_COMMIT_SHA`.

1. In `next.config.js`, expose at build time `NEXT_PUBLIC_BUILD_SHA` (first 7 chars of
   `VERCEL_GIT_COMMIT_SHA`, empty when absent) and `NEXT_PUBLIC_BUILD_TIME` (the build's ISO time).
2. **(c) PROPOSAL, Daniel confirms at his browser gate:** the footer reads
   **`v 9/18/26 · fcdeb2a`** — the build's date as M/D/YY in `America/New_York`, then the short sha.
   With no sha (local, harness) it reads **`v dev`**.
3. ⚠ **The gate's clock-pin finds the stamp by text regex and fails hard if it is absent.** Give the
   stamp's leaf `data-build-stamp` and change `pinProjectMenuDate` to find it by that attribute,
   still overwriting it to the literal `v 1/1/26`. Frame 01 is then unchanged, and the pin no
   longer depends on what the stamp says. Keep the fail-hard.

Run the gate. Expected 28/28.

---

## §7 · Close

- Full suite, frozen gate, visual gate at the last checkpoint; raw output per §0.4.
- Return to `handoffs/from-cc/` as DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT.
- Stage by explicit filename, including `supabase/migrations/20260918160720_rls_read_policies_set_form.sql`
  unedited. Proposed subject: `BATCH-FRONTDOOR: top-left print logo, build stamp, cable-delete message, failed-import record`.

**Daniel's browser gate (after deploy preview or local, his choice):**
1. Cable Parity Fixture → Print Equipment List: the top-left logo stands where the show name was.
   Vape! → Print: unchanged (top-right only, show name present).
2. Project menu footer: reads as §6.2 — and whether he wants that format.
3. As the non-owner editor on Cable Parity Fixture: equipment list and box list open noticeably
   faster than yesterday (SET-FORM, already live).
