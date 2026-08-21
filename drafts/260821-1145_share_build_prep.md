# SHARE — BUILD PREP (design round, no code)

**Written 2026-08-21 by Cowork-Arch, main line, at `8b078b2` / migration ledger 51.**
**Purpose:** discharge the three things owed since Aug 12, so the SHARE build unit opens cold with nothing blocking it.
**Status:** design deliverable. Nothing here is installed until Daniel confirms it.

---

## 0 — PLAIN SUMMARY, BEFORE THE DETAIL

Sharing is further along than the record implies, and further behind in one specific place that nobody had measured.

- **Further along:** the `project_members` table already exists, already defaults new members to `editor` (which is exactly what SHARE-R6 ruled), and **twenty-one tables already honor membership** in their row-level security. The equipment side of a shared project would work today.
- **Further behind:** **the entire cable and bundle family is owner-only.** Seven project-scoped tables have no membership clause at all. Share a project with a colleague today and they would see the equipment list and the boxes, and every cable page would come back empty. This is the single biggest item in REV-B and it was not on any list.
- **The fourth role does not exist in the database.** The `role` column's CHECK constraint permits `owner · editor · viewer` only. `admin` — Daniel's addition at SHARE-R1 — is rejected by the database today. That is a migration.

So REV-B is not "add a role to some policies." It is **one migration plus a policy sweep across sixteen tables**, and the sweep is the bulk of it.

---

## 1 — WHAT IS ALREADY RULED (not re-litigated here)

SHARE-R1..R7, Ledger Aug 11–12:

- **R1** — four roles: **owner / admin / editor / viewer**. Admin = edit + roster + settings. Daniel's addition over the proposed three; the name "admin" is kept.
- **R2** — invites issued by owner + admin.
- **R3** — project settings: owner + admin; **editors excluded** (the New-Defaults control simply is not rendered for editors).
- **R4** — ownership transfer deferred past public beta; manual support path until then.
- **R5** — phase-1 invites **auto-accept** for existing accounts, in-app, no email, with a courtesy dashboard notice.
- **R6** — default invite role: **editor**.
- **R7** — phase 2 (email invites, `project_invites`) strictly after AUTH-DOMAIN.

Plus: **libraries travel with the project**; 3TL inherits the personal-library leak-proof flag (`profiles.share_library_across_projects`, verified present).

---

## 2 — REV-B: THE RLS DELTA. Measured at source, 2026-08-21, against the live database.

### 2.1 — What exists today

`project_members` — `id · project_id · user_id · role (NOT NULL, default 'editor') · invited_by · accepted_at · created_at`.
Constraints: `UNIQUE (project_id, user_id)` · FKs to `projects` and `profiles`, both `ON DELETE CASCADE` · **`CHECK (role IN ('owner','editor','viewer'))`**.

The established policy idiom on membership-aware tables is a pair:

```
<table>_read   SELECT  : owner OR (member AND accepted_at IS NOT NULL)
<table>_write  ALL     : owner OR (member AND accepted_at IS NOT NULL AND role IN ('editor','owner'))
```

`viewer` is therefore **implicit today** — it is "a member whose role is not in the write array." That is sound and I recommend keeping it rather than enumerating viewer explicitly; enumerating it creates a second place to forget a role.

A `SECURITY DEFINER` helper `is_project_owner(pid uuid)` exists and is used by `project_members_read` — the recursion-safe pattern. **The four-role work should add a sibling helper rather than inline a subquery sixteen times** (see 2.4).

### 2.2 — THE HOLE. Seven project-scoped tables are owner-only.

No membership clause at all; a single `ALL` policy gated on `projects.owner_id = auth.uid()`:

| Table | Consequence for a shared project |
|---|---|
| `cable_details` | every cable invisible and unwritable to a collaborator |
| `cable_types` | cable type library invisible |
| `cable_mult_lines` | mult lines invisible |
| `tail_details` | tails invisible |
| `bundles` | bundles invisible |
| `link_groups` | linkage invisible |
| `link_group_members` | linkage invisible |

**This is not a four-role problem — it is a sharing problem that exists at the current three roles.** It has never surfaced because nothing is shared yet. It must be fixed in the same unit as the role addition, or SHARE ships a product where half the app is blank for everyone but the owner.

Verified not-a-hole, stated so the sweep does not "fix" them:

- `global_cable_types`, `global_default_categories`, `global_default_methods`, `global_equipment_library` — global reference data, not project-scoped. Correct as-is.
- `profiles` — per-user. Correct.
- `waitlist_signups` — **RLS enabled with zero policies**, i.e. deny-all to `authenticated`; writes go through the `SECURITY DEFINER` join RPC. Correct by design (R-Q(a)); leave it alone.

### 2.3 — The `admin` role: what has to change

- **Migration (Arch's, applied from this seat under the R-R precedent, Daniel's confirm):** widen `project_members_role_check` to `('owner','admin','editor','viewer')`.
- **Every write policy's role array** goes from `ARRAY['editor','owner']` to `ARRAY['admin','editor','owner']`. Sixteen membership-aware tables today, plus the seven from 2.2 = **twenty-three write policies**.
- **Zero policies mention `'admin'` anywhere in the database today** — measured. All of it is net-new.

### 2.4 — The recommended shape, and why

Rather than repeating a three-line subquery twenty-three times, add two `SECURITY DEFINER` helpers beside `is_project_owner`:

```
can_read_project(pid uuid)   -- owner OR accepted member, any role
can_write_project(pid uuid)  -- owner OR accepted member with role IN ('admin','editor')
```

Then every policy becomes one call. **The argument is maintenance, and it is the argument this project keeps re-learning:** twenty-three copies of a role array is twenty-three places to forget the next role. When ownership transfer lands (R4, post-public-beta) or licensing adds a tier (~Nov), one function changes instead of twenty-three policies.

**The counter, stated because it is real:** `SECURITY DEFINER` functions inside RLS are a privilege surface, and a bug in one is a bug everywhere at once. Mitigation is the one the project already uses — the functions are tiny, they take only a project id, they return boolean, and the migration smoke verifies them **at privilege level** (as `authenticated`, not as owner), which is the standing engineering rule here.

**Grants must be restored in the same migration whenever an object is recreated.** That is a standing rule and it has bitten this project before (`sprint3_cable_grants_fix`, `SRGRANT`).

### 2.5 — Roster policies need their own delta

`project_members`'s own four policies are **owner-only** for INSERT / UPDATE / DELETE, and `project_members_read` is `own row OR is_project_owner()`. Under SHARE-R1/R2 that is wrong three ways:

- **Admins must be able to insert** (R2: invites by owner + admin).
- **Admins must be able to update and delete** roster rows (R1: admin = edit + roster).
- **Members should be able to see the roster.** Today a collaborator cannot see who else is on the project. That is a UX call, not a security one — Arch recommends **all accepted members can read the roster**, because a shared project whose members are invisible to each other is the kind of surprise this audience does not need in a dark room. **Flagged as an OPEN QUESTION; Daniel rules.**
- **Nobody may delete or demote the owner's own row** — that is R4's deferral holding. Enforce it in the policy, not only in the UI.

### 2.6 — ADM-1 sketch for the fourth role (owed with REV-B)

ADM-1 is metadata-only by ruling (STRAT-ADM-R1): user list, activity, project metadata depth, **never content**. The fourth role touches it in exactly one place: **the admin panel's per-project row now shows a member count and role breakdown** — metadata, not content, so it stays inside R1's fence. Nothing else in ADM-1 changes.

**And the dependency runs the other way too (STRAT-ADM-R4):** per-incident, read-only, user-initiated support access runs **through project sharing**, because no admin content surface exists by design. So the roster surface is where support access is granted and revoked. Two consequences for the build:

- A support grant is an ordinary **viewer** membership. No special role, no special code path. That is the whole point of R4.
- The roster must make **revocation obvious and one gesture**, because the user is the only one who can perform it.

**STRAT-ADM-R6's decoupling contingency stays live:** ADM-1's true minimum has zero sharing dependency. If SHARE slips, ADM-1 splits out to protect October.

---

## 3 — THE CLOSED-SIGNUP INTERACTION. This is an INPUT, and here is the mechanism.

**The problem, plainly.** Public signup closed Aug 15. SHARE phase 1 auto-accepts invites **for existing accounts** (R5). There is now no public path to become an existing account. So phase 1 can only share with the handful of people who already have logins — which is four beta candidates and Daniel. The Aug-15 Strat close routed this here as *intent ruled, mechanism deferred*.

**Three mechanisms, with a recommendation.**

**(a) Admin-issued accounts — RECOMMENDED for phase 1.** Daniel creates the account (Supabase dashboard or a small admin action), the person gets credentials, and from then on they are an existing account and R5's auto-accept works unchanged. **Why this one:** it changes nothing about SHARE, requires no new auth surface, and matches the addendum's posture of record — *"private beta now (invited colleagues, manual provisioning)."* Manual provisioning is not a workaround here; it is the documented plan. Cost: Daniel's time, at private-beta scale, which is a handful of people.

**(b) Invite-created accounts** — an invite to an unknown email mints a pending account. **Not recommended for phase 1.** It is phase 2 wearing a phase-1 costume: it needs an email send, which needs AUTH-DOMAIN, which R7 already fenced behind phase 2. Building a second, weaker email path now means building it twice.

**(c) Re-open signup behind an allowlist** — STRAT-ADM-R2's "ONE bare allowlist-entry field." **Not recommended now.** It re-opens the public surface the Aug-15 ruling closed, for a benefit (self-serve) that four people do not need. Keep it in the pocket for the public-beta ramp, which is what R2 scoped it for.

**The fence that matters, and it is a legal one, not an engineering one:** every account created by any of these paths is a **pre-terms account** until the September engagement lands. Addendum §F already covers attaching terms at next sign-in for the four existing ones. **Any account minted between now and then joins that same set — so the count in §F is not fixed, and the build must not assume it is.** Route to Strat if the number moves materially.

---

## 4 — WHAT THE BUILD UNIT WILL LOOK LIKE (scoping, not the handoff)

Roughly, in dependency order:

1. **Migration (Arch's, not CC's):** widen the role CHECK; add `can_read_project` / `can_write_project`; verify at privilege level.
2. **Policy sweep:** twenty-three write policies + the read side of the seven owner-only tables + the roster's four. **Every recreated object gets its grants restored in the same migration.**
3. **Roster surface:** list members, invite by email, change role, remove, leave-project. Owner row protected. `(ppp)` — the settings header — rides here.
4. **Editor exclusion from settings** (R3) — do not render, do not merely disable.
5. **Courtesy dashboard notice** on auto-accept (R5).
6. **Library travel** — verify `equipment_library_items`' existing `owner_id OR project` policy behaves correctly for a member, and that the personal-library flag does not leak across the boundary (3TL's leak-proof flag).

**Trigger B fires on step 1.** The build unit opens with a MILESTONE HALT and Daniel's confirm, as every schema unit does.

---

## 5 — OPEN QUESTIONS FOR DANIEL (none block writing the build handoff; all block shipping)

1. **Roster visibility** — can all accepted members see the roster, or owner+admin only? (Arch recommends all members.)
2. **Account path** — confirm (a) admin-issued for phase 1.
3. **Can an admin invite another admin?** R2 says admins invite; R1 does not say whether they can promote to their own level. Arch recommends **no** — admins invite editors and viewers; only the owner creates admins. Cheaper to loosen later than to tighten.
4. **Does a viewer see private notes?** `equipment_items.private_notes` and `box_details`' private fields are readable by any member under the current read policies. "Private" is doing no work today. Arch has no recommendation — this is a product call about what the word means.

---

## 6 — WHAT IS DELIBERATELY NOT HERE

No code. No migration SQL. No handoff. Ownership transfer (R4, deferred). Email invites and `project_invites` (R7, after AUTH-DOMAIN). ADM-1 itself beyond the fourth-role sketch.

---

*Every table, policy, constraint and column named in §2 was read from the live database in the session that wrote this document. Nothing here was carried from memory.*
