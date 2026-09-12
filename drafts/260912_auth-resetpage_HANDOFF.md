# AUTH-RESETPAGE — the only door into the private beta

Tier: 3 (Claude Code)
Session: **CONTINUE** if the PREBETA-FRICTION commit has just landed in this session; **FRESH** otherwise. ⚠ **Do not start this unit until that commit exists.** A new unit opens on a clean tree — the same rule that held VERHIST-UI Leg 1 behind VERHIST-FANOUT. The push is deliberately still owed on that unit and that is fine; the commit is what this waits on, not the push.

**Unit:** build the account-setup and password-reset flow. ⚠ **This is not a recovery convenience. Under SHARE-R8 (Daniel, 2026-09-12) it is the ONLY way any beta cohort member ever gets into v2** — he supplies the email, the account is provisioned for them, and this flow is where they set their password. It gates ≈Sept 18.

---

## 0 · What exists today, measured at source this session

Read all of it at source before writing. The Surface Rule outranks every line below.

- **`src/app/auth/` holds exactly four files:** `callback/route.ts`, `layout.tsx`, `login/page.tsx`, `signup/page.tsx`. There is no reset route, no confirm route, no set-password page.
- **`src/app/auth/callback/route.ts` is FOURTEEN lines.** It reads `code`, calls `exchangeCodeForSession(code)` at `:10` **discarding the result**, and redirects to `/dashboard` **unconditionally** at `:13`. A failed exchange is indistinguishable from a successful one.
- **`src/app/auth/login/page.tsx` is 99 lines.** `signInWithPassword` at `:21`; no forgot-password link anywhere; the only secondary link is the R-P rider at `:89-96` pointing at the landing page's waitlist.
- **`src/app/auth/layout.tsx` is 6 lines** — a centred `min-h-screen bg-surface-950` main. Any new page lives inside it.
- **App-wide, `src/` contains ZERO occurrences** of `resetPasswordForEmail`, `updateUser`, `signInWithOtp`, `verifyOtp`, `redirectTo`, `emailRedirectTo` or `inviteUser`, excluding tests. **Nothing is being undone here; it is all being added.**
- **Both clients set no `flowType`** (`src/lib/supabase/client.ts`, `server.ts`), so `@supabase/ssr`'s **PKCE default** applies. This is the fact the design turns on — see §1.
- **`.env.local` carries** `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`, `TEST_USER_EMAIL`, `TEST_USER_PASSWORD`, `SUPABASE_SERVICE_ROLE_KEY`. **There is no site-URL variable.**

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
4. **The `redirectTo` value.** There is no site-URL env var today. Derive the origin rather than hardcoding it, and make localhost and production both work without an edit. Name the variable you add, if you add one, in the return — ⚠ **a new environment variable is a deployment step Daniel must perform, so it is a HARD STOP if you need one that does not exist. Return it; do not invent it and assume it is set.**

## 3 · ⚠ DEAD UTILITY CLASSES — DO NOT COPY THEM, DO NOT FIX THEM

Measured this session, and **this is wider than DEADCLASS-SURFACE's row says.** The `surface` scale in `tailwind.config.js` defines **0 / 50 / 100 / 200 / 300 / 800 / 900 / 950 and nothing between**, so **400–700 emit no CSS for ANY utility prefix**, not only `text-`. App-wide, code only: **`text-surface-[400-700]` 109 · `border-surface-[400-700]` 2 · `placeholder-surface-[400-700]` 2**, across 41 files.

⚠ **All four of the non-text ones are on the sign-in page** — `border-surface-600` at `:51` and `:66`, `placeholder-surface-500` at `:52` and `:67` — **plus `text-surface-400` at `:38` and `text-surface-500` at `:91`. Six dead classes on the first screen every beta user will ever see.**

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

## 6 · Hard stops — return, do not proceed

Schema, function, RLS or grant needs · any dependency change · a new environment variable · frozen-layer contact · **any change to which routes the middleware protects** (it was bounded one unit ago; do not touch it) · a second class of operator-facing text outside §4's module · credentials or secrets · anything raising an OS-permission or OAuth dialog.

⚠ **Single-file edits go through the Edit tool, no exceptions** — no `sed -i`, no `perl -pi`, no interpreter heredoc writing a repo file. A bash write bypasses the PostToolUse frozen-check hook, which is the whole reason for the rule (CCSED-260911). ⚠ **Measured 2026-09-12 by the META parallel: the fence blocks not one interpreter, so this rule is on your honour and nothing else is standing there.**

## 7 · Gates and close

`npm test` · `npm run type-check` · `node scripts/frozen-gate.mjs` · `npm run build` · `npm run test:visual`, plus the standing browser smoke on a throwaway.

⚠ **This unit ADDS SCREENS under `src/app/auth/`, so the visual gate may legitimately move.** A moved frame is not yours to adopt: measure the per-frame diff and bounding boxes and **return it as a declared baseline event for Daniel.** Never `--update-baselines`.

**Raw Output Rule — verbatim:** *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every line. The architect cannot verify correctness from a summary."*

**A number in the return is a measurement or it is not written.**

**Commit — WF-1a.** Stage by explicit filename; commit on Daniel's `COMMIT APPROVED: <first words>`. ⚠ **FENCE-PUSH is LIVE and the push is yours on the phrase — but HOLD IT, as on the previous unit**, until his browser gate runs. A push is a production deploy. Record it as **owed pending the gate**, never as blocked.

**Success condition:** all three surfaces exist and are tested, the gates are green, the commit exists, `origin/main` is unchanged, and the return states plainly which parts could not be proven end to end because §5's dashboard configuration had not landed yet.
