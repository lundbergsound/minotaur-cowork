# PARALLEL OPENER — REGISTRY-1, the licensing registry data model

*Written by the Cowork-Arch main line on 2026-09-13 under Architecture Prompt v37. Sequencing ruled by Daniel 2026-09-13: this session designs; nothing it designs is applied before the private-beta invite. REGISTRY-2 (the admin surface) and REGISTRY-3 (payments, after Strat picks the provider) follow it.*

---

## Paste this into the new chat

```
This is a parallel session for Minotaur v2 under Architecture_Prompt_v37.md, in Cowork,
with the three mounts. Read the prompt first; the seat check and the state check apply.
Parallel rules apply: no CC handoffs, no schema applied, no governing-document edits.

Then read handoffs/parallel/260913-1435_registry-1_OPENER.md in
~/Developer/Minotaur-Cowork/ and follow it. Its "Settled" list is settled.

Plain English, every message. Do not open with questions; open by reading.
```

---

## What this is

One place, for Daniel's eyes only, that holds every license Minotaur has ever issued — v1 and v2 — with the people behind them, the payments, the terms acceptances, and the beta cohort. Today those facts live in five places: a FileMaker database with serials but no emails, a Square invoice history that lives only in Gmail, the LICDB workbook that reconciled the two (747 people, 181 live licenses, $96,503 across 477 invoices), a `project_members` table that knows nothing about licenses, and, as of migration 60 this afternoon, a `terms_acceptances` table. **This session designs the model that replaces the five with one.** Nothing is built here.

Three Docket rows have been waiting for exactly this: **ENTITLE-V1** (how v2 knows who holds a live v1 license — the v1-holder beta on ≈Oct 15 depends on it), **LIC-NOV** (the November checkout), and **SEAT-CAP** (one active editing session per Individual account). The design answers the first outright, gives the second its tables, and gives the third its home.

## Read, in this order

1. `Architecture_Prompt_v37.md`, then `Minotaur_v2_Roadmap_v4_33.md` — ⏭ NEXT and the Docket rows ENTITLE-V1, LIC-NOV, SEAT-CAP, ORG-TIER, MONTHLY-HOLD, COHORT-EMAILS, WAITLIST-NOTIFY, LEGAL-SEP. Read only those rows.
2. `handoffs/parallel/260912_licdb_RETURN.md` and `reference/v1-licensing/README.md` — what the workbook holds and how each column was derived; the workbook itself is `reference/v1-licensing/v1_Licensing_Database_2026-09-12.xlsx` (People / Serials / Payments / Unmatched).
3. `Minotaur_v1_Serial_Cipher.md` (project knowledge) — a v1 serial decodes to an expiry and a machine id; that is the whole v1 entitlement.
4. `claude/260912-1409_strat-pricing_RETURN.md` — the ruled tiers and transitions.
5. `claude/BETA_TERMS_v0_2.md` §7–§8 — what the terms now promise the cohort about licensing (90 days of normal use after licensing opens, then **disabled, not deleted**; the v1 transitions).
6. `Minotaur_Legal_Brief_Addendum_2026-08-05.md` §A — the admin may see account metadata, never project content. That sentence is the registry's outer boundary.
7. `drafts/260913-1420_terms-accept_DESIGN.md` — the acceptance table as applied (migration 60). Its shape is fixed; the registry adopts it.
8. Live introspection, read-only: `auth.users`, `profiles`, `project_members`, `projects.owner_id`, `terms_acceptances`, and `handle_new_user()`.

## Settled — do not re-litigate

- **Pricing** (2026-09-12): Individual $199/year; Production $349 NfP / $599 Commercial, perpetual per project, unlimited collaborators, one year Individual for the purchaser; students free; no monthly, no free viewing at release; v1 Personal holders free to the end of their year; v1 Production holders free during the beta, ~$100 after; v2 includes v1 on request.
- **Named-user rule** — one account, one natural person; a role address is not a person.
- **SEAT-CAP** is ruled policy (one active editing session per Individual; a second sign-in ends the first); its mechanism is Arch's, before anyone is charged, not a beta-gate item.
- **ORG-TIER** and **MONTHLY-HOLD** are proposals for after the first paid quarter: the model must not preclude an organization account with admin-managed seats, and must not build it.
- **`terms_acceptances`** (migration 60): `id, user_id → auth.users, terms_version, accepted_at, user_agent`; insert-own and select-own only. Adopt it; do not redesign it.
- **Provisioning** (2026-09-13): cohort accounts are created by hand in the Supabase dashboard; operators set their own password through the reset flow. No invite mail.
- **The private beta is free**, and nothing charges anyone before an attorney review of the subscription agreement (LEGAL-SEP).
- **MAILGATE**, and the parallel boundaries below.

## What to design — in this order, each with the tables, columns, keys, RLS and functions written out

1. **Identity.** A *person* is not an *account*. v1 knows people by name and machine id (741 distinct names, 750 machine ids, no email column); v2 knows them by `auth.users` email; the workbook joined them through Gmail. Design the person entity, how a v2 account attaches to it, how a v1 serial attaches to it, and what happens to the 215 people with no email anywhere. The join must survive a person changing email.
2. **License.** One entity for every kind: v1 Personal (annual, machine-bound serial), v1 Production (per show), v1 student/educational, v1 trial, v1 comped; v2 Individual (annual), v2 Production (per project), v2 student, and the transitions the terms promise. States over time (issued, active, expiring, expired, transferred, disabled), the dates that define them, and what a v2 Production license points at (a `projects` row) versus a v1 one (a show name in a note).
3. **Entitlement — the ENTITLE-V1 answer.** One database function the app calls, `entitlement_for(auth.uid())` or its equivalent, that says what this account may open today, computed from the registry and never stored. State how the ≈Oct 15 v1-holder beta gate reads it ("holds a live v1 license" = a serial with an expiry after today, attached to this person), and what the hand-maintained interim allowlist looks like if the import is not clean by then.
4. **Payments.** The Square history as imported facts (477 invoices; amounts, dates, tax), a provider-agnostic shape for November (REGISTRY-3 picks the provider), and the fields NY GBL § 527-a needs for an auto-renewing annual license: consent recorded before the first charge, an acknowledgment sent and kept, the renewal-notice date (15–45 days before the cancellation deadline), and a cancellation the customer can perform. Design the columns; do not design the checkout.
5. **Cohort and invites.** The sixteen leads and their teams, who invited whom, the four July accounts, the waitlist — as registry facts rather than a spreadsheet.
6. **The admin boundary, sketched for REGISTRY-2.** An admin is an `auth.users` id in a table, never a magic email; an `is_admin()` function; every registry table readable and writable by the admin, readable by the operator only where the row is about them, and no registry table ever joins to project content. REGISTRY-2 designs the screen; this session gives it the rules to stand on.
7. **The import.** How the workbook lands: dry-run first, reconciliation counts stated (747 / 181 / 477 / $96,503.42 must reappear or the difference is explained), what "Unmatched" becomes, and what the operator-facing consequence is if a live v1 holder is missed.
8. **Migration sequence.** Which tables must exist before ≈Oct 15 (ENTITLE-V1's), which before November (LIC-NOV's), and which can wait — every one Trigger B, rehearsed with a forced rollback, confirmed by Daniel in the main line, never applied here.

## Boundaries — what this session may not do

No CC handoffs · no migration applied and no schema changed (rehearsal SQL is written into the design, run only inside a transaction that rolls back, and the residue check is reported) · no edits to the Roadmap, Ledger, Session Log, Brief, `CLAUDE.md` or any prompt · no writes to the code repo · no mail · Supabase is read-only here. Write only under `handoffs/parallel/` and `drafts/`. The main line closes and folds this return in.

## Return

`handoffs/parallel/260913-<hhmm>_registry-1_DESIGN.md` — the design, every table written out — and `260913-<hhmm>_registry-1_RETURN.md`: where you landed in plain English; the eight sections' one-paragraph answers; every decision Daniel must make as one line with the default the design takes; the migration sequence with dates; and anything the main line should register, one line each. Copies in `drafts/`.

⚠ **Everything produced is a proposal until Daniel confirms it in the main line.** A written table is not an applied one.
