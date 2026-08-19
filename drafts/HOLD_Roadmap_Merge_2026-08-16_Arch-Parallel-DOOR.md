# HOLD — Roadmap merge sheet, parallel Arch DOOR+LANDING design session, August 16, 2026

**Per Arch Prompt v30 §Parallel sessions, this seat wrote no Roadmap, Ledger or Session Log. Merge these deltas at the next main-line close (v3.13 or whichever Arch close lands next).**

**Still pending alongside this one:** `drafts/HOLD_Roadmap_Merge_2026-08-15_Comms.md`, unmerged since Aug 15. Fold both in the same package or the Comms deltas go two closes stale.

---

## Docket deltas

- **DOOR** — the **Arch design leg is DONE**. Design of record: `handoffs/parallel/260816-1210_door-landing-design-block.md`. Build opener: `handoffs/260816-1210_arch_opener_door-landing-build.md`. Remaining on the row: Daniel's toggle confirmation (still unverified — no Chrome bridge from either the Strat or the parallel Arch seat), four rulings **R-O/R-P/R-Q/R-R**, one migration (ledger 49 → 50), and the CC build. **Priority unchanged: ASAP, not waiting for Sprint 4's close.**
- **DOOR** — **measured of record: the unit moves ZERO visual-gate frames.** The gate captures 28 frames across 14 routes; `/`, `/auth/signup` and `/auth/login` are none of them (login is driven to authenticate the harness, never captured). No declared baseline event, no contact with H4's registry or thresholds. The unit is orthogonal to legs 5–6 and to the harness line — sequencing is free.
- **DOOR-SEO** — **NEW, register.** The landing copy's SEO block misidentifies the title tag: it specifies Google's SERP line (title + em dash + description) as the tag verbatim, where the live and indexed tag is `Minotaur Sound System Database` alone (`src/app/layout.tsx:5-8`, confirmed live). Built literally it changes the indexed title — the one thing the opener said to preserve. **Propagation list:** the Arch opener's CONTEXT paragraph · the copy file's §SEO and §BUILD NOTES bullet 1 · the Comms addendum item 2 · `HOLD_Roadmap_Merge_2026-08-15_Comms.md` · Session Log entry 4 (immutable — correction lands in the next entry). Roadmap v3.12's DOOR row makes no title-tag claim and is correctly not on the list. **A Comms-tier error, not an Arch standing-correction instance.** Resolution routes to Daniel via **R-O**.
- **DOOR-MW** — **NEW, register (closes inside the build).** `src/lib/supabase/middleware.ts:31-40` allowlists exactly `/` and `/auth/*` for anonymous visitors, and the matcher excludes only static assets, so an unlisted `/api/waitlist` 307s a signed-out POST to `/auth/login` and the waitlist form fails silently. Caught at design time by reading the surface; would otherwise have cost a build round.
- **DOOR-DBLAUTH** — **NEW, register (closes inside the build).** `getUser()` runs twice per anonymous hit on `/` — once in middleware, once at `src/app/page.tsx:7`. Design of record moves the signed-in redirect into the middleware so the landing page becomes a pure server component with no auth call, which is also the strongest form of the copy's "load-bearing crawlable text near the top."
- **SHARE** — build-prep input **confirmed received** from the Strat Trigger-A route and carried into the DOOR design block §6.3: with public signup closed, phase-1 in-app auto-accept invites need an account-creation path off the public form (admin-issued / invite-created; `admin.createUser` works with signups disabled). Intent ruled at Strat; mechanism is Arch's at build-prep. **Not designed in this unit.** Sits alongside the owed RLS-delta / ADM-1 REV-B.
- **HARNESS** — **H4 CLOSED and pushed at `13a8233`** (`23a34d6..13a8233`), verified from the repo's own ref files. Suite 1594/105 → **1611/105**; frozen 3/3; visual 28/28 at the new zero-tolerance default across four runs; zero baselines written; `declared-event.json` untouched. The `GATE_DIFF_THRESHOLD_PCT=0` emit/write workaround is retired. Rule 9 is per-dimension at FACTOR 1.75 / ADD 8, area constants retired in the same step. Diff-exception registry checked in with four sites, two provisional, each carrying a `refineBy`. **Leg 5 is next on the main line.**
- **DIFF-EXC-BOUND** — **NEW from H4**, registered with a concrete trigger rather than a someday. Carried here only so it is not lost between the H4 close and the next Roadmap; the main line owns its wording.
- **Frame 11's provisional 1×1 site** — n=1. Carry-forward for whoever opens leg 5: if a rule-3 refusal hits frame 11, check whether that registration was adequate.

## Open-questions delta

- **Seat consolidation** gains two datapoints. First, a **third scoped Supabase-MCP exception** is in play if **R-R** lands on (a) — a cloud Cowork seat applying a migration, against the migrations-from-claude.ai clause. Second, the honest one: this seat held read/write on both mounts by folder grant and confined itself to reads on `Minotaur` **by discipline, not by mechanism** — the same asymmetry already logged on Aug 14, now observed a second time. The git prohibition, by contrast, held as a mechanism: every git fact this session came from `.git/HEAD` and the ref files, and `git` was never invoked.
- **"Comms Prompt structure"** gains its sharpest datapoint yet. v30 §Document Hygiene states that the propagation check binds the Arch tier and that a correction originating in another tier "should be closed there rather than assumed away here." DOOR-SEO is the first live instance: a Comms-tier factual error propagated into four other documents with no tier-level check to catch it. This strengthens the already-queued **Comms Prompt v10** proposal (point at Writing Prompt v1 §Daniel's Voice rather than duplicating it) with a second, independent amendment: **the Comms tier needs its own propagation check.**
- **The question widget** failed again as a design-block vehicle on Aug 15 (two of four answers lost). This session pre-empted it and put a four-fork block in plain text at the outset. If that holds a second time, it is worth a one-line convention in the Arch Prompt rather than a per-session judgement call.

## Not this seat's writes

No project document installed. No CC handoff issued. No migration applied. No Roadmap, Ledger or Session Log touched. Deliverables landed as files in the Minotaur-Cowork mount:

- `handoffs/parallel/260816-1210_door-landing-design-block.md`
- `handoffs/260816-1210_arch_opener_door-landing-build.md`
- `drafts/HOLD_Roadmap_Merge_2026-08-16_Arch-Parallel-DOOR.md` *(this file)*
