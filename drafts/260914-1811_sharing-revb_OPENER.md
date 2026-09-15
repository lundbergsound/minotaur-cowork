# PARALLEL OPENER — SHARING REV-B, the permissions delta and the fourth role

*Written by the Cowork-Arch main line on 2026-09-14 under Architecture Prompt v37, while CC runs AUTH-FRONTDOOR. Ruled by Daniel 2026-09-14: REV-B is a parallel on the REGISTRY-1 pattern — design, rehearse under forced rollback, apply nothing. The main line applies on Daniel's confirm.*

---

## Paste this into the new chat

```
This is a parallel session for Minotaur v2 under Architecture_Prompt_v37.md, in Cowork,
with the three mounts. Read the prompt first; the seat check and the state check apply.
Parallel rules apply: no CC handoffs, no schema applied, no governing-document edits.

Then read handoffs/parallel/260914-1811_sharing-revb_OPENER.md in
~/Developer/Minotaur-Cowork/ and follow it. Its "Settled" list is settled.

Plain English, every message. Do not open with questions; open by reading.
```

---

## What this is

Minotaur v2 has no sharing. Every project belongs to exactly one person, and the private beta on ≈Sept 18 is sixteen leads **plus their teams — 30 to 40 people**. A lead who cannot put their associate on a show will hit that wall on day one.

The policy half is done: SHARE-R1 through R8 were ruled on 2026-08-12 and re-ruled unchanged on 2026-09-12. `project_members` exists, with `owner`, `editor` and `viewer` in its role column. **What has never been designed is what `editor` and `viewer` are actually allowed to do in the database** — that is REV-B, owed since 2026-08-12, and it is the only design work left on SHARING.

**This session designs it. Nothing is applied here.**

## The surface, measured live 2026-09-14 (read-only introspection, this seat)

- `public.project_members` holds **12 rows, every one `owner`.** ⚠ The Roadmap's SHARING row says 25; the difference is PROJ-CLEAN-2, which deleted thirteen throwaway projects on 2026-09-13. **12 is the live figure** — the Roadmap row is stale by that one number and the main line corrects it at the close. **No `editor` or `viewer` row has ever existed on this project.**
- **63 RLS policies across 34 tables** in `public`. **20 of those tables already reference `project_members` in a policy; 28 reference `owner_id`.** The delta is therefore not a blank page and not a sweep — it is a reconciliation, and the first job is to say exactly which tables sit in which group and why.
- `registry.license_seats` and `registry.edit_claims` are **applied (migration 62) and both hold 0 rows.** They are SEAT-CAP's home, not this session's build.
- Migration ledger live-read at **64**.

## Read, in this order

1. `Architecture_Prompt_v37.md`, then `Minotaur_v2_Roadmap_v4_37.md` — the Docket rows **SHARING**, **WHOCOL-RLS**, **SEAT-CAP**, **AUTH-PROVISION**, **ORG-TIER**, and the STANDING rows **PROJECT-NAME-NOT-UNIQUE** and **HARNESS-RLS-CORPUS**. Read only those rows.
2. `drafts/260912_sharing-rulings_RECORD.md` — SHARE-R8, the re-ruling of R1–R7, and the section *"What this leaves genuinely open"*. That section is this session's scope statement.
3. `handoffs/parallel/260812-0915_share_rls_delta.md`, `260812-0915_share_decision_block.md`, `260812-0915_adm1_requirements.md` — the 2026-08-12 work. Treat it as prior art to be re-measured, not as truth: it predates the registry, `terms_acceptances`, and version history's twenty commit points.
4. `drafts/260821-1145_share_build_prep.md`.
5. `drafts/260913-1929_registry-1_DESIGN.md` — the registry as applied, so seats are read rather than re-invented.
6. Live introspection, read-only: `pg_policies` for `public`, `project_members`, `projects`, `profiles`, `project_snapshots`, `project_blobs`, `registry.license_seats`, `registry.edit_claims`, and the generated types at `src/types/database.generated.ts` — ⚠ **that file is stale by six migrations (TYPES-REGEN); the database is the surface, the file is not.**

## Settled — do not re-litigate

- **SHARE-R1..R8**, ruled 2026-08-12 and re-ruled unchanged 2026-09-12.
- **SHARE-R8's account-creation path:** Daniel supplies an address, the account is provisioned for it, the operator sets their own password from the sign-in page's reset link. No public form, no password mailed, no shared credential.
- **The sixteen cohort accounts are created BY HAND in the Supabase dashboard** (Daniel, 2026-09-13). Programmatic creation is in scope here **only for a teammate a lead adds** — not for the cohort, and not before the invite.
- **`service_role` never enters the deployed application.** Credentials are a named CC hard-stop. The proven pattern is `scripts/gate-a-isolation.mjs`, which reads the key from the environment at runtime for Auth-admin calls only.
- **SEAT-CAP is ruled policy** — one active editing session per Individual account, a second sign-in ends the first — and **its mechanism is its own row, not this session's.** Say how a seat and a project membership relate; do not build the claim mechanism.
- **ORG-TIER** must not be precluded and must not be built.
- **The named-user rule:** one account, one natural person; a role address is not a person.
- **MAILGATE**, and the boundaries below.

## What to design — in this order, each written out in full

1. **The permissions delta, table by table.** All 34 policied tables, in three groups: already gated on `project_members` (20 today — is each one gated *correctly* for three roles, or only for the owner case?), gated on `owner_id` only (28 today — each needs a decision), and deliberately not shared. For every table: what `owner`, `editor` and `viewer` may select, insert, update and delete, and the policy text that says so. **A viewer who can write anything is a defect; an editor who cannot do their job is the same defect from the other side.**
2. **The destructive gestures.** Version history guards twenty commit points, several of which write or delete across an unbounded scoped set. State, per gesture, whether an `editor` may fire it — Delete All, Change All, Unallocate All, the Bundle List's delete-members arm, and the import. The snapshot is not the permission question; who may cause one is.
3. **The fourth role.** Its sketch has been owed since 2026-08-12. Name what it is *for* before naming what it can do, and say plainly if the honest answer is that three roles are enough and the fourth is ORG-TIER's problem. **A role that exists because a row was written for it is worse than no fourth role.**
4. **WHOCOL-RLS.** History's Who column renders anyone but the viewer as a raw id, because `profiles` is self-only. It becomes visible the day sharing lands. Design the narrowest readable slice — display name for co-members of a shared project and nothing else — and say what it must never expose.
5. **Programmatic account creation for a teammate.** A lead adds an address that has no account. Design the path end to end: where it runs (never the deployed app), what it writes, what the new person sees, what happens when the address already has an account, and what happens when they never accept. ⚠ **It must not send mail** — state the send as a step Daniel performs, gated by MAILGATE.
6. **Seats.** How `registry.license_seats` relates to `project_members` under the ruled tiers: a Production license is per project with unlimited collaborators; an Individual is one person. Say what a membership row costs, if anything, and which of the two tables is the authority when they disagree.
7. **The rehearsal.** For each migration the design proposes: the SQL, run **inside a transaction that rolls back**, with the residue check reported. ⚠ **Run the migrations separately and in sequence in the proof-run, never as one batch** (CLAUDEMD-RIDERS, from REGISTRY-1). **No policy on any product table may reference a registry table** — a registry row answers a question, it never widens a read. That rider is a hard constraint on section 1.
8. **The sequence.** Which pieces must exist before the ≈Sept 18 invite, which can follow the cohort's first week, and which wait for ORG-TIER. Every migration is Trigger B: rehearsed here, confirmed by Daniel in the main line, applied there.

## Boundaries — what this session may not do

No CC handoffs · no migration applied and no schema changed (rehearsal SQL runs only inside a rolled-back transaction, residue check reported) · no edits to the Roadmap, Ledger, Session Log, Brief, `CLAUDE.md` or any prompt · no writes to the code repo · no mail · no account created · Supabase is read-only here. Write only under `handoffs/parallel/` and `drafts/`. The main line closes and folds this return in.

## Return

`handoffs/parallel/260914-<hhmm>_sharing-revb_DESIGN.md` — the design, every policy written out — and `260914-<hhmm>_sharing-revb_RETURN.md`: where you landed in plain English; the eight sections' one-paragraph answers; **every decision Daniel must make as one line with the default the design takes**; the migration sequence against the Sept 18 gate; and anything the main line should register, one line each. Copies in `drafts/`, because `.gitignore` ignores `handoffs/` entirely and a file left only there is not in the repo.

⚠ **Everything produced is a proposal until Daniel confirms it in the main line.** A written policy is not an applied one.
