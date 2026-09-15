# SHARING REV-B — RETURN to the main line

*Arch parallel, Cowork, 2026-09-14. Companion to `260914-1829_sharing-revb_DESIGN.md`, which carries every policy written out and the raw output. Seat check passed; state verified from files — code and origin both `1f82072`, no lock files, migration ledger live-read **64**, Session Log 8 entries, rollover clear.*

> ⚠ **HEAD MOVED DURING THIS SESSION: `1f82072` → `3b98ce9`** (the main line's CC run committed and pushed while this parallel worked). **Every code citation here was re-measured against the new tree at the close and all of them still hold** — `operatorLabel` unchanged at three branches with the raw-id fallback, `COMMIT_POINTS` still exactly 20 entries, `guard.ts` unchanged, `history.ts` still selecting `created_by` with no join, and nothing under `src/lib/verhist/`, `src/components/verhist/` or `src/lib/queries/history.ts` modified since this session opened. **Every database figure was live-read and is independent of the commit.**

> ⚠ **ALL EIGHT DECISION LINES RULED BY DANIEL, 2026-09-14, every one as proposed.** The sections below were written before the rulings and say "recommended" and "default" in places — read those as **ruled**. The two that change the build: **four roles** (so the fourth role is a build, not a question) and **`editor`-only at the invite** (so `viewer` and its whole-app control inventory move to week one together).

***Nothing was applied.*** *Supabase read-only. No CC handoff, no schema change, no governing-document edit, no repo write, no mail, no account created. Residue check clean.*

---

## Where this lands, in plain English

**Sharing is not a feature that is missing. It is a feature that is wired to the wrong half of the database, and one of the wires is live.**

The equipment side of a shared project would work today. The cable side would not — seven tables, the whole cable and bundle system, have no sharing rule at all. That was already on the record from 2026-08-21. **What was not on the record is what those seven tables do to version history.**

Your backup function reads the database *as the person who fired the gesture*. Seven of the twenty tables it reads are the seven that are invisible to anyone but the owner. So the first time an associate you have shared a show with presses Change All, Minotaur takes a backup of that show **with no cables in it at all**, writes it, and tells them it worked. The refusal machinery you ruled in — *"if the snapshot fails, the gesture refuses"* — does not fire, because from its point of view nothing failed. A restore from that backup would return the show with its cable system gone.

I proved it rather than arguing it. On a throwaway project with 10 spine records, 7 cables, a cable type, a bundle, a tail, a link group and a mult line, an editor's Change All produced a backup reading **10 / 0 / 0 / 0 / 0 / 0 / 0 / 0**. After the fix, the same editor, the same gesture: **10 / 7 / 1 / 1 / 1 / 1 / 1 / 1**.

**The hard rule that comes out of it: migration 66 lands before the first membership row that is not `owner` exists anywhere — including the first one you create to test sharing.** Not "before the beta". Before the first one.

Five migrations, all of them permission rules rather than new tables. All five rehearsed in transactions forced to roll back, in sequence, never as one block. Twenty-one privilege probes — as an editor, a viewer, an admin, the owner and a stranger — all green. Ledger still reads 64 and nothing is left behind.

---

## The eight sections, one paragraph each

**1 · The permissions delta.** 34 tables, 63 policies, four groups. **18** are already correct for three roles. **2** are half-done — `projects` and `project_features` read for members but write for the owner only. **8** have no membership rule at all: the seven cable tables plus `project_members` itself. **6** are not project-scoped and are right as they stand. Outside `public`, all four `project-images` storage policies are owner-only, which means **every print a collaborator makes is missing its letterhead.** The design replaces forty hand-written subqueries with three small functions — `can_read_project`, `can_write_project`, `can_admin_project` — so the next role is one line instead of forty edits. **The registry rider is discharged: zero policies anywhere mention a registry table today, and this design adds none.**

**2 · The destructive gestures.** All twenty commit points may be fired by owner, admin and editor; **none** by a viewer, and a viewer needs no new rule to be stopped — every underlying write is already denied. An editor can empty a production in one gesture, which is the ruled meaning of full working access, and the snapshot is the net — which is exactly why §1's fix must land first. The same "blocked read looks like an empty table" shape shows up more quietly in `bulk_delete_v1` and five sibling RPCs, which **return a row count rather than an error**: an editor deleting cables today gets `0` back and no complaint. Converting the tables fixes all of them for free.

**3 · The fourth role.** ⚠ **It is not an open question — SHARE-R1 ruled four roles on 2026-08-12 and you re-ruled them unchanged on 2026-09-12.** The opener's body asks whether three would do; the opener's own Settled list says otherwise, and so does the Ledger. What is actually owed is that **the database still rejects `admin`** — the CHECK constraint has never admitted it, so no row was ever written for a role that does not exist. What `admin` is *for*: the associate who runs the roster and the paperwork while the designer is in another theatre. Three limits, enforced in the database rather than the UI: an admin may not create another admin, nobody may remove or demote the owner, and `owner_id` cannot change through any path, for anyone. **It is not load-bearing for Sept 18** — sixteen leads will hand out `editor`. Make it legal now, surface it after the invite.

**4 · WHOCOL-RLS.** The 2026-08-12 design proposed opening `profiles` to co-members, which hands over your email, avatar, theme and library flag to fix a **name column**. Rejected. `profiles` gains no policy and stays self-only; instead one function returns exactly `(user_id, display_name)`, only for one named project, only to someone who can already read it. It must never expose an email address, any other profile column, or anything at all to a non-member. **One arm exists only because I looked at the data:** a member who leaves still has their id on every snapshot they caused, so the function also resolves names for past authors — otherwise Who re-opens as a raw id the moment someone is removed, which is precisely when you would be reading the history. **Knock-on: AUTH-PROVISION's "write the sixteen real names into `profiles.display_name`" is now load-bearing for the History screen, not just the greeting.**

**5 · Programmatic account creation for a teammate.** A lead types an address. If it has an account, a membership row is written and access is immediate — that is the whole path and it needs no new machinery. If it does not, the app records nothing and creates nothing: **you** run the provisioning script from your own environment on the proven `gate-a-isolation.mjs` pattern (service key from the environment at runtime, never in the deployed app), it creates the account with no password and writes the membership row, and prints the three-step note **for you to send** — MAILGATE holds, the app sends nothing. The person sets their own password in their own browser, which is the only half PKCE permits. **One line in that script is a compliance control, not a convenience: it must not set a password**, or the account skips the terms acceptance the set-password page records.

**6 · Seats.** They answer different questions and never disagree about the same thing. **`registry.license_seats` answers "may this person open this project at all"** — and `my_entitlement()` already returns the list. **`project_members` answers "what may they do once inside".** A membership row costs nothing: a Production licence is per project with unlimited collaborators, so adding an editor consumes no seat and touches no registry table. An Individual licence limits **concurrent editing**, not membership — SEAT-CAP's `edit_claims`, applied at migration 62, mechanism still owed and not built here. When they disagree, the registry wins on access and `project_members` wins on capability — **and the registry's answer is given in the app, never in a policy.** ORG-TIER is not precluded, because `project_members` never learned what a licence is.

**7 · The rehearsal.** Five migrations, each executed separately and in sequence inside a rolled-back transaction, then the objects they create were called at privilege level as `authenticated` with JWT claims set per actor. Fixture was a throwaway created and destroyed inside the transaction — never the Visual Gate Fixture. Twenty-one probes, all matching expectation. Residue check: ledger 64, 63 policies, 4 storage policies, none of the new objects present, role CHECK unchanged, `project_members` still 12 rows, `project_snapshots` still 26, nothing left behind. **Two things the rehearsal could not prove and nobody should assume:** the storage policies were rehearsed as DDL only — exercising them needs a real image in the bucket, which is outside this session's boundary, so **the main line must add one storage probe at apply time**; and the generated types are stale by six migrations, a debt this set does not pay (it changes no table shape, so its own regen is expected zero-diff).

**8 · The sequence.** Before the invite: 65 helpers, 66 cable family (the hard rule), 67 sweep, 68 settings and storage, 69 roster — plus the roster surface itself, which is CC's and is the largest remaining piece. Week one: the snapshot completeness counter, the viewer role if you take D-1, the admin surface, a harness assertion that no project-scoped table can be added without a membership rule. ORG-TIER: seats as an access gate, the organisation account.

---

## The eight decisions — ALL RULED, Daniel, 2026-09-14, every one as proposed

**Nothing below is still open.** Proposed IDs SHARE-R9..R16; the main line assigns the real numbers at the close.

| | Decision | **RULED** |
|---|---|---|
| **D-0** | Four roles, or three? | **FOUR.** SHARE-R1 stands; `admin` made legal at migration 69, surfaced after the invite. The opener's body is the half that is wrong |
| **D-1** | Ship the beta `editor`-only? | **YES.** `viewer` and its whole-app control inventory move to week one together |
| **D-2** | Does the sweep (67) ride the gate? | **YES.** All five migrations before the invite |
| **D-3** | Who sees the roster? | **EVERY ACCEPTED MEMBER.** Closes a question open since 2026-08-21 |
| **D-4** | May an editor fire Delete Unused on the Categories and Methods admin? | **YES.** List work, not settings — R3's fence stops at the Project panel |
| **D-5** | Does `private_notes` stay readable by a viewer? | **STAYS**, and D-1 takes it out of the gate — no viewer exists at the invite. Re-reads with the role in week one |
| **D-6** | Snapshot completeness counter: gate or week one? | **WEEK ONE.** 66 closes the known path; the counter closes the class |
| **D-7** | `teammate_requests` before the invite? | **NO** — "email Daniel". Reconsidered in week one only if the friction is real |

⚠ **The one consequence of D-1 the build must not lose:** with no `viewer` at the invite, **nothing in the beta is read-only.** The "if the write would be RLS-denied, don't render the control" inventory is deferred *with* the role, not skipped — and the day `viewer` lands it is the unit, not an afterthought inside another one.

---

## The migration sequence against the Sept 18 gate

| # | Name | Gate? | Note |
|---|---|---|---|
| 65 | `share_revb_helpers` | **yes** | three functions; inert alone |
| 66 | `share_revb_cable_family` | **yes — first, and before any non-owner membership row** | the seven tables; closes the truncation |
| 67 | `share_revb_sweep` | **yes** (D-2) | 18 tables onto the helpers; the one that could slip |
| 68 | `share_revb_settings_features_storage` | **yes** | R3's editor exclusion, the `owner_id` guard, the four storage policies |
| 69 | `share_revb_roster` | **yes** | roster visibility, self-leave, owner protection, the `admin` CHECK, `project_member_names()` |
| 70 | `share_revb_snapshot_counts` | no — week one (D-6) | makes truncation impossible rather than merely unreachable |

Every one is Trigger B. All five are policy-level: one trigger, one CHECK, four functions, no new tables, no column changes.

---

## For the main line to register — one line each

- ⚠ **The Roadmap's SHARING row says 25 membership rows. The live figure is 12.** Also live: 13 projects, one of which has no owner membership row.
- ⚠ **SHARE-R1 ruled four roles, and the opener's body contradicts its own Settled list.** Whichever way D-0 goes, correct one of them so the next session does not re-derive this.
- ⚠ **`snapshot_project_v1` is SECURITY INVOKER and silently truncates for a non-owner member** — measured. A new evidence row, and it belongs to **version history**, not to SHARING: sharing only arms it.
- ⚠ **`bulk_delete_v1` and five sibling RPCs return counts, not errors, under an RLS refusal.** Same class, quieter. Worth a sentence in `CLAUDE.md` about invoker RPCs and blocked reads.
- **`projects` UPDATE has no `WITH CHECK`** today; Postgres falls back to `USING`. Correct by accident, silent about intent. Fixed in 68.
- **`registry.admins` holds 0 rows**, so `public.is_admin()` returns false for everyone including you — the admin surface cannot be tested until a row exists. REGISTRY-2's first job.
- **`public.is_admin()` is a public-schema definer function reading a registry table.** Used by no policy, and must stay that way — it is the rider's shape one step removed.
- **`service_role` holds no DML grants on the product tables.** Against SRGRANT.
- **TYPES-REGEN: `database.generated.ts` is stale by six migrations.** This set changes no table shape.
- **AUTH-PROVISION's display-name pass is now load-bearing for History's Who column**, not only for the greeting.
- **`project_members.invited_by` has no `ON DELETE` action** — deleting an inviter's profile would error. One line, not in this set.
- **The storage policies were rehearsed as DDL only** — add a privilege probe against a real bucket object at apply time.

---

## One plain next step

**The decisions are done.** The main line applies 65 through 69 in order, one Trigger B confirm at a time, and registers the rulings and the four correction items at the close.

*The design is confirmed. The migrations are not applied — a written policy is not an applied one, and nothing but `owner` goes into `project_members` until 66 has landed.*
