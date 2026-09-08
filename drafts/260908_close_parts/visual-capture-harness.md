# Visual-Capture Harness — full text

*(Relocated out of `CLAUDE.md` on 2026-09-08 under CLAUDEMD-ATLIMIT, VERBATIM and
unedited below the original heading. `CLAUDE.md` had reached THREE characters of its
150,000-character limit, and a file over the limit loses its TAIL. Same move and same
reason as the Guarded Architectures Index on 2026-08-09. `CLAUDE.md` carries the
pointer; THIS file is the payload and the surface — open it before any gate run, any
baseline declaration, and any edit to `scripts/visual-capture.mjs`.)*

## Visual-Capture Harness (standing infrastructure — July 6, 2026; renamed from visual-gate July 12; expanded to 16 frames July 19; 18 Aug 11 (S4-3 leg 1); 24 Aug 12 (S4-3 leg 2); 26 Aug 12 (leg 2 AMEND-1); 28 Aug 15 (S4-3 leg 4))

The repo carries a Playwright visual-verification harness. **Any session doing
visual/UI work MUST self-verify with it before writing a handoff file.**

- **Run:** `node --env-file=.env.local scripts/visual-capture.mjs` (reuses a running
  dev server or spawns one; approval-gated under the harness `node` ask-rule).
- **Capability (current, post sort-unit July 19):** CC self-captures via
  `scripts/visual-capture.mjs` against the fixture project (resolved by name
  at runtime). Comparison is a pure-Node PNG diff (`scripts/lib/pngDiff.mjs`,
  node:zlib only; channelThreshold 24 = the diff definition of record).
  **Fourteen surfaces × light/dark = 28 frames** (EXPECTED_CAPTURE_COUNT 28):
    01-project-menu · 02-equipment-list-category · 03-equipment-list-method
    · 04-library · 05-gcm · 06-settings · 07-print-revision-stamp ·
    08-find-active · 09-box-list · 10-box-detail-panel ·
    11-box-nesting-error · 12-box-type-plus · 13-boxes-menu-tab ·
    14-box-types-admin.
  **Frame 13 keeps its staging neighbourhood, deliberately** (AMEND-1 A1):
  its staging clicks the Boxes tab, and inserting those clicks anywhere earlier
  deterministically moved 16-19 antialiased pixels on the topbar's theme-toggle
  glyph in whichever frame followed. It also restores the Equipment tab
  afterwards — the session tab memory is shared by both theme passes.
  **Frame 14 (leg 4) is captured after that restore, and is now the LAST frame
  in each pass.** The property that protects 13 is about what immediately
  follows 13, so 14 was placed after the Equipment restore rather than between
  13 and it, leaving the 13 → restore sequence byte-for-byte unchanged; and
  nothing follows 14, so 14 cannot shift anything either. Measured: 13 stayed
  byte-clean through the leg-4 event except for its own declared change.
  Three-mode CLI: bare invocation = capture-only; `--gate` = capture then
  diff every PNG against `screenshots/baseline/`, nonzero exit on any
  dimension mismatch or over-threshold pixel diff (a MISSING baseline
  reports PENDING per frame and does not fail the run); `--update-baselines`
  = capture then overwrite `screenshots/baseline/`. A green `--gate` run
  proves parity, not just rendering. **28/28 is the gate pass count.**
  **Every gate line prints what it MEASURED (HARNESS-H1 §1, Aug 14):** under
  each PASS/FAIL line the report prints a second, indented `measured @ch0:`
  line — pixel count, max channel delta and bounding box computed at ZERO
  tolerance, or `byte-clean (0 px)` when there is nothing to report — plus the
  run's load average and both thresholds in the header. **Judged verdicts did
  not move:** `diffPixels`/`diffPercent`/the red diff PNG still measure at
  channelThreshold 24. The point is that "0.0000%" alone means "no pixel over
  channel-24", NOT byte-identical — eight frames once printed PASSED at up to
  0.0906%, and both recent misses were caught by a human hand-computing
  exactly these three numbers. Read the measured line, not just the verdict;
  the standing any-nonzero-is-stop-and-report rule now has a printed number
  behind it.
  **Modes are mutually exclusive — the tool HARD-ERRORS on combined flags
  (Aug 14, HARNESS-H1 §2; origin July 20):** passing more than one of `--gate`
  / `--update-baselines` exits non-zero at startup, before any capture and
  before the server spawn, naming both flags. Originally (July 20) this was a
  silent precedence — the MODE ternary checked `--gate` first, so
  `--gate --update-baselines` ran gate-only and NEVER wrote baselines, with no
  error and nothing to read but "looks like a failed gate". The human-memory
  rule that replaced it is retired; the tool enforces it. To refresh, run
  `--update-baselines` ALONE.
- **Declared events and scoped baseline writes (HARNESS-H2, Aug 14 —
  SUPERSEDES the Aug-4 scoped-event restore and its Aug-12 same-run rider,
  both retired below):** `--update-baselines` **REFUSES to run without
  `--declare <path>`** — the refusal fires at preflight, before the server
  spawn and before any PNG. The declaration is `screenshots/declared-event.json`,
  checked in with the event's own commit, so its git history is the register of
  every declared event this project has ever run. It names, per frame, a
  `reason` in prose, the `bbox` the movement must sit inside, and ceilings for
  `maxPixels` and `maxChannelDelta`; plus an `added` list for brand-new frames
  and an `expectedCaptureCount`. **The harness computes the moved set itself
  and hard-fails on any disagreement, writing NOTHING at all** — moved but not
  declared · declared but not moved (the stale-declaration case) · moved
  outside the declared region (containment, not equality) · moved more than
  declared · **a declared region far larger than what was measured** · an
  addition that already has a baseline or a PENDING frame absent
  from `added` · count drift against `EXPECTED_CAPTURE_COUNT` · an empty
  `reason` · a dimension mismatch. **Rule 9 (AMEND-1) is what keeps rule 3 from
  being switchable-off:** containment alone is satisfied by a whole-frame bbox,
  so a declared bbox must also be bounded relative to what was measured — a
  ratio, not an absolute cap, because a legitimately whole-frame change has a
  whole-frame measurement and must still pass.
  **Rule 9's metric is PER-DIMENSION as of HARNESS-H4 (Aug 15), replacing the
  area form.** The declared bbox's WIDTH must sit within
  `DECLARE_BBOX_MAX_DIM_FACTOR` (**1.75**) × the measured width +
  `DECLARE_BBOX_MAX_DIM_ADD` (**8**), and its HEIGHT within the same bound on
  the measured height; BOTH must hold, and the violation message names the
  failing dimension and its ceiling rather than an area.
  `DECLARE_BBOX_MAX_AREA_FACTOR` / `_ADD` and their tests were retired in the
  same step — two metrics in the tree at once is the hygiene failure this
  project has a rule about.
  **Why per-dimension:** area was not dimensionally correct and it squared a
  linear pad, which is what forced its `ADD` from the ruled 400 up to 4000 —
  padding a 1596×1 measurement 2px per side yields 1600×5 = 8000 px² against a
  ceiling of 5188, the harness's own emitted declaration failing its own rule.
  Per-dimension, that same shape costs +4 in one dimension and nothing in the
  other.
  **Why FACTOR is 1.75 and NOT the area rule's 3.0 — this is the part that gets
  re-derived wrongly, so it is stated as a mechanism, not a number.** *A factor
  applied per dimension squares in area.* Carrying 3.0 across would permit
  3.0² = 9× in area against a ruled bound of 3× — a threefold RELAXATION,
  shipped under documentation calling the change "dimensionally correct".
  **H4's first round did exactly that**, and a sweep caught it: 41,752 cases the
  area rule rejected and per-dimension@3.0 accepted, 0 the other way.
  **1.75² = 3.0625 ≈ the ruled 3.0**, so the metric becomes dimensionally
  correct while the strictness is preserved instead of quietly traded away. The
  residual 2.08% is real and measured; √3 = 1.7321 would zero it, and 1.75 is
  the ruled value with the approximation deliberate. Measured against the
  retired area rule: **dramatically tighter for small regions** (a 10×10
  measurement admitted a ~65×65 declaration before and admits ~25×25 now — the
  old `+4000` term dominated everything at that scale) and **equivalent for
  large ones** (at 200×200 the two ceilings agree to within 1.7%). All three
  properties are pinned by tests, including one whose whole job is to fail if
  someone "restores" FACTOR to 3.0.
  **`ADD` = 8 is argued from a sweep at THIS factor** (the round-1 sweep ran at
  3.0 and its conclusion did not carry). The emit path's worst required `ADD` is
  **3.25**, at measured extent 1 — but the binding case is the honest false
  positive that argued 400 → 4000 in the first place: the writing run measuring
  LESS than the emitting run. **At `ADD` 4 a 2px extent tolerates ZERO shrink** —
  declared 6, and a writing run measuring 1px hits a ceiling of 5.75 and fails a
  CORRECT declaration. 2px extents are not hypothetical here: both registered
  SUBPIXEL-WANDER sites have one. `ADD` 8 tolerates total collapse to 1px for
  any feature up to 5px and ~43% shrink at every larger extent, and the abuse
  case pays nothing — a whole-frame bbox over a 2×10 measurement is still 139×
  over its width ceiling.
  **Rule 9 was never the only bound on over-declaration, and the others are
  untouched:** rule 3 still forces containment, and rule 4 still bounds
  `maxPixels` and `maxChannelDelta` independently, so an over-wide bbox cannot
  absorb an extra real change without blowing the volume ceiling.
  **The diff-exception registry is what makes the tighter factor safe.** The one
  case that plausibly needed a huge factor was a wandering Δ1 site present in
  the emitting run and absent in the writing run — which swung a frame-12
  declared extent from ~965 px to ~110 px, an 8.8× shrink that fails at 3.0 as
  well as at 1.75. Masking that site at source is what makes measured extents
  stable between runs, so the factor no longer has to absorb the wander. H4's
  two halves hold each other up.
  There are no partial writes: a half-adopted
  event moves the baseline without moving the record, which is worse than no
  event at all. **On success it writes ONLY the declared frames** and prints
  two lists — written, and deliberately not written — so **the run's own output
  is the record, and `git status` is no longer the source of truth for which
  frames changed.** The comparator is the pure module
  `scripts/lib/declaredEvent.mjs` (tested); rule numbers in its output match
  the numbered list above. `--gate --emit-declaration <path>` writes a
  CANDIDATE declaration from what the gate just measured — bbox padded 2px per
  side, `maxPixels` = measured × 1.1 + 8 (the emitting run and the writing run
  are two different captures), every `reason` blank on purpose: a
  machine-emitted declaration nobody read is the failure mode this protocol is
  most likely to grow, and the blank refuses the file until a human writes the
  prose. `--force-all` is the escape hatch to the old
  overwrite-everything behaviour, behind a loud banner that names every frame
  first; it is the only path to it.
  **`git checkout --` has LEFT the baseline workflow.** The Aug-4
  scoped-event restore — capture all 26, then `git checkout -- <path>` every
  frame outside the declared scope — is retired: undeclared frames are never
  written, so there is nothing to revert. The **Aug-12 same-run restore
  rider** is retired with the mechanism it guarded; it existed only because
  restore operated against HEAD/index and could therefore silently revert a
  legitimate re-baseline from an earlier, still-uncommitted stage of the same
  run, and scoped writing removes that possibility instead of documenting
  around it. Byte-determinism in this environment is still only PARTIAL (some
  unchanged frames re-capture byte-DIFFERENT yet visually 0.0000% — see the
  flake registry below); under H2 that drift is inert by construction, because
  an undeclared frame is not written in the first place.
- **The diff-exception registry (HARNESS-H4 §3, Aug 15):**
  `screenshots/diff-exceptions.json`, checked in, so its git history is the
  register of every exception this project has ever granted. **What it is for
  is narrower than it sounds.** SUBPIXEL-WANDER is Δ1 and therefore contributes
  ZERO judged pixels at channel-24 — it never threatened the gate verdict and
  the registry is NOT what protects it. Where the wander actually bites is
  declared-event **rules 3, 4 and 9**, which deliberately consume the
  ZERO-TOLERANCE measurements; that is what refused twice on the frame-12 pair
  in leg 4, and it is why a declaration widened to the union of a wandering
  site's observed positions is legal only while that site is present. **So the
  registry masks known-wandering sites out of the zero-tolerance aggregates
  (`zeroDiffPixels` / `maxChannelDelta` / `zeroBBox`), and nothing else. It
  NEVER touches the judged fields (`diffPixels` / `diffPercent` /
  `diffImage`)** — those are the gate verdict, and a registry that can suppress
  a gate verdict is a blindfold. That property is pinned by a test, deliberately,
  so nobody wires one in later by reading the option name and assuming it means
  "ignore these pixels".
  It lives inside `diffImages`'s per-pixel loop (`scripts/lib/pngDiff.mjs`)
  because the aggregates are a count and ONE bounding box with no pixel list
  retained — you cannot subtract a region from an aggregate after the fact.
  **Two bounds keep it an exception rather than a hole in the frame:** a pixel
  is masked only if it is inside the site's `bbox` **AND** its channel delta is
  **≤ that site's `maxChannelDelta`** (so a real change landing on the same
  coordinates has a large delta and is NOT masked); and a site masking more
  than its `maxPixels` in one frame is a **hard error**, not a silent mask —
  the site has changed character and wants a human. **Nothing is masked
  silently:** the `measured @ch0:` line names what was excluded and by which
  site, a fully-excluded frame says `0 px unexcluded` rather than claiming
  `byte-clean`, and both report headers print the armed site count and the
  run's total excluded pixels. `--no-exceptions` runs with the registry
  disabled — it exists for whoever eventually diagnoses the wander.
  **Four sites are registered**, each with a prose `reason` citing where its
  numbers came from (rule 7's shape, and the loader REFUSES a site without
  one): the topbar theme-toggle glyph (`1582,18–1583,27`, ~16 px, Δ1, both
  themes) · the Box List Type-cell ⊕ low site (`262,107–299,108`, 6 px, Δ1 —
  **re-measured live during H4's §1 control run at exactly the record's
  coordinates**) · the ⊕ high site (`597,107–723,108`), which is **APPROXIMATE
  and marked `provisional: true`**: its x extent is quoted from the leg-4
  record, its y is taken from the low site's row, it was not observed in either
  H4 control run, and its `maxPixels` is set to the full bbox area precisely
  because its pixel count is unmeasured. It carries a `refineBy` naming **H3 or
  the first run that actually measures it**, so it cannot become permanent by
  inertia; Arch holds the matching H3 docket row.
  · the frame-11 single-pixel site (`184,358`, 1 px, Δ1, dark only), **CONFIRMED**:
  it was registered provisional on n=1, and the second observation its own
  `refineBy` asked for HAPPENED, at exactly the registered coordinate, so
  GATE-NEST-UPGRADE (ruled 2026-08-22, adopted in PORT-COV leg 2 §6.2) dropped
  both the `provisional` flag and the `refineBy` on the entry's own terms —
  see the SUBPIXEL-WANDER
  paragraph in the run fence for the ruling and its reasoning. Its `maxPixels`
  of 1 is structural rather than judged: a 1×1 box cannot mask more than one
  pixel, so its overflow error cannot mis-fire, and anything larger falls
  outside the box and is reported unmasked.
  **Every provisional site carries a `refineBy`**, so the registry cannot
  silently accumulate permanent guesses.
  **No bound on a site's bbox SIZE — deliberately not built, and registered
  rather than vaguely deferred, as `DIFF-EXC-BOUND`.** A large bbox paired with
  a small `maxPixels` is the HONEST shape for a site that wanders across a
  region, so bounding the box alone would penalise the honest case exactly as
  rule 9's retired area metric did, and designing the right bound against three
  data points is premature. **Its trigger is concrete: the first time a site is
  registered above Δ1** — that is the point at which the registry becomes able
  to mask something the judged gate would care about. Below it the Δ ceiling,
  the `maxPixels` hard error and the file's git history are adequate. The
  harness PRINTS a warning naming the ticket when a site is added above Δ1;
  that warning is a signpost, not the bound.
  **H4 TOLERATES the wander; it does not explain it. Diagnosis is H3, and H3 is
  still unscheduled.**
- **Load gate (HARNESS-H1 §3, Aug 14):** the harness reads the 1-minute load
  average before any capture and before the server spawn, and **REFUSES above
  5.0** — printing the measured load and the ceiling, exit non-zero. The
  ceiling is `GATE_MAX_LOAD`; `--force-load` overrides it behind a loud
  banner. **Every gate report prints the load the run happened at**, pass or
  fail, so a frame's conditions travel with its result. Proposed from the
  Aug-10 record: two honored refusals at load 8.07 and 218, and the clean
  official run at 3.96.
- **A fail-hard no longer leaks the dev server (HARNESS-H1 §4, Aug 14):**
  `fail()` throws a sentinel caught at the top level, which reaps the browser
  and the spawned server and *then* exits non-zero — `process.exit()` skips
  `finally` blocks, so every fail-hard inside the spawn-to-reap window used to
  orphan a `next dev` that the next run then adopted on :3000 (which is how
  flake (3) below self-perpetuated). Messages and exit codes are unchanged.
  **The CLEAN path was checked, not assumed, and was NOT leaking:** spawned
  non-detached, server up, `child.kill()` — 4s later `ps` showed no `npm run
  dev`, no `next dev`, no next-server and nothing on :3000, i.e. this npm
  forwards SIGTERM. So the spawn stays non-detached (it keeps sharing the
  run's process group, which is what makes Ctrl-C reach the server) and the
  reap stays a plain child kill. Re-check with `ps` if npm is ever upgraded.
- **Capture-flake registry (Aug 4):** known, intermittent, harmless-on-re-run —
  (1) the **08-pair persistent sub-threshold byte-drift**: `08-find-active`
  light+dark re-capture byte-DIFFERENT under `--update-baselines` yet PASS the
  gate at 0.0000% (the committed 08 baseline predates the current Turbopack
  render). **INERT BY CONSTRUCTION as of HARNESS-H2** — the entry stays because
  it is still a true description of what the capture does, but the old
  "RESTORE, don't adopt" instruction is gone with the restore step: a
  sub-threshold frame is undeclared, and an undeclared frame is never written.
  (2) **theme-race whole-frame diff** — the async theme re-sync, clean on
  re-run. **Widened TWICE, and the second widening is the important one.**
  Originally `04-library-dark`; widened at leg 6 to "a dark frame, not frame
  04" when it fired on `06-settings-dark` (1451200 px, max Δ207, bbox
  0,93–1599,999); widened again 2026-08-30 when it fired on
  `06-settings-`**`light`** at **the identical pixel count and the identical
  bounding box** (1451200 px, bbox 0,93–1599,999, max Δ248). **It is NOT
  dark-only and it is not frame-specific. The invariant across all three
  sightings is the pixel count and the bbox — not the frame, not the half.**
  Read it as *either half of any frame*. Δ varies; 1451200 px at bbox
  0,93–1599,999 is the signature.
  **Settled by import graph on 2026-08-30, and this is how the next one should
  be settled too:** a re-run tells you whether it recurs; the import graph
  tells you whether the frame could ever have seen the change, and it gives the
  same answer either way. Zero of that unit's eight changed modules were
  reachable from `06-settings`, against a control of 8 of 8 from the route that
  does use them. **Two runs is the limit** (lesson entry 6).
  **This entry is PROSE and masks nothing. It never becomes a
  `screenshots/diff-exceptions.json` site.** DIFF-EXC-BOUND is owed before any
  Δ>1 site is admitted there, a whole-frame diff is not the Δ1 sub-pixel wander
  that registry exists for, and masking 1.79% of a frame would blind the gate
  to a real regression on that page permanently.
  (3) **frame-03 sort-button mid-capture flake**: the harness fail-hards
  ("Method sort button not found") mid-run and writes NO baselines — re-run.
  **AMENDED Aug 13 — DEV-SERVER AGE IS A TRIGGER.** This fail-hard
  reproduced THREE consecutive times against a 7-hour-old `next dev`, and
  the very next run passed 26/26 once the server was killed and
  respawned. A flake that reproduces is not a flake (the lesson entry (6)
  was kept for). **Remedy: restart the dev server FIRST, then re-run** —
  never re-run the harness repeatedly against the same aged server, which
  reads as noise and is not.
  (4) post-`--update-baselines` transient byte-noise on **01/02/03-light** — a
  re-run drops them. (5) **04-library-light blank-capture race** (Aug 11):
  light-only, captured before the library loader paints — blank below the
  topbar, ~6.9% diff; clean on re-run. (6) WITHDRAWN as a flake (Aug 12): the
  9×9px topbar-region diff on 01/02-light was DETERMINISTIC — staging clicks
  shifting the capture moment of whichever frame followed (root-caused during
  AMEND-1; resolved by the frame-13-last staging rule). Kept as a numbered
  entry so the lesson survives: a "flake" that reproduces identically three
  times is staging, not noise.
  None is a real visual change; all sit within the loop bound.
  **MEASURED NEGATIVE — zeroing the pixel threshold made NO flake fail loudly
  (HARNESS-H4 §1, Aug 15).** The open worry was that a zero pixel threshold
  converts every capture flake from "passes quietly" to "fails loudly", so H4
  measured it BEFORE changing the constant: two gate runs on the unchanged tree
  at `GATE_DIFF_THRESHOLD_PCT=0`, on separate dev-server spawns, both **28/28
  PASS with ZERO judged pixels on every frame** — 28 of 28 byte-clean at ch0 in
  run 1, 27 of 28 in run 2 (the exception being the low-⊕ SUBPIXEL-WANDER site,
  6 px at Δ1, invisible at channel-24 and therefore not judged). Two further
  runs at the new default after the change: **28/28 again, both.** Every flake
  above is either a CHANNEL-scale event that was already failing (2, 3, 5) or a
  Δ1 byte-drift that channel-24 still absorbs (1, 4) — the zero that moved is
  the PIXEL COUNT, not the channel tolerance, and that distinction is the whole
  reason nothing changed here. Recorded as a negative on purpose: the next
  person to wonder whether H4 made the gate flaky should find the measurement,
  not repeat it.
- **Clock-pins (July 19, S-8 — pure-harness DOM overwrites, fail-hard if
  the target node isn't matched; the LIVE APP is never pinned):**
  frame 01: the MenuFooter build-date leaf div (anchored regex
  `/^v \d{1,2}\/\d{1,2}\/\d{2,4}$/`) is overwritten to "v 1/1/26" before
  each capture; frame 07: the print PageFooter's minute-resolution date
  spans are overwritten to "1/1/2026 12:00p". Never weaken the fail-hard —
  a silently-unpinned frame reintroduces nondeterminism.
- **Staged frames (July 19):** frame 07 navigates /equipment/print,
  dismisses the NoMethodDialog (the fixture deliberately trips it), enables
  Show Revisions, selects the fixture's saved revision, GO, waits for the
  page footer, captures the section-header stamp pair. Frame 08 performs
  the deterministic find of record — Model contains "Shure" (FOUND 2 of 5)
  — captures the found strip, then restores via Display All. Revision mode
  never persists in saved settings, so every run stages fresh.
- **Credentials:** `TEST_USER_EMAIL` / `TEST_USER_PASSWORD` in `.env.local`, read
  at RUNTIME only. Never read `.env.local` via tools — the permission config
  denies it by design.
- **Captures:** both themes × eight surfaces → `screenshots/gate/` (gitignored).
  View your own captures and compare against the reference frames in
  `screenshots/cmp-260706/` (25 Zite-vs-v2 comparison frames) and `screenshots/`
  (curated catalog frames).
- **Fixture:** permanent harness project "Visual Gate Fixture",
  `projects.id = 0d308b93-fc26-4389-b00f-c35e2170c7ee` (Blue #0070A3; 2
  categories, 4 methods, one 2-child model, three lone parents incl.
  no-category/no-method cases). Owned by the test user — **RLS-invisible
  from Daniel's own dashboard; access it via the test credentials.**
  **The fixture's pristine state INCLUDES revision snapshot "Baseline Rev"
  (`equipment_list_revisions.id = 89e87927-9591-45eb-981b-4ab4e5062482`,
  saved 2026-07-19 — ruled S-9 fixture amendment; frame 07 depends on it)
  AND (Aug 4 declared baseline event) ONE cable "GATE-CABLE" — type "6-Pair",
  length 25 ft, unbundled, NO tails/lines — plus the "6-Pair" cable type; frame
  07 photographs its EP-P1 projection "6-Pair, 25'". **(GS-A Leg 0,
  L0-R1/L0-R2):** pristine state ALSO includes
  `projects.equipment_sort_mode = 'category'` — self-maintained by the gate
  run itself (the run sets it; not a declaration-gated write). Full pristine
  data state: 5 generic items + GATE-CABLE + the "6-Pair" cable type +
  sort-mode 'category' + **the seeded `N/A - Labels Only` method row**
  (`methods.is_system = true`, one per project, created by the `seed_na_rows`
  AFTER INSERT trigger on `projects`; protected by `guard_system_method` — it
  cannot be renamed or deleted. **There is no box-side counterpart row:** the
  box N/A state is `equipment_items.no_box_needed`, a flag — migration 45,
  Aug 11) + **four seeded boxes** (`Amp World` #201 · `FOH Trunk` #202 ·
  `Spares` #203, nested inside FOH Trunk · `Mystery Case` #204, deliberately
  untyped so the yellow ⊕ state has a subject) and **three `box_types`** marked
  `notes='fixture'` (`Amp Rack 12U` · `Trunk` · `Small Case`) — **all four
  boxes carry no category**, so they print under `(No Category)` (Aug 11
  declared baseline event; frame 07 photographs them). Do NOT delete the
  fixture, this snapshot, the cable/type, OR the boxes/box types; do not add
  unrelated data. The fixture-write
  license is DECLARATION-ONLY — any further fixture data change is a ruled event.**
- **Probe rule (standing, GS-A window Aug 4–7):** diagnostic probes never
  write to the Visual Gate Fixture project. Any probe needing a write runs on
  a THROWAWAY project (created and destroyed in-run). Fixture writes happen
  ONLY under a DECLARED baseline event or a declared one-time Arch exception,
  census-bracketed and SELECT-verified.
- **Live projects (as of July 19):** JOY (retained by ruling; carries one
  stray harmless "Baseline Rev" revision, Daniel's to keep or delete), Our
  Town in Space, Visual Gate Fixture (never delete), Matchbook Festival —
  **Daniel's live show; treat as REAL production data in every handoff.**
- **Loop bound:** maximum 3 fix-and-recapture iterations per checkpoint. Anything
  still mismatched after 3 passes gets FLAGGED in the handoff with a diagnosis —
  not endlessly polished.
- **Visual-parity method: VERBATIM EXTRACTION.** Copy literal values (hex,
  padding, font-size, radius) from Zite source in the repo-root
  `Zite Minotaur.json` export into named constant modules (precedents:
  the menu button constants; `src/lib/toolbarButtonPalette.ts`). Never restyle
  from a prose description when source exists. Extract named files from the
  export programmatically — never load the 4.6MB blob whole.
