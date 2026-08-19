Open as Cowork-Arch on Minotaur v2. READ FIRST, in order:

Architecture Prompt v30 — INSTALLED, governing; Minotaur-Cowork root.
Roadmap v3.12 (WHOLE)
Minotaur_v2_Session_Log.md — **3 entries after the Aug-15 rollover**; entry 3 (Strat, ACCOUNTS) is the last one written, entry 2 is the last Arch session.
On citation only: the Ledger's Aug-15 block + its same-day addendum; the leg-4 returns `from-cc/260815-1120_s4-3-leg4.md` and `260815-1307_s4-3-leg4-amend1.md`; the handoffs `to-cc/260815-1037_s4-3-leg4-box-types-admin.md` and `260815-1612_s4-3-leg4-amend1.md`.

STATE: HEAD/origin/production **`23a34d6`**, refs-verified, READY. Minotaur-Cowork at **`62ba604`**, pushed, Sync-now clicked. **S4-3 leg 4 CLOSED ENTIRE**, AMEND-1 folded in. Suite **1594/105** · frozen **3/3 vs `be0769de`** · visual **28/28 @ 0.0000%** · migration ledger **49, no schema in that unit** · `screenshots/declared-event.json` is checked in and describes leg 4's event (10 moved + 2 added). **ROLLOVER IS CLEAR** — run Aug 15; archive at `session-log-archives/Session_Log_Archive_2026-08-15.md`. Tree clean apart from the generated `next-env.d.ts` (GIT-CFG, never committed) and the four untracked evidence PNGs in `docs/reference/evidence/equipment/`. **Public signup is CLOSED** and the four uninvited accounts stay live as named beta candidates. No CC session open. No parallel session open.

FIRST ACTIONS:

1. **Verify HEAD/origin at `23a34d6` from the repo's own ref files — never by running git.** The mount denies `unlink`, so `git status` takes `.git/index.lock` and cannot release it, orphaning a lock that halts any live CC session. Live-read the migration ledger (expect **49**).

2. **THE SEQUENCING CALL — make it first, put it to Daniel, and do not just start building.** Three things are queued and the ordering is genuinely open:
   - **HARNESS-H4** — ruled by Daniel to run as its own unit **before leg 5**.
   - **DOOR + LANDING** — ruled ASAP by Daniel via Strat, explicitly not waiting for Sprint 4's close. An Arch opener exists at `handoffs/260815_arch_opener_door-landing.md` — **but Daniel has since taken the login/landing page to the Strat chat separately, so that opener may be superseded. Check for a newer Strat ruling before acting on it, and do not design the landing page's policy or copy here.**
   - **S4-3 leg 5** — gated behind H4 by ruling, and see §4 below, because it is not the unit the Roadmap's one-line name implies.

   Recommend an order with reasons and let Daniel rule. Nothing below authorises starting a build before that.

3. **HARNESS-H4 — what it carries.**
   - **The hole is measured, not hypothetical.** At leg 4, nine of ten moved frames measured **0.0389–0.0504% and printed PASSED**; the first emit therefore classified one frame as moved instead of ten, and a declaration written at the default would have left nine baselines silently stale behind a green gate. CC worked around it with `GATE_DIFF_THRESHOLD_PCT=0` for the emit and write, confirming at the default. **H4 is what retires that workaround.**
   - **Nothing earlier is in doubt** — prior legs measured 0.0000%, which is byte-clean and strictly stronger than "under threshold." Do not re-open closed baselines.
   - **H2 left a clean seam on purpose:** one constant plus a checked-in exception registry. Use it; do not redesign the comparator.
   - **Rule 9's metric folds in here.** The area-ratio shipped and is correct, but per-dimension bounds are the cleaner metric (dimensionally correct, immune to the thin-shape problem that forced ADD from 400 to 4000). It was an Open Question and the leg-4 close moved it into H4's scope.
   - **SUBPIXEL-WANDER is the registry's first candidate AND its hard case.** A declaration widened to the union of a wandering site's observed positions is legal only while that site is present; a run where it vanishes trips rule 9 on the same declaration. H4 must **tolerate** the wander, not explain it — **H3 stays unscheduled and diagnosis is not in H4's scope.**
   - **Do not break the banked amend-round re-declaration procedure** (restore `screenshots/baseline/` to HEAD, then one emit → fill every reason → write → confirming gate, guarded by checking that every baseline change in the tree is that leg's own). It is in CLAUDE.md.

4. **LEG 5 — READ THIS BEFORE SCOPING IT. IT IS NOT A PORT, AND THE ROADMAP'S ONE-LINE NAME IS MISLEADING.**

   Measured from `docs/reference/v1_ddr.xml` at this close, so it does not have to be rediscovered:

   - **v1 has NO on-screen box-contents surface.** Layout **179 `Box List`** is the sole box browse surface (Box Catalog §2, and the census agrees). Every other box-named layout in the catalog is print, label or find: 185 · 186 · 189 · 194 · 209 · 210 · 212 · 216 · 310 · 316 · 324 · 325 · 326 · 357.
   - **Layout 180 `Boxes` is an EMPTY layout — 120 characters, zero `<Object>` elements.** A table stub, not a surface. Do not read it as the missing contents screen.
   - Therefore **"Contents" has no v1 pedigree to port.** Designing an on-screen contents view is a fundamentally new user flow, which is **Trigger A** — halt and take Daniel's scoping ruling before any design, rather than inventing a surface and calling it parity.
   - **"Assignments" is largely already built.** The box autocomplete and the New Box ⊕ landed at S4-AUTO; the row grammar at legs 2–4; `effective_box_id` is live; the In Box nesting gesture is ruled (R-42) and built. **Establish what actually remains** before assuming a unit's worth of work exists.
   - **The contents PRINT chain is leg 6's, not leg 5's:** scripts **280 `Print Box Contents List`** and **714 `Make Box Contents List`**, layout **212 `Box Contents Lists`**, find layout **316 `Search-Box Contents`**; and **P5 (script 804) rides leg 6 by ruling R-F**.
   - **`ADMIN-NAV` wants a ruling before leg 5**, because leg 5 will build another list surface and will otherwise inherit the divergence silently. Measured: ⌥⇧↑↓ moves selection *and* focus on the Box List, but only the selection on the Box Types admin **and** on the Methods admin it was built from — three surfaces, one divergence, none of it leg 4's doing.

ALSO CARRY:

**Standing corrections are now TWELVE instances, and the newest three are three different shapes.** (a) The original shape, still the commonest: **asserted a fact about the surface without reading it** — this session's was "DDR layout 239", which is a script; the Box Types layout is 194. (b) **Read the surface, then read its CONSUMERS** — Arch read `fetchCurrentState` correctly and never asked who else used its output, and the IMP-SPINE fix as written would have aborted every mirror apply via the plan fingerprint. A fix to a shared read is a change to every reader of it, and the reader that bites may be in the database. (c) **State the MECHANISM whenever you restate a rule** — "`git checkout --` has left this workflow" was written as a flat prohibition, read as etiquette, and correctly rationalised past by CC, which disclosed the tension instead of proceeding silently. **v31 candidate banked: v30's "state the mechanism" clause was written for the Cowork git prohibition and generalises to every rule this tier restates.**

**The evidence corpus lives in TWO places** — the repo, and `~/Minotaur_v1_exports` (grant it if v1 exports are needed). Four sessions in a row have now reasoned from the repo as though it were the whole of it.

**CC's leg-4 record, so its judgement is weighted correctly:** it refuted Arch's stated root cause by probe rather than building on it, caught the fingerprint coupling, disclosed the rule conflict and asked for a ruling, and inverted its own conclusion after spotting a confound for the second time in two days.

NOT THIS SESSION: **AC-HANDLED** (open, app-wide, gets its own pass — do not fix it inside another unit) · **Print** (closed; PRINT-REDO on Daniel's word only) · **the login/landing page's copy and policy** (at Strat) · **project and account cleanup** (sequenced after R8-DRILL, deliberately) · units/metric (R-M) · BOXTYPE-CA · BOXTYPE-BTN · IMP-SPINE-2 · R-H's header sorts.

OWED BY DANIEL: **the R8 drill, early week of Aug 17** — the one hard date, and it now also gates the account/project cleanup and feeds the attorney addendum's retention number · **the four CAND-4 texts this week** · the Supabase signup toggle if it is not yet flipped · TOK-VC at private-beta start, rotating by ~Nov 8 regardless · PARITY-PAIR whenever PRINT-REDO opens · COWORK-PORT + WF1A-SUNSET at Sprint 4 close · the three housekeeping strays under GIT-CFG.

ROLLOVER: clear. The log is at 3 entries and fires again at 10.
