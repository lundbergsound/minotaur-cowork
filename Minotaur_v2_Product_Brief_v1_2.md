# 📘 PRODUCT BRIEF — Minotaur v2

**Daniel Lundberg Sound Design LLC** • Version 1.2 • September 11, 2026 • CONFIDENTIAL

*Version note (v1.2, 2026-09-11, Strat): retires v1.1 (July 2026). Rewritten: Strategic Context, Pricing Model, Beta Strategy, IP & Legal Status, Reference Artifacts, Parallel Workstreams, Operating Costs & Stop Conditions; the Communications section proposed 2026-08-15 is installed as §15. Sections 9–12 (UX Targets, Design System, Tech Stack, Data Model) are Arch-owned and carried verbatim from v1.1 — several of their status lines are known to be stale and are Arch's to bring current. Every ruling cited is Daniel's, dated; one reading is marked as awaiting his confirmation.*

---

## 📑 Table of Contents

1. [Document Hierarchy](#document-hierarchy)
2. [Product Overview](#product-overview)
3. [Strategic Context](#strategic-context)
4. [Competitive Landscape](#competitive-landscape)
5. [Pricing Model](#pricing-model)
6. [Beta Strategy](#beta-strategy)
7. [IP & Legal Status](#ip--legal-status)
8. [Target Users](#target-users)
9. [UX Targets by Section](#ux-targets-by-section)
10. [Design System](#design-system)
11. [Tech Stack & Architecture](#tech-stack--architecture)
12. [Data Model & Schema Decisions](#data-model--schema-decisions)
13. [Reference Artifacts](#reference-artifacts)
14. [Parallel Workstreams](#parallel-workstreams)
15. [Communications](#communications)
16. [Adjacent Markets](#adjacent-markets)
17. [Operating Costs & Stop Conditions](#operating-costs--stop-conditions)
18. [History of Attempts](#history-of-attempts)

---

## Document Hierarchy

The Minotaur v2 project is governed by three documents. **Read this Brief first in every session.** It points to the others.

- **Product Brief** *(this document)* — canonical, durable. Strategic context, pricing, schema decisions, competitive landscape, reference inventory. Updates at meaningful milestones, not weekly.
- **Roadmap** *(separate doc)* — dynamic, sprint-level. Forward-only: THE TRACK (the dated beta milestones, carried at the top), NOW, NEXT, THE SEQUENCE, THE DOCKET. History lives in its Ledger sibling, read on citation only. Arch chat reads this every session.
- **Session Log** *(separate doc)* — chronological, append-only. Each session: date, chat type, decisions, work started, next concrete action. The "pick up after two weeks" tool.

**Routing rule:** anything strategic and durable goes here. Anything sprint- or task-level goes in Roadmap. Anything chronological goes in Session Log. When in doubt, default to Brief and pointer from elsewhere.

---

## Product Overview

Minotaur v2 is a multi-user SaaS web application for theatrical sound designers and system engineers. It manages equipment inventory, cable systems, RF coordination, box packing, and paperwork output for theatrical sound systems from preliminary design through load-out.

Minotaur v1 (FileMaker, single-user desktop) has been the industry-standard tool since 2015. v2 is a complete rebuild as a collaborative web app: browser-based, real-time multi-user, hosted on Supabase, deployed via Vercel.

**v2 has shipped its first production.** Buena Vista Social Club, Mexico City, met its paperwork deadline on v2 in September 2026. The BVSC North American Tour's cable-label shop target (August 10) was missed and accepted; cable and boxes were far along and the tour did not run on v1.

**Product home:** `minotaur.app` *(also owned: minotaur.audio, lundbergsound.com, daniellundberg.com)*

**Trademark:** "Minotaur" registered with USPTO, 2018, owned by Daniel Lundberg Sound Design LLC.

---

## Strategic Context

**Market position.** Minotaur v1 is used by a majority of Broadway productions since 2022 (58 of 102 shows in the 2022–2024 window). 500+ demos/purchases since 2020. The v1 User Database export of 2026-09-11 holds **774 serials issued to 741 people, 181 of them unexpired on that date** (the v1.1 figure of "285 active/renewed in the preceding 12 months" measured a different thing; the licensing database — see Reference Artifacts — will supply the number this Brief carries from v1.3). The product is taught at Carnegie Mellon, DePaul, Michigan Tech, UC Irvine, Cincinnati CCM, Penn State, and Pace University. v1 has standardized workflows, nomenclature, and documentation conventions across the industry.

**The transition imperative.** v1 is degrading: crashes during heavy use, slow runtime, immediate crash on PNG insertion, unsigned-app launch friction. Each OS release increases fragility. The strategic risk is not that a better product emerges — it's that v1 frustration crosses user thresholds during the v2 development window and users defect to ShowBuilder (the one confirmed SaaS competitor).

**Defensive posture.** Speed to a stable beta matters more than feature expansion. The original beta gate — v1 import + Equipment List + Cable + Boxes + PDF output + v2-to-v1 export — is effectively met: round-trip import/export is proven at 100% on three corpora, and the cable, box, and equipment-list print families have had their v1 parity rounds. **From 2026-09-11 the Roadmap is sequenced by the beta track (see Beta Strategy), not by a production.** Parity and housekeeping that do not serve the next beta milestone take a pin, named as a pin.

**Strategic stance on growth.** Sustainable lifestyle business with defensible market position. Target: "dominant on Broadway, hire small per-hour team for support, clear $30K+ after expenses." No outside capital. No pressure for explosive growth. Adjacent markets (touring, eventually) explored only after theatrical SaaS is stable.

---

## Competitive Landscape

| Competitor | Approx. Broadway use (2022–2024) | Platform | Threat level |
|---|---|---|---|
| **Sndwrks** (John McKenna) | ~7 of 102 productions | Desktop/FileMaker-era | Low — no known SaaS version |
| **Dillon Cody's database** | ~6 of 102 productions | Desktop | Low — no known SaaS version |
| **ShowBuilder** (Shannon Slaton) | ~5 of 102 productions | **Web SaaS** | **Direct — confirmed competitor in same space** |
| **Rumored AI-built internal tools** | Unknown | Unknown | Monitor, don't react. Internal tools rarely commercialize. |
| **Minotaur v1** | 58 of 102 productions | Desktop/FileMaker | Dominant; degrading |

**The moat:** market share, industry workflow standardization, taught at universities, owner-operator credibility. **The threat:** ShowBuilder ships a web SaaS solution today; v1 frustration creates defection opportunities; the v2 transition window is the vulnerable period.

---

## Pricing Model

### At release

| Tier | Price | Scope |
|---|---|---|
| **Individual** | $149/year (annual subscription) | One user, unlimited personal projects. **Includes a v1 license on request.** |
| **NfP Production** | $349 perpetual per project | One specific project, unlimited collaborators, includes 1 year Individual for purchaser |
| **Commercial Production** | $599 perpetual per project | One specific project, unlimited collaborators, includes 1 year Individual for purchaser |
| **Student** | Free | Honor system; tighten verification later if abuse appears |

**From release, v1 is no longer sold à la carte** (Daniel, 2026-09-11). A v2 license is the Minotaur license; v1 comes with it for anyone who wants it.

### The transition for v1 license holders (Daniel, 2026-09-11)

- **v1 Personal** → v2 Individual, free, for the rest of the current v1 license year. Then $149 like everyone else. *(Strat's reading, awaiting Daniel's one-word confirmation: the v1.1 "$99 legacy upgrade, first year" rate is retired by this rule.)*
- **v1 Production** → v2 Production on that project, **free if taken during the beta, before release**; after release the upgrade is approximately **$100** (the $499 → $599 difference).
- **Through the beta, the v1 store keeps selling.** A v1 purchase or renewal during the beta is the ticket to v2 — this is what lets revenue continue before v2 has a checkout of its own. Nobody is promised v2 forever for a v1 purchase.

**v1 reference pricing:** Personal $99/yr, NfP Production $299, Commercial Production $499.

**Design intent.** Annual Individual covers ongoing hosting and dev costs. Perpetual Production licenses match how production budgets actually work (per-show, not per-year). No seat count on Production tiers — unlimited collaborators on the specific project. Production licenses must allow any invited user to collaborate regardless of individual license status (architecture requirement, see Schema Decisions). No perpetual Individual option — would create permanent free-hosting liability. Benchmark: Lightwright (theatrical lighting analog) at $149/year individual.

---

## Beta Strategy

### The track (Daniel, 2026-09-11)

| When | Milestone | Gate |
|---|---|---|
| **≈ Sept 18, 2026** | **Private beta** — sixteen named leads plus their production teams (30–40 people) | Version history (fan-out + History screen) · sharing surface · a cable label print on real stock · a full-size v1 show imports on the first try or the import tells the user to split it (APPLY-TIMEOUT) · production READY check · the invite note · **beta terms in force (see IP & Legal — terms before any third-party access)**. Password reset ships first *after* the invite; a hand reset is the week-one crutch, said in the invite. |
| **The four weeks after** | Fix what the cohort finds | The 90-second auth-refresh hang in week one; the v1 entitlement check scoped and built |
| **Target Oct 15, 2026 — floating** | **v1-holder beta** — free to anyone with an active v1 license | Beta terms · entitlement check against the licensing database. Daniel moves the date forward or back on how the private beta goes. |
| **~ November 2026** | Licensing — v2's own checkout | Attorney review of the subscription agreement before the first charge |
| **Release (target January 2027)** | Paid; pricing above | — |

**The cohort's job is the test.** Each lead imports a real past show, prints the paperwork, and exports it back to v1. Three people running that in a week tell more than ten browsing for a month. The exit path is the acceptance criterion, not a feature.

**The private cohort:** Mike Tracey · Jason Crystal · Brendan Friedel · Will Pickens · Jason ONeal · Thomas Ford · Andrew Poppleton · Marcus Myler · Connor Wang · Mike Deyo · Jamie Tippett · Brian Hsieh · Sam Schloegel · Owen Meadows · Kevin Sweetser · Sam Palumbo — and their teams, which is why the sharing surface is a gate item.

**The announcement is the drop, not a tease** (Daniel, 2026-09-11). The v1 license-holder list hears about v2 when the v1-holder beta opens for them — a personal note from Daniel in the Email Prompt's register, not marketing copy. Whether it names productions is decided when it is written. The 2026-08-15 landing copy and the minotaur.app waitlist are the only public surfaces until then.

**Signup state.** Public self-serve signup on minotaur.app was open from approximately July 17 to August 15, 2026, then closed; private-beta posture (invited accounts, manual provisioning) has been enforced in the product since, and signup stays closed until a beta opens under terms. Four real individuals created accounts in the open window; their accounts remain live and accept terms by click-through at next sign-in once the terms exist (Legal Brief Addendum §F).

**University program cohort** — reach out to professors at Carnegie Mellon, DePaul, Michigan Tech, UC Irvine, Cincinnati CCM, Penn State, Pace; propose a spring 2027 class beta. Students already get v1 free, so no friction. After the v1-holder beta is stable.

**Trust signal:** v2-to-v1 export works end-to-end (proven 2026-08, 100% round trip on three corpora). Users will not commit to beta without a known exit path; they now have one, and the invite says so.

---

## IP & Legal Status

**Owned by Daniel Lundberg Sound Design LLC (single-member LLC):**
- "Minotaur" trademark (USPTO, 2018)
- Domains: minotaur.app, minotaur.audio, lundbergsound.com, daniellundberg.com
- Revenue collection through the LLC

**Standing rule (Daniel, 2026-08-15): terms exist before ANY third-party access, paid or unpaid.** The v1.1 trigger — "before first paid commercial user" — was met in the July–August signup window by luck, not design, and is retired. Consequence: beta terms are a gate item for the ≈ Sept 18 private beta.

**Documents, and who writes them (Daniel, 2026-09-11):**
- **Self-drafted by Daniel, Writing Prompt session:** the retroactive IP assignment (Daniel → LLC, to 2015, all Minotaur code and copyright); the beta terms; the privacy policy. The Legal Brief Addendum (2026-08-05, amended 08-15) is the spec: support-access posture, account lifecycle, beta-terms contents, privacy-regime scoping. The assignment carries Daniel's representation that the work was created outside the scope of any employment; **no written invention-assignment agreement was ever signed** (Daniel, 2026-09-11), and no quitclaims are sought from former employers.
- **Attorney, as a review engagement:** the self-drafted documents plus the paid subscription agreement, **before v2 charges anyone** — New York's automatic-renewal statute (GBL § 527-a) is the compliance question a lawyer earns the fee on. Scoping the week of October 5, 2026. Also in scope, unchanged from the Addendum: EULA/subscription agreement, Century Gothic webfont licensing, third-party security-review framing for the paid release.

**Work-for-hire exposure on early v1 code:** assessed 2026-09-11 as real in theory, small in fact, and moot for v2 — v2 contains no v1 code, and the workflows it reproduces are methods of operation. Not chased further.

**No EULA existed for v1; v2 starts clean.**

**LLC structure decision deferred.** Single LLC consolidates sound design and software products today. Separate software LLC considered when (a) liability profiles diverge meaningfully, or (b) partnership/sale conversation becomes active. Revisit with the attorney during the review engagement.

---

## Target Users

| User | Primary Need |
|---|---|
| Sound Designer | Build/manage equipment list; produce shop paperwork |
| A1 / System Engineer | Track packed/drawn/remaining status; manage boxes and cable |
| Associate Sound Designer | Collaborate on equipment and cable lists in real time |
| Production Manager | Read-only access to equipment lists and cost estimates |
| Rental Shop | Receive clean, printable equipment lists and parts schedules |
| Student | Free access for school productions |

**Operating context:** dark, high-pressure live performance environments. Operator-invisible solutions preferred. Avoid anything requiring configuration steps or technical knowledge.

---

*Sections 9–12 below are Arch-owned technical content, carried verbatim from Brief v1.1 (July 2026). Status lines in them — notably the cable and RF "UI not yet" notes and the schema-evaluation status — predate the August and September work and are Arch's to bring current.*

## UX Targets by Section

- **Equipment List:** Match Zite Prototype 1 — speed, keyboard navigation, inline editing feel. Performance benchmark.
- **All other sections** (Cable, RF, Boxes, Walkies, Print, Cover Letter, Bingo, Maintenance): Match FileMaker v1 — functional completeness and workflow logic.
- **Lovable export:** code reference only — not a UX target.

---

## Design System

**Fonts:**
- UI: Century Gothic → CenturyGothic → AppleGothic → Futura → Trebuchet MS → sans-serif
- Monospace (quantities, IPs): DM Mono → Menlo → Monaco → monospace

**Minotaur Colors** (canonical project palette):

| Name | Hex | | Name | Hex |
|---|---|---|---|---|
| Red | #D80B00 | | Brown | #975400 |
| Orange | #EEA036 | | Pink | #F6C6D8 |
| Yellow | #FFF002 | | Aqua | #94E3FE |
| Green | #70AF46 | | Chartreuse | #B8D586 |
| Blue | #0070A3 | | Sand | #E4BF8F |
| Purple | #AF1F7B | | Grey | #C2C3C3 |
| Black | #000000 | | White | #FFFFFF |

White excluded from project color picker (illegible). All 14 available for method badge colors.

**UI conventions:**
- **Topbar:** Dark navy (#0f1826), 48px, fixed. Left: "MINOTAUR SOUND SYSTEM DATABASE v2". Right: theme toggle, user email, sign out.
- **Project header:** White/light bg. Left: ← HOME pill. Center: project name (large italic bold). Right: ⚙ PROJECT SETTINGS pill.
- **Tab bar:** Active = white bg + project-color underline. Inactive = dark/grey bg.
- **Category headers:** Full-width bar in project's paperwork_color with contrast text.
- **Method badges:** Color-coded pills using method's color_hex with auto-contrast text.
- **Light/dark mode:** Stored in localStorage as `minotaur-theme`.

---

## Tech Stack & Architecture

| Layer | Technology | Rationale |
|---|---|---|
| Frontend | Next.js 16 (App Router) + TypeScript | SSR, file routing, Vercel-native |
| Styling | Tailwind CSS v3 + plain CSS | Utility-first, custom design tokens |
| Database | Supabase (PostgreSQL 17) | Managed Postgres, Auth, RLS, Realtime |
| Auth | Supabase Auth | Email/password + magic link |
| PDF generation | @react-pdf/renderer (planned) | Server-side, pixel-accurate layout |
| Hosting (frontend) | Vercel (planned) | Native Next.js, free tier sufficient at start |
| Hosting (backend) | Supabase (us-west-2), project ID `musfmquwwjlggyxckpos` | |
| Version control | GitHub (private repo, planned) | Replaces Dropbox-based current setup |
| Local dev | `localhost:3000` via `npm run dev` | |
| Project location | Will move from `/Users/Daniel/Dropbox/...` to `~/Developer/Minotaur` | Dropbox is data integrity risk for git repos |

**Engineering standards (Next.js/Supabase stack):**
- TypeScript strict mode
- Zod for all input validation at server boundaries
- Supabase RLS policies on every table
- @supabase/ssr for browser + server client separation
- React Server Components where appropriate
- No global state library until proven necessary

**Stack alternatives considered.** Supabase migration cost is acceptable: Postgres underneath means lift-and-shift to Neon or AWS RDS is possible if needed. Stay on Supabase through v2; reconsider when bill becomes meaningful.

---

## Data Model & Schema Decisions

### Confirmed schema requirements for v2

These decisions must be addressed by the arch chat *before* Cable or RF work begins. They are foundational, not feature-level.

**1. Unified equipment table.** All physical objects on a show — equipment items, cables, road cases, RF devices — are fundamentally equipment items with a UID. v2 models them as a single equipment table with type-specific extension tables (cables, boxes, rf_devices) linked by UID. The v1 "allocate" system was a FileMaker constraint, not a design intention; it is eliminated.

**UI consequence:** the tab structure (Equipment / Cable / Boxes / RF) is preserved as filtered views of the same underlying table. The Equipment tab gains an item-type filter (all / manually added / cables / boxes / RF / etc.).

**2. UID-based device connections.** Cable source and destination must be foreign keys to equipment items, not string-matched descriptions. Required for reliable device patch schedules and to prevent Cable rebuild later. The current Lovable export half-implements this with mixed FK/free-text — must be cleaned up.

**3. Patch points as first-class entity.** Inputs, outputs, intercom stations, CCTV cameras/monitors are logical signal endpoints, not physical equipment. A new `patch_points` (or equivalent) table models these. Spreadsheet-first designer workflow becomes a UI surface over this entity, eliminating the redundant data entry between Excel/Google Sheets and Minotaur. *This was Section 7b of the 2024 MSL document — an unbuilt v1 development goal.*

**4. Production license access control.** Production-licensed projects must allow any invited collaborator to access the project regardless of whether they hold an Individual license. RLS policy structure and `project_members` schema must support this. Not a retrofit — architect deliberately.

### Existing schema (v2 current state, updated July 2026)

23 tables in `public` schema, RLS enabled on all. *(See "History of Attempts" for context.)* **July 7 2026: `equipment_items` flattened from parent/child to v1's flat-records shape — see the Equipment note below.**

**Core tables:**
- `profiles` (extends auth.users), `projects`, `project_members` (owner/editor/viewer)

**Equipment:**
- `equipment_items` — **flat records** (each row a real item carrying its own `model` + `description`; `type` discriminator generic/cable/tail/box/rf_device + four 1:1 extension tables). *Flattened from the former self-referencing parent/child model on July 7 2026 to match v1 exactly: `model` is a real column, the bold model header is a computed GROUP BY summary (aggregate QTY = SUM), and `parent_id` is retired to an all-NULL column pending a cleanup drop. This resolved the model-vs-description field conflation (R-2).*
- `equipment_library_items` (per-project)
- `global_equipment_library` (system-wide; empty, awaiting 2,379-item import)
- `equipment_list_revisions` (JSONB snapshots)
- `maintenance_history` (per-item log)

**Organization:**
- `methods`, `categories`, `global_default_methods`, `global_default_categories`

**Project details:**
- `cover_letters`, `boxes`, `box_types`

**Cable system (schema built, UI not yet):**
- `cable_models`, `bundles`, `cables`, `cable_mult_lines`

**RF/Comms (schema built, UI not yet):**
- `rf_devices`, `cast_members`, `walkie_channels`, `walkie_assignments`, `circuits`

**Views:**
- `v_equipment_list` (resolved category/method/method_color/box; exposes `model`; bundle-aware effective-box via `COALESCE(bundle_box, own_box)`; post-flatten the parent self-join is removed and `parent_description` is a null passthrough pending cleanup)
- `v_project_stats` (per-project counts)

**RLS pattern:** simple ownership-based policies (no recursive helper functions). All tables either use `project_id in (select id from projects where owner_id = auth.uid())` or `owner_id = auth.uid()`.

**Status:** the current schema must be evaluated against the four confirmed schema requirements above before Sprint 4 work continues.

---

## Reference Artifacts

| Artifact | Location | Used by | Purpose |
|---|---|---|---|
| **Otter.ai tutorial transcript** | `3093455601_otter_ai_transcript.txt` (project files) | Arch chat (primary), Strat chat | 90-min v1 walkthrough — definitive functional spec for v2 |
| **Lovable export** | `Minotaur.zip` (project files) | Arch chat | TanStack Start codebase, business logic reference, gap analysis source. Was buggy in practice — evaluate honestly |
| **Zite Prototype 1 export** | `.lovable/zite.json` inside Minotaur.zip | Arch chat | 4.7MB Prototype 1 schema and field reference; UX benchmark for Equipment List |
| **MSL document (July 2024)** | `Minotaur_MSL_2024-07-09.pdf` (project files) | Strat chat | Market position context, competitor list, original v1 development goals (some still unbuilt) |
| **Minotaur website** | https://lundbergsound.com/?page_id=656 | Both | Public feature list and user references |
| **v1 User Database exports** | `Minotaur-Cowork/reference/v1-licensing/` — `v1_User_Database_people_2026-09-11.xlsx` (774 serials), `v1_User_Database_sales-to-shows_2026-09-11.xlsx` (121 sales, 2019–June 2022), with README | Strat; the licensing-database session | The spine of the licensing database. No emails, no license types; sales stop June 2022 |
| **v1 licensing database** | `reference/v1-licensing/v1_Licensing_Database_<date>.xlsx` — **pending**, built by a parallel session from Gmail (serial mails, Square invoices) joined to the exports | Strat (segmentation, cohort); Arch (the v2 entitlement check) | Who holds what, active or not, what they paid, beta-candidate signals |
| **v1 serial cipher** | `Minotaur_v1_Serial_Cipher.md` (project knowledge) | The licensing-database session | Decodes any v1 serial to expiry + computer ID |
| **Legal Brief Addendum** | `Minotaur_Legal_Brief_Addendum_2026-08-05.md` (project knowledge), amended 08-15 | Daniel (drafting), the attorney (review) | The spec for the beta terms and privacy policy; signup-state history (§F) |
| **Example I/O spreadsheets** | Held by Daniel — provide to arch chat on request | Arch chat (when designing patch_points UI) | Real-world examples of spreadsheets users currently maintain in parallel with Minotaur |
| **Example signal flow diagrams / rack elevations** | Held by Daniel — provide to arch chat on request | Arch chat (when drawings feature is scoped) | Future drawing-tool UI reference |

**Provisioning rule:** Lovable export and Otter transcript should be uploaded to the Claude Project files so they persist across arch sessions. Other artifacts (I/O spreadsheets, drawings) provided when specifically requested. The licensing files hold customer names, emails and machine IDs and stay in the private Cowork repo.

---

## Parallel Workstreams

| Workstream | Chat tier | Status (2026-09-11) |
|---|---|---|
| **Development** | Strat → Arch → Claude Code | Active. Sequenced by the beta track. Standing instructions from Daniel: small fixes bundle into as few, long handoffs as possible; harness and process findings register as HELD unless they block the beta gate. |
| **Communications** | Email Prompt for the invite and the announcement; Comms chats for landing copy and help docs (Comms Prompt v9 deleted, rewrite owed before the next Comms deliverable) | The invite note and cohort brief are due before Sept 18. The announcement is the v1-holder beta drop. Landing copy drafted Aug 15; waitlist live on minotaur.app. |
| **Legal** | Daniel drafts (Writing Prompt); attorney reviews | Beta terms due before Sept 18. Attorney scoping week of Oct 5; review before the first charge. |
| **Licensing database** | A parallel Cowork session (General Advisor + Gmail) | Opener at `drafts/260911-1350_licensing-db-parallel_OPENER.md`. Feeds the entitlement check and the announcement segmentation. |

**Communications priorities (in order):**
1. Private-beta invite note and one-page cohort brief (before Sept 18)
2. v1-holder beta announcement to the license-holder list — sent at the drop, segmented by license type from the licensing database
3. `minotaur.app` landing page (initial copy drafted; refresh at the drop)
4. Help docs site (initial scaffold — can be Notion)
5. Support email setup (`support@minotaur.app`; `info@minotaur.app` already sends from Gmail)
6. University professor outreach for the spring 2027 cohort
7. Demo video / walkthrough materials (eventually)

---

## Communications

*Installed in v1.2 from the section proposed by the 2026-08-15 Comms session; Strat's to maintain.*

**Who they are.** Theatrical sound designers, associate designers, A1s and system engineers, production sound shops, and university professors teaching sound design. Senior, credentialed, time-poor. Many hold v1 licenses and have standardized their paperwork on it; students already get v1 free. They work in dark, high-pressure environments and read paperwork for a living — they notice a wrong column header before they notice a headline.

**What they trust.** Named productions and named people. Specific workflow detail in their own vocabulary (equipment list, mult, shop order, bid, load-in). Owner-operator presence — Daniel builds it, uses it on his own shows, and answers his own email. A known exit path: round-trip import/export outranks any feature claim. Honesty about what isn't built yet.

**What alienates them.** SaaS marketing register of any kind. Feature promises ahead of shipping. Anything that reads as replacing workflows they standardized on rather than carrying those workflows forward. Vagueness about data ownership or portability. Hype adjectives.

**What works.** Plain declarative sentences. First person. Concrete workflow moments ("import the workbook, match three columns, print"). Naming the schools and the shows. Selling v1 today while building v2, without pretending v1 is other than it is.

**The respect test.** Would the most skeptical Broadway A1 read this at the shop table and feel respected rather than sold to? Every sentence must survive being read aloud at a shop table.

**Voice sources.** Writing Prompt v1 §Daniel's Voice is the canonical statement of the voice; Email Prompt v7 carries the same rules derived from real emails, with calibration samples. The Otter demo transcript exemplifies the instructional register; the public v1 page the product-copy register; the MSL document the formal one. A Comms Prompt rewrite should point at Writing Prompt v1 for voice rather than carry its own copy.

---

## Adjacent Markets

**Near-adjacent (post-beta consideration):**
- **Concert touring** — same workflow (rented systems, multi-person teams, long runs), same nomenclature, overlapping user base. Some existing Minotaur users already use it on tours. Natural first market extension. Schema designed to accommodate.

**Far-adjacent (not pursued in v2 or near future):**
- **AV integration** (corporate, installation) — separate product, separate sales motion, D-Tools is the incumbent. Design schema for extension only. Revisit no earlier than 18 months post-launch.

**Positioning principle:** design for extension, build for theatrical. Do not pursue any market extension until theatrical SaaS is stable and profitable. Touring before AV.

---

## Operating Costs & Stop Conditions

**Estimated production-state monthly burn:** ~$500/month
- Supabase scaling tier (spend cap ON — Daniel, Aug 27; PITR excluded from the cap)
- Vercel (likely still free tier at this scale)
- Domain renewals (annual, minor)
- Claude.ai subscription
- Eventual support tooling

**One-time costs:**
- Attorney review engagement (reduced from the v1.1 $2–5K drafting estimate; scope is review of self-drafted documents plus the subscription agreement)

**Stop conditions:**
1. **Budget floor:** total v2 development spend in 2026 must not exceed Minotaur v1's 2026 revenue (currently ~$20K/year trajectory).
2. **Schedule floor:** if v2 is not in paid beta within nine months of June 2026 (i.e., by ~March 2027), re-evaluate scope, partnership options, or whether to stabilize v1 and pause v2 development. The beta track above lands paid release in January 2027, inside this floor.

*(The v1.1 mid-July BVSC go/no-go is discharged — v2 shipped BVSC Mexico City.)*

---

## History of Attempts

For context — this is the third attempt at Minotaur v2. Each prior attempt left artifacts that inform the current build.

**v1 (2015–present):** FileMaker desktop app. Working product, degrading with OS releases. Used by majority of Broadway productions since 2022. Source of all UX and functional specifications for v2.

**Attempt 1 — Zite prototype (2026, abandoned mid-development):** First v2 effort. Built using Zite (web app builder competing with Lovable). Equipment list section was fast and well-designed — became the UX benchmark for v2's Equipment List. Other sections unfinished. Exported as `zite.json` (4.7MB).

**Attempt 2 — Lovable build (2026, abandoned):** Second v2 effort. Built in TanStack Start. Substantial business logic completed: equipment CRUD, library, admin (categories/methods/groups), full print configuration with filter logic, cable bundles, cover letter, bulk import. Used `zite.json` as canonical reference. Was buggy in practice. Now serves as code reference for current build.

**Attempt 3 — Current Claude Code v2 (June 2026, active):** Next.js 16 / App Router / Supabase. Started fresh with better architectural patterns. Behind Lovable on features at the start; ahead on architecture rigor. **Shipped its first production, BVSC Mexico City, September 2026.**

---

*End of Product Brief v1.2*
