# RETURN — STRAT: the first day of the beta, and two parallels spun up

*Parallel Strat session, Cowork, 2026-09-20, written 13:29 ET under Strategy Prompt v16, model
`claude-opus-5`. **No governing-document edit, no CC handoff, no repo access, no migration, no mail.**
Every database call was a SELECT. The main line installs what follows.*

*⚠ Recovered into the repo by the main line at 2026-09-20 14:05 ET, from the copy in project knowledge.
The session's own "Files this session wrote" says it wrote this file to `handoffs/parallel/` and
`drafts/`; **neither existed on disk.** The bytes below are project knowledge's, unaltered.*

## For Daniel

- One ruling this session: **the v1-holder beta waits for the two-person bar, not for 2026-10-15.**
- Two parallels are open: **terms and privacy policy** (Strat) and **licence management** (Arch).
  Their returns go to the main line, not to this chat.
- **Still yours, and unchanged since yesterday:** your word on the import-too-big message.

## 1 · Rulings — Daniel, 2026-09-20

- **BETA-BAR, new.** *"I think at least two people touching every feature of the beta for a real
  production would be good. not necessarily the same two people, but, two people have run a shop prep
  print cables and boxes, two people have made revised equipment lists."* This is the test the
  v1-holder beta opening waits on.
- **The date waits for the bar.** *"for now, the date waits for the two person bar, though I may
  change that."* The mid-October target in the Sequence and in beta terms §7 becomes a forecast, not
  a gate. He may revisit it.
- **The Google redirect links in the 16 invites: leave them.** No follow-up note to the cohort.
- **Two parallels authorised:** a Strat session for beta terms v1.1 and the privacy policy, and an
  Arch session for the licence-management surface. Openers written this session and pasted by him.

## 2 · Live readings — SELECT only, 2026-09-20

Read against `auth.users`, `public.projects`, `public.equipment_items` and the `registry` schema.

- **Sign-ins since the invites went out (14:35 ET on 09-19):** Joseph Haggerty, Ryan Cooper, Andrew
  Poppleton, Thomas Ford. 12 of 27 accounts have ever signed in.
- **The password emails are arriving.** Poppleton's and Ford's accounts were created on 09-19, so
  both set a password from a reset mail sent that day. **This retires yesterday's worry that
  Porkbun's unknown sending limit would hold the set-password mail.** Four data points, not a load
  test; if a member reports no mail, the limit is still the first thing to check.
- **Andrew Poppleton created a project, "Doubtfire", at 22:01 ET on 09-19. It holds zero equipment
  rows.** Either he has not imported yet, or an import failed — the import is one transaction, so a
  failure leaves nothing behind, and the two look identical from here. Worth a light note to him if
  it is still empty in a day or two. **Not investigated further; no other cohort project exists.**
- **The registry is empty, as designed:** `people`, `licenses`, `v1_serials`, `v1_machines`,
  `cohorts`, `cohort_members`, `admins` and the rest all read 0 rows. `v_project_metadata` 19,
  `v_waitlist` 3.
- **Negative finding, hedged:** `auth.audit_log_entries` returned nothing for the period after the
  invites, so **there is no evidence either way about how many people requested a set-password
  email.** That is one query against one table; it most likely means the audit log is off or pruned,
  not that nobody asked.

## 3 · Proposed, not ruled

1. **The import-too-big message is still owed and now applies to live users.** The proposal is
   unchanged from yesterday's invite-ready return §3, and Daniel has still not ruled on it:

   > This show is too big for Minotaur to import in one go. The import ran for 90 seconds and
   > stopped. Nothing has been imported, and nothing in your show has changed. Please email
   > info@minotaur.app and we'll get it in for you.

   Until it is ruled, an over-size import shows the database's own text, *"canceling statement due to
   statement timeout"*, to a cohort member.

2. **Two import fixes proposed for the next print handoff.** IMPORT-TRAILSPACE (a cable name ending
   in a space loses its tails; 13 on JOY) and the message above. **This is not a challenge to the
   2026-09-18 build-priority ruling** — paper first, cable split after. The new fact is that 23 people
   outside Daniel now hold the import path, and both items are small enough to ride an existing
   bundle. CABLE-SPLIT stays where it is ruled unless a cohort member hits it.

3. **How the bar gets measured.** Imports, revised equipment lists and shares can be read from the
   database. **Cable and box print runs are not recorded anywhere**, so those legs of the bar have to
   be asked about. Arch to say whether any print leaves a trace before anyone assumes it does.

## 4 · Roadmap changes proposed

The main line places these; Arch may reorder freely.

- **New row — BETA-BAR.** *What it is:* the v1-holder beta opens when two people have run each core
  workflow on a real production — a shop prep printing cables and boxes, a revised equipment list, an
  import, an export back to v1, a shared project. Not necessarily the same two people. *Who · what it
  needs:* **Daniel** · the list of workflows is his; some legs are measurable from the database and
  some must be asked.
- **The Sequence, mid-October line.** Replace the date as gate: *"The beta opens to v1 owners when
  the two-person bar is met (BETA-BAR) — mid-October is the forecast, not the gate."*
- **LEGAL splits in two.** The privacy policy becomes its own unit, which is what Daniel asked for on
  2026-09-13 and has not happened; LEGAL keeps the IP assignment, the attorney packet and the
  60-day window. The Strat parallel supplies both rows' text in its return.
- **New row — TERMS-V1_1.** The live terms (Version 1.0, `src/lib/legal/betaTerms.ts:33`) say *"My
  invitation links to them"*, which Daniel's 09-19 ruling made false. ⚠ **Terms §11 commits him, on
  any change, to emailing every account and showing the change at next sign-in — and no sign-in
  notice exists.** Whether v1.1 triggers §11 is his ruling, in the terms parallel; if it does, the
  email is a MAILGATE send and the notice is a build item. Carried by the Strat parallel.
- **REGISTRY-REST is superseded** by the Arch parallel's licence-management unit (admin screen,
  V1-ISSUE, migration 65 import, cohort seeding, then BETA-SIGNUP-GATE). **V1-ISSUE has dropped out
  of the Roadmap's text since v4.35 and should be named again.** Rows come from that parallel's
  return; the main line should wait for them rather than writing its own.
- **STRAT-OWED, unchanged and now overdue:** the Brief's next version carrying $199 and the corrected
  competitor benchmark; the Comms prompt rewrite; the eight unreachable v1 holders and the missing
  Square export; the Vercel token rotation, hard at about 2026-11-08.

**Already owed from 2026-09-19 and not duplicated here:** COHORT-ACCOUNTS' account half is done and
its names half is open; BETA-INVITE is done but for the one-page brief question; the Roadmap's NOW
and NEXT still say "thirteen accounts". Those live in `260919-1500_invite-ready_RETURN.md`.

## 5 · Session Log entry — verbatim

### September 20, 2026 — Cowork-Strat, PARALLEL (**the cohort's first day** · **BETA-BAR ruled: the v1-holder beta waits on a two-person test, not a date** · **two parallels opened: terms/privacy and licence management** · model `claude-opus-5`)

**Decisions (Daniel's).** **BETA-BAR** — *"two people touching every feature of the beta for a real
production … two people have run a shop prep print cables and boxes, two people have made revised
equipment lists"*; **the date waits for the bar** (*"though I may change that"*); the Google redirect
links in the 16 invites are left alone; a **Strat parallel** for beta terms v1.1 and the privacy
policy, and an **Arch parallel** for the licence-management surface, both opened with openers written
this session.

**Work.** Big-picture read of the Roadmap, the Session Log and yesterday's invite-ready return. Live
SELECTs: four cohort sign-ins since the invites (Haggerty, Cooper, Poppleton, Ford); the set-password
mail is getting through, which retires the Porkbun sending-limit worry; Poppleton's project
"Doubtfire" exists with zero equipment rows; the registry's tables all read 0. Two openers written.
No document written, no mail, no code.

**Owed by Daniel, unchanged:** the import-too-big message.

**Next action.** Main line: keep the print work moving; install the registry return first, then the
legal return, then this one.

## 6 · Install order for the main line

1. The **Arch licence-management return** — it carries a CC handoff and a migration, so it is the
   time-sensitive one.
2. The **Strat terms/privacy return** — documents, Roadmap rows and attorney-packet lines.
3. **This return** — Roadmap rows and the Session Log entry only.

Do not begin installing any of them mid-handoff; the print work holds the main line until CC is
clear.

## Files this session wrote

- `handoffs/parallel/260920-1329_strat-bigpicture_RETURN.md` and a `drafts/` copy (this file).
- The two openers were delivered in chat and pasted by Daniel; no file.
- Nothing else. No memory of this session lives anywhere but this file.

---

## Main line's amendment, 2026-09-20 14:05 ET (Arch)

1. **§3.1 and §5's "owed by Daniel" are STALE.** Daniel ruled the import-too-big message on
   2026-09-19 (*"message for too big import approved"*), and it **shipped today in `1982063`**
   (PALETTE-V1-HUES, CP3): SQLSTATE `57014` now shows his wording verbatim, on both of Apply's
   failure arms, and every other error still prints the database's own text. Nothing is owed there.
2. **§3.2's IMPORT-TRAILSPACE is closed on the name-lookup half.** Migration 82
   (`20260919193946_import_apply_v1_trim_name_lookups`) shipped 2026-09-19: every name lookup in
   `import_apply_v1` now trims the stored side. A fresh JOY import came in with 636 mult lines
   against the old copy's 603, and 5 parentless tails against 13. What is left on that row:
   `cPreview`, and the Sand/Chartreuse end colours.
3. **§3.3 — whether a print leaves a trace, answered:** no. No print writes a row. The database
   records imports, revisions, shares and exports, so those legs of BETA-BAR are measurable; the
   cable and box print legs have to be asked.
