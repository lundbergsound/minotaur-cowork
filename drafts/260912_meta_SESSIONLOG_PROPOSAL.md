# PROPOSAL — the structural three: an unbounded header, archives nobody may read, and the register

*Written 2026-09-12 by the META parallel (Cowork-Arch). Members 13, 14 and 15 — the three found at the 2026-09-11 close. They are one mechanism and are proposed together. Proposal only; the main line installs.*

---

## Plain English, first

**The Session Log's header is half the file.** 102 bullets, 70,554 characters, 11,207 words — **50.0% of a 140,996-character document.** Mean bullet 690 characters; the longest 2,205. The opener estimated ~95 bullets; measured, it is 102.

**And it is not the header the Architecture Prompt mandates.** v35 specifies six fields — `Shipped` · `In flight` · `Next action` · `Open decisions` · `Current log` · `Rollover` — and calls the shape *"identical across all tiers."* Measured: **none of the six appears in the mandated form.** Two survive in bold (`**Current log:** 8 entries`, `**Rollover:** CLEAR`); `Shipped`, `In flight`, `Next action` and `Open decisions` do not exist as fields at all. Their content is dispersed through 100 free-form bullets. **So the header has no bound because the template that bounded it was abandoned** — the six fields *were* the bound, and nothing replaced them.

**The reason it swelled is the second finding, and it is a policy, not an accident.** Rollover archives entries, and the Architecture Prompt says archives are *"write-once and never read by working sessions."* Measured: **six archives, 425,675 characters, none of it readable by any working session by rule.** So the only place a finding survives is the header. **Every incentive in the system pushes material into the one container with no bound.** Members 13 and 14 are not two problems; 14 is the cause and 13 is the symptom.

**And member 15 is what that does to the writing.** The corpus Arch reads at open is **316,582 characters** (Architecture Prompt 27,355 + Roadmap 116,471 + Session Log 140,996 + Brief 31,760), of which the part written in Daniel's register — ▶ NOW plus ⏭ NEXT — is **1,847 characters. 0.58%.** A seat that reads 316,582 characters of dense internal register and then writes one message to Daniel will write in the register it has been reading. That is not a discipline failure; it is the predictable output of the ratio. Three writing failures in one close, one cause, and the cause is measurable.

---

## What was measured

| Object | Measurement |
|---|---|
| `Minotaur_v2_Session_Log.md` | 140,996 characters · 22,230 words · 347 lines · 8 entries |
| STATE OF PLAY header (lines 5–108) | **70,554 characters · 11,207 words · 102 bullets · 50.0% of the file** |
| Header bullet length | mean **690** characters; longest **2,205**; top five 2,205 / 1,506 / 1,432 / 1,411 / 1,296 |
| Mandated six fields present in the mandated form | **0 of 6** (`- Shipped:`, `- In flight:`, `- Next action:`, `- Open decisions:`, `- Current log:`, `- Rollover:`) |
| Fields present in any form | 2 of 6 — `**Current log:** 8 entries`, `**Rollover:** CLEAR — ran 2026-09-10, fires again at 10` |
| `session-log-archives/` | 6 files, **425,675 characters**, all tracked (2026-08-10, 08-15, 08-22, 08-27, 09-01, 09-10) |
| Archive readability by policy | **Never read by working sessions** (Architecture Prompt v35, O-10). Daniel must upload one for its contents to be usable |
| Arch's open corpus | **316,582 characters** across four documents |
| The part in Daniel's register (NOW + NEXT) | **1,847 characters — 0.58%** |
| Rollover status | 8 entries; fires at 10. **Not due**, and the header says so correctly |

⚠ **One thing the header gets right and should not be lost in a rewrite:** its last two bullets are the only correctly-shaped fields in the file, and `Rollover` carries its own arithmetic (*"ran 2026-09-10, fires again at 10"*). That is the pattern the other four should follow.

---

## PROPOSAL 1 — restore the six fields, and bound them

**For the Architecture Prompt's Session Log discipline section**, replacing the header template with a bounded version:

```
## STATE OF PLAY
- Shipped: <what exists and is live>
- In flight: <what is currently being built or decided>
- Next action: <the single next concrete step>
- Open decisions: <unresolved questions, or "none">
- Current log: <N> entries
- Rollover: <"clear — ran YYYY-MM-DD, fires again at 10" or "⚠ DUE — run at next pre-open">
```

> **Bound, counted and not assumed: the header is SIX fields and ≤ 4,000 characters total.** Each of the first four is one paragraph, not a list of bullets; a field that will not fit is evidence that its material belongs in a durable findings file (PROPOSAL 2), not evidence that the header needs to grow. ⚠ **The reason, because a bare rule gets rationalised past: on 2026-09-12 the header measured 70,554 characters across 102 free-form bullets — 50% of the Session Log — and not one of the six mandated fields was present in the mandated form. The template was the bound; abandoning the template removed the bound, and nothing noticed for weeks because no close instruction counted it.**

**The migration is the hard part and it needs a destination.** 70,554 characters have to go somewhere before the header can be 4,000. ⚠ **That destination does not exist today, which is why PROPOSAL 2 has to land first.** Sequence: create the findings file → triage the 102 bullets into it → then rewrite the header to six fields. A header rewrite performed first deletes standing rules.

## PROPOSAL 2 — the missing document: a durable, readable findings file

**The gap, stated precisely:** the corpus has an append-only history nobody reads (the Ledger, read on citation only), archives nobody may read (write-once, never read), and a header everybody reads with no bound. **There is no bounded, readable, durable home for a standing fact.** So standing facts go to the header, and the header is what broke.

**Propose `Minotaur_v2_Standing_Facts.md`** in `Minotaur-Cowork`, tracked, and read at every open as a **fifth** source of truth:

- **What goes in it:** a fact that binds future sessions and is not a task — a measured corpus figure, a harness property, a rule and its reason, an invariant, a trap that will otherwise be re-derived. One line each, each dated and attributed, each carrying its reason because a bare rule gets rationalised past.
- **What does not:** anything in flight (Roadmap), anything that happened (Ledger), anything owed (Docket).
- **Bound: ≤ 20,000 characters, ratcheting down as facts expire.** A fact is removed only when it is proven no longer true, and its removal is a Ledger append.
- **Read order:** after the Roadmap, before the Session Log. It replaces the 100 free-form header bullets as the thing a session actually needs carried across.

⚠ **This is the one genuinely new document this pass proposes, and it should be resisted unless the measurement justifies it.** The measurement: 70,554 characters of material is currently surviving in the only container with no bound, because every properly-bounded container either forbids reading or forbids standing facts. A new document is the smaller change; the alternative is lifting the never-read rule on archives, which was ruled for good reasons (O-10).

## PROPOSAL 3 — fix the rollover's lossy half

**The rule today:** rollover archives the oldest 8 entries, and archives are never read. So a finding written into an entry dies at rollover unless someone lifted it to the header first. **Nothing checks that anyone did.**

**Propose, for the Architecture Prompt's rollover step (O-10), one added sub-step:**

> **Before the archive is delivered, every entry leaving the log is read for standing facts, and each one found is lifted into `Minotaur_v2_Standing_Facts.md` in the same step.** The rollover is not complete until that lift is done, and the archive's own header names the facts lifted out of it, so a later reader can tell the difference between *"nothing durable was in these eight entries"* and *"nobody looked."* ⚠ **The reason: archives are write-once and never read by working sessions, so a finding not lifted at rollover is not archived — it is deleted, with a copy kept where no session may look.**

⚠ **This is retrospective as well as forward-looking.** Six archives, 425,675 characters, went through rollover under the old rule. Whether anything durable is buried in them is unmeasured, and this seat is not proposing a sweep of all six — that is a real cost against a private beta in six days. **Propose one bounded check instead: the most recent archive only** (`Session_Log_Archive_2026-09-10.md`, 92,839 characters), read once for standing facts, at the first close after the invite. If it yields nothing, the earlier five are very unlikely to and the question closes. If it yields something, the cost of the sweep is then justified by evidence rather than by worry.

## PROPOSAL 4 — the register, and it is a routing rule rather than a style note

**For the Architecture Prompt's "Writing to Daniel" section:**

> ⚠ **The register problem, measured 2026-09-12: this seat reads 316,582 characters at open, of which 1,847 — 0.58% — are written in Daniel's register.** Writing in the register you have just read is the default behaviour, not a lapse, so it is guarded rather than resolved. **Before any message to Daniel longer than four sentences: draft it, then re-read it against one test — would a sharp professional who has not read the Roadmap follow this?** An identifier without a gloss, a row ID as a noun, a count with no unit, a sentence whose subject is a document: each is the corpus register leaking. **Rewrite, do not append a glossary.**

**And the concrete habit, which is what will actually work:** ⚠ **write Daniel's message before writing the close package, not after.** The measured failure mode is three writing failures in one close, all after a long session in the corpus. A message drafted first is drafted from the work rather than from the documentation of the work.

**What this pass will not propose:** a template for messages to Daniel. The Architecture Prompt already carries nine rules for writing to him and they are good rules; the failure was not a missing rule, it was 316,582 characters of priming against 1,847. A tenth rule does not change that ratio. ⚠ **PROPOSAL 1's bound and PROPOSAL 2's file are the real fix for member 15**, because they cut what the seat reads at open — a header at 4,000 characters instead of 70,554 removes 66,554 characters of dense internal register from every single open, which moves Daniel's share of the open corpus from 0.58% to **0.74%**. That is still small, and it is the honest number: the register problem is mitigated by the header bound and not solved by it.
