# A week of forward motion with Daniel's attention divided — the lanes, and what to issue

*Cowork-Arch, 2026-09-09, at Daniel's instruction: "figure out what long handoffs we can issue to keep moving forward on the list with less involvement from me this week."*

## 1 · The governing observation

**Almost everything blocked right now is blocked on DANIEL'S EYES, not on design.** Sort the live Docket by what it terminates in and the picture is stark:

| Terminates in | Items |
|---|---|
| **Daniel's printed proof** | the eight queued layouts · PRINT-PARITY cable family · BOX-DOC-PARITY · EQUIPLIST-ESTIMATE-PAGINATOR's conversion · the 5167 sheet · the Tail Panel reprint · BUNDLESUM-MARKS · the box reprints |
| **Daniel's visual judgment** | DARKMODE-PASS · CONTRAST-PAIR's remainder · KKK-PASS |
| **Daniel's ruling** | VERHIST (7) · CHANGEALL-NAALIAS · BOXBAND-DOCTRINE · CATCOUNT-COLUMN · EQUIPLIST-DOTRULE · EQUIPLIST-CLMARGIN · BUNDLE-LINK-IMPORT · CABLE-TAB-BUNDLE-METHOD · the library Tab order |
| **NOTHING — machine-checkable end to end** | **BATCH-HARNESS · FENCE-FORMS · BATCH-HOUSEKEEPING · CORPUSBOUND-AUDIT · parts of the export-integrity pair** |

⚠ **So the week's rule writes itself: run the fourth row, and do not start anything in the first two.** A print unit issued this week finishes and then sits waiting for a proof he cannot give, which is worse than not starting it — it occupies a slot and accrues staleness.

## 2 · The lane, in order

### ▶ UNIT 1 — BATCH-HARNESS, and it is FIRST because it pays for the rest

**Why first, on evidence rather than preference:** leg 3a's gate took **ten attempts** and cost **five runs in one day**, and two of those failures were harness defects that were only diagnosed because a session happened to look. **Every unit this week pays that tax until someone fixes it.**

Already diagnosed and waiting, no design needed: **GATE-DEVCHECK** and **GATE-PORT** (they have now cost three runs between them) · the **flake-register amendments and the unregistered `05-gcm-light` sighting** (`drafts/260908-2006_leg3a-harness-findings.md`) · **GATE-NOGREP**'s codification · **ROUNDTRIP-INMEM** · GATE-COUNTWAIT · GATE-DLGRACE · GATE-LOADPROXY · VIS-ENVFILE.

⚠ **Scope note: the two fixes leg 3a already made to `scripts/visual-capture.mjs` ride in leg 3a's commit and are NOT this unit's** — this unit starts from them.

**Involvement: ZERO.** No UX surface, no pedigree, no printed proof. The acceptance is the gate's own behaviour, which the gate measures.

### ▶ UNIT 2 — FENCE-FORMS

**RULED IN SUBSTANCE ALREADY** and it has a precedent to copy exactly: FENCE-PUSH was proved with a **34-case battery on the installed hook**. FENCE-FORMS has none, which is why the guard has been patched one spelling at a time by reading — and has missed `perl -0pi`, a `python3` heredoc, and (a false positive, the other failure direction) an inline `node -e` containing `=>` read as a shell redirect.

**The instruction writes itself: TEST THE GUARD, DO NOT READ IT.** Battery first, then widen the matcher until the battery passes, then prove bulk staging is still blocked.

**Involvement: ZERO.** It is a shell-script guard with a test battery. Nothing renders.

### ▶ UNIT 3 — BATCH-HOUSEKEEPING

The registered small fixes that have been waiting for a convenient unit: **LINT** (dead on Next 16 — `next lint` was removed and the script errors) · **LINECOLOR-ZERO** · **DEADEXPORT-GRIDCOL** (a deliberate keep-or-delete, not drift) · **ADMIN-NEWDUP** · **CREATEMETHOD-BLINDERR** · SRGRANT sweep · REPO-WEIGHT.

⚠ **`duplicate_item_v1` does NOT ride this** — it is a migration, Trigger B, Arch's, and the Roadmap says so explicitly.

**Involvement: NEAR ZERO.** One caveat: DEADEXPORT-GRIDCOL wants a keep-or-delete decision, which Arch can take and record.

### ▶ UNIT 4 — CORPUSBOUND-AUDIT — Arch's, and it needs NO ONE

The docket asks: how many "resolved by corpus scan" dispositions rest on **BVSC + JOY alone**, when `Labels` was true of those two and false of the world? **Never audited.**

⚠ **And last night gave it a second, sharper question.** `num_labels` on the parity fixture went from a recorded 150-twos/57-ones to **zero on every row**, and three governing documents still assert the old figure. **So the audit is no longer only "which conclusions rest on a narrow corpus" but "which rest on corpus state that has since CHANGED, with nothing to notice."** *A corpus measurement is true at a timestamp; we record neither the timestamp nor a way to re-check.*

**Involvement: ZERO. This runs on this seat, with no CC handoff and no repo write.**

## 3 · Held for the week — named as held, not dropped

**DARKMODE-PASS** is the tempting one and should still wait. It is one file and one gate round, but **its acceptance is Daniel looking at a dark screen and saying "yes, that reads now."** Issuing it produces a unit that is built, gated green, and unacceptable — the worst state to leave a UI change in.

**VERHIST** is the biggest available forward motion and is **one message away**: seven rulings, Arch leaning yes on all seven, and Arch will take them on his word. **If he delegates them, VERHIST-MIG becomes Arch's Trigger B work (one confirm before the apply) and VERHIST-UI becomes a long CC unit with almost no involvement.** That is the single highest-leverage sentence he could write this week.

**Everything print** waits for a printer and a person.

## 4 · What this buys

Three long CC handoffs and one Arch audit, all of which run to completion without him, **plus a harness that stops charging every future unit a five-run tax.** The rulings pile does not shrink — but nothing in the lane is waiting on it.
