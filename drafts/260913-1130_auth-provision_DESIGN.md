# AUTH-PROVISION — design (Arch, 2026-09-13)

*Status: proposal. Trigger A (a new flow). Nothing here is built, and nothing here sends mail. Daniel decides the three questions at the end; the rest follows from them.*

## The question

How does a cohort lead get an account, and how do they get from the invite to a password? The front door is live at `3416650`: the sign-in page's "Set or reset your password" link, the emailed link that verifies only on a press, the six-digit code, and the set-password page. What does not exist is the account itself — and the way the email reaches anyone but Daniel.

## Finding 1 — the built-in mailer cannot reach the cohort at all

Read 2026-09-13 in the vendor's own guide (*Send emails with custom SMTP*, supabase.com/docs/guides/auth/auth-smtp): **"Unless you configure a custom SMTP server for your project, Supabase Auth will refuse to deliver messages to addresses that are not part of the project's team,"** failing with *Email address not authorized*. The default sender also carries a rate limit that "can change without notice" and is "not meant for production use."

What this means: every end-to-end test so far, and every test Daniel could run tomorrow, works only because his address is the organization's team address. **The first cohort member to click "Set or reset your password" would get the neutral "an email is on its way" message and no email.** The page cannot tell them, by design (the enumeration property). This is not AUTH-MAILVOLUME's "untested at 30–40"; it is a hard refusal at one.

**Custom SMTP is therefore a gate item for ≈Sept 18**, ahead of every other row in this design, and it is dashboard-and-DNS work, Daniel's. Registered as **AUTH-SMTP**. Two workable providers:

- **Google Workspace SMTP for `info@minotaur.app`** — if `minotaur.app` mail already runs on Google (the beta-terms companion says info@ "already sends from Gmail"): `smtp.gmail.com`, port 587, an app password on that mailbox, sender name "Minotaur". No new vendor, Google's existing SPF/DKIM on the domain, a 2,000-per-day ceiling. **The lean choice if the premise holds.**
- **Resend** (or Postmark) — a new account, domain verification (three DNS records), API-key SMTP. Better deliverability reporting; one more vendor and a DNS afternoon. The right choice at public beta; not needed for 16 leads.

Either way the dashboard's own cap after custom SMTP is **30 emails per hour by default**, adjustable on the Rate Limits page. For a cohort that requests its own mail one at a time, 30 is plenty.

## Finding 2 — the account can be created with no code and no mail

Measured 2026-09-13 on the live database: `auth.users` carries a trigger, `on_auth_user_created → handle_new_user()`, that inserts the `profiles` row (id, email, display name from metadata or the address's local part) on **every** insert, however the user was created. So a user created by hand in the Supabase dashboard (Authentication → Users → Add user → *Create new user*, email, **Auto Confirm User** on, no password) is indistinguishable from one created by a script — and no email is sent by that action.

Also measured: 12 users, 6 confirmed, 0 ever invited, 0 recovery mails ever sent.

## The mechanism — three options, one recommended

**A · Create the account; the operator asks for their own email. Recommended.**
Daniel creates each lead's account (dashboard for the sixteen — ten minutes, no credentials handled, no code). His personal invite note (BETA-INVITE, already his) tells them the three steps: go to minotaur.app → *Set or reset your password* → enter the address he invited. The recovery email arrives (through custom SMTP), they press Continue, choose a password, land on the dashboard. Every screen in that path is built and gated; the email is the one already designed (AUTH-DASHBOARD's recovery template). Nothing is admin-sent, so MAILGATE has nothing to approve, and the typed-code path already works because the code is a recovery code. OQ-11 (a typed *invite* code is refused) is moot: no invite emails exist. The four pre-terms accounts take exactly the same path.

**B · Admin invite (`inviteUserByEmail`).** Supabase sends an invite email per lead. It needs the invite template set, an `invite` arm on the typed-code path (OQ-11), and — under MAILGATE — one standalone approval per send, sixteen times. The invite also arrives from the system rather than from Daniel, which is the wrong first contact for a cohort he knows personally. Rejected for the private beta.

**C · Generate a link and paste it into the personal note.** The link is the one-time token; the default expiry is an hour (24 hours at most), and Daniel writes sixteen notes over days. Expired links on first contact, by construction. Rejected.

**What A costs:** one extra step for the operator (typing their address) and a mechanical email following a personal one. Both are the ordinary shape of "you've been given an account," and the invite note can say so in one sentence.

**When a script is wanted anyway:** SHARING's invite (REV-B) will need to create an account for a team member from inside the app, server-side, with the service key. That is the moment for programmatic provisioning — as an app action behind the sharing surface, not a script Daniel runs — and it will reuse exactly this mechanism: create-confirmed, no mail, the operator self-serves the recovery. The Docket's "dry-run script with an allowlist" is retired by this design; nothing needed it.

## What the invite note has to say (for BETA-INVITE, Email Prompt)

Three steps, in Daniel's words, plus the two ruled sentences (*forgot your password → email me*; *v1 stays your source of truth*): the address he set up, the link's name on the sign-in page, and that an email from Minotaur follows which needs one press. One sentence that the terms are accepted by setting a password — **only if TERMS-ACCEPT lands that way** (the beta-terms parallel is deciding what the terms need; Task 2 of its opener).

## Rehearsal — proves the chain before anyone is invited

1. **Now, before SMTP:** Daniel creates a throwaway user for a second address of his own that is on the Supabase team (or uses his team address), signs out, runs the full path on production: sign-in page → *Set or reset your password* → email → Continue → password → dashboard. Then the typed-code path once. This discharges AUTH-RESETPAGE's check 5 and AUTH-LINKCLICK's "real link unproven."
2. **After SMTP:** the same path to an address of his that is **not** on the Supabase team (`daniel@daniellundberg.com` qualifies). Delivery to that address is the proof that Finding 1 is closed. Read the received email's headers once: sender domain, SPF and DKIM pass.
3. Delete the throwaway users in the dashboard.

Both rehearsals send only to Daniel's own addresses — inside MAILGATE without an approval.

## Decisions for Daniel

1. **Mechanism A** (dashboard-created accounts; operators request their own email) — yes, or name the objection.
2. **SMTP provider:** Google Workspace on `info@minotaur.app` if that mailbox is on Google; otherwise Resend. Which is true?
3. **Display names.** A dashboard-created account's display name is the address's local part until something changes it, and nothing in the app lets an operator change it yet. Acceptable for the private beta (it shows only in places SHARING will expose later), or does the invite ask each lead for the name they want and Daniel sets it in the user's metadata at creation?

## Docket movements this design proposes

- **AUTH-SMTP** — new, ▶ ACTIVE, gate ≈Sept 18, Daniel: custom SMTP configured and rehearsal 2 passed. Absorbs the mechanical half of AUTH-MAILVOLUME; the Strat half (a vendor domain and 30–40 in an afternoon) closes with it.
- **AUTH-PROVISION** — mechanism A ruled, no unit to build for the private beta; programmatic creation moves into SHARING REV-B.
- **AUTH-DASHBOARD** — unchanged: recovery template on `{{ .TokenHash }}` + `{{ .Token }}`, allow-list carrying `https://minotaur.app/auth/confirm` and `http://localhost:3000/auth/confirm`. Set the invite template to the same shape anyway, so a stray dashboard "Send invitation" click cannot rebuild the scanner defect.
- **TERMS-ACCEPT** — new, ▶ ACTIVE, gate ≈Sept 18: how acceptance of the beta terms is recorded; the parallel decides what the terms need, Arch designs what is built. Today: nothing in `src/` records acceptance (measured 2026-09-13).
- **BETA-INVITE** — gains the three-step sentence above.
