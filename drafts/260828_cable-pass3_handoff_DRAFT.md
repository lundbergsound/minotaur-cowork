**DRAFT — NOT ISSUED.** Written at the 2026-08-28 close for the NEXT session to re-anchor and issue. Every line citation below was read at source at `ff82281`; **re-verify each one at open before pointing CC at this file.** On the previous handoff three of Arch's cited line numbers had drifted and CC caught all three.

Tier: 3 (Claude Code)
Session: FRESH — the BOX-PRINT-CLIP session ended at its commit.

# CABLE PRINT PARITY — PASS 3, GEOMETRY

**Unit of record:** PRINT-PARITY cable pass 3. Passes 1 (records) and 2 (page container) are closed; this is the last of the three.
**HEAD at drafting:** `ff82281`. Migration ledger **55**. No migration rides this unit.

---

## §0 · AUTHORISATION — this is a GUARDED unit

`CLAUDE.md` names **Print/PDF + revision snapshots** as a guarded surface: never build, wire, stub or "prepare" without an Arch-designed handoff. **This is that handoff.** You are authorised to edit the cable print clients and to add a cable geometry module, for the scope in §3–§4 and nothing wider. Revision snapshots are NOT in scope.

**Not in scope:** the box print family · `minotaurColors.ts` beyond what §4 names · any migration or schema · the seven disabled outputs (a parallel Arch session is designing them) · `docChrome.tsx:209-222`'s `@page` rule, which is **correct** — see §2.

## §1 · THE EVIDENCE, AND IT IS ALL ON THE MOUNT

- **v2, printed 2026-08-28 from `Import Test 5` through Chrome's own Save-as-PDF:** `~/Minotaur_v1_exports/parity-pairs/260828_cable-family/` — eight outputs, plus **sixteen options screenshots** in `screens/` recording the exact sorts and finds that produced them. The pairing is reproducible by construction, not reconstructed.
- **v1 arbiters:** `~/Minotaur_v1_exports/cable-box/Cable PDFs/` — all seventeen traced and **data-derived, none Find-driven. No fresh v1 print is owed.**
- **Prior measurement:** `handoffs/parallel/260827-0020_cable-parity-v2-pairs-MEASURED.md` §16 carries v1 column pitch, row pitch and tint-band sizes in points for the four **portrait** label grids. **Those numbers stand. Any geometry that document measured on a LANDSCAPE output is VOID** — it was measured on Quartz-rotated pages (PDF-CHROME-PATH).
- **The tool:** `handoffs/parallel/tools/pdfgeom2.py`, mode 1 (geometry). **It imports `pdfplumber`, so porting it into the repo is a DEPENDENCY CHANGE and a hard stop — do not.** Run it where it lives, or measure by whatever means your own machine already has. **DEVICE-VM-IS-NOT-CC: what Arch measured through the device shell does not describe your machine.**

## §2 · WHAT IS ALREADY SETTLED — do not re-derive

- **TIER 2 (orientation) IS CLOSED.** All eight outputs are `Skia/PDF m151` with **zero non-upright characters**, and Bundle Sheets, Tail Checklist and Tail Panel Labels are genuinely **792×612 landscape**. `docChrome.tsx:209-222` is correct and always was.
- **TIER 1 (content), after pass 1:** Cable Folder Labels **24 ✓** · Tail Checklist **116 ✓** · Tail Panel Labels **137 ✓** · Bundle Sheets **71 pages ✓** · Cable Checklist carrying **190 of 190** tail lines.
- **Pass 2 is closed:** pagination runs on measured DOM heights, every estimate constant is gone and `paginateByHeight` is deleted. **Do not reintroduce an estimate paginator.**
- **The palette is closed.** Fourteen `MINOTAUR_COLORS` values stand; **the product palette is the parity target, not v1's printed render.** `PANEL_GREY` is NOT Minotaur Grey — it is print chrome and matches v1 exactly.
- **The box family's fix is the precedent, not the template.** Its root cause was a cell derived as page ÷ grid where v1's cell is the layout body. **v1 stamps a fixed die pitch per output where v2 derives `(page − 54 pt) ÷ COLS`** — a different fault. The parallel retracted its own guess that one fix might serve both.

## §3 · CHECKPOINT 1 — **CHECKLIST-GROUPCOUNT**, and it is not a pixel

**Do not measure geometry until this is settled.**

The Cable Checklist printed 2026-08-28 shows **16 group sections**. v1 shows **27**. The M0-WIRE close records **"27 group sections exact"** on this same fixture the day before. The options screen was clean — sort By Group / Bundle / Cable, Model-before-name off, Which Cables blank, Print List off — so **it is not a find.**

**Establish a stated counting rule and apply it to all three: v1's artifact, the Aug-28 v2 artifact, and the builder's own output.** Then say which of the three numbers is right and why. Possible outcomes, all acceptable: the earlier 27 was counted differently; the found sets differ (v1's July-11 run is 794 of 1,119 cables); or something regressed. **If it is a regression, STOP and return — a selector defect is a pass-1 unit, not a geometry one.**

## §4 · THE WORK, once §3 yields

Per output, in this order, and **measure both sides rather than deriving either**:

1. **Page box and margins** — v1's and v2's, in points.
2. **Grid pitch** — column and row, per output, from the per-label origins on both sides. §16's v1 numbers for the four portrait grids are your starting comparison; **re-measure v2 from the Aug-28 artifacts, not from that document's v2 column, which describes a superseded build.**
3. **Cell geometry** — tint-band size and position, header and footer blocks, rule weights and colours.
4. **Land the constants in a `cableGeometry.ts`** on `boxLabelGeometry.ts`'s precedent: absolute point geometry measured off the arbiters, derived grids rather than restated ones, and one renderer where three near-identical ones exist. **A second copy of a constant is how the box family drifted.**

**Chrome floors painted edges to a 0.75 pt grid** (Q-2) — that is the residual floor, not a target. The box family's worst element landed at 0.63 pt and that is the standard to hit.

## §5 · SUCCESS CONDITION

Each shown as RAW OUTPUT:

1. **§3 settled**, with the counting rule stated and applied to all three sources.
2. **Per-output worst-element delta, before and after**, in points, against the v1 arbiter.
3. **The four portrait grids' column pitch** matching v1's measured values, or a stated reason one cannot.
4. Full gate set — suite, typecheck, frozen, dependency, build, visual. **Never pipe a gate run through a filter; write it to a file and read the file** (GATE-NOGREP). Expect **GATE-THEMEGLYPH** to be possible on any run: 19 judged px, Δ42, bbox `1273,14–1307,32`, light frames. **Report it as the known open signature; never register it, and never quote a green re-run as "the gate passed" when the same tree also failed.**
5. **No frame moved** — or, if one did, **STOP**: a baseline write is a declared event and is not yours to declare inside a geometry pass.

## §6 · HARD STOPS

Access control · dependency changes (**including porting `pdfgeom2.py`**) · frozen-layer contact · schema needs · ambiguous evidence · destructive or irreversible operations · credentials, secrets or money · anything raising an OS-permission or OAuth dialog. Plus: **§3 resolving to a regression** · **any gate frame moving** · **any output whose v1 arbiter turns out not to pair by construction.**

## §7 · CONDUCT

- **Raw Output Rule.** Reproduce the complete raw output verbatim into the return file. Do not summarize, paraphrase or describe it. Show every line.
- **Read the artifact, not the document** — including this one. Every anchor is checked at source before you edit it, and a number in your return is a measurement or it is not written.
- **No bash-mediated writes.** Edit/Write only; a `python3 - <<'EOF'` rewriting a file is a bash write (FENCE-HEREDOC).
- **The harness cannot reach `Import Test 5`** — RLS. Never write a gate against it; throwaway projects, created and destroyed in-run.
- **Commit** per WF-1a, only on Daniel's exact phrase. **The push half is still INERT** until FENCE-PUSH lands; state the block and leave the push to him.
- **The printed proof is Daniel's**, through Chrome's own Save-as-PDF, and it is the acceptance for this unit.
