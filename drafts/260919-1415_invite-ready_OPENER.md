# PARALLEL OPENER — INVITE-READY: get the rest of the private-beta cohort in

*Written 2026-09-19 14:15 ET by the Cowork-Arch main line, under **Architecture Prompt v39**, while CC runs
PRINT-REPARITY-LABELS. This is a **parallel session**: one named scope, no CC handoff, no schema change, no
governing-document edit. The main line installs whatever this session returns.*

## Read first

1. `Architecture_Prompt_v39.md`, then the **Docket rows only**:
   - COHORT-ACCOUNTS
   - BETA-INVITE
   - TERMS-GATE
   - IMPORT-REMEASURE
   - LEGAL
   - MAILGATE

   All six are in `Minotaur_v2_Roadmap_v4_47.md`.
2. `drafts/260913-1336_terms-acceptance-copy.md`: the approved invite fragment and the set-password
   sentence. **This is approved copy. Quote it; don't rewrite it.**
3. `drafts/260917-1220_cohort-state_FINDINGS.md`: the last live read of who exists (it is two days old).
4. `drafts/260917-1105_cohort-addition_AARON-HANNA.md`
5. `drafts/260911-1350_strat-beta-plan_RETURN.md`, for who the cohort is.
6. For the wording in step 3, also read `Comms_Prompt_v9.md` and `Email_Prompt_v7.md` (project
   knowledge). **User-facing copy is Comms' lane, not Arch's.** This session writes the invite under
   those prompts' rules, and Daniel approves every word.

## Where things stand. Read live at 14:10 ET on 2026-09-19; re-read before you rely on it.

- **The invite cannot go out yet. Two things are still Daniel's:**
  - the thirteen accounts and their real names;
  - the invite note and the one-page brief.
- **No new cohort account was created after the 2026-09-18 close.** `auth.users` holds **12** logins,
  the newest dated 2026-09-18 19:30 UTC. Most of the 12 are Daniel's own, test or support logins.
  `terms_acceptances` holds 7 rows.
- **`registry.cohort_members` holds 0 rows.** Establish whether that is by design (REGISTRY-1 may never
  have been seeded) before anyone treats it as a gap. It is a read, not a write.
- **Everything else on the private-beta gate is done:** terms in force, front door, mail sender, sharing,
  typeface, import time limit, speed changes, method colours, support login.
- **Two known open states** (ruled 2026-09-17, "logged, not chased"):
  - Mike Tracey has used the app with no recorded terms acceptance.
  - Jason Crystal had no `profiles` row at the last read. **Re-check both.**

## The scope, in order

1. **Live read (SELECT only).** List every cohort member with:
   - whether their account exists;
   - whether they have a `profiles` row;
   - whether they have a terms acceptance.

   Give Daniel the result as one plain table: who is ready, who is missing, and what each is missing.
2. **Walk Daniel through creating the accounts.** He creates them in the Supabase dashboard (a
   password is required: set any, and the member uses "forgot password", which is what records their
   terms acceptance). **Neither this session nor CC creates accounts or sends mail.** After each batch,
   re-read to confirm the account got its `profiles` row. If one didn't, that is the
   `handle_new_user` question from the 09-17 findings: name it and send it to the main line.
3. **Draft the invite note and the one-page brief** for Daniel to approve. Content is ruled (BETA-INVITE):
   - the two ruled sentences;
   - the three-step sign-in (go to minotaur.app → "forgot password" → set your own);
   - the approved terms fragment and link;
   - one line on the shared library;
   - **no confidentiality ask** (ruled 2026-09-13: the beta may be talked about freely).

   Ask Daniel sharply for anything the Docket row does not settle. **Quote every drafted paragraph in
   full when asking for a ruling.** He does not rule on paraphrases. **If you cannot find the text of
   the two ruled sentences at source, say so. Don't reconstruct them.**
4. **Draft the one other piece owed before the invite:** the message an operator sees when an import is
   too big even for ninety seconds (IMPORT-REMEASURE). Offer it as a proposal for his wording.
5. **Plan the send, don't send.**
   - Batches, not one blast: Porkbun publishes no sending limit.
   - Jamie Tippett and Mike Tracey already have accounts. Who is in the first batch is Daniel's call;
     ask it as one question.
   - **MAILGATE:** each send is approved by Daniel in a message that contains only that approval.

## Out of scope

- Any schema or code change.
- The TERMS-GATE build.
- The bug-report form.
- LEGAL drafting.
- Roadmap or Ledger edits.
- If a real defect turns up, write it as a finding for the main line. Don't fix it.

## Return

- Write `handoffs/parallel/260919-HHMM_invite-ready_RETURN.md` (HHMM is the time you write it) and put a
  copy in `drafts/`.
- Contents, top to bottom:
  - a plain block for Daniel;
  - the readiness table;
  - the approved (or pending) invite note and brief, verbatim;
  - the import-too-big wording;
  - the send plan;
  - findings for the main line;
  - every ruling Daniel gave, quoted.

## For Daniel

This session gets the rest of the cohort in. Here is what it does, in order:

- It checks who already has an account.
- It walks you through making the missing ones: you click, it checks.
- It drafts the invite and the one-page brief from what you've already approved, for your yes or no.
- It plans the send in small batches.

**It sends nothing. Every email goes out only on your separate yes.**
