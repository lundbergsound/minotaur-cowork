# SHARING REV-B — the permissions delta, the destructive gestures, and the fourth role (design)

*Arch parallel, Cowork, 2026-09-14, from the opener `handoffs/parallel/260914-1811_sharing-revb_OPENER.md`. Code `1f82072`, origin `1f82072`, migration ledger live-read **64**, Session Log 8 entries.*

***Nothing here is applied.*** *Supabase was read-only. Every line of DDL below was rehearsed inside transactions forced to roll back; the residue check is in §7 and is clean. Every migration is Trigger B: rehearsed here, confirmed by Daniel in the main line, applied there.*

> ⚠ **HEAD MOVED DURING THIS SESSION: `1f82072` → `3b98ce9`** (the main line's CC run committed and pushed while this parallel worked). **Every code citation below was re-measured against the new tree at the close and all of them still hold** — `operatorLabel` unchanged at three branches with the raw-id fallback, `COMMIT_POINTS` still exactly 20 entries (lines 142–355), `guard.ts` unchanged, `history.ts` still selecting `created_by` with no join, and nothing under `src/lib/verhist/`, `src/components/verhist/` or `src/lib/queries/history.ts` modified since this session opened. **Every database figure was live-read and is independent of the commit.**

> ⚠ **ALL EIGHT DECISION LINES WERE RULED BY DANIEL ON 2026-09-14, every one as this design proposed — see §9.** The design below was written before those rulings and says "default" and "recommended" in places; read every one of those as **ruled**. The two live consequences: **four roles**, so §3 is a build and not a question; and **`editor`-only at the invite**, so the viewer role and its whole-app control inventory move to week one together.

---

## ⚠ Before anything else — the opener disagrees with the record, twice

The Architecture Prompt says to stop and flag it when what the files show and what the documents say disagree. They do.

**One — how many roles there are.** The opener's body says three roles exist and the fourth is an open sketch: *"say plainly if the honest answer is that three roles are enough and the fourth is ORG-TIER's problem."* But the opener's own **Settled** list re-rules **SHARE-R1..R8** unchanged, and the Ledger (line 744) records SHARE-R1 as:

> **SHARE-R1 — FOUR roles: owner / admin / editor / viewer** (admin = edit + roster + settings; Daniel's addition over the proposed three; name "admin" kept)

Ruled 2026-08-12, re-ruled unchanged 2026-09-12. **The Settled list wins.** This design therefore builds four roles and does not re-argue the third one.

What is genuinely owed on the fourth role is not *whether*, it is *that the database rejects it*: `project_members_role_check` still reads `('owner','editor','viewer')`, measured at source. **No row was ever written for `admin`** — the opener's worry that the role exists only because a row exists is the opposite of the truth. §3 supplies the migration and the surface.

**Two — what an editor may do with project settings.** The opener's §1 asks what `editor` may do. **SHARE-R3 already ruled it:** project settings are owner + admin, **editors excluded**, and the New-Defaults silent no-op resolves *by not rendering the control for an editor*, not by widening the database. The 2026-08-12 RLS delta's §3 (which opened `projects` UPDATE to editors) predates that ruling and is superseded. This design follows R3.

---

## 0 — Where this lands, in one paragraph

Sharing is one migration further from working than the record says, and the gap is not a convenience gap. **Seven project-scoped tables — the whole cable and bundle system — have no membership clause at all**, and `snapshot_project_v1` reads them **as the caller**. So the day the first `editor` row exists, any of version history's twenty commit points writes a backup whose entire cable system is empty, reports success, and leaves a restore that would wipe the cables. That is measured, not inferred: §7 shows an editor's Change All producing `10 / 0 / 0 / 0 / 0 / 0 / 0 / 0` against a truth of `10 / 7 / 1 / 1 / 1 / 1 / 1 / 1`, and the same gesture producing `10 / 7 / 1 / 1 / 1 / 1 / 1 / 1` once the seven tables are converted. **Five migrations, all policy-level, all rehearsed clean, twenty-one privilege probes green.**

---

## 1 — The permissions delta, table by table

### 1.1 The surface, measured live 2026-09-14

**34 policied tables in `public`, 63 policies.** Four groups, and the opener's "20 reference `project_members` / 28 reference `owner_id`" is right but overlapping — 28 includes 20. The non-overlapping picture:

| Group | Count | State today |
|---|---|---|
| **A — membership-aware and correct** | **18** | read = owner OR accepted member · write = owner OR member with role in (`editor`,`owner`) |
| **B — membership-aware on read, owner-only on write** | **2** | `projects` (UPDATE owner-only, **no WITH CHECK**) · `project_features` (write owner-only) |
| **C — owner-only, no membership clause at all** | **8** | the 7 cable-family tables, `TO public` · plus `project_members` itself |
| **D — not project-scoped; correct as they stand** | **6** | 4 `global_*` (read `true` to authenticated) · `profiles` (self-only) · `terms_acceptances` (self-only) |

Group A in full: `box_details`, `box_types`, `cast_members`, `categories`, `circuits`, `cover_letters`, `equipment_items`, `equipment_library_items`, `equipment_list_revisions`, `import_identity_map`, `import_runs`, `maintenance_history`, `methods`, `project_blobs`, `project_snapshots`, `rf_device_details`, `walkie_assignments`, `walkie_channels`.

Group C's cable family: `bundles`, `cable_details`, `cable_mult_lines`, `cable_types`, `link_groups`, `link_group_members`, `tail_details`. **All seven carry `project_id`**, so the conversion is mechanical — no join gymnastics.

**Outside `public`:** the four `project-images` storage policies are **all four owner-only**. A member opening a shared project sees no letterhead and no box logo, so every print they make is missing the paperwork header. That is Group C by another name.

**Two facts the record does not carry:**

- `projects` UPDATE has **no `WITH CHECK`** — Postgres falls back to `USING`, which happens to be right today and is silent about its intent. The replacement states both.
- **13 projects, 12 membership rows, and one project has no owner row.** (The opener's 12 is confirmed; the Roadmap's 25 is stale by PROJ-CLEAN-2.) Every policy ORs `projects.owner_id`, so the missing row is cosmetic — but §1.5 flags the tidy.

### 1.2 The shape: three helpers, not forty subqueries

Group A's **38** policies each say the same two sentences in longhand, and groups B and C say them again in another 17. Adding `admin` means editing the role array in every write policy — 20 of them. The 2026-08-21 build prep already proposed the answer and this design takes it:

```sql
public.can_read_project(pid)   -- owner OR accepted member, any role
public.can_write_project(pid)  -- owner OR accepted member with role in (owner, admin, editor)
public.can_admin_project(pid)  -- owner OR accepted member with role in (owner, admin)
```

All three `SQL`, `STABLE`, `SECURITY DEFINER`, `search_path = ''` — the `is_project_owner` house shape, which is what stops a policy on `project_members` recursing into itself. `REVOKE ALL FROM PUBLIC` then `GRANT EXECUTE TO authenticated`; rehearsal confirms `authenticated` is the only grantee.

**`can_write_project` names `admin` from the first day it exists.** That is deliberate and it is free: the CHECK constraint forbids the value, so no row can match until §3's migration widens it. **The consequence is that no policy is ever touched twice** — the fourth role becomes a one-line `ALTER TABLE`, not a second sweep across forty policies.

**The counter, stated because it is real:** a `SECURITY DEFINER` function inside RLS is a privilege surface, and a bug in one is a bug everywhere at once. The mitigation is the one this project already uses — the functions are three lines, they take a project id, they return boolean, and §7 verifies them at privilege level as `authenticated` rather than as owner.

### 1.3 The registry rider, discharged

> *No policy on any product table may reference a registry table — a registry row answers a question, it never widens a read.* (CLAUDEMD-RIDERS)

**Measured: zero policies anywhere in the database mention `registry`, `is_admin` or `my_entitlement` today, and this design adds none.** The three helpers read `public.projects` and `public.project_members` only. Entitlement — *may this person open this project at all* — stays where REGISTRY-1 put it, in `my_entitlement()`, answered by the app. See §6.

⚠ One standing hazard worth naming, not touching: **`public.is_admin()` is a `SECURITY DEFINER` function in the `public` schema that reads `registry.admins`.** It is not used by any policy, and it must never be — it is exactly the shape the rider forbids, one step removed. `registry.admins` currently holds **0 rows**, so `is_admin()` returns false for everyone including Daniel.

### 1.4 What each role may do — the matrix

| Surface | owner | admin | editor | viewer |
|---|---|---|---|---|
| Every project record table (equipment, cable, boxes, RF, library, methods, categories, cover letters, revisions, walkies, maintenance, imports) | all | all | all | **SELECT only** |
| Version history — read the list | ✓ | ✓ | ✓ | ✓ |
| Version history — cause a snapshot | ✓ | ✓ | ✓ | ✗ |
| Project settings (`projects` UPDATE: name, paperwork colour, header images, print defaults, New Defaults) | ✓ | ✓ | **✗ (SHARE-R3)** | ✗ |
| `project_features` (feature flags) | ✓ | ✓ | ✗ | ✗ |
| Roster — see it | ✓ | ✓ | ✓ | ✓ |
| Roster — add / change / remove editors and viewers | ✓ | ✓ | ✗ | ✗ |
| Roster — create an **admin** | ✓ | **✗** | ✗ | ✗ |
| Leave the project themselves | ✗ (owner cannot leave) | ✓ | ✓ | ✓ |
| `projects.owner_id` | **✗ — trigger, for everyone** | ✗ | ✗ | ✗ |
| Delete the project | ✓ | ✗ | ✗ | ✗ |
| Project images (storage) | r/w | r/w | r/w | **read** |

**A viewer who can write anything is a defect; an editor who cannot do their job is the same defect from the other side.** The line this design draws: **an editor owns the paperwork, an admin owns the project's shape and its people, the owner owns the project.** An A1 or associate designer given `editor` can do every piece of show work — build, edit, bulk-change, delete, import, print — and cannot rename the show, repaint its paperwork, change who else is on it, or delete it.

⚠ **Two edges where the line is a judgement and Daniel should see it:**

- **Categories and Methods admin.** Their "Delete Found" / "Delete Unused" gestures are two of the twenty commit points. These are project *configuration*, which reads like R3's territory — but they are the list-management surfaces an A1 uses constantly, and v1 never gated them. **This design leaves them to `editor`.** Decision line D-4.
- **`equipment_items.private_notes`.** Readable by any member, including a viewer, under today's read policies and under this design's. RLS is row-level; hiding a column needs a view or a column-masking rewrite of every read path. **"Private" is doing no work today and this design does not change that.** Decision line D-5 — this is a product call about what the word means, and it is not free to fix.

### 1.5 Hygiene riders — flagged, not folded

- `project_members.invited_by` has **no `ON DELETE` action**; deleting an inviter's profile would error. One line: `on delete set null`. Not in this migration set.
- **One of 13 projects has no owner membership row** (owner rows are app-inserted at create; no trigger). Harmless — every policy ORs `owner_id`. The tidy is an `AFTER INSERT` trigger plus a one-row backfill, and it touches a fixture, which is a declared-event question. Left alone.
- `service_role` holds **no DML grants** on the product tables — only `REFERENCES`, `TRIGGER`, `TRUNCATE`. Noted against SRGRANT; nothing here needs it.
- The seven cable policies are `TO public`; the replacements are `TO authenticated` like the rest of the schema. `anon` has no DML grant today, so this is hygiene rather than a hole.

---

## 2 — The destructive gestures, and the thing that was actually wrong

### 2.1 The finding

**`snapshot_project_v1` is `SECURITY INVOKER`** (`prosecdef = false`, measured). It builds its payload by reading twenty tables **under the caller's RLS**, and every array is wrapped in `coalesce(..., '[]'::jsonb)`.

Seven of those twenty tables are the owner-only cable family.

So for a caller who is a member but not the owner:

- every cable-family read returns nothing,
- `coalesce` turns nothing into `[]`,
- the one existence check the function has (`if v_payload -> 'project' is null ... raise`) passes, because `projects` *is* membership-aware,
- the payload hash differs from the last one, so skip-if-unchanged does not catch it,
- **the row is written, and the function returns a uuid — which the guard reads as success.**

`src/lib/verhist/guard.ts` names "RLS refusal" among the failure modes it catches. **This is not a refusal.** It is a successful write of a truncated backup, and the guard cannot tell. The module's own ruling — *"a safety net the operator believes is there and is not is worse than no net"* — is precisely the state the product enters the day the first editor is added.

**Measured, §7:** editor fires `change_all` → payload `equipment 10 / cables 0 / types 0 / bundles 0 / tails 0 / link groups 0 / link members 0 / mult lines 0`, against a fixture holding `10 / 7 / 1 / 1 / 1 / 1 / 1 / 1`. After migration 66, the same gesture by the same editor → `10 / 7 / 1 / 1 / 1 / 1 / 1 / 1`.

**A second, quieter instance of the same shape:** `bulk_delete_v1` is also `SECURITY INVOKER` and **returns a row count, not an error**. An editor deleting cables today gets `0` back and no complaint. Same for `bulk_update_v1`, `delete_tails_of_cables_v1`, `unlink_group_members_v1`, `merge_methods` and `import_apply_v1` — all invoker, all inheriting whatever the caller can see. Converting the tables converts all of them for free; no RPC needs editing.

**The hard sequencing rule that follows: migration 66 lands before any `editor`, `admin` or `viewer` row is ever written — including the first test one.** This is not "before the beta"; it is before the first membership row that is not `owner`.

### 2.2 Who may fire each of the twenty

The census (`src/lib/verhist/census.ts`) holds twenty commit points. Under §1.4 the answer is uniform and enforced by the tables themselves, not by a new rule:

| Group | Points | owner | admin | editor | viewer |
|---|---|---|---|---|---|
| **Change All** — Equipment List, Cable List, Box List, Equipment Library, Tail List, Bundle List, Mult Lines | 7 | ✓ | ✓ | ✓ | ✗ |
| **Delete Found / Delete All** — Equipment List, Cable List, Box List, Tail List, Bundle List, Categories admin, Methods admin | 7 | ✓ | ✓ | ✓ | ✗ |
| **Unbounded scoped set** — Bundle List's delete-members arm, Cable List's Unallocate All | 2 | ✓ | ✓ | ✓ | ✗ |
| **Manual Save Version** — History | 1 | ✓ | ✓ | ✓ | ✗ |
| **Import apply** — v1 import, workbook equipment, workbook library | 3 | ✓ | ✓ | ✓ | ✗ |

**A viewer fires none of them**, and needs no new rule to be stopped: each gesture's underlying write is already denied, and `project_snapshots_write` is editor-and-above, so a viewer cannot even fill the history with noise. A viewer **reads** history, which is theirs by role.

**An editor fires all twenty, including the two unbounded ones and including Delete All.** That is the ruled meaning of full working access, and it means an editor can empty a production in one gesture. The snapshot is the net — which is exactly why §2.1 must land first. *The snapshot is not the permission question; who may cause one is, and the answer is: anyone who may cause the damage it protects against, and nobody else.*

⚠ **One thing the roles do not protect and this design will not pretend to:** two editors in the same list are **last-write-wins on refresh**. Real-time collaboration is post-beta by the Sprint Plan, and the beta terms' data-loss language covers the posture. Worth one sentence in the invite note (Comms lane).

### 2.3 Should the truncation be made impossible, not just unreachable?

After migration 66 there is no known path to a truncated payload. But the defect was never *the cable tables* — it was that **a blocked read and an empty table are the same value**, and the next project-scoped table added without a membership policy re-arms it silently.

**Proposed, and recommended for the cohort's first week rather than the gate (migration 70):** a `SECURITY DEFINER` counter, `public.project_payload_counts(pid)`, returning one row of true counts per table, which `snapshot_project_v1` compares against its own array lengths and **raises** on mismatch. It leaks counts and nothing else. The guard then does what it says: a truncated snapshot becomes a refusal, and the operator is told.

**The counter-argument, which is why it is not in the gate set:** it adds a definer surface and a per-snapshot cost to a function already measured at ~570 ms first call on the largest production, for a defect that migration 66 closes. **Default: 66 before the invite, 70 in week one.** Decision line D-6.

**The cheaper half, and it should ride whatever unit touches the harness:** a schema assertion that no project-scoped table in `public` lacks a membership-aware read policy. That is a test, not a migration, and it catches the *next* instance at CI rather than at 2 a.m. in a tech.

---

## 3 — The fourth role

### 3.1 What it is for, before what it can do

`admin` exists for **the associate who runs the show's paperwork while the designer is in a different theatre.** On a Broadway or touring production the lead designer is frequently the person least available to click things: the associate adds the A1, removes the over-hire when the load-out ends, sets the paperwork colour before a print deadline, and does not own the project and should not be able to delete it.

Without `admin`, every one of those is a text message to the designer. With it, the designer delegates the roster and the project's shape while keeping the two things that are actually theirs — **ownership and deletion.**

**The second thing it is for is support.** STRAT-ADM-R4 makes support access user-initiated *through* sharing: Daniel gets invited like anyone else, read-only. That is a **viewer** membership and needs no role of its own — which is the point. `admin` is not the support role, and `admin` is not a Minotaur-staff role. It is a per-project role held by the user's own colleague.

**And here is the honest limit on it:** for the ≈Sept 18 cohort, `admin` is not load-bearing. Sixteen leads adding two or three people each will hand out `editor`. **The role should be made legal now, because making it legal later means a second sweep; the surface that exposes it can follow the invite.** That is the sequencing in §8.

### 3.2 The migration

```sql
alter table public.project_members drop constraint project_members_role_check;
alter table public.project_members add constraint project_members_role_check
  check (role = any (array['owner','admin','editor','viewer']));
```

That is the whole of it, because §1.2's `can_write_project` and `can_admin_project` already name `admin`. **Zero policies change.**

### 3.3 What an admin may not do, and why it is enforced in the database

Three limits, all in the `project_members` policies rather than in the UI, because the UI is not where a roster is protected:

1. **An admin may not create another admin.** Only the owner does. Cheaper to loosen later than to tighten. (Probe 11: `DENIED 42501`. Probe 12, promoting an existing editor to admin: `RAISED 42501` — the `WITH CHECK` rejects the new row rather than silently matching nothing, which is the better of the two failures.)
2. **Nobody may delete or demote the owner's row** — not an admin, not the owner. A project has exactly one owner, and R4 defers transfer past public beta. (Probes 13, 16.)
3. **`projects.owner_id` may not change through this path, for anyone including the owner** — a `BEFORE UPDATE` trigger, raising `42501`. When transfer arrives (R4) it gets a sanctioned path that bypasses this trigger deliberately, rather than a policy that was quietly permissive all along. (Probe 14.)

```sql
create policy "project_members_insert" on public.project_members for insert to authenticated
  with check (
    (public.is_project_owner(project_id) and role in ('admin','editor','viewer'))
    or (public.can_admin_project(project_id) and role in ('editor','viewer')));

create policy "project_members_update" on public.project_members for update to authenticated
  using (
    (public.is_project_owner(project_id) and role in ('admin','editor','viewer'))
    or (public.can_admin_project(project_id) and role in ('editor','viewer')))
  with check (
    (public.is_project_owner(project_id) and role in ('admin','editor','viewer'))
    or (public.can_admin_project(project_id) and role in ('editor','viewer')));

create policy "project_members_delete" on public.project_members for delete to authenticated
  using (
    (public.is_project_owner(project_id) and role <> 'owner')
    or (public.can_admin_project(project_id) and role in ('editor','viewer'))
    or (user_id = auth.uid() and role <> 'owner'));   -- "Leave project"
```

The owner arm never admits `role = 'owner'`, so a second owner row cannot be inserted at all.

### 3.4 Roster visibility

```sql
create policy "project_members_read" on public.project_members for select to authenticated
  using (user_id = auth.uid() or public.can_read_project(project_id));
```

**All accepted members see the roster.** A shared project whose members are invisible to each other is exactly the surprise this audience does not need in a dark room, and knowing who else can change your paperwork is not a privilege. This was flagged as an open question on 2026-08-21 and never ruled — **decision line D-3**, default as written.

### 3.5 ADM-1's touch, owed since 2026-08-12

One place only, and it stays inside STRAT-ADM-R1's metadata-only fence: **the admin panel's per-project row gains a member count and a role breakdown.** Counts, never content. Nothing else in ADM-1 changes. STRAT-ADM-R6's decoupling contingency stays live — ADM-1's true minimum has zero sharing dependency.

---

## 4 — WHOCOL-RLS

### 4.1 What breaks, exactly

`operatorLabel` (`src/lib/verhist/historyRow.ts:42`) is three lines: `NULL` → *Automatic*; the viewer themself → their own name; **anyone else → the raw uuid.** `profiles` is self-only, so a third party has no name to show. Today that is invisible, because 30 of 34 rows are `pg_cron`'s `NULL` and the rest are the owner's own. **It becomes visible on the first shared project, on the History screen, as a uuid in a column headed Who.**

### 4.2 The narrowest slice — and it is not a policy

The 2026-08-12 design proposed a `profiles_read_co_members` SELECT policy. **This design rejects it.** RLS grants whole rows: that policy hands every co-member your `email`, `avatar_url`, `theme_preference` and `share_library_across_projects`, to fix a name column. Its own author flagged the exposure and proposed a view as the eventual fix. Build the eventual fix now — it is no harder.

```sql
create or replace function public.project_member_names(p_project uuid)
returns table (user_id uuid, display_name text)
language sql stable security definer set search_path to '' as $$
  select pr.id, pr.display_name
  from public.profiles pr
  where public.can_read_project(p_project)
    and (pr.id in (select m.user_id from public.project_members m
                   where m.project_id = p_project and m.accepted_at is not null)
      or pr.id = (select p.owner_id from public.projects p where p.id = p_project)
      or pr.id in (select s.created_by from public.project_snapshots s
                   where s.project_id = p_project and s.created_by is not null));
$$;
revoke all on function public.project_member_names(uuid) from public;
grant execute on function public.project_member_names(uuid) to authenticated;
```

**`profiles` gains no policy. It stays self-only.** The function is the only door, it is scoped to one project, and the caller must already be able to read that project.

**The third arm is the one that only shows up when you look at the data.** A member who leaves still has their id on every snapshot they caused. Without that arm, WHOCOL-RLS closes for current members and re-opens as a raw uuid the moment someone is removed — which is precisely when a designer is most likely to be reading the history. The arm is scoped to `created_by` values that already exist on *that project's* snapshots, so it exposes no one the project's history does not already name.

**What it must never expose:** email addresses · avatar URLs · `theme_preference` · `share_library_across_projects` · any profile of a person who is neither a member of the named project nor an author of one of its snapshots · anything at all to a non-member (probe 20: `0`).

**The app half** (CC's, not this session's): `src/lib/queries/history.ts` fetches the rows, calls `project_member_names(projectId)` once, and maps `created_by` → `display_name`. `operatorLabel` keeps both existing branches — `NULL` → *Automatic*, self → *You* — and the raw-id fallback **stays as the last resort**, because a name that cannot be resolved must degrade to something rather than to nothing.

⚠ `profiles.display_name` is **non-null on all 12 rows today**, but its default is the address's local part (AUTH-PROVISION). A roster reading `mtracey` is not wrong, just unlovely; AUTH-PROVISION's "write the sixteen real names in one confirmed SQL pass" is what makes it read properly, and **that pass is now load-bearing for the History screen, not only for the greeting.**

---

## 5 — Programmatic account creation for a teammate

### 5.1 The constraints, restated because they decide the shape

- **`service_role` never enters the deployed application.** Named CC hard-stop. The proven pattern is `scripts/gate-a-isolation.mjs`, which reads the key from the environment at runtime for Auth-admin calls only.
- **MAILGATE: it must not send mail.** The send is a step Daniel performs.
- **PKCE (measured 2026-09-12):** both Supabase clients are constructed with no `flowType`, so the default applies — a code in an emailed link can only be exchanged by the browser that wrote the matching verifier. **An admin-initiated link cannot be exchanged in the recipient's browser.** Only the user-initiated half works, which is SHARE-R8's whole shape: the operator clicks reset on the sign-in page themselves.
- The cohort's sixteen accounts are created **by hand in the dashboard** and are out of scope here.

### 5.2 The path, end to end

1. **In the app.** A lead opens ⚙ PROJECT → Sharing, types an address, picks a role. The app looks the address up among existing accounts.
2. **Address has an account.** A `project_members` row is written with `accepted_at = now()` (SHARE-R5 auto-accept), `invited_by = auth.uid()`, role from the picker (default `editor`, SHARE-R6). Access is immediate. **This is the whole path for anyone already in the system, and it needs nothing built beyond the roster surface.**
3. **Address has no account.** The app records the request and tells the lead, in words, that the account will be set up and the person will hear from Daniel. Nothing is created and nothing is sent from the app.
4. **Out of band.** Daniel runs the provisioning script from his own environment, on the `gate-a-isolation.mjs` pattern — service key from the environment at runtime, Auth-admin `createUser` with auto-confirm and no password, no mail. The script then writes the `project_members` row for the project that requested them, and prints the three-step note.
5. **Daniel sends the note.** MAILGATE: a standalone yes per send. The note carries AUTH-PROVISION's three steps — go to the sign-in page, use the reset link, set your own password.
6. **The person arrives.** They set their own password in their own browser, which is the half PKCE permits, accept the terms at the set-password page (TERMS-ACCEPT, live at `1f82072`), and land on a dashboard with the project already on it.

**Already has an account:** step 2, no script, no mail. **Never accepts:** nothing to expire — the account exists, unconfirmed as to password, and the membership row is live but unreachable. The lead sees them on the roster and can remove them. No pending state, no token, no cleanup job.

### 5.3 Where step 3 records the request — and the recommendation

`project_members.user_id` is `NOT NULL` and **must stay that way**; a pending-by-email row must not pollute the membership table. Two options:

- **(a) A minimal `public.teammate_requests` table** — `project_id · email · role · requested_by · status · created_at`, owner/admin-only RLS, explicitly the pre-AUTH-DOMAIN stand-in that `project_invites` absorbs at phase 2 (SHARE-R7).
- **(b) No table.** The Sharing panel says *"No Minotaur account for that address yet"* and the lead emails Daniel.

**Recommended: (b) for the gate, (a) in week one if the friction is real.** The table saves Daniel nothing — he creates the account by hand either way — and it saves the lead one context switch. Sixteen leads is not the volume that justifies a new table, an RLS policy set and a migration in the four days before an invite. Decision line D-7.

⚠ **The legal fence, which is not an engineering question:** every account minted by this path is a **pre-terms account** until it accepts. `/beta-terms` is live and the set-password page records an acceptance, so a teammate provisioned this way accepts on first sign-in like anyone else — **provided the script does not set a password for them.** It must not. That is the one line in the script that is a compliance control rather than a convenience.

---

## 6 — Seats, and which table is the authority

**They answer different questions, and that is the whole relationship.**

- **`registry.license_seats` answers: may this person open this project at all?** Keyed `(license_id, person_id)`, in the registry, unreachable from the app. `my_entitlement()` already returns `production_project_ids` — every v2 Production project whose licence the caller either holds or holds a seat on.
- **`public.project_members` answers: what may they do once inside?** Keyed `(project_id, user_id)`, in `public`, the subject of this entire design.

**A membership row costs nothing.** A Production licence is per project with unlimited collaborators (Brief, Schema Decisions #4), so adding an editor consumes no seat and touches no registry table. An Individual licence is one natural person — the named-user rule — and what it limits is **concurrent editing**, not membership: `licenses.concurrent_edit_limit` and `registry.edit_claims`, both applied at migration 62, both holding 0 rows. **SEAT-CAP's mechanism is its own row and this design does not build it.** What this design owes SEAT-CAP is one sentence: *a membership row is not a seat, and removing someone from a project must not release an edit claim.*

**When they disagree, the registry wins on access and `project_members` wins on capability.** A person whose licence lapsed but whose membership row survives must not be able to open the project — and the registry is what says so, in the app, through `my_entitlement()`, **never in a policy** (the rider). A person with a live licence and no membership row sees nothing, which is correct: a licence is not an invitation.

**The practical consequence for the beta:** entitlement is not wired into the app yet, and it does not need to be before Sept 18 — the cohort is comped and `my_entitlement()` returns `beta` for them. **Sharing must not wait on entitlement, and entitlement must not be smuggled into a policy to make sharing feel complete.**

**ORG-TIER is not precluded.** An org licence later is one new table plus a nullable column, with no change to how entitlement is computed and no change to anything in this design — because `project_members` never learned what a licence is.

---

## 7 — The rehearsal

Five migrations. Each executed **separately and in sequence** inside a transaction forced to roll back, never as one block (CLAUDEMD-RIDERS), and then the objects they create were **called** at privilege level as `authenticated` with `request.jwt.claims` set per actor. The fixture is a throwaway project created and destroyed inside the transaction — **never the Visual Gate Fixture** (Probe Rule).

### The migration set

| # | Name | What it does |
|---|---|---|
| **65** | `share_revb_helpers` | `can_read_project` · `can_write_project` · `can_admin_project`; revoke from PUBLIC, grant to `authenticated` |
| **66** | `share_revb_cable_family` | the seven owner-only tables → read/write pair on the helpers, `TO authenticated` |
| **67** | `share_revb_sweep` | the eighteen membership-aware tables rewritten onto the helpers (personal-library arm preserved; the two spine-keyed tables reach `project_id` by join; `equipment_list_revisions` stays per-command) |
| **68** | `share_revb_settings_features_storage` | `projects` read + update (owner/admin, both USING and WITH CHECK) · `owner_id` guard trigger · `project_features` · the four `project-images` storage policies |
| **69** | `share_revb_roster` | role CHECK widened to admit `admin` · the four `project_members` policies incl. self-leave · `project_member_names()` |
| *(70)* | *`share_revb_snapshot_counts`* | *proposed, week one — see §2.3* |

### RAW OUTPUT — the truncation, before and after migration 66

```
[{"seq":1,"phase":"BEFORE","k":"editor snapshot equip/cables/types/bundles/tails/lg/lgm/mult (truth 10/7/1/1/1/1/1/1)","v":"10/0/0/0/0/0/0/0"},
 {"seq":2,"phase":"AFTER66","k":"editor snapshot equip/cables/types/bundles/tails/lg/lgm/mult (truth 10/7/1/1/1/1/1/1)","v":"10/7/1/1/1/1/1/1"}]
```

and, from the first run of the same fixture:

```
[{"phase":"BEFORE","snapshot_row_written":true,"cables_editor_can_read":0,
  "pay_equipment":10,"pay_cable_details":0,"pay_cable_types":0,"pay_bundles":0,
  "pay_tails":0,"pay_link_groups":0,"pay_link_members":0,"pay_mult_lines":0}]
```

### RAW OUTPUT — object and census verification

```
[{"seq":3,"phase":"65","k":"helpers definer/search_path","v":"can_admin_project=true/search_path=\"\" | can_read_project=true/search_path=\"\" | can_write_project=true/search_path=\"\""},
 {"seq":4,"phase":"65","k":"EXECUTE grantees (must be authenticated only)","v":"authenticated"},
 {"seq":5,"phase":"66","k":"cable policies / still TO public","v":"14 / 0"}]

[{"seq":1,"phase":"67","k":"public policies total / referencing a helper / still TO public","v":"63 / 38 / 9"},
 {"seq":2,"phase":"67","k":"policies still naming project_members inline (expect 0 outside project_members itself)","v":"projects.projects_read, project_features.project_features_read"},
 {"seq":3,"phase":"67","k":"equipment_library_items personal arm preserved","v":"2 of 2 policies"}]

[{"seq":1,"phase":"69","k":"admin role row accepted by widened CHECK","v":"true"}]
```

*Reading of `67`: the policy total is unchanged at 63 — nothing added, nothing lost. The nine still `TO public` are the seven cable `_owner` policies (migration 66 was not replayed in that transaction) plus the two `profiles` policies, which stay as they are. The two remaining inline references are `projects_read` and `project_features_read`, which are migration 68's job — the sweep's scope is confirmed complete by what it leaves behind.*

### RAW OUTPUT — twenty-one privilege probes, as `authenticated`

```
[{"seq":1,"actor":"editor","probe":"UPDATE equipment_items (expect 1)","result":"1"},
 {"seq":2,"actor":"editor","probe":"UPDATE projects settings (expect 0 - SHARE-R3)","result":"0"},
 {"seq":3,"actor":"editor","probe":"INSERT roster row (expect DENIED)","result":"DENIED 42501"},
 {"seq":4,"actor":"editor","probe":"project_member_names (expect 4)","result":"4"},
 {"seq":5,"actor":"editor","probe":"sees roster rows (expect 4)","result":"4"},
 {"seq":6,"actor":"viewer","probe":"SELECT equipment_items (expect 1)","result":"1"},
 {"seq":7,"actor":"viewer","probe":"UPDATE equipment_items (expect 0)","result":"0"},
 {"seq":8,"actor":"viewer","probe":"DELETE equipment_items (expect 0)","result":"0"},
 {"seq":9,"actor":"admin","probe":"UPDATE projects settings (expect 1)","result":"1"},
 {"seq":10,"actor":"admin","probe":"INSERT roster editor (expect ALLOWED)","result":"ALLOWED"},
 {"seq":11,"actor":"admin","probe":"INSERT roster ADMIN (expect DENIED)","result":"DENIED 42501"},
 {"seq":12,"actor":"admin","probe":"PROMOTE editor to admin (expect 0)","result":"RAISED 42501"},
 {"seq":13,"actor":"admin","probe":"DELETE the owner row (expect 0)","result":"0"},
 {"seq":14,"actor":"owner","probe":"UPDATE projects.owner_id (expect RAISE)","result":"RAISED 42501"},
 {"seq":15,"actor":"owner","probe":"UPDATE projects name (expect 1)","result":"1"},
 {"seq":16,"actor":"owner","probe":"INSERT a SECOND owner row (expect DENIED)","result":"DENIED 42501"},
 {"seq":17,"actor":"owner","probe":"INSERT an admin (expect ALLOWED)","result":"ALLOWED"},
 {"seq":18,"actor":"non-member","probe":"SELECT equipment_items (expect 0)","result":"0"},
 {"seq":19,"actor":"non-member","probe":"SELECT projects (expect 0)","result":"0"},
 {"seq":20,"actor":"non-member","probe":"project_member_names (expect 0)","result":"0"},
 {"seq":21,"actor":"editor","probe":"self-leave (expect 1)","result":"1"}]
```

**All twenty-one match expectation.** Probe 12 is the one that differs in *mechanism* from the prediction — promoting an existing editor to admin raises `42501` rather than matching zero rows, because `USING` admits the old editor row and `WITH CHECK` then rejects the new one. That is the better of the two failures: the admin is told no rather than watching nothing happen.

### RESIDUE CHECK — run in a fresh transaction after every rehearsal

```
[{"migration_ledger":64,"public_policies":63,"storage_policies":4,
  "revb_objects_present":0,"revb_trigger_present":0,
  "role_check":"CHECK ((role = ANY (ARRAY['owner'::text, 'editor'::text, 'viewer'::text])))",
  "throwaway_residue":0,"pm_rows":12,"snapshots":26,"temp_residue":0}]
```

**Clean.** Ledger still 64. 63 policies, 4 storage policies. None of the five new functions, the trigger, or the widened CHECK exists. No throwaway project survives. `project_members` still 12 rows, all `owner`. `project_snapshots` still 26 — **the rehearsal's snapshots rolled back with everything else.** No temp objects left in `public`.

### What the rehearsal did NOT prove, stated so nobody assumes it did

- **The storage policies were rehearsed as DDL only.** `storage.objects` was not exercised at privilege level — the fixture would need a real object in the `project-images` bucket, and creating one is a write outside this session's boundary. **The main line should add one storage probe at apply time**, on a throwaway project: member SELECT of a header image → visible; viewer INSERT → denied.
- **`database.generated.ts` is stale by six migrations (TYPES-REGEN).** Nothing in this set changes a table shape, so the regen is expected zero-diff — but the regen rides the apply regardless, and the *existing* six-migration drift is a separate debt this design does not pay.
- **No mail was sent, no account created, no schema changed, no governing document edited, no repo write, no CC handoff.**

---

## 8 — The sequence

### Before the ≈Sept 18 invite — the gate set

| | Why it cannot wait |
|---|---|
| **65 helpers** | everything below stands on them; inert on their own |
| **66 cable family** | ⚠ **the hard rule: before the first non-owner membership row exists anywhere, including a test one.** Without it a shared project's cable system is invisible *and* version history silently writes corrupt backups |
| **67 sweep** | the one that could slip — those 18 tables already behave correctly for editor and viewer. It buys: `admin` becomes one line instead of a second sweep, and forty hand-written subqueries become three functions. **Recommended in, because a half-converted schema across a live beta is worse than either end state** |
| **68 settings / features / storage** | without the storage arm every print a member makes is missing its letterhead — a paperwork product that prints wrong paperwork. R3's editor exclusion also lands here |
| **69 roster** | without it members cannot see each other, cannot leave, and the owner row is unprotected. The CHECK widening rides along, inert |
| **the roster surface + viewer UI** | **CC's, and the largest remaining piece.** See the note below |
| **AUTH-PROVISION's display-name pass** | now load-bearing for History's Who column, not only for the greeting (§4) |

⚠ **The lever on the gate, and it is worth a ruling: ship the beta `editor`-only.** The viewer role's cost is not its policies — those are rehearsed and green — it is the UI inventory: *every* edit affordance on *every* surface has to be found and hidden, because "if the write would be RLS-denied, don't render the control." An editor's UI is the owner's UI minus the project-settings panel, which is one surface. **Editor-only removes a whole-app sweep from the four days before the invite and costs the cohort nothing they asked for** — a lead's first need is to put their associate on the show, not to give the production manager a read-only login. Viewer lands in week one with its inventory done properly. Decision line **D-1**.

### The cohort's first week

- **70** — the snapshot completeness counter (§2.3), so a truncated payload becomes a refusal rather than a row.
- The schema assertion in the harness: no project-scoped table without a membership-aware read policy.
- **Viewer**, with its UI inventory, if D-1 goes editor-only.
- The **admin** surface — the roster's role picker gains its fourth entry. The role is already legal; nothing in the database changes.
- `teammate_requests` (§5.3 option (a)) **if** the friction proved real.
- `invited_by on delete set null`.

### Waiting for ORG-TIER

- Seats as an access authority in the app (`my_entitlement().production_project_ids` gating project open).
- The organisation account and its admin — which needs no change to anything designed here, because `project_members` never learned what a licence is.

---

## 9 — The eight decisions — ALL RULED BY DANIEL, 2026-09-14, every one as proposed

**These are now rulings, not defaults.** SHARE-R9 through R16 (proposed IDs; the main line assigns them at the close).

| | Decision | **RULED** |
|---|---|---|
| **D-0** | Four roles or three? | **FOUR**, as SHARE-R1 stands. The Settled list wins; `admin` is made legal at migration 69 and surfaced after the invite. **The opener's body is the half that is wrong** |
| **D-1** | Does the beta ship `editor`-only? | **YES** — `editor` only at the invite; `viewer` lands week one with its UI inventory done properly |
| **D-2** | Does the sweep (67) ride the gate? | **YES** — all five migrations before the invite |
| **D-3** | Who sees the roster? | **EVERY ACCEPTED MEMBER.** Closes an open question standing since 2026-08-21 |
| **D-4** | May an `editor` fire Delete Unused on the Categories and Methods admin? | **YES** — list work, not settings. R3's fence stops at the Project panel |
| **D-5** | Does `private_notes` stay readable by a viewer? | **STAYS — and D-1 moves it out of the gate entirely**, because no viewer exists at the invite. Re-reads with the viewer role in week one |
| **D-6** | Snapshot completeness counter: gate or week one? | **WEEK ONE** — 66 closes the known path, the counter closes the class |
| **D-7** | `teammate_requests` table before the invite? | **NO** — "email Daniel". The table is reconsidered in week one only if the friction proves real |

⚠ **Consequence of D-1 that the build must not lose:** with no `viewer` at the invite, **nothing in the beta is read-only.** The "if the write would be RLS-denied, don't render the control" inventory is deferred *with* the role, not skipped — and the day `viewer` lands, that sweep is the unit, not an afterthought inside another one.

---

## 10 — For the main line to register

- ⚠ **The Roadmap's SHARING row says 25 membership rows; the live figure is 12** (PROJ-CLEAN-2 deleted thirteen throwaway projects on 2026-09-13). Also live: **13 projects, one of them with no owner membership row.**
- ⚠ **SHARE-R1 ruled four roles and the opener's body contradicts its own Settled list.** Whichever way D-0 goes, one of the two should be corrected so the next session does not re-derive this.
- ⚠ **`snapshot_project_v1` is `SECURITY INVOKER` and silently truncates for a non-owner member** — measured, §7. This is a new evidence row, not a SHARING row: it is version history's defect, armed by sharing.
- ⚠ **`bulk_delete_v1` and five sibling RPCs return counts, not errors, under RLS refusal.** Same class, quieter. Converted for free by migration 66; worth a line in `CLAUDE.md` about invoker RPCs and blocked reads.
- **`registry.admins` holds 0 rows**, so `public.is_admin()` returns false for everyone including Daniel. Not a defect — REGISTRY-2's first job — but the admin surface cannot be tested until a row exists.
- **`public.is_admin()` is a `public`-schema definer function reading a registry table.** Unused by any policy today. It must stay that way; it is the rider's shape one step removed.
- **`service_role` holds no DML grants on the product tables.** Against SRGRANT.
- **TYPES-REGEN:** `src/types/database.generated.ts` is stale by six migrations. Nothing here changes a table shape, so this set's regen is expected zero-diff — the existing drift is a separate debt.

---

*Written from live read-only introspection on 2026-09-14 against migration ledger 64. Every count, policy, constraint, column and function named above was read from the database or the repo in this session; nothing was carried from the record without re-measuring. **Everything here is a proposal until Daniel confirms it in the main line. A written policy is not an applied one.***

---

# APPENDIX — the five migrations, in full

*Exactly as rehearsed. Apply order is 65 → 69, each its own migration file, never one batch.*

## Migration 65 — `share_revb_helpers`

```sql
create or replace function public.can_read_project(pid uuid) returns boolean
language sql stable security definer set search_path to '' as $$
  select exists (select 1 from public.projects p
                 where p.id = pid and p.owner_id = auth.uid())
      or exists (select 1 from public.project_members m
                 where m.project_id = pid and m.user_id = auth.uid()
                   and m.accepted_at is not null);
$$;

create or replace function public.can_write_project(pid uuid) returns boolean
language sql stable security definer set search_path to '' as $$
  select exists (select 1 from public.projects p
                 where p.id = pid and p.owner_id = auth.uid())
      or exists (select 1 from public.project_members m
                 where m.project_id = pid and m.user_id = auth.uid()
                   and m.accepted_at is not null
                   and m.role in ('owner','admin','editor'));
$$;

create or replace function public.can_admin_project(pid uuid) returns boolean
language sql stable security definer set search_path to '' as $$
  select exists (select 1 from public.projects p
                 where p.id = pid and p.owner_id = auth.uid())
      or exists (select 1 from public.project_members m
                 where m.project_id = pid and m.user_id = auth.uid()
                   and m.accepted_at is not null
                   and m.role in ('owner','admin'));
$$;

revoke all on function public.can_read_project(uuid)  from public;
revoke all on function public.can_write_project(uuid) from public;
revoke all on function public.can_admin_project(uuid) from public;
grant execute on function public.can_read_project(uuid)  to authenticated;
grant execute on function public.can_write_project(uuid) to authenticated;
grant execute on function public.can_admin_project(uuid) to authenticated;
```

## Migration 66 — `share_revb_cable_family`

*Seven tables. The pattern once, then repeated verbatim per table: `bundles`, `cable_details`, `cable_mult_lines`, `cable_types`, `link_groups`, `link_group_members`, `tail_details`.*

```sql
drop policy "bundles_owner" on public.bundles;
create policy "bundles_read"  on public.bundles for select to authenticated
  using (public.can_read_project(project_id));
create policy "bundles_write" on public.bundles for all to authenticated
  using (public.can_write_project(project_id))
  with check (public.can_write_project(project_id));

drop policy "cable_details_owner" on public.cable_details;
create policy "cable_details_read"  on public.cable_details for select to authenticated
  using (public.can_read_project(project_id));
create policy "cable_details_write" on public.cable_details for all to authenticated
  using (public.can_write_project(project_id))
  with check (public.can_write_project(project_id));

drop policy "cable_mult_lines_owner" on public.cable_mult_lines;
create policy "cable_mult_lines_read"  on public.cable_mult_lines for select to authenticated
  using (public.can_read_project(project_id));
create policy "cable_mult_lines_write" on public.cable_mult_lines for all to authenticated
  using (public.can_write_project(project_id))
  with check (public.can_write_project(project_id));

drop policy "cable_types_owner" on public.cable_types;
create policy "cable_types_read"  on public.cable_types for select to authenticated
  using (public.can_read_project(project_id));
create policy "cable_types_write" on public.cable_types for all to authenticated
  using (public.can_write_project(project_id))
  with check (public.can_write_project(project_id));

drop policy "link_groups_owner" on public.link_groups;
create policy "link_groups_read"  on public.link_groups for select to authenticated
  using (public.can_read_project(project_id));
create policy "link_groups_write" on public.link_groups for all to authenticated
  using (public.can_write_project(project_id))
  with check (public.can_write_project(project_id));

drop policy "link_group_members_owner" on public.link_group_members;
create policy "link_group_members_read"  on public.link_group_members for select to authenticated
  using (public.can_read_project(project_id));
create policy "link_group_members_write" on public.link_group_members for all to authenticated
  using (public.can_write_project(project_id))
  with check (public.can_write_project(project_id));

drop policy "tail_details_owner" on public.tail_details;
create policy "tail_details_read"  on public.tail_details for select to authenticated
  using (public.can_read_project(project_id));
create policy "tail_details_write" on public.tail_details for all to authenticated
  using (public.can_write_project(project_id))
  with check (public.can_write_project(project_id));
```

## Migration 67 — `share_revb_sweep`

**The fourteen plain project-scoped tables.** Repeat verbatim for `box_types`, `cast_members`, `categories`, `circuits`, `cover_letters`, `equipment_items`, `import_identity_map`, `import_runs`, `maintenance_history`, `methods`, `project_blobs`, `project_snapshots`, `walkie_assignments`, `walkie_channels`:

```sql
drop policy "box_types_read"  on public.box_types;
drop policy "box_types_write" on public.box_types;
create policy "box_types_read"  on public.box_types for select to authenticated
  using (public.can_read_project(project_id));
create policy "box_types_write" on public.box_types for all to authenticated
  using (public.can_write_project(project_id))
  with check (public.can_write_project(project_id));
```

**`equipment_library_items` — the personal-library arm is PRESERVED.** `owner_id = auth.uid()` is 3TL's tier-2 reservation; it holds zero rows today and must not be dropped by a sweep that does not know what it is for.

```sql
drop policy "equipment_library_items_read"  on public.equipment_library_items;
drop policy "equipment_library_items_write" on public.equipment_library_items;
create policy "equipment_library_items_read"  on public.equipment_library_items
  for select to authenticated
  using (owner_id = auth.uid() or public.can_read_project(project_id));
create policy "equipment_library_items_write" on public.equipment_library_items
  for all to authenticated
  using (owner_id = auth.uid() or public.can_write_project(project_id))
  with check (owner_id = auth.uid() or public.can_write_project(project_id));
```

**`box_details` and `rf_device_details` carry NO `project_id`** — they are keyed on the equipment spine id, which is why `snapshot_project_v1` reaches them by join and says so in its own comment. Their policies reach the project the same way:

```sql
drop policy "box_details_read"  on public.box_details;
drop policy "box_details_write" on public.box_details;
create policy "box_details_read"  on public.box_details for select to authenticated
  using (id in (select ei.id from public.equipment_items ei
                where public.can_read_project(ei.project_id)));
create policy "box_details_write" on public.box_details for all to authenticated
  using (id in (select ei.id from public.equipment_items ei
                where public.can_write_project(ei.project_id)))
  with check (id in (select ei.id from public.equipment_items ei
                     where public.can_write_project(ei.project_id)));

drop policy "rf_device_details_read"  on public.rf_device_details;
drop policy "rf_device_details_write" on public.rf_device_details;
create policy "rf_device_details_read"  on public.rf_device_details for select to authenticated
  using (id in (select ei.id from public.equipment_items ei
                where public.can_read_project(ei.project_id)));
create policy "rf_device_details_write" on public.rf_device_details for all to authenticated
  using (id in (select ei.id from public.equipment_items ei
                where public.can_write_project(ei.project_id)))
  with check (id in (select ei.id from public.equipment_items ei
                     where public.can_write_project(ei.project_id)));
```

**`equipment_list_revisions` stays per-command** — it is the one table whose four policies were written separately, and the guard trigger `equipment_list_revisions_guard` depends on that shape.

```sql
drop policy "equipment_list_revisions_read"   on public.equipment_list_revisions;
drop policy "equipment_list_revisions_insert" on public.equipment_list_revisions;
drop policy "equipment_list_revisions_update" on public.equipment_list_revisions;
drop policy "equipment_list_revisions_delete" on public.equipment_list_revisions;
create policy "equipment_list_revisions_read"   on public.equipment_list_revisions
  for select to authenticated using (public.can_read_project(project_id));
create policy "equipment_list_revisions_insert" on public.equipment_list_revisions
  for insert to authenticated with check (public.can_write_project(project_id));
create policy "equipment_list_revisions_update" on public.equipment_list_revisions
  for update to authenticated
  using (public.can_write_project(project_id))
  with check (public.can_write_project(project_id));
create policy "equipment_list_revisions_delete" on public.equipment_list_revisions
  for delete to authenticated using (public.can_write_project(project_id));
```

## Migration 68 — `share_revb_settings_features_storage`

```sql
-- projects: read for every member, settings for owner + admin (SHARE-R3)
drop policy "projects_read" on public.projects;
create policy "projects_read" on public.projects for select to authenticated
  using (public.can_read_project(id));

drop policy "Update own projects" on public.projects;
create policy "projects_update" on public.projects for update to authenticated
  using (public.can_admin_project(id))
  with check (public.can_admin_project(id));
-- NOTE: the retired policy had NO with_check; Postgres fell back to USING.
-- The replacement states both explicitly.

-- ownership is not changed through this path, by anyone, including the owner.
-- SHARE-R4 defers transfer past public beta; when it arrives it gets a
-- sanctioned path that bypasses this trigger deliberately.
create or replace function public.guard_projects_owner_column() returns trigger
language plpgsql security definer set search_path to '' as $$
begin
  if new.owner_id is distinct from old.owner_id then
    raise exception 'projects.owner_id may not be changed through this path'
      using errcode = '42501';
  end if;
  return new;
end $$;

create trigger guard_projects_owner_column
  before update on public.projects
  for each row execute function public.guard_projects_owner_column();

-- feature flags are owner + admin surface
drop policy "project_features_read"  on public.project_features;
drop policy "project_features_write" on public.project_features;
create policy "project_features_read"  on public.project_features for select to authenticated
  using (public.can_read_project(project_id));
create policy "project_features_write" on public.project_features for all to authenticated
  using (public.can_admin_project(project_id))
  with check (public.can_admin_project(project_id));

-- project-images: members read (letterheads and box logos must render for a
-- member's print), editors and above write.
drop policy "project_images_select" on storage.objects;
drop policy "project_images_insert" on storage.objects;
drop policy "project_images_update" on storage.objects;
drop policy "project_images_delete" on storage.objects;

create policy "project_images_select" on storage.objects for select to authenticated
  using (bucket_id = 'project-images'
         and (storage.foldername(name))[1] in
             (select p.id::text from public.projects p where public.can_read_project(p.id)));

create policy "project_images_insert" on storage.objects for insert to authenticated
  with check (bucket_id = 'project-images'
              and (storage.foldername(name))[1] in
                  (select p.id::text from public.projects p where public.can_write_project(p.id)));

create policy "project_images_update" on storage.objects for update to authenticated
  using (bucket_id = 'project-images'
         and (storage.foldername(name))[1] in
             (select p.id::text from public.projects p where public.can_write_project(p.id)))
  with check (bucket_id = 'project-images'
              and (storage.foldername(name))[1] in
                  (select p.id::text from public.projects p where public.can_write_project(p.id)));

create policy "project_images_delete" on storage.objects for delete to authenticated
  using (bucket_id = 'project-images'
         and (storage.foldername(name))[1] in
             (select p.id::text from public.projects p where public.can_write_project(p.id)));
```

⚠ **The folder comparison stays `text = text`, deliberately.** Casting `(storage.foldername(name))[1]` to `uuid` would raise on any object in another bucket whose first folder segment is not a uuid, and AND-clause evaluation order is not guaranteed to save it.

## Migration 69 — `share_revb_roster`

```sql
-- SHARE-R1's fourth role becomes legal. can_write_project and
-- can_admin_project already name it; no policy changes.
alter table public.project_members drop constraint project_members_role_check;
alter table public.project_members add constraint project_members_role_check
  check (role = any (array['owner','admin','editor','viewer']));

drop policy "project_members_read"   on public.project_members;
drop policy "project_members_insert" on public.project_members;
drop policy "project_members_update" on public.project_members;
drop policy "project_members_delete" on public.project_members;

-- every accepted member sees the roster (D-3)
create policy "project_members_read" on public.project_members for select to authenticated
  using (user_id = auth.uid() or public.can_read_project(project_id));

-- the owner may seat admins, editors and viewers; an admin may seat editors
-- and viewers only. Neither arm ever admits role = 'owner', so a second owner
-- row cannot be inserted at all.
create policy "project_members_insert" on public.project_members for insert to authenticated
  with check (
    (public.is_project_owner(project_id) and role in ('admin','editor','viewer'))
    or (public.can_admin_project(project_id) and role in ('editor','viewer')));

create policy "project_members_update" on public.project_members for update to authenticated
  using (
    (public.is_project_owner(project_id) and role in ('admin','editor','viewer'))
    or (public.can_admin_project(project_id) and role in ('editor','viewer')))
  with check (
    (public.is_project_owner(project_id) and role in ('admin','editor','viewer'))
    or (public.can_admin_project(project_id) and role in ('editor','viewer')));

-- the last arm is "Leave project". role <> 'owner' everywhere means the owner
-- row cannot be removed by anyone, including the owner.
create policy "project_members_delete" on public.project_members for delete to authenticated
  using (
    (public.is_project_owner(project_id) and role <> 'owner')
    or (public.can_admin_project(project_id) and role in ('editor','viewer'))
    or (user_id = auth.uid() and role <> 'owner'));

-- WHOCOL-RLS. profiles gains NO policy and stays self-only; this function is
-- the only door, and it returns two columns for one project's people.
create or replace function public.project_member_names(p_project uuid)
returns table (user_id uuid, display_name text)
language sql stable security definer set search_path to '' as $$
  select pr.id, pr.display_name
  from public.profiles pr
  where public.can_read_project(p_project)
    and (pr.id in (select m.user_id from public.project_members m
                   where m.project_id = p_project and m.accepted_at is not null)
      or pr.id = (select p.owner_id from public.projects p where p.id = p_project)
      or pr.id in (select s.created_by from public.project_snapshots s
                   where s.project_id = p_project and s.created_by is not null));
$$;
revoke all on function public.project_member_names(uuid) from public;
grant execute on function public.project_member_names(uuid) to authenticated;
```

## Migration 70 — `share_revb_snapshot_counts` *(proposed, week one — §2.3)*

Not written out here, because its shape depends on D-6. The contract, if it is taken: a `SECURITY DEFINER` function returning one row of true per-table counts for a project, called by `snapshot_project_v1` immediately after the payload is built, raising when any array length disagrees. It leaks counts and nothing else, and it turns a silently truncated backup into a refusal the guard already knows how to report.

## Apply-time checklist for the main line

1. Trigger B on every one of 65–69; Daniel's confirm before each.
2. Apply **separately and in sequence**, never as one batch (CLAUDEMD-RIDERS).
3. After each: the census in §7, plus the privilege probes re-run on a throwaway project — **never the Visual Gate Fixture**.
4. **Add the storage probe this session could not run:** a real object in `project-images`, member SELECT visible, viewer INSERT denied.
5. Grants restored and verified wherever an object is recreated (house rule; `sprint3_cable_grants_fix` and SRGRANT are why).
6. Types regen rides the apply — expected zero-diff, run it anyway.
7. **Nothing that is not `owner` goes into `project_members` until 66 is applied.**
