# Queued behind the CDMX sprint — two items (Daniel, 2026-09-06)

Registered while CC ran CAT-ADMIN. **Both are PINS behind CDMX-SEQUENCE** and
neither is to be opened before CAT-ADMIN → CAT-NOTE's print half →
EQUIP-LIST-PARITY are finished. Recorded here so the close package cannot lose
them; they belong in the Roadmap Docket at install.

---

## 1 · CLAUDEMD-OVERSIZE — `CLAUDE.md` is 1,887 characters over the limit

**Measured at source 2026-09-06 (not transcribed from CC's warning):**

- **151,887 characters** · 153,463 bytes · 2,264 lines. **Over the 150,000 limit by 1,887.**
- CC's warning quoted 151.9k, which matches.

**Where the cut lands, and it is the worst 1,887 characters in the file.**
Character 150,000 falls *mid-sentence* inside the Return Handoff File
Protocol's commit-block rules — at `…FENCE-PUSH, 2026-08-30, Daniel's ruling —
both layers permit the bare form…`. Everything past it is:

- the rest of the FENCE-PUSH commit-block rules — **that a commit IS a
  production DEPLOY**, that only the bare `git push` is permitted, and that a
  half-working push is reported plainly rather than retried in another shape;
- the gate-first discipline rule (checks and commits never share a paste);
- the rule that the `git add` list must exactly match FILES CHANGED;
- **RETURN-ON-CONTROL's "ONE FILE PER UNIT, APPENDED"** rule entire;
- the hard-stop reporting reminder.

⚠ **Whether the limit truncates or only warns is NOT measured from this seat.**
If it truncates, CC loses precisely the rules governing the commit, the push
and the return file — the last three things it does in a unit, and the ones
with production consequences.

**Mitigation already standing for the live unit:** the CAT-ADMIN handoff
(`to-cc/260906-0748_cat-admin.md`) restates the commit block at §6 and the
return protocol at §7 in full, per Arch v34's *a pointer is not a list*. So
CAT-ADMIN is covered whatever the limit does. **The next handoff written
without that restatement would not be.**

**Section sizes, measured — the remedy is visible in them:**

| section | chars | share |
|---|---:|---:|
| CC Operating Contract | 33,164 | 22% |
| Reference material (pointer) | 1,654 | 1% |
| Visual-Capture Harness | 27,136 | 18% |
| Project state — durable truth | 39,083 | 26% |
| **Current run fence** | **42,046** | **28%** |
| Guarded Architectures Index (pointer) | 1,918 | 1% |
| Return Handoff File Protocol | 6,886 | 5% |

⚠ **The run fence is 42,046 characters — 28% of the file — and it is the
section that is supposed to describe only the CURRENT unit.** It has accreted
rather than been replaced. FENCE-STALE and FENCE-COUNTS are both symptoms of
the same section; this is the third.

**Shape of the fix (proposal, not a decision):** the fence carries one unit,
not a history — retired fences go to the Ledger. The two pointer sections show
the precedent already works: the Guarded Architectures Index was relocated to
`docs/reference/` on 2026-08-09 and left a 1,918-char pointer behind.

⚠ **CC's suggested remedy — `/import-memory` — is the wrong tool.** That skill
imports memory from another AI assistant; it has nothing to do with a
`CLAUDE.md` over its size limit. Do not run it for this.

---

## 2 · ROADMAP-REFACTOR — restructure the Roadmap (Daniel, 2026-09-06)

Daniel's ask, queued behind the CDMX sprint. Three observations from reading
v4.19 **whole** on 2026-09-06, offered as evidence for scoping — not as a
design:

1. **The file does not obey its own header.** It reads *"Forward-only file —
   history lives in `Minotaur_v2_Ledger_v1_0.md`"*, and then carries closed
   items inline as `~~strikethrough~~` rows in both the DATED and EVENT docket
   tables. Those rows are history and are a large share of the bulk.
2. **A superseded duplicate is live inside the Docket.** APPLY-TIMEOUT appears
   twice — once as a DATED row carrying the live confirmation, and once as an
   EVENT row explicitly marked *"SUPERSEDED by the DATED row above."* A
   superseded copy sitting in a live docket is the exact shape that has
   produced wrong claims on this project before.
3. **The live set is hard to see.** The Sprint Plan's three-table split
   (NEXT / PINNED / SHIPPED) works and is recent; the single unified Docket
   below it does not have the same discipline.

**Not in scope for the refactor unless Daniel says so:** the 🧭 Next Sessions
block, which is bounded by RM-6 at six bullets and is working.

---

*Written 2026-09-06 by the Cowork-Arch main line while CAT-ADMIN was in flight
with CC. Nothing in this file has been installed. Both items are proposals for
the close package's Docket.*
