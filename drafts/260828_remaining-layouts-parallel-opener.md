# PARALLEL SESSION OPENER — Cowork-Arch, DESIGN ONLY

**Written 2026-08-28 10:45 EDT by the MAIN LINE.**
**Scope: design the seven remaining disabled outputs, and define the evidence each needs. No build, no CC.**

---

## 0 · SEAT CHECK

Cowork, three mounts reachable: `Minotaur` · `Minotaur-Cowork` · `Minotaur_v1_exports`. **If not, STOP and say so.** Mounts do not persist between sessions — expect to grant all three at open.

## 1 · YOUR BOUNDARIES — these are what make a parallel session safe

You are a **PARALLEL** session. The main line is live and owns the repo, the close, and CC.

- **Issue NO CC handoffs.** Not staged, not drafted "ready to go." The main line issues.
- **Touch NO migrations and NO schema.** Read the live schema freely; change nothing.
- **Edit NO Roadmap, NO Ledger, NO Session Log, NO `CLAUDE.md`, NO Arch prompt.** Two sessions editing the Roadmap is the one way this pattern fails.
- **Write NOTHING to the `Minotaur` repo.** Read it freely.
- **Write only** into `~/Developer/Minotaur-Cowork/handoffs/parallel/`, under the filenames in §7.
- **Never run git in either repo folder** — even `git status` leaves a lock this seat cannot delete, and that lock blocks CC's next commit. Read git state from the plain files inside `.git/` (`refs/heads/main`, `refs/remotes/origin/main`).

## 2 · READ ORDER

`Architecture_Prompt_v33.md` → `Minotaur_v2_Roadmap_v4_11.md` **(the installed one — v4.12 is drafted but NOT installed and is the main line's)** → `Minotaur_v2_Session_Log.md` (STATE OF PLAY + the two live entries) → this opener → then, on citation only, the cable-parity evidence trio in `handoffs/parallel/`: `260826-1545_cable-parity-evidence.md`, `260826-1754_..._ADDENDUM.md`, `260827-0020_cable-parity-v2-pairs-MEASURED.md`.

**Verify state from files, never by running git.** HEAD should read **`ff82281`** in `.git/refs/heads/main` — NOT `.git/packed-refs`, which carries `be0769de`, six commits stale, and is also the frozen-gate baseline so a wrong read looks plausible. Migration ledger **55**.

## 3 · THE SCOPE — seven outputs that exist only as disabled buttons

Daniel ruled 2026-08-28: **all seven get built, each with a meticulous v1 print-parity comparison of the kind the box label family got.** They are queued; this session designs them, it does not build them.

Verified at source in `src/components/.../MenuPageLoader.tsx`, all `disabled: true`:

| # | Output | Menu line | v1 arbiter in the corpus |
|---|---|---|---|
| 1 | **Group Parts** | 167 | **NONE — equipment side has no v1 PDFs at all** |
| 2 | **Device Patch** | 168 | **NONE** |
| 3 | **Equipment Labels** | 172 | **NONE** |
| 4 | **Bundle Summary** | 193 | `cable-box/Cable PDFs/bundle summary.pdf` |
| 5 | **Line List** | 198 | **UNCONFIRMED** — `Mult Detail.pdf` is the candidate; **confirm or refute it, do not assume it** |
| 6 | **Steck Labels** | 211 | `Steck Labels.pdf` — but see §5, the data is not there |
| 7 | **Tail Folder Labels** | 216 | `Tail Folder Labels.pdf` |

**Bundle Labels** (line 208) is also disabled and has `Bundle Labels.pdf`. It is not on Daniel's list. **Raise it; do not silently add it or silently drop it.**

## 4 · WHAT THIS SESSION PRODUCES

For each of the seven, in one design document:

1. **What the output IS**, in plain language, from the v1 artifact and v1's own scripts and DDR — not from its name. Every claim cited to a file and a line or page.
2. **Its found set — what records print** — traced to source. The cable family's hardest defects were all found-set defects, and one output was reading the wrong table entirely. **Establish the selector before anything else.**
3. **Its data dependencies in v2** — which columns exist, which are populated, which are missing. Live introspection, not the generated types alone.
4. **The evidence it needs for a parity round**, stated as a list Daniel can act on: which v1 print, from which show, with what found set, in what orientation.
5. **A build-size estimate in units**, and whether it is a Trigger A (a fundamentally new user flow) — several of these are.

**Do NOT design the pixels.** Geometry follows the evidence; the box family proved that deriving a cell instead of measuring it produces a fix that has to be redone.

## 5 · DO NOT RE-DERIVE, AND DO NOT REPEAT

- **PDF-CHROME-PATH (2026-08-28).** A parity print is valid evidence **only** from Chrome's own Save-as-PDF destination. *"Open PDF in Preview"* and *"Print using system dialog…"* route through **Quartz**, which discards the CSS `@page size` rule and rotates landscape content onto portrait paper. **Every landscape v2 artifact in the corpus taken before 2026-08-27 is invalid.** Portrait artifacts are unaffected — which is why the box label geometry stands and the four portrait cable label grids in `260827-0020_...MEASURED.md` §16 stand, while its §15 orientation tier is **RETIRED** and its provenance line claiming "interactive Chrome Save-as-PDF" is **contradicted by the files' own metadata** (`/Producer: macOS Version 15.7.3`). Any geometry that document measured on a landscape output must be re-measured.
- **STECK-ZERO / Q-7.** `source_steck_count` and `destination_steck_count` are **0 on all 1,119 BVSC NY cables**, where v1 carries **342**. **BVSC NY was seeded by script, not run through the import engine**, so it cannot be the arbiter for Steck Labels. Never re-import into BVSC NY — it plans 1119 INSERTS and would double the show.
- **BVSCNY-SEED-JUNK (2026-08-28).** The same seed put **two junk boxes** into BVSC NY named `In Box` and `Box Name` — 136 boxes live against 134 in the v1 export — and dropped box types and weights (boxes 607/608/609 have no type; 603 has no weight where v1 prints 301 lbs). **BVSC NY is not a valid arbiter for anything box-shaped**, and treat its completeness as suspect generally.
- **All seventeen v1 cable outputs are DATA-DERIVED, none Find-driven.** No fresh v1 *cable* print is owed for pairing purposes. That is measured and closed; do not reopen it.
- **v1's Quartz prints are FINE.** FileMaker declares its page setup natively, so the system print path honours it — v1's Tail Checklist measures 792×612 landscape with zero non-upright characters. Only the v2 side was ever damaged.
- **Do not re-litigate:** the palette (closed, fourteen values, the product palette is the parity target, not v1's render) · `PANEL_GREY` is not Minotaur Grey · FOLDER-NABOX's count of 24 · R-7 label sets collapsing to a boolean · that Wire Types and Wiring Schedule are deprecated and their menu entries come out.

## 6 · WHAT IS THE MAIN LINE'S, NOT YOURS

The cable geometry pass (pass 3) and its evidence request · GATE-METHODRACE · the `CLAUDE.md` run fence · the cable split feature, which fired a **Trigger A halt** and is waiting on a fourth v1 corpus · 2-MIG-c · the close package. **If you find something that changes any of them, write it in your return and say so plainly. Do not act on it.**

## 7 · RETURN FILENAMES

Write only these, in `handoffs/parallel/`:

- `260828-XXXX_remaining-layouts-design.md` — the seven, per §4.
- `260828-XXXX_remaining-layouts-evidence-request.md` — **one consolidated list Daniel can work from**, ordered by what unblocks the most, marking for each item whether it is a v1 print, a v2 print, a ruling, or a data fix. This is the deliverable he will actually use.
- `260828-XXXX_remaining-layouts-questions.md` — anything needing a ruling. **Raise, do not resolve.**

Timestamps follow the `YYMMDD-hhmm` convention and must reflect **when you actually write them** — a return that sorts ahead of the opener that spawned it has happened here before (PARALLEL-CLOCK).

## 8 · CONDUCT

- **Plain language first.** Daniel is a sharp professional and a non-technical founder. Every identifier gets a gloss on first use or it does not appear. Lead with what a thing IS and what it costs.
- **Read the artifact, not the document** — and not this opener either. Every anchor is checked at source in the session that writes the instruction.
- **A number is a measurement or it is not written.** An expectation in the past tense is indistinguishable from a measurement to whoever reads it next.
- **A search run with the wrong instrument returns absence, not evidence of absence** — `docs/reference/v1_ddr.xml` is **UTF-16**, and a byte-oriented grep on it silently finds nothing.
- **Batch rulings, never batch experiments.** Settle what Daniel can settle in one pass; hand back one thing at a time where an outcome decides the next step.
- **Never hand Daniel a first draft.** Critique and refine internally before it goes out.
- **End every message with a single plain-language next step.**
