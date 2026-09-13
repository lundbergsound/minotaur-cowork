# TERMS-ACCEPT — design (Arch, 2026-09-13)

*Status: proposal. Trigger B — one new table. Daniel confirms the schema before the migration rehearses; the CC unit follows the migration. The terms are ADOPTED (2026-09-13) and NOT in force; this unit is what lets them be published.*

## What the terms need (from the parallel's RETURN, ruled by Daniel)

1. On the set-password page, directly below the button: *"By setting your password, you accept the [Minotaur v2 Private Beta Terms](https://minotaur.app/beta-terms)."* — with the six placement rules in `260913-1336_terms-acceptance-copy.md` as requirements.
2. A record, written when the password is set: the account, the version string **exactly as the published page shows it** (`Version 1.0`), and the moment.
3. The terms published at `minotaur.app/beta-terms` with `[DATE]` replaced by the publication date.

## What exists (measured 2026-09-13 at `3416650`)

- The set-password page is `src/app/account/password/page.tsx` (111 lines): signed in by construction, one form, one button, `updateUser({ password })`, then `/dashboard`. Its classes come from `authFormClasses.ts`; its strings from `AUTH_COPY`; a test forbids prose outside that module.
- Nothing in `src/` records terms acceptance (zero occurrences).
- `profiles` has two policies, both self-only (`auth.uid() = id`): read and update. No insert policy — the row is made by `handle_new_user()` on `auth.users` insert.
- The middleware (`src/lib/supabase/middleware.ts:91-95`) sends every signed-out request on a non-`/auth` path to `/auth/login`, with `/` and `/api/waitlist` as the only exceptions. **`/beta-terms` does not exist and, if it did, a signed-out reader would be bounced to sign-in.** The invite links the page, so it must be public.

## The record — three ways, one recommended

**A · A table, `terms_acceptances`. Recommended.**
`id uuid pk default gen_random_uuid()` · `user_id uuid not null references auth.users(id) on delete cascade` · `terms_version text not null` · `accepted_at timestamptz not null default now()` · `user_agent text null`. RLS on; **insert** where `user_id = auth.uid()`; **select** where `user_id = auth.uid()`; no update, no delete policies — the row is append-only from the app's side. Grants to `authenticated` on insert/select only. Index on `(user_id, accepted_at desc)`.
Why a table and not columns on `profiles`: a column holds one acceptance; November's terms change will want the history, and a row that cannot be updated or deleted by its owner is a better record than a column that can.

**B · Two columns on `profiles`** (`terms_version`, `terms_accepted_at`). Fewer objects, same migration ceremony, and the self-update policy already lets the user overwrite them later — a weaker record for no less work. Rejected.

**C · No schema: user metadata** (`updateUser({ password, data: { terms_version, terms_accepted_at } })`). Zero migration, one call. But user metadata is the user's to rewrite at any time from the client, so it records a claim, not an event, and it goes to counsel as "we stored it where the user can edit it." The parallel's whole argument for storing anything was a record you can't reconstruct later; C is a record you can't trust later. **Fallback only** if the migration cannot land before the invite.

## Order of operations on the page — record first, password second

When the button is pressed: insert the acceptance row, then `updateUser({ password })`. If the insert fails, the password is **not** set and the operator sees the existing `saveFailed` sentence — no password without a record, and no record without a password only if the second call fails, which leaves a row with no password set; that case is harmless (they try again and a second row is written) and honest (they did accept). The version string comes from one constant, `BETA_TERMS_VERSION = 'Version 1.0'`, used by the page byline and the insert, with a test that the terms file's byline contains it.

## The published page — `/beta-terms`

- The publish copy lands in the repo as `docs/legal/BETA_TERMS_v1_0.md` (the file of record, byte-identical to project knowledge's `BETA_TERMS_v0_2_PUBLISH.md` with `[DATE]` replaced). A server component at `src/app/beta-terms/page.tsx` renders it. No new dependency: the markdown subset is headings, paragraphs, bold, links, and short lists, and a small in-repo renderer covers it, with a test that every non-blank line of the file appears in the rendered text.
- **Middleware, one line, Arch's ruling:** `/beta-terms` joins the public exceptions beside `/` and `/api/waitlist`. Signed-in readers see it too (it is not under `/auth`, so no bounce). This is the one middleware edit CC is licensed to make in this unit, and the test file that pins the middleware gains one case for it.
- The byline date is the deploy date, given by Daniel in the commit message as the publication date. Adopted becomes in force when that deploy is READY.

## What this asks of Daniel

1. **Confirm the schema (Trigger B):** table A as above. Then Arch rehearses the migration (live introspection, proof-run with forced rollback, residue check), shows the result, and applies on the confirm.
2. **The four July accounts:** the note in `260913-1336_terms-acceptance-copy.md` §3, sent after publication, by Daniel, one MAILGATE approval per send.
3. **The publication date** — the day the TERMS-ACCEPT commit deploys; say it in the phrase message.

## Docket movements this design proposes

- **TERMS-ACCEPT** — ▶ ACTIVE, gate ≈Sept 18: migration 60 (Arch), then one CC unit (page sentence and record, `/beta-terms`, middleware exception, byline date). Registered today; it was not in v4.33.
- **PRIVACY-POLICY** — new row, Daniel, before the v1-holder beta (target 2026-10-15): §12 of the adopted terms promises it in writing. Its own parallel opener, on the beta-terms pattern.
- **GBL-527A** — new row under LIC-NOV: pre-renewal notice 15–45 days before the cancellation deadline, cancellation as easy as sign-up, a retainable acknowledgment after purchase. A build requirement for the November checkout, verified against the statute by the parallel.
- **BETA-INVITE** — carries the two-sentence terms fragment (§2 of the acceptance copy) and, since §11 was deleted, any confidentiality ask now lives there or nowhere (Daniel's call).
- **LEGAL-SELFDRAFT** — gains the six-line checklist from the RETURN's Task 0; no Legal Prompt.
- **LEGAL-SEP** — the attorney packet list (RETURN, Task 3, nineteen items) is the scope for the week of Oct 5.
- Roadmap NOW/NEXT — Daniel's words; the proposed three lines are in chat.
