# 📘 PRODUCT BRIEF — Minotaur v2

**Daniel Lundberg Sound Design LLC** • Version 1.1 • July 2026 • CONFIDENTIAL

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
15. [Adjacent Markets](#adjacent-markets)
16. [Operating Costs & Stop Conditions](#operating-costs--stop-conditions)
17. [History of Attempts](#history-of-attempts)

---

## Document Hierarchy

The Minotaur v2 project is governed by three documents. **Read this Brief first in every session.** It points to the others.

- **Product Brief** *(this document)* — canonical, durable. Strategic context, pricing, schema decisions, competitive landscape, reference inventory. Updates at meaningful milestones, not weekly.
- **Roadmap** *(separate doc)* — dynamic, sprint-level. Current sprint priorities, Buena Vista target, mid-July decision point, parallel workstream status. Updates frequently. Arch chat reads this every session.
- **Session Log** *(separate doc)* — chronological, append-only. Each session: date, chat type, decisions, work started, next concrete action. The "pick up after two weeks" tool.

**Routing rule:** anything strategic and durable goes here. Anything sprint- or task-level goes in Roadmap. Anything chronological goes in Session Log. When in doubt, default to Brief and pointer from elsewhere.

---

## Product Overview

Minotaur v2 is a multi-user SaaS web application for theatrical sound designers and system engineers. It manages equipment inventory, cable systems, RF coordination, box packing, and paperwork output for theatrical sound systems from preliminary design through load-out.

Minotaur v1 (FileMaker, single-user desktop) has been the industry-standard tool since 2015. v2 is a complete rebuild as a collaborative web app: browser-based, real-time multi-user, hosted on Supabase, deployed via Vercel.

**Product home:** `minotaur.app` *(also owned: minotaur.audio, lundbergsound.com, daniellundberg.com)*

**Trademark:** "Minotaur" registered with USPTO, 2018, owned by Daniel Lundberg Sound Design LLC.

---

## Strategic Context

**Market position.** Minotaur v1 is used by a majority of Broadway productions since 2022 (58 of 102 shows in the 2022–2024 window). 500+ demos/purchases since 2020, 285 active/renewed licenses in the preceding 12 months. The product is taught at Carnegie Mellon, DePaul, Michigan Tech, UC Irvine, Cincinnati CCM, Penn State, and Pace University. v1 has standardized workflows, nomenclature, and documentation conventions across the industry.

**The transition imperative.** v1 is degrading: crashes during heavy use, slow runtime, immediate crash on PNG insertion, unsigned-app launch friction. Each OS release increases fragility. This is a ticking bomb. The strategic risk is not that a better product emerges — it's that v1 frustration crosses user thresholds during the v2 development window and users defect to ShowBuilder (the one confirmed SaaS competitor).

**Defensive posture.** Speed to functional parity with v1 matters more than feature expansion. Beta gate = v1 import + Equipment List + Cable + Boxes + PDF output stable. Communicate v2 to existing user base now (not at beta) to lock in fence-sitters and seed beta interest.

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

| Tier | Price | Scope |
|---|---|---|
| **Individual** | $149/year (annual subscription) | One user, unlimited personal projects |
| **NfP Production** | $349 perpetual per project | One specific project, unlimited collaborators, includes 1 year Individual for purchaser |
| **Commercial Production** | $599 perpetual per project | One specific project, unlimited collaborators, includes 1 year Individual for purchaser |
| **Student** | Free | Honor system; tighten verification later if abuse appears |
| **v1 Legacy Upgrade** | $99 first year | Available to existing v1 license holders; standard pricing from year two |

**v1 reference pricing:** Personal $99/yr, NfP Production $299, Commercial Production $499.

**Design intent.** Annual Individual covers ongoing hosting and dev costs. Perpetual Production licenses match how production budgets actually work (per-show, not per-year). No seat count on Production tiers — unlimited collaborators on the specific project. Production licenses must allow any invited user to collaborate regardless of individual license status (architecture requirement, see Schema Decisions). No perpetual Individual option — would create permanent free-hosting liability. Benchmark: Lightwright (theatrical lighting analog) at $149/year individual.

---

## Beta Strategy

**Gate:** v1 import + Equipment List + Cable + Boxes + PDF output for those + v2-to-v1 export. Stable, not feature-complete.

**Stretch target:** Buena Vista Social Club tour, into the shop August 10, 2026. *(Scope, timeline, and go/no-go protocol detailed in Roadmap.)*

**Beta cohorts (after BVSC or in parallel):**
- Daniel's 10 colleagues already informed verbally, willing to test on low-stakes productions
- University program beta cohort — reach out to professors at Carnegie Mellon, DePaul, Michigan Tech, UC Irvine, Cincinnati CCM, Penn State, Pace; propose fall 2026 or spring 2027 class beta. Students already get v1 free, so no friction
- v1 license holder list (full database exists) — communicate v2 development now, build pre-beta interest

**Trust signal:** v2-to-v1 export must work end-to-end before any production touches v2. Users will not commit to beta without a known exit path.

---

## IP & Legal Status

**Owned by Daniel Lundberg Sound Design LLC (single-member LLC):**
- "Minotaur" trademark (USPTO, 2018)
- Domains: minotaur.app, minotaur.audio, lundbergsound.com, daniellundberg.com
- Revenue collection through the LLC

**Outstanding gaps (must be resolved before commercial beta — *not* required for BVSC if BVSC is treated as personal/internal use):**
- Written IP assignment from Daniel personally to the LLC, retroactive to 2015, covering all Minotaur code and copyright
- Terms of Service and Privacy Policy for minotaur.app
- EULA / subscription agreement
- Beta-specific terms (limits liability, sets expectations re: data loss, no warranties)
- No EULA exists for v1; v2 starts clean

**Attorney engagement.** Single focused engagement, estimated $2–5K. Trigger: before first paid commercial user. Not required for BVSC (internal use). Not required for beta with friends/colleagues if structured as informal testing. *Required* before public availability or paid signup.

**LLC structure decision deferred.** Single LLC consolidates sound design and software products today. Separate software LLC considered when (a) liability profiles diverge meaningfully, or (b) partnership/sale conversation becomes active. Revisit with the attorney during the IP engagement.

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
| **v1 license-holder database** | Held by Daniel (not in repo) | Daniel (for Comms outreach); Strat (for segmentation) | List of 285+ active license holders for v2 announcement and beta recruitment |
| **Example I/O spreadsheets** | Held by Daniel — provide to arch chat on request | Arch chat (when designing patch_points UI) | Real-world examples of spreadsheets users currently maintain in parallel with Minotaur |
| **Example signal flow diagrams / rack elevations** | Held by Daniel — provide to arch chat on request | Arch chat (when drawings feature is scoped) | Future drawing-tool UI reference |

**Provisioning rule:** Lovable export and Otter transcript should be uploaded to the Claude Project files so they persist across arch sessions. Other artifacts (I/O spreadsheets, drawings, v1 license DB) provided when specifically requested.

---

## Parallel Workstreams

Three workstreams run in parallel, each with its own chat tier:

| Workstream | Chat tier | Status |
|---|---|---|
| **Development** | Strat → Arch → Claude Code | Active. Gap analysis is next arch session. |
| **Communications** | Comms chats (new tier — prompt being drafted) | Comms Prompt v1 not yet written. v2 announcement email to existing user base is first deliverable. |
| **Legal** | Outside attorney engagement | Trigger: before first paid commercial user. Not required for BVSC. |

**Communications priorities (in order):**
1. v2 announcement email to v1 license-holder database (segmented by license type)
2. University professor outreach for fall 2026 / spring 2027 beta cohorts
3. `minotaur.app` landing page (initial version)
4. Help docs site (initial scaffold — can be Notion)
5. Support email setup (`support@minotaur.app`)
6. Demo video / walkthrough materials (eventually)

---

## Adjacent Markets

**Near-adjacent (post-BVSC consideration):**
- **Concert touring** — same workflow (rented systems, multi-person teams, long runs), same nomenclature, overlapping user base. Some existing Minotaur users already use it on tours. Natural first market extension. Schema designed to accommodate.

**Far-adjacent (not pursued in v2 or near future):**
- **AV integration** (corporate, installation) — separate product, separate sales motion, D-Tools is the incumbent. Design schema for extension only. Revisit no earlier than 18 months post-launch.

**Positioning principle:** design for extension, build for theatrical. Do not pursue any market extension until theatrical SaaS is stable and profitable. Touring before AV.

---

## Operating Costs & Stop Conditions

**Estimated production-state monthly burn:** ~$500/month
- Supabase scaling tier (estimated for 285 active users)
- Vercel (likely still free tier at this scale)
- Domain renewals (annual, minor)
- Claude.ai subscription
- Eventual support tooling

**One-time costs:**
- Attorney engagement: $2–5K (before first paid commercial user)

**Stop conditions:**
1. **Budget floor:** total v2 development spend in 2026 must not exceed Minotaur v1's 2026 revenue (currently ~$20K/year trajectory).
2. **Schedule floor:** if v2 is not in paid beta within nine months of June 2026 (i.e., by ~March 2027), re-evaluate scope, partnership options, or whether to stabilize v1 and pause v2 development.
3. **Mid-July BVSC go/no-go decision** *(see Roadmap)* — independent of these stop conditions.

---

## History of Attempts

For context — this is the third attempt at Minotaur v2. Each prior attempt left artifacts that inform the current build.

**v1 (2015–present):** FileMaker desktop app. Working product, degrading with OS releases. Used by majority of Broadway productions since 2022. Source of all UX and functional specifications for v2.

**Attempt 1 — Zite prototype (2026, abandoned mid-development):** First v2 effort. Built using Zite (web app builder competing with Lovable). Equipment list section was fast and well-designed — became the UX benchmark for v2's Equipment List. Other sections unfinished. Exported as `zite.json` (4.7MB).

**Attempt 2 — Lovable build (2026, abandoned):** Second v2 effort. Built in TanStack Start. Substantial business logic completed: equipment CRUD, library, admin (categories/methods/groups), full print configuration with filter logic, cable bundles, cover letter, bulk import. Used `zite.json` as canonical reference. Was buggy in practice. Now serves as code reference for current build.

**Attempt 3 — Current Claude Code v2 (June 2026, active):** Next.js 16 / App Router / Supabase. Started fresh with better architectural patterns. Behind Lovable on features; ahead on architecture rigor.

---

*End of Product Brief v1.0*
