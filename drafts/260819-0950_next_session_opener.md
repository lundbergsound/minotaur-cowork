# NEXT SESSION OPENER — Minotaur v2 main line — S4-3 LEG 6 (the three box print chains + P5)

Open as Cowork-Arch on Minotaur v2 — the MAIN LINE. The pen is here; no parallel seat is open. READ FIRST, in order:
**Architecture Prompt v30** — installed, governing; Minotaur-Cowork root. **Roadmap v4.0, WHOLE** — the restructured file (RM-7 trigger classes, RM-8 one-line rows); do not read v3.14, it is retired — its row histories live in Minotaur-Cowork git history and the Ledger's Aug-19 append. **Minotaur_v2_Session_Log.md** — 7 entries; entry 7 is the leg-5 close. On citation only: the Ledger's Aug-19 block (rulings R-X through R-AF, correction nineteen); the three leg-5 returns in `from-cc/` (`260818-1555_*`, `260818-2027_*-amend1`, `260819-0740_*-amend2`).

STATE: HEAD = origin = **`07150e6`** (`e92f2c9..07150e6`), pushed, Daniel's paste, refs-verified at close. Suite **1677/111** · frozen **3/3 vs `be0769de`** · visual **28/28 at zero tolerance** · **six baselines re-adopted under the LEG-5 declared event** (02/03/08 pairs, the R-7 yellow) — `screenshots/declared-event.json` now describes **leg 5's** event, not leg 4's · **migration ledger 51** (`s4_3_leg5_list_sort_mode_persistence`, applied by the main line 2026-08-19). Tree clean apart from the GIT-CFG strays (`next-env.d.ts` flip-flop, never committed; the four untracked evidence PNGs in `docs/reference/evidence/equipment/`). Minotaur-Cowork at the Aug-19 close commit; Roadmap v4.0 installed to project knowledge, v3.14 deleted in the same step.

STANDING CORRECTIONS STAND AT **NINETEEN**. Nineteen's shape, carried forward: **a precedent is a surface too** — the leg-5 handoff specified the R-7 arm per-class from a shipped precedent that had itself never been checked against v1's formula (whose own comment stated the opposite intent). Two practical residues: `v1_ddr.xml` is **UTF-16** — a naive grep returns 0 hits on text that is there; the extracted tables in `docs/reference/v1-cable-box-catalog/extracted/` are the greppable source of record for v1 field calcs.

## FIRST ACTIONS

1. **Verify state before anything.** HEAD/origin from the repos' own ref files — **never by running git** (the mount denies `unlink`; `git status` orphans `.git/index.lock` and halts any live CC session — the mechanism, not manners). Check for an orphaned `index.lock`. Live-read the migration ledger — expect **51**. Production READY at `07150e6` is NOT seat-verifiable (the Vercel token sits outside the mounts; the device shell has no network): Daniel runs `node scripts/vercel-preopen.mjs`, or CC's §0 probe covers it.

2. **Model & Effort Check** per v30, then scope **LEG 6 — the three box print chains + P5 (R-F).** This is a PORT with full v1 pedigree — no Trigger A. Read at source before writing the handoff, per the Surface Rule:
   - **The catalog of record:** `docs/reference/Minotaur_v1_Box_Behavioral_Catalog.md` **§4 (the three chains) and §5 (output content rules — the D-10 pattern: the layouts die, these rules survive)**. R-51 truck/nesting annotations · R-52 Location tinted with Box Color · R-53 statuses as checkboxes · R-54 numeric per-record label counts · R-55 Replacement Numbers kept · R-56 ONE normalized find shape replacing the three v1 variants, riding R-22's combined options+find page · R-24 skip-labels offset where grid-sheeted · R-50 resolve-up trucks.
   - **v1 mechanics:** scripts **280/714** (the print chain drivers), print layout **212**, find layout **316** — read in the DDR/extracted tables, minding the UTF-16 note. **Script 804 is already read in full** (catalog §2.4 item 3, corrected 2026-08-14): P5 is a PRE-PRINT sweep of five classes — equipment · bundles · cable · tails · RF — "Show Me" sorts and HALTS the print into the offender list, "Ignore" continues; clearing all five lets the print proceed. RF does not exist in v2; build four.
   - **Banked leg-6 inputs (Roadmap v4.0 🧭, verified at leg 5):** the print chain **hard-codes `boxLabel: null`** — `src/components/print-cable/docData.ts:23,:54` and `CableLabelsPrintClient.tsx:94`, plus two stale "until Sprint 4" comments (`CableChecklistPrintClient.tsx:41`, `docData.ts:23`) — leg 6 owns this fix. **CLAUDE.md's fence still reads "the next unit is S4-3 leg 5"** — leg 6's handoff §0 advances it (and measures the counts line, per the fence's standing lesson). The **categorized-box print case is unexercised** — the fixture's boxes carry no category; if leg 6 stages one, that is a cheap declared event under H2, measured not predicted.
   - **Open flags that may bite at scoping:** Box Logo (R-49) is a project-level asset printing top-left of every label — catalog open flag 5 says its v2 storage is unconfirmed; the `storage_project_images` bucket exists (migration 23). If a schema decision surfaces, it is Arch's (Trigger B), never CC's. Replacement-numbers sheet geometry (open flag 7) and Contents pagination header-repeat (flag 6) are verify-at-build.

3. **Take Daniel's confirm on the AC pass placement** — Roadmap v4.0 proposes BATCH-AC (R-AC: typed text wins app-wide; suggestion only on arrow/click; plus AC-HANDLED and the BoxDetailPanel lying-screens) runs **after leg 6**. One plain-text question, at open or at leg-6 close.

## GATE AND DECLARATION STANDING NOTES (carry into the handoff)

- `npm run test:visual` DOES NOT RUN — use `node --env-file=.env.local scripts/visual-capture.mjs --gate` (VIS-ENVFILE).
- **GATE-THEMERACE**: intermittent Δ42 over the topbar theme-toggle, 01/02-light. Re-run once; if it clears, proceed; **never register it** (DIFF-EXC-BOUND's trigger).
- **GATE-DLGRACE**: frame 07-dark can fail-hard on the NoMethodDialog staging race (`visual-capture.mjs:459-461`, count()-once family). Re-run; do not fix the harness in-leg (R-V).
- Declarations under H4: plain flags · every `reason` filled by hand · write with `--declare` · rule 9 per-dimension **1.75/8** · `CHANNEL_THRESHOLD` 24 untouched · amend-round re-baselining per the banked CLAUDE.md procedure. If leg 6 ADDS print frames, that is the `added` set — H2 supports it; declare what is measured.
- On any rule-3 refusal, check the n=1 sites FIRST: frame 11's `184,358` (registered, 1×1) · frames 02/03-light `1127,18–1128,27` (unregistered, seen once Aug 18) · frame 12-light `149,108–188,109` (unregistered, seen once Aug 19). A second observation upgrades a registered site per its `refineBy`; unregistered sites get reported, not registered, absent a ruling.
- Honor the load gate; never `--force-load`.

## NOT THIS SESSION

BATCH-AC (unless Daniel confirms placement AND leg 6 has closed) · harness fixes (R-V — behind the box unit, import/export, SHARE) · PRINT-REDO (Daniel's word only; PARITY-PAIR first) · R7-ARM-2 and BOXTYPE-DIALOG-2 (post-private-beta, R-AE/R-AF) · BAND-EDITOR build (its sequencing ruling first — RULINGS-WANTED) · schema inside CC (halt to Arch, always) · account/project cleanup (sequenced after R8-DRILL, deliberately).

## OWED BY DANIEL

**R8-DRILL — OVERDUE.** The one hard date; it gates the account/project cleanup, feeds the attorney addendum's retention number, and September is coming. · The four CAND-4 texts, this week. · `HERO_BID_TO_OPENING` goes plural when Vape! Chicago opens (`src/app/page.tsx`, one line). · Sync-now at open if this session will read repo `.md` files from project knowledge. · The GIT-CFG strays, at leisure.

ROLLOVER: clear — the log is at 7 and fires at 10.
