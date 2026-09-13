# 🗺️ ROADMAP — Minotaur v2 (v4.34)

## ▶ NOW

The three pre-beta fixes are live. The password-setup page — the only way a cohort member gets into v2 — is built and tested but not committed; it is waiting on your browser check. While building it, CC found two problems in the design, both fixable before the invite: the emailed link can be burned by a corporate mail scanner before the operator clicks it, and two lines on the sign-in page are unreadable in dark mode.

## ⏭ NEXT — the next three sessions

1. **Finish the front door.** You browser-check the password page and type the commit phrase. Then one handoff fixes the two findings: the link opens a page that verifies only on a click (AUTH-LINKCLICK), and the sign-in contrast is repaired (AUTH-SIGNIN-CONTRAST).
2. **Provision the cohort.** You approve the sixteen addresses (four need a word) and set the Supabase email templates; Arch designs how an account is created from an address and how the invite is accepted (AUTH-PROVISION). Nothing sends without your standalone yes.
3. **CHANGEALL-MODEL-SERIAL and VERHIST-SWEEPWATCH, bundled** — the slow model Change All, and the backup log nothing reads. VERHIST-FORK after that, and you may defer it past the invite.

**Yours:**

- Beta terms in force before any outsider touches v2 — draft v0.1 exists; read it, add the named-user paragraph, adopt it. This week.
- The browser gate for the cable-delete fix, now on live code: delete a cable that is in a bundle or carries link badges, confirm it is fast and that a 2-member group vanished while a 3+-member group kept its other members.
- Two wordings: the cable-delete failure message (reworded, awaiting your yes), and yes or no on repairing the two sign-in lines.
- The invite note and the one-page cohort brief, then tell the sixteen.
- A cable label print on real stock, the 5167 sheet with it, and the production READY check.

## 🏗 THE SEQUENCE — the road, in order

- **≈2026-09-18 — PRIVATE BETA.** Sixteen leads plus their teams, 30–40 people. The front door is live (`3416650`). Needs **TERMS-ACCEPT** built and deployed (the terms are adopted; that deploy puts them in force), **AUTH-SMTP** (a custom mail sender — the built-in one refuses every address outside Daniel's Supabase team), **AUTH-DASHBOARD**, the sixteen accounts created (**AUTH-PROVISION**), **SHARING**'s REV-B and **APPLY-TIMEOUT** built, plus the invite note, a cable label print on stock, and the READY check. Terms before any third-party access.
- **The four weeks after — fix what the cohort finds.** **ENTITLE-V1** scoped and built. **PROCESS-REFACTOR**'s remainder opens as a parallel once week-one fixes ship.
- **Target 2026-10-15, floating — V1-HOLDER BETA.** Free with an active v1 license, gated on beta terms and ENTITLE-V1. The announcement is the drop; no tease.
- **~November — LICENSING.** v2 checkout on the **REGISTRY**, with an attorney review of the subscription agreement before the first charge and the New York auto-renewal rules built in (**GBL-527A**). **SEAT-CAP** (one active editing session per Individual account) is built before anyone is charged.
- **RELEASE — $199.** v1 included on request, none sold à la carte; v1 Personal holders free to the end of their year; v1 Production holders free during the beta, ~$100 after. Production tiers unchanged (NfP $349, Commercial $599, perpetual per project). Named-user accounts; one active session per Individual.
- **Stop condition: paid beta by ~March 2027.**
- **Off the road, released by trigger and not by date:** the fail-open controls, FIELDCONTRACT-3B, BATCH-HOUSEKEEPING, `duplicate_item_v1`, META's Tier 2 and 3, ORG-TIER, MONTHLY-HOLD.

---
## 📌 THE DOCKET

Three tables. **▶ ACTIVE** is being worked, dated, or owed now. **⏸ HELD** is real and registered, waiting on a named unit, batch or trigger. **📐 STANDING** binds indefinitely and never closes. A row is one line: what is owed and who owns it. The reasoning behind any row is in the Ledger; the full text of every row as it stood before this version is in `Minotaur_v2_Roadmap_v4_32.md`, kept in the repo.

### ▶ ACTIVE — being worked, dated, or owed now

| ID | One line | When / trigger |
|---|---|---|
| **AUTH-COPY** | The five 2026-09-13 sentences (confirm page ×3, sign-in ×2) are RULED; the reworded code-refusal sentence and the rest of the 36 remain proposals; TERMS-ACCEPT adds three ruled ones. Making the ruled ones pedigree (a) in the code rides AUTH-POLISH. | AUTH-POLISH |
| **AUTH-POLISH** | One bundled CC handoff after TERMS-ACCEPT, all ruled 2026-09-13: the five auth sentences made pedigree (a) in the copy module; `brand-400` links readable in dark mode (2.42:1 today — Arch picks the light/dark pair); the sign-in page's two inputs on live steps like the new pages; CABLEDEL-FAILMSG's wording; `0` in a Method Change All means N/A (v1) and a blank field changed-all makes the field blank; a blank box on one linked row follows to its linked rows (box fields are links); `Truck 2` and `truck 2` are one band (BOXBAND-DUPKEY); the Categories tab shows an item count (CATCOUNT-COLUMN, filtered by `type`). | Arch writes it after TERMS-ACCEPT commits |
| **AUTH-DASHBOARD** | The Supabase dashboard: recovery template on `{{ .TokenHash }}` + `{{ .Token }}`, allow-list carrying `https://minotaur.app/auth/confirm` and the localhost one. Set the invite template to the same shape too, so a stray dashboard send cannot rebuild the scanner defect. | Daniel, before any invite send |
| **AUTH-PROVISION** | RULED 2026-09-13: accounts are created by hand in the Supabase dashboard (create user, auto-confirm, no password — no mail is sent); the operator sets their own password through the reset flow, told the three steps in the invite note. No script, no invite email. After the sixteen exist, Arch writes their real names into `profiles.display_name` in one confirmed SQL pass (the greeting and History's Who column show it; the default is the address's local part). Programmatic creation moves into SHARING REV-B. Rehearsal 1 (a full reset to Daniel's own address on production) is owed. | Daniel, before the invite — creates the sixteen; then Arch, the names |
| **AUTH-SMTP** | Verified 2026-09-13 in the vendor's guide: without a custom SMTP server, Supabase Auth refuses to deliver to any address not on the project's team — the first cohort member to request a reset would get no email, and the page cannot say so by design. RULED 2026-09-13: the sender is Porkbun, where `info@minotaur.app` is hosted (`smtp.porkbun.com`, port 587, TLS — what Gmail already uses); read Porkbun's daily limit off its page at setup. Then rehearsal 2, a reset to an address of Daniel's that is NOT on the team. Absorbs AUTH-MAILVOLUME. | Daniel; gate ≈Sept 18, before any invite |
| **TERMS-ACCEPT** | RULED 2026-09-13 (beta-terms parallel): the ruled sentence and link directly below the Save password button, plus a stored version string and timestamp — no click-through screen. Migration 60 (`terms_acceptances`, append-only from the app) is applied. Handoff written: record-then-password, `/beta-terms` serving the file of record with the publication date, one middleware carve-out. The deploy is the publication. | CC, after CHANGEALL-MODEL-SERIAL commits; gate ≈Sept 18 |
| **PRIVACY-POLICY** | Terms §12 promises the cohort, in writing, a privacy policy before the v1-holder beta. Its own parallel opener on the beta-terms pattern; Addendum §D's regime question belongs to it. | Daniel; before Oct 15 |
| **COHORT-EMAILS** | RULED 2026-09-13: the sixteen addresses found 2026-09-12 are approved as listed (Tracey at `mtracey@me.com`, Hsieh at `bshsieh@me.com`; Pickens and Meadows at their BCC-list addresses). Nothing sent. | Closed as a list; the accounts are AUTH-PROVISION's |
| **SHARING** | Roles and invites are ruled (SHARE-R1..R8). Left: REV-B — the database permissions delta, the fourth role's sketch, and programmatic account creation for a teammate (from AUTH-PROVISION, 2026-09-13). `project_members` exists with owner/editor/viewer; 25 rows, all owner. | Arch, REV-B. Gate: ≈Sept 18 |
| **APPLY-TIMEOUT** | A full-size v1 import hits the 8-second database timeout and writes nothing (the design working). The snapshot half is fine at ~570 ms. Raise the ceiling at role level after a rehearsal; never chunk the import. Trigger B. | Gate: ≈Sept 18. Arch's; Daniel confirms before the apply |
| **VERHIST-FORK** | "Open as new production" — the last piece of version history. A migration, rehearsal-first; design at `drafts/260911-1600_verhist-fork_DESIGN.md`; ~4,000 rows against an 8-second timeout is the open measurement. Trigger B. DEFERRED past the invite (Daniel, 2026-09-13). | After the invite |
| **VERHIST-REVBLOB** | RULED 2026-09-11: a fork carries the original's Equipment List Revisions, as a third content-hashed blob; needs a `schema_version` bump. | Rides VERHIST-FORK |
| **CHANGEALL-MODEL-SERIAL** | BUILT 2026-09-13, uncommitted: on 330 rows a model Change All went from 333 requests / 146 s to 5 requests / 2.1 s, two batched writes, same end state; `updateItem` untouched. VERHIST-MANUALLEAD and EXPRPT-HINT ride in it. | Daniel's browser gate 2026-09-14, then the phrase and the push |
| **VERHIST-GESTURECLASS** | One pass enumerating every gesture that writes or deletes across a scoped set, ruling the class once (the 2026-09-10 ruling named four; the app has more). | Arch, before the cohort finds one |
| **VERHIST-680** | Script-680's Add-to-Group writes across a scoped set with no snapshot; not one of the ruled gestures. | With VERHIST-GESTURECLASS |
| **VERHIST-MANUALLEAD** | RULED 2026-09-12: the Save Version refusal wording is approved. Built in CHANGEALL-MODEL-SERIAL (constant renamed, comment cites the ruling), uncommitted. | Retires when CHANGEALL-MODEL-SERIAL commits |
| **VERHIST-BLOBWATCH** | Library blobs are never deleted, justified by a measurement taken only on Daniel's projects (three edits ever). Re-measure blob count and size per project. | Private-beta start, and if any project's blob total crosses 25 MB |
| **INSPECTOR-ARM** | Change All did nothing from a Method field with no row selected. The recorded cause does not match the code (`method_name` is an ordinary row cell). Arch measures on the running app before proposing a fix. | Arch, measurement first |
| **CABLEDEL-FAILMSG** | Assessed 2026-09-13: needed, because a half-finished delete silently changes link groups. Proposed: *"Minotaur couldn't delete this cable. Check your internet connection, then reload the page. If this cable's link groups look different from before, that's from the unfinished delete — put them right before you carry on, then try the delete again."* Technical detail on its own `Details:` line. | Daniel's yes; rides AUTH-POLISH |
| **EXPRPT-HINT** | RULED 2026-09-12: the export hint wording is approved. Built in CHANGEALL-MODEL-SERIAL, uncommitted. Frame 06 does not reach that section of the page (GATE-SETTINGS-FOLD). | Retires when CHANGEALL-MODEL-SERIAL commits |
| **DEADCLASS-SURFACE** | 105 `text-surface-400..700` classes emit no CSS and inherit body colour. Which of the 105 should be dim is not machine-decidable. AUTH-SIGNIN-CONTRAST repaired two on the sign-in page (11.19 / 8.37); four remain there (input border, placeholder). | Daniel's ruling; no sweep until then |
| **LEGAL-SELFDRAFT** | Terms ADOPTED 2026-09-13 (v0.2 = `Version 1.0`), NOT in force until TERMS-ACCEPT's deploy publishes them. No Legal Prompt — a six-line checklist instead (beta-terms RETURN, Task 0). Still to draft: the IP assignment and the privacy policy (PRIVACY-POLICY). The named-user rule is in §1. | Terms in force ≈Sept 18; the rest before the v1-holder beta |
| **LEGAL-SEP** | Attorney review of the self-drafted documents plus the subscription agreement before v2 charges anyone. The packet list is the beta-terms RETURN's Task 3 (nineteen items): the two retention riders, the 7-day backup window, the §F disclosures, the acceptance-mechanism substitution, the $100 cap, the regime scoping, GBL § 527-a. | Daniel; scoping week of Oct 5 |
| **BETA-INVITE** | The invite note (Email Prompt) and the one-page cohort brief (Writing Prompt); CAND-4 folds in. Required: the two ruled sentences (forgot your password → email me; v1 stays your source of truth), the three-step sign-in instruction (AUTH-PROVISION), the two-sentence terms fragment (acceptance copy §2), one sentence on GLOBAL-LIB. RULED 2026-09-13: no confidentiality ask anywhere. Cannot send before `/beta-terms` is live. | Daniel, before ≈Sept 18; MAILGATE per send |
| **CAND-4** | Four personal texts to the named beta candidates. Found 2026-09-13: the four pre-terms accounts are Austin Brion (`abrion@pace.edu`: `tesr`, empty; `Comet Fall '26`, 2026-08-19, 0 equipment but 1,923 library rows — a v1 library import, after Addendum §F's "no third party imported a file" was written on 08-15), Ryan Cooper (`Test`, 4 rows; `ACC`, empty), Joseph Haggerty (`Test`, 4 rows), and one account with no project. Their projects are theirs. The §F disclosure needs the Comet import added (LEGAL-SEP). | This week |
| **SEAT-CAP** | RULED 2026-09-12 (policy): one active editing session per Individual account; a second sign-in ends the first. Mechanism Arch's (Supabase Auth sessions), the laptop-plus-iPad case, what a Production-licensed project's members see. Home: REGISTRY. Trigger A. Not a beta-gate item. | Arch; before LIC-NOV charges anyone |
| **BRIEF-13** | Brief v1.3 carries PRICE-199 ($199 Individual), BENCH-FIX (Lightwright is $399/year, not $149), COMPETE-FIX (ShowBuilder drops to monitor), the one-paragraph sharing rationale, and anything BRIEF-12 left open. The Roadmap's RELEASE line is the operative number until then. | Strat scheduling |
| **COMMS-Q** | The announcement to the v1 list is the v1-holder beta drop; a personal note, no tease. | Daniel; at the drop, target Oct 15 |
| **COMMS-REWRITE** | Comms Prompt v9 deleted, rewritten from scratch. | Before the next Comms deliverable |
| **ENTITLE-V1** | How v2 knows who holds a live v1 license. Answered by REGISTRY-1's entitlement function (a serial with an expiry after today, attached to this person); a hand-maintained allowlist is the interim if the workbook import is not clean by Oct 15. Trigger A. | REGISTRY-1 design; built after the private-beta gate |
| **GLOBAL-LIB** | There is no global equipment library (14,411 rows, all project-scoped); a from-scratch show has an empty autocomplete. Not a gate item — an import brings its library. | One sentence in the invite; build unscheduled |
| **IDMAP-ORPHAN-REIMPORT** | BVSC Mexico City has 823 import-identity rows pointing at deleted equipment (seed a show, cut it down — an ordinary workflow). What a re-import does against that residue is unmeasured. | Before the next import unit, and before private beta |
| **WHOCOL-RLS** | History's Who column shows anyone but the viewer as a raw id (`profiles` is self-only). Reachable the day SHARING lands. | With SHARING |
| **SNAPSHOT-SIZE** | A Project Version's size is not shown in the list; needs a view. | Behind a schema window |
| **REPO-MIGRATIONS-ABSENT** | Two migration files in the code repo against 59 applied; the database cannot be rebuilt from the repo. `20260707152921` is applied but never recorded — do not touch it; it is a reconciliation row for the backfill. | Before any second environment |
| **REPO-STRAY-UNTRACKED** | RULED 2026-09-12: delete the stray trees (`Claude outputs/`, `{src/`, `docs/reference/evidence/equipment/`) and add the ignore line in the same pass; `rm -rf` stays denied. Re-routed 2026-09-13 to the META parallel (hygiene never on the main line). `session-log-archives/` was tracked by the 2026-09-12 close commit — decide before untracking it. | META parallel |
| **FENCE-COUNTS** | The run fence in `CLAUDE.md` goes stale whenever a count changes; the handoff that changes a count asks for the fence in the same pass. Routine since 2026-09-13: both units replaced the fence; retired bodies are in the Ledger's eighteenth append. | Every CC handoff, step 1 |
| **CCSED-260911** | Evidence: CC made four single-file writes through bash instead of the Edit tool in VERHIST-GUARD round 1 (self-disclosed, tree clean). 2026-09-13: CC ran a read-only `git status` at the open of both units despite the ref-file rule, self-disclosed both times; Arch did the same on 2026-09-12. Feeds SEDRULE-REMAINDER and WF1A-SUNSET. | Sprint 4 close |
| **SEDRULE-REMAINDER** | While the auto-mode rider stands, `perl -i` / `gawk -i` / `ruby -i` can edit any repo file with no guard (battery cases 15/16/136/137). Extend or let it expire is Daniel's. | Sprint 4 close, WF1A-SUNSET's sitting |
| **FIXTURE-NUMLABELS-GONE** | Cable Parity Fixture's label counts read 0 on all rows where three documents record 150 twos / 57 ones — one bulk write on 2026-09-01 13:03 UTC. Live shows unaffected. Look at what ran before re-importing; a re-import overwrites the evidence. | Before any re-import |
| **BOXBAND-DUPKEY** | RULED 2026-09-13: a band's identity is the comparator's equality class — `Truck 2` and `truck 2` are one band. Do not edit the data. | AUTH-POLISH |
| **FINDFLAG-CHECKBOX** | RULED 2026-09-08: a flag criterion in Find becomes a pre-checked checkbox; needs a third `FindFieldType`. Four flags only; Labels stays a value field. | Its own unit, after FIELD-CONTRACT leg 3 |
| **CABLEGROUP-EDITOR** | RULED 2026-09-08: a bundled cable's group field becomes inherited text. The Find half shipped; this is the editor half. | FIELD-CONTRACT leg 3 |
| **CABLE-FINDDEFAULT** | The seven newly findable cable inspector fields cannot seed ⌥⇧F from focus (`CableListClient.tsx:476` reads `[data-b2-field]` only). | FIELD-CONTRACT leg 3 |
| **CDMX-DEFERRED** | Four cable findings from the 2026-09-05 gate, deferred by Daniel: CABLE-NAME-COMMIT (a name commit fetches the whole mult-line list first), CABLE-CHANGEALL-BOX (two overlays stack), CABLE-TAB-BUNDLE-METHOD (Tab order), BOXBAND-DOCTRINE (band editor silently reverts an unmatched name). | All four ride FIELD-CONTRACT |
| **CHANGEALL-NAALIAS** | RULED 2026-09-13: a typed `0` in a Method Change All means N/A, as in v1 (every visible record takes the N/A method); a field made blank and changed-all makes every visible record's field blank. Both paths, methods and bands. | AUTH-POLISH |
| **AUTOCOMPLETE-NOPORTAL** | Equipment autocompletes do not use the portal dropdown every other surface uses, so the list is cut off at the bottom of the screen (six call sites). | Rides FIELD-CONTRACT or BATCH-HOUSEKEEPING |
| **CAPFLAKE-LIBLIGHT** | One 27/28 visual run on `04-library-light` with a new signature; not the registered theme-race; must not enter `diff-exceptions.json`. | H3 |
| **GATE-SETTINGS-FOLD** | Frame 06 captures the settings page at 1600×1000 without scrolling; the Export to v1 section sits below the fold, so nothing in the visual gate watches it (found 2026-09-13 when a ruled hint change moved no pixel). Scroll the frame or add one. | BATCH-HARNESS |
| **VERHIST** | Schema (migration 58), the guard, timer and retention (59), the fan-out to twenty commit points and the History screen are shipped. Not built: the fork. | Continues as VERHIST-FORK in THE SEQUENCE |
| **EQUIPLIST-WHOEST** | The cover letter's height estimator models a layout the renderer no longer draws and has no wrap model; safe today because it over-counts. Wants a measured wrap model. | Its own scoped round; Arch's |
| **REVGROUP-SPLIT** | Revision-mode print still groups by model alone while the plain list groups by (model, note); changing it means deciding how new rows pair against old snapshots. | Its own unit |
| **EQUIPLIST-DOTRULE** | RULED 2026-09-13: solid row rules, as v1 draws them — one line, not 372 rects. Pairs with PREVIEW-CLIP. | PRINT-RULES |
| **PRINT-RULES** | One bundled CC handoff, ruled 2026-09-13: solid row rules (EQUIPLIST-DOTRULE) with the preview clip measured in the same pass (PREVIEW-CLIP), methods without a sort override printing after those with one (METHOD-SORT-ORDER), and the ruled hint line on the equipment print (PRINT-HINT-EQUIP). | Arch writes it after AUTH-POLISH |
| **PREVIEW-CLIP** | Content is cut off in the print preview that is not cut off in the PDF; the preview was never measured. Measured in PRINT-RULES. | PRINT-RULES |
| **EQUIPLIST-ESTIMATE-PAGINATOR** | The equipment list still uses the estimate paginator that clipped rows on the cable and box documents; converting it is its own unit with a printed proof. | Its own later unit |
| **BOX-PRINT-CLIP** | The Box Contents List and Box List still use the estimate paginator and are likely losing rows; unmeasured. | Its own unit |
| **METHOD-SORT-ORDER** | Methods without a sort override should print after methods that have one; today they do not. | PRINT-RULES |
| **PRINT-HINT-EQUIP** | One ruled hint line at `PrintEquipmentListClient.tsx:951` (Daniel's verbatim text); frame 07 may move. | PRINT-RULES |
| **CATNOTE-EXPORT-LF** | An edited category note stores LF where v1 wrote CR and the export emits it verbatim; whether v1 reads it as two lines is unmeasured. | Before the next export unit |
| **CAT-MERGE** | There is no `merge_categories` function, so a category rename collision refuses and reverts. A new database function. Trigger B. | Its own later unit |
| **CATCOUNT-COLUMN** | RULED 2026-09-13: the Categories tab shows an item count, filtered by `type`. Rides along; never its own handoff. | AUTH-POLISH |
| **BUNDLE-LINK-IMPORT** | RULED: import v1's bundle-field link groups and keep v1's link behaviour; the reader is built before the eight flags flip. | Its own small unit |
| **SPENDCAP-BETA** | RULED Aug 27: keep the Supabase spend cap on. Headroom is large; PITR is outside the cap and bills regardless. | Revisit before public beta, or if any covered item crosses half its quota |
| **CONTRAST-PAIR** | RULED Aug 27: no white text on yellow. `ImportV1Client.tsx:1105` hardcodes white over the project colour; the fix is a hex→text pairing plus a luminance fallback. | Small unit |
| **GRANT-TRUNCATE** | Residual TRUNCATE grants (`service_role` on 35 objects); TRUNCATE ignores RLS. Revoke. Trigger B. | Before public beta |
| **HARNESS-READ** | A read-only database role plus a parity fixture the harness owns — today no harness can read the database. Trigger B. | Rides GRANT-TRUNCATE |
| **RLS-INITPLAN** | `auth.uid()` is unwrapped in RLS policies on 53 tables (re-evaluated per row); small at today's scale. Also 38 unindexed foreign keys. | Before public beta; pairs with GRANT-TRUNCATE |
| **PROJ-CLEAN-2** | DONE 2026-09-13: thirteen throwaway projects owned by `daniel+pt@` deleted by Arch on Daniel's word (eight `FIX1`, three `Amend2`, two `S3G-2`); 13 projects remain, the three fixtures intact. Left: `Versioning Test` (657 rows, 7 versions) — keep or go, Daniel's word. | Daniel's word on the one |
| **CORPUSBOUND-AUDIT** | The mapping doc's "resolved by corpus scan" conclusions rested on two shows; how many others do is unaudited. | Arch, before the next mapping decision cites a corpus scan |
| **MARKER-OVERHANG** | The tail-label model-section marker overhangs onto the neighbouring sticker by 21.44 pt; v1 wraps it to its column. Fix is a wrapping block. | Before any 5167 output ships to real stock |
| **BUNDLESUM-MARKS** | v1's bundle summary prints Bundled/Tested on 71 of 71 rows where the workbook carries 1 and 0. One fresh v1 print settles it. | Daniel's desk |
| **CABLE-SPLIT** | v2 has split columns and no split feature. Trigger A. UNBLOCKED 2026-09-13: Paradise Square (New York) is filed at `~/Minotaur_v1_exports/Paradise_Square_NY/` — 24 cables with splits, 146 `Split of` rows. Daniel's ruling: no upload to minotaur.app until the split unit is designed and built; the upload is then its test. | Arch design, after the invite |
| **GATE-THEMEGLYPH** | A Δ42 diff at the theme-toggle glyph, light only, reproduced twice on different trees. Never register it. | Its own diagnosis unit |
| **DIFF-EXC-BOUND** | Bound the diff-exception registry by area × max pixels. | Before any Δ>1 site is admitted |
| **METRIC-UNRUN** | Every project is imperial; the metric path has never met real data. A typed `150m` on an imperial show now commits metres. | Daniel's browser gate |
| **HARNESS-WAIT** | A visual-gate run sometimes times out waiting for the print route; never survives a second run. Needs an owner or a decision to tolerate it. | Unscheduled |
| **HERO-PLURAL** | `HERO_BID_TO_OPENING` goes plural. | When Vape! Chicago opens |
| **TOK-VC** | Vercel token rotation. | Private-beta start; hard ~Nov 8 |
| **LIC-NOV** | The licensing subsystem and ownership transfer, on the REGISTRY (REGISTRY-3 picks the provider). Amended 2026-09-12: must not preclude an organization account (ORG-TIER) — scope-check only. Carries GBL-527A. | ~November |
| **GBL-527A** | NY GBL § 527-a, verified 2026-09-13: for an auto-renewing annual license — clear disclosure of what renews, the amount and the frequency; affirmative consent before the first charge; an acknowledgment the customer can keep; cancellation as easy as sign-up; a renewal notice 15–45 days before the cancellation deadline. A build requirement for the November checkout, not only an attorney question. | REGISTRY-3 / LIC-NOV |
| **REGISTRY** | RULED 2026-09-13: one registry, for Daniel's eyes only, of every v1 and v2 license, person, payment, terms acceptance and cohort membership — ENTITLE-V1, LIC-NOV and SEAT-CAP get their home in it; `terms_acceptances` is its first table. Three design parallels: REGISTRY-1 the data model (opener issued 2026-09-13, chat opened), REGISTRY-2 the admin surface, REGISTRY-3 payments after Strat picks the provider. Every table Trigger B; nothing applied before the invite. | Arch parallels; first migration after week-one fixes |
| **GIT-CFG** | git identity · Next 16 `middleware`→`proxy` · the two `ORPHANED-index.lock.*` files in `Minotaur/.git/`. | Housekeeping |

### ⏸ HELD — real and registered, waiting on a named unit, batch or trigger

| ID | One line | When / trigger |
|---|---|---|
| **PROCESS-REFACTOR** | RULED 2026-09-12: the governing documents get cut to what Daniel can read. Done at this version: Architecture Prompt v37, Roadmap v4.33 (one-line rows), the Session Log header cut to six fields with the old header frozen into the Ledger. Remaining: decide whether a Standing Facts file is still wanted. | After the invite and week-one fixes |
| **ORG-TIER** | PROPOSED: an organization account — the theatre or shop owns the projects, an admin manages seats. Lightwright's $375/seat is the ceiling; the number is a later Strat session's. | Strat; after the first paid quarter |
| **MONTHLY-HOLD** | PROPOSED: a monthly Individual only if LICDB's usage distribution shows the few-shows-a-year segment is small, priced so annual wins by month seven. Not at release. | Strat; after the first paid quarter, with LICDB |
| **FIELDCONTRACT-3B** | Field-contract leg 3b; scope from the Ledger's tenth append before sequencing. | After the invite |
| **UNATTENDED-MEASURE** | Three measurements before any unattended-CC build: does `--restricted` drop the hooks; what `--setting-sources` accepts; whether the four gate invocations match under prefix semantics. `--bare` is struck. Detail in `drafts/260910-2050_autonomy-measurements-and-proposal.md`. | Measurements, then a proposal — never a build first |
| **FROZENCHECK-FAILOPEN** | The frozen-check hook allows the edit if `git show` fails or `jq` is absent, and compares against HEAD rather than the frozen baseline. The gate is the control; the hook is only an early warning. Do not build on it. | BATCH-HOUSEKEEPING or its own pass, with a battery |
| **HARNESS-SIGNOUT** | The harness signs in on every run and never signs out (1,431 sessions before the rotation). Sign out at run end, or sweep sessions on a schedule. | BATCH-HARNESS / H3 |
| **HARNESS-THEMEWRITE** | The visual gate sets the fixture owner's theme to dark and never restores it; fixing it moves the timing HARNESS-SETTLE just fixed. | BATCH-HARNESS / H3, not before |
| **GATE-METHODRACE** | A visual-gate fail-hard at "Method sort button not found" — environmental; the harness queries with no settle wait at `visual-capture.mjs:425`. | BATCH-HARNESS; reopen on the next sighting |
| **EQUIPLIST-QTYCOL** | v1 has no fixed quantity column (right-aligned); v2's fixed cell was widened to stop a clip, not rebuilt. | With a later print unit |
| **RENAME-HASHDRIFT** | Renaming a category or method in v2 changes the row hash of a v2 export re-imported into v2, minting duplicates on shows with no v1 HistoryIDs (Vape!, Matchbook). The same door has been open since the Methods admin shipped. | Pairs with any export-integrity unit |
| **ADMIN-NEWDUP** | ⌥⇧N twice without renaming silently no-ops (UNIQUE on `'New Category'`); copy-faithful to Methods. | BATCH-HOUSEKEEPING |
| **LINT-DEAD** | `npm run lint` is dead on Next 16; the `package.json` script is stale. | BATCH-HOUSEKEEPING |
| **CHANGEALL-METHODDOCTRINE** | Cable's Change All reverts an unmatched method draft; equipment's creates one. Nothing has ruled they should differ. | With FIELD-CONTRACT |
| **CREATEMETHOD-BLINDERR** | `createMethod` swallows its error, so a 409 cannot be told from a permission failure. | BATCH-HOUSEKEEPING |
| **SMALLNAME-STEP** | RULED (OQ-3): the small box name is 48 pt to 17 characters, 36 pt from 18; v2 steps at 14 to 34 pt. Not built. `stepSlot` at `boxLabelGeometry.ts:106-109`. | With the box residuals |
| **BOXLABEL-ZERO** | Box label counts export `0` where v1 wrote blank; unruled (the equipment ruling's mirror). | Its own small unit |
| **DEADEXPORT-GRIDCOL** | Three dead exports in `cableSheet.tsx` with live-looking doc comments; keep-or-delete. | BATCH-HOUSEKEEPING |
| **DEVICE-FK-LINK** | Cable source/destination device foreign keys exist and are 0-populated everywhere; Device Patch reproduces v1's text join. | Post-public-beta, beside DOOR-V1LINK |
| **SKIP-LABELS** | `SkipLabelsDialog` exists on four surfaces; re-verify its gating against v1's script 83. | With the first 5167 output pass |
| **CATSORT-NATURAL** | v1 sorts categories naturally (`10.0` after `9.0`); whether v2's integer `sort_order` reproduces that is unverified. | With Group Parts |
| **EQUIPVIEW-UNSAFE** | `v_equipment_list` does not filter `type` and exposes `ip_address` instead of `address`; Group Parts wants all four families, Equipment Labels wants generic only. | With whichever equipment output lands first |
| **BOX-DOC-PARITY** | The Box List and Contents List prints have never had a v1 parity round. | After cable parity |
| **SPLITEND-DAISY** | `runExport.ts:420` says v1 knows Source/Destination only; v1's three real splits carry Daisy Chain. | With CABLE-SPLIT |
| **SPLITOF-NO-ARM** | Import refuses `split_of` (3 rows corpus-wide) rather than emitting a key the RPC ignores. | With CABLE-SPLIT |
| **MENU-DEPRECATE** | RULED Aug 28: remove Wire Types and Wiring Schedule from the main menu. Likely a declared baseline event. | Rides a UX unit with a working gate |
| **WF1A-PHRASE** | `COMMIT APPROVED` appears in `CLAUDE.md` only and in no matcher — a discipline, not a mechanism; both prompts should say so. | Arch, after the invite |
| **BUNDLE-NA-UNTESTED** | The Bundle Sheet excludes N/A-method cables and that filter has never fired on real data. | Before another corpus exercises it |
| **EXPORT-CARRIES-STATE** | The export drops `no_box_needed` and emits `N/A - Labels Only` where v1 expects `0`; a unit that creates state must prove the export carries it. | With EXPORT-HISTID-DROP, one export-integrity unit |
| **EXPORT-HISTID-DROP** | `cable.xlsx` emits HistoryID on 852 of 1,119 cables; the figure it rested on is contradicted and must be re-measured before design. | Its own unit |
| **APPLY-PROMISE-GAP** | Dry run promised 913 groups / 2,036 memberships; the database holds 912 / 2,034. One measurement. | With EXPORT-HISTID-DROP |
| **ROUNDTRIP-INMEM** | The round-trip test runs in memory and never writes a file; round-trip through files and a fresh project. | BATCH-HARNESS |
| **LINKJOIN-FENCE** | A test whose only job is to fail if `historyJoinKey` is used for identity. | Next touch of the import mappers |
| **FENCE-INTERP** | The bash fence blocks the redirect form only; `python3 -c`, `node -e` and heredocs writing a file all pass. Match the interpreter, with a battery. (Was FENCE-HEREDOC.) | Arch, next unit touching `.claude/hooks/`; after the invite |
| **GATE-DEVCHECK** · **GATE-PORT** | The harness calls any `:3000` listener a dev server and has no port override. | BATCH-HARNESS |
| **LINECOLOR-ZERO** | `lines.xlsx` carries v1's null marker `'0'` in Line Color on 86 rows; imports blank with a variance line. | 2-IMP-c or BATCH-HOUSEKEEPING |
| **LINK-ORPHAN** | `link_group_members.item_id` has no FK and is 100% orphaned live. | BATCH-BOX or 2-IMP-c |
| **CABLE-AUDIT-TIME** | v1's `_Create Time` / `_Modify Time` are datetime cells; `*Person` has no v2 counterpart. | Next export touch |
| **GATE-PDF** | `pdfgeom2.py` built outside the repo; porting it is a dependency change (`pdfplumber`). | Its own port unit |
| **BOX-REPARENT** · **IMPRPT-COPY** · **BUILDSHEET-CMT** · **BOX-NAME-UNIQ** · **BOX-TYPES-DIM-DROP** · **BOX-ALPHA-UNSAMPLED** · **BVSC-RF** · **HISTID-HASH-COST** · **SMOKE-LOGIN-HYDRATION** | unchanged from v4.6 | BATCH-BOX / BATCH-HOUSEKEEPING |
| **GATE-LOAD-AUDIO** · **REPRO-SUSPECT** · **SENT-BUNDLE** | unchanged from v4.6 | BATCH-HARNESS |
| **BOX-TYPE-VOL** · **BOX-LABEL-COUNTS** · **BOX-EXPORT-ORDER** · **SHOP-ORDER-NOTES** · **BUNDLE-FIND** · **SED-GUARD** · **DEV-SERVER-AGE** · **REPO-WEIGHT** | unchanged from v4.6 | Their batches |
| METHOD-FIX · GATE-OL25WR · GATE-C4 · S504 · CONCEPT-A · UNALLOC · EFFGRP · DOOR-V1LINK · CABLE-LOADER | unchanged from v4.6 (PRINT-REDO and PARITY-PAIR folded into PRINT-PARITY) | Icebox sweeps |
| RULINGS-WANTED | REV-STAMP · (ff) tab strip · (dddd) `#` headings · IMP-SORT · BAND-EDITOR sequencing · `no_box_needed` vs the yellow | Icebox sweeps |

### 📐 STANDING — binds indefinitely; a row here never closes

| ID | One line | Binds |
|---|---|---|
| **MORNING-CHECK** | A scheduled task in the Cowork workspace runs every morning at 8:00 ET: backup sweep failures in the last 24 hours (VERHIST-SWEEPWATCH) and new waitlist signups (WAITLIST-NOTIFY), read-only, pushing to Daniel's phone only when there is something. Created 2026-09-13; it lives outside the repo, so this row is its record. | Standing |
| **MAILGATE** | RULED 2026-09-12: nothing sends email to any address that is not Daniel's own until he approves that send in a message whose only content is the approval. One approval covers one send. CC never sends mail or provisions accounts. | Standing |
| **HANDOFF-BUNDLE** | Small fixes ride as few, long handoffs as possible (Daniel, 2026-09-11). | Every handoff |
| **HELD-IS-NOT-FORGOTTEN** | A HELD row without a named release trigger is illegal; every close checks whether any trigger has fired. | Every close |
| **TOAST-ON-WRITE** | `pg_column_size` on a computed value reports the uncompressed datum. Any storage estimate cites a stored measurement or says it is an expectation. | Every sizing, retention and quota claim |
| **SWEEPLINE-NOT-DURABLE** | Anything that must outlive one session goes in a row, never in a summary line; every propagation claim is a search before it is a sentence. | Every Roadmap close and correction |
| **APCA-NOT-WCAG** | For dark-mode text the WCAG ratio cannot see polarity; report APCA Lc alongside it. No colour value brings a 9px label inside the model. | Every contrast claim |
| **GATE-SETTLE-BETWEEN** | A reliability measurement lets the machine settle between runs; a refusal captures nothing and is never counted; six clean runs is absence of evidence. | Any run count offered as evidence |
| **PROJECT-NAME-NOT-UNIQUE** | Two productions of one musical share a show name and that is a must-have feature. Never add a uniqueness constraint. Every citation of a project names its id. (`visual-capture.mjs:122` finds its fixture by substring — harness fix rides BATCH-HARNESS.) | Standing |
| **PRINTPROBE-MEDIA · RECT-VS-FLOW · PAGINATE-SLACK** | Clip probes on the equipment list run under `emulateMedia({media:'print'})` at 816×1056; rect heights exclude the collapsed bottom margin; `CONTENT_H` 880 sits under a measured 890–910. | Every probe on that document |
| **ARCH-OUTPUTS-MIRROR** | Files written through the Cowork output path mirror into the first connected folder — the code repo. Intermediates go to the scratchpad. | This seat |
| **BVSC-8POWER-DRIFT** | The US Tour's `8.0 Power` note no longer matches its v1 source byte-for-byte (Daniel typed a blank line into it). Mexico City is clean. | Round-trip comparisons on the US Tour |
| **FENCE-ONEUNIT** | The run fence carries one unit, not a history; `git log` is the closed list; retired fence text goes to the Ledger. The limit is in characters. | Both tiers |
| **CONTCAT-DIVERGE** | RULED 2026-09-05: v2's continued-category line is better than v1's overlap and stays. Do not "fix" it back by citing the artifact. | EQUIP-LIST-PARITY |
| **PAGEBREAK-MODEL** | RULED 2026-08-30: a model section starts a new page on all three tail outputs (v1 breaks to a column). Do not "fix" it back. | Tail outputs |
| **CATNOTE-TYPE** | Measured: a v1 category note prints at 12.00 pt italic, an item sub-note at 10.00 pt italic; three indent levels; repeats at every non-continued section header. | CAT-NOTE |
| **IMPORT-LINEBREAK-CR** | v1 text arrives carriage-return separated; render through `normalizeLineBreaks`, never write it back (the row hash is frozen). | CAT-NOTE and every note renderer |
| **LABELSDONE-RESIDUE** | `labels_done` is product-dead but stays — it is one of the frozen fourteen hash keys. Dropping it is a ruled destructive step. | Post-beta at the earliest |
| **DDR-IS-THE-SOURCE** | Go to the source that made the ink: `docs/reference/v1_ddr.xml` (UTF-16LE — read via `iconv`). A threshold fitted to one corpus reproduces that corpus by construction. | Both tiers |
| **GRAPH-BEATS-RERUN** | An import graph says whether a frame could ever have seen the change; two re-runs is the limit. The prose flake list masks nothing; `diff-exceptions.json` masks pixels. | Both tiers |
| **HARNESS-RLS-CORPUS** | The parity fixtures are owned by daniel@ and invisible to the test user; every harness count is a labelled reproduction on a throwaway. | Rides HARNESS-READ |
| **FOUNDSET-NOT-COUNT** | A count that matches is not a found set that matches. | Every print↔corpus pairing |
| **BROWSER-NOPRINT** | The built-in browser has no print and no Save-as-PDF; useful for the behavioural half of a gate, never the printed half. | Standing |
| **PDF-CHROME-PATH** | A parity print is valid only through Chrome's own Save-as-PDF; every landscape artifact before 2026-08-27 is invalid as a geometry arbiter. | Every parity measurement |
| **GATE-NOGREP** | Never pipe a gate run through a filter; write it to a file and read the file. | Both tiers |
| **HIST-BLIND** | v1's audit lives in OnObjectSave triggers, which scripted mass edits never fire. | What `history` can prove |
| **CLONELINK-ROWSET** | v2 emits one clone-link row per cable and line (1,671 vs v1's 596); what selects v1's 596 is unexplained. A ruled divergence. | Standing |
| **PARALLEL-CLOCK** | `YYMMDD-hhmm` in a filename is the ordering key; write it at the time of writing. | Parallel openers |
| **PORT-COV-REIMPORT** | A v1 re-import path is a product requirement (Daniel, Aug 23); acceptance is round-trip, not column order. | Every export unit |
| **TENSE-IS-A-CLAIM** | An expectation written in the past tense reads as a measurement. | Both tiers |
| **DEAD-CODE-IS-NOT-SAFE** | A symbol with no production callers is dead code, not low blast radius. | Arch |
| **EQUIPLIST-ROWH-BIMODAL** | v1's body row takes two heights, 19.97 and 20.97, and nothing separates them; 19.97 is taken. | Blocks nothing |
| **R-7 LABEL SETS** | v1's label counts are sets; v2 prints one. Governs cables, lines and tails (equipment keeps its integer). | Applied in 2-IMP-b |
| **LEN-SCALE** | Numeric scale is on the wire (`"150.0"`); JS `JSON.parse` normalises it, a non-JS consumer would not. | Standing caution |
| **HISTENTRY-NOTID** | `History Entry ID` is not unique and not a UUID; never map it to an id. | Standing caution |
| **JOY-NAME-HYGIENE** | Do not trim cable names; a verbatim coercion exists for that one column. | Standing caution |
| **LINES-NOFK** | `lines.sourceID` / `destinationID` are 0-populated everywhere and the DDR confirms no relationship joins on them. | Standing |

### ✅ RETIRED TO THE LEDGER — index only, so a citation still resolves

Full text is in `Minotaur_v2_Ledger_v1_0.md` (the append named) or in `Minotaur_v2_Roadmap_v4_32.md`.

| ID | Closed at | Ledger |
|---|---|---|
| **AUTH-RESETPAGE** (shipped `57e0eec`, live 2026-09-13) · **AUTH-LINKCLICK** and **AUTH-SIGNIN-CONTRAST** (shipped `3416650`, live 2026-09-13) · **AUTH-MAILVOLUME** (absorbed by AUTH-SMTP) · **VERHIST-SWEEPWATCH** and **WAITLIST-NOTIFY** (discharged by MORNING-CHECK, no build) · **EQUIPLIST-CLMARGIN** (ruled 2026-09-13: leave it) | v4.34, 2026-09-13 | eighteenth append |
| **DOCKET-ROWLENGTH** (discharged by this version) · **GATE-REPORTING** and **GATE-BEFORE-COMMIT** (installed as step 0 of the COMMIT BLOCK in `CLAUDE.md`) · **EQUIP-LABELS-2** (shipped; the row was stale) · **CAT-NOTE print half** (shipped at `f4192cd`; the row was stale) · **PRINT-FOUNDSET** (premise withdrawn) · **OQ-1 COLOUR-TABLES** (closed by ruling) · **BVSCNY-SEED-JUNK** (moot — the project is gone) · **EVIDENCE-UNTRACKED** (folded into REPO-STRAY-UNTRACKED) · **CHANGEALL-SPEED** (absorbed by CHANGEALL-MODEL-SERIAL) · **BRIEF-12** (superseded by BRIEF-13) · **CHIP-CABLECOLOUR** · **CHIPTEXT-PAIRED** · **RETURN-ON-CONTROL** (all built and closed) | v4.33, 2026-09-12 | seventeenth append |
| **AUTH-REFRESH-HANG** · **CABLEDEL-LATENCY** · **EXPRPT-STALE** | `bf0d7ed`, live at `d980b73` | PREBETA-FRICTION, sixteenth append |
| **LICDB** · **CLAUDE-HARNESS-STALE** · **META** (Tier 1 installed; Tiers 2–3 ride the next unit touching `.claude/hooks/`; Tier 4 is PROCESS-REFACTOR) | 2026-09-12 | sixteenth append |
| **DOCKET-STALEACTIVE** · **FIELD-CONTRACT** (leg 3b continues as FIELDCONTRACT-3B) · **FINDPARITY-UNTYPED** · **DARKMODE-PASS** · **CLAUDEMD-ATLIMIT** · **ROADMAP-REFACTOR** · **BVSC-MX** · **CDMX-SPRINT** · **VERHIST-RESTORE-IDENTITY** | v4.30, 2026-09-11 | fifteenth append |
| **EQUIP-LIST-PARITY** · **EQUIP-LIST-SCALE** · **QTY-ITALIC** · **CATNOTE-FONT-DUP** · **AMEND-ROUND-TENSION** | `c525a55`, 2026-09-07 | seventh append |
| **CATNOTE-RULE** | `f4192cd`, 2026-09-06 | sixth append |
| **CAT-ADMIN** · **CAT-NOTE's data and editing half** · **GCMTAB-STALE** · **CLAUDEMD-OVERSIZE** | `1a54c3b`, 2026-09-06 | fifth append |
| **CHANGEALL-BOXNULL** | `6deb411`, 2026-09-05 | fourth append |
| **CHANGEALL-FOUNDSET** · **CHANGEALL-METHODNULL** (closed as CHANGEALL-METHODNEW at `e3a336a`) · **GREP-NULBYTE** · **LINKGROUP-CORPUS** | `ba0058f` / `e3a336a` / 2026-09-05 | third and fourth appends |
| **STOCK-IS-DIE** · **FENCE-PUSH** · **ROW-LADDER** · **JUSTIFY-PERCELL** · **HEADER-PANEL** | `9a333cc` / `0bf6df3` / `2cc6b14` | second append |
| **PRINT-CLIP** · **CHECKLIST-GROUPCOUNT** · **ORIENT-FIXFAILED** · **CLONE-FLAG-DIVERGE** · **CLONE-TOKEN** · **STECK-ZERO** | `eaabd03` / `0468a5d` / by measurement | first and second appends |
| **FENCE-FORMS** · **FENCE-RULINGS** | `31b4c26`, 2026-09-10 | eleventh append |
| **VERHIST-LIBDEDUP** | 2026-09-11, no commit | twelfth append |

### BATCH

| Batch | Members |
|---|---|
| **BATCH-HARNESS** | H3 · GATE-SETTINGS-FOLD · GATE-DEVCHECK · GATE-PORT · GATE-METHODRACE · ROUNDTRIP-INMEM · HARNESS-SIGNOUT · HARNESS-THEMEWRITE · GATE-COUNTWAIT · GATE-DLGRACE · GATE-FIXDIRTY · GATE-LOADPROXY · VIS-ENVFILE · DEV-SERVER-AGE · GATE-LOAD-AUDIO · the PROJECT-NAME-NOT-UNIQUE harness fix |
| **BATCH-AC** (after private beta starts, R-AG) | unchanged from v4.6 |
| **BATCH-BOX** (post-private-beta) | unchanged · BOX-NAME-UNIQ · BOX-REPARENT · LINK-ORPHAN |
| **BATCH-EXPORT** | Remaining: **2-IMP-c** · **2-MIG-c** (leg 1, ARCH-MIG-BOX, leg 1b, MIRROR-SYSMETHOD, HISTID-UUID, 2-EXP, 2-MIG, 2-IMP-a, 2-MIG-b, 2-IMP-b all shipped) |
| **BATCH-PREBETA** | Three members shipped in PREBETA-FRICTION. Remaining, each held for a stated reason: SHARE · (ppp) settings header · ADM-1 · 3TL (all ride SHARING) · AUTH-DOMAIN (DNS/provider config, Daniel's) · DEPS (a dependency change is a CC hard-stop; its own unit) · CL-HILITE (no ruled design) · GCM (post-beta) · IMPRPT-COPY (no measured surface) |
| **BATCH-HOUSEKEEPING** | LINT-DEAD · FENCE-INTERP · LINECOLOR-ZERO · ADMIN-NEWDUP · CREATEMETHOD-BLINDERR · DEADEXPORT-GRIDCOL · FROZENCHECK-FAILOPEN · SRGRANT sweep · ST-RACE · CTF-SEED · SLOT-AUDIT residue · REPO-WEIGHT · BOX-TYPES-DIM-DROP · PROJ-CLEAN-2 |

### ICEBOX

Unchanged from v4.6.

### ❓ Open Questions (live only)

- **PRINT-PARITY's remaining:** OQ-3 — does the SMALL box layout's Box Name carry a Conditional Formatting rule (a screenshot settles it; a rendered style the engine ignores is not evidence) · OQ-4 — the dashed grey cut rules are ruled and fully specified (`x 22.00 → 590.00` at `y 395.50`, 1.0 pt, `#ADADAD`, dash `[3.005291, 3.005291]`, phase 0.5) — build pending · OQ-5 — which cell edge is the parity target · OQ-B — does Box-in-Box suppress fields other than the Stack? One more card answers it.
- **What selects the 596 rows in v1's `cable clone links.xlsx`?** (CLONELINK-ROWSET — named, not chased.)
- **What zeroed the three v1 count fields between July 11 and Aug 20?** (Q-1.) Only Daniel's memory can close intent.
- **Do the 39 boxes whose types BOX-TYPE-LIB created want dimensions?** Not blocking.
- **Does the operator need the report to say a system row was protected?** Not blocking.
- **Should the HISTID-HASH-COST wording be sharpened?**
- **What actually moves the theme-toggle glyph?** (GATE-THEMEGLYPH.)
- The own-truck vs resolve-up reading on box labels is unobservable by construction.
- `box_default_large_labels` 5 (OQ4 ruled) vs the v1 panel's `#Big Labels 2`.
- v1 continuation header · cover-page body size → PRINT-PARITY.
- Script 551 extraction · cable Change All checkbox eligibility · house-wide Cancel semantics · Used∩Ignored · empty-string note · link `field_name` CHECK backstop · cable-type RENAME affordance · CL a-1 uploads · d2_01 red Members count · CL multi-letter-per-project · stale-category healing · CC credit-budget policy · OQ#2b own-band pendency · band-cascade harmonization.

---

*Roadmap v4.34 · 2026-09-13 · retires v4.33. Cap: 60,000 characters, ratcheting down. Code `3416650` live; CHANGEALL-MODEL-SERIAL built and uncommitted; migration ledger 60; suite 3,278 / 168; frozen 3/3; visual 28/28; no baseline event.*
