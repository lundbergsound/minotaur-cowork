# For the Elephant Scribe Arch seat — why Minotaur's Roadmap rule is changing, and what it becomes

*Written from the Minotaur Cowork-Arch seat, 2026-09-11. Read this before adopting Minotaur's Roadmap shape, because the version you would have copied is the broken one.*

---

## What went wrong, and it is a prompt defect rather than a discipline one

Daniel gave the same note repeatedly for a fortnight: **the Roadmap is unreadable, and he cannot find out what is happening now.** Each time the seat fixed the summary block and the file re-bloated the following session. Measured this session rather than assumed:

- Roadmap v4.27 is **161,971 characters**, up from 12,454 three weeks earlier.
- The plain-English block he actually reads is **1,546 characters — one percent of the file.**
- Immediately below it sits a **22,728-character change-log of every past version (14%)**, inside a file whose own header reads *"Forward-only — history lives in the Ledger."* A further 7,862 characters of shipped-unit history sits below that.
- **To reach the ordered list of what happens next, he scrolled past 28,000 characters of history and status.**

**The mechanism: Architecture Prompt v34 bounds exactly one thing — six bullets on that one-percent block — and bounds nothing else.** Every other close instruction is an addition: append to the Ledger, update the Roadmap, write a recap line, carry a propagation list, add a Session Log entry. Nothing anywhere instructs the seat to remove. The two largest history sections are governed by no rule at all, so they gain a row every session, forever.

The file was growing exactly as written. The note kept landing on the seat; the defect was in the instructions.

## The new shape — four sections, in this order, and no others

1. **NOW** — the single unit in flight. Plain English, three sentences, hard cap.
2. **NEXT** — the next three sessions, one plain sentence each.
3. **THE SEQUENCE** — the ordered technical list. Identifiers and detail start here, not before.
4. **THE DOCKET** — open items.

**History never appears in the Roadmap.** The change-log and shipped-unit tables are deleted outright and never recreated.

Plus a **character cap on the whole file**, on the model of the one `CLAUDE.md` already carries: over the cap, the close prunes before it adds.

## Two deletions pay for it, because Daniel has ruled that additions must

⚠ **Standing rule (Daniel, 2026-09-11): no Architecture Prompt rewrites or additions without removals, unless there is a very good reason.** What comes out:

- **The end-of-session recap line.** A fact recorded only there died when the next Roadmap version replaced the line, and went missing from every live document for days before a search found it. A weekly-overwritten paragraph is not a record.
- **"Read the Roadmap WHOLE."** It sounds like diligence and it is the reason nothing ever forced the file to be short enough to read. ⚠ **It is only safe to delete alongside the size cap** — dropping the mandate without shrinking the file trades "too long to read" for "nobody has to read it," which is worse.

## ⚠ The one thing that does not port cleanly to Elephant Scribe

Minotaur's fix rests on *"history lives in the Ledger."* **Elephant Scribe was ruled (2026-09-08) to have no Ledger** — its governing set is Brief + Roadmap + Session Log.

So do not copy the rule as written; it would point at a document that does not exist, and the history would stay in the Roadmap by default. **In Elephant Scribe, the Session Log and its archives are where Roadmap history goes**, and the rule reads the same otherwise: the Roadmap carries what is happening now, what is next, the sequence, and the open items — and nothing that has already happened.

The Session Log's rollover already gives that a home with no new machinery: the log is append-only, and the archive is written at ten entries.
