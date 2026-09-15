# 📝 SESSION LOG — Minotaur v2

Append-only chronological record. Each entry: date, chat type, model, decisions, work, next action. Prior entries are immutable. Every delivery is the complete live file. The header is six fields, under 4,000 characters; anything that must outlive a session and is not one of those six goes to the Ledger or a Docket row, never here.

## STATE OF PLAY
- **Shipped:** v2 is live at `https://minotaur.app` at **`3b98ce9`**. The front door is COMPLETE: the beta terms are in force, custom SMTP (Porkbun, `smtp.porkbun.com:587`) sends as `info@minotaur.app` under the name **Minotaur**, and the typed recovery code reaches the auth host for the first time on this project. **Jamie Tippett and Mike Tracey are in — the first two people outside this office ever to use v2.** Version history except the fork; the model Change All in two writes. Migration ledger 64. Suite 3,312 / 170, frozen 3/3, visual 28/28, no baseline event. `CLAUDE.md` 109,892 characters.
- **In flight:** nothing is building. SHARING REV-B is designed and rehearsed, nothing applied; five migrations (65–69) wait on Daniel's confirm. ⚠ **Nothing but `owner` enters `project_members` until 66 is applied.** The Sept 18 gate now reads: SHARE-MIGRATIONS · SHARE-ROSTER · BATCH-COHORT-1 · AUTH-POLISH · APPLY-TIMEOUT · the fourteen remaining accounts · the invite.
- **Next action:** open the next Arch session by writing the **BATCH-COHORT-1** handoff to CC; once Daniel confirms CC is working, spin off the **APPLY-TIMEOUT** parallel; apply 65–69 only after CC returns.
- **Open decisions:** which methods palette is v1's (METHODS-PALETTE) · CABLEDEL-FAILMSG's wording · YES or KEEP on the sign-in placeholders · whether first and last name become separate columns and whether `registry.people` owns them · `Versioning Test` keep or delete.
- **Current log:** 10 entries
- **Rollover:** ⚠ **DUE — run at next pre-open.** Archive the oldest 8 to `session-log-archives/`, keep the newest 2, wait for Daniel's confirm before installing.

### September 11–12, 2026 — Cowork-Arch session, the MAIN LINE (**TWO UNITS SHIPPED, two production deploys — VERHIST-FANOUT `c446326` and VERHIST-UI Leg 1 `96efd11`** — version history goes from TWO guarded commit points to TWENTY and gets a face · ⚠ **the browser gate Daniel nearly skipped found two defects, and diagnosis proved BOTH pre-existing** · ⚠ **FOUR sightings of one mask defect, two in the instrument's own author's code and one in ALREADY-SHIPPED test code that could never have passed** · ⚠ **the production READY check proven permanently un-seat-runnable — the reason is EGRESS, not the token** · **the Strat parallel folded in and the driver moves off a production for the first time since Sept 5** · **five Arch errors, four caught by CC or by Daniel** · model `claude-opus-5`)

**Seat check passed, and it ran OUT OF ORDER — recorded because that is the second time.** State was verified from the ref files before the third mount was confirmed; `~/Minotaur_v1_exports/` was requested only after Architecture Prompt v35 was read and named it. Nothing verified was invalidated; the order was wrong. **State from files, never by running git:** code `951557c` at the open, `Minotaur-Cowork` `cf87036`, no lock files, `CLAUDE.md` **115,579 characters** by `wc -m`, **migration ledger live-read at 59** and byte-matched against `20260911165516`, Session Log at 6 — rollover clear.

⚠ **PRODUCTION READY IS NOT SEAT-VERIFIABLE AND NOW THE REASON IS MEASURED RATHER THAN INFERRED.** Two prior sessions recorded "the token sits outside the three mounts." Daniel granted `~/.config/minotaur` this session, the token became reachable, and the script moved from **exit 2 to exit 3, network failure**. Three hosts were then tested from the device shell — `api.vercel.com`, `registry.npmjs.org`, `github.com` — **all three refused, connection reset**, and `api.vercel.com` is equally unreachable from the cloud container. **The blocker is egress, not the token, so no mount ever fixes it and the check is permanently Daniel's.** ⚠ **A carried figure was also wrong: "two deploys stale" was ONE**, and it had propagated into the Ledger, the Session Log, the Roadmap and the opener. Daniel ran it: `LATEST READY 951557c`, equal to code HEAD.

**VERHIST-FANOUT — SHIPPED `c446326`, one production deploy, 19 files, +1262/−177.** The fifteen remaining commit points wired, and the census grew **17 → 19** on a Daniel ruling mid-unit: the Bundle List's delete-members arm and the Cable List's Unallocate All are destructive over an unbounded scoped set and were outside the four named gestures. Every shared single/bulk delete handler now takes a **REQUIRED positional `DeleteScope` threaded from each invoker**, so a call site that forgets it does not compile. ⚠ **The cable Change All guards twice** — B7-R6's "Update all links" fans the write set out AFTER the first count, so a fifteen-cable gesture that extends to forty would have taken no snapshot. The three import sites guard immediately above `import_apply_v1`, never inside it.

⚠ **THE REFUSAL MESSAGE SPLIT INTO THREE LEADS, AND THE REASON WAS A LIVE DEFECT.** Daniel's ruled sentence names a 20-record threshold — but Delete All is exempt from that threshold and always backs up, so the shipped equipment list was already telling an operator deleting five records that Minotaur backs up "before changing more than 20 records at once." **RULED (Daniel, 2026-09-11): three leads chosen by reason, sharing his tail verbatim.** `delete_all` reads "before deleting records in bulk" — deliberately naming no scale, because `delete_all` wears two faces and is v1's **"Delete Unused"** on both admin grids.

**VERHIST-UI LEG 1 — SHIPPED `96efd11`, one production deploy, 13 files, +963/−48.** ⚙ PROJECT → History: the list, and **Save Version as the twentieth commit point and the first surface ever to invoke `'manual'`** — `snapshot_project_v1` has taken `p_label` since it was written and no gesture had ever passed one. ⚠ **`created_by IS NULL` renders "Automatic", pinned by test — 30 of 34 rows are NULL by design because `pg_cron` is a superuser.** The fork renders disabled with its reason on the page and no handler at all.

⚠ **CC BOUNCED AN ARCH INSTRUCTION ON THE SURFACE RULE AND WAS RIGHT.** The handoff asked for a "your latest backup already matches" message on a manual save. **`snapshot_project_v1` EXEMPTS `'manual'` from skip-if-unchanged, with the reasoning in its own comment** — the operator pressed a button and expects a row. CC built the message, its smoke proved the branch unreachable, removed it, and measured the truth: two consecutive saves with nothing changed wrote two rows. **Settled: the database is right, the handoff was wrong, no migration.**

⚠ **THE BROWSER GATE DANIEL NEARLY SKIPPED IS WHY TWO DEFECTS ARE ON THE RECORD.** Arch handed him a commit phrase and told him to log the gate for later; CC refused both halves, correctly, because GATE-REPORTING says a green machine gate is never a substitute. He ran it in three minutes and returned two findings. **Both diagnosed PRE-EXISTING, each proven twice.** The six-second single-cable delete: the path is **byte-unchanged by the unit** and makes **zero snapshot calls**, measured at the same 459-cable scale, where a bare throwaway measured 757 ms — the difference is topology, not scale. The method Change All that "did nothing": the guard is exonerated by the snapshot table showing **no orphan row**, and by a forced-500 test proving **the refusal dialog renders and blocks the write**. The real cause is a pre-existing CP-B8 arming gate — `method` lives only in the inspector, which arms Change All only when a row is already selected, leaving the button disabled with **no explanation anywhere on screen**.

⚠ **ONE MASK DEFECT, FOUR SIGHTINGS IN TWO UNITS, AND THE FOURTH WAS ALREADY IN PRODUCTION.** `blankOut` erases string literals, so any assertion reading `bodyText` cannot see a quoted needle. It made the import-RPC provenance check return **zero for the one function whose entire purpose is calling that RPC**, and its mirror would have passed **vacuously for all nineteen points**. The shipped instance: *"no file both references the guard and names `'manual'`"* compared an empty list against a scan **structurally incapable of returning anything**, and would have passed with Save Version already built. **Ten deletion controls across the unit; two of them caught the instrument's own author rather than the code under it.**

⚠ **A SED DISCLOSURE BREACH, SELF-DISCLOSED, WITH NO DAMAGE — AND NOTHING COULD HAVE STOPPED IT.** CC ran `perl -pi` on a single repo file during a deletion control. The rule permits in-place `perl` for mechanical multi-site edits and says **"single-file edits go through the Edit tool, no exceptions."** It is a breach. The ledger is complete on all four items, the file is byte-identical to HEAD, the frozen gate ran immediately, and CC did not argue the clean outcome excused the mechanism. ⚠ **`CLAUDE.md`'s own accepted remainder says `perl`/`gawk`/`ruby` in-place on an ordinary repo file has NO control under the auto-mode rider — only the ledger, "an obligation on the writer, not an enforcement."** The honour system was the only thing standing there and it held. **A new evidence row for CCSED-260911.**

**THE STRAT PARALLEL FOLDED IN.** ⚠ **The driver moves from BVSC Mexico City to the private-beta gate — the first time since 2026-09-05 that the Roadmap is not sequenced by one production.** Private beta ≈Sept 18, sixteen leads **plus their teams, 30–40 people**, which is what makes the sharing surface load-bearing. **AUTH-RESETPAGE moves to first-unit-AFTER-the-invite.** Process findings register HELD by default. ⚠ **Beta terms are a gate item for the PRIVATE beta, correcting earlier Strat advice** — Daniel's own 2026-08-15 rule is terms before any third-party access. Read order now points at **Brief v1.2**; **Strategy Prompt v15** replaces v14.

⚠ **TERMINOLOGY RULED, AND THE QUESTION BEHIND IT FOUND A REAL GAP.** Daniel asked how Minotaur file versions and equipment list revisions are told apart. Measured: the two vocabularies are **completely disjoint** in every operator-facing string, and each word is anchored correctly — but **nothing in the app states the difference, and a Project Version does not contain the Equipment List Revisions.** **RULED: the full terms "Project Version" and "Equipment List Revision" throughout**, plus his sentence verbatim on the History screen. ⚠ **AND A RULING THAT REVERSED ARCH: a fork MUST carry the original's Equipment List Revisions**, because without them the copy cannot print a revised equipment list at all — there is nothing to diff against. Arch had argued the opposite and was wrong on the domain.

**THE FORK DESIGNED FROM LIVE INTROSPECTION, NOT BUILT.** `drafts/260911-1600_verhist-fork_DESIGN.md`. ⚠ **Two traps found before a line was written: a new project SEEDS ITSELF via `seed_na_rows`, and `guard_system_method` refuses to let those rows be deleted** — so the restore must MAP the payload's system rows onto the seeded ones. Nineteen tables remapped in FK order; **the identity map carried and remapped** (Arch's call). ⚠ **~4,000 rows against an 8-second timeout is the open measurement, and if it does not fit the answer is not a bigger timeout.**

**TWO MEASUREMENT ASKS DISCHARGED FROM THIS SEAT.** **SIGNUP-GATE — closed, three layers deep:** the signup route is a server component with no `createClient()`, no `signUp()` and no error path, and the newest of 12 users predates the 2026-08-15 closure. ⚠ **GLOBAL-LIB — worse than "not seeded": there is no global tier at all.** `equipment_library_items` holds **14,411 rows, ZERO unscoped**. Not a gate item, because the cohort's task is to import a real show and an import brings its library.

**THE CLOSE.** **Roadmap v4.31 retires v4.30 and v4.29 — 116,471 characters, and only 33 words sit above ▶ NOW.** v4.30 was built and committed inside this same close and superseded within it: Daniel read it and rejected 457 words of preamble above the section he actually reads. ⚠ **DOCKET-STALEACTIVE's pass actually ran this time: nine rows retired, counted rather than claimed, and its blocker cleared because FIELDCONTRACT-3B now exists as its own row.** ⚠ **Strat's "§0 THE TRACK" was FOLDED INTO THE SEQUENCE rather than added as a fifth section (Daniel)** — a dated road and an ordered build list are the same view at the same altitude, and carrying both would have said the near-term work three times. ⚠ **Arch's first draft failed twice on writing: a SEQUENCE that was a second Docket with a paragraph per row, and two paragraphs Daniel sent back as unreadable — every word understood and the sentence meaningless.** Both failures are now rules in the file: the granularity ladder, and plain English or it has failed.

**Arch errors this session:** the stale suite baseline carried into a handoff (2980/157 against a measured 3088/160); the `import_apply_v1` NULL premise, bounced by CC; the seat check run out of order; a commit phrase handed over with the browser gate deferred, which contradicted GATE-REPORTING and which CC refused; and the `memberIds.length` count that omitted the bundle row, which changed the verdict at exactly twenty members.

**Next action:** the next session spins off the **LICDB** parallel opener before its own work, then **scopes the sharing surface**.

**⚠ A THIRD WRITING FAILURE, AND IT IS THE ONE WITH A CAUSE.** v4.30 was committed and then rejected on sight: **457 words above ▶ NOW**, all of it rules about the file rather than facts about the project. Traced with Daniel rather than asserted: the Architecture Prompt already holds the Roadmap's rules, the Ledger already holds what each version retired, and the Docket already holds the standing facts — **the preamble duplicated all three into the one document he reads.** ⚠ **And the mechanism behind all three failures was named: Arch reads a ~95-bullet Session Log header and a dense Roadmap at every open, and then writes in that register — which is correct for another Arch session and wrong in a message to Daniel.** **v4.31 is the fix: 33 words above ▶ NOW, no ⚠ icons in the part he reads, 116,471 characters.** ⚠ **Three structural gaps registered with it, all into META: the Session Log header has no bound and is now the system's real memory; rollover archives entries, so a finding written into an entry dies unless it is lifted to the header first; and the register problem itself.** ⚠ **RULED (Daniel, 2026-09-12): process, workflow and hygiene work runs in ONE parallel session and never on the main line. The priority is Minotaur v2, features and integrity, and momentum.**

---

### September 12, 2026 — Cowork-Arch session, the MAIN LINE (**PREBETA-FRICTION SHIPPED AND COMMITTED AT `bf0d7ed`, NOT PUSHED — three defects closed and nothing deployed** · ⚠ **the six-second cable delete traced to SIXTEEN sequential round trips, refuting both of Arch's candidate causes** · ⚠ **the Architecture Prompt found twelve days wrong about the push, by CC and independently by a parallel** · **SHARING scoped, SHARE-R8 ruled, and AUTH-RESETPAGE became the only door in** · **MAILGATE ruled** · **both parallels returned** · **five Arch errors, two caught by CC and one by counting** · model `claude-opus-5`)

**Seat check passed, in order.** Three mounts reachable. **State from files, never by running git:** code `96efd11`, `Minotaur-Cowork` `478ba48`, both equal to `origin/main`, no lock files, `CLAUDE.md` 115,579 characters, migration ledger live-read at **59** and byte-matched, Session Log at 8 — rollover clear at the open. ⚠ **Production READY is permanently un-seat-runnable and the reason is egress; it is Daniel's and always will be.**

**The session opened by writing a handoff rather than by asking anything**, on Daniel's instruction. One bundled pre-beta unit from items already planned and already ruled. ⚠ **`BATCH-PREBETA`'s member list proved older than its members' status** — four of eleven ride SHARING, DEPS is a CC hard-stop class, GCM is post-beta, IMPRPT-COPY has no measured surface — **so three were buildable and those three were the unit**, with every exclusion stated in the handoff so CC could not quietly widen it.

**PREBETA-FRICTION — `bf0d7ed`, 8 files, +416/−31, committed and NOT pushed.** The middleware's unbounded auth await is bounded at 3,000 ms resolving as signed-out, with protection reduced nowhere and twelve new tests. The export report derives its fourteen filenames from `EXPORT_FILENAMES` instead of re-typing four, **pinned against `ALL_EXPORT_FILENAMES` and never against a count**, with two guards that read the settings page itself because that is how the drift survived. **Frame 06 did not move, measured — the report renders only after an export runs.**

⚠ **CP2 IS THE ONE WORTH READING. BOTH OF ARCH'S CANDIDATE CAUSES WERE REFUTED ON THE PRODUCTION ITSELF** — it carries zero patch ends, so the per-row sweep writers write nothing, and the invalidations are never awaited. **The cause is groups-per-cable: a median of SIXTEEN, each broken as its own round trip.** Now two — dissolves as one `bulk_delete_v1`, unlinks concurrent, **order-independence proved from `planDeletePurge`'s own code and pinned by a test rather than left in a comment.** ⚠ **The handoff pointed at the wrong two things and said to measure first; measuring first is the only reason that was survivable.** ⚠ **And the honest limit CC stated itself: the timings are a reproduction on a seeded throwaway carrying the production's measured topology, because that production is RLS-invisible to the test user. Daniel's gate is where it becomes real, and he deferred it.**

⚠ **CC BOUNCED AN ARCH INSTRUCTION ON THE SURFACE RULE AND WAS RIGHT — TWICE IN TWO SESSIONS.** The handoff restated v35's claim that the push is inert. **FENCE-PUSH landed 2026-08-30.** Re-measured at source by Arch rather than taken on the return's word: `settings.json:6` allows the bare form, `bash-fence.sh:47-51` carries the ruling and says so in its own refusal string. **`CLAUDE.md` had it right in six places; the Roadmap's RETIRED index had it right; this header had it right. v35 was the only live document still wrong — installed one day after its own rewrite.** ⚠ **Independently corroborated by the META parallel the same day, by RUNNING both forms through the fence rather than reading it.** *Arch carried the rule with its reason exactly as instructed, and the reason was obsolete.*

**SHARING scoped, and the Docket row was the thing that was wrong.** SHARE-R1..R7 were ruled 2026-08-12 and Daniel re-confirmed all seven; **SHARE-R8 supplies the mechanism that had been reserved to Arch at build-prep on 2026-08-15.** ⚠ **That makes AUTH-RESETPAGE the only door into the beta and moves it ahead of the invite**, superseding the 2026-09-11 Strat sequencing on that point alone. ⚠ **Arch reversed its own advice inside the session:** it first told Daniel only a user-initiated link could work, which is true of the PKCE code exchange and false of `token_hash` + `verifyOtp` — **which needs no verifier, and therefore works from an admin-initiated invite too.**

**MAILGATE ruled, and prompted by Arch's own failure** — Daniel asked for approval on mail sends to be asked for on its own, not buried among other paragraphs of asks. Measured alongside it: **0 invites and 0 recovery mails have ever been sent from this project.**

**Both parallels returned and were folded.** LICDB's workbook exists with 747 people and 181 live licences, two independent derivations agreeing. META returned fifteen members, **its Tier 1 installed at this close**, Tiers 2 and 3 folded into the next unit touching `.claude/hooks/` or either repo, and **Tier 4 registered as PROCESS-REFACTOR, released only after the invite and week-one fixes, with Daniel's acceptance written as a reading test.**

**Arch errors this session:** the stale push claim carried into a handoff, caught by CC; ⚠ **a net character figure written into v36's own version line that was wrong by sign and magnitude — stated −569 against a true +571, caught by counting rather than reading, in the one document being corrected for carrying a false claim**; "the amendment never ran," inferred from HEAD alone when commit-and-stop looks exactly like that; ⚠ **three CC handoffs issued as one-line pointers buried at the ends of long multi-topic messages rather than as the prompt's handoff sequence, so Daniel could not find them — the same burying failure MAILGATE was ruled against**; and the PKCE advice reversed above.

**The close.** **Roadmap v4.32 retires v4.31** — ⚠ **it GREW by 595 characters and that is declared rather than hidden; the prune is PROCESS-REFACTOR's job.** **Architecture Prompt v36 retires v35**, one correction, **+420 characters against the standing no-additions-without-removals instruction, declared rather than paid for by trimming measured text.** `CLAUDE.md` 115,579 → 117,288: the browser gate becomes **step 0 of the COMMIT BLOCK and a precondition the phrase cannot supply**, the `_CLOSE.txt` contract stops being conditional on a push and gains a gate field that is never inferred, and ⚠ **the run fence's stale `57` is corrected by a dated note rather than by editing a true record of its own date.**

**Next action:** Daniel runs the browser gate for `bf0d7ed` and pushes, then opens **AUTH-RESETPAGE** on its waiting handoff. ⚠ **The next session pauses at pre-open and runs the ROLLOVER — this entry makes 9 and it fires at 10.**

---

### 2026-09-12 — Strat (parallel, Cowork) — pricing model reassessed

Decisions (Daniel): Individual $199/year at release (was $149); Production tiers unchanged ($349 NfP / $599 Commercial, perpetual per project); no monthly Individual and no free viewing at release — free viewing is a one-way door and Production licenses are three quarters of revenue; nobody opens a project without a license of their own unless the project carries a Production license. Named-user rule goes into the beta terms this week. One active editing session per Individual account before v2 charges anyone (SEAT-CAP; mechanism Arch's). Organization tier and a monthly option registered as proposals for after the first paid quarter.
Finding: the Brief's Lightwright benchmark ($149/yr) is wrong — Lightwright is $399/yr individual, $375/seat organizations, viewing free, read 2026-09-12; replacement sentence in the RETURN. v1 never had a sharing problem because the serial was hardware-locked; v2 removes the lock, so the sharing question and the price question were one problem.
Correction (Daniel): ShowBuilder has no public pricing and about five users whose output is disliked — the Brief's "direct competitor" threat level is overstated (COMPETE-FIX).
Open: none.
Work: this RETURN only. No governing document written.
Next action: main line folds §1–§2 in; Daniel adds the named-user paragraph to the beta terms.

---

### September 12, 2026 — Cowork-Arch session, the main line, closed by the General Advisor (AUTH-RESETPAGE built and uncommitted · rollover installed · four wordings put to Daniel · the session failed on readability and the governing documents were rewritten at its close · Arch model `claude-opus-5`; close written with the General Advisor)

**What happened.** The seat opened, verified state from the ref files (code `d980b73` = `origin/main`, Cowork `664df60`, ledger 59, `CLAUDE.md` 117,288), and found that `bf0d7ed` had been pushed since the last close — the Roadmap and this log both still said it was unpushed. The rollover ran and was installed on Daniel's word: seven entries archived (a 9-entry log cannot take the 8-plus-2 split), two retained, 152,567 → 95,172 characters. Project knowledge was brought current (Roadmap v4.32, Architecture Prompt v36, Ledger, Session Log; v4.31 and v35 deleted). The FENCE-PUSH line for the Strat record was handed to Daniel. The AUTH-RESETPAGE handoff was re-verified at source (one figure off by a line), rewritten as `to-cc/260912-1355_auth-resetpage.md`, and executed by CC.

**CC's return.** The unit is built — 14 files, 2 modified and 12 new — with suite 3,255 / 167, typecheck 0, build clean, frozen 3/3, dependency clean, visual 28/28 unmoved. Uncommitted; `origin/main` still `d980b73`. CC bounced three Arch claims and was right on all three: the set-password page could not live under `/auth` (signed-in requests there redirect to the dashboard) and moved to `/account/password`; the dead-class instruction had the contrast direction backwards for that page, and the 12.81 figure of record belongs to dark-theme `surface-900` on `surface-0`, not to these lines, which measure 1.19:1; and the typed six-digit fallback does not rescue the scanner case, because the link and the code are one token and `/auth/confirm` verifies on GET. Twelve open questions came back; the ones that matter are now Docket rows in plain words (AUTH-LINKCLICK, AUTH-SIGNIN-CONTRAST, AUTH-COPY, AUTH-DASHBOARD, AUTH-PROVISION).

**Rulings (Daniel).** EXPRPT-HINT approved as proposed. VERHIST-MANUALLEAD approved as proposed; the gate on Save Version work is lifted. CABLEDEL-FAILMSG: "cleanup" rejected — reworded, awaiting his yes. INSPECTOR-ARM: withdrawn from his desk, because the diagnosis of record (Method lives only in the inspector; Change All arms only on a selected row) does not match the code — `method_name` is an ordinary row cell and neither arming path reads a selected row. Arch owes a measurement on the running app.

**Also done.** The cohort's sixteen addresses found in Gmail and put up for approval (four need a word); nothing sent under MAILGATE. The beta-terms parallel opener written and opened by Daniel; `BETA_TERMS_v0_1.md` and its coverage and open-questions files now exist in the project. The pricing parallel (Strat, 14:09) returned and is folded in at this close: RELEASE $199, SEAT-CAP, ORG-TIER, MONTHLY-HOLD, COMPETE-FIX, BRIEF-13, the LIC-NOV amendment and the LEGAL-SELFDRAFT rider.

**The failure.** Daniel could not read the OPEN QUESTIONS relay ("what page are you talking about?", "how can I decide?") and closed the session. Diagnosed with the General Advisor against every Architecture Prompt version since v15: the prompt had grown from 14,000 to 27,000 characters of rules written to stop a future Arch from rationalising past them, so Arch wrote for Arch; the prompt itself required a metadata line above ▶ NOW and opened with a changelog, so the Roadmap kept growing above the section Daniel reads; and every open read a 70,000-character Session Log header in that register. **Installed at this close: Architecture Prompt v37** (12,500 characters — every v36 ruling kept, every justifying paragraph gone; NOW and NEXT are Daniel's words that Arch never writes; a passing session open is one line; two readers, never mixed); **Roadmap v4.33** (one-line Docket rows, no caution triangles, nothing above NOW but the title; 117,064 → 41,760 characters; v4.32 stays in the repo as the full text of record); and **this header** (six fields, 2,000 characters; the 102-bullet header frozen into the Ledger). PROCESS-REFACTOR's remainder is the Standing Facts decision only.

**Arch errors this session:** the INSPECTOR-ARM diagnosis written from the symptom rather than the screen; the 12.81 contrast figure cited without its conditions; the OPEN QUESTIONS relay written for a machine; the Roadmap and log header left saying `bf0d7ed` was unpushed after it went live.

**Next action:** Daniel runs the browser gate on AUTH-RESETPAGE and types the commit phrase. The next Arch session opens on `drafts/260912_next-session_OPENER.md`.

---

### September 12–13, 2026 — Cowork-Arch session, the main line (the front door shipped in two units · the terms adopted and their acceptance designed · the mailer finding · provisioning ruled · the registry ruled · Change All fixed · model `claude-fable-5-1`)

**What happened.** The seat opened 2026-09-12 evening on Architecture Prompt v37 (one-line open, with a disclosed `git status` in the docs repo). The AUTH-LINKCLICK + AUTH-SIGNIN-CONTRAST handoff was written that night and pointed at CC one step early; CC stopped on its own precondition because AUTH-RESETPAGE was still uncommitted. On the 13th Daniel gated the password page (the code-refusal wording found wanting), CC committed and pushed `57e0eec`, then built and shipped the two fixes as `3416650` — links verify only on a press, the sign-in page reads 11.19:1 where it read 1.19:1. CC then built CHANGEALL-MODEL-SERIAL (333 requests and 146 seconds → 5 requests and 2 seconds), left uncommitted for Daniel's gate tomorrow.

**Findings.** Supabase's built-in mailer refuses every address outside Daniel's own team, verified in the vendor's guide — AUTH-SMTP became a gate item and Porkbun (where `info@minotaur.app` lives) the sender. Nothing in the product recorded acceptance of the terms; the beta-terms parallel (second start, under General Advisor v7) adopted the text, chose sentence-plus-record over a click-through, and the acceptance table was rehearsed and applied as migration 60. `Comet Fall '26` shows a third-party v1 library import on 2026-08-19, after Addendum §F said none had happened. Paradise Square (New York) arrived with 24 split cables and is filed as CABLE-SPLIT's evidence.

**Rulings.** Provisioning is dashboard-created accounts and self-serve resets (no script, no invite mail). One licensing registry for Daniel's eyes only, three design parallels, nothing applied before the invite. Twenty Docket questions answered in one sitting (§2 of the eighteenth append) and folded into two bundled future handoffs, AUTH-POLISH and PRINT-RULES. Thirteen throwaway projects deleted. Two scheduled tasks created: tomorrow's reminder and the daily morning check.

**The close.** Roadmap v4.34 (Daniel approved it as a file before the twenty rulings were folded; grew to ≈47,000 characters, declared), the eighteenth Ledger append with both retired fence bodies, this entry. `CLAUDE.md` and the Architecture Prompt untouched by Arch.

**Arch errors this session:** the `git status` at the open; the CC pointer one step early; the UTC filename; a wrong subject prefix in a paste, caught before use; one file left off an expected FILES CHANGED list; estimated line numbers; a predicted screenshot movement that did not exist; the opener's prompt version; an unfilled `<time>` placeholder.

**Next action:** Daniel's CHANGEALL gate and phrase (2026-09-14, reminder at 09:00), then CC on `260913-1500_terms-accept.md` with the publication date. The next main line opens on v4.34 and reads the REGISTRY-1 return.


### 2026-09-13 — Arch (parallel, Cowork) — REGISTRY-1, the licensing data model

Delivered: the registry data model — 17 tables in a `registry` schema the API does not
expose, built around a person rather than an account; entitlement computed on every ask
and never stored. Two rehearsals run inside transactions forced to roll back; residue
zero; the database is identical to session start. Nothing applied.

Rulings (Daniel): the access model — a Production licence is that project forever, for
everyone on it, and nothing else, and a Production-only holder cannot create a project;
the v1-holder door test — any v1 tier except trial expiring on or after 2026-04-15, a
six-month lookback, comped and educational in and demos out (241 rows / 214 people /
~185 humans); cohort membership carries beta access, the v1 expiry being the entry test
only; the post-licensing window back to 60 days, reversing this morning's Question 2,
clean because the terms are unpublished with zero acceptances; a v1 licence bought during
the beta gets the transition, a deliberate $99 discount; the public paste-your-serial path
withdrawn; V1-ISSUE registered — the registry mints v1 serials and drafts the email;
Joseph Haggerty joins the cohort; D5 and D9 routed to the terms and the attorney packet.

Found: (1) entitlement returned a single may_edit that would have refused a Production-only
collaborator — a Broadway crew member locked out of his own show — split into
may_open_own_projects / production_project_ids / has_any_access; (2) the ≈Oct 15 beta has
no way in — signup closed 2026-08-15, ~185 people cannot be hand-provisioned, and
entitlement_for needs an account that does not yet exist — new row BETA-SIGNUP-GATE;
(3) LICDB's 68 unreachable live holders are eight, three of them paid — the rest were the
same humans on other rows, addresses filed under a different machine, or institutional lab
seats. Daniel's explanation: a serial sent by text leaves no mail to find, so "FileMaker
export only" means delivered through another channel.

Proven: a Postgres port of CipherEncrypt reproduces two real FileMaker serials byte for
byte and round-trips on all sixteen shift pairs; the decoder reads three real serials
correctly and returns nothing for garbage. A serial minted in the registry cannot leave no
row, which closes the caveat that created the 107 off-book machines.

Corrected against the parallel's own first draft: the 107 off-book machines are five live,
four of them reachable — the serial-paste argument does not hold and went with the feature.

Open: the four LICDB questions (they size the announcement, not the schema); when v1 stops
being sold; D5 and D9 with counsel.
Work: DESIGN, RETURN and ADDENDUM in handoffs/parallel/ and drafts/. No governing document
written, no CC handoff, no migration.
Next action: Daniel confirms the migration sequence; then 61–64 rehearse as one unit.

Sequencing amended the same evening (Daniel): the "nothing applied before the invite"
ruling is lifted for migrations 61-64, which apply in the main line while it waits on the
browser gate — the set is wholly additive (one new schema, no ALTER on any existing table,
three new function names verified free), and invisible to the running app because the
schema is not exposed and nothing calls it. Arch error caught in confirming the sequence
and owned: entitlement_for() reads cohort_members, which had been filed two migrations
later — the rehearsal created all tables in one block and so proved the objects, not the
order. Corrected order: 61 identity, 62 licences, 63 cohort, 64 entitlement, 65 import,
66 payments, 67 subscriptions. The anon grant on v1_beta_eligible is held back until
BETA-SIGNUP-GATE builds the route in front of it.

### September 13, 2026 — Cowork-Arch session, the MAIN LINE (**the licensing registry APPLIED — migrations 61–64, the first schema work since `terms_acceptances`** · ⚠ **the parallel's own ordering correction was itself wrong in mechanism, and the truth is worse** · **the three never-run pieces rehearsed and proved** · **the seat did this while idle on a browser gate it cannot run** · model `claude-opus-5`)

**Seat check passed, in order, one line.** Three mounts requested and granted before anything was read. **State from files, never by running git:** code `3416650` = `origin/main`, docs repo `940d42b` = `origin/main`, no `index.lock` in either (the two registered `ORPHANED-index.lock.*` are the only lock files), `CLAUDE.md` **109,777 characters**, **migration ledger live-read at 60** (`20260913182602 terms_acceptances`), Session Log at 5 — rollover clear. All seven CHANGEALL-MODEL-SERIAL files present and unmodified since 17:44–18:01 the previous evening, so the unit is still uncommitted in CC's tree as the opener said.

**REGISTRY-1 folded in.** The RETURN, the TO-MAINLINE with its three corrections against v4.34, and the AMENDMENT that supersedes §5. Twelve rulings carried forward without re-litigation.

⚠ **THE CORRECTION TO THE CORRECTION, AND IT IS THE DURABLE FINDING.** The AMENDMENT records that migration 64 "would fail on apply" without the cohort tables. **Measured on this database before it was written into the Ledger: it would not.** `entitlement_for()` is PL/pgSQL, and PostgreSQL does not resolve table references in a PL/pgSQL body at CREATE time even with `check_function_bodies = on` — probed directly, `plpgsql CREATE with missing table: SUCCEEDED | CALL failed`, while the same probe in `language sql` **did** fail at CREATE. So in the original order migration 64 would have applied **cleanly and silently**, and broken at the first real call to `public.my_entitlement()` — the one function the app calls — for every signed-in user. **The rule of record gains a second half: a one-block rehearsal cannot catch an ordering bug, and for PL/pgSQL bodies neither can the apply. Ordering is proved only by running the migrations separately, in sequence, and then calling what they create.**

**The rollback harness was proved before it was trusted.** A throwaway schema created inside a multi-statement query terminated by a forced exception left no residue. Recorded because every previous rehearsal's residue claim rested on that behaviour and nothing had tested it.

**MIGRATIONS 61–64 APPLIED** — 61 identity, 62 licences, 63 cohort, 64 entitlement, each its own migration, in the corrected order. Trigger B run in full: live introspection, proof-run with forced rollback, residue check, Daniel's confirm, apply, verify with grants. **The three things never executed before tonight all work:** `issue_v1_serial` mints a serial, decodes its own output and refuses to return anything that does not round-trip to the intended machine and date, then writes machine, licence, serial and event rows in one transaction and drafts the email (MAILGATE stands — it drafts, it does not send); `v1_beta_eligible` answers true for a live Personal holder with mixed case and stray spaces, false for a trial, false for a licence seven months lapsed, false for a stranger; and **the corrected entitlement shape does what the `may_edit` bug could not** — a Production-only collaborator reads `may_open_own_projects: false`, `production_project_ids: [the show]`, `has_any_access: true`, so the Broadway crew member gets into his show.

**Verified after the apply:** ledger **64** · 12 tables, 2 views, 5 registry functions · RLS enabled **and** forced on all 12 · **0 policies, 0 table grants** to anon / authenticated / service_role / PUBLIC · none of the three roles holds USAGE on the schema · `anon` has no execute on any of the three public functions. **The `anon` grant on `v1_beta_eligible` was deliberately withheld** — it is the only externally reachable thing in the set and BETA-SIGNUP-GATE's rate-limited route is not built.

⚠ **A SECURITY FINDING RAISED FROM THE ADVISOR RUN AND DOWNGRADED BY MEASUREMENT AN HOUR LATER — ARCH'S ERROR, CAUGHT BEFORE ANYTHING WAS BUILT ON IT.** The post-apply advisor reports `public.handle_new_user()` and `public.rls_auto_enable()` as SECURITY DEFINER and executable by `anon` over the REST API, and **DEFINER-ANONEXEC was registered in all three documents with that wording accepted as a finding — a lint report taken for a measurement, which is precisely what the Surface Rule forbids.** Probed live: **both REFUSE direct invocation, `0A000 trigger functions can only be called as triggers`**, because one returns `trigger` and the other `event_trigger` — a function of those return types cannot be called as an ordinary function by anyone, PostgREST included. The GRANT is real; the reachability is not. What survives is one genuine item — `handle_new_user` is SECURITY DEFINER with no `search_path` set and fires on every `auth.users` insert — and two cosmetic ones. Also learned in passing: `rls_auto_enable` auto-enables RLS on new tables **in `public` only**, which is why the registry's twelve needed explicit statements. **DEFINER-ANONEXEC re-scoped to low, not a beta gate, in all three documents in the same pass.** The twelve registry tables appear under `rls_enabled_no_policy` at INFO, which is the design and not a defect.

**Nothing else moved.** No CC handoff, no commit, no push, no write to the code repo, no mail. 65, 66 and 67 keep their dates. `issue_v1_serial` and `v1_beta_eligible` exist with no admin surface and no route in front of them.

**Arch errors this session:** the Ledger's migration-version column was written with one guessed value and three dashes before the versions were read, corrected in the same pass · **DEFINER-ANONEXEC was registered in three documents from an advisor's wording without measuring reachability, and the measurement downgraded it an hour later** — the second Surface Rule lapse of the evening, both caught here rather than downstream.

**Next action:** Daniel's CHANGEALL browser gate and commit phrase (2026-09-14, reminder at 09:00), then CC on `260913-1500_terms-accept.md` with the publication date.


### September 14, 2026 — Cowork-Arch session, the MAIN LINE (**TWO UNITS SHIPPED, two production deploys — CHANGEALL-MODEL-SERIAL `7993221` and TERMS-ACCEPT `1f82072`; the beta terms are IN FORCE** · ⚠ **a live defect found by the browser gate in code that shipped the day before** · **a Docket audit found eight designed layouts with no row and four other misses** · ⚠ **the Roadmap hit its cap** · model `claude-opus-5`)

**Two deploys.** CHANGEALL-MODEL-SERIAL passed its browser gate at about half a second on a 48-row found set, categories intact, snapshots 1 → 3 proving the version-history guard live on that path. Its commit was eight files, not seven; CC reported the difference rather than absorbing it. TERMS-ACCEPT then published the beta terms: `/beta-terms` signed out or in, the ruled sentence under the button, an acceptance row written before the password — with a forced-failure proof that no password is set without a record. Fifteen files, every machine gate green.

⚠ **THE VISUAL GATE COULD NOT RUN AT FIRST AND CC REFUSED TO FORCE IT.** The machine measured a 1-minute load of 12 to 66; the harness ceiling is 5.0 and `--force-load` is forbidden. Daniel found Logic open, closed it, and the gate ran clean at 4.65, 28/28, no baseline event. The refusal is the control working.

⚠ **OTPLEN-MISMATCH — A LIVE DEFECT, FOUND BY THE GATE, IN CODE THAT SHIPPED THE DAY BEFORE.** The emailed recovery code is **eight digits**; `resetFlow.ts:80` hardcodes `OTP_LENGTH = 6` and refuses anything else **before it reaches the auth host**. The typed-code path has never worked on this project. That code is the fallback for a link a mail scanner burned — the exact failure AUTH-LINKCLICK exists to prevent — so a burned link currently means no way in. Not blocking TERMS-ACCEPT, which touches none of those files. The 2026-09-13 `codeExpired` finding may have masked it.

**A DOCKET AUDIT, AND IT FOUND REAL WORK WITH NO ROW.** 619 ID-shaped tokens across every design and return document were diffed against the Roadmap, then narrowed to those absent from the Ledger and Session Log too. **The eight queued layouts** — designed 2026-08-28/29 against real v1 prints, none built, all greyed out, five with zero mentions anywhere — now have rows, plus LAYOUT-FINDSCREEN for the screen six of them need. A correction in Daniel's favour: Equipment Labels' schema prerequisite shipped as migration 57, so its August estimate overstates it. Also registered: **BOX-REPRINT** (the box outputs have never been checked against a v2 render), **DEEP-ARCHIVE** (scoped after the R8 drill, carrying a legal parameter), **COMMITMSG-PATTERN**. ⚠ **And BOX-DOC-PARITY's trigger fired two weeks ago while the row sat in HELD** — the check HELD-IS-NOT-FORGOTTEN requires at every close did not happen.

**Rulings (Daniel):** the types regen held out of the terms commit and made its own unit · BATCH-HOUSEKEEPING and PRINT-RULES never bundled, housekeeping first, because housekeeping repairs the instruments PRINT-RULES is measured by · SHARING REV-B designed as a parallel on the REGISTRY-1 pattern · the terms page keeps the default title · the smoke acceptance row removed.

**Data action by the seat:** deleted the smoke `terms_acceptances` row on `daniel+pt@`; two genuine rows remain, both Daniel's own from his gate.

⚠ **THE ROADMAP IS AT ITS CAP.** v4.37 is 59,988 characters against 60,000, after the retired index was compressed to fit. The next close cannot add a row without a structural decision. Owed before the next append.

**Arch errors this session:** DEFINER-ANONEXEC was registered in three documents from an advisor's wording without measuring reachability, and downgraded an hour later when the measurement showed both functions refuse invocation · the Ledger's migration-version column was written with a guessed value before the versions were read · two instructions were given in jargon Daniel could not act on, and one was left truncated mid-paste.

**Next action:** open on v4.37, issue the SHARING REV-B parallel opener, write AUTH-POLISH.

---

### 2026-09-14 — Arch (parallel, Cowork) — SHARING REV-B, the permissions delta

Delivered: the last design work on SHARING — the permissions delta table by table, the
destructive gestures, the fourth role, WHOCOL-RLS, the teammate account path, and the
seat relationship. Five migrations (65–69), all policy-level: one trigger, one CHECK,
four functions, no new tables. Each rehearsed separately and in sequence inside a
transaction forced to roll back, then called at privilege level; 21 probes across
editor, viewer, admin, owner and a non-member, all matching. Residue clean, ledger
unchanged at 64, nothing applied.

⚠ FOUND, and it is the session: snapshot_project_v1 is SECURITY INVOKER and reads seven
owner-only cable tables under the caller's RLS, coalescing a blocked read to []. The day
the first non-owner membership row exists, any of the twenty commit points writes a
backup with no cable system in it, returns a uuid, and the guard — whose own module says
a net the operator believes in and does not have is worse than no net — reads that as
success. Measured on a throwaway: editor fires change_all → 10/0/0/0/0/0/0/0 against a
truth of 10/7/1/1/1/1/1/1; after migration 66, the same editor and gesture → 10/7/1/1/1/1/1/1.
Registered as VERHIST-TRUNCATE, an evidence row belonging to version history. The same
shape, quieter, in six invoker RPCs that return a count rather than an error (RPC-COUNTNOTERROR).
HARD RULE: nothing but 'owner' enters project_members until 66 is applied.

Rulings (Daniel, all eight as proposed): four roles stand as SHARE-R1 ruled, admin made
legal at 69 and surfaced after the invite; the beta ships EDITOR-ONLY with viewer and its
whole-app control inventory moving to week one together; the eighteen-table sweep rides
the gate; every accepted member sees the roster (open since 2026-08-21); an editor may
fire Delete Unused on the Categories and Methods admin; private_notes unchanged and out
of the gate with viewer; the snapshot completeness guard lands week one; no
teammate_requests table before the invite.

⚠ The opener contradicted itself and the record: its body asked whether three roles are
enough while its own Settled list re-ruled SHARE-R1's four, which the Ledger confirms.
Flagged before any work; the Settled list won; one of the two needs correcting.

Also found: all four project-images storage policies are owner-only, so every print a
collaborator makes is missing its letterhead; the 2026-08-12 WHOCOL-RLS fix would have
exposed every co-member's email, avatar, theme and library flag to fix a name column, and
is withdrawn in favour of a two-column function; and WHOCOL-RLS needs a third arm for
past snapshot authors, or Who re-opens as a raw uuid the moment someone is removed.

Corrected: the Roadmap's SHARING row says 25 membership rows; live is 12. 13 projects,
one with no owner row.

Work: DESIGN and RETURN in handoffs/parallel/ and drafts/; TO-MAINLINE alongside. No
governing document written, no CC handoff, no migration, no mail, no account created.
⚠ HEAD moved 1f82072 → 3b98ce9 mid-parallel (CC committed and pushed); every code
citation re-measured at the close and all hold.
Next action: Daniel confirms the migration sequence; then 65–69 apply in order, one
Trigger B at a time, with a storage probe added at apply time.

---

### September 14–15, 2026 — Cowork-Arch session, the MAIN LINE (**AUTH-FRONTDOOR SHIPPED `3b98ce9` — the typed recovery code works for the first time on this project** · **the mail sender configured end to end and proven with a real email** · ⚠ **THE FIRST TWO REAL USERS ARE IN, and the first night produced eight findings** · ⚠ **the app ships no font file, so every print-parity measurement assumed a typeface most users may not have** · ⚠ **two colour palettes found in the database under the same names** · **three Arch errors, two caught by CC and one by Daniel reading a sentence** · model `claude-opus-5`)

**Seat check passed. State from files, never by running git:** code `1f82072` = `origin/main` at the open, `3b98ce9` at the close; no lock files; migration ledger live-read at **64**; Session Log at 8, rollover clear at the open and **DUE at the close**. Three mounts reachable.

**The session opened on an opener that was already wrong about itself.** It named two ⚠ blocks — a stale ▶ NOW and a Roadmap twelve characters from its cap — and Daniel ruled both out of scope in one sentence: *"the last arch chat wrote the roadmap, we should follow it, and update it at session close."* Registered because the same instinct produced the morning's wasted exchange and the evening's cap fold was accepted without argument once it was framed as work rather than process.

⚠ **THE TWO FINDINGS THE OPENER SENT ME TO FIX HAD SHIPPED THE DAY BEFORE.** AUTH-LINKCLICK and AUTH-SIGNIN-CONTRAST are in `3416650` and in the Roadmap's own retired index; ⏭ NEXT still described them as owed. What was actually left on the front door was **OTPLEN-MISMATCH**, and it was the live one.

**AUTH-FRONTDOOR — SHIPPED `3b98ce9`, one production deploy, 4 files, +65/−30.** CP1: `normalizeCode` accepts a plain run of 6 to 10 digits and leaves the judgement to the host; `OTP_LENGTH` is deleted because nothing reads it. CP2: the five ruled auth sentences carry their pedigree, each verified byte-identical against `3416650` before a comment was written. Suite 3,310 → 3,312. One deletion control, two red tests, restored byte-identical. Browser smoke proved an eight-digit code reaching `verifyOtp` as `"token":"12345678"`.

⚠ **CC BOUNCED CP3 AND WAS RIGHT, AND THE ERROR WAS MINE IN A WAY WORTH RECORDING.** The handoff told it to swap the auth links onto `--brand-link`, calling that "readable in dark mode". Measured at source, that token is tuned for `bg-surface-0` grounds; every one of the six sites and every existing consumer sits on `bg-surface-950`, which has the opposite polarity. The swap would have taken dark from **2.42:1 to 1.64:1** and light from 6.73 to 3.29. **I measured the links and never measured the ground behind them** — a Surface Rule failure by the seat that wrote the rule into the handoff. Moved to CONTRAST-PASS.

⚠ **CP4 DID NOT RUN BECAUSE THE POINTER I WROTE CONTAINED A BLANK.** The paste block carried `CP4's placeholder question, my answer: <YES or KEEP>`; Daniel pasted it as written; CC applied the handoff's own rule and stopped. A fill-in-the-blank handed to a person is an instruction defect, not a user error.

**THE MAIL SENDER, END TO END, IN ONE SITTING.** Custom SMTP on Porkbun (`smtp.porkbun.com:587`, STARTTLS, `info@minotaur.app`), sender name **Minotaur** — ruled against "Minotaur Sound System Database" on the grounds that a From line is for recognition and context belongs in the subject. Rate limit raised 30 → 100/hour, email OTP length set to 6 (which makes the four "six-digit code" strings true), the recovery template rebuilt on `{{ .TokenHash }}` + `{{ .Token }}`, the invite template matched to it so a stray dashboard send cannot rebuild the scanner defect, and the redirect allow-list verified — `https://minotaur.app/**` and `http://localhost:3000/**` both cover `/auth/confirm`, checked against the documented wildcard rules rather than assumed. ⚠ **Verified before any of it: Supabase's built-in sender delivers only to project team members AND is capped at two messages an hour** — it was never going to carry invite day. **Minimum interval per user kept at 60s**, because the page has no cooldown on "Send another email" and the enumeration property collapses a rate-limit refusal into "an email is on its way"; lowering the interval would trade a silent no-op for a first email whose link the second request kills. One clause is owed to the `sent` copy.

**DANIEL'S BROWSER GATE — PASSED**, ~9:40 p.m. ET on localhost, in his words: *"the sign out page only ever presents to me in light mode, but that's fine. email passes, 6-digit code passes, insistence on new password passes"*. The light-mode observation is NOT filed as fine — it lands on CONTRAST-PASS, because the auth pages' default state renders the dark-looking ground and `.dark` renders the light one, and which one a signed-out visitor resolves to decides which contrast pair matters.

⚠ **THE FIRST TWO REAL USERS.** Jamie Tippett and Mike Tracey — Daniel's fiancé and his best friend — ruled ahead of the production dress rehearsal on the grounds that their relationship to him, and therefore to the product, is different from the rest of the cohort. The rehearsal was skipped and they became it. **Tracey's account is at `mike@mtsounddesign.com`, not the `mtracey@me.com` COHORT-EMAILS ruled** — corrected in the Docket so no future session repairs a working account into a dead one.

⚠ **JAMIE'S FIRST NIGHT PRODUCED EIGHT FINDINGS AND TWO OF THEM CHANGED THE BOARD.** (1) **GROUPCELL-BLANK**, flagged urgent: a row whose group field is blank cannot be clicked into, so a group can never be set on a row that lacks one. (2) EQUIPSORT-NODESC. (3)(4)(5) the global library, default methods and a library-defaults inspector → **LIBRARY-DEFAULTS**, which needs a per-user library tier that does not exist. (6) contrast and type size everywhere, with five renderings or a switcher between mockups → **CONTRAST-PASS**, which is the key that unblocks DEADCLASS-SURFACE's 105 classes after weeks of "not machine-decidable". (7) NOTES-MULTILINE. (8) the menu reads `jtippettsound` → PROFILE-REALNAMES, now load-bearing for History's Who column.

⚠ **THE APP SHIPS NO FONT FILE.** Jamie does not have Century Gothic installed, and the stack is `'Century Gothic', 'CenturyGothic', 'AppleGothic', Futura, 'Trebuchet MS', …` — a pure local-font chain with **`AppleGothic`, a Korean typeface, ahead of Futura**. So no licence is owed and none is exposed, and **every print-parity measurement ever taken assumed a typeface most users may not have.** Webfont licensing priced and declined: Monotype sells it annually against pageview tiers (≈$80–165/yr at this scale, ≈$1,200 at 250k pageviews/month), which grows with success. **RULED: Jost**, self-hosted at build, behind Century Gothic, for people who lack it only — the stack collapses to two entries and the Korean face falls out as a side effect. Registered as FONT-FALLBACK, and **FONT-IS-NOT-SHIPPED** enters STANDING so this is not re-learned.

⚠ **TWO COLOUR PALETTES EXIST IN THE DATABASE UNDER THE SAME NAMES.** Jamie reported new projects showing wrong method colours that fix themselves when reassigned by hand. Measured: `global_default_methods` holds saturated (Chartreuse `#80FF00`, Pink `#FF69B4`, Aqua `#00FFFF`) and new projects are seeded pale (`#B8D586`, `#F6C6D8`, `#94E3FE`) from a second source. `Foo` is pale, `Memoirs` saturated, `Liberation` mixed — the fingerprint of hand-fixing. BVSC, the US Tour, the Cable Parity Fixture and Vape! are all pale. **Not a rendering bug and not "the defaults table is wrong" — a second palette.** METHODS-PALETTE; the v1 source is read before anything is written, because pale may be the original.

**THE ROADMAP REWRITTEN AT DANIEL'S INSTRUCTION — v4.38, 32,355 characters against v4.37's 59,988, cap ratcheted 60,000 → 40,000.** Seventy-one rows consolidated into twenty-eight by bundling: the nine queued layouts into BATCH-LAYOUTS, the box residuals into BATCH-BOX, the export family into EXPORT-INTEGRITY, field-contract leg 3 and its dependants into FIELD-CONTRACT-3, the harness rows into BATCH-HARNESS, the pre-public security items into SECURITY-PREPUBLIC, the registry legs into REGISTRY-REST, and the legal items into LEGAL. **AUTH-POLISH was split along its real seam** — it had been half auth copy and half equipment-list fixes with nothing to do with auth; the equipment half is now BATCH-COHORT-1, pulled forward on Daniel's word. No row dropped, only merged.

**Arch errors this session:** CP3's remedy chosen without measuring the ground the links sit on, bounced by CC · a pointer written with a fill-in-the-blank, which cost CP4 an entire cycle · ⏭ NEXT item 1 written as "Land sharing", which Daniel read as a compound noun and asked what it meant — the third readability failure of the same class on record, and the cheapest one to have caught.

**Next action:** open by writing the BATCH-COHORT-1 handoff to CC; once Daniel confirms CC is working, spin off the APPLY-TIMEOUT parallel; apply migrations 65–69 only after CC returns.
