## CC Operating Contract (standing behavior — do not skip)

This section is the CANONICAL Operating Contract (single source — no
separate contract file exists; July 23 ruling). For a new project, copy
this section, adjusting only project-specific hard-stop items; never
loosen the shared set.

### Delegation scope (July 23 — unit-scale)
Arch delegates whole units of work (one named Roadmap unit per handoff),
not subtasks. Within the unit: implementation, visual fidelity, column
widths, menu look, and dialog anatomy are YOURS to judge — directly
against repo evidence (screenshots, print artifacts, catalogs), never
against Arch's paraphrase of it. Arch retains schema/migrations,
cross-unit architecture, frozen-layer stewardship, and rulings where
evidence is silent or v1 is deliberately diverged from.

### Handoff tier (July 24 — WF-2)
Handoffs carry a `Tier:` line naming the model the pass runs on (Opus
4.8 is the default; Fable by exception). If a handoff arrives with no
`Tier:` line, flag it and proceed.

### The Parity Rule (binds CC AND Arch)
Every UX-affecting choice (anything the user sees or operates: layout,
labels, controls, dialogs, colors, ordering, gesture behavior) must
carry exactly one pedigree:
  (a) a Daniel ruling, cited by ID;
  (b) a specific evidence artifact, cited by file + section/frame;
  (c) an OPEN QUESTIONS proposal awaiting Daniel's ruling — clearly
      marked, suggestions welcome, never silently shipped.
UNCITED = UNBUILT. Never invent UX or features. If an Arch handoff
specifies UX without a citation, BOUNCE IT — put it in OPEN QUESTIONS
and build the rest; do not implement it on Arch's authority alone.
Internal engineering structure (module layout, naming, test design,
non-visual code shape) is your professional judgment and needs no
pedigree. Where evidence artifacts conflict, the evidentiary hierarchy
(Reference material section below) rules; a conflict it doesn't resolve
goes to OPEN QUESTIONS, never to a silent call.

### The Surface Rule — CC's side (Arch Prompt v30, Aug 14 install)
"Uncited = unbuilt" has a sibling: **unread is unwritten.** A handoff's
factual claims ABOUT THE CODEBASE — a line number, a field or column
name, a selector, a function, a section of a spec — are checkable at
source, and Arch's side of the rule is to check them before writing
them. CC is therefore both licensed and OBLIGATED to bounce an
instruction whose factual claims were not checked at source, exactly the
way it bounces unpedigreed UX: build what is verifiable, put the
unverifiable claim in OPEN QUESTIONS, and say which claim failed the
check and what the source actually says. Building on a claim that turns
out not to describe the repo is the same defect class as building
uncited UX — the fact that an architect asserted it is not evidence.

### Evidence classes (Aug 9 — output parity is PDF-only)
Plain version: comparing printed output between v1 and v2 requires PDFs
on both sides; screenshots only prove what a screen looks like.
All v1↔v2 OUTPUT-parity evidence — anything comparing printed or
exported output between the two versions — is print-to-PDF, at 100%
scale, on matching paper size and orientation on BOTH sides of the
comparison. Screenshots remain valid for on-screen UX anatomy only
(layout, controls, dialog anatomy as rendered in the interface). A
screenshot of printed output is not parity evidence — treat it as an
unestablishable pedigree: OPEN QUESTIONS, request the PDF.

### Response quality (no first drafts)
Never deliver first-draft work. Before every internal checkpoint and
every handoff file, critically review your own output from these
perspectives — and fix what the review finds before proceeding:
correctness (does it do what the unit's rulings say); evidence fidelity
(does every UX surface match its cited pedigree); regression surface
(what existing behavior could this touch — run the gates); guardrail
compliance (frozen layers, guarded units, the standing "never" rules in
this file). The loop bound stays: max 3 fix-and-recapture iterations
per checkpoint, then flag with a diagnosis.

### Internal checkpoints (self-gating for long runs)
At every internal checkpoint of a unit-scale run: the full gate set
(test suite · frozen gate · visual gate) PLUS the standing browser
smoke against a THROWAWAY project (created and destroyed in-run; the
visual-gate fixture is never written outside a declared baseline
event), results verbatim in RAW OUTPUT. Multi-ruling passes keep the
July-18 mid-build checkpoint discipline.

### Multi-Leg Run Pattern (Aug 9 — standing; memorialized from the S3-G run)
Plain version: legs are planned disjoint up front, each leg gates and
documents itself before the next, commits land in leg order, and
Daniel's browser gates batch by how risky the leg is.
- **Step 0 — disjoint-footprint map, before any leg builds.** Enumerate
  every leg's file footprint and prove the footprints disjoint; where
  files are genuinely shared, declare them and the leg ordering that
  protects them. No map, no run.
- **Full machine gate set per leg** — build · strict typecheck · frozen
  gate · visual gate · guarded-code grep · dependency gate — run at each
  leg's close, never deferred to end of run.
- **Per-leg boundary files.** Each leg closes with its own boundary file
  (DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT, scoped to that
  leg) at the Return Handoff Protocol's fidelity bar.
- **Serial commits.** Commits land in leg order; a leg's commit is in
  before the next leg's commit lands. (Which legs share a commit is a
  per-run Arch/Daniel scoping call; seriality — never interleaving or
  reordering — is the standing rule.)
- **Context-budget handover license stands.** Legs within one unit may
  split across CC sessions when the context budget requires; the
  boundary file is the handover artifact, and the incoming session reads
  it before building.
- **Daniel's browser gates batch by risk class:** plumbing legs (no UX
  surface) batch to end of run; UX-surface legs gate BEFORE the next leg
  builds on them.

### Standing gates and guarded surfaces (restored Aug 9 — relocation remediation)

- **Guarded units — never build, wire, stub, or "prepare" without their own
  Arch-designed handoff:** the Auto-fill write cascade (confirm dialogs,
  default fills, sibling propagation); Print/PDF + revision snapshots; the
  CSV/Excel import ENGINE (button + disabled state exist; engine is guarded).
  (**Change All: BUILT Aug 4–7 via the sanctioned GS-A/E-CA Arch handoff —
  live on all five list surfaces, removed from this list; see the GS-A / E-CA
  section above. The two `25b2993` placeholders were unguarded by that
  handoff, not drift.** **Split: BUILT
  July 20 via Arch handoff — SP-1..SP-9 + SP-1a/SP-7a, commit `98cbf67` —
  removed from this list; the split architecture of record is below, and its
  files are now normal editable code under the standing gates.** Methods
  merge/reassign: BUILT July 16 via Arch handoff — MRG-1..6, `merge_methods`
  RPC live — removed from this list; the Change All TOOLBAR BUTTON entry
  above remains guarded and unchanged.) Encountering one =
  the Operating Contract's "beyond the task as scoped" hard-stop.
- **The autocomplete ↔ Auto-fill seam:** library auto-appear as built = a bare
  single-row, case-insensitive-deduped insert on model commit. Everything richer
  stays behind the existing TODO call-site and lands with the guarded Auto-fill
  handoff.
- **Standing machine gates for any run (Tier A):** build clean · strict
  typecheck clean · frozen-layer gate as defined above · no guarded code (grep
  the diff) · dependency gate: `git diff <baseline> -- package.json
  package-lock.json` shows nothing beyond the ruled-in `playwright`
  devDependency (any other change = hard-stop for Daniel's ruling) · nothing
  staged, no commits before Daniel's terminal confirm phrase (WF-1a) —
  Daniel owns the commit checkpoint, and the phrase authorises
  stage → verify → commit → **push** as one step, LIVE — the dependency
  that used to gate it lifted (FENCE-PUSH, 2026-08-30, Daniel's ruling).
  See Commit authority below; the push is a production deploy.
- **Visual work additionally self-verifies via the Visual-Capture Harness**
  (section above) before any handoff file is written.

### Proceed without asking (rubber-stamp authority)
On work that is reversible, local, and already in scope for the task
Daniel gave you, just do it — do not stop to ask "confirm I can make
this." This includes: creating/editing the files the task obviously
requires, picking the clearly-better implementation (data structure,
naming, file layout), behavior-preserving refactors, and writing/running
the build or test commands needed to verify your own work. Batch any
genuine confirmations into one place at a natural checkpoint rather than
interrupting per step.

### Hard-stop and ask first (never proceed autonomously)
Stop and get explicit confirmation before:
- **Destructive or irreversible ops** — deleting data, force operations,
  history rewrites, anything not cleanly undoable.
- **Data/security/signal-path boundary** — changes to core data
  structures, schema, API contracts, RLS policies, grants, or the
  WebSocket / audio signal-path protocol. (Mirrors arch Milestone
  Trigger B.)
- **Ambiguous or conflicting evidence** — a Parity Rule pedigree that
  cannot be established, or an evidence conflict the hierarchy does not
  resolve. OPEN QUESTIONS, never a silent call.
- **New feature or major flow** — anything beyond the task as scoped.
  (Mirrors arch Milestone Trigger A.)
- **Third repeated attempt** — if the same issue has failed 2 prior
  fixes, stop; do not try a third patch off error-text guessing.
  (Mirrors arch Milestone Trigger C.)
- **OS-level permission or OAuth dialog trigger** — any action that
  would surface a macOS/OS permission prompt (Accessibility, Automation,
  Screen Recording, Microphone, Keychain, TCC-protected resources of any
  kind) or an OAuth/consent screen is a hard-stop, full stop. This is not
  mirrored to an arch Milestone Trigger — it stands alone because it is
  the one category where the actor requesting the permission (CC) is not
  the person who can meaningfully consent to it. Recognize this by the
  **class of action**, not by reasoning about whether permission is
  probably already granted or the request seems harmless because the app
  is "already in use" — that reasoning is exactly what fails here. Stop
  *before* running the command that would trigger the dialog, not after
  it appears.
- **A `.git/index.lock` with no git process behind it** (Arch Prompt v30,
  Aug 14 install) — do NOT read it as stale and clear it. It may belong
  to a CONCURRENT Cowork-seat session: the Cowork mount denies unlink,
  so even a `git status` run there orphans a lock that no local process
  explains. Halt, say plainly that a lock is present and that another
  seat may hold it, and wait — removing it is never CC's call. This is
  what round 3 of B4 hit on Aug 13.
- Anything touching credentials, secrets, money, or access control.

### Report plainly (so a session relays in two pastes, not twenty)
- State what you did and the single checkable result. No preamble, no
  restating the task back, no narrating intermediate steps.
- Raw Output exception stays in force: when asked to run a command and
  show output, paste every line verbatim — do not summarize. Source
  correctness is provable by build; reserve verbatim/screenshot
  discipline for command output and diffs.
- One task, one clear stop condition. If you hit a hard-stop item,
  surface it in one plain line and wait.

### Stream-edit disclosure — the Sed Disclosure Rule (July 23; SCOPE WIDENED Aug 13)
`sed -i` (and any in-place stream editor: `perl -i`, `gawk -i inplace`)
is PERMITTED for mechanical multi-site edits, under a disclosure
obligation. Bundled-flag forms (`perl -pi`, `-ni`, etc.) ARE in-place
stream edits under this rule and under the bash-fence (matcher tightened
July 31 — the `-pi` evasion is closed); single-file edits go through the
Edit tool, no exceptions. Bash writes bypass the PostToolUse frozen-check hook, and a
regex can match wider than intended — the risk is opacity and breadth,
so every in-place stream-edit command carries a SED LEDGER entry in the
handoff file, pre-commit:
  1. The verbatim command (Raw Output fidelity).
  2. Plain-language intent — what the change is, and why a stream edit
     over the Edit tool (legitimate: one mechanical pattern across many
     call sites; illegitimate: convenience on a single file — use the
     Edit tool for those).
  3. Measured scope, proven not asserted — `git diff --stat` verbatim
     IMMEDIATELY after the command, plus the diff hunks for every file
     where the match count is low or the change is non-mechanical.
  4. Frozen assertion — the command did not touch a frozen-layer file
     (the bash-fence blocks in-place editors against those files;
     state it anyway), and the frozen gate
     (`node scripts/frozen-gate.mjs`) ran IMMEDIATELY after the sed
     batch — never deferred to the checkpoint. Paste its output.
Arch evaluates the ledger before Daniel commits any sed-touched
change — an unledgered stream edit is an UNCOMMITTABLE change, the same
defect class as a FILES CHANGED mismatch.
**Enforcement note (July 24):** two consecutive passes carried
self-flagged single-file stream edits. The self-flag is honest but does
not substitute: single-file edits go through the Edit tool, no
exceptions — from here, a single-file stream edit is itself a handoff
defect, disclosed or not.
**SCOPE WIDENED (Aug 13) — the rule is about the MECHANISM, not the
tool's name.** This rule now covers **any bash-mediated write to a repo
file**, not only in-place stream editors: a `python3`/`node` heredoc that
reads-modifies-rewrites a file, a `cat > file` or `>>` redirection, a
script that rewrites paths in bulk — all of them. The reason the rule
exists is that **a bash write bypasses the PostToolUse frozen-check
hook**, and that is true of every form above regardless of what the
binary is called. So: same SED LEDGER entry, same four items, same
frozen gate immediately after, same single-file prohibition (one file =
the Edit tool, always).
*Origin of record:* on Aug 13 a pass disclosed a `python3` heredoc used
for multi-site edits — unprompted, with a single-match assertion per
pattern and an immediate frozen gate — on the reasoning that a bash write
bypasses the hook even though the rule as written named only stream
editors. That disclosure was **correct judgement and is explicitly NOT a
discipline strike**; it proved the RULE was underspecified, and this
paragraph is the fix. Disclosing something the letter of the rule does
not require is always the right call.

### Commit authority (Aug 9 — WF-1a PILOT, supersedes WF-1's stage/commit clauses; the PUSH clause amended Aug 26 and LIVE since FENCE-PUSH, 2026-08-30; sunset review at Sprint 4 close, alongside the auto-mode rider)
**Plain version: CC may stage, commit AND PUSH — but only after Daniel types the
confirm phrase in the terminal.**

> **⚠ IN EFFECT since FENCE-PUSH, 2026-08-30 (Daniel's ruling). The push half is
> no longer forward-dated.** Both enforcement layers were NARROWED — not
> removed — in that unit: a bare `git push` is permitted, and the destructive
> family (force in any spelling, a leading `+` on a refspec, `--delete`/`-d`,
> `--mirror`) stays blocked in both. **A push under this authority is a
> PRODUCTION DEPLOY**, because Vercel builds every push to `main`; the confirm
> phrase therefore approves a release, not just a commit. What is narrowed is
> described under "Enforcement" below.
>
> **A session that has not restarted since a `.claude/settings.json` change is
> testing a stale config** — settings are read at session start. That is a
> property of the harness, not of this ruling, and it applies to any future
> settings edit the same way.
- **The phrase gates everything.** CC stages and commits ONLY after Daniel
  types the confirm phrase in the terminal for THIS commit: the phrase is
  **`COMMIT APPROVED: <first words of the commit subject>`** — subject-bound:
  it must quote the drafted subject's opening words; a bare "COMMIT APPROVED"
  approves NOTHING (the stale-approval class). No phrase, no stage, no commit.
  The phrase is per-commit, never standing; a green gate, a passed browser
  gate, or "looks good" in conversation is never the trigger. If a handoff
  implies commit authority without the phrase flow, that is a handoff defect —
  flag it.
- **Sequence on the phrase:** stage by explicit filename (never `-A`,
  never a bare directory; double-quote bracketed paths) →
  `git status --short` and verify the staged set exactly matches FILES
  CHANGED (any mismatch: stop, report, do not commit) → `git commit`
  with the drafted message → **`git push`, the bare form only** (FENCE-PUSH,
  2026-08-30, Daniel's ruling) → the `_CLOSE.txt` artifact. **If the push
  refuses, report it plainly and stop** — never retry it in another shape; a
  push that half-works is worse than one that is blocked.
- **THE PHRASE NOW COVERS THE PUSH (Daniel, 2026-08-26) — one step, not two.**
  `COMMIT APPROVED: <first words>` authorises **stage → verify → commit →
  push**. Subject-binding is unchanged, a bare approval still approves nothing,
  and a green gate is still never consent.
  **State the consequence rather than leaving it inferable: a WF-1a commit is
  now a production DEPLOY**, because Vercel builds on every push to `main`. The
  browser gate that precedes commit approval is therefore the last check before
  live, not before a staging step.
- **The `_CLOSE.txt` artifact.** After a SUCCESSFUL PUSH, CC writes
  `handoffs/from-cc/YYMMDD-hhmm_<unit>_CLOSE.txt` — **plain text, not Markdown,
  so it pastes anywhere.** Contents: unit · commit hash and `<before>..<after>` ·
  file count · pushed state **read from the ref files, never from `git`** ·
  measured counts (suite, typecheck, frozen, visual, dependency) · what closed ·
  what stays open and who owns it · what is owed by Daniel. Written whether the
  unit ends clean or partial. **Every number in it is a measurement or it is
  not written.**
- **Enforcement — what the two layers block NOW (FENCE-PUSH, 2026-08-30,
  Daniel's ruling).** The deny list lifts `git commit`, explicit `git add` and a
  BARE `git push`; bulk staging (`-A`/`--all`/`.` and `commit -a` variants)
  stays fence-blocked, and so does every destructive form of push. **This was a
  NARROWING of the fence, not its removal**, and both layers carry it:
    · `.claude/settings.json` — `"Bash(git push)"` in `allow` (the bare form
      only, no wildcard); `"Bash(git push --force*)"`, `"Bash(git push -f*)"`,
      `"Bash(git push --delete *)"` and `"Bash(git push --mirror*)"` in `deny`
      (`:6`, `:22-23`).
    · `.claude/hooks/bash-fence.sh:50-52` — the composition-aware
      `git[[:space:]]+push` matcher is now TWO conditions in the shape of the
      `commit -a` matcher above: a push must be present AND a destructive token
      must be present. It exits 2 with *"destructive git push (force /
      +refspec / --delete / --mirror) is human-only."*
  **Anything in between — `git push origin main`, a refspec, another remote — is
  neither allowed nor denied and falls through to a prompt. That is deliberate:
  routine work needs the bare form, and anything else deserves a human's eyes.**
  **The battery is what proved the narrowing, not the diff:** 34 cases against
  the installed hook, and a control run against the pre-lift hook that differed
  in exactly one case (`git push`) and agreed on all the others. **Test the
  guard; do not read it** — two holes were found in this fence in three days
  (FENCE-COMMITA's `-av`/`-avm` false negative, and FENCE-HEREDOC), and the
  ruled list of forms to block was a description, not a specification: `-d` and
  the `-fv`/`-vf` cluster forms were added beyond it because the battery, not
  the prose, is the authority. **FENCE-HEREDOC is still OPEN** — a
  `python3 - <<'EOF'` that rewrites a file is still unmatched by this hook; it
  was consciously left out of FENCE-PUSH and needs its own scoping.
  **Any future change to `.claude/settings.json` requires a session RESTART
  before its behaviour can be tested or reported**, because settings are read at
  session start — testing a new file against a stale config and reporting the
  result as the new behaviour is the defect this line exists to prevent.
- **No-trailer rule (standing) — now hook-enforced:** the
  `.claude/hooks/commit-msg` hook rejects any commit message carrying
  `Co-Authored-By` or any other trailer; subject + body only. The
  drafting discipline is unchanged — never draft a trailer into a
  commit message; the hook is the backstop, not a license.
- **Unchanged from WF-1:** Arch never commits; Daniel's browser gate
  precedes any commit approval; commit messages follow the repo's
  existing style.
- **RETIRED by FENCE-PUSH (2026-08-30, Daniel's ruling):** the rule that CC
  never pushes and that Arch delivers the push as its own paste block. **CC
  pushes now, on the phrase, as step 4 of the sequence.** What survives it is
  the discipline underneath: checks and Daniel-run pastes never share a paste.
- **Pilot sunset:** reviewed at Sprint 4 close alongside the auto-mode
  rider — continue, revise, or revert to WF-1.

### Fork rule (G1 — standing, GS-A window Aug 4–7)
Recon forks are READ-ONLY. A fork that builds anything must disclose it
immediately; the only salvage path is a full hunk review PLUS a complete
re-gate, under an explicit Arch/Daniel decision — build output from a
recon fork is never silently merged.

### Print doctrines (Aug 7–9 — standing, product-wide)
- **PRINT FONT PARITY (standing law):** every print output renders
  point-true font sizes matching its v1 exemplar, proven by MEASUREMENT
  at its gate — never eyeballed. Applies to all nine S3-G outputs +
  equipment print, and joins the gate set for every future print
  surface.
- **@page uses EXPLICIT DIMENSIONS** (`size: 11in 8.5in` /
  `8.5in 11in`), never the `landscape`/`portrait` keyword — Chrome's
  interactive print path drops the keyword (root-caused twice: the
  @media-print nesting, then the keyword itself).
- **Print-verification honesty rule:** print orientation/size is NEVER
  evidenced by Playwright `pdf()` or headless `--print-to-pdf` alone —
  the interactive Save-as-PDF dialog is a different renderer, and
  Daniel's desk is the renderer of record. Claiming parity off the
  wrong render path is the amend-3 defect class; do not repeat it.
- **Evidence commits STAGE BY DIRECTORY:** exotic filenames (the Aug-7
  U+202F clipboard failure) never travel in pasteable blocks —
  directory staging is the standing workaround.

### Permission mode (July 23 rider — expires at Sprint 4 close)
Daniel runs CC in AUTO permission mode through the end of Sprint 4
(risks acknowledged and overruled by Daniel — too many technical
pauses). Auto mode changes PERMISSION prompts only. Every behavioral
rule in this contract binds unchanged: the hard-stop list, the WF-1a
commit rules (phrase-gated stage/commit/push — the push now CC's, and a
production deploy: FENCE-PUSH, 2026-08-30, Daniel's ruling), the Raw
Output Rule, the Parity Rule, the
Sed Disclosure Rule. At Sprint 4 close this rider expires and CC
returns to accept-edits / standard operation before active projects
live in v2.

### Standing instructions
- Read repo files via the Read tool, not sed/cat in bash. WRITING via
  `sed -i` (or any in-place stream editor) is permitted ONLY under the
  Sed Disclosure Rule (Operating Contract above); frozen-layer files
  are fence-blocked from in-place editors entirely.
- Hook files delivered by Arch and saved by Daniel lose their execute
  bit (July-24 incident of record: `bash-fence.sh` silently dead —
  every PreToolUse ran unfenced until the terminal noise was spotted).
  After ANY hook-file placement: `chmod +x .claude/hooks/*`, and if
  a "Permission denied" hook error appears in the transcript, flag it
  immediately — it means the fence is offline.
- Arch handoffs carry `Tier:` and `Session:` lines. Session:
  CONTINUE = execute in the currently open CC session; Session:
  FRESH = open a new session first (the handoff states why). Session
  line absent → ask before proceeding.
- Frozen byte-gate: `node scripts/frozen-gate.mjs` (reference be0769de,
  three regions, nonzero exit on failure).
- **Session pre-open Vercel check (VERCEL-CLI, Aug 10):** run
  `node scripts/vercel-preopen.mjs` at every session pre-open — it queries
  Vercel's REST API directly (no Vercel CLI; the machine's npm prefix is
  read-only) with the project-scoped token at
  `~/.config/minotaur/vercel_token` and prints the latest production
  deployments. LATEST must be READY before any build work (exit 0 = READY;
  exit 1 = not-READY). Exit 2 = token missing/expired → Daniel recreates the
  token (project-scoped, `minotaur-v2` only, 90-day expiry, file at
  `~/.config/minotaur/vercel_token`, chmod 600). The script never prints,
  logs, or commits the token. Replaces the prior Daniel-screenshot pre-open
  step (no CLAUDE.md line previously existed for it — this is the first
  written record).
- Visual baselines — adopted set current at the **S4-3 leg-6 close**: frames
  04/05/06 pairs @ the checkpoint-A nav commit `d35cc04` · frame-01
  pair @ the leg-2 rider-A commit `043ce39` · frame-07 pair @ `40aa945` (the
  EP-P1 fixture event) · the frame-14 pair
  @ the leg-4 commit `23a34d6` (leg 4's declared event: the Box List toolbar's
  "Edit Box Types" link, the Boxes menu card's Box Types entry enabled, the Box
  Types admin ADDED as frame 14) · **frames 09/10/11/12/13 pairs @ the leg-6
  commit** — leg 6's declared event (2026-08-19), `screenshots/declared-event.json`:
  the Box List page header's nav pill row (Box Types · Print Box List · Print
  Contents Lists · Box Labels — bbox 904,57–1583,83, identical on 09/10/11/12
  because all four stage the same page) and the Boxes menu card's five print
  entries going from disabled to live (bbox 682,246–1192,351). 10 written, 18
  deliberately not written; the write REFUSED once on rule 1 — a whole-frame
  `06-settings-dark` theme-race flake, byte-clean minutes earlier — and wrote
  nothing, which is the protocol working. This supersedes `23a34d6` for
  09/10/11/12/13. · **frames 02/03/08 pairs @ the leg-5 commit**
  — leg 5's declared event (AMEND-1, 2026-08-18), `screenshots/declared-event.json`:
  the R-7 Box-Error yellow on the equipment list's Box cell (the 80px `w-20`
  column, x≈1174–1253) — the project-wide arm (Daniel, 2026-08-19: the yellow
  arms whenever the project has ANY boxes) makes the fixture's four seeded boxes
  arm it, and all five generic items are unboxed, so every Box cell wears the
  fill (7200 px on 02/03, 2880 px on the two found rows of 08; Δ101 light / Δ93
  dark). 6 written, 22 deliberately not written, first try, no refusal. This
  supersedes `d35cc04` for 02/03/08. **28 frames**, confirming gate 28/28 at
  exactly 0.0000%, clock-pinned (frames 01/07/13).
  **Flake (2)'s registry entry was one frame too narrow** (leg 6): it named
  `04-library-dark`, but the identical whole-frame theme-race signature fired
  on `06-settings-dark` during leg 6's first write attempt (1451200 px, max
  Δ207, bbox 0,93–1599,999) after that frame had been byte-clean minutes
  earlier. **Leg 6's fix — "a dark frame", not "frame 04" — was itself too
  narrow, and is SUPERSEDED (2026-08-30):** the same signature fired on
  `06-settings-`**`light`**. Read the registry entry, which now carries the
  invariant: 1451200 px at bbox 0,93–1599,999, either half of any frame.
  **The 08 restore-don't-adopt rule and the same-run restore rider are RETIRED**
  with the mechanism they guarded (HARNESS-H2, harness section below): an
  undeclared frame is never written, so there is nothing to restore. Leg 4's
  event proved it — 16 undeclared frames were left byte-identical and the run
  printed both lists.
  **The `GATE_DIFF_THRESHOLD_PCT=0` emit/write workaround is RETIRED
  (HARNESS-H4, 2026-08-15) — the tool judges the moved set itself.** The
  history, kept because the defect class recurs: the moved set is classified by
  `diffPercent > DIFF_THRESHOLD_PCT`, so at the old 0.1% default a real change
  of up to 0.0999% printed PASSED and was classified "still" — leg 4's own
  event had NINE such frames (0.0389–0.0504%), and a declaration emitted at the
  default would have left their baselines silently stale. Leg 4's remedy was to
  run the emit and the write under `GATE_DIFF_THRESHOLD_PCT=0` by hand. **H4
  made ZERO the default**, so a plain `--gate --emit-declaration` and a plain
  `--update-baselines --declare` now measure at the same tolerance the humans
  were applying, and the confirming gate runs at that default too. The env
  override survives unchanged for anyone who needs to widen it deliberately.
  **The classification sites, corrected — the old citation of
  `visual-capture.mjs:685` was wrong** (that line is the `WRITTEN (…)`
  console.log). The moved set is judged at four places, and they move together:
  `:705` (`emitDeclaration`) · `:639` (`printClassification`'s MOVED/still
  column) · `:822` (`runGate`'s PASS/FAIL verdict) · `:663`, passed as
  `judgedThresholdPct` into `classifyFrames`, where it drives rule 1
  (`declaredEvent.mjs:197`) and rule 2 (`:234`). Line numbers are as of the H4
  close; check them at source before citing them again.
  **A declared event's scope is measured, not reasoned (AMEND-3):** the handoff
  predicted "frame 10 only" from which frame is NAMED for the panel; the
  measurement found all four box frames carry it. Enumerate the frames a change
  is in-frame for by measuring, before writing the scope into a handoff.
- Run git from the repo root, never via `git -C`. Run allowed read-only
  commands as separate invocations rather than `;`-chains when a
  prompt-free pass matters.
- **Theme mechanism of record (July 16):** theme-dependent colors are
  published as `-light`/`-dark` CSS-var pairs selected by `.dark` scope
  rules (band-amendment pattern). Never reintroduce a runtime theme-mode
  hook for color selection; `useThemeMode` was deleted July 16 with cause.
- **Visual gate environment (July 16; interpretation revised July 19):**
  `devIndicators: false` in next.config.js is load-bearing for the visual
  gate — do not remove. **Gate interpretation rule (July 19, supersedes
  the July-18 frame-01 drift rule):** both live-date surfaces are
  clock-pinned in the harness (frame 01 menu stamp → "v 1/1/26"; frame 07
  print footer → "1/1/2026 12:00p"), so NO frame carries an expected
  drift. **Every frame must be exactly 0.0000% — any nonzero diff
  anywhere is stop-and-report.** That intent is unchanged; what changed
  (HARNESS-H4, 2026-08-15) is that it is **MACHINE-ENFORCED** rather than a
  human's to remember. The gate's pixel threshold now defaults to ZERO, so a
  single judged pixel FAILS the frame — there is no longer a 0.1% band in which
  a real change prints PASSED and a reader has to catch it by hand. The rule no
  longer reads "regardless of the gate's threshold", because the gate's
  threshold now IS the rule.
  The harness pixel-diff's channelThreshold 24 is the diff definition of
  record (absorbs sub-threshold rasterization noise) and **H4 did not move
  it** — zeroing the PIXEL count is not the same as zeroing the CHANNEL
  tolerance, and lowering channel-24 would make SUBPIXEL-WANDER live. That is a
  comparator redesign and belongs to H3. Strict-zero CHANNEL probing remains
  diagnostic-only, never a gate criterion.
  Known baked-in defect: frame 08 (find-active) captures the find strip
  with its light-mode-tokens-in-dark-theme defect (punch (ggg)) — the
  eventual token fix will legitimately diff frame 08 and rides that
  unit's baseline event.
- **Checkpoint discipline (July 18):** single-ruling units run one EXIT
  checkpoint. Multi-ruling passes run the mid-build checkpoint after the
  named subset is implemented, BEFORE continuing — running both
  checkpoints post-hoc against the finished diff defeats the early-catch
  purpose and is non-compliant.
- **Types regen: CURRENT @ commit 9d9e7d8** (July 23 — covers
  `merge_methods`, `mark_remaining`, and the Sprint-3 cable schema).
  The `db:types` script is truncation-proof (`/tmp` + `[ -s ]` guard).
  Re-run after every migration; commit the generated file promptly.
  **REGEN OWED: DISCHARGED at `769b84e` (S3-G Leg 0, 2026-08-07).** The regen
  brought `projects.equipment_sort_mode` + `cover_letters.signature_data` into
  the generated types and dropped all three postdated-column `as never` casts
  (the sort-mode persist write + the cover-letter upsert pair); the workbook
  `import_sort_order` plan key carried no cast by construction (a jsonb plan
  key read by the RPC's coalesce, not a typed column write). Zero `as never`
  casts remain in src (grep-proven in the Leg 0 handoff).

## Reference material — docs/reference/ (pointer, not payload)

Detailed UX/behavior specs live in `~/Developer/Minotaur/docs/reference/`;
curated screenshots in `~/Developer/Minotaur/screenshots/`. Do NOT assume
their contents — open the specific file when a task needs it. These catalogs
span the whole product, guarded units included; pull the sections your
current task covers, not the whole file ambiently.

**Evidentiary hierarchy (every build decision):**
- **Zite** = UX benchmark — speed / feel / interaction target.
- **v1 (FileMaker)** = functional truth — what the operation must actually do.
- **Lovable** = reference-only — framework/schema mismatch (TanStack Start,
  non-unified `equipment` table). Corroboration, never a build target.

Zite-vs-v1 conflict: Zite wins on *feel/interaction*, v1 wins on
*function/workflow*. A conflict that doesn't resolve on that split is a flag
for Daniel, not a silent call.

**Files:**
- `Minotaur_Shell_Visual_Reference.md` — **start here for the shell run**;
  frame→unit bindings + the states the frames don't show.
- `Minotaur_Zite_UX_Catalog.md` — benchmark. Equipment List = View 2.
- `Minotaur_v1_UX_Catalog.md` — functional truth. Delta index D1–D9;
  guarded-unit detail (Split D3, Change All D2, Auto-fill D1, Print D5) —
  out of fence for the shell run.
- `Minotaur_Lovable_UX_Catalog.md` — reference-only.

Screenshots: Zite `.png` set = shell feel targets; v1 `.jpg` set =
guarded-unit reference, held until those handoffs.

Parity target: /docs/reference/Minotaur_Parity_Spec.md — Daniel-ruled
build-against spec for the Sprint 2.5 shell remediation (read fully before
any shell work).

## Visual-Capture Harness (relocated 2026-09-08 — full text in `docs/reference/visual-capture-harness.md`; pointer, not payload)

The repo carries a Playwright visual-verification harness. **Any session doing
visual/UI work MUST self-verify with it before writing a handoff file.**

- **Run:** `node --env-file=.env.local scripts/visual-capture.mjs` (reuses a
  running dev server or spawns one; approval-gated under the harness `node`
  ask-rule).
- **Fourteen surfaces × light/dark = 28 frames** (`EXPECTED_CAPTURE_COUNT` 28).
- **Diff definition of record:** `scripts/lib/pngDiff.mjs`, pure Node,
  `channelThreshold 24`.

⚠ **OPEN `docs/reference/visual-capture-harness.md` BEFORE any gate run, any
baseline declaration, and any edit to `scripts/visual-capture.mjs`.** It carries
the frame inventory and each frame's staging (including why frame 13 keeps its
staging neighbourhood and why frame 14 follows the Equipment restore), the
declared-baseline-event procedure, the capture-flake register, the rules governing
`screenshots/diff-exceptions.json`, and the load gate. **Do not assume its
contents and do not reconstruct them from memory — only the file describes the
file** (the Surface Rule).

*(Relocated because `CLAUDE.md` had reached THREE characters of its
150,000-character limit — CLAUDEMD-ATLIMIT — and a file over the limit loses its
TAIL. Same move and same reason as the Guarded Architectures Index on 2026-08-09.
27,136 characters of standing infrastructure that no unit edits and every gate run
consults is payload, and payload belongs in `docs/reference/`.)*

## Project state — durable truth (schema + rulings)

### Rulings of record
- **New-record placement (July 16; IMPLEMENTED July 18, commit 4fd1695;
  release timing amended July 19, sort unit — (ddd) CLOSED):**
  new equipment records insert below the active record's model group
  (v1 behavior), scrolled into view, cursor in Model. Mechanism of
  record: render-anchoring (`src/lib/equipment/newRecordAnchor.ts`) —
  the pending record's band is pinned after the anchor group in the
  grouped render regardless of comparator order. **Pin release (July 19,
  S-7): a `releasePin()` closure runs on EVERY exit path of the Model
  band commit handler. Non-cascade paths (blank commit, pristine commit,
  no-target early return, cancel) release immediately. The cascade path
  releases in a `finally` AFTER `await runModelSaveCascade(...)`, with
  `setPendingFollowId` set in the same synchronous block so React batches
  them — the band lands at final comparator position and focus follows in
  ONE paint. Never move the release back before the cascade (that was the
  (ddd) double bounce); never let any commit path exit without releasing
  (a phantom anchored band never re-sorts).** The follow-after-settle
  effect keeps the record active with focus in Quantity. Flat-array
  position does NOT control render position — never reintroduce an
  insertion-index/splice approach.
- **Sort architecture of record (July 18–19, sort unit — S-1..S-6; do not
  undo or fork in later passes):**
  - `src/lib/equipment/sortChains.ts` is the ONE chain module:
    `compareLabels` (empty/null LAST; otherwise localeCompare
    `{ numeric: true, sensitivity: 'base' }`) +
    `makeEquipmentChainComparator(mode, methodRankByName)` carrying the
    four ruled chains —
      category: category→model→method→description→group ·
      method: method→category→model→description→group ·
      box: box→category→model→method→description→group ·
      group: group→category→model→method→description.
    Category term = `category_sort` rank nulls-last then label; method
    term = rank-map nulls-last then label; model term = `compareModels`;
    box/description/group = `compareLabels`. Returns 0 below the last
    term — JS stable sort makes the server Layer-1 chain
    (`category_sort → sort_order → created_at DESC → id DESC`) the
    persistent don't-care tiebreak. The server chain itself is untouched
    and export tests pin it (S-12 re-alignment rides the deferred export
    unit — do not "fix" the export comparator ahead of that unit).
  - Screen: `chainSorted` useMemo sorts `filtered` BEFORE grouping;
    grouping preserves push order. Band-label tiebreaks use
    `compareLabels`.
  - **`compareModels` (src/lib/equipment/modelSort.ts) is the ONLY model
    comparator on ANY surface** (screen bands, print sections, revision
    modelRows, library grid). **`nat` was DELETED from printEngine July
    19 — never reintroduce it or any parallel comparator.** Print's
    Zite-verbatim lexicographic option lists (print method dropdown,
    revisions-panel dropdowns) are deliberate, comment-marked survivals —
    leave them.
  - Pulldown band order (FLT-2, landed): category options by
    `category_sort` rank, method options by `sort_order` rank, group
    options by `compareLabels`; FilterDropdown sentinels stay first.
  - Rows re-rendering on genuine order changes is the B-6..B-9 memo
    working correctly — not a regression.
- **Toolbar delete semantics of record (July 19, S-10):** the Delete
  button is ALWAYS single-record (`requestDelete([currentRowId], …)`,
  disabled without a current row — it never relabels during a find). The
  Delete All button becomes "Delete Found (n)" during an active find and
  routes `requestDeleteFound()` (n = filtered.length); otherwise
  "Delete All (items.length)". Tooltips branch-follow. **The per-row ✕
  control and the entire onDelete prop chain
  (stableOnDelete → EquipmentItemRow.onDelete → ItemRowCells → button)
  were DELETED July 19 — never reintroduce a row-level delete control
  without a ruling.** ⌥⇧E remains delete-the-ACTIVE-record, untouched.
- **Filter / new-record semantics of record (July 19, FLT batch, commit
  1d1cf1a — D-1..D-8; do not undo or fork in later passes):**
  - `src/lib/equipment/newItemSeed.ts` is the ONE source of both the
    new-record insert payload (`buildNewItemSeed`) and the
    defaults-override condition (`isDefaultOverridden`). Never rebuild
    the seed inline in a component; never re-derive the override
    condition in JSX — both drift from the precedence table otherwise.
  - Precedence per field (D-2): a CONCRETE filter value beats the New
    Defaults bar (method/category resolved by name against the managed
    lists — null on no-match, NEVER invented or fuzzy-created; group
    seeds the string directly). FILTER_NONE seeds null, OVERRIDING a set
    default. FILTER_HAS / FILTER_ANY fall through to the defaults bar
    exactly as before the unit. `remaining_quantity` is never
    filter-affected. Sentinels import from FilterDropdown.tsx — never
    re-declare them.
  - New-record visibility exemption (D-5): BOTH `createNewItem` and
    `duplicateItem` grant the `exemptNewIds` exemption on
    `findActive || anyFilterActive`. Any filter CHANGE clears
    `exemptNewIds` at the onChange call sites (a filter change is a new
    view request, same as re-performing a find — never clear from an
    effect watching the values). Duplicate copies its source VERBATIM —
    no filter inheritance, ever. The Library "+ Add" insert path
    (`addToListPayload.ts`) is deliberately untouched by all FLT
    semantics.
  - `showAll()` = `displayAll()` + set all three filters to FILTER_ANY
    (D-4). Consumers: ⌥⇧J (registration gate is
    `findActive || anyFilterActive`), the FOUND-strip Display All, and
    the filter-bar conditional Display All button. FindPanel's ✕ Cancel
    stays on plain `displayAll` — the shared prop is wired
    `onDisplayAll={findActive ? showAll : displayAll}`, an exact
    behavioral split (the strip only renders while findActive; Cancel
    only fires while !findActive) with FindPanel byte-untouched. Never
    collapse the filter-clearing into `displayAll` itself.
  - The filter-bar "Display All (⌥⇧J)" button (D-1) renders ONLY when
    `anyFilterActive` — find-active is served by the FOUND strip's
    existing button. It renders NOTHING at rest; frames 02/03/08's
    zero-diff status depends on this conditionality.
  - Defaults-override affordance (D-7): the Method/Group default field
    wrappers dim to opacity-50 with a native `title` ("Overridden by
    active Method/Group filter") when `isDefaultOverridden(filterX)`.
    Dim + tooltip only — the inputs stay fully editable, never disabled.
    Mark All As Remaining never dims.
- **Keyboard semantics of record (July 18, slot 2 — commits 4fd1695 +
  6b882bc; do not undo in later passes):**
  - Enter in a row field (no modifiers, `data-equip-field`, non-textarea)
    = commit + advance to the NEXT RECORD, SAME FIELD (Zite-verbatim).
    Textareas keep real newlines.
  - An arrow-navigated autocomplete highlight + Enter = commit the
    highlighted option + take the TAB path (band editors → active
    record's Quantity; row fields → next field). Typed Enter (no arrow
    use) keeps the rules above.
  - ⌥⇧↑/↓ = record navigation, boundary-clamped, preserving the focused
    field — and preserving BAND CONTEXT when focus is inside a band
    editor (walks records staying in that band kind).
  - One navigation action sets BOTH `currentRowId` and `rowFocusRequest`
    together (Tab cross-record hop, Enter-advance, ⌥⇧↑/↓). The two
    states must never be updated independently by navigation code.
  - Every KEYBOARD-driven field entry selects the field's contents and
    scrolls the target `block:'center'` (within-row Tab scrolls only
    when the row isn't fully visible). Mouse-driven entry NEVER selects
    and never gets new scroll behavior.
  - Exactly ONE focus system fires per navigation event (rowFocusRequest
    OR the band-focus mechanism, never both).
  - Pristine band commits (value unchanged after the commit path's own
    normalization) are TOTAL no-ops — no cascade, no dialog, no write.
  - Every commit path that calls the frozen `updateItem` routes through
    `trackedUpdateItem` so `lastCommitRef` stays populated — new commit
    call sites must do the same (⌥⇧D and ⌥⇧I await it).
  - ⌥⇧E always means delete-the-ACTIVE-record; bulk deletion is owned by
    the Find panel and the toolbar's find-state "Delete Found (n)" form
    of the Delete All button (S-10 above).
  - `onTabOut`'s signature is `(rowId: string, direction: 'forward'|'back')`
    (July 18, Slot 3 pass 3) — the row passes its own id because the callback
    is one shared stable identity. New boundary callbacks follow the same
    id-as-argument pattern.

- **Row-render architecture of record (July 18, Slot 3 Hoisting Unit — commits
  e938759/15c84bd/9d59c8d/c5713c6; do not undo in later passes):**
  - `EquipmentItemRow` is memoized: `export default memo(EquipmentItemRow)`,
    DEFAULT shallow equality. **Never add a custom comparator** — if a prop
    defeats shallow comparison, fix that prop's identity at its source.
  - `InlineText` / `DescriptionField` / `Flag` / `ItemRowCells` are
    module-scope components in EquipmentItemRow.tsx. **Never define a React
    component inside another component's function body** — it remounts the
    subtree every parent render and discards edit-in-progress state.
  - Row-boundary callbacks are single stable identities via
    `useStableCallback` (src/hooks/useStableCallback.ts), defined once in
    EquipmentListClient component scope — **never reintroduce inline arrow
    callbacks at the `<EquipmentItemRow>` callsite.** Per-row data reaches a
    shared callback as an ARGUMENT (id-in, look the rest up from list-level
    state inside the callback), never via a per-row closure.
  - useStableCallback caveat (documented in the hook): a descendant invoking
    it from its OWN useLayoutEffect in the same commit may see the previous
    render's closure — safe only when the closure is behaviorally identical
    across renders (e.g. a bare state dispatcher). Audit any new such site.
  - Expected render footprint (prediction of record): a plain keyboard hop
    re-renders exactly 2 rows; a single-row edit re-renders exactly that row.
    A change that widens this footprint is a regression to flag, not a detail.
    Genuine ORDER changes legitimately re-render the moved rows (July 19).
  - **FLT note (July 19): the three FilterDropdown onChange inline arrows
    live on a non-memoized component outside the row system — they are not
    a B-6..B-9 violation. Do not "fix" them into useStableCallback wrappers
    unprompted.**
- **Supabase client identity (July 18):** EquipmentListClient's client is
  `const supabase = useMemo(() => createClient(), [])`. **Never revert to a
  bare per-render `createClient()`** — the frozen `updateItem`'s `[supabase]`
  dependency (and ~10 downstream useCallbacks) derive their identity
  stability from this one line. The frozen region's text is unaffected by
  this line; the frozen gate proves it.
- **Unmount-while-dirty safety nets (July 18):** the nets in InlineText,
  DescriptionField, ItemRowCells (Quantity), and AutocompleteInput are
  RETAINED deliberately post-hoist. #1/#2 are dormant belt-and-suspenders;
  the Quantity net is LOAD-BEARING (no Escape-revert affordance exists —
  registered punch). Do not remove or weaken any net without an explicit
  Daniel ruling.
- **Split architecture of record (July 20, slot 6 — SP-1..SP-9 + SP-1a/SP-7a;
  commit `98cbf67`; do not undo or fork in later passes):**
  - `src/lib/equipment/splitPayload.ts` is the ONE source of split arithmetic:
    `buildSplitPlan(sourceRaw, inputs, markAllRemaining)` returns a three-arm
    plan (`split` | `addInstead` | `invalid`). Never re-derive the split/add
    branch or the proportional-remaining math in a component. Remaining is v1
    proportional and CONSERVED (`newRem = min(n, max(0, round(R·n/Q)))`,
    source = R − newRem; null stays null). The SP-2 type guard (`generic`
    only) lives IN the pure module — a typed row returns `invalid` (a typed
    row's sidecar extension record wouldn't clone; reachable at Sprint 3).
  - **Over-split (n ≥ Q) is a SECOND dialog, not an in-place button flip**
    (SP-1a, v1 shape): `SplitDialog` → on n ≥ Q → `OverSplitDialog`
    (accent `brand-600`, the named primary; copy verbatim "You've Split Off
    More Gear Than You Have"). The second dialog's Cancel/Escape aborts
    entirely — NO write, NO return to the first dialog. `splitTarget` carries
    the stage (`'input' | 'overConfirm'` + preserved inputs); both confirm
    paths run one extracted `executeSplit` primitive. The forced-add reuses
    `buildSplitPlan`'s payload and overrides only `remaining_quantity` /
    skips `sourcePatch` — never re-derive the branch.
  - **SP-6 write order — insert-first, then decrement.** The decrement does
    NOT route through `trackedUpdateItem`: frozen `updateItem` swallows its
    own failure (catch reverts + flashes, never rethrows/returns), so
    compensation could never fire through it. The decrement uses the
    `propagateFieldToIds` idiom (optimistic patch, direct `.update().eq()`,
    revert + flash on error); on decrement failure the inserted clone is
    deleted (compensation) so a failure inflates the list visibly rather than
    shrinking quantities silently. **This is the observable-programmatic-write
    pattern of record.** Frozen `updateItem` is byte-untouched (the frozen
    gate proves it).
  - Placement: the split-off row has a committed model → NO anchor pin; the
    comparator places it (adjacent to its source in the model group).
    Exemption granted under find-or-filter (SP-4), same as `duplicateItem`.
  - Row control (SP-3): `EquipmentItemRow` gains OPTIONAL
    `onSplitRequest?: (rowId: string) => void` — id-as-argument, ONE
    `useStableCallback`, render-gated to `isCurrent && quantity > 1`,
    absolutely-positioned leading-edge glyph, zero layout shift (B-6..B-9
    compliant; `onUpdate` contract untouched). ⌥⇧S = a `KeyS` case in
    `useNavShortcuts` dispatching a per-route `onSplit` target. The equipment
    list registers `onSplit` → Split (this block). **The library route now
    registers its own `onSplit` → the Add-to-List dialog (BUILT July 20 —
    see "Add-to-List architecture of record" below); ⌥⇧S in the library is
    NOT a split — do not read it as one.** The per-route dispatch is one clean
    context switch over the shared slot, not two split implementations.
  - Post-split AND post-add focus lands in DESCRIPTION, selected, centered
    (SP-7a) — via the K-2 `currentRowId` + `rowFocusRequest` seam, no new
    focus path.
  - **Known gap (registered punch, low-priority):** the SP-6 compensation
    flashes `['quantity','remaining_quantity']`, but the Remaining cell has
    no `save-error-flash` wiring, so only the Quantity cell visibly flashes
    on rollback. Wiring Remaining touches the contract-fenced affordance
    surface — left unwired pending a Daniel ruling.
- **Add-to-List architecture of record (July 20 — AL-1..AL-11; commits
  `4ddde18` source + `7cdc698` baseline; do not undo or fork in later
  passes):**
  - **The (jj)-OQ2 follow-on is SUPERSEDED.** The old rule ("a library-added
    row is indistinguishable from a hand-typed new equipment row" — qty 1,
    project-default method, no note) is retired. A library add now carries the
    library note, a user-chosen quantity, description, group, private note,
    star, and a method OVERRIDE. Never restore the hand-typed-conformance rule.
  - `src/lib/equipment/addToListPayload.ts` is the ONE source of the add: it
    imports nothing from `newItemSeed.ts` or `splitPayload.ts` — a separate
    single-source seam, deliberately outside FLT/Split semantics. Two exports:
    `buildAddToListSeed(item, overrideMethodName, defaultMethodName)` → the
    dialog's initial values (note ← library `public_note`; method =
    `overrideMethodName || defaultMethodName`, NEVER the item's own
    `method_hint`); `buildAddToListInsert(projectId, values, categories,
    methods)` → the `equipment_items` insert (`type 'generic'`; category_id
    and method_id resolved by case-insensitive NAME match against the live
    lists, set-existing-only, null on no-match; `public_notes`/`private_notes`
    value-or-null; `group_label` trimmed-or-null; `quantity` passthrough,
    integer ≥ 1; `starred` passthrough). The write is a plain single insert
    through the existing browser client — NOT the SP-6 split write-pattern (no
    decrement, no compensation, no `propagateFieldToIds`).
  - **Quantity N = ONE row with quantity N** (AL-5, v1 truth), never N rows.
  - `src/components/equipment/AddToListDialog.tsx` is the v1-parity dialog on
    the ConfirmDialog/SplitDialog idiom (open-prop gate, window keydown while
    open, Enter = confirm, Escape = cancel; TEXTAREA target early-returns so
    Enter inserts a newline in Notes/Private Notes). Eight fields, v1 order:
    Category · Model · Notes · Quantity (focused+selected on open) ·
    Description · Method · Group · Private Notes · Star. There is NO
    "Hide Window on OK" control (AL-6, dropped). On insert error the dialog
    STAYS OPEN with an inline message; on success it closes.
  - **Method is an ADD-TIME OVERRIDE, not a grid filter (AL-3).** The dark
    action bar carries an "ADD WITH METHOD" select next to "+ New Item"
    (`addWithMethod` state, "—" = fall to project default, sticky across
    adds). The library grid's old METHOD *filter* was removed. Never
    reintroduce a library method filter, and never seed the add method from
    the item's `method_hint`.
  - **⌥⇧S in the library opens the Add-to-List dialog for the last-focused
    grid row (AL-11).** The current row is tracked in a REF
    (`currentLibraryRowIdRef`) set by ONE `onFocusCapture` on the grid scroll
    container via `.closest('[data-lib-row-id]')` — deliberately NOT React
    state: the library grid is ~2,330 unmemoized inline rows and a focus-driven
    state write would re-render all of them. Do not add per-row focus handlers,
    and do not convert the library row into the B-6..B-9 memo/hoist pattern
    (out of scope; left as an inline `sorted.map`). ⌥⇧S no-ops if the ref is
    null or the row no longer exists; no quantity gate (any library row is
    addable). The `onSplit` slot is shared with the equipment list's Split by
    per-route dispatch — same key, different action per route.
  - Cross-route scroll-to-matching (library↔list, model field selected +
    focused) is NOT part of add-to-list — **BUILT July 21 in (kk) leg C; see
    "(ss) cross-route landing architecture of record" below.** Do not fold
    landing logic into add-to-list code paths.
- **Category-fill on model change — architecture of record (July 20 — CAT-1..CAT-4; committed `859e44e`; do not undo or fork in later passes):**
  - **Category is NEVER overwritten on a model change (CAT-1).** On a Model-band commit, a record that already carries a category KEEPS it — the fill only ever populates a BLANK category (`category_id == null`). This is v1 D1 step 2 ("if Category is blank … silently fills it in") — functional truth. The "coverage extension" is a per-record blank-fill, NOT an overwrite. Never widen the fill to replace a set category.
  - **Silent — no prompt (CAT-2 / CAT-4).** Neither the edited record's own fill nor the sibling blank-fill shows a dialog. There is no category confirm prompt at all.
  - **"Change All" fills every affected BLANK sibling, and only those (CAT-3).** `src/lib/equipment/categoryFill.ts` (`selectBlankCategoryFillTargets`, pure) partitions the sibling set on a FRESH read of `equipment_items.category_id`; the new model's default category (`newCat`, resolved ONCE from the library, independent of the edited record's own blankness) is written to the blank ids via a SEPARATE scoped `propagateFieldToIds('category_id', …)` call. "Just this one" writes no siblings (the edited record still gets its own blank-fill through the frozen `updateItem` patch).
  - **Category does NOT ride the model+note sibling write.** The prior (jj) inheritance folded category into the model+note `propagateFieldToIds` patch — that was the clobber-or-skip bug (it overwrote SET siblings and skipped BLANK ones whenever the edited record was already categorized). Never re-fold category into that write; it is its own scoped pass.
  - **Known limitation (registered, not a defect):** the blank-fill is a third sequential DB write after the model+note write — the cascade's non-atomicity predates this (edited record + siblings were always two writes). A category-write failure after a model-write success leaves the model change in place and flashes a category save-error.
- **Model-band key is category-aware — architecture of record (July 20; committed `859e44e`; do not undo or fork in later passes):**
  - A model band's identity is the natural triple **`outerLabel␟category␟model`** (U+001F unit-separator joins — an invisible control char, collision-free vs. plain concatenation), produced by ONE shared pure helper `src/lib/equipment/modelBandKey.ts` (`modelBandKey(outerLabel, catLabel, model, fallbackId)`). Used at BOTH derivation sites — the render closure's `groupKey` and `resolveModelGroupKeyFor` — so nav-derived and render-derived keys are guaranteed identical. Every downstream consumer (`editingModelGroupKey` compare, the React key / `data-model-group` marker, `advanceBandEditor`, the ⌥⇧I toggle, the pending-new-record landings) inherits the key; do not hand-roll a band key anywhere.
  - **Never derive a model-band key from model text alone.** One model can legitimately sit under two category (or outer-group) bands at once — this is NORMAL under CAT-1's no-overwrite (a model group whose records carry different categories). A model-only key collides across the two bands and the model field goes CLICK-DEAD. The **outer-group label is REQUIRED** in the key, not just the category sub-label: in category-sort mode the category IS the outer group and the inner `catLabel` collapses, so a `catLabel`-only key still collides there.
  - **Blank model → falls back to the record's own id** (unchanged) — preserves the `wasPending`/`newRowId` new-row anchor semantics; the composite applies to the non-blank branch only. Do not composite the fallback.
  - **The three `data-model-group` `querySelector` consumers escape the key with `CSS.escape()`** (`scrollBandIntoView`, `selectBandEditorInput`, the `pendingBandFocusRef`/`tryFocus` effect) — the U+001F byte and any quote/backslash in label/model text would otherwise break the attribute selector. Keep the escape on the model branch.

- **Data-fetch architecture of record (July 21, (kk) legs A+B — commits
  `3914090`/`5c8a16d`; do not undo or fork in later passes):**
  - The app-wide data layer is TanStack Query. `src/app/providers.tsx` mounts
    ONE QueryClient (created in useState) wrapping the root layout; defaults
    of record: `staleTime: 0, retry: 1, refetchOnWindowFocus: false,
    refetchOnReconnect: false`. Never add focus/reconnect refetching — the
    app never surprise-refetches by design.
  - **`src/lib/queryKeys.ts` is the ONE source of every cache key** (pure,
    tested). Project-scoped reads key as `['project', projectId, '<read>']` —
    the `['project', projectId]` prefix is the family-invalidation handle.
    Shared reads share keys: `v_equipment_list` per project is ONE cache
    entry read by equipment, print, and revisions. Never hand-roll a key.
  - Page shape: page.tsx = thin server shell (awaits params/searchParams
    only) rendering a `'use client'` loader (`src/components/**/loaders/`)
    that runs one useQuery per read (browser supabase client from
    `@/lib/supabase/client`; query fns in `src/lib/queries/`, bodies moved
    VERBATIM from the old server pages; `fetchAllRows` unchanged) and mounts
    the existing client component with its exact prior props once data is
    ready (render null while loading). Layout server auth gates are
    untouched — do not move auth client-side.
  - **Invalidation doctrine:** on converted pages, `router.refresh()` as a
    DATA refresh is retired — use scoped `invalidateQueries` (family for
    cross-cutting writes like imports and method merges). `router.refresh()`
    is retained ONLY where server-rendered chrome depends on it (e.g.
    settings save → layout project name/color). Classify any new call site;
    never pattern-replace.
  - **Equipment-list contract (KK-4):** the `initialItems` seam and resync
    effect are PRESERVED — the query's data feeds the same prop. Two
    mechanisms guard it: (a) an unmount-only write-back effect snapshots
    `itemsRef.current` into the cache (`setQueryData`) so returning paints
    exactly what was left — never remove it; (b) the resync effect is
    GUARDED: while any in-flight signal is active (`editingModelGroupKey`,
    cascade in flight, open confirm dialog, pending new record) an incoming
    array is STASHED and applied when signals clear, latest-stash-wins.
    Never apply a resync mid-edit; never drop a stashed update silently.
    Note: a post-(ss)-landing open band editor is such a signal — the first
    resync stashing until it closes is by design, not a stuck resync.
  - The S-1 Layer-1 underlay sort (`category_sort → sort_order →
    created_at DESC → id DESC`) is applied inside the equipment query fn —
    one place, verbatim semantics. Do not re-sort in the loader or client.
  - **Preload (KK-5):** the project-menu loader prefetches the library +
    equipment reads on mount. Print/revisions inherit equipment's warm cache
    through shared keys — do not give them private equipment keys.
  - Image-column writes on settings bypass the shared debounced autoSave —
    `writeImageColumn` does a direct single-column update + projectSingle
    invalidation (a superseded debounce silently dropped column writes while
    the storage upload succeeded). Text fields keep the shared debounce.

- **(ss) cross-route landing architecture of record (July 21, (kk) leg C —
  commit `d5036e8`; do not undo or fork in later passes):**
  - Context-aware chords: ⌥⇧W on the equipment list / ⌥⇧L on the library,
    with a focused row carrying a non-blank model, navigate WITH a landing
    param (`?land=<model>`); otherwise plain navigation. Mechanism: a
    CAPTURE-PHASE window keydown listener inside each client component
    claims its ONE chord ahead of `useNavShortcuts`'s bubble listener via
    `preventDefault()` + `stopImmediatePropagation()`; every other chord
    flows through. **`useNavShortcuts` stays byte-untouched — route-local
    chord claims use this capture pattern, never edits to the shared hook.**
    The list chord runs the K-5 flush before navigating; the library chord
    blurs (its writes are fire-and-forget, matching existing behavior).
  - `src/lib/equipment/landTarget.ts` (`findLandTarget`) is the ONE matcher
    (SS-1 exact then case-insensitive; SS-2 first in DISPLAY order — caller
    passes grouped/orderedIds order on the list, `sorted` on the library;
    blank/no-match → null → plain nav). Never re-derive matching.
  - Landing effects are mount-armed, consume-once, and ride EXISTING focus
    machinery: list → editing-key + `pendingBandFocusRef` (the FF idiom, no
    new locator); library → `[data-lib-row-id]` + a local 5-retry rAF
    locator → model field focus+select, center-scrolled. After landing (or
    no-match) the param is scrubbed via
    `history.replaceState(window.history.state, '', pathname)` —
    **always preserve `window.history.state`; never pass null** (nulling it
    corrupts Next's router state).
  - `?noMethod=1` (Print's Show Me) is consumed by the same machinery:
    method filter → FILTER_NONE, identical to a user pick. `landModel` wins
    if both params are present.

- **Project-images storage architecture of record (July 21, (kk) leg D —
  commit `cc3b299`; migration `storage_project_images_bucket_and_policies`
  Arch-applied + smoked; do not undo or fork in later passes):**
  - ONE private bucket `project-images`; server-enforced 5MB cap +
    PNG/JPEG allowlist; four owner-scoped policies on storage.objects
    (path's first folder must be a project with `owner_id = auth.uid()`).
    Object path = `{projectId}/{slot}`, slot ∈ top_left | top_right |
    box_logo; fixed path + `upsert: true` = replace-in-place, no versions.
  - `src/lib/storage/projectImages.ts` is the ONE storage lib (pathFor,
    validators mirroring the server caps, uploadProjectImage,
    removeProjectImage, signedUrlFor — null on error, removeAllProjectImages
    — NEVER throws). Never call the storage API around it.
  - **The DB columns (`top_left_image_url` / `top_right_image_url` /
    `box_logo_url`) store the storage PATH**, not a URL. Display resolves a
    path via `signedUrlFor` at mount; a stored value starting with http is
    the LEGACY branch (render directly; ✕ nulls the column only). Replace
    display uses a `resolveNonce` effect dep + a display-only `&cb=` buster —
    the stored value stays the bare path. Print resolves top_right per mount
    (no buster needed); top-left/box-logo print rendering are NOT built —
    registered elsewhere, do not wire them ad hoc.
  - **Delete-project cleanup ordering (A1, ruling of record):**
    `removeAllProjectImages` runs BEFORE the projects row delete — the
    storage policies verify ownership against the LIVE row; a post-delete
    remove is denied and orphans objects. Best-effort: the delete proceeds
    regardless of cleanup `{ok}`. Never move the cleanup after the delete.

- **Cable B1 architecture of record (July 23 — commit `5cf9c61`; do not
  undo or fork in later passes):**
  - A cable = `equipment_items` row (type `'cable'`) + 1:1
    `cable_details`; reads via `v_cable_list` into
    `queryKeys.cableList` (ONE shared cache entry per project);
    `cable_types` via `queryKeys.cableTypes`; `fetchAllRows` always.
  - CableRow is greenfield B-6..B-9 (default-shallow memo, module-scope
    editors, `useStableCallback` id-as-argument). **NO `initialItems`
    seam** — the client reads the cableList cache directly and every
    mutation is an optimistic `setQueryData`. Never retrofit the
    equipment seam here.
  - **Two save paths, one row — NEVER merge:** parent-row fields
    reproduce the frozen idiom cache-targeted (the frozen `updateItem`
    is a component-scoped closure and is NOT importable; reproduction,
    not extraction, is the ruling of record); details fields go through
    `updateCableDetails` on the same optimistic idiom.
  - Create = insert item then details, delete-item compensation on
    details failure (SP-6 idiom); focus lands in Name. Unallocate =
    type→`'generic'` FIRST, then delete details (a type failure
    aborts); invalidates cableList AND equipment keys. Delete = one
    item delete (details cascades). All dialog copy is Daniel-captured
    verbatim — never paraphrase it.
  - `cableSortChains`: `compareLabels` IMPORTED from equipment
    sortChains (never fork a comparator); tiebreaks
    (`created_at DESC → id DESC`) live IN the comparator —
    `v_cable_list` carries no `created_at`; the caller passes the
    shared createdAt map. A documented divergence from the equipment
    underlay shape.
  - Menu: MenuTabBar controlled-tab mode (MenuPageLoader owns the
    state); the Cable panel renders the Behavioral Catalog §1 inventory
    (button label "Cables" — Daniel-ruled over "Cable List"); at-rest
    default Equipment keeps frame 01's capture stable. **RULED FOR B2:**
    the menu remembers the session's last tab (leaving a cable page
    returns to the Cable tab; fresh login opens Equipment).
  - Cable List delete is a HEADER action beside + New (Daniel ruling
    July 23, from the v1 New/Delete/Change All header cluster) — never
    a per-row control on cable rows.

- **EQUIP-LIST-FULLSIZE (Daniel, 2026-09-06) — a v1 point is 4/3 of a v2 pixel,
  type and leading together.** ⚠ **The 0.750 that four governing documents called
  a die was a UNITS DEFECT**: v2 wrote v1's POINT numbers as PIXEL values
  (`fontSize: 12` for 12.00 pt), and a CSS pixel is 3/4 of a point, so the ratio was
  *exactly* 0.750 on every element class by arithmetic — which is why it read as a
  design decision. **The page die is the one exception and does NOT scale:**
  `MARGIN_X`/`MARGIN_Y` 36 px is 27.00 pt against v1's 25.98, already correct.
  `src/lib/print/equipListDie.ts` is the die and a test enforces it — the die gate
  slices each print-surface component out BY NAME and fails on any numeric
  `fontSize:`, any quoted `lineHeight: 'Npx'`, and any rule-weight literal, with a
  **positive control** proving the extractor still matches (a gate whose extractor
  silently matches nothing passes for the wrong reason).
- **CONTCAT-DIVERGE (Daniel, 2026-09-05) and CONTCAT-SIZE (Daniel, 2026-09-07) —
  BOTH RULED, BOTH STAY, and the second EXTENDS the first rather than reversing
  it.** v2 prints a continued category on its own line reading
  `4.0 Microphones (continued)` where v1 overlaps it with the method chip, and it
  takes the FULL heading size, 12.00 pt, not v1's 10.00 — v1 shrinks it BECAUSE it
  must fit beside the chip, and on its own line that reduction has no job left.
  ⚠ **Do not "fix" either back to v1 by citing the artifact** — the PAGEBREAK-MODEL
  protection. Both dates are in the source comment and a test fails anyone who does.
- **NOTE-GROUPING (Daniel, 2026-09-08) — the printed row is keyed on MODEL *and*
  NOTE.** Items sharing a model AND a note collapse to one row with the quantity
  summed; items sharing a model with different notes become separate ADJACENT rows.
  ⚠ **The COLLAPSE half is pedigree (b) as well as (a) — ZERO consecutive identical
  sub-note lines in the arbiter's 312**, on rows aggregating to 13 / 165 / 42, which
  a non-collapsing renderer could not produce. **The SPLIT half is pedigree (a)
  alone** and the source says so. ⚠ **The key NORMALISES line endings first**
  (IMPORT-LINEBREAK-CR: imported notes carry CR, notes typed in v2 carry LF), or an
  exact-string key splits two IDENTICAL notes on nothing but their line endings.
  ⚠ **It is a SECOND function, `groupByModelAndNote`, and the census is why:**
  `groupByModel`'s other callers are `pairRevision`, which matches old rows by model
  ALONE, and `buildRevisionSnapshot`, which WRITES `equipment_list_revisions` JSON.
  **Revision mode keeps the old grouping** — REVGROUP-SPLIT, its own unit, because
  changing a persisted artifact's shape is not a print round's.

### Schema
- `project_features` table is live (uuid pk, project_id FK → projects,
  feature_key text, enabled bool, enabled_at/enabled_by/notes). RLS
  enabled: SELECT for owner or member, INSERT/UPDATE/DELETE for owner
  only. No consumer code wired yet — schema-only.

### Equipment List — optimistic-UI compliance confirmed
- `updateItem` in `EquipmentListClient.tsx` now captures `prevRow` via
  `itemsRef.current` before the optimistic `setItems`, wraps the
  Supabase call in try/catch, and on failure: reverts the row in state
  and sets a per-row `rowErrors` entry that drives a `save-error-flash`
  CSS animation (red ring, ~2.5 s fade) on the specific cell that
  failed. No toast, no modal, no layout shift.

### Verified data-access layer is FROZEN — reuse, never regenerate
### (gate definition REVISED July 5, 2026 — Daniel-accepted)

The optimistic-UI write path is verified and correct. Every equipment write on
every surface flows through it. Never reimplement it, never invent a new error
style. If a task genuinely requires changing this path's signature or rollback
mechanism, that is a **data-boundary hard-stop** — stop and surface it.

The gate is verified against the current baseline commit (`be0769de` — canonical
post-rewrite baseline, July 10 history rewrite; updated only at a ruled baseline
change) **at every checkpoint of every run**:

1. **Byte-identity** (extract by NAMED CONSTRUCT from `git show <baseline>:<file>`;
   diff must be empty):
   - the complete `updateItem` function in
     `src/components/equipment/EquipmentListClient.tsx` (`prevRow` capture via
     `itemsRef.current`, optimistic `setItems`, try/catch revert-on-failure
     driving `rowErrors`)
   - the `save-error-flash` rule block in `src/app/globals.css` (red ring,
     ~2.5 s fade — no toast, no modal, no layout shift)
2. **Contract-level** for `src/components/equipment/EquipmentItemRow.tsx`
   (presentation work legitimately interleaves with frozen code in this file):
   - `onUpdate` signature identical:
     `(id: string, updates: Partial<EquipmentListRow>) => void`
   - every call site passes `(id, { field: value })` over the same field set as
     baseline
   - `failedFields` → `save-error-flash` remains the ONLY error affordance
   - trace with file:line in the handoff; any contract change = HARD STOP
   - **Note (July 18): `trackedUpdateItem` is a caller-level wrapper around
     the frozen `updateItem` (captures the returned promise into
     `lastCommitRef`, then returns it). It satisfies the contract — the
     `onUpdate` prop now points at the wrapper. The frozen function itself
     is byte-unchanged; the wrapper is NOT part of the frozen region but
     removing it breaks the July-18 commit-flush semantics.**
   - **Note (July 19): the `onDelete` prop was removed from
     EquipmentItemRow's contract with the row ✕ deletion (S-10). It is not
     part of the frozen contract; do not re-add it without a ruling.**

### Equipment schema — unified spine (both migrations landed, 2026-07-03)

Equipment unification is complete and verified. Migration 1 (additive:
`type` discriminator + `cable_details`/`tail_details`/`box_details`/
`rf_device_details` extension tables + RLS/grants) and Migration 2
(repoint inbound FKs → `equipment_items`; rebuild `v_equipment_list`
bundle-aware + `v_project_stats` type-filtered; drop old `cables`/
`boxes`/`rf_devices`) both landed. The old `cables`, `boxes`,
`rf_devices` tables no longer exist.

**Schema truth = live introspection, not this file.** For any concrete
schema detail (tables, columns, constraints, view definitions, RLS
policies), introspect the live database via Supabase MCP (project
`musfmquwwjlggyxckpos`) — `list_tables`, `list_migrations`,
`execute_sql`. Never trust a static snapshot in this document over the
live database; snapshots drift at every migration. This file records
design decisions and gotchas, not a mirror of the schema.

**`execute_sql` is SELECT/EXPLAIN only in CC's hands (July 25 standing
rule; adopted with the project-scoped auto-approval of the MCP tool
prompt; the `.claude/settings.json` ask-gate on the tool was RETIRED
July 26, `4dd575d` — this rule is the standing guard).** Any INSERT/UPDATE/DELETE/DDL issued through `execute_sql`
by CC is a handoff defect — flag it in the handoff file, never
rationalize it. ONE licensed exception — the **atomic self-cleaning
throwaway DB smoke** (Daniel ruling July 29, flags-2/3(a); first
licensed outings: R7 + R7-AMEND): writes permitted ONLY under ALL of —
throwaway-project rows only · seed + exercise + cleanup in ONE atomic
call · rollback-on-any-error (nothing persists either way) ·
census-to-zero proven verbatim in RAW OUTPUT · a browser smoke still
owed wherever the surface is drivable. Real project data is never
written through `execute_sql` under any framing. All DDL remains
Arch-applied via `apply_migration` with an authenticated-role smoke.

**Durable design facts (live introspection won't tell you these):**
- **Type discriminator.** `equipment_items.type` ∈ `generic | cable |
  tail | box | rf_device` (CHECK-enforced; `walkie` deliberately
  excluded until built). Each non-generic type has a 1:1 extension
  table keyed on `equipment_items.id` (ON DELETE CASCADE); ownership
  checked through the spine → projects.
- **Bundles are NOT an equipment type.** `bundles` stays a separate
  grouping table. On equipment/cable lists, member cables show and the
  bundle row doesn't; on pack lists, the bundle shows and its member
  cables don't. Never model bundles as a `type`.
- **Effective box is computed, not stored.** A cable's display box =
  `IF bundled THEN bundle.box_id ELSE own box_id`, resolved in
  `v_equipment_list` — matches v1's formula.

### Known gotcha — view 403s: check grants before RLS
`v_equipment_list` and `v_project_stats` were created without
`GRANT SELECT … TO authenticated`. The symptom was a 403 on any
authenticated SELECT against the view even though the underlying
table's RLS policies were correct. Fix: `GRANT SELECT ON <view> TO
authenticated`. If a view query 403s and the table policies look right,
run `SELECT grantee, privilege_type FROM information_schema.role_table_grants
WHERE table_name = '<view>'` — missing SELECT for authenticated is the
first thing to check.

**July 23 extension — the TABLE side (production outage lesson):**
dropping/recreating a table LOSES its grants, and because every view is
`security_invoker=true`, missing TABLE grants fail every authenticated
SELECT through any view referencing it — RLS policies landing is not
enough. Standing rule: every table-recreating migration includes its
grant set (per-project tables: SELECT/INSERT/UPDATE/DELETE to
authenticated; global catalogs: SELECT only; no anon), and every
migration smoke includes a `SET LOCAL ROLE authenticated` probe of the
touched surfaces — service_role smoke is blind to grants and proves
nothing about them.

## Standing rules — earned by units, owned by none

*(NEW 2026-09-08, CLAUDEMD-ATLIMIT. **This section exists so the run fence can be
thrown away.** FENCE-ONEUNIT ruled that the fence carries ONE unit and that
retired fence text goes to the Ledger — but the fence was in fact the ONLY home
for eighteen standing rules, so obeying FENCE-ONEUNIT literally would have deleted
them. Measured at this refactor: of twenty rules checked, eighteen appeared
nowhere else in this file. **A rule a unit earns lands HERE at that unit's close;
the fence then holds narrative only and is discarded in full.** Every rule below
carries its reason, because a bare rule gets rationalised past.)*

### The fence, and how counts are kept

- **FENCE-HEADLINE (2026-08-24). HEAD is the commit whose subject names the
  current unit.** The fence's headline never carries a literal hash: the commit
  does not exist when the fence is written, so any hash quoted is always the
  PREVIOUS unit's. Self-locating, always true, unfalsifiable by one push.
- **FENCE-ONEUNIT (2026-09-06). The fence carries ONE unit — never a history.**
  `git log` already is the closed-and-pushed list and cannot go stale. The
  shipped history belongs to the Ledger and the Roadmap. **The fence is REPLACED,
  never appended**, and at a unit's close its earned rules move up into this
  section before the body is discarded.
- **FENCE-COUNTS. Whoever measures a count writes it into the fence in the same
  pass.** The expensive part is the measurement; leaving it unwritten is how the
  fence went three units stale, then six. Every handoff that changes a measured
  count asks for the fence in the same pass.
- **TESTCOUNT. `2827/149` is TESTS / TEST FILES — never passing / skipped.** The
  suite has no skipped tests. A handoff that reads the second number as "skipped"
  is wrong; say "tests across files" in prose.
- **TENSE-IS-A-CLAIM. An expectation written in the past tense is
  indistinguishable from a measurement to whoever reads it next.** Earned when a
  `28/28` that had not happened reached four documents including this fence.
- **The limit is in CHARACTERS.** `wc -m`, not `wc -c` — `wc -c` reports more for
  this file and reads as over when it is under. **A file over the limit loses its
  TAIL**, and the tail of this one is the Return Handoff File Protocol.

### The visual gate

- **GATE-NOGREP. Capture the gate to a FILE, never through a filter.** A run
  piped through `grep` lost its verdict detail and overwrote its diff PNGs,
  costing the only characterisation of a 26/28 failure. An intermittent you cannot
  characterise costs the next run as much as the failure itself.
- **GATE-DEVCHECK. Check what is on `:3000` BEFORE running the gate, not after it
  produces a result.** `ensureServer` (`scripts/visual-capture.mjs:260-267`)
  adopts any `:3000` responder under HTTP 500 as a dev server without checking,
  and it spent two fail-harded runs measuring a production `npm start`. There is
  no port override (GATE-PORT). **The pattern to copy when a unit needs both:
  PANEL-CLIP ran its own production server on `:3100` and left `:3000` free.**
- **GATE-LOAD-AUDIO. `--force-load` is forbidden — poll for a window and fire
  inside it.** Audio software on this machine holds the load between 4.5 and 12.8;
  the harness refuses and writes nothing, which is the guard working.
- **GATE-THEMEGLYPH. Do not quote a single green run as "the gate passed" here,
  and NEVER admit it to the diff-exception registry.** The topbar theme-toggle
  glyph, `bbox 1273,14–1307,32`, 19 judged px at **max Δ42**, reproduced to the
  digit on different trees; the same tree has failed then passed, three times now.
  Δ42 is a real visual difference, not the Δ1 the registry masks, and
  **DIFF-EXC-BOUND's bound is owed before ANY Δ>1 site is admitted.** Diagnosis
  owed since 2026-08-21, scoped as its own unit.
- **SUBPIXEL-WANDER and GATE-THEMEGLYPH are both H3's, and H3 is UNSCHEDULED.**
  The registry TOLERATES the wander and explains nothing; nothing in it is a
  diagnosis. `--no-exceptions` is the flag H3 will want. The model the record
  keeps confirming: **presence wanders while position and volume reproduce
  exactly.** Two live threads — site 3 (`box-type-plus-high`) is still PROVISIONAL
  and still carries its `refineBy`, and frame 12's 150 ms settle is a **partial
  improvement, measured, not a fix** (the light half wandered on 4 of 5 runs
  without it and 1 of 3 with it, on small samples).
- **GRAPH-BEATS-RERUN. A re-run says whether a failure recurs; an IMPORT GRAPH
  says whether the frame could ever have seen the change, and gives the same
  answer either way.** Two runs is the limit. Earned on a `06-settings-light`
  failure — 0 of 8 changed modules reachable from that route against a control of
  8 of 8 — and used again to settle a `05-gcm-dark` refusal at 0 of 3 against
  3 of 3.
- **AMEND-DECLARES-PER-ROUND — RULED (Arch, 2026-09-06), superseding the
  AMEND-ROUND RE-DECLARATION PROCEDURE. A declaration is per ROUND, not per
  unit.** H2 computes the moved set against the baselines ON DISK, which is the
  honest comparison; the alternative is a restore, i.e. the retired scoped-restore
  workflow under another name.
  - **A round declares only the frames that move IN THAT ROUND**, measured
    per-frame with pixel counts and bounding boxes, reproduced on more than one
    run before adoption.
  - **Frames already adopted by an earlier round are neither re-declared nor
    restored.**
  - **The unit's close records EVERY declaration it ran**, so "one declaration per
    unit" survives where it matters — in the record.
  - What "never restore baselines" protects is that no frame is adopted without
    having been measured and declared first; per-round declaration keeps that
    invariant exactly.
  - **The retired procedure, for the record:** restore `screenshots/baseline/` to
    HEAD, then ONE emit → fill every `reason` → write → confirming gate. **No
    longer run.** And **never prefix the emit or the write with
    `GATE_DIFF_THRESHOLD_PCT=0`** — plain `--gate --emit-declaration` and
    `--update-baselines --declare` measure at the right tolerance now.
- **GATE-REPORTING. Ask for Daniel's browser-gate result IN THE TERMINAL before
  the confirm phrase, and record his words VERBATIM in the `_CLOSE.txt`** —
  `browser gate: <his words>, reported by Daniel at <time>`. His gate runs in his
  browser and is reported to Arch in Cowork; the phrase is typed at CC. **A gate
  reported where CC cannot see it is, to CC, indistinguishable from one that did
  not happen.** Do not infer it from silence and do not assume it from a green
  machine gate. Built 2026-09-07 and it worked on its first unit.

### Measuring a printed page

- **PDF-CHROME-PATH. A v1↔v2 parity print is valid ONLY through Chrome's own
  Save-as-PDF destination.** "Open PDF in Preview" and "Print using system dialog"
  reach Quartz, which discards the CSS `@page size` rule — those artifacts measure
  the operating system, not the app. Every landscape artifact taken before
  2026-08-27 is invalid as an orientation or geometry arbiter.
- **NO print-parity judgement from a `next dev` export, EVER.** Measure against a
  PRODUCTION build — the `:3100` pattern — under `emulateMedia({media:'print'})`
  at a true 816×1056.
- **PRINTPROBE-MEDIA. The screen does not clip; the printed page does.**
  `.print-page` carries an inline `height: 1056` and a flex column refuses to
  shrink below its content, so an over-budget page GROWS on screen while the
  scissoring `overflow: hidden` sits in the `@media print` block. **A screen-only
  probe reports zero blocks lost while rows are being lost.**
- **RECT-VS-FLOW. `getBoundingClientRect().height` excludes the last child's
  collapsed bottom margin**, so a probe comparing block rects to a content budget
  under-counts every block. Estimate constants are FLOW costs — top-of-block to
  top-of-next-block.
- **THE ACCEPTANCE INSTRUMENT FOR TYPE AND LEADING IS THE EMITTED PDF, NOT THE
  DOM.** A DOM solve correct at weighted RMS 0.114 px printed two values on four of
  eight transitions. *An instrument that cannot see the quantum reports a solved
  system.* **The DOM is where you solve; the PDF is where you accept.**
- **EQUIPLIST-LEAD-QUANTUM. In the emitted PDF every baseline lands on a WHOLE
  CSS PIXEL**, which is 0.75 pt — so a fractional baseline-to-baseline distance
  cannot be painted and the printed gap ALTERNATES between the two nearest.
  **RULED (Arch, 2026-09-07): SNAP per transition, not as one policy** — v1's
  rhythm is exactly constant and a steady 0.28 pt long beats a page that breathes
  in and out by 0.75.
- **EQUIPLIST-RULE-QUANTUM. Chrome FLOORS a CSS `border-width` to a whole CSS
  pixel**, so the achievable rule weights are the 0.75 pt multiples and nothing
  between. **RULED (Arch, 2026-09-07): KEEP NEAREST** — every print-parity round
  here is scored worst-element-in-points, and nearest minimises that error at
  0.25 pt where floor gives 0.50. Single named site `nearestRulePx`.
- **⚠ A BORDER IS DETERMINISTIC; A FRACTIONAL FILLED BOX IS NOT.** In the emitted
  PDF a **2.5 px** filled `<div>` painted **2.25 pt** while a **2.667 px** one
  painted **1.50 pt** — a smaller authored box painting HEAVIER, because painted
  edges snap to the device grid independently and the result is a function of the
  box's absolute y on the page. **Anything that must have a predictable weight is
  a border.** Its own rule because it is the counter-intuitive half and will be
  re-derived wrongly otherwise.
- **A GAP IS NOT A WRAP UNTIL THE LINE ABOVE IT IS MEASURED.** v1's 126 sub-note
  gaps at 12.00 were called soft wraps without the lines above them ever being
  measured, and **119 of 126 end more than 60 pt short of the wrap edge.** The
  wrong model reached the measurement of record, a governing amendment and the
  build, and Daniel caught it on paper.
- **AN INSTRUMENT MUST NOT INHERIT THE CLAIM'S PARAMETERS — census the class, then
  narrow. A MEASUREMENT'S BOUNDARY IS A CLAIM TOO.** A probe filtered
  `linewidth >= 2.0` because the lead said 2 pt; the rule renders at 1.00 pt, so
  the instrument could not see the object it existed to test for, returned absence,
  and the absence shipped.
- **SET A SPACING AND THEN MEASURE IT ON THE EMITTED PAGE — a die constant is an
  instruction, not an outcome.** Two cover-letter rows printed off their set
  advance because of extra BOX, and one of the two pixels was not in the repo at
  all: Chrome's UA `td { padding: 1px }`.
- **MEASURE WHAT v1 DOES BEFORE ASSERTING IT** (PANEL-CLIP, nearly shipped). The
  rejected fix clipped each cell to its die row on the reasoning that "FileMaker
  fields do not grow"; v1 measured does not clip at all, and the fix would have
  deleted a line v1 prints.
- **A NEW FIXED-HEIGHT CONTENT BOX IS A HARD STOP.** If content does not fit its
  box, the box is measured to fit or the content paginates. It is never silently
  trimmed.
- **AN `<img>` THAT FAILS TO DECODE MEASURES ZERO**, which looks exactly like "the
  image costs nothing". Any probe that measures an image ASSERTS the decode and
  refuses the measurement otherwise.
- **DDR-IS-THE-SOURCE — go to the source that made the ink.** ⚠
  `docs/reference/v1_ddr.xml` is **UTF-16LE** (`iconv -f UTF-16LE`; a byte-oriented
  grep finds nothing in it), it names the same field TWO ways, and **it states NO
  TAB ORDER anywhere — do not search for one again.**
- **Print is OPEN and has been since `eaabd03`.** What still binds from the older
  "print is closed" paragraph: one agreed target ruled first, and a measurement
  harness before any code.

### Static scans and source-reading guards

- **SCAN-NONZERO (FIELD-CONTRACT leg 1, 2026-09-08). A guard that reads source must
  assert it found something BEFORE it compares anything.** A scan that matches
  nothing returns an empty set, and an empty set satisfies every set comparison
  downstream — so a renamed attribute or const turns the guard off and the suite
  still prints green. The instrument must also return `null` for an absent
  declaration rather than `[]`, so the difference between *absent* and *empty* is
  not lost at the parse. This is the same defect class as the die gate's positive
  control and as the `linewidth >= 2.0` probe that reported absence as refutation;
  it is stated generally here because it has now bitten in three different shapes.
- **A SELECTOR IS NOT AN EMISSION.** When source both EMITS an attribute and builds
  a SELECTOR from it — every row component does, ``querySelector(`[data-x-field="${f}"]`)``
  — a scan that does not distinguish them invents things that are not rendered. The
  discriminator is cheap (a selector always follows a `[`); the bug is not, because
  the invented entry looks like a real finding. Present in this census's own first
  draft and caught by the instrument's own test.

### Open, carried across units — none of these belongs to the unit in the fence

- **AC-HANDLED — app-wide; do not fix it inside another unit.**
  `AutocompleteInput.handledRef` latches on the first commit of a mount and never
  clears, so the (kk) blur-fallback commit is inert for the rest of every mount, on
  every autocomplete in the app. Symptom: same-row mouse and keyboard disagree on
  when a held draft reverts. Its own small pass.
- **BOXBAND-DOCTRINE — a RULING owed from Daniel, not a build.**
  `commitBandFieldScoped`'s box arm keeps its no-op-revert, on the reading that
  ruling 1 of 2026-08-19 says "every Box **field**" and a sort-band header is not
  one of the four. Rides FIELD-CONTRACT.
- **2-MIG-c (SPLITOF-NO-ARM + APPLY-TIMEOUT) — still owed, still Arch's**, and
  sequenced behind the CDMX work by Daniel's own ruling.
  `cable_details.split_of_id` exists and the export emits the column, but the RPC
  has no arm, so the import refuses it (3 rows corpus-wide).
- **`BUNDLE_LINK_VOCABULARY` — OPEN, waiting on Daniel's ruling.** It ships
  COMPLETE and enrolls NOTHING, deliberately: the premise that bundle-field linking
  "was never used" was measured on `Link Bundle`, a column of the CABLE sheet, and
  the BUNDLE sheet's own eight columns DO group (19 / 42 / 26). **Not importing is
  the reversible direction, because no import can undo it.** Pinned by a
  DO-NOT-ENROLL test.
- **EQUIPLIST-QTYCOL — the clip is stopped; the parity answer is still owed.** v1
  has NO fixed quantity column: it right-aligns the number hard against the
  description, `x0` 30.52 / 37.18 / 43.83 pt for three / two / one digits.
- **EQUIPLIST-WHOEST — Arch's, its own scoped round.** The cover letter's
  `estimateWhoHeight` models a RETIRED two-line layout, over by 119 px on a six-row
  block, **and has no wrap model at all** — a row whose role wraps renders 48 px
  and the estimator does not move. **Safe today because it over-counts, and the
  obvious correction is the one that clips.**
- **Two findings the old fence recorded as cut for size, kept here so they are not
  lost:** `itemNoteHeight`'s rendered-string rule, and the subnote test's
  `margin-bottom:0` matcher. Both are in
  `handoffs/from-cc/260906-1630_equip-list-parity.md`.
- **HARNESS-RLS-CORPUS — every future parity pass has it, and it is why a unit
  cannot "just look at the real data."** `Cable Parity Fixture`, `Matched Pair
  Fixture` and BOTH Buena Vista Social Club projects are owned by daniel@ while the
  harness signs in as the TEST user, so **no harness CC drives can read the parity
  corpus at all.** Every count taken on a seeded throwaway is labelled as a
  reproduction, and anything that needs the real corpus on screen is Daniel's gate.
  Closing it needs HARNESS-READ (a read-only role) — a Trigger B unit. Detail in
  `docs/reference/visual-capture-harness.md`.
- **Owed by Daniel, both unrun acceptances on SHIPPED units:** hold a printed 5167
  sheet against a real Avery blank (deferred 2026-08-31 — a die match is not a
  stock match, and five outputs are built on that die), and **reprint
  `Tail Panel Labels`** — PANEL-CLIP was verified by DOM and PDF extraction only,
  which is not parity evidence for the printed page, and `702048b` is live.
- **Sequencing that outlives any one fence:** BATCH-AC runs after private beta
  STARTS (ruled 2026-08-19) — it is not next. S4-mid follows the PORT-COV legs. The
  remaining S3-G docket items (three-PDF interactive measurement packet · OL25WR
  die-cut re-gate · C4 pagination confirm) are Daniel-at-a-printer.

## Current run fence

**HEAD is the commit whose subject names this unit** (FENCE-HEADLINE). **The
fence carries ONE unit and is REPLACED, never appended** (FENCE-ONEUNIT); a rule
this unit earns moves up into **Standing rules — earned by units, owned by none**
at its close, and then this body is discarded in full. ⚠ **Both rules, and the
counting rules that go with them, now live in that section — do not re-state them
here.**

**In flight: FIND-PARITY (FIELD-CONTRACT leg 2) — BUILT, ALL MACHINE GATES GREEN,
UNCOMMITTED.** Awaiting Arch's read of the return and Daniel's browser gate, which is
a real precondition here. The last unit closed and pushed is **FIELD-CONTRACT leg 1,
the census (`44e206d`)**, 2026-09-08; its predecessor was ROADMAP-REFACTOR /
CLAUDEMD-ATLIMIT (`1b23223`).

**RULED (Daniel, 2026-09-08) — FIND-PARITY: every field a surface's Change All can
WRITE is a field that surface's Find can SEARCH.** A SUBSET relation,
`changeAll ⊆ find`, **not a blanket "everything is findable"** — three fields stay
unfindable precisely because Change All cannot write them (cable's two steck columns,
boxes' `in_box`). It now holds on all seven surfaces, asserted by test.
**25 keys added: equipment 5 · cable 7 · boxes 13.** 24 are newly-searchable columns;
`box_number` was a REKEY from `number`, which also fixed a live defect (the
focus-aware find default could never resolve that cell). 25 stale exceptions retired.

Counts MEASURED at this checkpoint, 2026-09-08: suite **2908 tests across 151 test
files, ZERO skipped** (was 2900/151 — +8, one subset check per surface plus the
retired-exception guard) · frozen **3/3 vs `be0769de`** · build clean · strict
typecheck clean · dependency gate clean · guarded-code grep clean · migration ledger
**57**, UNCHANGED for seven consecutive units.

Visual gate **28/28 at 0.0000%, zero FAIL lines, no baseline event** — the run of
record finished 11:36:47 at load 3.62, AFTER the last source edit (11:29:53), so it
covers the committed tree. It took five attempts and the interesting ones are 1 and 2.
**Run 1: 27/28**, `04-library-light` at 110357/1600000 px (6.8973%), max Δ248, bbox
0,48–1599,996, every other frame byte-clean **including `04-library-dark`**.
**Runs 2 and 4 REFUSED** on load (6.32 and 5.96 > 5.00) and wrote nothing — the guard
working; `--force-load` is forbidden. **Runs 3 and 5: 28/28**, `04-library-light`
byte-clean.
**GRAPH-BEATS-RERUN called it before run 3 existed:** 0 of 4 changed modules reachable
from the library route, against a positive control of 2 of 4 from the equipment
route, and the equipment frames that DO see the change were byte-clean throughout.
⚠ **A CAPTURE-FLAKE REGISTER ENTRY IS OWED and this unit did not write it** — the
signature does NOT match the registered theme-race invariant (1451200 px at bbox
0,93–1599,999); it is a new one, on a frame whose DARK half is already registered.
**That is H3's**, and editing the harness doc was outside this unit's scope.
**Data point for H3, recorded because it is free:** the Δ1 registry site
`subpixel-wander/topbar-theme-toggle-glyph` fired 16 px on frames 02 and 03 in BOTH
halves on run 5 and **not at all** on runs 1 and 3 — presence wandering on an
otherwise identical tree, exactly as its entry predicts. ⚠ **This is NOT the
GATE-THEMEGLYPH site and must not be confused with it:** the registry site is bbox
1582,18–1583,27 at Δ≤1; GATE-THEMEGLYPH's undiagnosed one is bbox 1273,14–1307,32 at
**Δ42**, is NOT in the registry, and must not be admitted. All four registered sites
remain at Δ1, so **DIFF-EXC-BOUND's trigger is still untripped.**

⚠ **THIS UNIT CHANGES WHAT DANIEL SEES** — the Find panel's field dropdown gains
entries on equipment, cable and boxes (`panelFields` maps the field map straight to
the `<option>` list). His browser gate is a real precondition and is **not waivable**.

⚠ **READ `.git/refs/heads/main` FOR HEAD, NEVER `.git/packed-refs`** — it still
carries `be0769de`, now twenty commits stale, and that value is ALSO the
frozen-gate baseline, so a stale read looks plausible. (GIT-CFG.)

⚠ **A WF-1a COMMIT IS A PRODUCTION DEPLOY.** FENCE-PUSH is live: a bare
`git push` is CC's on the `COMMIT APPROVED:` phrase, and Vercel builds every push
to `main`. **Daniel's browser gate runs BEFORE the phrase, not after it**
(GATE-BEFORE-COMMIT), and its result is asked for in the terminal and recorded
verbatim (GATE-REPORTING).

**Next: FIELD-CONTRACT LEG 3 — the contract fixes, BLOCKED on rulings, not on code.**
Census §4 is the agenda: THE MODEL GAP (one attribute, one array, three chords) ·
**cable's find-default listener, now inconsistent — `CableListClient.tsx:476` reads
`data-b2-field` only, so the seven inspector fields this unit made findable cannot
seed ⌥⇧F from focus** · the `box_number`/`number` spelling (rekeyed, still unruled) ·
the steck marker/column split · the library's missing Tab order · the two uncited
Change All refusals · `num_labels`' marker · `ROW_FIELD_ORDER`'s `num_labels`
position. Then DARKMODE-PASS.

⚠ **THE HAZARD THIS UNIT LEFT LIVE:** FIND-PARITY was verified by STATIC ANALYSIS —
the test reads source and proves the four structures agree. **It does not prove a
single one of the 25 new fields actually matches anything when typed into the Find
panel.** Two accessor faces are judgement calls that only a human at the keyboard can
confirm: the four equipment flags find as `Yes`/blank while the CELL draws a `✓`
glyph, and cable `group` reads `group_manual`, so a bundled cable's inherited group
will not match. Both are declared in the return's OPEN QUESTIONS §A.

## Guarded Architectures Index (relocated 2026-08-09 — full text in docs/reference/arch-record/; DO NOT UNDO OR FORK any entry)

Cable B2-line · a63e03b..8329881 · do not undo or fork · docs/reference/arch-record/cable-b2-line.md
Cable CTF / (ooo)-2 · c1d7ae6 · do not undo or fork · docs/reference/arch-record/cable-ctf-ooo-2.md
Cable B3 · 03b9753 · do not undo or fork · docs/reference/arch-record/cable-b3.md
Cable B4 · a066155 · do not undo or fork · docs/reference/arch-record/cable-b4.md
Cable B6 · 4dd575d · do not undo or fork · docs/reference/arch-record/cable-b6.md
Cable B7 · 18d09ce · do not undo or fork · docs/reference/arch-record/cable-b7.md
Cable S3-D · dfd95c9 · do not undo or fork · docs/reference/arch-record/cable-s3-d.md
Cable S3-E · 670849d · do not undo or fork · docs/reference/arch-record/cable-s3-e.md
Cable R7 · 3acbee8 · do not undo or fork · docs/reference/arch-record/cable-r7.md
Cable S3-F · 327c100 · do not undo or fork · docs/reference/arch-record/cable-s3-f.md
Cable (uuu) · 8505484 + 1786211 · do not undo or fork · docs/reference/arch-record/cable-uuu.md
Find Engine · b572fd4 · do not undo or fork · docs/reference/arch-record/find-engine.md
Found-set · 0c0792c + 40aa945 · do not undo or fork · docs/reference/arch-record/found-set.md
Equipment (zzz) · 2720607 · do not undo or fork · docs/reference/arch-record/equipment-zzz.md
Cable D-2 · de1dda9 · do not undo or fork · docs/reference/arch-record/cable-d-2.md
DEV-1 / Equipment import · 35e23c3 · do not undo or fork · docs/reference/arch-record/dev-1.md
DEV-2 · 7fad0f8 · do not undo or fork · docs/reference/arch-record/dev-2.md
Cover Letter (CL) · 5ddf30b · do not undo or fork · docs/reference/arch-record/cover-letter-cl.md
GS-A / E-CA — Change All · f949d8e..b09178e · do not undo or fork · docs/reference/arch-record/gs-a-e-ca.md
Cable S3-G · 1055e76 · do not undo or fork · docs/reference/arch-record/cable-s3-g.md

## Return Handoff File Protocol

**The trigger is RETURNING CONTROL. It is an event, not a judgment.** Every
time you stop and wait for Daniel — for a confirm phrase, a ruling, a print, a
decision, a re-run, anything at all — the unit's return file is brought current
FIRST, before you write a word in the terminal.

**And the last line of your terminal message is that file's path, alone**
(Daniel, 2026-08-30). Do not restate the return in the terminal and do not
summarise it: the return is for Arch, the path is for Daniel. A terminal
message that carries the findings and no path has recreated the defect this
rule exists to close.

The reason, carried with the rule because a bare rule gets rationalised past:
**the terminal is not the record.** A measurement, a verdict, a count or a
state change that exists only in scrollback when you stop is lost — and Daniel
becomes the transport layer, retyping or photographing your own output back to
Arch. That has happened twice in one day.

**THE EXCLUSIONS (Daniel, 2026-08-30) — written into the rule, not a
footnote.** No return file is owed when:
1. **You are waiting for any step already written into the COMMIT BLOCK** —
   which now means waiting for the confirm phrase, since CC runs all four
   steps itself. The record exists; the stop is procedural. *(The
   waiting-for-Daniel-to-push case is gone with FENCE-PUSH, 2026-08-30,
   Daniel's ruling; the general form — a stop for a step the return already
   documents — stays, and is what this exclusion is now for.)*
2. **You are interrupted rather than finished** — an API error, a dropped
   connection, the machine sleeping. Those are not returns of control and
   nothing has concluded.
3. **You stop to ask a clarifying question before any work has been done.**
   Work already done is never covered by this exclusion.

**The test that decides all three: has something happened that Arch will need
and that exists only in scrollback?** If yes, write. If no, do not.

Path: `~/Developer/Minotaur-Cowork/handoffs/from-cc/YYMMDD-hhmm_<unit>.md`
(the actual current date/time in that format; `<unit>` is the unit slug the
inbound handoff used — an AMEND on `260812-1712_s4-3-leg2-amend3.md` returns
as `260812-1746_s4-3-leg2-amend3.md`). A handoff that names its own return
path overrides this one.

**No Desktop copy (Aug 12, 2026 — Daniel's ruling).** Returns used to be
written to `~/Desktop/Minotaur CC Handoff YYMMDD-hhmm.txt`; the
`handoffs/from-cc/` folder replaced that and the duplicate is retired. Write
ONE file, in the folder. Nothing else about this protocol changes — the
sections, the fidelity bar, and the COMMIT BLOCK rules below are unchanged,
and the Multi-Leg Run Pattern's per-leg boundary files land in the same
folder at the same bar.

Format (the four sections below every time; plus SED LEDGER and COMMIT
BLOCK when applicable):

DONE
<what was accomplished, in plain language, no restating the task back>

FILES CHANGED
<one file per line, relative path>

OPEN QUESTIONS
<anything requiring Daniel's decision, or "none">

RAW OUTPUT
<verbatim command output/test results relevant to verifying the work —
never include credentials, API keys, tokens, or full RLS policy SQL
here; reference the file instead>

SED LEDGER (include whenever the pass ran ANY in-place stream edit —
sed -i / perl -i / gawk -i inplace; omit entirely otherwise)
<one entry per command, per the Sed Disclosure Rule: the verbatim
command · plain-language intent and why a stream edit · git diff --stat
verbatim from immediately after the command · diff hunks where the rule
warrants them · the frozen assertion + the immediate frozen-gate output.
Arch reviews this ledger before any commit approval — an unledgered
stream edit makes the commit unapprovable>

COMMIT BLOCK (include whenever the pass changed files that will need
committing; omit entirely for read-only/recon passes)
<the exact sequence for this commit. Under the WF-1a pilot, ALL FOUR STEPS
are executed by CC on Daniel's confirm phrase — the phrase covers the push
as of the Aug-26 amendment (Commit authority above), and **step 4 is CC's to
run as of FENCE-PUSH, 2026-08-30 (Daniel's ruling): both enforcement layers
permit a bare `git push`, and that push is a PRODUCTION DEPLOY.**
In this order:
 1. ONE `git add` line staging every changed/new file by explicit
    filename — never `-A`, never a bare directory; list files
    individually, and double-quote any path containing brackets
    (e.g. "src/app/project/[projectId]/settings/page.tsx")
 2. `git status --short`, with the expected output stated on the next
    line (file count and that every line begins `M ` or `A `)
 3. `git commit -m "<drafted message following the repo's existing
    style, e.g. feat(unit): summary (ruling refs)>"`
 4. `git push`>

COMMIT BLOCK rules:
- The block executes ONLY on Daniel's per-commit confirm phrase (WF-1a);
  without the phrase it is inert record. The phrase covers steps 1–4.
- **Step 4 is CC's, on the phrase** (FENCE-PUSH, 2026-08-30, Daniel's
  ruling — both layers permit the bare form). A successful push is
  followed by the `_CLOSE.txt` artifact (Commit authority above), and
  **the commit IS a production DEPLOY.** Only the bare `git push` is
  permitted: a force, a refspec, `--delete` or `--mirror` is still
  refused, and a push that half-works is reported plainly, not retried
  in another shape.
- The block never weakens gate-first discipline: Daniel runs it only
  after his browser gates pass, and checks and commits still never share
  a paste.
- The `git add` list must exactly match FILES CHANGED — same files, no
  more, no fewer. A mismatch is a defect in the handoff.

Rules:
- This file is for Daniel to read and act on — never read a prior
  handoff file back into your own context unless Daniel explicitly
  points you to it by name.
- **ONE FILE PER UNIT, APPENDED — not one per stop.** What gets batched is the
  FILE, never the writing. A checkpoint, an amendment or a re-run inside a live
  unit appends a new dated section to that unit's existing return file and
  leaves every prior section untouched; it does not open a new one. A new file
  is opened only by a new inbound handoff. This is what
  `260830-1420_cable-pass4-cell-and-row.md` already does across CP1, AMENDMENT
  1 and AMENDMENT 2, and it is the pattern, not an exception.
- A focused return answering one narrow inbound handoff may be written as its
  own file **provided its content is also folded into the unit's file in the
  same step**, and it says so in its own first paragraph.
- This does not replace the hard-stop reporting rule in the Operating
  Contract ("surface it in one plain line and wait") — if you hit a
  hard-stop, still say so plainly in the terminal AND write the handoff
  file with OPEN QUESTIONS covering it, so Daniel has both the
  in-the-moment flag and the durable record.
