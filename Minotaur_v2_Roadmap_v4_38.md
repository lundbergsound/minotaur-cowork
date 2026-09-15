# 🗺️ ROADMAP — Minotaur v2 (v4.38)

## ▶ NOW

The front door is finished and live. The beta terms are in force, the mail sender
is our own, and the recovery code works for the first time. Jamie Tippett and Mike
Tracey are in — the first two people outside this office ever to use v2.

Nothing is building. What stands between here and the other fourteen is sharing:
five permission migrations and one roster screen.

Jamie's first night produced eight findings, one of them urgent, and a design
session found a backup that would have silently dropped every cable on a shared
show. Both are below.

## ⏭ NEXT — the next three sessions

1. **Sharing.** A show belongs to one person today, and nobody else can open it.
   Five database permission changes, one at a time with your confirm, then one
   screen where a lead types a colleague's address and that person appears on the
   show. Nobody is added to any show until the second of the five is in.
2. **BATCH-COHORT-1.** Jamie's urgent bug and everything near it, pulled forward.
3. **The invite.** The accounts, the note, the cohort brief.

**Yours:**

- The sixteen accounts, minus the two that exist.
- The invite note and the one-page cohort brief.
- A cable label print on real stock, the 5167 sheet with it, and the READY check.
- Which methods palette is correct — v1's, not ours (METHODS-PALETTE).
- CABLEDEL-FAILMSG's wording, and YES or KEEP on the sign-in placeholders.

## 🏗 THE SEQUENCE — the road, in order

- **≈2026-09-18 — PRIVATE BETA.** Sixteen leads plus their teams, 30–40 people.
  Needs **SHARE-MIGRATIONS** (65–69), **SHARE-ROSTER**, **BATCH-COHORT-1**,
  **AUTH-POLISH**, **APPLY-TIMEOUT**, the accounts, the invite, a label print on
  stock, and the READY check. Terms are in force; that gate is passed.
- **The four weeks after — fix what the cohort finds.** **CONTRAST-PASS** ·
  **BATCH-HOUSEKEEPING** · **VIEWER-ROLE** · **VERHIST-COUNTER** · **ENTITLE-V1**
  scoped and built. PROCESS-REFACTOR's remainder opens as a parallel once week-one
  fixes ship.
- **Target 2026-10-15, floating — V1-HOLDER BETA.** Free with an active v1 licence —
  any tier except trial, expiring on or after 2026-04-15 — gated on the terms,
  ENTITLE-V1 and **BETA-SIGNUP-GATE**, without which ~185 people have no way in.
  The announcement is the drop; no tease.
- **~November — LICENSING.** v2 checkout on the REGISTRY (payments and subscriptions
  are migrations 66–67), with an attorney review before the first charge and the New
  York auto-renewal rules built in (**GBL-527A**). **SEAT-CAP** before anyone is charged.
- **RELEASE — $199.** v1 included on request, none sold à la carte; v1 Personal
  holders free to the end of their year; v1 Production holders free during the beta,
  ~$100 after. Production tiers unchanged (NfP $349, Commercial $599, perpetual per
  project). Named-user accounts; one active session per Individual.
- **Stop condition: paid beta by ~March 2027.**
- **Off the road, released by trigger and not by date:** the fail-open controls,
  FIELD-CONTRACT leg 3, BATCH-HOUSEKEEPING's remainder, `duplicate_item_v1`, META's
  Tier 2 and 3, ORG-TIER, MONTHLY-HOLD.

---
## 📌 THE DOCKET

Three tables. **▶ ACTIVE** is being worked, dated, or owed now. **⏸ HELD** waits on
a named unit or trigger. **📐 STANDING** binds indefinitely and never closes. A row
is one line: what is owed and who owns it. Reasoning lives in the Ledger; row text
as it stood before v4.38 is in `Minotaur_v2_Roadmap_v4_37.md`, kept in the repo.

### ▶ ACTIVE — units, not items

| ID | One line | When / trigger |
|---|---|---|
| **SHARE-MIGRATIONS** | Five policy-level migrations from SHARING REV-B, all rehearsed under forced rollback with 21 privilege probes green, nothing applied: **65** helpers (`can_read_project` / `can_write_project` / `can_admin_project`, replacing forty hand-written subqueries) · **66** the seven cable tables · **67** the eighteen-table sweep · **68** settings, features and the four owner-only storage policies (today every print a collaborator makes is missing its letterhead) · **69** roster, self-leave, owner protection, the `admin` CHECK and `project_member_names()`. ⚠ **HARD RULE: nothing but `owner` enters `project_members` until 66 is applied — including the first row created to test sharing.** Each is Trigger B, one confirm at a time. Add one storage probe against a real bucket object at apply time; the rehearsal was DDL only. ⚠ **Not applied while a CC unit is live** — the sweep rewrites policies on 34 tables and CC's gates read them. | Arch, when CC returns |
| **SHARE-ROSTER** | The sharing panel itself — CC's, and the largest remaining build before the invite. A lead types an address; if it has an account, a membership row is written and access is immediate. Every accepted member sees the roster (D-3). Absorbs **WHOCOL-RLS**: `profiles` stays self-only and one function returns `(user_id, display_name)` for one named project, including past snapshot authors so Who does not re-open as a raw uuid the moment someone is removed. ⚠ **Zite built sharing too — study its interaction options before the handoff is written, not during the build. Parity is NOT wanted; the ideas are.** | After SHARE-MIGRATIONS; gate ≈Sept 18 |
| **SHARE-PROVISION** | A lead's teammate who has no account: the app records nothing and creates nothing; Daniel runs the provisioning script from his own environment on the `gate-a-isolation.mjs` pattern (service key from the environment at runtime, never in the deployed app) and it prints the three-step note for him to send. ⚠ **It must not set a password**, or the account skips the terms acceptance the set-password page records. MAILGATE holds; the app sends nothing. No `teammate_requests` table before the invite (D-7). | With SHARE-ROSTER |
| **BATCH-COHORT-1** | ⚠ **Pulled forward on Daniel's word 2026-09-14 — make the bundle soon, even bundling things that would otherwise be later.** The equipment-list fixes, one handoff: **GROUPCELL-BLANK** (⚠ Jamie, urgent — a row whose group field is blank cannot be clicked into, so a group can never be set on a row that has none; cause unmeasured) · **EQUIPSORT-NODESC** (a description-less row sorts below described ones sharing a model; v1 puts it above) · **AUTOCOMPLETE-NOPORTAL** (six call sites; visible in Jamie's first screenshot, the dropdown cut off at the window edge) · **CHANGEALL-NAALIAS** · **BOXBAND-DUPKEY** · **CATCOUNT-COLUMN** · the blank-box-follows-linked-rows rule · **METHODS-PALETTE**'s code half. All ruled; none needs a new decision. **Independent of the sharing schema — this is what CC runs while Arch waits.** | The first CC handoff of the next session |
| **AUTH-POLISH** | What is left of the auth bundle after its equipment-list half moved to BATCH-COHORT-1 and its link colour moved to CONTRAST-PASS: the sign-in page's two inputs on live steps (**Daniel: YES or KEEP on the placeholders — KEEP needs a ruled placeholder colour, so YES is cheaper**) and **CABLEDEL-FAILMSG**'s wording. ⚠ When CP4 runs, the dead-step positive control at `resetSurface.test.ts:68-70` must move to a file that still carries one BEFORE the login assertion goes to `[]`. | Daniel's two words, then one small unit |
| **METHODS-PALETTE** | ⚠ **Measured 2026-09-15: two palettes exist under the same colour names.** `global_default_methods` holds saturated (Chartreuse `#80FF00`, Pink `#FF69B4`, Aqua `#00FFFF`); new projects are seeded pale (`#B8D586`, `#F6C6D8`, `#94E3FE`) from a second source. Jamie's `Foo` is pale, `Memoirs` is saturated, `Liberation` is mixed — the fingerprint of hand-fixing. BVSC, the US Tour, the Cable Parity Fixture and Vape! are all pale. **Read the v1 source before writing anything — pale may be the original and saturated the drift.** Two halves: correct the seed, then decide what happens to projects already seeded (a data migration, Trigger B). | Daniel rules the palette; code half rides BATCH-COHORT-1 |
| **APPLY-TIMEOUT** | A full-size v1 import hits the 8-second ceiling and writes nothing (the design working); the snapshot half is fine at ~570 ms. Ceiling measured live 2026-09-14: `authenticated` and `authenticator` both `statement_timeout=8s`, `anon` 3s. ⚠ **Measure what a real import costs before raising anything — if it does not fit, the answer is not a bigger timeout.** Trigger B. **RULED 2026-09-15: runs as a PARALLEL, spun off once CC is confirmed working.** Do not run a heavy import measurement while the visual gate runs. | Parallel next session; gate ≈Sept 18 |
| **BETA-INVITE** | The invite note (Email Prompt) and the one-page cohort brief (Writing Prompt). Required: the two ruled sentences (forgot your password → email me; v1 stays your source of truth), the three-step sign-in instruction, the two-sentence terms fragment, one sentence on GLOBAL-LIB. RULED 2026-09-13: no confidentiality ask anywhere. CAND-4's four personal texts fold in. | Daniel, before ≈Sept 18; MAILGATE per send |
| **COHORT-ACCOUNTS** | Fourteen of sixteen still to create by hand (create user, auto-confirm, no password — no mail sent). ⚠ **Tippett `jtippettsound@gmail.com` and Tracey `mike@mtsounddesign.com` exist as of 2026-09-14** — Tracey's account is at his sending address, not the `mtracey@me.com` COHORT-EMAILS ruled; the row is corrected here so no future session "fixes" a working account back to a dead one. Haggerty needs a membership row, not an account (CAND-4). Then **PROFILE-REALNAMES**: Arch writes real names into `profiles.display_name` in one confirmed pass — Jamie's currently reads `jtippettsound`. ⚠ Now load-bearing for History's Who column, not only the greeting. Separate first/last columns are wanted eventually; `registry.people` has **only** `display_name` today, and is the right eventual home. | Daniel, before the invite; names then Arch's |
| **CONTRAST-PASS** | ⚠ **The unlock.** Jamie: raise contrast everywhere in both themes and assess type that is too small; the proposal is five renderings, or a temporary switcher between five mockups. DEADCLASS-SURFACE's 105 dead `text-surface-400..700` classes have sat blocked on "which should be dim is not machine-decidable" — five mockups make it decidable by looking. **Absorbs DEADCLASS-SURFACE · the bounced auth link colour (`--brand-link` is tuned for `surface-0` grounds and the auth pages sit on `surface-950`, the opposite polarity: it would take dark from 2.42:1 to 1.64:1) · CONFIRMBTN-FLIP (`ConfirmDialog` pairs a static yellow ground with a flipping token: 8.17:1 light, 1.39:1 dark, 27 files import it) · CONTRAST-PAIR (`ImportV1Client.tsx:1105`) · the type-size assessment.** APCA reported beside WCAG. ⚠ **Runs AFTER FONT-FALLBACK.** Acceptance is Daniel picking one rendering. **The runner-up parallel if APPLY-TIMEOUT is not taken.** | Week one |
| **FONT-FALLBACK** | RULED 2026-09-14: **Jost**, self-hosted at build, behind Century Gothic. Stack collapses to `'Century Gothic', Jost` — `AppleGothic` (a Korean face, wrongly ahead of Futura), `Futura` and `Trebuchet MS` come out. Found by Jamie, who does not have Century Gothic: **the app ships no font file, so every print-parity measurement assumed a typeface most users may not have.** Webfont licensing declined — Monotype sells it annually by pageview tier, so it grows with success. Expected no baseline event (the gate renders on a machine that has the font) — **measured, not predicted**. One comparison render confirms row heights hold. | BATCH-HOUSEKEEPING, before CONTRAST-PASS |
| **BATCH-HOUSEKEEPING** | **Runs BEFORE PRINT-RULES (ruled 2026-09-14)** — housekeeping repairs the fence and the frozen-check hook, and PRINT-RULES is measured by them. Members: FONT-FALLBACK · TYPES-REGEN (stale by six migrations; this set changes no table shape) · LINT-DEAD · FENCE-INTERP + COMMITMSG-PATTERN · REPO-STRAY-UNTRACKED · the four registry migration files into `supabase/migrations/` · FROZENCHECK-FAILOPEN · CLAUDEMD-RIDERS · RPC-COUNTNOTERROR's sentence · DEFINER-ANONEXEC's one real item (`handle_new_user` has no `search_path`) · LINECOLOR-ZERO · ADMIN-NEWDUP · CREATEMETHOD-BLINDERR · DEADEXPORT-GRIDCOL · SRGRANT sweep · ST-RACE · CTF-SEED · SLOT-AUDIT residue · REPO-WEIGHT · BOX-TYPES-DIM-DROP · GIT-CFG · PROJ-CLEAN-2's last project. | Week one |
| **VIEWER-ROLE** | D-1: the beta ships **editor-only**, so nothing in it is read-only. Viewer and its whole-app control inventory move here together — every edit control on every surface must be found and hidden, because a control that would be refused must not be rendered. Re-reads **D-5** (`private_notes` readable by any member) with the role in hand. Its permission rules are already written and green. | Week one |
| **VERHIST-TRUNCATE** | ⚠ **`snapshot_project_v1` is SECURITY INVOKER and reads seven owner-only cable tables under the caller's RLS, coalescing a blocked read to `[]`.** The day a non-owner membership row exists, any of the twenty commit points writes a backup with no cable system in it, returns a uuid, and the guard reads that as success. Measured: editor fires change_all → 10/0/0/0/0/0/0/0 against a truth of 10/7/1/1/1/1/1/1; after 66 → 10/7/1/1/1/1/1/1. **Version history's defect, armed by sharing.** Closed by migration 66; **VERHIST-COUNTER** then makes the class impossible rather than merely unreachable (D-6). | 66 now; counter week one |
| **VERHIST-REST** | The rest of version history, in order: **VERHIST-FORK** ("open as new production" — a migration, rehearsal-first, design at `drafts/260911-1600_verhist-fork_DESIGN.md`; ~4,000 rows against an 8-second ceiling is the open measurement; Trigger B; DEFERRED past the invite) carrying **VERHIST-REVBLOB** (a fork carries the original's Equipment List Revisions as a third content-hashed blob, `schema_version` bump) · **VERHIST-GESTURECLASS** + **VERHIST-680** (one pass enumerating every gesture that writes or deletes across a scoped set; the 2026-09-10 ruling named four and the app has more) · **VERHIST-BLOBWATCH** (re-measure blob count and size per project; the justification rested on three edits ever, all Daniel's). | After the invite; GESTURECLASS before the cohort finds one |
| **PRINT-RULES** | One bundled handoff, ruled 2026-09-13: solid row rules (EQUIPLIST-DOTRULE) with the preview clip measured in the same pass (PREVIEW-CLIP), methods without a sort override printing after those with one (METHOD-SORT-ORDER), and the ruled hint line (PRINT-HINT-EQUIP, `PrintEquipmentListClient.tsx:951`). **AFTER BATCH-HOUSEKEEPING, never bundled with it.** Frame 07 may move (baseline event). | After BATCH-HOUSEKEEPING |
| **BATCH-LAYOUTS** | The nine queued v1 layouts, designed 2026-08-28/29 against real v1 prints, **none built, all greyed out**: LAYOUT-FINDSCREEN (six of them land on a find-or-options screen v2 has never built; four want the same `Add Blank Records` skip-N control — **design the screen and the offset ONCE**) · GROUPPARTS (menu 167, 974/976, ~1.5u) · DEVICEPATCH (menu 168, the largest, 1,919 rows / 384 devices, ~2u) · EQUIPLABELS (menu 172, 356/357; its Trigger B prerequisite shipped as migration 57, so the August estimate overstates it; ~1u) · BUNDLESUMMARY (menu 193, 71=71, ~1u, the cheapest full document) · LINELIST (menu 198, 96pp=96 mults, ~1u) · BUNDLELABELS (menu 208, 71→142, ~0.5u) · STECKLABELS (menu 211, 342=342, ~1u) · TAILFOLDER (menu 216, 8=8, ~0.5u). Arbiter filenames, measured counts and per-layout estimates in the Ledger's twenty-first append. Blocked on MARKER-OVERHANG for real stock. | After the invite |
| **BATCH-BOX** | The box residuals, one family: **BOX-DOC-PARITY** (⚠ its trigger fired 2026-08-30 and the row sat in HELD until the 2026-09-14 audit — the Box List and Contents List have never had a v1 parity round) · **BOX-PRINT-CLIP** (same two documents on the estimate paginator, likely losing rows, unmeasured) · **BOX-REPRINT** (v2's five box outputs never checked against a v2 render — Daniel's desk) · **EQUIPLIST-ESTIMATE-PAGINATOR** · SMALLNAME-STEP · BOXLABEL-ZERO · BOX-REPARENT · BOX-NAME-UNIQ · BOX-ALPHA-UNSAMPLED · BOX-TYPE-VOL · BOX-LABEL-COUNTS · BOX-EXPORT-ORDER. | After the invite |
| **FIELD-CONTRACT-3** | Leg 3 and its dependants, one unit: CABLEGROUP-EDITOR (a bundled cable's group field becomes inherited text; the Find half shipped) · CABLE-FINDDEFAULT (`CableListClient.tsx:476` reads `[data-b2-field]` only) · FINDFLAG-CHECKBOX (a flag criterion becomes a pre-checked checkbox; needs a third `FindFieldType`) · CHANGEALL-METHODDOCTRINE · **CDMX-DEFERRED**'s four (CABLE-NAME-COMMIT, CABLE-CHANGEALL-BOX, CABLE-TAB-BUNDLE-METHOD, BOXBAND-DOCTRINE) · FIELDCONTRACT-3B (scope from the Ledger's tenth append first). | After the invite |
| **EXPORT-INTEGRITY** | One export unit rather than six: EXPORT-HISTID-DROP (852 of 1,119 cables; **the figure it rested on is contradicted and must be re-measured before design**) · EXPORT-CARRIES-STATE (`no_box_needed` dropped; `N/A - Labels Only` where v1 expects `0`) · CATNOTE-EXPORT-LF · RENAME-HASHDRIFT (a rename mints duplicates on shows with no v1 HistoryIDs — Vape!, Matchbook) · APPLY-PROMISE-GAP (913/2,036 promised, 912/2,034 held) · CABLE-AUDIT-TIME · LINECOLOR-ZERO · ROUNDTRIP-INMEM · LINKJOIN-FENCE · IDMAP-ORPHAN-REIMPORT (823 orphan identity rows on BVSC Mexico; what a re-import does against that residue is unmeasured) · BUNDLE-LINK-IMPORT. ⚠ **FIXTURE-NUMLABELS-GONE first — look at what ran before re-importing; a re-import overwrites the evidence.** | After the invite; IDMAP before any import unit |
| **CABLE-SPLIT** | v2 has split columns and no split feature. Trigger A. Carries SPLITEND-DAISY and SPLITOF-NO-ARM. UNBLOCKED 2026-09-13: Paradise Square (New York) at `~/Minotaur_v1_exports/Paradise_Square_NY/` — 24 cables with splits, 146 `Split of` rows. Ruled: no upload to minotaur.app until the unit is designed and built; the upload is then its test. | Arch design, after the invite |
| **BATCH-HARNESS** | HARNESS-SIGNOUT · HARNESS-THEMEWRITE · GATE-METHODRACE · GATE-SETTINGS-FOLD (frame 06 ends above the Export section, so nothing watches it) · GATE-DEVCHECK · GATE-PORT · GATE-LOAD-AUDIO · CAPFLAKE-LIBLIGHT (**must not enter `diff-exceptions.json`**) · DIFF-EXC-BOUND · HARNESS-WAIT · GATE-THEMEGLYPH (Δ42, light only, reproduced twice — **never register it**) · REPRO-SUSPECT · SENT-BUNDLE · HARNESS-READ's fixture half. | H3, after the invite |
| **SECURITY-PREPUBLIC** | One pass before public beta: GRANT-TRUNCATE (residual `service_role` TRUNCATE on 35 objects; TRUNCATE ignores RLS) · HARNESS-READ (a read-only role; today no harness can read the database) · RLS-INITPLAN (`auth.uid()` unwrapped on 53 tables, plus 38 unindexed FKs) · REPO-MIGRATIONS-ABSENT (two files against 64 applied — the database cannot be rebuilt from the repo). All Trigger B. | Before public beta |
| **LIBRARY-DEFAULTS** | **Design unit, Trigger A — three of Jamie's asks, one surface.** On new project creation the user chooses whether to seed from their own global library (refer to Zite); the same choice for default methods; and an inspector at the foot of the equipment list to edit library defaults — default category, default note, rack spaces — per v1's graphics. ⚠ **Needs a per-user library tier that does not exist:** `equipment_library_items` holds 14,411 rows, **zero unscoped**. Supersedes GLOBAL-LIB's "not a gate item"; one sentence about it still goes in the invite. Schema work, so Trigger B follows Trigger A. | Design after the invite |
| **NOTES-MULTILINE** | Jamie: a multi-line note shows as one line on an unfocused row with a subtle more-than-one indicator, and expands when the row or the notes field has focus. ⚠ **Kept out of BATCH-COHORT-1 deliberately** — it changes row heights, and row heights are measured against v1 and feed the paginator. Pairs with EQUIPLIST-WHOEST, whose estimator models a layout the renderer no longer draws and has no wrap model. | Its own scoped round |
| **REGISTRY-REST** | The registry's remaining legs: **REGISTRY-2** (the admin surface; ⚠ `registry.admins` holds 0 rows, so `is_admin()` returns false for everyone including Daniel — its first job) · **REGISTRY-IMPORT** (dry-run the LICDB workbook in a rolled-back transaction and publish the reconciliation — 747 people · 778 spine rows · **181 live serials, the figure that must not move** · 477 invoices · $96,503.42 · 425 unmatched · 241 eligible; the 425 import as a worklist, not a graveyard) · **REGISTRY-3** (payments, after Strat picks the provider) · **ENTITLE-V1** (answered and half built — the gate reads `my_entitlement()->>'v1_live_until'`, applied at migration 64; what is left is the data) · **BETA-SIGNUP-GATE** (`v1_beta_eligible(email)` is applied and granted to `authenticated` only; the `anon` grant is withheld until the rate-limited route exists) · **V1-ISSUE**'s admin screen · **SEAT-CAP**'s mechanism (`licenses.concurrent_edit_limit` and `registry.edit_claims` applied at 62; one active editing session per Individual). | Arch parallels; 65 before REGISTRY-IMPORT runs |
| **LEGAL** | **LEGAL-SELFDRAFT** (terms adopted and in force; still to draft: the IP assignment and **PRIVACY-POLICY**, promised to the cohort in §12 before the v1-holder beta — its own parallel on the beta-terms pattern) · **TERMS-60DAY** (the post-licensing window returns to 60 days; four places, all in `drafts/`, none in the code repo — ⚠ **it was clean only while `terms_acceptances` held 0 rows, and it now holds two; this is a different act than it was**) · **LEGAL-SEP** (attorney review of the self-drafted documents plus the subscription agreement before v2 charges anyone; nineteen packet items, plus D5 and D9) · **GBL-527A** (a build requirement, not only an attorney question; `registry.subscriptions` carries a column per requirement, unapplied — migration 67) · **DEEP-ARCHIVE** (⚠ no row existed until the 2026-09-14 audit; the R8 drill closed with **F9: NO COVERAGE TODAY**; carries the attorney's 7-day persistence window and goes on the agenda **before** the archive is built). | LEGAL-SEP scoping, week of Oct 5 |
| **STRAT-OWED** | **BRIEF-13** (carries PRICE-199, BENCH-FIX — Lightwright is $399/year, not $149 — COMPETE-FIX, the sharing rationale; the Roadmap's RELEASE line is operative until then) · **COMMS-Q** (the announcement to the v1 list is the v1-holder beta drop; a personal note, no tease) · **COMMS-REWRITE** (Comms Prompt v9 deleted and rewritten from scratch) · **REGISTRY-DESKWORK** (the eight unreachable live v1 holders — Weston $898, Potts $495, Barsky $433, Sonnabend, Proctor, Leach, D'Amore, Schloegel, likelier in his phone than in Gmail; the fifteen paid B-list names; the Square Customers export, the highest-leverage missing input) · **BUNDLESUM-MARKS** · **METRIC-UNRUN** (a typed `150m` on an imperial show commits metres) · **TOK-VC** (Vercel token rotation, hard ~Nov 8) · **HERO-PLURAL**. | Daniel and Strat |
| **PROCESS** | Everything harness- and document-shaped, in ONE parallel and never on the main line (ruled 2026-09-12): PROCESS-REFACTOR's remainder (decide whether a Standing Facts file is still wanted) · CCSED-260911 and SEDRULE-REMAINDER (`perl -i` / `gawk -i` / `ruby -i` can edit any repo file with no guard) · WF1A-SUNSET and WF1A-PHRASE · UNATTENDED-MEASURE (three measurements before any unattended-CC build — **never a build first**) · CORPUSBOUND-AUDIT · FENCE-COUNTS. ⚠ **A parallel that starts proposing process which costs build time has failed.** | Sprint 4 close; release trigger is week-one fixes shipped |

### ⏸ HELD — waiting on a named unit or trigger

| ID | One line | Trigger |
|---|---|---|
| **ORG-TIER** | An organisation account — the theatre or shop owns the projects, an admin manages seats. Lightwright's $375/seat is the ceiling. **Not precluded and not built:** `registry.license_seats` and `licenses.seats` applied at 62, so an org licence later is one table and a nullable column. | Strat, after the first paid quarter |
| **MONTHLY-HOLD** | A monthly Individual only if LICDB's usage distribution shows the few-shows-a-year segment is small, priced so annual wins by month seven. Becomes a query against `registry.payments` once 66 lands. | Strat, after the first paid quarter |
| **INSPECTOR-ARM** | Change All did nothing from a Method field with no row selected; **the recorded cause does not match the code** (`method_name` is an ordinary row cell). Arch measures on the running app before proposing a fix. | Arch, measurement first |
| **CAT-MERGE** | No `merge_categories` function, so a category rename collision refuses and reverts. Trigger B. | Its own later unit |
| **REVGROUP-SPLIT** | Revision-mode print groups by model alone while the plain list groups by (model, note); changing it means deciding how new rows pair against old snapshots. Pairs with EQUIPSORT-NODESC's question. | Its own unit |
| **MENU-DEPRECATE** | Remove Wire Types and Wiring Schedule from the main menu. Likely a declared baseline event. | Rides a UX unit with a working gate |
| **SPENDCAP-BETA** | Keep the Supabase spend cap on. PITR is outside it and bills regardless. | Before public beta, or at half any quota |
| **DEVICE-FK-LINK** · **CATSORT-NATURAL** · **EQUIPVIEW-UNSAFE** · **EQUIPLIST-QTYCOL** · **SKIP-LABELS** · **BUNDLE-NA-UNTESTED** · **FIXTURE-NUMLABELS-GONE** · **HISTID-HASH-COST** · **SMOKE-LOGIN-HYDRATION** · **IMPRPT-COPY** · **BUILDSHEET-CMT** · **DEV-SERVER-AGE** · **SHOP-ORDER-NOTES** · **BUNDLE-FIND** · **SED-GUARD** | unchanged; each waits on the unit named in v4.37 | Their units |
| METHOD-FIX · GATE-OL25WR · GATE-C4 · S504 · CONCEPT-A · UNALLOC · EFFGRP · DOOR-V1LINK · CABLE-LOADER · RULINGS-WANTED | unchanged from v4.6 | Icebox sweeps |

### 📐 STANDING — binds indefinitely; never closes

| ID | One line |
|---|---|
| **MAILGATE** | Nothing sends email to any address that is not Daniel's own until he approves that send in a message whose only content is the approval. One approval, one send. CC never sends mail or provisions accounts. |
| **MORNING-CHECK** | A scheduled task runs every morning at 8:00 ET: backup sweep failures in the last 24 hours and new waitlist signups, read-only, pushing to Daniel's phone only when there is something. |
| **HANDOFF-BUNDLE** | Small fixes ride as few, long handoffs as possible. |
| **HELD-IS-NOT-FORGOTTEN** | A HELD row without a named release trigger is illegal; every close checks whether any trigger has fired. |
| **SWEEPLINE-NOT-DURABLE** | Anything that must outlive one session goes in a row, never a summary line; every propagation claim is a search before it is a sentence. |
| **APCA-NOT-WCAG** | For dark-mode text the WCAG ratio cannot see polarity; report APCA Lc alongside it. |
| **CONTRAST-PAIR-RULE** | No white text on yellow. A static ground wants static text; a flipping token over a static ground is the defect class. |
| **FONT-IS-NOT-SHIPPED** | Any measurement of a printed or laid-out surface states which typeface rendered it. The app does not ship Century Gothic. |
| **GATE-SETTLE-BETWEEN** | A reliability measurement lets the machine settle between runs; a refusal captures nothing and is never counted. |
| **GATE-REPORTING** | A green machine gate is never a substitute for Daniel's browser gate. |
| **GATE-NOGREP** | Never pipe a gate run through a filter; write it to a file and read the file. |
| **TOAST-ON-WRITE** | `pg_column_size` on a computed value reports the uncompressed datum. Any storage estimate cites a stored measurement or says it is an expectation. |
| **PROJECT-NAME-NOT-UNIQUE** | Two productions of one musical share a show name and that is a feature. Never add a uniqueness constraint; every citation names the project id. |
| **DDR-IS-THE-SOURCE** | Go to the source that made the ink: `docs/reference/v1_ddr.xml` (UTF-16LE, read via `iconv`). |
| **GRAPH-BEATS-RERUN** | An import graph says whether a frame could ever have seen the change; two re-runs is the limit. |
| **FOUNDSET-NOT-COUNT** | A count that matches is not a found set that matches. |
| **TENSE-IS-A-CLAIM** | An expectation written in the past tense reads as a measurement. |
| **DEAD-CODE-IS-NOT-SAFE** | A symbol with no production callers is dead code, not low blast radius. |
| **BROWSER-NOPRINT** · **PDF-CHROME-PATH** | The built-in browser has no print; a parity print is valid only through Chrome's own Save-as-PDF. |
| **HARNESS-RLS-CORPUS** | The parity fixtures are invisible to the test user; every harness count is a labelled reproduction on a throwaway. |
| **FENCE-ONEUNIT** | The run fence carries one unit, not a history; retired fence text goes to the Ledger. |
| **PARALLEL-CLOCK** | `YYMMDD-hhmm` in a filename is the ordering key; write it at the time of writing. |
| **PORT-COV-REIMPORT** | A v1 re-import path is a product requirement; acceptance is round-trip, not column order. |
| **ARCH-OUTPUTS-MIRROR** | Files written through the Cowork output path mirror into the code repo. Intermediates go to the scratchpad. |
| **CONTCAT-DIVERGE** · **PAGEBREAK-MODEL** · **CATNOTE-TYPE** · **IMPORT-LINEBREAK-CR** · **LABELSDONE-RESIDUE** · **EQUIPLIST-ROWH-BIMODAL** · **R-7 LABEL SETS** · **LEN-SCALE** · **HISTENTRY-NOTID** · **JOY-NAME-HYGIENE** · **LINES-NOFK** · **CLONELINK-ROWSET** · **BVSC-8POWER-DRIFT** · **PRINTPROBE-MEDIA** | unchanged from v4.37; ruled divergences and standing cautions. Do not "fix" any of them back by citing the artifact. |

### ✅ RETIRED TO THE LEDGER — index only

| ID | Closed at | Ledger |
|---|---|---|
| **AUTH-FRONTDOOR** — CP1+CP2 shipped `3b98ce9`, live 2026-09-14; the typed recovery code reaches the host at any length 6–10, and the five auth sentences carry their ruling | v4.38, 2026-09-14 | twenty-first |
| **AUTH-SMTP** · **AUTH-DASHBOARD** — Porkbun `smtp.porkbun.com:587` sending as `info@minotaur.app`, sender name **Minotaur**; rate limit 100/hr, OTP length 6, recovery template on `{{ .TokenHash }}` + `{{ .Token }}`, allow-list confirmed | v4.38, 2026-09-14 | twenty-first |
| **SHARING** REV-B design · **COHORT-EMAILS** · **OTPLEN-MISMATCH** (b) | v4.38, 2026-09-14 | twenty-first |
| **TERMS-ACCEPT** — shipped `1f82072`; the beta terms are IN FORCE | v4.37, 2026-09-14 | twentieth |
| **CHANGEALL-MODEL-SERIAL** · **VERHIST-MANUALLEAD** · **EXPRPT-HINT** — `7993221` | v4.36, 2026-09-14 | nineteenth |
| **AUTH-RESETPAGE** (`57e0eec`) · **AUTH-LINKCLICK** · **AUTH-SIGNIN-CONTRAST** (`3416650`) · **AUTH-MAILVOLUME** · **VERHIST-SWEEPWATCH** · **WAITLIST-NOTIFY** · **EQUIPLIST-CLMARGIN** | v4.34, 2026-09-13 | eighteenth |
| Everything earlier | v4.32 and before | by append |

### ❓ Open Questions (live only)

- **PRINT-PARITY's remaining:** OQ-3 (does the SMALL box layout's Box Name carry a Conditional Formatting rule) · OQ-4 (dashed grey cut rules fully specified — `x 22.00 → 590.00` at `y 395.50`, 1.0 pt, `#ADADAD`, dash `[3.005291, 3.005291]`, phase 0.5 — build pending) · OQ-5 (which cell edge is the parity target) · OQ-B (does Box-in-Box suppress fields other than the Stack).
- **Which methods palette is v1's** — saturated or pale (METHODS-PALETTE).
- **What selects the 596 rows in v1's `cable clone links.xlsx`?** (CLONELINK-ROWSET.)
- **What zeroed the three v1 count fields between July 11 and Aug 20?** (Q-1.) Only Daniel's memory can close intent.
- **Does the operator need the report to say a system row was protected?**
- **Do the 39 boxes whose types BOX-TYPE-LIB created want dimensions?**
- **Should first and last name become separate columns**, and does `registry.people` own them?
- v1 continuation header · cover-page body size → PRINT-PARITY.
- Script 551 extraction · cable Change All checkbox eligibility · house-wide Cancel semantics · Used∩Ignored · empty-string note · link `field_name` CHECK backstop · cable-type RENAME affordance · CL a-1 uploads · d2_01 red Members count · CL multi-letter-per-project · stale-category healing · CC credit-budget policy · OQ#2b own-band pendency · band-cascade harmonization.

---

*Roadmap v4.38 · 2026-09-14 · retires v4.37. Cap: **40,000** characters, ratcheted down from 60,000 at this version. Code **`3b98ce9`** live. Migration ledger 64; suite 3,312 / 170; frozen 3/3; visual 28/28; no baseline event. One unit shipped this session and one parallel folded in. Seventy-one rows consolidated into twenty-eight; no row dropped, only merged — every retired row's text is in the twenty-first append.*
