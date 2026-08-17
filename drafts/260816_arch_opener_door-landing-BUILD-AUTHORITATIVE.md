# ARCH OPENER — DOOR + LANDING, BUILD LEG (AUTHORITATIVE)

*(Issued 2026-08-16 by the MAIN-LINE Cowork-Arch session that closed HARNESS-H4. This SUPERSEDES `handoffs/260816-1210_arch_opener_door-landing-build.md`, which was written by the parallel design seat and — per Arch Prompt v30 §Parallel sessions — binds nothing on its own. That file remains valid as EVIDENCE; this one carries the authority. Paste the block below into a fresh Arch chat.)*

---

Follow the Architecture Prompt. Minotaur v2 — **DOOR + LANDING, build leg**, 2026-08-16.

**You are finishing this unit.** The design is done, the four rulings are TAKEN, and the migration is already APPLIED AND SMOKED. You issue one CC handoff and own the close package. You are not re-deriving any of it.

## YOUR SEAT AND ITS AUTHORITY — read this before anything else

You hold, granted by the main line at this handover:

- **Repo write** — `Minotaur-Cowork/handoffs/to-cc/` (your CC handoff), `Minotaur-Cowork/drafts/` (repo-root deliverables per v30), and `Minotaur/docs/reference/` if the unit touches a catalog.
- **CC handoff authority.** The v30 §Parallel-sessions restriction — *"a parallel session issues no CC handoffs; the main line issues, after the open unit closes"* — is **discharged**: HARNESS-H4 closed and pushed at `13a8233`. You are no longer a parallel design seat. You are the writing seat for this unit.
- **The pen.** You own the DOOR+LANDING close package: **Roadmap v3.14** (retiring v3.13), a Ledger append, a Session Log entry, and CLAUDE.md if the unit touches its claims.

You do **NOT** hold, and must not take:

- **Schema or migration authority. There is nothing left to apply — see below.** If the build somehow surfaces a second schema need, **HALT and route it back to the main line.** That backstop is unchanged, and the reason R-R was ruled the way it was is to keep schema authority at one seat.
- **Anything outside this unit.** Leg 5, the harness, print, AC-HANDLED, account cleanup — none of it is yours.

**THE ONE-WRITER RULE, which is the condition of this grant.** Do not open until Daniel confirms **Roadmap v3.13 is installed** (Minotaur-Cowork committed + pushed, Sync now clicked). From that moment the main-line Arch chat stops writing project documents and you hold the pen alone. Two sessions editing the Roadmap is the one way this pattern fails — it is named as such in v30, and it has been avoided three times by discipline. Do not be the fourth attempt that isn't.

## PRE-OPEN

1. **Read order:** Arch Prompt v30 (Minotaur-Cowork root) → **Roadmap v3.13 WHOLE** (not v3.12 — it is superseded) → Session Log (5 entries; rollover clear, fires at 10) → **`handoffs/parallel/260816-1210_door-landing-design-block.md`** — the design of record, read as evidence, validated at source by the main line → `handoffs/260815_landing_copy_minotaur-app.md` — the ruled copy, build it verbatim except as R-O amends → `handoffs/260816-1210_arch_opener_door-landing-build.md` for the parallel seat's own framing.
2. **Verify, don't trust:** HEAD = origin = **`13a8233`**. **Read git state from `.git/HEAD` and the ref files — NEVER run git in a Cowork mount.** The mechanism, not the manners: the mount denies `unlink`, so `git status` takes `.git/index.lock` and cannot release it, orphaning a lock that halts any live CC session with *"Unable to create index.lock: File exists."* It has happened twice.
3. **Live-read the migration ledger. Expect 50.**

## ✅ THE HALT GATE IS DISCHARGED — do not re-raise it

The parallel seat halted on the signup toggle. Both halves are now closed:

- **(a) Daniel confirmed to the main line, in session: "Signup toggle is off and tested."** Public signup is CLOSED at GoTrue.
- **(b) The exact vendor string no longer matters,** because R-P(a) removes the form. The string becomes unreachable **by construction** rather than handled. Do not spend a round observing a string that the ruling deletes.

## ✅ THE MIGRATION IS DONE — applied and smoked by the main line, 2026-08-16

Per **R-R**, ruled against the parallel seat's recommendation: the main-line Cowork-Arch seat applied it, so schema authority stays where the two existing scoped exceptions already sit and you open against a database that is already correct.

- Migration name: **`door_waitlist_signups_and_join_rpc`**. Ledger **49 → 50**.
- DDL exactly as design block §5.4, unmodified.
- **Posture verified at source:** RLS enabled, **zero policies**, `waitlist_join_v1` is `SECURITY DEFINER` with `search_path=""`.
- **Table grants: `postgres` and `service_role` only. `anon` and `authenticated` are absent entirely** — not policy-restricted, absent.
- **Privilege-level smoke, five checks, all PASS** (`service_role` smoke is blind to grants and was deliberately not used):
  1. `anon` SELECT → *permission denied for table waitlist_signups* ✅
  2. `anon` EXECUTE `waitlist_join_v1` → succeeds, 1 row ✅
  3. `anon` repeat with `PROBE@Example.TEST` → succeeds, **still 1 row** — proves idempotence *and* the `lower(email)` functional unique index ✅
  4. `authenticated` SELECT → permission denied ✅
  5. `anon` direct INSERT, bypassing the RPC → permission denied ✅
- **Census to zero: 0 rows remaining.** The probe row is gone.
- **One observation, harmless, recorded so you don't re-derive it:** `service_role` has `EXECUTE = false` on the RPC, a consequence of `revoke all ... from public`. It needs no execute — it has direct table access. Leave it.

**You have no migration to write and no schema in your CC handoff.** Migrations never ride inside a CC run; that rule is untouched.

## THE FOUR RULINGS — TAKEN (Daniel, 2026-08-16, main line, plain text)

- **R-O — the title tag: (a).** Keep the live `<title>Minotaur Sound System Database</title>` **verbatim and unchanged**; adopt Comms's new meta description. The copy file's "verbatim title tag" is Google's **SERP line** (title + em dash + description), not the tag — verified independently by the main line at `src/app/layout.tsx:5-8`. **Riders:** `title.template` is `'%s — Minotaur'` and the root uses `default`, so **do not set a page-level title on `/`** or it renders `X — Minotaur`; if one is ever wanted it must be `title: { absolute: … }`.
- **R-P — `/auth/signup`: (a).** Keep the route; replace its body with the deliberate closed-door message + waitlist CTA + sign-in link. No form, no Supabase call. Deleting it would 404 an indexed path; keeping the form would leave the vendor string reachable.
  - **Rider, RULED:** `src/app/auth/login/page.tsx:88-91` — *"No account? Create one"* → becomes a **waitlist pointer**. Pedigree (a), Daniel's ruling, 2026-08-16. It is now cited and therefore buildable.
- **R-Q — the waitlist write path: (a).** Route handler + anon-key call to the `SECURITY DEFINER` RPC. **No new secret; no service-role client in `src/`.** The residual is acknowledged and accepted: `waitlist_join_v1` is directly callable via PostgREST, so a determined caller bypasses the honeypot and timing checks. Worst case is junk rows in a table only Daniel reads, and the upgrade path — swap the route handler's anon call for a service-role call — stays cheap if abuse becomes real.
- **R-R — migration: applied by the main line.** See above.

## DOOR-SEO — the correction, and its propagation list

The copy file's SEO block misidentifies the title tag, and **five documents carry it**. R-O resolves the build question; the documents still need fixing, and that is yours at close:

1. `handoffs/260815_arch_opener_door-landing.md` — CONTEXT paragraph
2. `handoffs/260815_landing_copy_minotaur-app.md` — §SEO **and** §BUILD NOTES bullet 1
3. The Aug-15 Comms addendum to the Arch opener — item 2
4. `drafts/HOLD_Roadmap_Merge_2026-08-15_Comms.md` — *"SEO title/meta preserved verbatim"*
5. **Session Log entry 4 — IMMUTABLE.** The correction lands in YOUR new entry and in the Roadmap; entry 4 stands as written.

Roadmap v3.13's DOOR-SEO row carries the corrected statement already — check it rather than restating it from scratch.

**This is a Comms-tier error, not an Arch standing-correction instance.** The Comms addendum routes wording through Daniel: **flag, do not rewrite copy.** It is also the first live instance of the gap v30 §Document Hygiene names — the propagation check binds Arch and cannot legislate for the Comms Prompt — and it is banked as a Comms Prompt v10 datapoint.

## MEASURED FACTS — validated at source by the main line, do not re-derive

Each of these was re-read at `13a8233` by the main line before this opener issued. They hold.

- **ZERO visual-gate frames move.** The gate captures 28 frames across 14 routes; `/`, `/auth/signup` and `/auth/login` are none of them — login is *driven* at `visual-capture.mjs:382` to authenticate the harness, never captured. **No declared baseline event in this unit.** Run the visual gate, expect **28/28 unchanged at the new zero-tolerance default**, and **declare nothing**. No contact with H4's registry or thresholds.
- **`src/lib/supabase/middleware.ts` allowlists exactly `/` and `/auth/*`** for anonymous visitors, and `src/middleware.ts`'s matcher excludes only static assets — so an unlisted **`/api/waitlist` 307s a signed-out POST to `/auth/login`** and the form fails silently. The allowlist line is not optional and must be *in* the CC instruction.
- **`getUser()` runs twice per anonymous hit on `/`** — middleware, then `src/app/page.tsx:7`. Design of record: move the signed-in → `/dashboard` redirect into the middleware and make the landing page a pure server component with no auth call, so the SEO-load-bearing hero renders with zero network dependency.
- **`citext` is NOT installed** and was deliberately not added. Case-insensitivity is the functional unique index, already live.

## YOUR DELIVERABLES

1. **One CC handoff, one unit.** Spec in design block §5.5: the landing page in the copy file's section order, the waitlist form island used twice with a `source` prop, `/api/waitlist` (Origin check, honeypot, submit-timing floor, server-side email validation, truncated-SHA-256 `ip_hash` — describe that as **de-duplication forensics, not anonymisation**), the two middleware lines, the closed-door signup route, the login rider, pure-module tests for the validation and honeypot/timing decision, and **the hero's bid-to-opening sentence as a single named constant** so the plural revision landing ~week of Aug 17 is a one-line edit. `Session: CONTINUE` into the existing CC session unless context budget argues otherwise.
   - **One seam to rule before you issue it:** the RPC raises `rate_limited`, but §5.5 says the route handler returns `{ok:true}` unless the RPC *genuinely* errors. Decide what a rate-limited **legitimate** user sees. Silent success hides a real failure from a real person; a raw error hands a bot a signal. Your call, but make it explicitly.
2. **The close package** — Roadmap **v3.14** retiring v3.13 · Ledger append · Session Log entry · CLAUDE.md if touched · Docket Sweep · `drafts/` copy for any repo-root deliverable.
3. **Register into SHARE build-prep** — with public signup closed, phase-1 auto-accept invites need an account path off the public form (admin-issued / invite-created; `admin.createUser` works with signups disabled). Intent ruled at Strat. **Received, not solved in this unit.**

## DO NOT RE-LITIGATE

The closure · the waitlist ruling · the four accounts staying live · SHARE's four roles · the beta gate · pricing · Sprint 4's leg order · the four rulings above · the migration · **the copy, which is final and Daniel-approved through three rounds** (R-O amends the SEO block's factual error and changes no wording).

## SEQUENCING

Orthogonal to the harness line and to legs 5–6: zero frames, no schema overlap, no shared files. Run in the free CC session now or interleave with leg 5. Priority is ASAP per the Strat ruling and does not wait for Sprint 4's close.
