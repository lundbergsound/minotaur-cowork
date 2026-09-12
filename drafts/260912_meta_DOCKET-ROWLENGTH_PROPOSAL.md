# PROPOSAL — DOCKET-ROWLENGTH: the measurement, the rule, and five worked rows

*Written 2026-09-12 by the META parallel (Cowork-Arch). Member 6, plus two document-hygiene defects found while measuring it. Proposal only; the main line installs. Character counts are `wc -m` on `Minotaur_v2_Roadmap_v4_31.md` at `478ba48`.*

---

## Plain English, first

**The row's own numbers are stale, and the real ones are worse.** DOCKET-ROWLENGTH says the Docket is 61% of the Roadmap and ▶ ACTIVE is 35%. Measured against v4.31, the Roadmap of record: **the Docket is 97% and ▶ ACTIVE is 48%.** The figures were taken before the restructure deleted 35,541 characters of history — the Docket barely moved, the denominator shrank, so the percentages went up. 35% reproduces exactly at v4.27. The row has been quoting the pre-restructure ratio ever since.

**Two things broke in the v4.30 → v4.31 rewrite, and both are hygiene defects rather than row length.**

1. ⚠ **v4.31 states no character cap and no character count.** v4.28, v4.29 and v4.30 each opened with *"The whole file is capped at 135,000 characters. It stands at N."* The v4.31 rewrite deleted 457 words of preamble for being *"none of it facts about the project"* — and the cap and the count went out with it. The Architecture Prompt requires the file to be *"≤ its stated cap, which RATCHETS DOWN"* and requires *"both character counts checked rather than assumed"* at close. **There is now no stated cap to ratchet.** This is precisely the failure mode v35's own closing line names — SWEEPLINE-NOT-DURABLE, *"a fact carried only there dies with the version that carried it."* It died one version later, in the file that quoted the warning.

2. ⚠ **v4.31's footer still reads "End of Roadmap v4.28 … Retires Roadmap v4.27."** The H1 says v4.31 and matches the filename; the closing line is three versions behind. Against the rule that a governing document's header and filename always match and every install names what it retires, the footer is the half that was not bumped.

**And the honest constraint on the prune itself:** a Docket row's reasoning is supposed to move to the Ledger. **This seat cannot write the Ledger** — it is the main line's, by the parallel's own boundaries. So a prune performed here would delete reasoning before its destination exists. The rows below are therefore delivered as *pairs* — the one-line Docket row, and the Ledger-bound extract that must land first. **Ledger append before prune, never the reverse.**

---

## The measurement

| Section | Lines | Characters | Share of file | Rows |
|---|---|---|---|---|
| Head (H1 + version line) | 1–4 | 203 | 0.2% | — |
| ▶ NOW | 5–12 | 676 | 0.6% | — |
| ⏭ NEXT | 13–25 | 1,171 | 1.0% | — |
| 🏗 THE SEQUENCE | 26–37 | 1,199 | 1.0% | — |
| **NOW + NEXT + SEQUENCE** | **5–37** | **3,046** | **2.6%** | — |
| 📌 THE DOCKET | 38–293 | **113,222** | **97.2%** | 177 |
| — ▶ ACTIVE | 42–133 | 56,171 | **48.2%** | 77 |
| — ⏸ HELD | 134–181 | 21,457 | 18.4% | 41 |
| — 📐 STANDING | 182–224 | 22,538 | 19.4% | 38 |
| — ✅ RETIRED index | 225–248 | 3,422 | 2.9% | 14 |
| — BATCH | 249–260 | 2,052 | 1.8% | 7 |
| — ICEBOX | 261–264 | 34 | 0.0% | 0 |
| — ❓ Open Questions | 265–293 | 6,961 | 6.0% | 0 |
| **Whole file** | 1–293 | **116,471** | 100% | 177 |

**The bound that IS met:** NOW + NEXT + SEQUENCE = 3,046 characters against a cap of 8,000. The part written for Daniel is well inside its bound and is not the problem.

**▶ ACTIVE row length:** mean **705** characters across 77 rows. Longest rows: BOXBAND-DUPKEY 1,948 · CDMX-DEFERRED 1,940 · REPO-STRAY-UNTRACKED 1,813 · DEADCLASS-SURFACE 1,715 · UNATTENDED-MEASURE 1,625 · FIXTURE-NUMLABELS-GONE 1,576 · VERHIST 1,519 · CAPFLAKE-LIBLIGHT 1,471 · APPLY-TIMEOUT 1,345 · EQUIP-LABELS-2 1,319.

**Historic share, so the stale figure is not re-derived:**

| Version | Total | Docket | ▶ ACTIVE |
|---|---|---|---|
| v4.27 | 161,970 | 108,705 (67%) | 57,030 (**35%**) |
| v4.28 | 119,008 | 112,066 (94%) | 58,377 (49%) |
| v4.29 | 119,611 | 113,619 (95%) | 59,930 (50%) |
| v4.30 | 118,490 | 112,391 (95%) | 56,171 (47%) |
| **v4.31** | **116,471** | **113,222 (97%)** | **56,171 (48%)** |

⚠ **▶ ACTIVE has not shrunk by one character since v4.30** — 56,171 both times. v4.31's 2,019-character saving came entirely out of the preamble, which is where the cap was written.

---

## PROPOSAL 1 — the row-length rule, for the Architecture Prompt's Roadmap section

> **A Docket row is ONE LINE: what is owed, and who owns it.** The reasoning, the measurement and the history go to the Ledger, and the row carries a pointer to the append that holds them. A row may carry one `⚠` clause where the *consequence of getting it wrong* is not obvious from the one line — never to carry the evidence for the claim. **Bound, counted not assumed: no row exceeds 300 characters, and ▶ ACTIVE totals ≤ 25,000.** A row that cannot be said in one line is not a Docket row; it is a Ledger entry with a Docket pointer.

**What the bound buys, arithmetically:** 77 ACTIVE rows at ≤300 characters is ≤23,100 against 56,171 today — a saving of **~33,000 characters**, which takes the whole file to ~83,000. That is what lets the cap ratchet from 135,000 to **90,000** in one step.

## PROPOSAL 2 — restore the cap and the count, as a fact and not as preamble

The cap died because it lived in prose that was deleted for being prose. Put it somewhere structural instead. ⚠ **Propose: one line immediately under the H1, and it is the only metadata line allowed above ▶ NOW:**

```
*v4.32 · 2026-09-12 · retires v4.31 · cap 90,000 · stands at <counted> · NOW+NEXT+SEQUENCE cap 8,000 · stands at <counted>*
```

Four numbers, one line, no reasoning. It survives a preamble deletion because it is not preamble.

## PROPOSAL 3 — fix the footer

v4.31's closing line reads *"End of Roadmap v4.28 — September 11, 2026. Retires Roadmap v4.27."* It should name v4.31 and v4.30, and whichever version the main line installs next should name itself. ⚠ **Propose adding to the close checklist: the footer's version is read back, not assumed** — the same check already applied to H1 and filename, extended to the one place it was not applied.

---

## Five worked rows — each as a pair

**The pattern:** the Docket keeps the one line; the Ledger append receives everything else, verbatim from the current row so nothing is lost in paraphrase. ⚠ **The append lands first.**

### 1. BOXBAND-DUPKEY — 1,948 → 214

**Docket row:**

| **BOXBAND-DUPKEY** | Box List draws one box in two identically-labelled `Truck: Truck 2` bands; the fix is the band KEY, not the data. ⚠ **Do not edit the truck string.** UX-affecting, unpedigreed | **Daniel's ruling, then its own small unit. Ledger: sixteenth append** |

**To the Ledger:** the comparator/label identity mismatch (`banded` run-length grouping at `BoxListClient.tsx:1562-1573` keyed on the raw trimmed string vs `makeBoxComparator('truck')` at `boxSortChains.ts:89` using `compareLabels` with `sensitivity: 'base'`, `numeric: true`); the live corroboration on `Cable Parity Fixture` (`dbf56057…`) at `Truck 2` = 10 rows hex `547275636b2032` and `truck 2` = 1 row hex `747275636b2032`, the lowercase row being `More Hardware`, box 409; the proof of pre-existence (`boxSortChains.ts` byte-identical at `44e206d`); why `${label}-${i}` is the wrong fix; why editing `More Hardware`'s truck string is forbidden (BVSC-8POWER-DRIFT); and that the equipment list's banding is unmeasured.

### 2. REPO-STRAY-UNTRACKED — 1,813 → 246

**Docket row:**

| **REPO-STRAY-UNTRACKED** | Two untracked unignored trees in the code repo (`Claude outputs/`, `{src/`) plus one TRACKED stray (`session-log-archives/`); `Minotaur-Cowork/.gitignore` is two lines, so `handoffs/` never commits. ⚠ **`Claude outputs/` is a second one-writer breach** | **Daniel's desk — exact commands in `drafts/260912_meta_REPO-HYGIENE_PROPOSAL.md`. Ledger: sixteenth append** |

**To the Ledger:** the four-file inventory of `Claude outputs/` with the two 2026-09-10 20:31/20:38 writes during a live CC session; that September's instance was moved to `_to_delete/` and no ignore line was added; `{src/`'s unexpanded brace of 2026-07-04; the correction that `session-log-archives/` is **tracked**, not untracked, so an ignore line does not address it; and the `handoffs/` consequence for CC returns.

### 3. DEADCLASS-SURFACE — 1,715 → 233

**Docket row:**

| **DEADCLASS-SURFACE** | `text-surface-400/500/600/700` emit no CSS; 105 code sites inherit body colour and read WCAG 12.81 in dark. ⚠ **"Repairing" them LOWERS contrast to ~4.85, and a `surface.400` token would activate ~110 at once** | ⚠ **RULING OWED (Daniel): which of the 105 should be dim. No sweep until then. Ledger: fifteenth append** |

**To the Ledger:** the scale's actual steps (0/50/100/200/300/800/900/950); why all 105 were left untouched including two CC was already editing; why the four new tokens were kept out of `tailwind.config.js`; the code-only count of 105 against a raw grep's 109 (four comments, two written by the unit itself) and SCAN-COMMENTS; and the root cause at `globals.css:41-47`, with the observation that a finding recorded in a comment beside its single instance gets re-derived.

### 4. FIXTURE-NUMLABELS-GONE — 1,576 → 228

**Docket row:**

| **FIXTURE-NUMLABELS-GONE** | `Cable Parity Fixture`'s label counts read 0/0/0 across 2,783 rows against a record of 150/57/207, while `labels_done` still reads 57. **Live shows checked and unaffected.** ⚠ **Cause NOT measured** | ⚠ **BEFORE ANY RE-IMPORT — it overwrites the only evidence. Ledger: thirteenth append** |

**To the Ledger:** that the surviving boolean confirms project and population; the single bulk write at 2026-09-01 13:03 UTC touching 1,329 of 1,335 generic rows and the exclusion of the 2026-09-08 seven-row residue; that 2026-09-01 is a lead and not a finding; the live counts (BVSC US Tour 113, Mexico City 20) and that `labelsHashFreeze.test.ts` still guards the frozen fourteen; the three costs (EQUIP-LABELS-2's demonstration, FINDPARITY-UNTYPED's 25th sweep, the false Session Log state-of-play bullet); and CORPUSBOUND-AUDIT's generalisation.

### 5. UNATTENDED-MEASURE — 1,625 → 251

**Docket row:**

| **UNATTENDED-MEASURE** | ⚠ **`--bare` AND `--restricted` are both STRUCK — each leaves an unattended run with no fence.** Surviving candidate `--setting-sources user,project`: keeps the fence, drops all 184 local allow entries, costs two allow entries | **HELD. One measurement remains before any build. Ledger: sixteenth append** |

**To the Ledger:** the full measurement record in `drafts/260912_meta_UNATTENDED-MEASURE_PROPOSAL.md` — the settings-read probe and its three verdicts, the `--setting-sources` enumeration from the binary's own error, the split of the fence into `settings.json` and the 184 entries into `settings.local.json`, the two gate invocations that depend on the blanket `Bash(node *)`, the three-gate-sets inconsistency that makes Measurement 3 unanswerable as written, and the remaining unmeasured question about hooks declared via `--settings`.

---

## What this proposal deliberately does NOT do

⚠ **It does not rewrite the other 72 ▶ ACTIVE rows.** Doing so would delete ~33,000 characters of reasoning whose destination — the Ledger — this seat is barred from writing. The five above are worked to prove the pattern and to price it: **about 12 minutes per row for the pairing, so the full ACTIVE pass is roughly one Arch session, and it must be sequenced Ledger-append-first.** That is the proposal: one session, one direction, and the cap ratcheted to 90,000 at its close.
