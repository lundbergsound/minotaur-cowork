# PARALLEL OPENER — BETA TERMS, second start (LEGAL-SELFDRAFT, terms half)

*Written by the Cowork-Arch main line on 2026-09-13 under Architecture Prompt v37. Supersedes `260912-1410_beta-terms_OPENER.md`, which was written under v36; the chat it opened is abandoned and nothing from it is carried except the three files it produced. This session runs under the General Advisor Prompt, not the Architecture Prompt.*

---

## Paste this into the new chat

```
This is a parallel session for Minotaur v2. General_Advisor_Prompt_v6.md governs
how you work with me; Email_Prompt_v7.md and Writing_Prompt_v1.md take over
when the work turns into a message or a document, as the advisor prompt says.
Read those three first.

Then read the opener, handoffs/parallel/260913-1016_beta-terms_OPENER.md, in
~/Developer/Minotaur-Cowork/, and follow it. Its "Settled" list is settled.

Start with its Task 0. One question at a time. Plain English, every message.
```

---

## Why this session exists

The private beta opens ≈2026-09-18: sixteen leads plus their teams, 30–40 people. My rule of 2026-08-15 is **terms before any third-party access**. The front door is live as of this morning (`57e0eec`, the account-setup and password-reset flow), the cohort has not been invited, and the terms are still a proposal. This session gets them adopted.

**What already exists, in project knowledge and in `drafts/`:** `BETA_TERMS_v0_1.md` (thirteen sections, plain English, every clause traced to the Legal Brief Addendum or marked new), `BETA_TERMS_v0_1_COVERAGE.md` (each Addendum requirement against the clause that discharges it, and what was left out and why), and `BETA_TERMS_v0_1_OPEN-QUESTIONS.md` (eight questions, each with the default the draft already takes). The named-user paragraph is already in §1. Do not redraft from scratch; work from v0.1.

**Read, in this order:** the three files above → `Minotaur_Legal_Brief_Addendum_2026-08-05.md` (§A–D is the spec; §F is the pre-terms accounts) → `R8_Standing_Posture_2026-08-27.md` (the measured backup window the terms cite) → `Minotaur_v2_Product_Brief_v1_2.md`, for what the product does.

---

## Task 0 — decide whether a Legal Prompt is needed

I have role prompts for strategy, architecture, comms, email and writing. Legal self-drafting has been running under the General Advisor and Writing prompts. Before touching the terms, decide whether that is enough for the three documents I am self-drafting (beta terms, the Daniel→LLC IP assignment, the privacy policy) and for the attorney review that follows (LEGAL-SEP, scoping the week of Oct 5).

Judge it on what the legal work needs that the existing prompts do not say: every clause traced to a spec or marked new; the Addendum's honesty constraint (never claim I cannot access data — say I don't, and name the three exceptions); "proposal until adopted, adopted is not in force until published where the reader sees it"; any statute or regime cited only after it is looked up (the advisor prompt already says this for published facts — the question is whether legal drafting needs it said harder); an attorney-packet format so the review is scoped rather than open-ended; and the standing reminder that none of this is legal advice.

**Where I lean, so you can correct it in one word:** the Writing Prompt plus the advisor's verification rule covers the drafting, and what is actually missing is a one-page *checklist*, not a fifth role prompt — a prompt that is only rules the other prompts already carry is how one prompt became 27,000 characters last week. Argue against that if the evidence says otherwise. If a prompt is warranted, draft `Legal_Prompt_v1.md` as a proposal in the shape of the others (H1 matches filename, version note at top, under 8,000 characters) and stop for my yes before using it. If it is not, write the checklist into the RETURN and carry on.

## Task 1 — close the eight open questions and produce v0.2

Ask them one at a time, in the companion file's order, with the drafted default as the first option. Each answer changes a clause; make the change and move on. Then write:

- `BETA_TERMS_v0_2.md` — review copy: trace lines and the two RIDER notes kept, a version note at the top saying what changed from v0.1 and which question changed it.
- `BETA_TERMS_v0_2_PUBLISH.md` — the same text with the trace lines, riders and status block stripped, ready to publish. Two files, one text; say in the RETURN how you proved they match.
- The coverage table brought current as `BETA_TERMS_v0_2_COVERAGE.md`, one line per change.

## Task 2 — the acceptance gap, which is the real risk

§"What this is" says *"You accept these terms by clicking through them the first time you sign in."* **Nothing in the product does that.** Measured by the main line on 2026-09-13 at `57e0eec`: zero occurrences of any terms-acceptance surface, column or string anywhere in `src/`. The sentence describes a mechanism that does not exist, and if the terms are published with it, the first thing they say about themselves is false.

Your half is the legal question, and it is a real one: **for a private beta of 30–40 invited professionals, what is the least the product must do for the terms to bind?** The options on the table, from lightest to heaviest:

1. The invite email links to the published terms and says that setting your password accepts them; the set-password page carries one sentence and a link saying the same. Nothing stored.
2. Option 1 plus a record: the moment and version accepted, written when the password is set.
3. A click-through screen at first sign-in with a stored acceptance — what the sentence currently promises, and what Addendum §F proposed for the four pre-terms accounts.

Recommend one, with the case against the others in a paragraph each, and rewrite the acceptance sentence to match whatever you recommend. **Do not design the build.** The main line owns the mechanism as a Docket row (TERMS-ACCEPT) and decides with me what is built before Sept 18; you decide what the terms need to be true. If your answer is that option 1 does not bind and only option 3 does, say so plainly — that changes the build plan and I would rather know now.

The four pre-terms accounts (Addendum §F) are part of this question: whichever option you recommend must also attach the terms to them.

## Task 3 — start the attorney packet, do not write it

LEGAL-SEP is an attorney review before v2 charges anyone. Produce a one-page list of what the packet must contain, one line each, so the October scoping call is scoped: the three self-drafted documents; the §F disclosure of record (the v1-import defect, fixed 2026-08-15, never triggered, unreachable by third parties); the two technical riders (the Project Version retention window, and `equipment_list_revisions`, which grows on every revision print and has no retention rule — 56 rows / 1.66 MB stored, measured 2026-09-11); the privacy-regime scoping question from §D; NY GBL § 527-a on the subscription agreement (look it up, do not recall it); the webfont licence; the security-review framing. Anything you add, mark as yours.

---

## Settled — do not re-litigate

- Beta terms gate the **private** beta. Terms before any third-party access, paid or unpaid (Daniel, 2026-08-15).
- I self-draft; the attorney engagement is a review before v2 charges anyone. This is not a request for an attorney-grade instrument.
- Pricing in the terms is the ruling of 2026-09-12: Individual $199/year; Production $349 NfP / $599 Commercial, perpetual per project; no monthly, no free viewing, students free; the v1 transition as v0.1 §8 states it. Open question 1 asks only whether the figures appear in the terms, not what they are.
- The named-user rule is in (§1). SEAT-CAP — one active editing session — is ruled policy, not built, and stays out of the terms.
- No invention-assignment agreement was ever signed; the IP position rests on my own representation, and §10's "me and my company" is written to be true either way.
- MAILGATE: nothing sends email to any address that is not mine without my standalone approval. Drafting an invite sentence is fine; sending anything is not.
- The two riders are named, not solved. The retention questions go to the attorney packet.

## Boundaries — what this session may not do

No CC handoffs · no migrations, schema or code · no edits to the Roadmap, Ledger, Session Log, Product Brief, `CLAUDE.md` or any role prompt · no installs to project knowledge (the main line installs, retiring the superseded version in the same step) · no mail, no calendar changes, nothing that acts outside the chat without my per-action yes. Write only under `handoffs/parallel/` and `drafts/`.

## Return

`handoffs/parallel/260913-<hhmm>_beta-terms_RETURN.md`, with `<hhmm>` as my Mac's clock reads it when you write, plus the v0.2 files beside it and copies in `drafts/`. The RETURN carries, in this order: the Task 0 decision in three sentences; the eight answers as a table; the Task 2 recommendation and the rewritten acceptance sentence; the Task 3 list; anything you found that the main line should register, one line each.

⚠ **Everything produced is a proposal until I adopt it.** Adopted is not in force. In force means published where every cohort member sees it before they get an account — and that is exactly what Task 2 decides.
