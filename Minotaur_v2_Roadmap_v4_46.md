# 🗺️ ROADMAP — Minotaur v2 (v4.46)

## ▶ NOW

**A big day, and everything shipped.** Four releases went live, all checked in your browser:

- **The equipment list is fast for everyone.** For people who don't own a show it went from about 65 thousandths of a second to 2.
- **The front-of-house fixes:** the top-left print logo, a real build stamp (`v 9/18/26 · 7c96904`), the cable-delete message in your words, and a record left behind when an import fails.
- **Housekeeping:** the screenshot check no longer flakes on a leftover sort, error messages no longer vanish early, and the code-quality check is back.
- **Next.js upgraded for security.** No critical warnings are left on the live site, and a theme-toggle bug is fixed on the way.

Method colours are back on the shared palette. **The support login exists** (Minotaur Support). **Your test shows are separated from your real ones.** The paperwork order is set, and the find screen is fully designed.

**Nothing is running.**

## ⏭ NEXT — the next three sessions

1. **The paperwork, part one.** The ruled print fixes, then Line List and Bundle Summary. First I check whether the v1 prints already in your exports folder cover the blank-description sort; if not, I'll name the one v1 print I need.
2. **The accounts and the invite.** Thirteen accounts and their real names, the note and the brief. All yours; nothing in the product is in the way.
3. **The paperwork, part two.** The find screen with Bundle Labels and Tail Folder Labels, then Steck and Equipment labels once your 5167 print is in. Cable splits follow.

**Yours, and the first two are the only ones holding anything up:**

- **Thirteen accounts**, and the real names.
- The invite note and the one-page brief.
- **A cable label print on real 5167 stock.** It only blocks Steck and Equipment labels now.
- **A fresh v1 export of BVSC US Tour**, to remake it under your own account.
- A fresh export of the v1 licensing database.
- Wording for the bug-report form, and for an import too big even for ninety seconds.

## 🏗 THE SEQUENCE — the road, in plain language

- **The private beta.** Seventeen leads plus their teams. **Left:** thirteen accounts and their names · the note and brief. **Done:** terms, front door, mail sender, sharing, the typeface, the import's time limit, all four speed changes, method colours, the support login, the security upgrade.
- **The paperwork, which you have called your priority, in your order.** The ruled print fixes · Line List and Bundle Summary · the find screen with Bundle and Tail Folder labels · Steck and Equipment labels after the 5167 print · Group Parts, then Device Patch. The box and contents lists get their first v1 comparison in the first step.
- **Then cable splits**, ruled and designed — a core v1 feature that v2 cannot import a real show without.
- **The four weeks after the invite — fix what the cohort finds.** Jamie's contrast and type-size pass · a read-only role · a counter that makes an incomplete backup impossible · the terms gate · housekeeping.
- **Mid-October — the beta opens to v1 owners.** Free to anyone with a live v1 licence. First: a way to tell who qualifies, and a sign-up page.
- **After that — RF, walkies and circuits** (your ruling of today), with the IAS frequency import. **Then Maintenance, Spreadsheet Export, Cover Letter and real-time collaboration** — v1 sections that fell off the Roadmap on 2026-09-12 without anyone ruling them out, now back on it.
- **Then the bug report button**, so a member can tell you what broke and hand you the show.
- **November — money.** Checkout and subscriptions, attorney review first, New York's auto-renewal rules built in, a seat limit before the first payment.
- **At release — $199 a year**, named user, one session each. v1 on request.
- **Stop: a paid beta by ~March 2027.**
- **Off the road — released by an event, not a date:** a typeface with a two-storey `a` that also has the ohm sign · controls that fail open · duplicating an item · an organisation tier · a monthly price · a per-kind category breakdown · the empty backup a new show's first import leaves · chunking the import · live results under the find fields.

---
## 📌 THE DOCKET

Three tables. **▶ ACTIVE** is in the order the work will happen, most immediate first. **⏸ HELD**
waits on a named trigger. **📐 STANDING** binds indefinitely and never closes. Every ACTIVE row
says what it is, who does it, and what it needs before it can start. Measurements, incident
history and reasoning live in the Ledger.

### ▶ ACTIVE — in the order the work will happen

| ID | What it is | Who · what it needs |
|---|---|---|
| **PAPERWORK** | ⚠ **Your stated priority. Order RULED 2026-09-18:** (1) the ruled print fixes — solid row rules, the preview clip, method sort order, the hint line, the blank-description divergence between screen and paper, plus EQUIPLIST-NAMEWRAP (a wrapping show name under-counted by 24 px per page) — with the Box List and Contents List's first v1 parity round and the paperwork preview on Project Settings; (2) Line List and Bundle Summary, which need no find screen; (3) the find screen with Bundle Labels and Tail Folder Labels (Tail Folder on Avery 5160); (4) Steck and Equipment Labels; (5) Group Parts, then Device Patch. **The find screen is fully ruled** (six rulings, `handoffs/parallel/260918-1240_paperwork-findscreen_RULED.md`): skip only where v1 has it, no hint line, Max # Label Sets dropped, Bundle Labels shares Bundle Sheet's sort. | **CC builds, Arch writes each handoff** · step 1 needs Arch to check the v1 prints already filed for the blank-description sort; step 4 needs **your 5167 print**. Detail: Ledger, 21st, 26th and 27th appends |
| **COHORT-ACCOUNTS** | Thirteen of seventeen cohort accounts still to create, then real names written into the roster. The dashboard insists on a password — set any, and the member uses "forgot password" to set their own, which is what records terms acceptance. **The support login is done** (Minotaur Support, `info@minotaur.app`). | **Daniel** for the accounts and names, then **Arch** writes the names. Before the invite |
| **BETA-INVITE** | The invite note and the one-page cohort brief: the two ruled sentences, the three-step sign-in, the terms fragment and link, one line on the shared library. No confidentiality ask. | **Daniel** · needs the accounts to exist. One approval per send |
| **US-TOUR-REIMPORT** | BVSC US Tour was deleted 2026-09-18 on your word because it had drifted from v1. Remake it with a fresh v1 import under your own account; about 2,600 items, well inside the 90-second limit. Until CABLE-SPLIT lands it will again carry a few split markers with no parent. | **Daniel** · needs a fresh v1 export of the show |
| **CABLE-SPLIT** | A core v1 feature v2 cannot import a real show without. Ruled 2026-09-18: a split is two fields on the child cable; the named end is its own, the other inherited from the parent. Designed against the v1 source; one migration specified. **R6 closed by measurement:** no parent links exist live today, and 4 parentless split markers remain, all on Cable Parity Fixture. Still owed before the migration: whether an inherited end reads through to the parent or is copied at creation. | **CC** for five rows, **Arch** for the migration rehearsal · after the paperwork |
| **CONTRAST-PASS** | Jamie's finding: raise contrast everywhere in both themes and assess type that is too small. Five renderings or a switcher, and picking one is the acceptance. Absorbs the dead-class sweep, the bounced auth link colour, the confirm-button flip, the sort band that vanishes on a dark page, the dashboard's faint shared marker, and the type-size assessment. Also settles whether semibold — which now renders as a true 600 for the first time — is wanted heavier again; that is one token, not a font change. | **CC** · the wander sites are registered; **you pick a rendering**. Week one |
| **VIEWER-ROLE** | A read-only role for people who should look and not edit. Every edit control on every surface has to be found and hidden, because a refused write returns zero rows and raises nothing — the control must not be rendered at all. Carries the roster's role column, a member's ability to remove themselves, and whether an address shows under each name. | **CC** · needs the whole-app control sweep first. Week one |
| **TERMS-GATE** | Acceptance is recorded in exactly one place — the set-password page — so anyone handed a password never accepted. Two cohort members are in that state; ruled 2026-09-17 as logged, not chased. The fix is a routing gate onto the page that already exists: no new screen, no new version, no re-acceptance. Not in the middleware, where a database read would sit in front of every page load. | **CC** · needs your wording for the screen. Off the pre-invite path |
| **VERHIST-REST** | What is left of version history: a counter that makes a silently incomplete backup impossible rather than merely unlikely; "open as new production", which is a migration and is deferred past the invite; and the blob and gesture-class residue. Measured 2026-09-18: the saved payload holds twenty tables and the project library is not one of them — it is only fingerprinted — so a library-only re-import has never had a restore point. That may be deliberate; it is a question, not yet a defect. | **Arch, then CC** · the counter needs nothing; the fork needs a rehearsal and your Trigger B |
| **IMPORT-REMEASURE** | Ninety seconds covers roughly 4,700 items at the one rate we have measured — 1.7× the largest show in the corpus. That is one measurement on one show and linear scaling is an assumption, so it is re-measured on the first large cohort import; the identity map and the library are likeliest to bend the curve. Chunking the import stays unbuilt: the import is one transaction, which is exactly why two timeouts left zero corruption. | **Arch** · needs a real cohort import. **Your wording for an import too big even for ninety seconds** is owed before the invite |
| **REGISTRY-REST** | The licensing registry's remainder: the admin surface, which nobody can reach because its admin table is empty and one insert unblocks it; the import of the licensing workbook, which needs a fresh export from you because you issue serials by hand; payments once Strat picks a provider; the v1 entitlement check, which is applied and waiting on data; and the sign-up gate for v1 holders. | **Arch parallels** · the import needs **your fresh export**; payments need Strat's provider |
| **LEGAL** | Still to draft: the IP assignment and the privacy policy, promised to the cohort before the v1-holder beta. The terms window returns to 60 days. Attorney review before v2 charges anyone — nineteen packet items, plus two new lines: two members using the product with no recorded acceptance, and the cohort's first non-US address against documents drafted with only US users in view. New York's auto-renewal statute is a build requirement, not only a question for the lawyer. | **Daniel and the attorney** · needs the packet assembled. Week of Oct 5 |
| **SECURITY-PREPUBLIC** | One pass before public beta: the residual truncate grants, the grant-restore sweep, two functions with a mutable search path, 51 unindexed foreign keys, the resolver rate limit, **the one high security warning left after the Next.js upgrade** (`browserslist`, a build-only tool, fixed by moving `autoprefixer` to dev dependencies), and **MIDDLEWARE-PROXY** (Next.js wants `middleware.ts` renamed to `proxy`; the build still works). The import-timeout hook runs on every request, so anything added to it is on the hot path. | **Arch** · your Trigger B on each database item. Before public beta |
| **RF-COMMS** | ⚠ **Restored 2026-09-18 — it fell off the Roadmap at v4.28 without a ruling.** RF devices, walkies and circuits, and the IAS frequency import. The database tables exist and are protected; there is no screen. BVSC is the only v1 export carrying RF data. **Ruled by you: after the public beta opens.** | **Arch designs, CC builds** · after the mid-October opening |
| **V1-SECTIONS** | ⚠ **Restored 2026-09-18 — also dropped at v4.28 without a ruling:** Maintenance, Spreadsheet Export, Cover Letter and real-time collaboration. The Brief still names them as matching v1. Placed after RF until you order them. | **Arch**, with your order · after RF-COMMS |
| **BUGREPORT** | A form so a cohort member can tell you what broke without writing an email, and hand you the show read-only, one case at a time, visible in the member list the whole time — which is what your terms already promise. Ships the route, project, time, browser, viewport, theme and build, plus the last 25 console errors, never stored. A paste target for screenshots rather than automatic capture. Carries the redaction rule: every string value is replaced by its character count, including the database's own error text, which embeds the customer's typed value. Its test must drive that path. | **CC** · needs VIEWER-ROLE (the support login exists), your wording, and the build stamp. After public beta opens |
| **EXPORT-INTEGRITY** | One export unit rather than six: the history-id drop, whose headline figure is contradicted and must be re-measured before design; state carried in the export; line-feed and hash-drift issues; v1's null marker in Line Color on 86 rows; and 823 orphan identity rows on BVSC Mexico, where nobody has measured what a re-import does against the residue. Cable split's export arm reads with this. | **CC** · one fixture must be looked at before any re-import overwrites the evidence |
| **BATCH-BOX** | The box work that is not about paper: re-parenting, name uniqueness, type volumes, the dead dimensions column, and the alpha-step and zero-label questions. The box list's permission cost is already fixed, so giving box details their own project column would now only simplify a predicate. | **CC and Arch** · needs PAPERWORK's box parity round first |
| **FONT-NEXT** | Two findings that read together. The shipped face has no ohm sign and no ≥ or ≤, so those characters fall back to another typeface on screen and on paper — impedance and spec tolerances, on 7 of 34 pages of your own print. Widening the character range cannot fix a glyph the font does not contain. And you asked for a face with a two-storey `a` so `a` and `o` cannot be confused in a dark room; every face in the Futura school, Century Gothic included, has the single-storey one. Candidates are checked for those three characters before you are shown a rendering. | **Arch** renders, **you** pick. After public beta |
| **BATCH-HARNESS** | The visual-gate and harness residue. The sort leak is fixed (pinned at run start, 2026-09-18). Left: the theme-preference restore depends on the theme toggle (NEXT-UPGRADE S2-2); a wander site is registered by a point and should be a span; `01-project-menu-dark` shows 20 px at Δ1 on 6 of 9 runs, judged 0, unregistered; **no fixture has a non-owner member since the account separation**, so re-create one before the next non-owner measurement. | **CC** · needs nothing. After the invite |
| **OQ-UNPLACED** | Fourteen questions with no owning unit, held in one row so that unplaced is visible rather than invisible. Each is placed into a unit or closed; none stays past the sweep. | **Arch parallel** · needs the invite out |
| **STRAT-OWED** | Strat's own list: the Brief's next version, carrying the $199 price and the corrected competitor benchmark; the Comms prompt rewrite; the deskwork on eight unreachable live v1 holders and the missing Square customer export; and the Vercel token rotation, hard at about November 8. | **Daniel and Strat** · the deskwork needs the Square export |
| **PROCESS** | Everything harness- and document-shaped, in one parallel and never on the main line: the document refactor's remainder, the stray untracked trees, the commit-phrase pilot's sunset review, and the Docket's own bundling pass. A parallel that starts proposing process which costs build time has failed. | **Arch parallel** · needs the week-one fixes shipped |

### ⏸ HELD — waiting on a named trigger

| ID | What it is | Trigger |
|---|---|---|
| **LIVE-RESULTS** | A list of matching names under the find fields that narrows as you type, before GO — your OQ9 ruling of 2026-08-11, from Zite, never built. **"Not now" (2026-09-18):** the paperwork stays pure v1. Built once for every find screen, the box pages included. | After the paperwork |
| **FROZEN-FLASH** | The one error-flash timer ST-RACE could not convert, because it lives in the frozen equipment-save layer: on the Equipment List a flash from that path can end a newer flash of the same field early. | A ruling that opens the frozen layer |
| **VERHIST-PHANTOM-IMPORT** | **Ruled by you 2026-09-18: leave it.** Importing into a brand-new show saves a backup of an empty show, because at that moment there is nothing to back up. Harmless today — nothing in the product can restore a saved version yet. The fix, when it comes, is one condition in the function that writes it, not a change to where the backup is taken. | After public beta, batched with the restore work |
| **LETTERHEAD-COMPOSITE** | Build in the product what you do in OmniGraffle: a half-inch logo with text set to its right, assembled into the header band. Nobody should need a drawing application to make a letterhead. | After PAPERWORK's letterhead leg |
| **FONT-ADJUST** | If the fallback face is ever promoted to default, one setting normalises it to Century Gothic's x-height automatically, plus a decision on semibold. It sets about 5% smaller, narrower and lighter, which is what you read as "quite different". | Only if the fallback is promoted |
| **BUGREPORT-BATCH-CONTRAST** | Should the bug report ride into the contrast pass's declared visual event rather than declare 28 frames of its own? Your call, because it puts a control into a rendering you are choosing between. | When CONTRAST-PASS is scoped |
| **ERROR-BOUNDARY** | There is no error boundary anywhere in the app, so an uncaught render error shows the framework's own default screen. The real fix is an operator-facing "something broke" screen wired to the bug report. | Week one or later |
| **BUGREPORT-SHOT** | Automatic screen capture. It needs a permission prompt or a DOM renderer, plus storage and a retention rule, and it is the one attachment that cannot be redacted. The design ships a paste target instead. | After the cohort files real reports |
| **CATCOUNT-BREAKDOWN** | Category counts broken out by kind — items, cables, tails and boxes shown separately rather than as one total. Wanted, much later. | After public beta |
| **ORG-TIER** | An organisation account: the theatre or shop owns the projects and an admin manages seats. Not precluded — the seat columns exist. | Strat, after the first paid quarter |
| **MONTHLY-HOLD** | A monthly Individual price, only if the licensing data shows the few-shows-a-year segment is small, priced so annual wins by month seven. | Strat, after the first paid quarter |
| **INSPECTOR-ARM** | Change All did nothing from a Method field with no row selected, and the recorded cause does not match the code. Arch measures on the running app before proposing anything. | Arch, measurement first |
| **CAT-MERGE** | There is no merge for categories, so a rename collision refuses and reverts. | Its own later unit |
| **REVGROUP-SPLIT** | Revision-mode print groups by model alone while the plain list groups by model and note. Pairs with the blank-description divergence. | PAPERWORK |
| **CATBAND-CASEDUP** | Two category rows differing only in case and sharing a rank collapse into one band, and picking the other one is a silent no-op. | Its own unit, or the next category work |
| **MENU-DEPRECATE** | Remove Wire Types and Wiring Schedule from the main menu. | Rides a UX unit with a working gate |
| **SPENDCAP-BETA** | Keep the Supabase spend cap on. Point-in-time recovery sits outside it and bills regardless. | Before public beta, or at half any quota |
| **LINKEDBOX-LIVEPROOF** | A live browser proof that clearing the Box on a linked cable fans out to its pair; no live write has ever driven it. | The next cable unit |
| **DEVICE-FK-LINK** · **CATSORT-NATURAL** · **EQUIPVIEW-UNSAFE** · **EQUIPLIST-QTYCOL** · **SKIP-LABELS** · **BUNDLE-NA-UNTESTED** · **FIXTURE-NUMLABELS-GONE** · **HISTID-HASH-COST** · **SMOKE-LOGIN-HYDRATION** · **IMPRPT-COPY** · **BUILDSHEET-CMT** · **DEV-SERVER-AGE** · **SHOP-ORDER-NOTES** · **BUNDLE-FIND** · **SED-GUARD** · **REPO-WEIGHT** · **GIT-CFG** | Unchanged singles, each waiting on the unit named in v4.37. The quantity column and the skipped labels now read with PAPERWORK. The two orphaned lock files in the code repo are yours to remove at the terminal. | Their units |
| METHOD-FIX · GATE-OL25WR · GATE-C4 · S504 · CONCEPT-A · UNALLOC · EFFGRP · DOOR-V1LINK · CABLE-LOADER · RULINGS-WANTED · METHOD-STRAYS | Unchanged. Method strays deprioritised by you 2026-09-15. | Icebox sweeps |

### 📐 STANDING — binds indefinitely; never closes

| ID | The rule |
|---|---|
| **MAILGATE** | Nothing sends email to any address that is not Daniel's own until he approves that send in a message whose only content is the approval. One approval, one send. CC never sends mail or provisions accounts. |
| **SESSION-SHAPE** | A session opens with a CC handoff, bundled as large as the ruled material allows; the seat spins off parallel Arch designs only once Daniel confirms the handoff is in CC's hands. Arch never idles waiting on CC. A migration whose acceptance is a timing measurement goes first, because it cannot share the database with CC's visual gate. |
| **HANDOFF-BUNDLE** | Small fixes ride as few, long handoffs as possible, and a bundle's members are censused before it is written. A unit that re-baselines the whole visual gate ships alone. |
| **RULED-IS-RULED** | A ruling already made is not re-opened by a later instruction without saying so. Before writing anything that touches a ruled unit, read that unit's row and the surface at source. |
| **REHEARSE-BEFORE-RULING** | A mechanism is rehearsed before it is ruled, not after. Two ruled mechanisms have been falsified by rolled-back test, one of which would have shipped as a silent no-op. |
| **QUESTIONS-IN-ROWS** | There is no Open Questions section. A question lives inside the row of the unit that will answer it, or as its own row with an owner and a trigger. The Roadmap has four sections and no others. |
| **MEASURED-NOT-PREDICTED** | Check the instrument before citing it, and say which is a measurement and which is a prediction. A vendor's documentation is not the surface, and neither is our own expectation. |
| **GATE-SETTLE-BETWEEN** | A reliability measurement lets the machine settle between runs. A measurement sharing a transaction with schema changes is not a measurement, and no two timing runs — or a timing run and a visual gate — share one database. |
| **GATE-REPORTING** | A green machine gate never substitutes for Daniel's browser gate, and his words are the record. A gate that cannot render a browser has not tested it, and no gate can test a wall-clock claim. |
| **GATE-NOGREP** | Never pipe a gate run through a filter; write it to a file and read the file. |
| **POLICY-RETURNING-SNAPSHOT** | A SELECT policy that resolves permission by re-reading its own table breaks insert-with-returning. Test the row's own columns first. |
| **POLICY-CAPTURE-FIRST** | Any migration that drops or replaces a policy captures the existing policies for every affected table before applying. |
| **MIGRATION-FILE-FROM-SOURCE** | A migration's file in the repo is read back out of the database and checksummed against what executed, never reconstructed. When a function is too large to retype, the migration edits the live definition and proves the diff by reversing it and matching the original checksum. |
| **FOUNDSET-NOT-COUNT** | A count that matches is not a found set that matches. Compare the rows themselves. |
| **SWEEPLINE-NOT-DURABLE** | Anything that must outlive one session goes in a row or the Ledger. A measurement that lives only in a conversation did not happen. |
| **HELD-IS-NOT-FORGOTTEN** | A HELD row without a named release trigger is illegal, and every close checks whether any trigger has fired. |
| **TENSE-IS-A-CLAIM** | An expectation written in the past tense reads as a measurement. |
| **DEAD-CODE-IS-NOT-SAFE** | A symbol with no production callers is dead code, not low blast radius. |
| **DEAD-CONTROL-IS-A-BUG** | A control whose result is displayed nowhere is a defect, not a harmless spare. Either the slot renders or the control comes out. |
| **ACCIDENTS-OF-THE-FACE** | Minotaur's look rested as much on what Century Gothic lacks as on what it has, and four behaviours turned out to be accidents rather than decisions. Before changing a face, ask what the old one was doing by accident. |
| **FONT-IS-NOT-SHIPPED** | Any measurement of a printed or laid-out surface states which typeface rendered it. The app ships a fallback but still cannot guarantee Century Gothic, which is not redistributable. |
| **APCA-NOT-WCAG** | For dark-mode text the WCAG ratio cannot see polarity; report APCA alongside it. |
| **CONTRAST-PAIR-RULE** | No white text on yellow. A static ground wants static text. |
| **LOOK-AT-THE-FRAMES** | Every frame in a declared visual event is opened and read before any baseline is written. |
| **DDR-IS-THE-SOURCE** | For v1 behaviour, go to the source that made the ink — the design report — not to a screenshot or the repo's own belief about v1. |
| **HIST-BLIND** | v1's field-level audit lives in save triggers that a scripted mass edit does not fire, so any such edit is invisible to v1's own history. |
| **PORT-COV-REIMPORT** | A v1 re-import path is a product requirement; acceptance is round-trip, not column order. |
| **GRAPH-BEATS-RERUN** | An import graph says whether a frame could ever have seen the change; two re-runs is the limit. |
| **PROJECT-NAME-NOT-UNIQUE** | Two productions of one musical share a show name and that is a feature. Every citation names the project id. |
| **HARNESS-RLS-CORPUS** | The parity fixtures are invisible to the test user, so every harness count is a labelled reproduction on a throwaway. |
| **TOAST-ON-WRITE** | Column size on a computed value reports the uncompressed datum. |
| **FENCE-ONEUNIT** | The run fence carries one unit, not a history. |
| **PARALLEL-CLOCK** | The timestamp in a filename is the ordering key; write it at the time of writing. |
| **ARCH-OUTPUTS-MIRROR** | Files written through the Cowork output path mirror into the code repo; intermediates go to the scratchpad. |
| **ONE-WRITER-HOLDS** | While a CC session is live this seat writes nothing to the code repo, including the reference and migration folders that are otherwise Arch's own. |
| **BROWSER-NOPRINT** · **PDF-CHROME-PATH** | The built-in browser has no print; a parity print is valid only through Chrome's own Save-as-PDF. |
| **CONTCAT-DIVERGE** · **PAGEBREAK-MODEL** · **CATNOTE-TYPE** · **IMPORT-LINEBREAK-CR** · **LABELSDONE-RESIDUE** · **EQUIPLIST-ROWH-BIMODAL** · **R-7 LABEL SETS** · **LEN-SCALE** · **HISTENTRY-NOTID** · **JOY-NAME-HYGIENE** · **LINES-NOFK** · **CLONELINK-ROWSET** · **BVSC-8POWER-DRIFT** · **PRINTPROBE-MEDIA** | Ruled divergences and standing cautions, unchanged. Do not "fix" any of them back by citing the artifact. |

---

*Roadmap v4.46 · 2026-09-18 · retires v4.45. Written under Architecture Prompt v39. NOW + NEXT + THE SEQUENCE ≤ 8,000 characters is the only hard cap. Code `7c96904` live, Vercel READY. Migration ledger **78** — 77 the read-policy set form (SET-FORM), 78 the method palette; `supabase/migrations/` holds 17 files and 72–78 all have a file of record. Suite 3,458 / 184; frozen 3/3; visual 28/28 at 0.0000%; lint exit 0 (270 warnings). Cohort seventeen, four accounts plus the support login; thirteen to go. **Four production deploys today; the invite waits only on your accounts, names, note and brief.***
