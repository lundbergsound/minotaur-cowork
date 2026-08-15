Follow the Strategy Prompt.

Minotaur v2. This session's subject is ACCOUNTS: twelve auth accounts exist on
production, four of them belong to third parties nobody invited, six are
consistent with automated signup, and the product has no Terms of Service, no
EULA and no beta terms. Arch surfaced it during the S4-3 leg 4 browser gate on
2026-08-15 and routed it here, per the Architecture Prompt's rule that decisions
with business or legal implications beyond engineering are deferred to this
tier. Arch has ruled nothing about it and will not.

READ FIRST, in order:
Strategy Prompt v14 — governing.
Product Brief v1.1 (WHOLE) — §IP & Legal Status and §Beta Strategy are the load-bearing sections here.
Roadmap v3.11 — Current Status + the docket rows LEGAL-SEP · R8-DRILL · SHARE · AUTH-DOMAIN · COMMS-Q · TOK-VC.
Minotaur_v2_Session_Log.md — entry 9 is the last completed session.

PRE-OPEN: click Sync now before reading, so the GitHub-synced copies are
current. Note the log position: it stood at 9 entries when this opener was
written, with the Arch leg-4 close package still uninstalled. If that close has
been installed before this session opens, the log reads 10 and ROLLOVER IS DUE —
run it before any work. If it has not, this session's own entry brings it to 10.
Either way, only one tier writes the Session Log and Roadmap per cycle; if the
Arch close is still pending when this session ends, hold this session's document
updates and tell Daniel to merge them after Arch's close is installed rather than
writing over it.

FACTS OF RECORD — all measured against the production database on 2026-08-15,
not inferred. Take these as given; they are not open questions.

Twelve accounts exist. Two are Daniel's: his own, and `daniel+pt@` — the
visual-harness account, which owns the Visual Gate Fixture and fourteen
throwaway test projects. Neither is at issue.

Six are consistent with automated signup — Gmail addresses using the dot-alias
pattern, arriving one every four to seven days from 17 July to 5 August. NONE
confirmed their email, NONE ever signed in, NONE created anything. They are
inert rows. The control that stopped them is email confirmation, which is on and
working.

Four are real people, all of whom Daniel knows personally, none of whom
mentioned signing up to him:

- `abrion@pace.edu` — 31 July. Confirmed in 20 seconds, created a project 40 seconds later, left. Zero equipment items. About one minute in the product. Pace University is on the Brief's university beta-cohort list.
- `josh.jpr@gmail.com` — 11 August. Confirmed in 15 seconds, gone 6 seconds later, never created a project at all.
- `soundcooper@gmail.com` — 13 August, 10:58pm ET. Two projects; entered 4 equipment items and 1 library item.
- `jhaggerty97@me.com` — 14 August, 7:02pm ET. Took 15 minutes to find the confirmation email, came back, entered 3 equipment items and 2 library items.

Nobody imported a v1 file. Nobody created a revision. Nobody printed anything.
Combined third-party use of the product is roughly twenty minutes. There is
almost no user data in the system to be liable for — which is the good news and
also the whole of the sample.

One further fact, because it bears on liability framing: a live data-loss path
in the v1 mirror importer (docket IMP-SPINE — an unfiltered delete that would
have taken cable, tail and box rows on any mirror run) was open in this same
production database until it was fixed on 15 August. It was never triggered, and
no third party had the means to trigger it. It is stated here so the legal
question is asked against the real risk profile rather than a flattering one.

FIRST ACTIONS — six questions, in this order. Arch's position is given where
Arch has one, clearly marked, and is advice to be attacked, not a decision.

1. CLOSE PUBLIC SIGNUP — yes or no, and what replaces it. Arch's position: yes,
   and it costs nothing today, because nobody needs to self-serve an account
   except Daniel. The mechanism is a Supabase project setting, not code and not
   schema, so it is Daniel's to flip. The strategic question is what the door
   becomes: closed with no path in, closed with an invite path, or closed with a
   waitlist that feeds the beta cohorts the Brief already names.

2. DOES SELF-SERVED THIRD-PARTY USE CHANGE THE ATTORNEY TRIGGER? The Brief sets
   the trigger at "before first paid commercial user" and holds that beta with
   friends and colleagues, structured as informal testing, does not require it.
   These four were not structured as anything. They walked through a public form
   and put data in a production database governed by no terms. Rule whether that
   changes the timing or the scope of LEGAL-SEP, and whether anything is owed to
   those four now — a note, an offer to delete their data, or nothing.

3. IS THERE ALREADY A QUIET COHORT, AND SHOULD IT BE FORMALIZED? Four people
   found the product without being told. One is at a university already on the
   recruitment list. The Brief's beta strategy assumes recruitment is something
   Daniel initiates; this is evidence it has partly started without him. Decide
   whether to convert these four into named beta candidates or to close the door
   on them with everyone else.

4. WHAT DOES THE NON-RETURN MEAN, AND IS IT WORTH ASKING? Four people, sessions
   of a minute or less except one, no return visits, no word to Daniel. That is
   either idle curiosity or a product that lost them in under a minute, and the
   two have very different implications. The cost of finding out is four text
   messages to people he already knows. Decide whether that is a now action or
   an after-the-announcement action, and whether it belongs to this tier or to
   Comms.

5. COMMS SEQUENCING (COMMS-Q). The Brief says to announce v2 to the v1 licence
   list now rather than at beta, to lock in fence-sitters. A closed door plus an
   announcement is coherent only if the announcement carries a way in. A closed
   door plus silence reads worse to a curious professional than an open signup
   form does. If question 1 closes the door, this needs sequencing before the
   October announcement, and the ruling passes down to Comms.

6. DOES THIS MOVE R8-DRILL? The backup restore drill has never run, and it is
   the one hard date on the board — before the September attorney engagement.
   Other people's data in the database raises the cost of an unproven restore.
   Confirm the date holds or move it in.

CROSS-PRODUCT (the Portfolio Context rule): if minotaur.app's signup form is
being found by crawlers, any comparable public surface on Elephant Scribe or
Arvo is exposed to the same traffic. Flag whether that warrants a check; do not
analyse those products here unless it does.

NOT FOR THIS SESSION — confirmed decisions, do not re-litigate:
- The beta gate (v1 import + Equipment List + Cable + Boxes + PDF output + v2-to-v1 export).
- The pricing model and tier structure.
- SHARE's four roles, ruled 12 August.
- Sprint 4's sequencing and the box-family leg order — Arch's lane.
- Whether the six automated accounts and the fourteen harness projects get deleted. Arch's recommendation of record is to clean them the week AFTER the R8 drill, so the cleanup doubles as a rehearsal rather than a risk taken before a restore has ever been proven. That is a sequencing call, not a strategic one.

ROUTE BACK TO ARCH, do not design here (Trigger A):
- Closing signup interacts with SHARE phase 1, which is ruled as in-app
  auto-accept invites. With public signup disabled, an invited collaborator
  without an account cannot self-create one through the front door. The two are
  reconcilable — an admin-issued invite path still works with signups closed —
  but it is a design input SHARE's build-prep must receive explicitly rather
  than discover. Rule the intent here; send the mechanism to Arch.

OWED BY DANIEL, unchanged and carried for the Docket Sweep: the R8 drill before
September, the one hard date · TOK-VC at private-beta start, rotating by ~8
November regardless · PARITY-PAIR whenever PRINT-REDO opens · COWORK-PORT and
WF1A-SUNSET at Sprint 4 close.
