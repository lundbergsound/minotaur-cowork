# TERMS-ACCEPT — the terms page, the sentence under the button, and the record

Tier: 3 (Claude Code)
Session: **FRESH.** Runs only after CHANGEALL-MODEL-SERIAL is committed and pushed (Daniel's gate, 2026-09-14). Open clean.

**Unit:** what the adopted beta terms need before they can be published — and publication is what makes them in force, and the invite cannot go out before that. Three checkpoints, one commit, plus the fence. No mail (MAILGATE), no new dependency, no environment variable, **no migration in this run — the table already exists (migration 60, applied by Arch 2026-09-13 with Daniel's confirm).**

- **CP1 — the record and the sentence.** On the set-password page: one sentence and a link directly below the button; when the button is pressed, an acceptance row is written **before** the password is set.
- **CP2 — the published terms.** `minotaur.app/beta-terms`, readable signed out, showing `Version 1.0 · published <date>`.
- **CP3 — the migration file of record and the generated types.**

The wording and the placement rules are ruled (Daniel, 2026-09-13) and reproduced in §1. **Build to that text; do not reword it.** The placement is what makes the notice bind — it is a requirement, not styling.

---

## Precondition — return at once if it fails

`HEAD` = `refs/heads/main` = `refs/remotes/origin/main`, HEAD's subject begins `perf(equipment): CHANGEALL-MODEL-SERIAL`, tree clean but for the two pre-existing untracked trees. **Read the ref files; do not run git for this** — the last two sessions ran `git status` here and disclosed it; the rule stands. Migration ledger live-read: **60**, latest **`20260913182602 terms_acceptances`**. `CLAUDE.md` `wc -m` — write down what you measure (expected 109,777). No `.git/index.lock`.

---

## 0 · What exists today — measured by Arch on 2026-09-13 at `3416650` (the CHANGEALL commit does not touch these files; re-measure anyway)

**The set-password page** — `src/app/account/password/page.tsx`, **111 lines**, `'use client'`. `handleSave` `:33-58`: mismatch check `:36-39`, `updateUser({ password })` `:44`, failure mapping `:49-53`, then `clearAllMenuTabs()` and `/dashboard` `:55-57`. The form `:67-108`; the submit button `:105-107` is the form's last child; the only other link on the page is the conditional `sendNewEmail` inside the error box `:99`. Every string from `AUTH_COPY`; classes from `authFormClasses.ts` (`AUTH_LINK = 'text-brand-400 hover:text-brand-300'` at `:60` — **no underline**).

**The table** — `public.terms_acceptances` (`id uuid pk`, `user_id uuid → auth.users on delete cascade`, `terms_version text`, `accepted_at timestamptz default now()`, `user_agent text`), RLS on, policies `terms_acceptances_insert_own` (insert, `user_id = auth.uid()`) and `terms_acceptances_select_own`; grants insert+select to `authenticated`, nothing to `anon`; index `(user_id, accepted_at desc)`. Zero rows. **`user_id` has no default — the insert must pass it.**

**The types** — `src/types/database.ts` is hand-owned and re-exports `./database.generated`; `npm run db:types` (`package.json:11`) regenerates only `database.generated.ts`. The generated file does not yet know `terms_acceptances`.

**The middleware** — `src/lib/supabase/middleware.ts:82-95`: a signed-out request on any path other than `/auth*`, `/` and `/api/waitlist` is sent to `/auth/login`; `:106-110` sends a signed-in request on `/auth*` or `/` to `/dashboard`. `middleware.test.ts:109-139` pins the carve-outs (`/api/waitlist`, `/`).

**The copy module** — `src/lib/auth/resetCopy.ts`, `AUTH_COPY`; `resetSurface.test.ts` scans the set-password page for prose outside `AUTH_COPY` and for `aria-label|title|placeholder|alt` attributes, and checks every `AUTH_COPY` key is used.

**The terms text** — `handoffs/to-cc/260913-1500_terms-accept_BETA_TERMS_v1_0.md`, beside this file: 113 lines, twelve numbered sections, byline at `:3` reading `**Daniel Lundberg Sound Design LLC · Version 1.0 · published [DATE]**` — **`[DATE]` occurs exactly once.** Line 13 is the sentence the product must make true: *"You accept these terms by setting your password … Minotaur records which version you accepted and when."*

**The visual gate** captures neither the set-password page nor any new route; no frame should move.

---

## 1 · CP1 — the sentence, the placement, the record

**Pedigree (a): Daniel, 2026-09-13** — `260913-1336_terms-acceptance-copy.md` (project knowledge), reproduced here.

**The sentence, exactly:**

> By setting your password, you accept the [Minotaur v2 Private Beta Terms](https://minotaur.app/beta-terms).

**The six placement rules — each is a requirement:**
1. **Directly below the button** — inside the form, immediately after the submit button, nothing between them.
2. **Visible without scrolling** wherever the button is visible, phone width included. Measure at 390×844 and 1600×1000 in the smoke: if the button is in the viewport, the sentence is.
3. **Body-text size and contrast** — `AUTH_BODY`'s `text-sm` and its `text-surface-300` (11.19:1 / 8.37:1 on this frame, measured 2026-09-12); not smaller, not dimmer.
4. **The link looks like a link** — `AUTH_LINK` **plus `underline`**, `target="_blank"` and `rel="noopener noreferrer"`, so the form state survives the trip.
5. **Nothing between them** — no tooltip, no accordion, no "learn more."
6. **No competing links** — the only other link on the page stays the conditional `sendNewEmail` in the error box.

**Copy:** three `AUTH_COPY` keys in a `// ── set-password page: terms` block, so the sentence renders as `{termsBefore}<a>{termsLink}</a>{termsAfter}` with no raw JSX text: `termsBefore: 'By setting your password, you accept the '`, `termsLink: 'Minotaur v2 Private Beta Terms'`, `termsAfter: '.'`. The href is a constant, `BETA_TERMS_PATH = '/beta-terms'`, rendered relative (same origin) — the ruled text's absolute URL is the production origin of that path.

**The record — pure layer first.** New `src/lib/auth/acceptTerms.ts` exporting one function the page calls, e.g. `acceptTermsThenSetPassword(client, { password, userAgent })`:
1. `client.auth.getUser()` → the `user.id` (the page is signed in by construction; a null user → the existing `sessionEnded` failure, restart true).
2. `client.from('terms_acceptances').insert({ user_id, terms_version: BETA_TERMS_VERSION, user_agent })`. **If this errors, stop: return the `saveFailed` failure and never call `updateUser`.** No password without a record.
3. `client.auth.updateUser({ password })`; on error, `updatePasswordFailure(error)` as today. (A failed step 3 after a successful step 2 leaves a row and no new password; the retry writes a second row. That is accepted and honest — they did press the button.)
`BETA_TERMS_VERSION` comes from the legal module in CP2, never retyped here. The page's `handleSave` shrinks to: mismatch check, call the function, map the result.

**Tests for CP1:** `acceptTerms.test.ts` against a faked client — insert is called before `updateUser` (record the call order); an insert error returns `saveFailed` and `updateUser` is **never** called; a null user returns `sessionEnded`; the insert carries `terms_version === BETA_TERMS_VERSION` and the user's id. `resetSurface.test.ts`: the three new keys pass the orphan check; a source-scan pin that the set-password page's sentence sits inside the form immediately after the `type="submit"` button and that the anchor carries `underline`, `target="_blank"` and `rel="noopener noreferrer"`; positive controls for each. Deletion controls: swap the order of steps 2 and 3 → the order test goes red; drop `underline` → the placement pin goes red.

## 2 · CP2 — the published terms at `/beta-terms`

1. **File of record:** copy `260913-1500_terms-accept_BETA_TERMS_v1_0.md` to `docs/legal/BETA_TERMS_v1_0.md`, replacing the one `[DATE]` with the publication date **Daniel gives in the phrase message** (the deploy day, written as `September 14, 2026` or whatever day it is). Nothing else in the file changes; state its `sha256` before and after in the return.
2. **The text in code:** `src/lib/legal/betaTerms.ts` exporting `BETA_TERMS_VERSION = 'Version 1.0'`, `BETA_TERMS_PATH = '/beta-terms'`, and `BETA_TERMS_MD` — the file's text as a string constant. **A test pins `BETA_TERMS_MD` byte-equal to `docs/legal/BETA_TERMS_v1_0.md`** and pins that the file's byline contains `BETA_TERMS_VERSION`. (Reading the file at request time on Vercel depends on output tracing; a pinned constant does not. If you find a cleaner mechanism that provably survives the Vercel build, use it and say so.)
3. **The page:** `src/app/beta-terms/page.tsx`, a server component, no client code, rendering `BETA_TERMS_MD` through a small in-repo renderer for exactly the subset the file uses — `#`/`##` headings, paragraphs, `**bold**`, `[text](url)` links, and the `---` rule — **no new dependency.** Plain readable typography inside the auth frame's tones (re-export `@/app/auth/layout` as `account/layout.tsx` does, or a sibling layout — your judgment), max width for reading, and the whole document on one page. A test renders it and asserts every non-blank line of the markdown appears in the text content once markdown syntax is stripped.
4. **The middleware — Arch's ruling, the one licensed edit:** `/beta-terms` joins the signed-out carve-outs at `:88-91` beside `/` and `/api/waitlist` (an `isTermsRoute = pathname === '/beta-terms'`), and **is not added** to the signed-in bounce at `:106` — a signed-in operator may read the terms. Two new cases in `middleware.test.ts`: signed-out `/beta-terms` → no redirect; signed-in `/beta-terms` → no redirect. The 3,000 ms bound and everything else in the file stay byte-identical; say so with a diff.

## 3 · CP3 — the migration of record and the types

1. Write `supabase/migrations/20260913182602_terms_acceptances.sql` containing **exactly** the SQL below — it is what Arch applied; the file is a record, not a run. Do not apply anything.
```sql
-- TERMS-ACCEPT (Arch, 2026-09-13; Daniel confirmed the table 2026-09-13).
-- One row per acceptance of the beta terms, written by the operator from the
-- set-password page BEFORE the password is set. Append-only from the app:
-- insert and select for the owner, no update or delete policy. terms_version is
-- the byline string of the published page, e.g. 'Version 1.0'. Rehearsed with a
-- forced rollback and a residue check before this apply; migration 60.
create table public.terms_acceptances (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  terms_version text not null,
  accepted_at timestamptz not null default now(),
  user_agent text
);
comment on table public.terms_acceptances is 'TERMS-ACCEPT (2026-09-13): one row per acceptance of the beta terms, written by the operator from the set-password page before the password is set. Append-only from the app: insert and select for the owner, no update or delete policy. terms_version is the byline string of the published page, e.g. ''Version 1.0''.';
create index terms_acceptances_user_idx on public.terms_acceptances (user_id, accepted_at desc);
alter table public.terms_acceptances enable row level security;
create policy terms_acceptances_insert_own on public.terms_acceptances for insert to authenticated with check (user_id = auth.uid());
create policy terms_acceptances_select_own on public.terms_acceptances for select to authenticated using (user_id = auth.uid());
revoke all on public.terms_acceptances from anon, authenticated;
grant insert, select on public.terms_acceptances to authenticated;
revoke truncate on public.terms_acceptances from service_role;
```
2. `npm run db:types`. The diff to `src/types/database.generated.ts` must add `terms_acceptances` and nothing else — show it. **If the command cannot authenticate, stop and return; Arch supplies the generated file. Do not hand-edit the generated file.**

## 4 · Step 1 of the run — the fence

Replace the whole body under `## Current run fence` in `CLAUDE.md` with this unit's; quote the removed body verbatim in RAW OUTPUT; `wc -m` after ≤ before, both reported.

## 5 · Preconditions that are not yours

- **The publication date** is Daniel's, given in the phrase message; until then leave `[DATE]` in place and say so — the commit does not happen without it.
- **MAILGATE.** Nothing sends. The smoke uses `TEST_USER_EMAIL` only.
- **Provisioning and the invite** are Daniel's; nothing here creates an account.

## 6 · Hard stops — return, do not proceed

Schema, function, RLS or grant needs beyond what migration 60 already provides · any dependency change · a new environment variable · frozen-layer contact · **any middleware edit other than the one line in §2.4** · a second home for operator-facing text outside `AUTH_COPY` · hand edits to `database.generated.ts` · credentials · `--update-baselines`. ⚠ **Single-file edits go through the Edit tool, no exceptions** (CCSED-260911).

## 7 · Gates and close

`npm test` · `npm run type-check` · `node scripts/frozen-gate.mjs` · `npm run build` · `npm run test:visual`, plus the browser smoke on the throwaway. **Raw Output Rule — verbatim:** *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every line."* **A number in the return is a measurement or it is not written.**

**Smoke:**
- Signed out: `/beta-terms` returns 200 and shows the byline with the date; `/account/password` still redirects to sign-in.
- Signed in as the test user: `/beta-terms` renders (no bounce); `/account/password` shows the sentence directly under the button; at 390×844 and 1600×1000 the sentence's bounding box is inside the viewport whenever the button's is; the link opens `/beta-terms` in a new tab.
- The record: on the throwaway, as the test user, submit the **same** password the harness already uses. Expected: the insert succeeds (one row, select-own shows it), `updateUser` answers `same_password`, the mapped sentence shows, **the harness credential is unchanged.** Report the row's `id` and `accepted_at`; Arch removes it at the close. Then intercept the insert to fail: the `saveFailed` sentence shows and **no `updateUser` request is made** (assert from the network log).
- Census 0 by name at the end, re-verified by SELECT.

**Expected FILES CHANGED** (a difference is reported, not absorbed):
```
CLAUDE.md
docs/legal/BETA_TERMS_v1_0.md                          (new)
supabase/migrations/20260913182602_terms_acceptances.sql (new)
src/app/beta-terms/page.tsx                             (new)
src/lib/legal/betaTerms.ts                              (new)
src/lib/legal/betaTerms.test.ts                         (new)
src/lib/auth/acceptTerms.ts                             (new)
src/lib/auth/acceptTerms.test.ts                        (new)
src/app/account/password/page.tsx
src/lib/auth/resetCopy.ts
src/lib/auth/resetSurface.test.ts
src/lib/supabase/middleware.ts
src/lib/supabase/middleware.test.ts
src/types/database.generated.ts
```
plus whatever file holds the markdown renderer and the terms page's layout, named.

**Commit — WF-1a.** Follow the COMMIT BLOCK in `CLAUDE.md`, step 0 included. Subject begins `feat(terms): TERMS-ACCEPT`. Commit on `COMMIT APPROVED: feat(terms): TERMS-ACCEPT`, **which must also carry the publication date.** Push on the same phrase — **this deploy is the publication; the terms are in force when Vercel shows it READY.**

**Daniel's browser gate — four checks on localhost:**
1. Signed out, `/beta-terms` opens and reads `Version 1.0 · published <date>`.
2. On the set-password page, the sentence sits right under the button, readable, the link underlined; the link opens the terms in a new tab and the form is still filled when you come back.
3. On your phone (or the browser narrowed to phone width): when the button is on screen, so is the sentence.
4. Sign-in still works.

**Success condition:** the set-password page carries the ruled sentence at the ruled placement; an acceptance row is written before any password is set and none is set without one; `/beta-terms` serves the file of record with the date, signed out or in; the middleware differs by one carve-out and its two tests; the migration file and the generated types match the live database; the fence carries this unit; the five gates are green; the commit exists and is pushed on the phrase; the `_CLOSE.txt` names the gate and the date.
