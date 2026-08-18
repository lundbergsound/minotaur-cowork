# DOOR + LANDING — close running notes (for Roadmap v3.14)

*Working file held by the DOOR+LANDING build seat. Not a governing document. Everything here
folds into the v3.14 close package. Written durably rather than held in chat because this
unit has already lost one session to an interruption.*

**Status (2026-08-18 07:53 CDT):** built across round 1 + AMEND-1 + AMEND-2 + AMEND-3.
**Nothing committed**, 11 files, one commit pending Daniel's browser gate and confirm phrase.
**All eight machine gates GREEN on two consecutive rounds; visual gate 28/28 both times** —
see the withdrawn exception below. The unit is build-complete.

---

## Rulings taken in this seat

| ID | Ruling | Date |
|---|---|---|
| **R-S(a)** | A rate-limited legitimate user sees its own message: `That didn't go through — please try again in a few minutes.` Not silent success, not the generic error | Daniel, 2026-08-17 |
| **R-T(a)** | The CLAUDE.md run-fence amendment is applied inside the unit and committed with the code | Daniel, 2026-08-17 |
| **R-U** | **Landing page copy replaced wholesale.** The built copy was rejected in Daniel's own words — *"not copy that I approved… inauthentic and generic softwarese, and doesn't sound remotely like me."* Replacement supplied verbatim. Page becomes hero → waitlist → footer; five sections deleted. **Supersedes `handoffs/260815_landing_copy_minotaur-app.md` on landing-page body copy only** | Daniel, 2026-08-18 |
| **R-V** | **Harness line scheduling:** the harness fixes below run **after** (1) the box unit, (2) the v1 import/export work, (3) SHARE. Not before | Daniel, 2026-08-18 |
| **R-W** | **Comms Prompt v9 is to be DELETED and rewritten from scratch** before the next Comms deliverable. Not amended | Daniel, 2026-08-18 |

### ⚠ The visual-gate exception is WITHDRAWN

An earlier entry in this file recorded DOOR closing on 26/28 under a documented exception.
**That is retired: the AMEND-2 run passed 28/28, all frames byte-clean at ch0 except the two
registered Δ1 wander sites the registry masks normally.** DOOR closes on a clean gate with no
deviation from the standing per-unit gate rule, and nothing about a gate exception should
reach the Ledger.

**The corrected characterization of the Δ42 site** — this is the version of record:

- It is **intermittent in presence and identical in position when present**: four
  observations at `172 px, max Δ42, bbox 1273,14–1307,32` on `01-project-menu-light`, and two
  runs (2026-08-17 round 1 run 3, and 2026-08-18) with it absent entirely.
- That is precisely the project's own **SUBPIXEL-WANDER** model — *wanders in presence, stable
  in position* — occurring at **Δ42 instead of Δ1**. Being above channel-24 is why it fails
  the judged verdict rather than being absorbed the way the registered Δ1 sites are.
- **It is therefore the bridge case H3 has been missing:** the same phenomenon at a magnitude
  that reaches the verdict. H3's model was built entirely on Δ1 sites.
- **It must never be registered as a diff-exception site.** A Δ42 entry is exactly what
  `DIFF-EXC-BOUND`'s trigger exists to catch.

**Load average is not the variable — stated at the strength the evidence supports.** Two clean
28/28 runs, at load **4.97** and **3.72**; the failing runs sat at **2.84–3.87**. One pass is
above that band and one is inside it, so load **does not track the failure mode in either
direction**. *(An earlier draft of this file claimed a negative correlation off the 4.97 run
alone — corrected as instance EIGHTEEN below.)* This retires the Screen-Sharing/compositor
hypothesis and strengthens `GATE-LOADPROXY`.

---

## Docket rows to register at the close

| ID | Row | Owner | Trigger |
|---|---|---|---|
| `GATE-THEMERACE` | **NEW.** An intermittent Δ42 site over the topbar theme-toggle region on `01/02-light`, position-identical across the four runs where it appears and absent in two others. Same presence-wanders/position-holds signature as SUBPIXEL-WANDER, an order of magnitude larger, and above channel-24 so it reaches the judged verdict. Likely mechanism: the first light-pass frames captured mid theme-transition. **Best H3 input the line has** | Arch | Harness line, per R-V |
| `GATE-COUNTWAIT` | **NEW, root-caused at source.** `visual-capture.mjs:426` decides element presence with `locator.count()`, which **does not auto-wait** — unlike every other Playwright call in the harness. A slow-rendering equipment list therefore fail-hards with no retry. This is what capture-flake (3) actually is; killed three runs on 2026-08-17. Fix is one line. `:460`'s `count()` is an optional click and benign. **Correction owed:** flake (3)'s Aug-13 amendment names dev-server age as the trigger — a run on a **277ms-old** server failed identically, so age was one sufficient cause, not the cause | Arch | Harness line, per R-V |
| `GATE-FIXDIRTY` | **NEW, CC's find.** The equipment sort restore at `visual-capture.mjs:432` is a fire-and-forget `.click().catch(() => {})`, so a fail-hard after it leaves `projects.equipment_sort_mode = 'method'` on the fixture — and the *next* run then fails frame 02 for a reason unrelated to the tree under test. Cost a full run on 2026-08-17 | Arch | Harness line, per R-V |
| `GATE-LOADPROXY` | **NEW.** The 5.00 load ceiling never fired during any failing run. Measured across six runs: two passes at **4.97** and **3.72**, failures at **2.84–3.87** — one pass above the failure band and one inside it, so **load does not track the failure mode in either direction**. The gate's own guard measures a quantity unrelated to what it guards against: a check that reads as satisfied while doing nothing, the same class as H2's rule-3 containment and H4's threshold hole. **Not a negative correlation** — that overstatement was caught by CC and is instance EIGHTEEN | Arch | Harness line, per R-V |
| `VIS-ENVFILE` | **NEW.** `npm run test:visual` is `node scripts/visual-capture.mjs --gate` with no `--env-file` (`package.json:13`), so it dies at preflight on missing `TEST_USER_EMAIL`/`TEST_USER_PASSWORD`. CLAUDE.md documents the working invocation; the two disagree | Arch | Harness line, per R-V |
| `DOOR-RATE` | **NEW.** `waitlist_join_v1`'s per-IP brake is 5/hour on a hashed address. This audience sits behind shared university and shop NATs, so five real people from one address in an hour is realistic on an announcement day. R-S(a) makes the failure visible rather than silent; **raising the cap is schema and belongs to the main line** | Arch (main line) | If waitlist volume warrants |
| `DOOR-FLOOR` | **NEW.** The submit floor is 400ms measured from first interaction with the email field. Residual: a browser that autofills on load with no focus event starts the clock at `input`, so a submit within 400ms of that is still dropped silently. Named in the constant's own doc comment | Arch | Opportunistic |
| `DOOR-V1LINK` | **NEW, a consequence of R-U worth Daniel's eyes.** The deleted *"v1 is at work today."* section carried the only direct link to the v1 product page (`lundbergsound.com/?page_id=656`). The footer's `lundbergsound.com` now points at the site root instead. The Aug-15 Strat close listed "keep selling v1" as part of this page's job; R-U is Daniel's own ruling, so this is registered rather than contested. The round-trip trust signal itself **survives** inside paragraph 2 | Daniel | His call, any time |
| `COMMS-REWRITE` | **NEW, supersedes the banked v10 amendments.** Comms Prompt v9 is deleted and rewritten from scratch before the next Comms deliverable (R-W). The two amendments banked at the Aug-15 close — point at Writing Prompt v1 §Daniel's Voice rather than duplicating it, and give the Comms tier its own propagation check — become **inputs to the rewrite**, not edits to a document that no longer exists. **Third input, from R-U:** the landing copy was logged as Daniel-approved through three rounds and the build reproduced it verbatim, yet the assembled page read as generic to him. The miss was in the copy file, not the build — a fact about the Comms process, and the strongest argument for the rewrite | Daniel | Before the next Comms deliverable |
| `HARNESS` | **Amend the existing row:** H3 remains unscheduled, and the five gate rows above join the line behind it, sequenced by R-V | Arch | Per R-V |

---

## Arch standing-correction instances

- **FIFTEEN.** The round-1 handoff's §0.2 asserted `git status --short` must be empty.
  Roadmap v3.13's `GIT-CFG` row — read whole the same morning — records `next-env.d.ts`'s
  dev/build flip-flop as benign and never-committed. **New shape:** not a missing read; the
  disconfirming fact was already in front of the author in a governing document and did not
  reach the writing. Distinct from instance eight, which was about choosing a proxy.
- **SIXTEEN.** Two commands cited without being run: `npm run test:visual` (cannot run) and
  `grep -rn "as never" src/` (ten false positives on the prose *"was never"*). **v31
  candidate:** the Surface Rule as practised checks that a named thing *exists*; it does not
  check that a named *command works*. A command cited in a handoff is run before it is cited,
  or marked as unrun.
- **SEVENTEEN.** The AMEND-2 handoff instructed CC to expect 26/28 as an accepted exception,
  reasoning from flake (6)'s lesson that a signature reproducing identically is staging. Flake
  (6) was **deterministic**; this site is **intermittent in presence, identical in position**,
  which is SUBPIXEL-WANDER's own model — already in the corpus, and a better fit. **Shape:**
  matched a new observation to a registered model without checking whether a different
  registered model fit it better. Adjacent to thirteen (generalising from confirming examples)
  and fifteen (the disconfirming fact already in the documents). *Consequence: none material —
  every instruction given was correct either way, and the exception is withdrawn rather than
  exercised.*
- **EIGHTEEN, and CC caught it in the same document that recorded seventeen.** The AMEND-3
  handoff asserted *"load correlates negatively with the failure"* on the strength of a single
  clean run at 4.97. AMEND-3's own run then passed at **3.72**, inside the failing band, and CC
  flagged that the evidence supports only the weaker claim — load does not track the failure
  mode at all. **Shape:** asserted a directional relationship from n=1. Same family as
  instance thirteen (a claim proved on the cases in mind and stated as general), and the
  disconfirming case arrived one run later. Corrected in `GATE-LOADPROXY` above so the docket
  row does not inherit the overstatement. *Consequence: wording of one docket row; no
  instruction depended on it.*

---

## DOOR-SEO propagation — owed at the close

Four mutable documents carry the misidentified title tag; Session Log entry 4 is **immutable**
and the correction lands in the new entry instead.

1. `handoffs/260815_arch_opener_door-landing.md` — CONTEXT paragraph
2. `handoffs/260815_landing_copy_minotaur-app.md` — §SEO **and** §BUILD NOTES bullet 1
3. The Aug-15 Comms addendum to the Arch opener — item 2
4. `drafts/HOLD_Roadmap_Merge_2026-08-15_Comms.md` — *"SEO title/meta preserved verbatim"*

**Note against item 2:** under R-U that file is superseded on body copy but its SEO block
still needs correcting, because the error is what DOOR-SEO records.

**Second propagation item, from `GATE-COUNTWAIT`:** CLAUDE.md's capture-flake registry entry
(3) states dev-server age as the trigger. Disproven at source; amend in the harness pass.

---

## Verification Arch performed that CC structurally could not

- **Waitlist row census, three times, each matching CC's prediction exactly** — 4 rows after
  round 1, 1 after the interrupted AMEND-1, 2 after AMEND-1's re-run. Every silent-drop and
  reject branch wrote nothing. **Table censused to zero after each; it is at zero now.** The
  only end-to-end proof of the guard available, since `anon` and `authenticated` have no
  grants on the table by design.
- **AMEND-1's central claim, proven live:** Case A2 submitted at **894ms from first
  interaction / 954ms from mount** and inserted. Below the retired 1500ms mount floor — round
  1 would have dropped that person silently.
- **CC's H3 mechanism confirmed at source:** `visual-capture.mjs:262` and `:285` both
  `fetch(BASE_URL)` — the bare `/` — as the dev-server readiness probe, before login at
  `:382`. Under `next dev` that probe is a compile trigger, so a heavier `/` changes the
  run-up into frame 01. **Caveat of record: no pre-DOOR observation of the Δ42 site exists,
  so causation is not claimed** — and the 2026-08-18 clean run at high load weakens it further.
- **`GATE-COUNTWAIT` root-caused at source** by Arch: `visual-capture.mjs:426`, `count()`
  without auto-wait, with only two `.count()` sites in the file and the other benign.
- **CLAUDE.md's two fence edits verified verbatim** at `:1401`.
- **Import-graph measurement:** `WaitlistForm` is imported by exactly two files, neither
  captured; `layout.tsx`'s render surface byte-untouched.
