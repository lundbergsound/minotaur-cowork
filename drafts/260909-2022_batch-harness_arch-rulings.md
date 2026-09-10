# BATCH-HARNESS — Arch's read, four rulings, and what must not die in `handoffs/`

*Cowork-Arch, 2026-09-09. **Carried out of `handoffs/from-cc/260909-1615_batch-harness.md`, which is GITIGNORED.** The unit is BUILT and UNCOMMITTED; its commit is blocked on one thing (§3 below).*

## 1 · ⚠ THE CREDENTIAL — Daniel's, and the only time-sensitive item

**CC printed the test user's password to stdout and into one on-disk report file** while building the census logger. Disclosed in full, unprompted, at the top of its return.

**Remediation, all done before anything else:** six gate-report files removed (all written this session; `screenshots/gate/` is gitignored, so **never committable and it never left the machine through the repo**) · verified by grep that no file under `screenshots/` holds the value · a tested redaction module (`scripts/lib/censusRedact.mjs`) with **two independent rules** — an auth path contributes no body at all, and a secret-shaped key is masked by name — **13 tests with deletion controls** · census re-run and the login body now reads `(auth endpoint — body deliberately not recorded)`.

⚠ **One deletion control PASSED on its first attempt and proved nothing:** it put the secret beyond a truncation limit and asserted absence, which truncate-first also satisfies. **The corrected test straddles the cut**, where truncate-first leaves `{"password":"hunter` readable, and goes red under the control. *A control that passes is not a control — again, and caught again.*

**ARCH AGREES WITH CC: ROTATE IT.** The value is gone from disk but remains in that session's transcript, and "probably fine" is not the standard for a password that was written to a file. `.env.local`'s `TEST_USER_PASSWORD` is the only place the harness reads it. **Credentials are a hard stop for both agent tiers — this is Daniel's to do and neither seat can do it.**

## 2 · What shipped (built, not yet committed)

- **GATE-DEVCHECK** — the harness now proves what it is talking to: `/_next/static/development/_devMiddlewareManifest.json`, 200 + JSON array. ⚠ **Measured, not reasoned** — both servers stood up at once, dev `:3000` → 200, production `next start` `:3100` → 404. **And it carries repo identity for free**, since the manifest's `originalSource` entries are `config.matcher` from `src/middleware.ts`, compared against the file on disk. Refusal is loud, non-zero, and **spawns nothing** — spawning behind an occupied port would let `next dev` take the next port while the browser kept talking to the wrong server. A testable module (`scripts/lib/devServerCheck.mjs`), 21 tests, every guard with a recorded deletion control.
- **GATE-PORT** — the hardcoded `BASE_URL` gets an override, proven on a non-default port with the spawned server told the same port.
- **The flake register** — four corrections applied and the unregistered `05-gcm-light` sighting added; CAPFLAKE-LIBLIGHT closed as a duplicate of flake (5).
- **§4's census** — the class censused, then narrowed.

## 3 · ⚠ THE BLOCKER, AND IT IS ENVIRONMENTAL

**The visual gate could not run. Not once.** The machine sat at load **12–34** all session — `coreaudiod` 64%, `arkaudiod` 48%, Dante Virtual Soundcard, Loopback. **That is GATE-LOAD-AUDIO exactly.** One honest attempt was made and refused at the load gate; the refusal is the guard working.

**So "no frame moved" is UNPROVEN.** The unit touches only the harness, never app code, and the default run adds no listener and no wait — **but "no reason to expect movement" is not a measurement**, and the handoff was explicit that a moving frame is a stop-and-report. **The gate is owed on a quiet machine before this commits.**

⚠ **This is the practical cost of the low-involvement week and it should be said plainly: harness and app units both terminate in a gate run, and the gate needs a machine that is not doing audio work.** Sound work and gate runs cannot share a machine.

## 4 · Arch's four rulings on CC's open questions

**§D — RATIFIED, and it becomes a standing rule.** CC raised `GATE_MAX_LOAD` four times, each with a printed banner, for runs that were capture-only or terminated before any capture. `--force-load` was never used and the visual gate was never run under an override. **New rule: THE LOAD CEILING PROTECTS A VERDICT. A run that cannot produce a verdict may raise it — loudly, disclosed, and never on a run that captures a frame.** CC's reading was right; writing it down stops it being re-argued.

**§B — AGREED, LEAVE IT, and register the finding.** The census found one genuine leak: the theme write is un-awaited and **never restored at all**, so the fixture's owner reads `theme_preference = 'dark'` permanently. ⚠ **CC did not fix it deliberately, and the reasoning is right:** awaiting the `profiles` PATCH changes settle timing at the exact site of **GATE-THEMEGLYPH** (`bbox 1273,14–1307,32`, Δ42, undiagnosed three times) and plausibly of flake (2). **A change whose blast radius is the one site this project has repeatedly failed to diagnose does not ride a unit told not to move a frame.** Registered as **HARNESS-THEMEWRITE**; it rides H3.

**§C — AGREED.** `05-gcm` stages `goto → setTheme → capture` with no bounded wait — flake (3)'s shape. **No measurement ties entry (7)'s diff to that absence**, and adding a wait moves the capture moment. Registered, not fixed.

**§E — CORRECT JUDGMENT.** The stop condition existed to stop intermingling with leg 3a's uncommitted tree; leg 3a is committed and pushed, and the two untracked directories are stale artefacts in neither unit's footprint. Proceeding was right. **They remain Daniel's to clear** (EVIDENCE-UNTRACKED, ARCH-OUTPUTS-MIRROR).

**The SED LEDGER's `rm` — RATIFIED.** A bash-mediated deletion of six gitignored report files, disclosed beyond the letter of the rule because the rule is about the mechanism. **Leaving a plaintext credential on disk while asking permission to remove it would have been worse.** Scope measured before and after; frozen gate 3/3 after.

## 5 · New rows for the Docket

**NEXTENV-CHURN** — `next-env.d.ts` is rewritten by every `next dev` under Next 16, adding a `.next/dev/types/routes.d.ts` reference that exists only after a dev server has run. **Committing it would break a fresh clone's typecheck.** Caught at leg 3a's commit by the expected-line-count check. Probably wants gitignoring; not decided.
**HARNESS-THEMEWRITE** — §4 above.
**Flake (7)** — the GCM paint race, §C above.
