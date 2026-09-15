# 📝 SESSION LOG — Minotaur v2

Append-only chronological record. Each entry: date, chat type, model, decisions, work, next action. Prior entries are immutable. Every delivery is the complete live file. The header is six fields, under 4,000 characters; anything that must outlive a session and is not one of those six goes to the Ledger or a Docket row, never here.

## STATE OF PLAY
- **Shipped:** v2 is live at `https://minotaur.app` at **`3b98ce9`**. The front door is COMPLETE: the beta terms are in force, custom SMTP (Porkbun, `smtp.porkbun.com:587`) sends as `info@minotaur.app` under the name **Minotaur**, and the typed recovery code reaches the auth host for the first time on this project. **Jamie Tippett and Mike Tracey are in — the first two people outside this office ever to use v2.** Version history except the fork; the model Change All in two writes. Migration ledger 64. Suite 3,312 / 170, frozen 3/3, visual 28/28, no baseline event. `CLAUDE.md` 109,892 characters.
- **In flight:** nothing is building. SHARING REV-B is designed and rehearsed, nothing applied; five migrations (65–69) wait on Daniel's confirm. ⚠ **Nothing but `owner` enters `project_members` until 66 is applied.** The Sept 18 gate now reads: SHARE-MIGRATIONS · SHARE-ROSTER · BATCH-COHORT-1 · AUTH-POLISH · APPLY-TIMEOUT · the fourteen remaining accounts · the invite.
- **Next action:** open the next Arch session by writing the **BATCH-COHORT-1** handoff to CC; once Daniel confirms CC is working, spin off the **APPLY-TIMEOUT** parallel; apply 65–69 only after CC returns.
- **Open decisions:** which methods palette is v1's (METHODS-PALETTE) · CABLEDEL-FAILMSG's wording · YES or KEEP on the sign-in placeholders · whether first and last name become separate columns and whether `registry.people` owns them · `Versioning Test` keep or delete.
- **Current log:** 2 entries
- **Rollover:** clear. Rolled over 2026-09-15: entries one through eight archived to `session-log-archives/Session_Log_Archive_2026-09-15.md`; the newest two kept.

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
