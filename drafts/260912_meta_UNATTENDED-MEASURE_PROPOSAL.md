# PROPOSAL — UNATTENDED-MEASURE: the three measurements, and what they do to the design

*Written 2026-09-12 by the META parallel (Cowork-Arch). Member 5. **Measurement, then proposal — no build, and nothing here is a build.** Proposal only; the main line installs.*

---

## Plain English, first

**`--restricted` fails for the same reason `--bare` was struck, and it should be struck too.**

`--bare` was struck because it skips discovery of hooks — so an unattended run under it would have no bash fence. Measured today: **`--restricted` does not read `.claude/settings.json` at all.** That file is the only place the fence is wired. So `--restricted` removes the fence by a different route and arrives at the same place: the least-constrained session this project has ever run.

That answers Measurement 1 in the negative and it answers it *before* anything was built, which is what the HELD status was for.

**There is a surviving path, and it is in the flag's own help text:** `--restricted` ignores user, project and local settings but **`--settings` still applies**. So the shape is `--restricted --settings <a purpose-built unattended settings file>` — a file that declares the fence hook explicitly and carries only the allow entries an unattended run needs, instead of inheriting 184 accreted ones. That is a better design than the original candidate, and it is the one thing that should be measured next.

**Measurement 2 is fully answered.** **Measurement 3 cannot be answered as written**, because "the four gate invocations" does not resolve to any set of four in the corpus — three different gate sets are written down, of 3, 5 and 6 members.

---

## Measurement 1 — does `--restricted` drop the hooks declared in `settings.json`?

**Answer: it does not read that file at all, so the hooks cannot register.**

**Method.** The binary emits a warning naming the file whenever it reads a project settings file it will not honour. That warning is an observable proxy for "this file was read." Run in an isolated probe directory (outside both mounts) containing a `.claude/settings.json` with one allow entry and one PreToolUse hook:

| Invocation | Occurrences of `Ignoring 1 permissions.allow entry from .claude/settings.json` |
|---|---|
| `claude -p 'x'` | **1** — the file is read |
| `claude -p 'x' --restricted` | **0** — the file is not read |
| `claude -p 'x' --setting-sources user` | **0** — the file is not read |

**The flag's own help text, verbatim:**

> `--restricted` — Restricted mode: removes the built-in tools that run commands or code (Bash, PowerShell, REPL and the other code-running tools) and WebFetch unless `--tools` names them, and **ignores user, project and local settings files (managed settings and `--settings` still apply**; add `--strict-mcp-config` to skip MCP servers too). Also confines the file tools to the working directories (`--add-dir` included), refuses bypassPermissions, and lets only a person or the configured permission handler approve writes to settings, git and tool-configuration files.

**Strength of the claim, stated honestly.** This is a measurement that the file is not read, plus the vendor's own statement that project settings are ignored. It is **not** an end-to-end observation of a hook failing to fire, because that needs an authenticated session and **this seat is not logged in** (`claude -p` returns *"Not logged in · Please run /login"*). A hook declared in a file that is provably not read cannot register, so the conclusion is sound — but the one-minute confirmation belongs to Daniel, and it is written out below.

⚠ **Binary measured: `2.1.266`, at `/usr/local/bin/claude` inside the Cowork VM.** The row cites the installed `2.1.268` on Daniel's machine. The flag's documented behaviour is what decides this, and it is unlikely to differ across two patch releases, but the version gap is stated rather than papered over.

**Daniel's one-minute confirmation, if he wants it before the redesign:**

```
mkdir -p /tmp/fenceprobe/.claude && cd /tmp/fenceprobe
printf '#!/bin/bash\necho FIRED >> /tmp/fenceprobe/marker.txt\nexit 0\n' > hook.sh && chmod +x hook.sh
cat > .claude/settings.json <<'JSON'
{ "permissions": { "allow": ["Bash(echo *)"] },
  "hooks": { "PreToolUse": [ { "matcher": "Bash",
    "hooks": [ { "type": "command", "command": "/tmp/fenceprobe/hook.sh" } ] } ] } }
JSON
claude -p 'Run exactly this bash command: echo PROBE_A' ; cat marker.txt   # expect FIRED
rm -f marker.txt
claude -p 'Run exactly this bash command: echo PROBE_B' --restricted --tools Bash ; cat marker.txt
```

The second `cat` is the answer. No marker = the hook did not fire = the fence is off under `--restricted`.

---

## Measurement 2 — what values does `--setting-sources` take, and can it exclude `local`?

**Answer: `user`, `project`, `local` — exactly those three — and yes, `local` can be excluded.**

The binary enumerates them itself when given a bad value:

```
$ claude doctor --setting-sources nonsense
Error processing --setting-sources: Invalid setting source: nonsense. Valid options are: user, project, local
```

`--setting-sources user,project` parses cleanly at top level (it fails afterwards only on authentication, not on argument validation), and it suppresses the project-settings-read warning in the same way `--restricted` does — so it is a real exclusion, not a no-op.

**What this is good for, and it is not what the row assumed.** The row wanted `--restricted` partly to *"neutralise the 184 accreted allow rules without pruning them."* Measured: **`--setting-sources user,project` does that on its own** — it drops `settings.local.json`, which is where all 184 live (`settings.json` carries 36 allow entries and the hooks; `settings.local.json` carries 184 allow entries, no deny entries and **no hooks at all**). So:

⚠ **`--setting-sources user,project` neutralises the 184 rules AND keeps the fence, because the fence is declared in `settings.json` and the 184 are declared in `settings.local.json`.** That is the whole of what `--restricted` was wanted for, without the cost that disqualifies it. It is the finding of this measurement and it was not anticipated by the row.

---

## Measurement 3 — do the four gate invocations match under prefix semantics?

**It cannot be answered as written: there is no set of four.** Measured in the corpus:

| Source | The gate set it names | Count |
|---|---|---|
| `CLAUDE.md:75` — internal checkpoints | test suite · frozen gate · visual gate | **3** |
| `CLAUDE.md:~91` — Multi-Leg Run Pattern | build · strict typecheck · frozen gate · visual gate · guarded-code grep · dependency gate | **6** |
| `Architecture_Prompt_v35.md` — `_CLOSE.txt` contents | suite · typecheck · frozen · visual · dependency | **5** |

So the row's "four gate invocations" resolves to nothing, and **that inconsistency is itself the finding** — three documents name three different gate sets, and a `_CLOSE.txt` proving five counts cannot be checked against a checkpoint that runs three.

**The underlying question, restated and answered for the commands that ARE written down:**

| Gate command as the repo states it | Matched by |
|---|---|
| `npm run build` | `settings.json` allow, exact ✓ |
| `npm run lint` | `settings.json` allow, exact ✓ |
| `npx tsc --noEmit` | `Bash(npx tsc *)`, prefix ✓ |
| `npx vitest run` | exact ✓, and `Bash(npx vitest run *)` for arguments ✓ |
| `node scripts/frozen-gate.mjs` | `settings.json` allow, exact ✓ |
| `node --env-file=.env.local scripts/visual-capture.mjs` | `settings.json` allow, exact ✓ |
| `node scripts/visual-capture.mjs --gate` (package.json `test:visual`) | ⚠ **neither exact entry** — only `settings.local.json`'s blanket `Bash(node *)` |
| `node scripts/vercel-preopen.mjs` (pre-open check) | ⚠ **not in `settings.json`** — only `Bash(node *)` |

⚠ **Two gate-adjacent invocations are permitted today only by the blanket `Bash(node *)` in `settings.local.json`.** Under `--restricted` *or* `--setting-sources user,project`, local settings are dropped and both stop being permitted. **That is the concrete cost of the recommendation in Measurement 2, and it is two allow entries, not a redesign.**

---

## Proposals

### PROPOSAL 1 — strike `--restricted` from the design, on the record, beside `--bare`

Same reason, different route: `--bare` skips hook discovery; `--restricted` does not read the file the hooks are declared in. Both end with an unattended session running with no fence. Record it in the row so it is not reopened, exactly as `--bare` was.

### PROPOSAL 2 — the surviving candidate is `--setting-sources user,project`, and it is smaller than what was asked for

It keeps `settings.json` — therefore the fence, the frozen-check hook and the 36 curated allow entries — and drops `settings.local.json`, therefore all 184 accreted entries including `Bash(node *)`, `Bash(python3 *)`, `Bash(curl *)` and the literal `perl -pi` entry on `EquipmentListClient.tsx`. It needs **no new settings file and no build.**

**Its one measured cost:** add two allow entries to `settings.json` — `Bash(node scripts/visual-capture.mjs --gate)` and `Bash(node scripts/vercel-preopen.mjs)` — or the visual gate and the pre-open check prompt.

### PROPOSAL 3 — if a harder boundary is ever wanted, it is `--restricted --settings <file>`, and it needs one more measurement first

The help text says `--settings` still applies under `--restricted`. So a purpose-built unattended settings file could re-declare the PreToolUse fence and carry a minimal allow set. ⚠ **Unmeasured, and it is the whole load-bearing question: do hooks declared in a `--settings` file actually register under `--restricted`?** Nothing is built until that is answered, by the same discipline that saved this row today. The probe is the one in Measurement 1 with the hook moved from `.claude/settings.json` into a `--settings` file.

### PROPOSAL 4 — rewrite Measurement 3 before anyone tries to answer it

Replace *"whether the four gate invocations match under prefix semantics"* with **"reconcile the three gate sets — 3, 5 and 6 members across `CLAUDE.md` twice and the Architecture Prompt once — into one named set, then check that set's commands against the allow patterns."** The reconciliation is the work; the pattern check is then ten minutes, and the table above is most of it.

---

## What this did NOT cost, and it is the point of the HELD status

No build. No settings file changed. The candidate the row was heading toward was eliminated by a measurement that took one command, and the replacement turned out to be smaller and to have been available the whole time. ⚠ **Had this row been worked in the order it was written — design, then build, then measure — the fence would have been switched off by the unit intended to harden it.**
