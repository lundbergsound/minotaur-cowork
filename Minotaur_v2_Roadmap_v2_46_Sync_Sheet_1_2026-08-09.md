# 🗺️ ROADMAP SYNC SHEET #1 — vs v2.46 · 2026-08-09 (S3-G CLOSE)

Sheet 1 of ≤2 under the sync convention. Reads WITH Roadmap v2.46; where they
conflict, this sheet wins. The full v2.47 rewrite folds this sheet at the next
roadmap delivery (due at the second sheet or the next major close, whichever
first).

---

## 1 · S3-G — BUILT (Sprint 3 COMPLETE pending the owed-gates close-out)

All nine cable/tail print surfaces live end-to-end: Bundle Sheet · Cable
Checklist · Tail Checklist · Cable Labels (Small/Big, one page) · Tail
Line/Block/Panel labels · Balun Labels · Cable Folder Labels — on the R-22
one-page chain (options + Which-X find + preview + Print/Save-PDF), plus the
P10 cable-row 🖨/green-→/Clear-Print-List system, P9 phantom-model retirement
(steps 1+2; the view-column DROP stays registered Trigger-B), the A5
mult-delete tail cascade (DDR-224-extracted), the A6 nav doors, and equipment
print point-true fonts (C4).

**Commits this window:** `55d27e9` (GS-A CLAUDE.md fold) → `769b84e` (Leg 0
types regen) → `ff6c25d` (Leg 1 census + parity evidence) → `5616b89` (Leg 2
scope plumbing) → **the combined S3-G commit** (Legs 3+4 + Amends 1a/1b/2/3;
44 source files + docs/reference/evidence/print/parity/) — **hash enters the
record at the next pre-open**, alongside its Vercel Ready.

**Counts at close:** suite 1250/89 · frozen 3/3 vs `be0769de` · migrations
unchanged (`l0_r1_...` still last) · fixture pristine, untouched all session ·
THREE baseline events total (no new events; none were needed — every leg held
16/16 @ 0.0000% until the amend-3 parked gate, below).

**Ruling register additions (all Daniel, Aug 7–9):** Leg-1 round (method-0
extends to the Bundle Sheet · Labeled: = ordinary find field · unflagged-cables
warning → S4 · Clear-Print-List = DDR-573 verbatim w/ Clear default + the
once-per-arrival latch · line-gesture deferral now RULED, trio 606/607/608
evidenced) · the Aug-7 gate-notes triage (#1/#2/#3/#10–#14 amended in;
#4–#9 registered) · A3 fixed Source|Destination checklist order (Daniel
paper-confirmed) · Aug-8 round (#2 band scoping: bundle band only under
bundle-aware sorts; Quick Print bandless+modelless · Skip Labels only on
By-Cable · folder labels keyed to sort w/ the No-Group trail) · **PRINT FONT
PARITY (standing rule, product-wide):** every print output renders point-true
sizes matching its v1 exemplar, proven by measurement at its gate — applies to
all nine S3-G outputs + equipment, and joins the gate set for every future
print surface.

**New standing doctrine:** @page uses EXPLICIT DIMENSIONS (`11in 8.5in` /
`8.5in 11in`), never the landscape/portrait keyword (Chrome interactive-path
drop, root-caused twice: the @media-print nesting, then the keyword itself) ·
print-orientation/print-size verification is NEVER evidenced by Playwright
pdf() or headless --print-to-pdf alone — the interactive Save-as-PDF dialog is
a different renderer and **Daniel's desk is the renderer of record** ·
evidence commits STAGE BY DIRECTORY (exotic filenames never travel in
pasteable blocks — the Aug-7 U+202F clipboard failure).

---

## 2 · OWED GATES — "SOON" QUEUE (first actions of the next session, before any build)

1. **Official visual gate 16/16 @ 0.0000%** on a quiet machine (parked at
   amend-3 under the degraded-environment rule; frame-07 direct diff passed
   0.0000%; the commit landed on Daniel's ruling with the gate owed).
   `node --env-file=.env.local scripts/visual-capture.mjs` (warm-up) then
   `--gate`.
2. **The three-PDF measurement packet to Arch** (interactive Save-as-PDF, the
   renderer of record): Bundle Sheet · the vape-show Equipment List · Small
   Cable Labels. Arch measures vs the v1 exemplars: bundle sheet true
   792×612 unrotated full-size w/ the Description chip; equipment at 10/12/14pt
   and ≈v1 pagination (7pp show); labels point-true. Settles the C2 interactive
   confirm + the C3/C4 real-path font question numerically.
3. **OL25WR stock re-gate** (when at a printer): die-cut registration of Small
   Cable Labels + Tail Line Labels. Known residuals to judge in the flesh:
   ~7.7pt chip x-offset (small) · ~13pt constant first-row origin offset
   (tail-line). Inside the die-cut margins → accept; fighting the cuts → one
   scoped geometry amend.
4. **C4 pagination confirm** on Daniel's live show (≈7pp parity, per-page
   header/footer).
5. **Vercel Ready** for `5616b89` + the combined commit.

## 3 · REGISTERED THIS WINDOW (Sprint-4 basket + standing)

- **Focus/nav mini-pass** ← Daniel's Aug-7 notes **#4–#9** (tab-into-model
  from blank bundle w/ group-sort header stability · bundle-create dialog
  focus return · steck in tab order both ends · filter tab chain →
  top-record name · ⌥⇧C bundle-jump landing · ⌥⇧arrows commit-before-move in
  the color field). Joins (lll)/(nnn)/(jjjj)/(kkkk).
- **Dead-write verify mini-pass** (near-term, its own gated pass): grep the
  lazy-builder class (`void supabase.from` + bare builders); VERIFY each site
  by network capture before fixing (the Leg-0-proven sort-mode site is the
  caution against assuming); known suspects EquipmentListClient.tsx:276 +
  the TopBar theme profile write. Frozen-region adjacency noted.
- **effective_group ruling** (Arch-owned, view/schema): bundled cable's own
  `group_manual` is ignored (bundle-first derivation); v1 shows the cable's
  own group. Proposal on the table: COALESCE(group_manual, bundle_group).
  Extraction + four-step migration when ruled.
- **Aug-25 cable-data gap → STRAT:** the v1 import engine registers-but-never-
  parses cable/tails/bundles/lines — the port brings EQUIPMENT ONLY; any v1
  cable system built during shop prep needs hand re-entry in v2 (or a
  cable-import extension unit, unscheduled). Sequencing decision owed at
  Strat.
- **Line-side 🖨 trio port** (606/607/608) rides the line/steck label unit.
- **Revision-stamp labels** (Previous/Current) deliberately left screen-sized
  to protect the D-2 layout pin — rule if point-true wanted.
- **Multi-page print preview cosmetic whitespace** (screen only; prints
  correctly) — ungated cosmetic, registered.
- **Harness punch additions:** the fail-hard path leaks the spawned dev
  server (orphan wedges the next run — add cleanup) · frame-03 sort-button
  flake recurrence under load · the theme-toggle 10×10 intermittent joins the
  registry family · load-average sensitivity note (parked-gate precedent).
- **Prune owed in the claude.ai project** (deferred from Aug 9):
  S3G_Draft_Decision_Block_2026-08-05.md + S3G_Evidence_Digest_2026-08-05.md
  (superseded by the ruled register + the committed census).

## 4 · CORRECTIONS OF RECORD (this window)

**Arch:** propagated 1a's stale HEAD citation into the 1b opener unverified ·
the "21 expected lines" staging miscount (was 20) · the bundle-sheet
"trailing numeric pair" pdftotext misread (the Pulled/Labeled boxes) · the
per-filename commit-block convention failed on exotic filenames (replaced by
directory staging, standing).
**CC:** originated the stale HEAD in the 1a state map · amend-2 B9(ii) false
"structure matched" parity claim (overlaid the Playwright path, missed the
Description column and the interactive rotate/scale) · amend-2's landscape
"verification" via the disqualified path.

## 5 · CLAUDE.md FOLD QUEUE (one CC docs errand at the next session open)

Lineage `55d27e9` → `769b84e` → `ff6c25d` → `5616b89` → [combined hash]
(**S3-G COMPLETE**) · counts 1250/89 · the PRINT FONT PARITY rule · the
@page explicit-dims doctrine · the print-verification honesty rule
(interactive dialog = Daniel-desk gate; Playwright pdf()/headless
disqualified as orientation/size evidence) · directory staging for evidence
commits · the parity corpus at docs/reference/evidence/print/parity/ (7
PDFs) · the dead-write mini-pass registry · the owed-gates queue (§2) as the
Next block · Next → owed-gates close-out, then Sprint 4.

## 6 · NEXT ACTIONS

1. **Daniel now:** the combined commit (45-line check → push → hash noted) ·
   the S3-G-2 one-word confirm (residual v1 outputs → S4 basket) — still owed
   · R8 drill status (done / tonight / deferred-by-ruling) — still owed ·
   place this sheet + the Session Log; prune the two Aug-5 files.
2. **Next Arch open:** pre-open (hash + Vercel + tree) → **owed gate §2.1
   before anything else** → the CLAUDE.md fold errand → adjudicate the
   three-PDF packet → OL25WR close-out when available → Sprint 4 planning
   (basket: focus mini-pass · dead-write pass · D-2b · GS-C · S3-G-2 · OQ3 ·
   box registry · effective_group · unflagged-cables warning ·
   grouped-bundle-group view defect · line/steck unit).
3. **Standing:** ADM-1 waits on the sharing unit · attorney window September ·
   Aug-25 port path (equipment-only — see the Strat flag).
