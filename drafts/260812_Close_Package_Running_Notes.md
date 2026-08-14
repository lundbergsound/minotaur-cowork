# Running close notes — Cowork-Arch session, Aug 12 2026 (S4-3 leg 2 re-gate + AMEND-3)

Working scratch for this session's close package. Not a deliverable; folds into
Roadmap v3.8 + the Ledger append + the Session Log entry at close.

## Docket movements

**TYPE-JUNK — CLOSES.** Cleared on Daniel's word: 7 boxes + 5 junk box_types
deleted from Test Cable; `PRG Half` kept as the one real catalog entry. Zero
referencing rows (0 equipment_items.box_id, 0 bundles.box_id, 1 internal
within_box_id). **The docket row was stale in both directions:** it named two
junk types where four existed, and said `Mystery Type` was used by one box —
measured, it was used by none, so the "clearing blanks that box's type" hazard
had already evaporated. Note for the Ledger: `PRG` and `PRG H` are successive
partials of `PRG Half` — B2's fingerprint, found in live data. Independent
confirmation of CC's root cause from a source other than CC's reasoning.

**PRUNE-CHK — CLOSES.** 13 claude.ai project docs deleted; 14 remain.
- `claude/Minotaur_v2_Roadmap_v3_6.md` — superseded by v3.7 (the named item).
- 12 evidence catalogs that were duplicated: each existed once as a July manual
  upload and once as a live GitHub-synced copy under `docs/reference/`. All 12
  are in the sync filter.
- **The finding that justified it:** RAG was returning BOTH copies for the same
  query — 3 of 8 result slots in a box-behaviour search were duplicates of each
  other, crowding out the next genuine hit. The cost was retrieval quality, not
  storage (knowledge 332KB / 2MB).
- Reversible: synced copies remain and are the live ones; a manual copy is a
  re-upload from the repo.
- Images left alone: the .png and .jpg sets overlap on ~4 screens and each
  carries ~5 the other lacks. Not duplicates.

**CAT-VOL-FIX — OPENS.** `docs/reference/Minotaur_v1_Box_Behavioral_Catalog.md`
§3 and the DDR catalog §1.7 both still read "Volume computes from W×D×H." The
Ledger's Aug-11 corrections block says both are wrong (DDR extraction: Volume
is a plain editable Number, no script computes it). **The correction lives in
the Ledger; the catalog still carries the error** — and CC is instructed to read
evidence artifacts directly rather than through Arch's paraphrase, by design. A
leg-4 session opening the Box Types admin would read §3, build a computed-volume
grid, and be correct by its own citation while contradicting a standing ruling.
Two files, one sentence each. **Do at close, after CC returns** — the repo is
CC's desk under the one-writer rule.

**KNOW-HYG — OPENS.** Close-hygiene rule for claude.ai project knowledge; see
"Arch Prompt" below. Bank for v30.

**BOX-VOL-R1 — WITHDRAWN.** Arch error, owned: minted a new ID for a ruling that
already had one. It is **OQ3** (Aug 11) — "Box Types Volume is STORED and
manually entered; volume is INTERIOR capacity, W/D/H are EXTERIOR dimensions;
deriving one from the other is a category error." Daniel restated it unprompted
and identically on Aug 12. The AMEND-3 handoff's build instruction is unchanged
and correct; only the citation label is wrong. No churn to the file mid-run.

**BOX-CELLS — OPENS (provisional).** Header · Number · Truck · Stack · Location
render as plain text on `BoxRow`, editable only in the footer panel. Not a
regression — that is how leg 2 was built. Open question is whether v1 edits them
inline on the box list; if yes it joins **B4**'s port, since field-level
navigation across cells is meaningless if the cells are not fields. Settle from
the v1 catalogs before leg 3 opens.

## Session events

- **AMEND-2 browser re-gate FAILED** → AMEND-3 issued at
  `to-cc/260812-1712_s4-3-leg2-amend3.md`, Session: FRESH, off HEAD `f1a9348`.
- **Gate results.** PASS: B6 (both halves), B7, B8, ⌥⇧R inert, neutral cell.
  FAIL: Tab-to-⊕ dead · type commit flashes revert-then-adopt · New Box focus
  lands only sometimes.
- **D1 root cause (Arch-measured).** `showTypePlus` is true whenever the draft
  is not an exact match — *including while a dropdown option is arrow-navigated*.
  That, not Enter-activation, was B2's real root cause; B2 deleted the keyboard
  route instead of tightening the condition. Tab fails because the input's blur
  fallback clears the draft and the button unmounts in the same tick focus is
  landing — the S4-AUTO unmount race, keyboard flavour. Net effect: ⊕ is
  mouse-only, which fails the operator standard.
- **The house idiom, established of record.** Keyboard-activating a "+" is a
  capture-phase Enter handler on the cell (`CableRow.tsx:584`), NOT tabbing to
  the button — and Enter-activation is only safe there because a dialog gates
  the create (`CableListClient.tsx:1677`; Cancel leaves nothing, `:1890`).
- **Rulings.** R-A: Enter HOLDS unmatched text; ⊕ opens a create dialog on the
  UpdateBundleDialog shell (Daniel, from v1 — "v1 holds it as unmade until you
  hit the plus button"). R-B: Change All *refusals* become modal; *confirmations*
  stay passive (P3's green toast untouched). R-C: strip the footer panel's four
  duplicate checkboxes + the computed weight/cost readout; KEEP Add'l Weight,
  Actual Weight, Add'l Cost — the only entry point for those values in the app.
- **D3 folded into B4** rather than patched: New Box focus needs the declarative
  `rowFocusRequest` plumbing B4 builds. Patching the rAF means building it twice.
- **Arch error, owned.** The AMEND-2 re-gate script opened the B6 test with
  "click into Header" — Header is display-only on the row, so the stale-arm half
  of the test could not run and B6's real root cause sat unverified until the
  re-test. Script written without checking which cells were live.

## Still owed by Arch at close

- Flake registry entry (3) dev-server-age amendment → CLAUDE.md.
- CAT-VOL-FIX (2 files) — after CC returns.
- Roadmap v3.8 · Ledger append · Session Log entry 6.
- Docket sweep line.

## Datapoint for the seat-consolidation open question

Deleting claude.ai project docs is a **Cowork-seat capability the claude.ai seat
lacks** — from that seat it is an instruction to Daniel, not an action. Sits
alongside the already-registered Supabase-capability fact and SEAT-MIG
exceptions #1–2.

---

# AMEND-3 return + §B (appended 260812-1830)

## New docket items

**AC-HANDLED — OPENS.** `AutocompleteInput.handledRef` latches true on the first
commit of a mount and is never cleared, so the (kk) blur-fallback commit is
**partially inert for the life of every mount** across every autocomplete field
in the app. (kk) was registered as an *urgent data-loss fix*; this weakens it
more than anyone believed. CC found it, correctly declined to widen AMEND-3, and
registered it. Own small pass, other surfaces gated.

**HARNESS — amend the row.** The AMEND-3 gate printed **PASSED** with eight
nonzero frames, because all eight sat under the 0.1000% threshold (top: 0.0906%).
Only the standing any-nonzero-is-a-finding rule caught it. **A real regression up
to 0.0999% would print PASSED.** Threshold-vs-declared-event question for the
harness pass; the rule is currently doing work the tool should do.

## Rulings this round (Daniel)

- **OQ2 — the held box-type draft REVERTS on leaving the row.** Survives Tab to
  the ⊕, the dialog, and Cancel; discards on leaving the row. Reason of record:
  an unfocused cell showing a value the database does not have, on a row you have
  walked away from, reads as saved — a lie on screen in a dark theatre. R-A
  protects typing from the gesture just made; it does not make the draft durable.
- **OQ4 — one line of body copy in the create dialog**, pedigree (a): *Add
  “⟨name⟩” to this project’s Box Types. Size and volume are optional.* No v1 copy
  exists to cite — v1's ⊕ has no dialog at all (Box Catalog §2.4.1), so the
  dialog is a v2 invention off the bundle idiom. Deliberately omits "fill them in
  later": the Box Types admin is leg 4 and does not exist yet.

## Arch rulings

- **Baseline event GRANTED** for frames 09/10/11/12 × both themes (8 frames).
  CC's per-frame measurement proved every changed pixel falls in one 213×62 box
  in the panel's column 4, with both deviations explained. CC re-baselined
  nothing on its own authority — correct.
- **OQ5 re-pointed gate tests ACCEPTED**; the replacements are a stronger gate.
- **OQ3 registered, not fixed** (AC-HANDLED).
- **`commitValue` now sets the resolved option's label** — accepted, but it is a
  behaviour change to a component every surface uses, and pixels-at-rest do not
  prove behaviour. May intersect docketed **(bbb)** and **(eee)**; **B5**
  inherits the question.
- **Blank-name edge case checked at source, no defect** —
  `planBoxTypeCommit`'s empty branch returns `set typeId:null`/`noop`; the dialog
  cannot mint an empty box type.

## Arch corrections — THREE this session, one pattern

1. The AMEND-2 re-gate script opened the B6 test with "click into Header" —
   Header is display-only on the row, so the stale-arm half could not run.
2. §6 predicted "frame 10 only." The footer panel is `always visible` (CP-B1),
   so it is in-frame in all four box captures — eight frames moved.
3. §6 required the five source-pinned tests to survive while also ordering the
   keyboard route restored — four of them pinned its ABSENCE. Self-contradictory.

**The pattern, and it is the same one in all three:** specifying against a
*remembered or inferred* surface instead of a *measured* one. It is the same
failure the Aug-11 Ledger already recorded ("never design against a remembered
schema… only the generated types describe v2") reappearing in the UI and the
test layer. All three were caught downstream — twice by CC, once by Daniel at
the gate — which is the system working, but the cost is a round each time.
**Standing correction for the Ledger: read the surface before writing the
instruction that constrains it.**

## Pattern worth carrying

The outside-click / unmount race has now appeared in **three** distinct costumes:
S4-AUTO's box-⊕ create, AMEND-3's Tab-to-⊕, and AMEND-3's dialog Cancel
reverting the held text. Same root shape each time — a control whose existence or
value depends on focus state, losing a race to a document-level handler. Candidate
for a written idiom rather than a third ad-hoc fix.

---

# AMEND-3 §B return (appended 260812-1855) — ACCEPTED

Suite **1457/97** · frozen 3/3 · visual **26/26 at exactly 0.0000%** · deps 0 ·
fixture pristine · no stream editors in the repo. AMEND-3 §8 probe re-run
32/32 unchanged; §B delta probe 19/19.

## CC judgment calls accepted

- **Same-row moves REVERT via A2's existing path**, not hold. CC built hold
  first; the probe proved it unreachable — once focus returns to the field the
  cell is an ordinary autocomplete and a same-row click is an outside-click
  commit, which for unmatched text is A2's ruled `revert`. Buying the hold meant
  forking A2's semantics for one cell to keep a value on screen the DB lacks —
  the opposite of what the OQ2 ruling argues. The row-exit rule now stands aside
  for A2 and is only the net for the state A2 cannot reach.
- **02/03 dark byte-refresh: restore-don't-adopt.** The docketed 02/03 drift
  recurred under `--update-baselines` (which rewrites all 26). CC proved 0
  changed pixels with frame 13 as control and 09-light as positive control,
  excluded both from the staged set, and handed the restore line to Daniel per
  the standing same-run restore rider. Correct on all three counts.
- **One gate test re-cut** from a whitespace-exact pin to an assertion on the
  handler's body. A gate test needing a re-cut every time its handler is touched
  has stopped gating.

## Arch rulings

- **CLAUDE.md's two changes BOTH ride this commit** — the AMEND-3 baseline
  record and the Return Handoff File Protocol correction (the `~/Desktop`
  destination v29 retired on Aug 10, still named in CLAUDE.md until now).
  Splitting adds a commit and a phrase for nothing; leaving CLAUDE.md describing
  a retired destination is the exact failure CAT-VOL-FIX describes. Note it in
  the Ledger entry so the archaeology exists under a boxes-titled commit.
- **AC-HANDLED priority BUMPED.** It is no longer latent: mouse and keyboard now
  disagree, visibly, about *when* a same-row revert happens on a shipping
  surface (mouse reverts immediately via A2; keyboard holds to row exit because
  `handledRef` has left the blur fallback inert). Both satisfy the ruling and
  they converge when AC-HANDLED lands — but it is a user-visible inconsistency
  now, not a mechanism note.
- **DIALOG-BLANK — OPENS (docketed, not fixed).** Clearing the Name field makes
  the §C line read `Add “” to this project’s Box Types.` — and worse than ugly,
  it is false: `planBoxTypeCommit`'s empty branch means OK will *clear the box's
  type*, not add anything. Recommended fix is not a fallback sentence but
  **disabling OK while the trimmed name is empty**, which removes the misleading
  path outright. Docketed rather than built: the tree is green and complete for
  everything ruled, the path requires deliberately clearing a prefilled field,
  and another gate cycle for one line is not worth holding leg 2 open. Rides
  B5 or leg 3's first touch.

## THEME FOR THE LEDGER — corrections do not propagate to what is actually read

Three instances surfaced today, all the same shape:

1. **CAT-VOL-FIX** — OQ3's volume correction lives in the Ledger; the box
   catalog §3 and DDR catalog §1.7 still say "Volume computes from W×D×H", and
   the catalogs are what CC reads.
2. **CLAUDE.md's handoff protocol** — v29 retired the `~/Desktop` destination on
   Aug 10; CLAUDE.md still named it until CC fixed it in this round, unprompted.
3. **The AMEND-2 gate tests** — pinned a shape AMEND-3's own ruling superseded.

The Ledger and Roadmap capture *rulings*. CLAUDE.md and the reference catalogs
are what CC *reads*. **A correction that lands only in the Ledger is inert.**
Proposed standing rule for Arch Prompt v30, alongside KNOW-HYG: when a ruling
corrects a prior statement, the close names every document carrying the old text
and updates them in the same package — a propagation check, not a memory test.

---

# AMEND-4 return (appended 260813-0545) — ACCEPTED

Suite **1461/97** · frozen 3/3 · visual **26/26 at exactly 0.0000%** (no baseline
moved) · deps 0 · fixture pristine · probe 26/26 · regression sweeps 31 and 19.

**D4 fixed at the right level.** Presence is now DERIVED from render state and
announced from a single effect, so "no code path can set a highlight and forget
to announce it — which is the exact failure mode D4 was." Provenance moved to
`highlightFromHoverRef`; hover-set highlights clear on pointer-leave, keyboard-set
ones survive. `showBoxTypePlus` takes `optionHighlighted` and cannot tell arrow
from hover — one argument, one question. Enter picking the hovered option was
verified, not assumed (probe 2c/2d), per the explicit instruction.

**R-D, D5 and DIALOG-BLANK all built.** Blank name now degrades to *Add a type to
this project's Box Types.*

## Rulings

- **OQ1 — Tab-between-fields after OK is B4**, confirmed by CC's measurement: the
  ⊕ hides on an exact match, the capture handler stands down, `AutocompleteInput`'s
  Tab branch `preventDefault`s and calls `onAdvance`, and the box Type cell wires
  no `onAdvance` because the surface has no field navigation. Inert, not unsafe
  (no dialog raised — verified). Daniel's "cursor stays in the field" ask is
  satisfied; "Tab still works" needs B4.
- **OQ2 — R-D's consequence ACCEPTED, and B4 owns the final grammar.** With a
  draft held, forward Tab always re-raises the dialog. **Arch correction: I told
  Daniel the escape hatch was "Esc then Tab." It is Esc (cancel the dialog), Esc
  (revert the field, A2), then Tab** — or Shift+Tab, or the mouse. The exits all
  exist and the ruling holds in every one (the value never survives leaving the
  row), so this ships. Designing the row's Tab semantics now in an amend round and
  again in B4 next session would be designing it twice.
- **AC-HANDLED** unchanged, still docketed.

## The python-heredoc disclosure — ACCEPTED, and the rule gets widened

CC made three multi-site mechanical edits via a `python3` heredoc that asserts
`count == 1` per pattern before rewriting, and **disclosed it unprompted** on the
grounds that a bash write bypasses the PostToolUse frozen-check hook — even
though the rule as written names only stream editors. Frozen gate run
immediately after, PASS 3/3; both files outside frozen regions.

**Ruled: the rule is about the risk class, not the tool name.** Any file
modification through the shell bypasses the hook and is in scope. **CLAUDE.md
amendment owed** — one line naming the class rather than `perl -pi`/`sed -i`
specifically. CC is holding to Edit-only meanwhile.

**Explicitly NOT a third discipline strike for WF1A-SUNSET.** The prior two were
undisclosed-until-after `perl -pi` runs against an explicit instruction. This was
disclosed before being asked, guardrailed with a single-match assertion, gate-
verified, and outside the rule's letter. Log it as a datapoint that the RULE was
underspecified, not that the discipline slipped — that distinction matters at the
sunset review.

## CLAUDE.md amendments now owed at close (two)

1. Flake registry (3) — dev-server age is a trigger; restart rather than re-run.
2. The stream-editor rule widened to "no file modification through the shell."
