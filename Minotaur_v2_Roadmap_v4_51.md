# 🗺️ ROADMAP — Minotaur v2 (v4.51)

## ▶ NOW

**CHANGEALL-REFUSAL shipped 26 Sept (`cef0949`).** Change All can no longer offer to overwrite every row on screen
with a value you never typed, on either list. It found and fixed two production bugs: a pop-up opened from the
keyboard closed itself on the same key press, and Enter on an unknown cable model silently created a cable type.
The cable list's Change All now greys out when a find matches nothing.

⚠ **Two parts of it you rejected at the gate, and they are live:** the "no method called…" message — typing a new
method should create it, as v1 does — and the "isn't a length" message, which doesn't say what to do. Both are the
first things fixed next.

⚠ **Still unchecked by you:** the category line under each method, and the equipment list's Category refusal. They
need a test show you're willing to change — never JOY.

**Rulings done 24 Sept:** the defaults are all ruled except what goes in each set, which the build asks you for.
Bundle clone and extend has three of its eight.

⚠ **Two people editing one show can still lose work silently.** Aaron Hanna is already sharing shows.

**Nothing is running.**

## ⏭ NEXT — the next three sessions

1. **Will's eight, opening with one CC handoff:** typing a new method on the cable list creates it · Tab after the
   "just this one or all" question moves to the next cell · adding cable types on the Cable Types screen · your
   check of the category line on a test show · and library delete, if you say it can ship before restore exists.
   The shortcut helper follows on its own, because it changes every screen's top bar. **While CC works:** parallel
   design sessions for the silent-loss fix, the library panel and the box family, and the IP address migration
   rehearsed with you.
2. **The box family** — box labels, Box List and Contents List to v1, from your JOY prints. Then Paradise Square.
3. **Cable splits**, with its one open question: does a split's inherited end read through to the parent, or is it
   copied when the split is made?

**Yours:**

- **What should the length message say?** Your words: *"Fifty is a length, it's just not a number string."*
- **Can library delete ship before there's any way to restore a version?**
- **Five bundle rulings** (R4–R8) and **ten minutes in v1**: a bundle with a mult and a plain cable, Add Extension,
  photograph the three dialogs.
- **A second test account**, so anything about sharing can be measured at all · **tell Aaron** not to edit one show
  with someone else at the same time.
- The 5167 stock check plus a 5160 sheet · the Terms v1.1 diff and the privacy policy's two facts · a fresh v1
  export of BVSC US Tour · a fresh licensing export · the bug-report wording.

## 🏗 THE SEQUENCE — the road, in plain language

- **The private beta is open.** Twenty leads plus their teams, invited 19 Sept. **Done:** terms, front door, mail
  sender, sharing, the typeface, the import's time limit, the speed work, method colours, the support login, the
  security upgrade, the accounts, the invite, Jamie's notes request, and the whole equipment-side paperwork.
- **The paperwork, your priority, in your order.** ~~Print fixes · Line List and Bundle Summary · Small Cable
  Labels · Steck and Equipment labels · the equipment list's nine fixes · the three shop documents · Bundle and
  Tail Folder labels · Group Parts and Device Patch~~ (shipped) · **your 5167 check, plus a 5160 sheet** · the box
  family, then Paradise Square.
- **Then Will Pickens's eight**, moved ahead of the boxes and splits by your ruling of 22 Sept: deleting library
  rows · adding cables in Cable Types · the keyboard shortcut helper · the library panel · one IP address field
  that prints and exports · your default content and the screen you manage it from · cloning and extending a
  bundle. **Keep Will updated as each lands.**
- **Then cable splits**, a core v1 feature v2 cannot import a real show without.
- **Then A4.** Every printout and label sheet on A4 as well as US Letter, chosen per show. Before release.
- **Then Allocate**, then **RF, walkies and circuits** with the IAS frequency import, then **live editing by more
  than one person**, designed with working offline. **Keep Aaron updated on all three.**
- **The four weeks after the invite — fix what the cohort finds.** Jamie's contrast and type-size pass · a
  read-only role · a counter that makes an incomplete backup impossible · the terms gate · housekeeping · **the
  silent-loss fix** · and, if you rule it in, nothing lost on a bad connection.
- **Working without a connection** — nothing lost on a bad connection; then open and print your shows offline; then
  full offline editing, designed with live collaboration. **Keep Josh Richardson updated.**
- **Terms v1.1 and the privacy policy** — drafted; publish once you've adopted the wording and the rule that keeps
  Claude out of members' shows is installed.
- **The beta opens to v1 owners when two people have run each core workflow on a real production** — your bar,
  ruled 20 Sept. Mid-October is the forecast, not the gate. **No cohort member has yet imported a v1 show.**
- **Then Maintenance, Spreadsheet Export and Cover Letter**, then the bug report button.
- **November — money.** Checkout and subscriptions, attorney review first, New York's auto-renewal rules built in,
  a seat limit before the first payment.
- **At release — $199 a year**, named user, one session each. v1 on request.
- **Stop: a paid beta by ~March 2027.**
- **Off the road — released by an event, not a date:** a typeface with a two-storey `a` that also has the ohm sign ·
  controls that fail open · duplicating an item · an organisation tier · a monthly price · a per-kind category
  breakdown · the empty backup a new show's first import leaves · chunking the import · live results under the find
  fields · a per-printer print nudge.

---

## 📌 THE DOCKET

Three tables. **▶ ACTIVE** is in the order the work will happen, most immediate first. **⏸ HELD**
waits on a named trigger. **📐 STANDING** binds indefinitely and never closes. Every ACTIVE row
says what it is, who does it, and what it needs before it can start. Measurements, incident
history and reasoning live in the Ledger.

### ▶ ACTIVE — in the order the work will happen

| ID | What it is | Who · what it needs |
|---|---|---|
| **METHOD-CREATE-CABLE** | ⚠ **Rejected at the gate, live in `cef0949`.** On the cable list, a method name that doesn't exist brings up *"There's no method called…"*. Daniel, 2026-09-26: *"this isn't v1 behavior and I didn't approve this. Adding a method called Nutes should make that a method that appears in GCM."* Typing a new method creates it (Enter and Change All alike), as the equipment list already does (CHANGEALL-METHODNEW). | **CC** · needs nothing. First bundle |
| **CABLETYPE-ADD** | Add cable types from the Cable Types screen (Daniel, 2026-09-22: *"add cables in cable types"*). No schema. **Keep Will Pickens updated.** | **CC** · needs nothing. First bundle |
| **TAB-AFTER-SCOPE** | After the equipment list's *"just this one or all"* question, Tab jumps to the filter bar instead of the next cell (Daniel, 2026-09-24). Measured: focus is dropped when the question closes. Put it back where it was. | **CC** · needs nothing. First bundle |
| **MMM-CAT-GATE** | The category line under each method (shipped `3809860`) and the equipment Category refusal (`cef0949`) have never been checked by Daniel. Gate on a test show he is willing to change — **never JOY**. | **Daniel** · rides the first bundle's gate |
| **LENGTH-WORDS** | ⚠ **Rejected at the gate, live in `cef0949`.** A length the app can't read brings up *"fifty" isn't a length.* Daniel: *"Fifty is a length, it's just not a number string. If we want the user to do something, the dialog should be understandable."* | **Daniel** words it · then **CC** |
| **LIBRARY-DELETE** | Delete a library row, and Delete All in the Equipment Library, with a button and a shortcut. A member who imports the shared library cannot remove any of it today. Every version already carries the library (*"library should be in version history"*, 2026-09-22), but nothing can be restored from a version yet (VERHIST-RESTORE). **Keep Will Pickens updated.** | **CC** · needs Daniel's word: can delete ship before restore exists? |
| **SHORTCUT-HELPER** | A keyboard-shortcut helper in the menu bar (Daniel, 2026-09-22). Re-baselines the top bar, so it ships alone (HANDOFF-BUNDLE). **Keep Will Pickens updated.** | **CC** · needs nothing |
| **LIBRARY-PANEL** | A panel at the bottom of the equipment list showing the selected model's library defaults — public note, private note, rack spaces, power draw — editable in place. v1 has it (layout 26), measured field by field by the LIBRARY parallel; client-only, no migration; the read path is the one open call. **Keep Will Pickens updated.** | **Arch** rules the read path · then **CC** |
| **IP-ONE-FIELD** | v2 keeps two IP columns: labels print the one imported from v1, the column you type into saves to the other. Merge them, so a typed IP prints on the label and exports back to v1. One migration (Trigger B), then the list, Find and Change All read the merged column. **Keep Will Pickens updated.** | **Arch** rehearses · **Daniel** Trigger B · then **CC** |
| **SEED-DEFAULTS** + **DEFAULTS-ADMIN** | A new show comes with your library, methods, categories, cable types and box types, curated in an ordinary show called *Defaults* and pushed with a Publish button. **Ruled 2026-09-23/24:** copied at creation, never linked · Path B · Publish replaces · Equipment Library ticked by default · your five switch descriptions (Ledger). One migration (global box types). The build asks you for each set's content. **Keep Will Pickens updated.** | **Arch** rehearses, after REGISTRY-REST's admin check · **Daniel** Trigger B and the sets · then **CC** |
| **BUNDLE-CLONE-EXT** | Clone a bundle and extend a bundle — the restored **D-2b**. No migration (measured). **Ruled 2026-09-24:** Clone and Ext in the row strip with ⌥⇧G and ⌥⇧X; a cloned bundle's mults arrive empty, as v1. **R4–R8 wait**, and one ten-minute v1 errand (Add Extension, three dialogs). **Keep Will Pickens updated.** | **Daniel**: five rulings and the frames · then **CC** |
| **PRINT-REPARITY-BOX** | The box family's v1 round: box labels, Box List, Contents List (**absorbs BOX-DOC-PARITY**). **Unblocked 2026-09-22 — the matched JOY pair is in `parity-pairs/260922_box-family_JOY/`.** First read, content only: Big Box Labels and Replacement Numbers match v1's text on every page; the Box List is missing six weights and one differs by 1 lb; the Contents List prints no Packed marks and does not combine two lines of the same name. Carries the staged box fixes and OQ-3/4/5. **Then Paradise Square**, which exercises small box labels and box-in-box, neither of which JOY has. | **Arch** measures and designs · then **CC** |
| **STALE-WRITE** | ⚠ **Measured 2026-09-24, on the running app.** Two people in one show: the later write silently wins and the loser's screen keeps showing a value that is no longer stored; an edit to a row someone else deleted is accepted on screen and never saved, with no message. Proposed, cheap, ahead of LIVE-COLLAB: a write that changes no rows says so and refreshes. **Daniel tells Aaron Hanna in the meantime.** | **Daniel** rules · **Arch** designs · then **CC**. Week one |
| **LIVE-COLLAB** | Live editing by more than one person, split out of V1-SECTIONS by Daniel 2026-09-23 and placed after RF-COMMS; OFFLINE-3 is designed with it. Today there is no live update at all, on either list (measured 8–10 s, no change until reload). **Keep Aaron Hanna updated.** | **Arch** designs · then **CC** · after RF-COMMS |
| **ALLOCATE** | Allocate as Cable, Tail or Box, sharing the split's quantity code; **absorbs UNALLOC**, and amends Brief v1.1's *"allocate … is eliminated"*. Ruled by Daniel 2026-09-23, placed after A4-LAYOUTS. **Keep Aaron Hanna updated.** | **Arch** designs · then **CC** · after A4 |
| **TEST-ACCOUNT-2** | There is one test credential, so every two-seat question — sharing, roles, live editing — cannot be measured at all. A second test account, with a shared throwaway project. | **Daniel** creates it · then any seat |
| **CHANGEALL-SPEED** | Measured 2026-09-24 on 1,123 cables: ~10 s cold, ~3.4 s warm, of which **more than half is the version snapshot**, which by ruling runs before the write so it can refuse the gesture. The write itself is ~4 s. A faster or asynchronous snapshot is its own unit. | **Arch** · after the beta's first weeks |
| **VERHIST-RESTORE** | ⚠ **"Open as new production" calls nothing and the database function does not exist** (LIBRARY parallel, 2026-09-22). So nothing can be restored from a version today. Carries the written rule that a restore never empties the library, and Daniel's 2026-09-11 ruling that a restored copy carries the original's Equipment List Revisions — which are in **no** backup, along with import history and the per-show feature switches. Absorbs VERHIST-REST's fork half. | **Arch** rehearses · **Daniel** Trigger B · then **CC** |
| **STOCK-5167-CHECK** | One printed sheet each of **Steck, Equipment, Tail Line and Small Cable labels** on real Avery 5167 stock, held against a blank — **and one 5160 sheet** (Bundle Labels or Tail Folder Labels), because the 5160 grid is v1's measured die, not Avery's published cut (they differ by up to 1.3 pt at column 3) and STOCK-IS-DIE has never been applied to it. ⚠ **Your printer prints about 3/64" low, and v1 does the same on it** — try the other paper path before ruling anything. | **Daniel** · needs nothing |
| **BOX-ROW-TYPE** | The equipment list's Racks and Boxes section prints boxes by name; v1 prints them by type with a count, which is what a shop orders from. Which box field the list projects is a design call. | **Arch** designs · then rides EQUIP-PARITY-2 or the box family |
| **LANDSCAPE-CREDIT-LOGO** | On the two landscape documents (Tail Checklist, Bundle Sheet) a project with **both** a logo and a credit line would print them over each other — v1's own layout does the same, but nobody has seen it because JOY has no credit line. Your call whether they should be separated; if not, the row closes. | **Daniel** rules · then **CC**, rides the box family |
| **IMPORT-TRAILSPACE** | ✅ The name-lookup half shipped 2026-09-19 (migration 82). What is left: **`cPreview`**, which three v1 prints show and v2's cable table does not hold; **two end colours imported as Chartreuse where v1 prints Sand**; whether parentless tails share one column on the tail sheets; and whether v1's Tail Folder export writes an empty leading slot for a blank model (v2 prints none). | **Arch** diagnoses · **CC** fixes |
| **NEWPROJ-IMPORT** | An **import-from-v1 button on the new-project screen** (Daniel, 2026-09-19: *"when making a new project, add an import from v1 button to the new project screen"*). **Rides with it:** the import report's "source device" warning comes out — it warns about a match nothing in v2 uses (3 of 120 on JOY) and tells people to rename equipment they shouldn't (`handoffs/parallel/260921-1027_import-device-note_TO-MAINLINE.md`; Daniel: *"write a handoff to the mainline to update this text"*). The remaining block's wording is proposed there for your word at the gate. | **Arch** designs · then **CC** |
| **OFFLINE-1** | A save that fails because the network dropped is **held and sent again on reconnect**, not reverted; a visible "offline — changes will save when you reconnect" line. Nothing typed on a bad connection is lost. Every write path is censused first; a *refused* write is never queued. **Keep Josh Richardson updated.** | **Daniel** rules where it sits and opens the frozen save layer · **Arch** designs · then **CC** |
| **OFFLINE-2** | An installable app; recently opened shows readable and printable with no connection. **Keep Josh Richardson updated.** | **Arch** designs · then **CC** · before or at release |
| **OFFLINE-3** | Edit offline and sync on reconnect, merging with collaborators — designed together with real-time collaboration (V1-SECTIONS). **Keep Josh Richardson updated.** | **Arch** designs, rehearsal first · placement is Daniel's ruling |
| **US-TOUR-REIMPORT** | BVSC US Tour was deleted 2026-09-18 on your word because it had drifted from v1. Remake it with a fresh v1 import under your own account; about 2,600 items, well inside the 90-second limit. | **Daniel** · needs a fresh v1 export of the show |
| **CABLE-SPLIT** | A core v1 feature v2 cannot import a real show without. Ruled 2026-09-18: a split is two fields on the child cable; the named end is its own, the other inherited from the parent. Designed against the v1 source; one migration specified. **R6 closed by measurement.** Still owed before the migration: whether an inherited end reads through to the parent or is copied at creation. | **CC** for five rows, **Arch** for the migration rehearsal · after the paperwork |
| **A4-LAYOUTS** | Every printout and label sheet on **A4 as well as US Letter**, chosen per show. Today every v2 print is fixed to US Letter and the page height drives pagination, so A4 is a second page geometry — **scope unmeasured; measure before design.** UK users print labels on **Avery L7656**, so an A4 label stock has to be chosen. Daniel, 2026-09-19: *"put on the roadmap in the fairly near term, before official release."* | **Arch** designs · then **CC** · after the v1 re-check |
| **USER-DATA-RULE** | The rule that keeps Claude out of members' shows (Daniel, 2026-09-21: *"option C"*): Arch reads no member's project content unless that member has shared the project with the support account for the case and has not asked Claude be kept out; counts and measurements across the database, and account information, are allowed. Goes into the Architecture Prompt (a swap — one rule out) and `CLAUDE.md`. **Gates the publication of Terms v1.1.** The mechanical backstop — a connector role that cannot read content tables — is Arch's to weigh. | **Arch** drafts the swap · **Daniel** confirms · before TERMS-V1_1 |
| **TERMS-V1_1** | **Ruled 2026-09-21: "path A"** — v1.1 is a correction, not a §11 change: no email, no sign-in notice; the ten people who accepted "90 days" keep 90. Drafted and byte-checked: `handoffs/parallel/BETA_TERMS_v1_1.md`, the clause diff beside it. To ship: a new file, a new version constant, the identity test, Version 1.0 kept readable at a stable path; and **TERMS-GATE must accept both 1.0 and 1.1** until the pre-public-beta version. | **Daniel** adopts the wording · **Arch** installs USER-DATA-RULE · then **CC** |
| **PRIVACY-POLICY** | Drafted: `handoffs/parallel/PRIVACY_POLICY_v0_1.md`, every fact traced. **Cannot publish until you supply two facts** — Vercel's region, and where the FileMaker licence file lives. Ships as a `/privacy` route carried in code like the terms, linked from `/beta-terms` and the landing page. Promised in writing (terms §12) before the v1-holder beta. Its new decisions (waiting-list retention, v1 licence records outliving an account, a 30-day answer window) are marked NEW in the draft and are yours. | **Daniel**: the two facts and the wording · then **CC** |
| **ACCOUNT-DELETION** | Account deletion has never been shown to work, and the schema will fight it: `projects.owner_id` is RESTRICT, and several `created_by` / `invited_by` columns are NO ACTION. A runbook covering storage objects and those keys, before the first deletion request; whether the acceptance record should outlive the account is the attorney's (packet line 28). | **Arch** · before the first request |
| **CONTRAST-PASS** | Jamie's finding: raise contrast everywhere in both themes and assess type that is too small. Five renderings or a switcher, and picking one is the acceptance. Absorbs the dead-class sweep, the bounced auth link colour, the confirm-button flip, the sort band that vanishes on a dark page, the dashboard's faint shared marker, and the type-size assessment. **Ride-along (Daniel, 2026-09-19):** the equipment print options' radio buttons follow the project colour; the cable print options' do not. | **CC** · **you pick a rendering**. Week one |
| **VIEWER-ROLE** | A read-only role for people who should look and not edit. Every edit control on every surface has to be found and hidden, because a refused write returns zero rows and raises nothing. Carries the roster's role column, a member's ability to remove themselves, and whether an address shows under each name. | **CC** · needs the whole-app control sweep first. Week one |
| **TERMS-GATE** | Acceptance is recorded in exactly one place — the set-password page — so anyone handed a password never accepted. Two cohort members are in that state; ruled 2026-09-17 as logged, not chased. The fix is a routing gate onto the page that already exists, **accepting Version 1.0 and 1.1 alike**. Not in the middleware. | **CC** · needs your wording for the screen |
| **BETA-BAR** | The v1-holder beta opens when **two people have run each core workflow on a real production** — a shop prep printing cables and boxes, a revised equipment list, an import, an export back to v1, a shared project. Daniel, 2026-09-20: *"at least two people touching every feature of the beta for a real production … not necessarily the same two people"*. ⚠ **Measured 2026-09-21: no cohort member has imported a v1 show** — five imports, all equipment-library spreadsheets only. **No print writes a row**, so the print legs must be asked about. | **Daniel** · the list of workflows is his |
| **VERHIST-REST** | What is left of version history: a counter that makes a silently incomplete backup impossible; "open as new production", a migration deferred past the invite; and the blob and gesture-class residue. ⚠ **Corrected 2026-09-22: the library IS in the payload and always has been**; the fork half is now VERHIST-RESTORE. What is left here is the counter and the blob and gesture-class residue. | **Arch, then CC** · the counter needs nothing; the fork needs a rehearsal and your Trigger B |
| **IMPORT-REMEASURE** | Ninety seconds covers roughly 4,700 items at the one rate measured — one show, linear scaling assumed; re-measured on the first large cohort import. Chunking stays unbuilt. | **Arch** · needs a real cohort import |
| **REGISTRY-REST** | ⚠ **Superseded, pending the licence-management parallel's return** (opened 2026-09-20, not returned as of 2026-09-21): the admin surface; V1-ISSUE; the licensing workbook import, which needs a fresh export from you; payments once Strat picks a provider; the v1 entitlement check; the sign-up gate for v1 holders. The registry's tables read 0 rows, by design, until that import runs. **Do not write competing rows.** | **Arch parallel** · the import needs **your fresh export** |
| **LEGAL** | The IP assignment, the attorney packet and the 60-day window. Attorney review before v2 charges anyone — **thirty-seven packet lines now** (sixteen added 2026-09-21 by the terms parallel: the 90-day acceptors, customer exports tracked on GitHub, deletion blocked by the schema, the acceptance record dying with the account, the Anthropic plan's standing at scale, among them). New York's auto-renewal statute is a build requirement. | **Daniel and the attorney** · needs the packet assembled. Week of Oct 5 |
| **SECURITY-PREPUBLIC** | One pass before public beta: the residual truncate grants, the grant-restore sweep, two functions with a mutable search path, 51 unindexed foreign keys, the resolver rate limit, the one high security warning left after the Next.js upgrade (`browserslist`), and **MIDDLEWARE-PROXY**. The import-timeout hook runs on every request, so anything added to it is on the hot path. | **Arch** · your Trigger B on each database item. Before public beta |
| **RF-COMMS** | RF devices, walkies and circuits, and the IAS frequency import. The tables exist and are protected; there is no screen. **Ruled by you: after the public beta opens**, and after ALLOCATE (Daniel, 2026-09-23). Adds Allocate as RF. **Keep Aaron Hanna updated.** | **Arch designs, CC builds** · after the mid-October opening |
| **V1-SECTIONS** | Maintenance, Spreadsheet Export and Cover Letter. **Real-time collaboration split out to LIVE-COLLAB** (Daniel, 2026-09-23). Placed after RF until you order them; OFFLINE-3 is designed with the collaboration piece. | **Arch**, with your order · after RF-COMMS |
| **BUGREPORT** | A form so a cohort member can tell you what broke without writing an email, and hand you the show read-only, one case at a time. Ships the route, project, time, browser, viewport, theme and build, plus the last 25 console errors, never stored; a paste target for screenshots. Carries the redaction rule. | **CC** · needs VIEWER-ROLE, your wording, and the build stamp. After public beta opens |
| **EXPORT-INTEGRITY** | One export unit rather than six: the history-id drop, state carried in the export, line-feed and hash-drift issues, v1's null marker in Line Color on 86 rows, and 823 orphan identity rows on BVSC Mexico. Cable split's export arm reads with this. | **CC** · one fixture must be looked at before any re-import overwrites the evidence |
| **BATCH-BOX** | The box work that is not about paper: re-parenting, name uniqueness, type volumes, the dead dimensions column, the alpha-step and zero-label questions, and **whether Box Labels should fire the skip on every GO** (Cable Labels does not; v1's box scripts unchecked). Also BVSC's box-heading order on Bundle Labels, which is neither number nor text order — low priority, recorded so it isn't rediscovered. | **CC and Arch** · needs PAPERWORK's box parity round first |
| **FONT-NEXT** | The shipped face has no ohm sign and no ≥ or ≤, and you asked for a two-storey `a`. Candidates are checked for those three characters before you are shown a rendering. | **Arch** renders, **you** pick. After public beta |
| **BATCH-HARNESS** | The visual-gate and harness residue: the theme-preference restore depends on the theme toggle (NEXT-UPGRADE S2-2); a wander site registered by a point should be a span; `01-project-menu-dark` shows 20 px at Δ1 on 6 of 9 runs, judged 0, unregistered; **the frame-01 topbar wander reproduced on 2026-09-20's runs (H3's thread)**; **no fixture has a non-owner member since the account separation**. | **CC** · needs nothing. After the invite |
| **OQ-UNPLACED** | Fourteen questions with no owning unit, held in one row so that unplaced is visible rather than invisible. | **Arch parallel** · needs the invite out |
| **STRAT-OWED** | Strat's own list: the Brief's next version, carrying the $199 price and the corrected competitor benchmark; the Comms prompt rewrite; the deskwork on eight unreachable live v1 holders and the missing Square customer export; the Vercel token rotation, hard at about November 8. | **Daniel and Strat** · the deskwork needs the Square export |
| **PROCESS** | Everything harness- and document-shaped, in one parallel and never on the main line: the document refactor's remainder, the stray untracked trees, the commit-phrase pilot's sunset review, and the Docket's own bundling pass. | **Arch parallel** · needs the week-one fixes shipped |

### ⏸ HELD — waiting on a named trigger

| ID | What it is | Trigger |
|---|---|---|
| **EQUIP-FALLBACK-REST** | Three leftovers of the same shape on the equipment list: a blank category then Change All still offers the stored category; Quantity's unreadable-number arm does the same (unreachable by typing today); and the equipment and library Change All buttons stay lit once armed. | The next equipment-list unit |
| **DIALOG-FOCUS** | While a refusal is up, the caret can sit in another box behind it (Tab out of a cable field) or nowhere (click away on the equipment band); typed letters could land behind the dialog. | The next dialog work |
| **DIALOG-OPENING-KEY** | 28 files carry the keyboard listener that let a dialog answer the key that opened it; two are fixed, one measured clean, the rest unmeasured (census in `CLAUDE.md`). | The next unit that touches any of them |
| **SORTBAND-CLICKZONE** | The outer sort band opens its editor only where the label text is; a click anywhere else across the full-width band does nothing. | The next equipment-list unit |
| **EQUIPLIST-NOCURRENT** | The equipment list opens with no current row (the cable list's old state). No control there looks live and does nothing, but five keyboard chords silently no-op. Whether the two lists should match is Daniel's. | Daniel's ruling |
| **OUTPUTS-MIRROR** | A handoff written to `handoffs/to-cc/` also appeared in `Minotaur-Cowork/Claude outputs/`; CC read the mirror. Both copies were identical, so nothing went wrong — but nobody has said what writes that folder. | PROCESS |
| **PRINT-NUDGE** | A per-computer setting that shifts a printed sheet up or down by a few points. Daniel's Brother MFC-J6935DW prints about 3/64" low on **both v1 and v2**, which is the printer, not the layout. v1 never had one. | A cohort member reports the same drift, or the 5167 check says so |
| **LIVE-RESULTS** | A list of matching names under the find fields that narrows as you type, before GO — never built. **"Not now" (2026-09-18):** the paperwork stays pure v1. | After the paperwork |
| **FROZEN-FLASH** | The one error-flash timer ST-RACE could not convert, because it lives in the frozen equipment-save layer. | A ruling that opens the frozen layer |
| **VERHIST-PHANTOM-IMPORT** | **Ruled by you 2026-09-18: leave it.** Importing into a brand-new show saves a backup of an empty show. Harmless today. | After public beta, batched with the restore work |
| **LETTERHEAD-COMPOSITE** | Build in the product what you do in OmniGraffle: a half-inch logo with text set to its right, assembled into the header band. | After PAPERWORK's letterhead leg |
| **FONT-ADJUST** | If the fallback face is ever promoted to default, one setting normalises it to Century Gothic's x-height automatically, plus a decision on semibold. | Only if the fallback is promoted |
| **BUGREPORT-BATCH-CONTRAST** | Should the bug report ride into the contrast pass's declared visual event rather than declare 28 frames of its own? | When CONTRAST-PASS is scoped |
| **ERROR-BOUNDARY** | There is no error boundary anywhere in the app, so an uncaught render error shows the framework's own default screen. | Week one or later |
| **BUGREPORT-SHOT** | Automatic screen capture — needs a permission prompt or a DOM renderer, storage and a retention rule, and cannot be redacted. | After the cohort files real reports |
| **CATCOUNT-BREAKDOWN** | Category counts broken out by kind — items, cables, tails and boxes separately. | After public beta |
| **ORG-TIER** | An organisation account: the theatre or shop owns the projects and an admin manages seats. | Strat, after the first paid quarter |
| **MONTHLY-HOLD** | A monthly Individual price, only if the licensing data shows the few-shows-a-year segment is small. | Strat, after the first paid quarter |
| **CAT-MERGE** | There is no merge for categories, so a rename collision refuses and reverts. | Its own later unit |
| **REVGROUP-SPLIT** | Revision-mode print groups by model alone while the plain list groups by model and note. | PAPERWORK |
| **CATBAND-CASEDUP** | Two category rows differing only in case and sharing a rank collapse into one band. | Its own unit, or the next category work |
| **MENU-DEPRECATE** | Remove Wire Types and Wiring Schedule from the main menu. | Rides a UX unit with a working gate |
| **SPENDCAP-BETA** | Keep the Supabase spend cap on. Point-in-time recovery sits outside it and bills regardless. | Before public beta, or at half any quota |
| **LINKEDBOX-LIVEPROOF** | A live browser proof that clearing the Box on a linked cable fans out to its pair. | The next cable unit |
| **DEVICE-FK-LINK** · **CATSORT-NATURAL** · **EQUIPVIEW-UNSAFE** · **EQUIPLIST-QTYCOL** · **SKIP-LABELS** · **BUNDLE-NA-UNTESTED** · **FIXTURE-NUMLABELS-GONE** · **HISTID-HASH-COST** · **SMOKE-LOGIN-HYDRATION** · **IMPRPT-COPY** · **BUILDSHEET-CMT** · **DEV-SERVER-AGE** · **SHOP-ORDER-NOTES** · **BUNDLE-FIND** · **SED-GUARD** · **REPO-WEIGHT** · **GIT-CFG** | Unchanged singles, each waiting on the unit named in v4.37. The two orphaned lock files in the code repo are yours to remove at the terminal. | Their units |
| METHOD-FIX · GATE-OL25WR · GATE-C4 · S504 · CONCEPT-A · UNALLOC · EFFGRP · DOOR-V1LINK · CABLE-LOADER · RULINGS-WANTED · METHOD-STRAYS | Unchanged. Method strays deprioritised by you 2026-09-15. | Icebox sweeps |

### 📐 STANDING — binds indefinitely; never closes

| ID | The rule |
|---|---|
| **MAILGATE** | Nothing sends email to any address that is not Daniel's own until he approves that send in a message whose only content is the approval. One approval, one send. CC never sends mail or provisions accounts. |
| **SESSION-SHAPE** | A session opens with a CC handoff, bundled as large as the ruled material allows; the seat spins off parallel Arch designs only once Daniel confirms the handoff is in CC's hands. Arch never idles waiting on CC. A migration whose acceptance is a timing measurement goes first. |
| **PROPOSAL-ASKS-FIRST** | A behaviour Arch proposes — anything the user will see that is neither Daniel's ruling nor v1 evidence — is put to Daniel in plain words before it goes into a handoff. He does not meet it for the first time at the gate. |
| **JOY-READ-ONLY** | Daniel does not change data on JOY (2026-09-26). JOY is for reading and printing; any gate step that writes uses a throwaway, the Cable Parity Fixture or a test-account show. |
| **HANDOFF-BUNDLE** | Small fixes ride as few, long handoffs as possible, and a bundle's members are censused before it is written. A unit that re-baselines the whole visual gate ships alone. |
| **RULED-IS-RULED** | A ruling already made is not re-opened by a later instruction without saying so. Before writing anything that touches a ruled unit, read that unit's row and the surface at source. |
| **REHEARSE-BEFORE-RULING** | A mechanism is rehearsed before it is ruled, not after. |
| **QUESTIONS-IN-ROWS** | There is no Open Questions section. A question lives inside the row of the unit that will answer it, or as its own row with an owner and a trigger. |
| **MEASURED-NOT-PREDICTED** | Check the instrument before citing it, and say which is a measurement and which is a prediction. |
| **GATE-SETTLE-BETWEEN** | A reliability measurement lets the machine settle between runs; no two timing runs — or a timing run and a visual gate — share one database. |
| **GATE-REPORTING** | A green machine gate never substitutes for Daniel's browser gate, and his words are the record. |
| **GATE-NOGREP** | Never pipe a gate run through a filter; write it to a file and read the file. |
| **POLICY-RETURNING-SNAPSHOT** | A SELECT policy that resolves permission by re-reading its own table breaks insert-with-returning. |
| **POLICY-CAPTURE-FIRST** | Any migration that drops or replaces a policy captures the existing policies for every affected table before applying. |
| **MIGRATION-FILE-FROM-SOURCE** | A migration's file in the repo is read back out of the database and checksummed against what executed, never reconstructed. |
| **FOUNDSET-NOT-COUNT** | A count that matches is not a found set that matches. Compare the rows themselves. |
| **SWEEPLINE-NOT-DURABLE** | Anything that must outlive one session goes in a row or the Ledger. |
| **HELD-IS-NOT-FORGOTTEN** | A HELD row without a named release trigger is illegal, and every close checks whether any trigger has fired. |
| **TENSE-IS-A-CLAIM** | An expectation written in the past tense reads as a measurement. |
| **DEAD-CODE-IS-NOT-SAFE** | A symbol with no production callers is dead code, not low blast radius. |
| **DEAD-CONTROL-IS-A-BUG** | A control whose result is displayed nowhere is a defect, not a harmless spare. |
| **ACCIDENTS-OF-THE-FACE** | Before changing a face, ask what the old one was doing by accident. |
| **FONT-IS-NOT-SHIPPED** | Any measurement of a printed or laid-out surface states which typeface rendered it. |
| **APCA-NOT-WCAG** | For dark-mode text the WCAG ratio cannot see polarity; report APCA alongside it. |
| **CONTRAST-PAIR-RULE** | No white text on yellow. A static ground wants static text. |
| **LOOK-AT-THE-FRAMES** | Every frame in a declared visual event is opened and read before any baseline is written. |
| **DDR-IS-THE-SOURCE** | For v1 behaviour, go to the source that made the ink — the design report — not to a screenshot or the repo's own belief about v1. |
| **HIST-BLIND** | v1's field-level audit lives in save triggers that a scripted mass edit does not fire. |
| **PORT-COV-REIMPORT** | A v1 re-import path is a product requirement; acceptance is round-trip, not column order. |
| **GRAPH-BEATS-RERUN** | An import graph says whether a frame could ever have seen the change; two re-runs is the limit. |
| **PROJECT-NAME-NOT-UNIQUE** | Two productions of one musical share a show name. Every citation names the project id. |
| **HARNESS-RLS-CORPUS** | The parity fixtures — and JOY — are invisible to the test user, so every harness measurement is a labelled reproduction on a throwaway; Daniel's print on JOY is the record. |
| **TOAST-ON-WRITE** | Column size on a computed value reports the uncompressed datum. |
| **FENCE-ONEUNIT** | The run fence carries one unit, not a history. |
| **PARALLEL-CLOCK** | The timestamp in a filename is the ordering key; write it at the time of writing. |
| **ARCH-OUTPUTS-MIRROR** | Files written through the Cowork output path mirror into the code repo; intermediates go to the scratchpad. |
| **ONE-WRITER-HOLDS** | While a CC session is live this seat writes nothing to the code repo, including the reference and migration folders that are otherwise Arch's own. |
| **BROWSER-NOPRINT** · **PDF-CHROME-PATH** | The built-in browser has no print; a parity print is valid only through Chrome's own Save-as-PDF. |
| **CONTCAT-DIVERGE** · **PAGEBREAK-MODEL** · **CATNOTE-TYPE** · **IMPORT-LINEBREAK-CR** · **LABELSDONE-RESIDUE** · **EQUIPLIST-ROWH-BIMODAL** · **R-7 LABEL SETS** · **LEN-SCALE** · **HISTENTRY-NOTID** · **JOY-NAME-HYGIENE** · **LINES-NOFK** · **CLONELINK-ROWSET** · **BVSC-8POWER-DRIFT** · **PRINTPROBE-MEDIA** · **FLAGGED-HEAD-BOTTOM** · **NUMBER-SORT** | Ruled divergences and standing cautions. FLAGGED-HEAD-BOTTOM (Daniel, 2026-09-21): the Bundle Sheet's flagged header sits on the header line and wraps upward, where v1 top-aligns. NUMBER-SORT (Daniel, 2026-09-19, "sort as number approved"): number-aware order everywhere, where v1 sorts text. Do not "fix" any of them back by citing the artifact. |
---

*Roadmap v4.51 · 2026-09-26 · retires v4.50. Written under Architecture Prompt v39. NOW + NEXT + THE SEQUENCE ≤ 8,000 characters is the only hard cap. Code `cef0949` live. Migration ledger **83**, unchanged — no migration this session; `supabase/migrations/` holds 22 files, 72–83 all with a file of record. Suite 3,888 / 211; frozen 3/3; visual 28/28 with no event; lint exit 0 (265 warnings). **One deploy: CHANGEALL-REFUSAL `cef0949`.** ⚠ **Two of its refusals were rejected by Daniel at the gate and are first in line.***
