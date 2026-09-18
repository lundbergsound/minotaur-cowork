# SUPPORT-ACCOUNT — created 2026-09-18 (Daniel, dashboard), display name by Arch

- auth user `1c04aaca-704e-42c8-8474-4a4bd31d73d4`, `info@minotaur.app`, created 16:24:06Z, auto-confirmed. The dashboard REQUIRED a password (the "leave it blank" step in Arch's walkthrough was wrong for this dashboard version) — Daniel set one.
- profiles row present (the Crystal defect did not recur); display_name `info` → **`Minotaur Support`** (Arch, 12:3x ET).
- terms_acceptances: 0 — acceptance is written only on the set-password page.
- Reset requested 16:25:57Z: auth log `user_recovery_requested`, `/recover` 200 in 518 ms, `recovery_sent_at` stamped — **Supabase handed the mail to SMTP successfully.** Daniel reports it never arrived.
- ⚠ FINDING: the auth sender IS `info@minotaur.app` (Porkbun SMTP, 2026-09-14), so this reset is mail from info@ to info@. Non-arrival is downstream of Supabase (self-addressed filing, spam, or provider self-send handling). **Not yet diagnosed** — Daniel checks Sent/Spam/All Mail. Relevance beyond this account: none for cohort members (their addresses differ), but it means the support account cannot be recovered by the normal door if this holds.
- ✅ Daniel signed in as the support account 16:29:49Z (last_sign_in_at). SUPPORT-ACCOUNT discharged; BUGREPORT's support-login prerequisite met. Terms acceptance for it still 0 — TERMS-GATE's routing will ask at a later sign-in.
