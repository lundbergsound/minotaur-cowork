# NEXT-UPGRADE — ADDENDUM-2 (Arch ruling on S2-1)

Tier: 3
Model: claude-opus-5
Session: CONTINUE

*Arch, Cowork main line, 2026-09-18 15:05 ET, against section 2 of `from-cc/260918-1411_next-upgrade.md`.*

1. **S2-1 — route (a), the TopBar product fix, rides THIS unit.** Reason: your probe shows a real production
   race (a toggle made before the one mount read resolves is flipped back to the stored value — on a slow
   venue network that is seconds), and fixing the product rather than teaching the harness to wait around it
   is the Surface Rule. (b) would leave the defect in place; (c) would ship a production deploy without its
   gate. §0.1 is widened by exactly this one change.
   - The re-sync in `TopBar.tsx` (`:40-47` at your measurement) yields to any toggle made after mount: a ref
     set in `toggleTheme`, checked in the `.then` before applying the stored value. Nothing else in the file.
   - Unit-test the sequence: mount read pending → toggle → stale read resolves → theme stays toggled.
     Deletion control red, restored byte-identical.
   - Re-run your probe on dev `:3000`: 4 of 4 runs, the click sticks. Then the visual gate: **28/28, no
     baseline event** remains the expectation (no pixel should move).
2. **S2-2 — noted** for BATCH-HARNESS: the harness's preference restore depends on `setTheme`.
3. **At close, stop every process you started** (the `:3100` production server and any probe/proof servers)
   and say so in the return. Daniel's `:3000` stays his.

Then write the run fence and append section 3 with the COMMIT BLOCK. Proposed subject unchanged:
`NEXT-UPGRADE: next 16.3.3 for the security advisories`.

Raw Output Rule: *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT section if
the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every line."*
