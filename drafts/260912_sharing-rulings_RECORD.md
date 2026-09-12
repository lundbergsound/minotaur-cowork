# SHARING — rulings taken 2026-09-12, recorded so they outlive this session

Written by the Cowork-Arch main line while CC ran PREBETA-FRICTION. **Not yet installed** in the Roadmap, the Ledger or the Session Log — that happens at this session's close. Recorded here because a finding carried only in chat has not propagated at all, and a fact carried only in a sweep line dies with the version that carried it (SWEEPLINE-NOT-DURABLE).

---

## The rulings

**SHARE-R8 (proposed ID) — the account-creation path, Daniel 2026-09-12.** Answers the build-prep input reserved to Arch on 2026-08-15 (*"with public signup closed, phase-1 invites need an account-creation path that does not route through the public form; intent ruled, mechanism is Arch's at build-prep"*). **The mechanism:** Daniel supplies the cohort's email addresses — by hand to Arch, or later through an admin surface — the account is provisioned for that address, and the operator sets their own password from the sign-in page's reset link on first visit. No public form, no password mailed, no shared credential.

**AUTH-RESETPAGE moves AHEAD of the invite, Daniel 2026-09-12.** It was sequenced as the first unit *after* the invite, with a hand reset as the week-one crutch. **It is now the gate**, because under SHARE-R8 it is not a recovery path — it is the only way a cohort member ever gets in. Supersedes the 2026-09-11 Strat sequencing on this one point; the rest of that sequencing stands.

**SHARE-R1..R7 CONFIRMED UNCHANGED, Daniel 2026-09-12.** Re-read to him in full and re-ruled as they stand. The Roadmap v4.31 SHARING row calling the surface *"a gate item with no scope — the least-defined thing on the list"* is **wrong and must be corrected at the close**: four of the five things it lists as undecided were ruled on 2026-08-12.

---

## What this leaves genuinely open — the real remainder

1. **The RLS delta and the fourth role's sketch (REV-B).** Arch's, owed since 2026-08-12, and the only actual design work left on SHARING.
2. **PKCE, and it decides whether SHARE-R8 works at all.** Measured at source 2026-09-12: `src/lib/supabase/client.ts` and `server.ts` both construct `@supabase/ssr` clients with **no `flowType` set**, so the PKCE default applies — a code in an emailed link can only be exchanged by the browser that wrote the matching verifier. **An admin-initiated link therefore cannot be exchanged in the recipient's browser**, which is precisely why the record says a recovery link is valid and lands on the sign-in page with nowhere to go. **The user-initiated half is the half that works**, and SHARE-R8 must be built that way.
3. **Auth email volume and deliverability, UNMEASURED and a candidate gate item.** Supabase's built-in auth email sender is rate-limited per hour and sends from a vendor domain. Thirty to forty operators on invite day is the first time this project has ever sent auth mail at any volume. ⚠ **AUTH-DOMAIN is ruled a PUBLIC-beta prerequisite (STRAT-ADM-R2); this is a genuinely new consideration against that ruling and belongs back at Strat in one sentence, not re-argued here.**

---

## Measured at source this session, so the next instruction does not re-derive it

- `src/app/auth/` holds **four files**: `callback/route.ts`, `layout.tsx`, `login/page.tsx`, `signup/page.tsx`. There is no reset route, no set-password route, no recovery component.
- `src/app/auth/callback/route.ts` is **fourteen lines**: it exchanges the code and redirects to `/dashboard` **unconditionally**, with no branch on link type — and **the exchange's error is discarded** (`await supabase.auth.exchangeCodeForSession(code)` at `:10`, result not destructured). A failed exchange is indistinguishable from a successful one at that line.
- `src/app/auth/login/page.tsx` is **99 lines**: email + password via `signInWithPassword` only. **No "forgot password" link**; the only secondary link points at the landing page's waitlist (`:89-96`, the R-P rider).
- **App-wide, `src/` contains ZERO occurrences** of `resetPasswordForEmail`, `updateUser`, `signInWithOtp`, `magiclink`, `type=recovery` or `inviteUser` — verified by grep across `*.ts`/`*.tsx` excluding tests. The three `forgot` hits are unrelated comments about function arguments.
- **`service_role` already has a working, audited home OUTSIDE the deployed app:** `scripts/gate-a-isolation.mjs` reads `SUPABASE_SERVICE_ROLE_KEY` **from the environment at runtime only** (`:24`, and `:6-7` says it never reads `.env.local` itself), and its `:12` comment records that service_role is used **only for Auth-admin calls — create / reset / delete**. ⚠ **So the provisioning half of SHARE-R8 needs no admin portal and no secret in the deployed app: the pattern exists and is proven.** ADM-1's portal is a convenience for later, not a gate.
- `src/app/auth/signup/page.tsx` is a server component with no `createClient()` and no `signUp()` — **public signup is closed by construction** (SIGNUP-GATE, closed three layers deep), and the route is kept only because the path is Google-indexed.

---

## Consequence for the unit

AUTH-RESETPAGE is now **two halves with different owners**, and they must not be confused:

- **The app half — CC's.** A "set up / reset your password" entry on the sign-in page, the `resetPasswordForEmail` call that writes the verifier **in the operator's own browser**, a recovery branch in `callback/route.ts` that stops discarding the exchange error, and a set-password page. Every string on it is operator-facing and needs pedigree.
- **The provisioning half — Arch's and Daniel's, never CC's.** Creating the accounts with the service key. ⚠ **Credentials and secrets are a named CC hard-stop**; this half runs as a script from Daniel's environment, on the `gate-a-isolation.mjs` pattern, and the key never enters the deployed application.

**Neither half starts until CC returns from PREBETA-FRICTION.** One writer at a time.
