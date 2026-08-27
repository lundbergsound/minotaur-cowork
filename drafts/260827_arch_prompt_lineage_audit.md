# Architecture Prompt lineage audit — v15 → v33

**2026-08-27 · companion to the v33 install decision.** Scope: the eleven versions Daniel recovered (v15–v19, v21–v26), the six on the mount (v27–v32), and the drafted v33. **v20 does not survive; v1–v14 were not provided** — the pre-v15 era exists only in Ledger narrative. One anomaly of record: **the file named v21 self-titles "Architecture Prompt v19.1"** — the lineage has a gap and a mislabel exactly where the workflow's biggest reversal happened (single-task → batched handoffs).

## The eras, briefly

- **v15–v19 (early):** a small, self-contained contract (~11–15KB). Full-file delivery is born (v16), the Session Log discipline and rollover are born (v17), archive location and thresholds tuned (v18–v19).
- **v19.1/"v21"–v25 (growth):** the CC Operating Contract appears verbatim in the prompt, single-task handoffs are deliberately reversed into batched/unit-scale handoffs ("the prompt-ferrying tax"), the handoff file is born, the Raw Output Rule matures, full-file delivery extends to the Session Log (v25).
- **v25→v26 (the big cut, 23.7KB → 13.3KB):** the contract text is extracted to a separate file, and with it several rules leave the prompt. The plain-language decision rule is born here — the cut and the plain-language turn arrived together.
- **v27–v32 (the Minotaur era):** the Parity Rule, unit-scale delegation, migrations discipline, WF-1a commit authority, the seat model (born, split, and re-unified), the propagation check, provenance narratives.

## What v33 restores, and from where

**From v32 (required — the restructure's zero-drop contract).** An independent 98-item inventory of v32 was run against the v33 draft; it caught **nine dropped or weakened items plus one more found separately** — the Strat-record obligation on FENCE-PUSH, the chmod/test-battery in-unit clause, the standing "state the mechanism whenever a rule is restated" obligation, the measured push-denial specifics, "non-negotiable" on the hard-stops, the fresh-log Rollover-"clear" field, the index.lock error string and CC-halts claim, "suggestions welcome" in pedigree (c), "inside its sections" on Ledger appends, and the explicit success condition on handoffs. **All ten are restored; the re-verification pass confirms each, and the drop list is empty.** The inventory table is `260827_v32_rule_inventory.md`. (This episode is itself the strongest argument for the O-9 discipline: even a careful restructure dropped ~10% of the rules until measured.)

**From the v15–v27 lineage (four restorations, all small, all flagged for Daniel's confirm):**

1. **The full hard-stop mirror.** The prompt's inline hard-stop list had mirrored the CC contract *short* since the v26 cut: the contract in `CLAUDE.md` never lost "destructive or irreversible operations," "credentials, secrets, money," or the **OS-permission/OAuth dialog trigger** (verified present today at `CLAUDE.md` lines 152–186), but the prompt's list showed only five items. v33's own principle — a pointer to another document is not a list — says the mirror carries all eight. Restored.
2. **"Without optimizing"** on the simple-fix exception (lost v25→v26) — forbids gold-plating a rollback. Restored, three words.
3. **Close-package files named to match the file each replaces** (eroded in two steps, v16→v17) — makes the save-over target unambiguous. Restored, one clause.
4. **The checkable-state examples on success conditions** (lost v19→v21): "a test passes, a command prints the expected output, a gate reads a number." The abstract phrase survived; the examples are what keep it operational. Restored as a parenthetical.

## What is lost and stays lost — deliberately (so it is not re-litigated)

Single-task sequential handoffs (reversed by ruling — unit-scale won); the hardcoded Opus/Sonnet check and the 4-step Model & Effort ceremony (cut by ruling to the one useful line); the two-seat model and everything claude.ai-Arch (retired by ruling, O-11); the strat-set "CC Agency Boundary" concept (superseded by WF-1a + Strat invariant 1); the separate `CC_Operating_Contract.md` file (re-canonicalized into `CLAUDE.md` at v27); the mid-session contradiction clause (absorbed by the three-way context-drift rule).

## What is lost and left to Daniel (recommendations, not changes)

- **"Two pastes, not twenty."** The lineage's best outcome metric — the founder-feelable target the mechanisms exist for. It survives in `CLAUDE.md` line 188 on the CC side; the Arch prompt lost it at the v26 cut. v33 does not restore it because its mechanisms (handoff files, one-line pointers) largely achieved it. **Worth restoring as one sentence in "The handoff" if Daniel wants the target stated where Arch reads it.**
- **CC-side stack confirmation and the two-sentence plain-language summary of what's being built** (lost v25→v26, and absent from `CLAUDE.md` too — verified zero hits). Its verification function is superseded by the run fence and §0 preconditions, which are stronger. The founder-facing half — CC proving shared understanding in two plain sentences before working — has no successor anywhere. **If wanted, it belongs in `CLAUDE.md`'s contract, not this prompt, and would ride the next `CLAUDE.md` touch (CLAUDE-HARNESS-STALE is already queued).**

## What the lineage says about how this collaboration works

1. **Counted gates hold; style rules decay.** The rollover has never failed since v17. Plain-language rules have been restated in four eras and broken in every one. v33's answer: counted cap, session boundary, and the style rules stated once, first.
2. **Full-file delivery is the most durable invention in the lineage** — born v16, doctrine by v25 ("hand-splicing is exactly the transcription risk full-file delivery exists to prevent"), survived every restructure verbatim. Whatever else changes, keep it.
3. **Big cuts drop rules silently — every time.** v26 dropped the OS/OAuth trigger's visibility and stack confirmation; v28 dropped three rules under a "nothing lost" note; the v33 draft dropped ten until independently measured. The O-9 instrument (diff count for amendments, inventory for restructures) is not ceremony; it has caught real losses at three of the last four opportunities.
4. **Rules with their argument attached survive; bare rules get rationalised past** — the v22 OS/OAuth rationale said this explicitly in 2026's best sentence about CC conduct: "recognize this by the class of action, not by reasoning about whether permission is probably already granted." v33 keeps the one-line-mechanism device for exactly this reason.
5. **The prompt teaches the register the sessions speak.** The era of densest prompts (v30–v32) is the era Daniel stopped being able to read the output. v33's plain rewrite is a structural intervention, not cosmetics.

## Intake line (Evidence Intake Protocol)

Eleven recovered prompt versions → `~/Developer/Minotaur-Cowork/Architecture_Prompt_v15.md` … `_v26.md` (beside v27–v32, names as uploaded, v20 absent).
