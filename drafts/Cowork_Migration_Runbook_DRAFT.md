# Cowork Migration Runbook — Phase 2 Pilot (Strat decision 7)

*(DRAFT — produced in the 2026-08-09 parallel drafting session. Executes
post-S3-G, pre-Sprint-4. Anything marked [VERIFY AT EXECUTION] is a
Cowork product detail I could not confirm from this session — check it
against the app on setup day rather than trusting this draft.)*

---

## Plain summary

Doc-production work — close packages, Session Log entries, roadmap
maintenance, the eventual v3 migration — moves into a Cowork project on
your desktop, where Claude edits the actual files and you accept each
change by reviewing a diff, instead of downloading files and hand-placing
them. Design gates, rulings, and anything that decides how the product
works stay in the claude.ai Arch chat, exactly as now. The pilot is 2–3
doc sessions, then a review: keep it, fix it, or drop back to the
current flow.

---

## 1. What Cowork sessions MAY and MAY NOT do (the charter)

**May:** read the mounted files; draft and apply edits to governing
documents (Roadmap, Session Log, CLAUDE.md fold text, Brief technical
sections when Arch-proposed and Daniel-confirmed); produce close
packages; run the Roadmap v3 migration when that session comes.

**May not:** make or imply any design ruling (those live in claude.ai —
if a doc edit needs a ruling first, the session stops and says so);
write CC handoffs; touch anything outside the mount; edit prior Session
Log entries (append-only discipline binds here exactly as everywhere).

---

## 2. Setup steps

1. **Install/open the Claude desktop app** and sign in to the same
   account as your claude.ai project. Cowork is a tab inside the
   desktop app.
2. **Create a Cowork project for Minotaur doc work.** Name it something
   unmistakable — `Minotaur — Doc Sessions` — so it can't be confused
   with the Arch chat project. [VERIFY AT EXECUTION: Cowork's exact
   unit of organization ("project" vs. workspace/folder naming) and
   whether it supports per-project standing instructions; the porting
   step below assumes it does.]
3. **Mount the working scope — these two locations ONLY**
   (the decision-7 scope, drafted exactly):
   - The **governing-documents folder**. The governing docs need one
     canonical local home for Cowork to edit; proposed:
     `~/Developer/Minotaur-governing/` holding the Architecture Prompt,
     Brief, live Roadmap (later: Roadmap + Ledger), and live Session
     Log. [VERIFY AT EXECUTION: where your current canonical local
     copies actually live — if they're scattered, consolidating into
     this one folder is setup step 3a, and the claude.ai project
     knowledge copies become read-only mirrors updated from it.]
   - **`~/Developer/Minotaur/docs/reference/`** — the evidence and
     reference corpus, read-only in practice (doc sessions cite it,
     never edit it). Note: this folder contains the ~36MB gitignored
     v1 DDR; it's harmless in the mount (nothing reads it unasked) but
     don't point a session at it casually — it's parsed by streaming
     tools, not read whole.
   - **CLAUDE.md** is a special case: it lives at the repo root, not in
     either mounted location. Options: mount the single file
     [VERIFY AT EXECUTION: whether Cowork mounts individual files], or
     keep CLAUDE.md folds on the current upload-and-return flow for the
     pilot. Recommend the latter for pilot simplicity — one flow change
     at a time.

4. **What must NOT be mounted, and why (one line each):**
   - The repo source tree (`~/Developer/Minotaur/src` etc.) — doc
     sessions with code access invite uncommanded edits and merge
     collisions with CC sessions on the same tree.
   - `.claude/` (settings, hooks, deny lists) — the enforcement layer
     is not editable from a doc session, ever.
   - Any `.env` / credential / Supabase key material — secrets never
     enter a doc session's scope.
   - `~/Desktop` and the CC handoff files — handoff files are read and
     moved by you only; the never-auto-ingested rule survives the
     migration intact.

---

## 3. Project-instruction port

Cowork's standing instructions are a condensed slice of the
Architecture Prompt (v28 once installed), not the whole thing. Port:

- **Role framing** — doc-production session for Minotaur v2; Daniel
  decides, the session drafts; the charter in §1 verbatim.
- **Style rules** — plain-language-first, the ~4-sentence summary lead,
  bullets for 3+ items, the Session Log's append-only + State-of-Play
  discipline, the Docket Sweep line in every close package.
- **The diff-verify acceptance rule** (§5 below) in place of the
  full-file-delivery rule — full-file delivery exists to prevent
  hand-splice drift, and in-place editing with diff review solves the
  same problem a different way; the two rules never run together.

Leave out: handoff machinery, Milestone Triggers, migration/MCP
authority, the Parity Rule's build-side text (the doc side — cite
rulings by ID, never invent — is already in the charter).

---

## 4. The day-one context package (exactly what a Cowork session reads
## to get up to speed)

In order, at every Cowork session open:

1. Its own standing instructions (§3).
2. The live **Roadmap** (v2.47, or the Roadmap+Ledger pair once v3
   lands) — from the mount.
3. The live **Session Log** — from the mount.
4. **The Architecture Prompt** (reference for style/discipline rules it
   inherits) — from the mount.
5. The **Brief v1.1** — only when the session's task touches it.
6. For the v3-migration session specifically: `Roadmap_v3_Skeleton.md`
   (the migration procedure is in it).

Nothing else. No chat transcripts, no CC handoff files, no evidence
deep-reads unless the task names one. If a session needs something
outside this list, it asks; it does not go looking.

---

## 5. The diff-verify acceptance step (replaces hand-placement)

Plain version: instead of downloading a file and saving it over the old
one, the session edits the mounted file and you approve the change by
reading the diff. Nothing is accepted unread.

1. The session states, before editing: which file, what change, one
   line why.
2. It applies the edit to the mounted file.
3. You review the change as a diff — [VERIFY AT EXECUTION: Cowork's
   built-in change-review surface; if it shows edits clearly, use it.
   Fallback that always works: the session writes a
   `<file>.pre-edit` copy first, and you compare before accepting;
   for repo-tracked files like CLAUDE.md, `git diff` is the reviewer
   of record.]
4. Accept or reject per file, per session. A rejected edit is reverted
   immediately from the pre-edit copy (or `git checkout`), not patched
   forward.
5. Session Log deliveries remain whole-document in shape (header +
   every live entry) — the diff you review should show ONLY the new
   entry and the header update; any diff touching a prior entry is an
   automatic reject.

---

## 6. Pilot success / abort criteria (review after 2–3 doc sessions)

**Success looks like — all four:**
- Close packages land faster than the chat flow, with zero
  transcription defects (no dropped lines, no mangled prior entries —
  the exact failure class full-file delivery was built against).
- Discipline held: prior Session Log entries byte-untouched, headers
  current, Docket Sweep present in every close.
- Zero scope excursions: no rulings made, no files touched outside the
  mount, no CC handoffs drafted.
- The diff-review step costs you less time and attention than
  download-and-hand-place did.

**Abort — any ONE of these ends the pilot on the spot:**
- An edit outside the mount, or any uncommanded write.
- A ruling or design decision made (not merely flagged) in Cowork.
- A prior Session Log entry or Ledger entry modified.
- A governing doc corrupted in a way the pre-edit copy / git can't
  cleanly restore.
- Diff review proves more burdensome than the flow it replaced.

**On abort:** restore any affected file from its pre-edit copy or git;
log the abort and its cause in the Session Log (from claude.ai); return
close-package production to the claude.ai flow. The mount and project
can stay in place, dormant — aborting the pilot doesn't require
uninstalling anything.

**On success:** the review session (claude.ai, with Strat) decides what
else moves — candidates in decision order: the Roadmap v3 migration
session, then routine close packages as the default home.
