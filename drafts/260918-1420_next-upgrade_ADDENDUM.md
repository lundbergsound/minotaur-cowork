# NEXT-UPGRADE — ADDENDUM (Arch rulings on section 1's OPEN QUESTIONS)

Tier: 3
Model: claude-opus-5
Session: CONTINUE

*Arch, Cowork main line, 2026-09-18 14:20 ET, against `from-cc/260918-1411_next-upgrade.md`.*

1. **OQ1 — `agentRules: false`: YES, it rides THIS unit.** Reason: the upgrade is what introduces the
   behaviour, and `CLAUDE.md` is the contract every CC run is bound by; a dependency that edits it outside
   every hook cannot ship even once. Add the one line to `next.config.js`, nothing else in that file.
   **Prove it:** start one `next dev` on a spare port **with** `CLAUDECODE` and `AI_AGENT` set, wait for ready,
   stop it, and show `CLAUDE.md`'s md5 before and after is identical; then the same without the line
   (deletion control) showing the block appended, and restore byte-identical. Quote all four md5s.
   If the config key is rejected by 16.3.3's schema at build, stop and report.
2. **OQ2 — keep the caret on `next`.** The lock resolves 16.3.3 and the floor excludes every vulnerable
   version. The handoff's premise was wrong; thank you for not building on it.
3. **OQ3 — `browserslist` via `autoprefixer`: not this unit.** Arch registers it under SECURITY-PREPUBLIC
   (move `autoprefixer` to `devDependencies`, or the transitive bump). Build-time only; never runs in a
   served request.
4. **OQ4 — noted.** The `Model:` line stays for now; PROCESS reconciles the form.

Then, after Daniel tells you "dev restarted": run the visual gate (expected 28/28, §0.3 unchanged), write
the run fence, and append section 2 with the COMMIT BLOCK. `next.config.js` joins FILES CHANGED.

Raw Output Rule: *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT section if
the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every line."*
