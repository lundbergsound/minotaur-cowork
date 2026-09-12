# AUTH-RESETPAGE — the only door into the private beta

Tier: 3 (Claude Code)
Session: **FRESH.** The reason: `260912-1105_auth-resetpage.md` was written when PREBETA-FRICTION was committed and unpushed, and said CONTINUE if that commit had just landed in the same session. It has since landed **and been pushed** — `origin/main` is `d980b73`, whose parent is `bf0d7ed`. That session is over. Open clean.

⚠ **This file supersedes `handoffs/to-cc/260912-1105_auth-resetpage.md`.** Same unit, same mechanism, same rulings. What changed: the `Session:` line, one corrected measurement in §0, and the push/baseline paragraph in §7, which was written against a `96efd11` origin that no longer exists. **Nothing in §1–§6 was re-litigated.** Every figure below was **re-measured at source by Arch on 2026-09-12 at `d980b73`**, not carried from the superseded file.

**Unit:** build the account-setup and password-reset flow. ⚠ **This is not a recovery convenience. Under SHARE-R8 (Daniel, 2026-09-12) it is the ONLY way any beta cohort member ever gets into v2** — he supplies the email, the account is provisioned for them, and this flow is where they set their password. It gates ≈Sept 18.

---

## State at the open — read from the ref files, never by running git

- Code repo `HEAD` = `refs/heads/main` = `refs/remotes/origin/main` = **`d980b73`**. Nothing owed on either.
- ⚠ **`bf0d7ed` (PREBETA-FRICTION) IS DEPLOYED.** It is `d980b73`'s parent, and `d980b73` is on `origin/main`, so Vercel has built it. **Daniel's browser gate on `bf0d7ed` is still owed and is now a post-release verification of live code, not a pre-release gate.** That is his, it is not yours, and it does not block this unit.
- Migration ledger **59**, live-read, last version `20260911165516`. **No migration in this unit** — a schema need is a hard stop (§6).
- `CLAUDE.md` **117,288 characters**. It gained COMMIT BLOCK **step 0** at `d980b73`; §7 below points at it rather than restating it.

---

## 0 · What exists today, re-measured at source at `d980b73`

Read all of it at source before writing. The Surface Rule outranks every line below.

- **`src/app/auth/` holds exactly four source files:** `callback/route.ts`, `layout.tsx`, `login/page.tsx`, `signup/page.tsx` (plus a `.DS_Store`). There is no reset route, no confirm route, no set-password page. ✓ confirmed
- **`src/app/auth/callback/route.ts` is FOURTEEN lines.** It reads `code` at `:6`, calls `exchangeCodeForSession(code)` at `:10` **discarding the result**, and redirects to `/dashboard` **unconditionally** at `:13`. A failed exchange is indistinguishable from a successful one. ✓ confirmed verbatim
  - Also confirmed and useful to you: `:5` already destructures **`origin`** from `new URL(request.url)`. The origin-derivation pattern §2.4 asks for exists in this file already — follow it rather than inventing a second one.
- **`src/app/auth/login/page.tsx` is 99 lines.** `signInWithPassword` at `:21`; **zero** occurrences of "forgot", "reset" or "recover" anywhere in the file; the only secondary link is the R-P rider at `:89-96` pointing at the landing page's waitlist. ✓ confirmed
- ⚠ **`src/app/auth/layout.tsx` is SEVEN lines, not six.** The superseded file said six. It is a centred `min-h-screen bg-surface-950 flex items-center justify-center p-4` main. Any new page lives inside it. **Corrected here; re-measure it yourself anyway.**
- **App-wide, `src/` code contains ZERO occurrences** of `resetPasswordForEmail`, `updateUser`, `signInWithOtp`, `verifyOtp`, `emailRedirectTo` or `inviteUser`, and zero of `redirectTo` outside tests (one test file has it). **Nothing is being undone here; it is all being added.** ✓ confirmed
- **Neither client sets `flowType`** (`src/lib/supabase/client.ts`, `src/lib/supabase/server.ts`), so `@supabase/ssr`'s **PKCE default** applies. This is the fact the design turns on — see §1. ✓ confirmed
- **`.env.local` carries exactly** `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`, `TEST_USER_EMAIL`, `TEST_USER_PASSWORD`, `SUPABASE_SERVICE_ROLE_KEY`. **There is no site-URL variable.** ✓ confirmed

**Measure the baseline at the open and write it down. Carry nothing from any document, this one included.**

---

## 1 · ⚠ THE MECHANISM, AND IT IS ARCH'S RULING — token_hash, NOT the code exchange

**Do not route recovery through `/auth/callback`.** Under PKCE, an emailed `code` can only be exchanged by the browser that wrote the matching `code_verifier`. An admin-initiated link has no verifier in the recipient's browser, the exchange fails, and — because `:10` discards the error and `:13` redirects regardless — the operator lands signed-out on the sign-in page with nowhere to go. **That is the defect of record, and extending that route would rebuild it.**

**Build a NEW route, `/auth/confirm`, on the `token_hash` pattern:** it reads `token_hash` and `type` from the query, calls **`verifyOtp({ token_hash, type })`**, and on success redirects to the set-password page. ⚠ **`verifyOtp` needs no verifier**, so the link works from any browser and from an admin-initiated invite as well as a user-initiated reset. That property is the whole reason for this choice — say so in a comment, with its date, or the next session will "simplify" it back into the callback.

**Leave `callback/route.ts` alone** except for one thing: **stop discarding the exchange error.** On failure it must not redirect to `/dashboard` as though it worked. Where it sends them instead is operator-facing — pedigree (c), see §4.

⚠ **An OTP fallback is part of this unit, not a nicety.** Corporate mail scanners (Microsoft Defender Safe Links and its kin) **prefetch links and consume single-use tokens before the human clicks**, producing "Token has expired or is invalid" on a link the operator never opened. A cohort of thirty to forty theatre professionals will contain Office 365 accounts. So the set-password surface **also accepts a six-digit code** the operator types, verified with `verifyOtp({ email, token, type })`. **Mechanism is Arch's and ruled here; every word on screen is (c).**

## 2 · What to build

1. **An entry point on the sign-in page.** A link that starts the flow. It collects the email and calls `resetPasswordForEmail(email, { redirectTo })`. ⚠ **Always report the same neutral outcome whether or not the address exists** — a message that differs is an account-enumeration oracle on the front door of a product in private beta. That is a security property, not a wording choice, and it is not negotiable in either direction.
2. **`/auth/confirm`** — §1's route.
3. **A set-password page** — new password, confirmation field, `updateUser({ password })`, then on to `/dashboard`. It is also where the six-digit code can be entered.
4. **The `redirectTo` value.** There is no site-URL env var today. Derive the origin as `callback/route.ts:5` already does, rather than hardcoding it, and make localhost and production both work without an edit. Name the variable you add, if you add one, in the return — ⚠ **a new environment variable is a deployment step Daniel must perform, so it is a HARD STOP if you need one that does not exist. Return it; do not invent it and assume it is set.**

## 3 · ⚠ DEAD UTILITY CLASSES — DO NOT COPY THEM, DO NOT FIX THEM

Re-measured at source 2026-09-12, and every figure below held. This is wider than DEADCLASS-SURFACE's row says. The `surface` scale in `tailwind.config.js:33-42` defines **0 / 50 / 100 / 200 / 300 / 800 / 900 / 950 and nothing between**, so **400–700 emit no CSS for ANY utility prefix**, not only `text-`. App-wide, code only: **`text-surface-[400-700]` 109 · `border-surface-[400-700]` 2 · `placeholder-surface-[400-700]` 2**, across **41 files**. ✓ all confirmed

⚠ **All four of the non-text ones are on the sign-in page, and the six sites are exactly where the record says:** `text-surface-400` at `:38` · `border-surface-600` at `:51` and `:66` · `placeholder-surface-500` at `:52` and `:67` · `text-surface-500` at `:91`. **Six dead classes on the first screen every beta user will ever see.** ✓ confirmed line by line

**Your instructions, and they pull in two directions on purpose:**

- **New markup uses only live steps.** Copying the login page's classes would propagate dead ones into the pages the cohort meets.
- ⚠ **Do NOT repair the six existing sites.** DEADCLASS-SURFACE is explicit: a dead class renders at full body colour, and "repairing" it to its author's intended muted tone **lowers** contrast — WCAG 12.81 down to ~4.85. **Which of them should be dim is Daniel's ruling and no sweep runs before it.**
- **Do NOT add a `surface.400`–`700` step to `tailwind.config.js`.** One edit would silently activate ~110 dead classes app-wide. That restraint is the difference between a unit and a regression.
- **Report the visual delta** between your new pages and the sign-in page rather than resolving it. That inconsistency is the DEADCLASS ruling becoming visible, which is useful.

## 4 · Pedigree — every word on these screens is (c)

**This unit invents an entire screen's worth of operator-facing text and Daniel has ruled none of it.** Put **every** string in **one** constants module, each marked as an OPEN QUESTIONS proposal awaiting his wording, so his sentences replace them in one edit. Write plain, calm, non-technical copy as the proposal — these operators are in dark rooms under time pressure — and never render a raw vendor error string.

⚠ **Two sentences Daniel has already ruled must appear in the invite and are NOT yours to place here** (BETA-INVITE): *forgot your password, email me* and *v1 stays your source of truth*. Do not put them on these screens.

## 5 · Preconditions that are NOT yours — return if they block you

- **The Supabase redirect-URL allow list and Site URL** are dashboard configuration. **Daniel's, being done alongside this unit.** If a link 404s or bounces to the wrong origin in your smoke, that is this, not your code — **report it, do not work around it.**
- **The recovery email template must carry `{{ .TokenHash }}` and `{{ .Token }}`** for §1 to work at all. Also Daniel's, same sitting. **Build against the template shape; say plainly in the return that the flow is untestable end to end until it lands, and do not fake it.**
- **Provisioning accounts with the service key is Arch's and Daniel's and never yours.** ⚠ **Credentials are a named hard stop.** You never call the Auth-admin API and never read `SUPABASE_SERVICE_ROLE_KEY`.
- ⚠ **MAILGATE (Daniel, 2026-09-12): nothing in this unit sends mail to any address that is not his own.** Your smoke uses `TEST_USER_EMAIL` and nothing else. **0 invites and 0 recovery mails have ever been sent from this project; do not be the first.**

## 6 · Hard stops — return, do not proceed

Schema, function, RLS or grant needs · any dependency change · a new environment variable · frozen-layer contact · **any change to which routes the middleware protects** (it was bounded one unit ago at `bf0d7ed`; do not touch it) · a second class of operator-facing text outside §4's module · credentials or secrets · anything raising an OS-permission or OAuth dialog.

⚠ **Single-file edits go through the Edit tool, no exceptions** — no `sed -i`, no `perl -pi`, no interpreter heredoc writing a repo file. A bash write bypasses the PostToolUse frozen-check hook, which is the whole reason for the rule (CCSED-260911). ⚠ **Measured 2026-09-12 by the META parallel: the fence blocks not one interpreter, so this rule is on your honour and nothing else is standing there.**

## 7 · Gates and close

`npm test` · `npm run type-check` · `node scripts/frozen-gate.mjs` · `npm run build` · `npm run test:visual`, plus the standing browser smoke on a throwaway project created and destroyed in-run. **All five script names verified against `package.json` at `d980b73`.**

⚠ **This unit ADDS SCREENS under `src/app/auth/`, so the visual gate may legitimately move.** A moved frame is not yours to adopt: measure the per-frame diff and bounding boxes and **return it as a declared baseline event for Daniel.** Never `--update-baselines`.

**Raw Output Rule — verbatim:** *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every line. The architect cannot verify correctness from a summary."*

**A number in the return is a measurement or it is not written.**

**Commit — WF-1a.** Follow `CLAUDE.md`'s COMMIT BLOCK as written, including **step 0, the browser gate, which the confirm phrase does not cover and cannot supply.** Stage by explicit filename; commit on Daniel's `COMMIT APPROVED: <first words>`.

⚠ **HOLD step 4 — the push — behind Daniel's browser gate on THIS unit.** This is Arch asking for less than the fence permits, which `CLAUDE.md` explicitly allows: commit, stop, and record the push as **OWED pending the gate**, never as blocked. ⚠ **Do not carry the previous unit's gate into this one.** `bf0d7ed`'s gate is separately owed and does not discharge yours; `bf0d7ed` is already live.

**Success condition:** all three surfaces exist and are tested, the five gates are green, the commit exists, **`origin/main` is still `d980b73`**, the `_CLOSE.txt` is written with its browser-gate field filled in rather than inferred, and the return states plainly which parts could not be proven end to end because §5's dashboard configuration had not landed yet.
