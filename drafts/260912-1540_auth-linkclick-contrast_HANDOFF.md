# AUTH-LINKCLICK + AUTH-SIGNIN-CONTRAST — the front door, finished

Tier: 3 (Claude Code)
Session: **FRESH.** The AUTH-RESETPAGE session ended when its commit landed. Open clean.

**Unit:** two small fixes to the flow AUTH-RESETPAGE built, bundled into one run (HANDOFF-BUNDLE), plus the run-fence replacement that FENCE-COUNTS makes step 1 of the next handoff. Two checkpoints, one commit. Nothing here sends mail (MAILGATE), touches the middleware, the schema, a dependency or an environment variable.

- **CP1 — AUTH-LINKCLICK.** The emailed link lands on a page that does nothing until the operator presses a button; only that press verifies the token.
- **CP2 — AUTH-SIGNIN-CONTRAST.** The two unreadable lines on the sign-in page, its error box, and the raw vendor error it prints.

---

## ⚠ Precondition — return at once if it fails

*Amended 2026-09-13 by Arch after CC's precondition return (`from-cc/260912-1544_auth-linkclick-contrast.md`): AUTH-RESETPAGE is now committed and pushed as `57e0eec` and READY on Vercel; §2 gains one string from Daniel's browser gate. Nothing else changed.*

**`HEAD` = `refs/heads/main` = `refs/remotes/origin/main` = `57e0eec` (subject `feat(auth): AUTH-RESETPAGE …`), and the tree is clean** but for the two pre-existing untracked trees (`"Claude outputs/"`, `docs/reference/evidence/equipment/`), which are not yours. Read the ref files; never run git for this. If HEAD is anything else, **stop and return.**

Also at the open: migration ledger live-read (expected **59**, latest `20260911165516`; no migration in this unit); `CLAUDE.md` `wc -m` (expected **117,288** — write down what you measure); no `.git/index.lock` (the two `ORPHANED-index.lock.*` files are registered under GIT-CFG and are not yours).

---

## 0 · What exists today — measured by Arch on 2026-09-12 on the UNCOMMITTED AUTH-RESETPAGE tree

⚠ Every line number below was read on CC's uncommitted tree, not at a commit, so **none of it is "true at HEAD" yet** (O-4). Re-measure each at your open before writing; the Surface Rule outranks this section.

**The link's landing today**
- `src/app/auth/confirm/route.ts` — **42 lines, GET only.** `parseConfirmParams` at `:28`, `verifyOtp(params)` at `:33` **on the request itself**, success → `SET_PASSWORD_PATH` at `:34`, everything else → `LINK_FAILED_PATH` at `:41`. Its header comment (`:5-25`) holds the `token_hash` ruling and the template shape; **keep that text, move it with the mechanism.**
- `src/lib/auth/resetFlow.ts` — 140 lines. `CONFIRM_PATH = '/auth/confirm'` `:19` · `FORGOT_PATH` `:23` · `LINK_FAILED_PATH` `:26` · `SET_PASSWORD_PATH = '/account/password'` `:34` · `CONFIRM_TYPES` `:46` · `parseConfirmParams(searchParams: URLSearchParams)` `:50-57` · `recoveryRedirectTo` `:72-74` (appends `CONFIRM_PATH` to the serving origin, no query) · `requestOutcome` `:103-105` · `verifyCodeMessage` `:112-116` · `updatePasswordFailure` `:128-140`.
- `src/app/auth/forgot/page.tsx` — 17 lines: the pattern for a thin server shell that awaits `searchParams` and renders a client component. **Copy the shape.**
- `src/app/auth/layout.tsx` — 7 lines, the auth frame; anything under `src/app/auth/` gets it for free.
- `src/lib/supabase/middleware.ts:91-95` sends a signed-out request on any non-`/auth` path to `/auth/login`; `:106-110` sends a signed-in request on any `/auth*` path to `/dashboard`. **Not touched by this unit.** Both facts fix where the new page can live: it must stay under `/auth/`.
- The email template shape the code expects (`confirm/route.ts:20-21`): `{{ .RedirectTo }}?token_hash={{ .TokenHash }}&type=recovery`. ⚠ **This unit does not change the URL the email carries.** AUTH-DASHBOARD's instructions (CC's return, OQ-10) stand as written.

**The sign-in page**
- `src/app/auth/login/page.tsx` — **110 lines.** `setError(error.message)` at `:25` (the raw vendor string; measured on the live host it reads "Invalid login credentials"). Subtitle `<p className="text-surface-400 text-sm">Sign in to your account</p>` at `:40`. Error box `:75-79`: `text-red-400 text-xs bg-red-950/40 border border-red-800 rounded px-3 py-2`. "No account?" line `:102`: `text-surface-500`. **Six dead classes, in file order: `:40 text-surface-400`, `:53 border-surface-600`, `:54 placeholder-surface-500`, `:68 border-surface-600`, `:69 placeholder-surface-500`, `:102 text-surface-500`.**
- `src/components/auth/authFormClasses.ts` — 60 lines. `AUTH_BODY = 'text-surface-300 text-sm'` `:27` · `AUTH_ERROR` `:54` (`text-surface-50 text-xs bg-surface-800 border border-red-500 rounded px-3 py-2`) · `AUTH_LINK` `:60`.
- `src/lib/auth/resetCopy.ts` — 76 lines; `AUTH_COPY` is the one home for operator-facing text in this flow; a test fails on an orphan key and on prose outside it.
- `tailwind.config.js:33-42` — `surface` has steps 0/50/100/200/300/800/900/950 and nothing between; a `*-surface-400…700` class emits no CSS (DEADCLASS-SURFACE).
- **Contrast, measured by CC on 2026-09-12 with computed styles, both themes:** `:40` and `:102` **1.19:1 light / 1.20:1 dark**; `text-surface-300` on the same frame **11.19 / 8.37**; the sign-in error box **1.03:1 under `.dark`**; `AUTH_ERROR` **10.65 / 9.24**; `brand-400` links **6.73 light / 2.42 dark**. `.dark` reaches signed-out operators from the OS preference (`src/app/layout.tsx:30`).

**The tests that pin today's shape — every one of these changes in this unit**
- `src/lib/auth/authRoutes.test.ts` imports `GET as confirm` from `@/app/auth/confirm/route` and tests four behaviours: a recovery link verifies and lands on the set-password page; an invite link does the same; the PKCE exchange is never attempted; a refused or thrown verify lands on `LINK_FAILED_PATH`.
- `src/lib/auth/resetSurface.test.ts` — `CONFIRM = 'src/app/auth/confirm/route.ts'` `:24` · the six-site dead-class pin `:54-64` (an exact array, in file order) · the JSX-prose positive control on the sign-in page `:80` ('Sign in to your account') · the `.message` positive control `:113` (asserts the sign-in page DOES read `.message`) · the mechanism pin `:122-126` (`verifyOtp(` present, `exchangeCodeForSession` absent, in `CONFIRM`).

**`CLAUDE.md`**
- `## Current run fence` at `:1474`. Its body carries a **2026-09-08 unit (FIELD-CONTRACT leg 3a)** and its own dated note at `:1520` says the count is stale and that *"replacing it with the current one is the job of the next unit that touches this file."* That is this unit — §3.

---

## 1 · CP1 — AUTH-LINKCLICK. The link opens a page; a press verifies.

**The defect (CC's return OQ-2, Ledger seventeenth append §2):** `{{ .TokenHash }}` is a hash of `{{ .Token }}` — the link and the six-digit code are one token — and `/auth/confirm` verifies on GET. A mail scanner that prefetches the link spends the token, and the code the operator then types is already spent.

**The ruling — pedigree (a):** Daniel, Roadmap v4.33, ⏭ NEXT 1 and the AUTH-LINKCLICK row: *"the link opens a page that verifies only on a click."* Mechanism below is Arch's (2026-09-12); the `token_hash` + `verifyOtp` ruling from AUTH-RESETPAGE stands unchanged.

**Build exactly this:**

1. **`/auth/confirm` becomes a page.** Delete `src/app/auth/confirm/route.ts`; add `src/app/auth/confirm/page.tsx` (Next forbids a `page` and a `route` in one segment). It is a server component in the `forgot/page.tsx` shape: it awaits `searchParams`, runs `parseConfirmParams` over them, and if that returns null it `redirect()`s to `LINK_FAILED_PATH` — nothing to spend, so nothing to protect. Otherwise it renders, inside the auth frame: the heading, one sentence, and **one button inside a plain HTML form — `method="post"`, `action` = the verify route, `token_hash` and `type` as hidden inputs.** No client component, no `fetch`, no script needed. ⚠ **Rendering this page calls nothing on the auth client — no `createClient`, no `verifyOtp`, nothing.** A GET must be a pure read. Pin that with a source scan (§1 tests).
2. **`src/app/auth/confirm/verify/route.ts` — `POST` only.** Read the form body; build the same `{ token_hash, type }` through `parseConfirmParams` (a `URLSearchParams` over the form fields is the simplest bridge — your judgment, but the allow-list at `resetFlow.ts:46` is the only thing that may decide `type`). Then exactly what the old GET did at `:30-41`: `verifyOtp`, success → `SET_PASSWORD_PATH`, refused/thrown/malformed → `LINK_FAILED_PATH`. ⚠ **Both redirects are `303`** — a `307` after a POST makes the browser re-POST the form to the set-password page. **Export no `GET`**; a GET on this path must answer 405, and a test asserts the module has no `GET` export. Move the mechanism comment from the old route here, verbatim, with a dated line saying why the verify moved behind a press.
3. **Why a form POST and not a server action or a client-side call:** it works with scripts off, it is one file with no framework machinery, and a scanner that follows links does not submit forms — this is the vendor's documented "verify on click" mitigation. The token is the secret, so there is nothing to forge; no CSRF layer is added.
4. **Copy — pedigree (c), three new keys in `AUTH_COPY`, in a `// ── confirm page (/auth/confirm)` block.** Proposed text; Daniel's words replace it in one edit:
   - `confirmSubtitle`: `Set your password`
   - `confirmIntro`: `Press Continue to open the page where you choose your password.`
   - `confirmButton`: `Continue`
   The page's classes come from `authFormClasses.ts` — `AUTH_COLUMN`, `AUTH_HEADING`, `AUTH_BODY`, `AUTH_PRIMARY_BUTTON`. Live steps only.
5. **`resetFlow.ts`:** add `CONFIRM_VERIFY_PATH = '/auth/confirm/verify'` beside `CONFIRM_PATH` with a one-line comment; the page's form `action` and the tests read it from there. `recoveryRedirectTo` is unchanged — the email still lands on `/auth/confirm`. `resetPlacement.test.ts:48` (the middleware lets a signed-out request through to `CONFIRM_PATH`) stays true and stays as it is.
6. **Comment pointers that name the old file** — `resetFlow.ts:18`, `callback/route.ts:15` — now point at the page and the verify route. Grep `confirm/route.ts` across `src/` at the end; the count must be zero.

**Not fixed here, deliberately — report, do not build:**
- **OQ-6 rider:** a signed-in operator who clicks a reset or invite link is sent to `/dashboard` by `middleware.ts:106-110` before the page renders; the token is not spent and nothing tells them why. The middleware is a hard stop (§5). Confirm in the smoke that the behaviour is unchanged and say so in the return.
- **OQ-11:** a typed code from an INVITE email is refused (`ForgotPasswordForm.tsx:89` verifies as `recovery`). That is AUTH-PROVISION's, being designed now.

**Tests for CP1:**
- `authRoutes.test.ts`: replace the `GET as confirm` import with `POST as verify` from the new route; keep all four behaviours against the faked server client, over a `Request` whose body is form-encoded; add **(i)** both outcomes redirect with status **303**, **(ii)** the module has no `GET` export, **(iii)** a body with a `type` outside the allow-list never calls `verifyOtp`.
- `resetSurface.test.ts`: `CONFIRM` becomes the page and `CONFIRM_VERIFY` the route; both join `ALL`, the page joins `SCREENS` (so the prose-from-`AUTH_COPY` and live-steps scans cover it); the mechanism pin at `:122-126` moves to the verify route; **a new pin: the page's source contains none of `verifyOtp`, `createClient`, `exchangeCodeForSession`, `fetch(`** — a render that touches the token is the defect coming back.
- Smoke, on the throwaway: `/auth/confirm?token_hash=x&type=recovery` renders the button and does **not** land on the failed notice; pressing it lands on the failed notice; `/auth/confirm?type=recovery` (no hash) lands on the failed notice directly; GET `/auth/confirm/verify` answers 405; signed in, `/auth/confirm?…` still goes to `/dashboard` (OQ-6, unchanged). Census 0 by name at the end, re-verified by SELECT.

---

## 2 · CP2 — AUTH-SIGNIN-CONTRAST. Three things on one file.

**The ruling — pedigree (a):** Daniel, Roadmap v4.33, ⏭ NEXT 1: *"the sign-in contrast is repaired (AUTH-SIGNIN-CONTRAST)"*, and the AUTH-SIGNIN-CONTRAST row, which names the two lines and the error box. Everything below is on `src/app/auth/login/page.tsx` and its copy/flow modules; nothing else on the page moves.

1. **`:40` `text-surface-400` → `text-surface-300`** (the tone `AUTH_BODY` already uses on the request and set-password pages; measured 11.19 / 8.37 on this frame). The words stay.
2. **`:102` `text-surface-500` → `text-surface-300`.** The words stay.
3. **The error box `:75-79` → `AUTH_ERROR`** from `authFormClasses.ts` (import it; measured 10.65 / 9.24 on this frame), **and `:25` stops rendering `error.message`.** Add one pure function to `resetFlow.ts` beside `verifyCodeMessage`, in its style — `signInFailureMessage(error: unknown): string` — mapping: `isAuthRetryableFetchError` → `AUTH_COPY.unreachable`; error `code === 'over_request_rate_limit'` → `AUTH_COPY.signInTooMany`; anything else → `AUTH_COPY.signInFailed`. Unit-test it in `resetFlow.test.ts` beside the other mappings. `over_request_rate_limit` is in the installed `ErrorCode` union (`node_modules/@supabase/auth-js/dist/module/lib/error-codes.d.ts:6`, read 2026-09-12); `invalid_credentials` is what the live host returns and is NOT in that union — which is why the catch-all, not a named arm, carries it. Re-read the union at your open.
4. **Copy — pedigree (c), two keys in `AUTH_COPY`, in a `// ── sign-in page` block:**
   - `signInFailed`: `That email and password didn’t match. Check both and try again, or set or reset your password below.`
   - `signInTooMany`: `Too many attempts. Wait a minute, then try again.`
5. **One existing string — pedigree (a), Daniel's browser gate 2026-09-13:** the live host answers a mistyped code with `otp_expired`, so the operator who typed `666888` reads "That code has expired or has already been used", which does not allow for the code simply being wrong. Reword `AUTH_COPY.codeExpired` so it covers all three cases. Proposed: `That code didn’t work. It may be mistyped, expired, or already used — check the digits, or send another email for a fresh one.` The mapping in `resetFlow.ts:112-116` does not change; only the sentence does.

**Not touched — report, do not build:**
- The four remaining dead classes (`:53 :54 :68 :69`, the input border and placeholder). DEADCLASS-SURFACE stands: no sweep until Daniel rules on the 105. **Update the six-site pin at `resetSurface.test.ts:54-64` to the four that remain, in file order, and rewrite its comment to cite this unit** — it is a true record of the page, not a prohibition.
- The `brand-400` links (`:95`, `:104`, and every link in the flow) at 2.42:1 in dark (OQ-5). No live brand step clears 4.5 on both grounds; the fix is a light/dark pair under the theme mechanism, which is a design-system decision, not this unit's. **Measure and report the figure again in the return so the row has a second reading.**
- The sign-in page's own prose ('Sign in to your account', 'Email', 'Password', 'Sign In', 'No account?', 'Join the waitlist') stays inline. The JSX-prose positive control at `resetSurface.test.ts:80` depends on it. Only the two new strings come from `AUTH_COPY`.
- The `.message` positive control at `resetSurface.test.ts:113` asserts the sign-in page reads `.message`; after this change it does not. **Move the positive control to a fixture string inside the test file itself** (a line of code that does read `.message`) so the "never rendered" scans keep a control, and add the sign-in page to the files that must not read it.

**Measurement, before and after, in the return — verbatim, both themes:** computed-style contrast on `:40`, `:102` and the error box (force one by submitting a wrong password on the throwaway), as WCAG ratio **and APCA Lc** (APCA-NOT-WCAG is standing: the WCAG ratio cannot see polarity in dark mode). Screenshots of the sign-in page with an error showing, light and dark, into the scratchpad, paths in the return.

---

## 3 · Step 1 of the run — replace the run fence (FENCE-COUNTS · FENCE-ONEUNIT)

Before any source edit, in `CLAUDE.md`: **replace the whole body under `## Current run fence`** — from the line after the heading to the line before the next `##` — with this unit's fence. It carries ONE unit, replaced never appended; the 2026-09-08 body and its 2026-09-12 correction note both go. **Quote the removed body verbatim in RAW OUTPUT** so Arch can carry it to the Ledger, where retired fence text lives.

The new body says, in this order and nothing more: the unit (AUTH-LINKCLICK + AUTH-SIGNIN-CONTRAST, two checkpoints); the commit it follows (AUTH-RESETPAGE's hash, read from the ref file at your open); the counts **measured at this unit's close** — suite tests / files, frozen vs `be0769de`, build, typecheck, dependency gate, guarded-code grep, migration ledger 59 (`20260911165516`), visual gate result with its timestamp; and the browser-gate status, DEFERRED to Daniel with the four checks in §6 named. Write the counts last, after the gates run; a count written before it is measured is TENSE-IS-A-CLAIM.

⚠ **`CLAUDE.md` must not grow.** `wc -m` after ≤ `wc -m` at your open. Report both figures.

---

## 4 · Preconditions that are NOT yours — return if they block you

- **AUTH-DASHBOARD** (the Supabase redirect-URL allow list and the two email templates) is Daniel's and has not landed. **The URL shape this unit expects is unchanged from AUTH-RESETPAGE's OQ-10.** A real link end to end is still unprovable in-run; say so plainly, as the last return did. **Do not fake it.**
- **MAILGATE (Daniel, 2026-09-12): nothing in this unit sends mail to any address that is not his own.** Your smoke uses `TEST_USER_EMAIL` and never calls `resetPasswordForEmail` against it — the request page is not in scope. **0 invites and 0 recovery mails have ever been sent from this project; do not be the first.**
- **Provisioning is AUTH-PROVISION's, Arch's and Daniel's, never yours.** No Auth-admin API, no `SUPABASE_SERVICE_ROLE_KEY`.

## 5 · Hard stops — return, do not proceed

Schema, function, RLS or grant needs · any dependency change · a new environment variable · frozen-layer contact · **any change to `src/lib/supabase/middleware.ts` or to which routes it protects** · a second home for operator-facing text outside `AUTH_COPY` · credentials or secrets · anything raising an OS-permission or OAuth dialog · **`--update-baselines`.**

⚠ **Single-file edits go through the Edit tool, no exceptions** — no `sed -i`, no `perl -pi`, no interpreter heredoc writing a repo file (CCSED-260911). The fence blocks none of the interpreters; this rule is on your honour.

## 6 · Gates and close

`npm test` · `npm run type-check` · `node scripts/frozen-gate.mjs` · `npm run build` · `npm run test:visual`, plus the browser smoke on a throwaway project created and destroyed in-run. Script names verified against `package.json` at `d980b73` by the last unit; re-check them.

**The visual gate should not move:** no captured frame is an auth page. If a frame moves anyway, measure the per-frame diff and bounding boxes and return it as a declared baseline event. Never `--update-baselines`.

**Raw Output Rule — verbatim:** *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every line. The architect cannot verify correctness from a summary."*

**A number in the return is a measurement or it is not written.**

**Expected FILES CHANGED** (a difference is reported, not absorbed):
```
CLAUDE.md                                      M   (§3)
src/app/auth/confirm/route.ts                  D
src/app/auth/confirm/page.tsx                  A
src/app/auth/confirm/verify/route.ts           A
src/app/auth/login/page.tsx                    M
src/lib/auth/resetCopy.ts                      M
src/lib/auth/resetFlow.ts                      M
src/lib/auth/resetFlow.test.ts                 M
src/lib/auth/authRoutes.test.ts                M
src/lib/auth/resetSurface.test.ts              M
```
Stage the deletion by filename too (`git rm` on the old route, or `git add` of the path — either is by explicit filename).

**Commit — WF-1a.** Follow `CLAUDE.md`'s COMMIT BLOCK as written, including **step 0, the browser gate, which the confirm phrase does not cover and cannot supply.** Commit on Daniel's `COMMIT APPROVED: <first words>`. ⚠ **HOLD step 4, the push, behind Daniel's browser gate on THIS unit** — commit, stop, record the push as OWED pending the gate. AUTH-RESETPAGE's gate does not discharge this one.

**Daniel's browser gate for this unit — four checks on localhost (`npm run dev`), no email involved:**
1. `/auth/confirm?token_hash=x&type=recovery` shows a page with a Continue button and nothing has happened yet; pressing Continue lands on the request page saying the link has expired or been used.
2. The sign-in page: "Sign in to your account" and "No account?" are readable, in light and in dark (toggle the theme on the dashboard first, then sign out).
3. A wrong password shows a readable box with a plain sentence — not "Invalid login credentials" — in both themes.
4. Signing in still works.

**Success condition:** the link lands on a page whose GET touches no token and whose button does; the sign-in page's two lines and error box measure readable in both themes and print no vendor string; the run fence carries this unit and `CLAUDE.md` did not grow; the five gates are green; the commit exists; **`origin/main` is still `57e0eec`**; the `_CLOSE.txt` is written with its browser-gate field filled in rather than inferred; and the return states which parts remain unprovable end to end until AUTH-DASHBOARD lands.
