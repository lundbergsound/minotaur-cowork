# PREBETA-FRICTION — the three defects the cohort meets first

Tier: 3 (Claude Code)
Session: **FRESH.** Nothing is in flight. The last unit, VERHIST-UI Leg 1, is committed and pushed — code repo `refs/heads/main` and `refs/remotes/origin/main` both read `96efd113b4d232919ba121cb5da1f045384e7ee7`, read from the ref files, no lock files present.

**Unit:** one bundled pre-beta friction pass — **CABLEDEL-LATENCY**, **AUTH-REFRESH-HANG**, and the buildable half of **BATCH-PREBETA**. Three checkpoints, one CC run, one commit.

**Bundle discipline (HANDOFF-BUNDLE, Daniel 2026-09-11):** this is one long handoff, not three small ones. Do not split it, do not return between checkpoints, and do not ask which order — the order below is the order.

⚠ **NO SCHEMA. NO MIGRATION. NO DEPENDENCY CHANGE.** If any of the three turns out to need one, halt and return it; do not work around it.

---

## What is NOT in this bundle, and why — do not pull any of it in

`BATCH-PREBETA`'s member list is older than most of its members' current status. Measured against the live Docket at Roadmap v4.31 this session:

- **INSPECTOR-ARM** — the other half of Daniel's 2026-09-11 gate pair. Two fixes are proposed, **both UX-affecting and both unruled**. It waits on his ruling; the Parity Rule forbids picking one.
- **SHARE · (ppp) settings header · 3TL · ADM-1** — every one of them rides SHARE, which is a **Trigger A** being scoped by Arch in this same session. Nothing that touches the sharing surface builds before that scope lands.
- **AUTH-DOMAIN** — custom-domain auth email. Provider and DNS configuration, Daniel's, and squarely in CC's hard-stop class.
- **DEPS** — dependency maintenance. **A dependency change is a named CC hard-stop**; it gets its own unit with its own approval, never a ride inside another.
- **CL-HILITE** — a new highlight control on the cover-letter editor. A new operator-facing control with no ruled design has no pedigree; **uncited = unbuilt**.
- **GCM completion** — post-beta by the Roadmap's own sequence.
- **IMPRPT-COPY** — carried from v4.6 with no measured surface behind it. There is nothing here to write an instruction against, so it is not written.

---

## 0 · Before you write anything

**Read at source, not from this file — the Surface Rule outranks every description below.**

1. `src/middleware.ts` and `src/lib/supabase/middleware.ts` — both short, both load-bearing for access control.
2. `src/components/cable/CableListClient.tsx`, the block `:2950–3050`, **including its comments**. They record why each shape is what it is (CHANGEALL-FOUNDSET, AMEND-1 A5, S3F-R5). A comment there is a finding, not decoration.
3. `src/lib/cable/` — wherever `runPreDeleteCascade` lives, and `selectByIdsChunked`.
4. `src/lib/export/sheetNames.ts`, `src/lib/export/runExport.ts` (the report block), and `src/app/project/[projectId]/settings/page.tsx` `:470–500`.
5. `src/lib/queryKeys.ts`.

**MEASURE THE BASELINE AT THE OPEN AND WRITE THE NUMBERS DOWN BEFORE YOU TOUCH A FILE.** `npm test` · `npm run type-check` · `node scripts/frozen-gate.mjs` · `npm run build` · `npm run test:visual`. ⚠ **Do not carry a baseline from any document, this one included** — a stale suite count reached a handoff last session (2980/157 quoted against a measured 3088/160) and it is an Arch error being deliberately not repeated. For orientation only, and to be superseded by your own run: 162 `*.test.ts(x)` files exist at HEAD.

---

## 1 · Checkpoint 1 — AUTH-REFRESH-HANG

**The defect:** a failed Supabase token refresh blocks every matched route for roughly ninety seconds before falling through. The operator sees *"the app is broken"* where the truth is *"please sign in"* — and these operators are in dark rooms, in tech, under time pressure.

**Measured at source this session:**

- `src/middleware.ts:8-11` — the matcher is `'/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)'`. It excludes **static assets and nothing else**, so every page route and **every `/api/*` route** runs `updateSession`. The comment at `src/lib/supabase/middleware.ts:29-32` (DOOR-MW) says so explicitly.
- `src/lib/supabase/middleware.ts:24` — `const { data: { user } } = await supabase.auth.getUser()`, unconditional, **before any route decision is made**. Nothing on this path bounds how long that await may take.

**The job, in this order:**

**(a) Bound the wait.** Race `getUser()` against a timeout you choose and **state the number and your reason for it in the source**. On timeout, resolve as **no user** — that is the truthful state for a session whose token could not be refreshed, and it is the state that already has a correct handler at `:36`. A dead or slow auth host must cost seconds, not ninety.

**(b) Do not reduce protection.** The redirect at `:36` is the access control for the whole application. Removing work from the middleware is in scope; removing *protection* from any route is not. ⚠ **If the only correct fix requires changing which routes are protected, that is a hard stop — halt and return it.**

**(c) Keep the two documented carve-outs and their comments.** `isWaitlistRoute` at `:33` (DOOR-MW — without it a signed-out `POST /api/waitlist` 307s to login and the form fails silently) and the landing-page redirect at `:51` (DOOR-DBLAUTH — the SEO-load-bearing hero renders with zero network dependency because the middleware already holds the user). Both are findings paid for once already.

**(d) ⚠ NO NEW OPERATOR-FACING TEXT.** *"Please sign in"* versus *"the app is broken"* is the shape of the defect, not a licence to write the sentence. Any message this fix would put on screen is **pedigree (c)** — put it in **one** constant, mark it in the source as an OPEN QUESTIONS proposal awaiting Daniel's wording, so his sentence replaces it in a single edit. That is exactly how `SNAPSHOT_REFUSAL_MESSAGE` was carried before he ruled it.

**Success condition:** a test proves (1) the middleware resolves inside the chosen bound when the auth call hangs, (2) a signed-out request to a protected route still redirects to `/auth/login`, and (3) `/api/waitlist` and `/` still do not.

---

## 2 · Checkpoint 2 — CABLEDEL-LATENCY · **MEASURE FIRST, THEN FIX**

**The defect:** one cable took **~6 seconds** to delete on a real production (Daniel's browser gate, 2026-09-11).

**Facts of record. Re-measure them; do not trust them.** The path is **byte-unchanged** by VERHIST-FANOUT and makes **zero snapshot calls**, measured. It did **not** reproduce on a bare throwaway at the same 459 cables — that measured **757 ms**. So the difference is **topology, not scale**: 26 bundles, 175 tails, 23 boxes, ~1,300 link members. **CDMX and the US Tour are bigger than the production this was found on.**

**Measured at source this session — the whole single-cable path:**

- `confirmDelete`, `CableListClient.tsx:3028–3050`: `rehomeAndPurgeBeforeDelete([id])` (`:3033`) → one `equipment_items` delete (`:3038`) → **three** invalidations at `:3045–3047` (`equipmentList`, `createdAt`, `cableNotes`).
- `rehomeAndPurgeBeforeDelete`, `:2956–3026`: `runPreDeleteCascade` with thirteen injected callbacks, of which these are awaited network round trips — `reparentLines` `:2963`, `reparentTails` `:2966`, `deleteTailsOf` `:2979`, `listLineIds` `:2984` (chunked), `listPartnerLines` `:2991` (chunked, **halved chunk size**, de-duped), `writeLinePatch` `:2999` **per row**, `writeCablePatch` `:3007` **per row** — then up to **two more** invalidations at `:3020` (`multLineList`) and `:3022` (`tailList`).

So: **up to five `invalidateQueries` calls**, each refetching its active query, sitting on top of a cascade whose two patch writers are awaited **one row at a time**.

**Two candidate causes, and they are not the same fix:**

1. **The per-row awaits.** `writeLinePatch` and `writeCablePatch` are O(rows) sequential round trips. That is the exact shape of `CHANGEALL-MODEL-SERIAL` (`EquipmentListClient.tsx:2295`), and it would scale with link-member count precisely the way Daniel's ~1,300 members do while a bare fixture's topology stays flat.
2. **The five invalidations.** Each one refetches a large active query; `equipmentList` on that production is the expensive one.

**The job:** instrument the real path on a real-shaped production, **report per-stage raw timings**, and fix only what the numbers name. A guess that happens to help is not this checkpoint's output.

**Constraints:**

- ⚠ **Do not change WHICH rows are written.** The cascade's correctness is CHANGEALL-FOUNDSET's, bought with a live defect. Read `:2969–2998` before touching anything — in particular `:2973–2978`, where the select-then-delete pair it replaced silently orphaned every tail row above the request-size ceiling, and `:2987–2990`, where the id list is spent twice in one URL and is why that chunk is halved.
- **Coalescing the invalidations** into one batch after the delete, instead of five interleaved, is a legitimate fix. **Removing** one is a correctness question, not a performance one, and needs a stated argument.
- **Parallelising the two per-row writers** is legitimate only if row order does not affect the result. Prove that from the cascade's own code, not from this file.
- The whole path is **non-visual**, so the fix needs no pedigree. ⚠ **Anything that changes what the operator sees** — a spinner, a progress message, a different row landed on afterwards (`landAfterDelete`, CP-B6) — **does**, and is a halt.

**Success condition:** a **before/after measurement on the same production at the same cable count**, with the per-stage breakdown, naming which stage held the time and what it costs now. **A fix with no before-and-after number is not done.**

---

## 3 · Checkpoint 3 — EXPRPT-STALE

**The defect:** the v1 export report lists **four filenames of fourteen**.

**Measured at source this session:**

- `src/app/project/[projectId]/settings/page.tsx:478–481` hardcodes `equip.xlsx` · `library.xlsx` · `methods.xlsx` · `categories.xlsx`; `:483` then tests membership of `exportResult.report.filesOmitted`.
- `src/lib/export/runExport.ts:788–799` — `ExportReport.rowCounts` already carries **all fourteen** classes (…`boxes`, `boxTypes`, `cable`, `lines`, `tails`, `bundles`, `defEnds`, `defTails`, `cableCloneLinks`, `bundleCloneLinks`).
- `runExport.ts:865` — `filesOmitted` is **already derived** from `ALL_EXPORT_FILENAMES`.
- `sheetNames.ts:138` — `ALL_EXPORT_FILENAMES = Object.values(EXPORT_FILENAMES)`, and the comment at `:111` says the derivation exists *"so a new sheet cannot reach the zip without also reaching the omitted-files report."* **The UI is the one place that broke that guarantee.**

**The job:** render the report from the same derived source, in `EXPORT_FILENAMES`' declared order, so the rendered count cannot drift from the built set again. **Pin it with a test that fails if the rendered filename set is smaller than `ALL_EXPORT_FILENAMES`** — a test that asserts "four" is the defect written down.

**Pedigree — (b), evidence:** `EXPORT_FILENAMES` / `ALL_EXPORT_FILENAMES` is the artifact that names the set, and the four-of-fourteen render contradicts it. **Every filename and the existing "omitted (0 rows)" treatment are reproduced verbatim — no new wording anywhere.** ⚠ Note `'box types.xlsx'` and the four cable multiword names **carry spaces**: that is v1's own naming, reproduced verbatim per `sheetNames.ts:114-115`. Do not normalise them.

⚠ **This checkpoint can legitimately move visual gate frame 06** — the export section's at-rest hint text sits inside it. **A moved frame is still not yours to adopt:** measure the per-frame diff and bounding boxes, report them, and **return it as a declared baseline event for Daniel**. Never `--update-baselines`.

---

## 4 · Hard stops — return, do not proceed

- **Any schema, function, RLS or grant need** — including one you think is trivial.
- **Any dependency change**, including a version bump or a new dev dependency.
- **Frozen-layer contact.**
- **Any change to which routes the middleware protects.**
- **Any operator-facing text without pedigree.** Checkpoint 1(d) is the one known case and it is a marked proposal. A second one is a halt, not a judgement call.
- Ambiguous evidence · destructive or irreversible operations · credentials, secrets or money · anything raising an OS-permission or OAuth dialog.
- ⚠ **Single-file edits go through the Edit tool, no exceptions** — no `sed -i`, no `perl -pi`, no bash heredoc writes into the repo. A bash write bypasses the PostToolUse frozen-check hook, which is the entire reason for the rule (CCSED-260911).

---

## 5 · Gates and close

Every checkpoint runs the full set: `npm test` · `npm run type-check` · `node scripts/frozen-gate.mjs` · `npm run build` · `npm run test:visual`, plus the standing browser smoke against a throwaway project created and destroyed in-run.

**Raw Output Rule — verbatim:** *"Reproduce the complete raw output verbatim — into the handoff file's RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize, paraphrase, or describe it. Show every line. The architect cannot verify correctness from a summary."*

**A number in the return is a measurement or it is not written.**

**Commit — WF-1a.** Stage by explicit filename. Commit only after Daniel types `COMMIT APPROVED: <first words of the commit subject>` in the terminal. ⚠ **A WF-1a push IS a production deploy** — Vercel builds every push to `main` — so the phrase approves a release. ⚠ **The push half is INERT until FENCE-PUSH lands:** `git push` is denied in `.claude/settings.json` and by `.claude/hooks/bash-fence.sh`. **State the block plainly; do not route around it.** The push is Daniel's paste.

**Return** lands at `handoffs/from-cc/YYMMDD-hhmm_prebeta-friction.md` — DONE / FILES CHANGED / OPEN QUESTIONS / RAW OUTPUT — plus `handoffs/from-cc/YYMMDD-hhmm_prebeta-friction_CLOSE.txt` on commit, with the measured counts, the pushed state read from the ref files rather than from git, what closed, what stays open and who owns it.

**Return to Daniel when:** all three checkpoints are green, the CABLEDEL before/after numbers are in the return, and either the commit has landed on his phrase or you are halted on something in §4.

---

# ⚠ CORRECTION — appended 2026-09-12 by the Arch main line, after CC's return

**§5's push claim above is WRONG and CC was right to bounce it under the Surface Rule.** It said *"the push half is INERT until FENCE-PUSH lands"* and *"`git push` is denied in TWO places."* Neither is true at HEAD, and has not been since **2026-08-30**.

**Measured at source by this seat, independently of CC's return:**

- `.claude/settings.json:6` — `"Bash(git push)"` sits in **allow**. Deny (`:22-23`) carries only the destructive family: `--force*`, `-f*`, `--delete *`, `--mirror*`.
- `.claude/hooks/bash-fence.sh:47-51` — an explicit **FENCE-PUSH (2026-08-30, Daniel's ruling)** block: a bare `git push` is PERMITTED; force in any spelling, a leading `+` refspec, `--delete`/`-d` and `--mirror` stay blocked. Its error string at `:131` says so in as many words. The file carries its execute bit.
- `CLAUDE.md` has it **right in at least six places** (`:137`, `:276`, `:280-282`, `:306`, `:326-340`, `:365`, `:1569-1570`, `:1637`).
- Roadmap v4.31 `:239` lists **FENCE-PUSH as CLOSED** at `9a333cc` / `0bf6df3`.
- Session Log header: *"⚠ **FENCE-PUSH IS LIVE.**"*

**The cause, and it is the finding: `Architecture_Prompt_v35.md:198` is the ONLY live document still carrying the stale claim** — installed 2026-09-11, twelve days after the ruling and one day after its own rewrite. This seat read v35 at the open and restated the rule into a handoff, carrying its reason as instructed, and the reason was obsolete. **A bare rule gets rationalised past; a stale rule carried WITH its reason gets propagated instead.**

⚠ **Independently corroborated the same day** by the META parallel, which reached the identical conclusion by **running cases through the fence rather than reading it** (`handoffs/parallel/260912_meta_FENCE-AND-PUSH_PROPOSAL.md`, Proposal 1, battery cases C4 / P1–P6).

**Consequence, ruled by Arch 2026-09-12:** CC executes the full four-step commit block, **push included, on Daniel's phrase**. The phrase approves a **production deploy** — Vercel builds every push to `main` — which is why GATE-BEFORE-COMMIT's ordering is load-bearing and the browser gate runs **before** the phrase, never after.

**Propagation owed at this session's close (O-8):** `Architecture_Prompt_v35.md` → v36 §Commit authority, rewritten. `CLAUDE.md` and the Roadmap's retired index are already correct and need no change. Roadmap v4.31 `:169` (FENCE-HEREDOC's trigger reads *"with FENCE-PUSH"*) and `:259` (BATCH-HOUSEKEEPING lists FENCE-PUSH as a member) are **dangling references to a closed unit** and are repaired in the same pass.
