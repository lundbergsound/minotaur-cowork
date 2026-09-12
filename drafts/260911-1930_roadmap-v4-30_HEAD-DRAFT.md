# 🗺️ ROADMAP — Minotaur v2 (v4.30)

**Version 4.30 • September 11, 2026 • Retires v4.29 • Forward-only file — history lives in `Minotaur_v2_Ledger_v1_0.md`**

**FOUR SECTIONS, IN THIS ORDER AND NO OTHERS: ▶ NOW · ⏭ NEXT · 🏗 THE SEQUENCE · 📌 THE DOCKET.** ⚠ **The parallel Strat session's "§0 THE TRACK" is IN THIS FILE — folded into THE SEQUENCE, not added as a fifth section (Daniel, 2026-09-11).** A dated road of milestones and an ordered list of what to build are the same view at the same altitude; carrying both would have said the near-term work three times, counting ⏭ NEXT. **Nothing was added and nothing had to be removed to pay for it.** History does not appear in this file at all — the Lineage change-log, the SHIPPED table and the closed-session sections were deleted in v4.28 and are never recreated.

**⚠ THE FOUR SECTIONS ARE A GRANULARITY LADDER, and a section that drifts off its rung is the defect to fix (Daniel, 2026-09-11).** ▶ NOW is what is in flight. ⏭ NEXT is the next three sessions in plain language, plus what Daniel owes. **🏗 THE SEQUENCE is COARSE — dated, several units to a line, never one row per unit.** 📌 THE DOCKET is the granular and complete breakdown: every unit, its state, its trigger. **v4.30's first draft failed this — its SEQUENCE was a second Docket with a paragraph per row.**

**TWO BOUNDS, counted at this close and not assumed:**

1. **NOW + NEXT + THE SEQUENCE together are capped at 8,000 characters.** That is the part written for Daniel. This version stands at **{HEADCOUNT}**. Over the cap, prune — never accrete.
2. **The whole file is capped at 135,000 characters.** It stands at **{FILECOUNT}**. ⚠ **The cap RATCHETS DOWN as the Docket is pruned and never up.** ⚠ **DOCKET-STALEACTIVE's pass RAN at this close** — v4.29 was the second consecutive growing version, which this file itself named as the trigger to prune rather than to raise the cap.

**⚠ THE DRIVER IS NO LONGER A PRODUCTION. IT IS THE PRIVATE-BETA GATE (Daniel, 2026-09-11).** BVSC Mexico City met its deadline; its standing row is retired and the hold on non-CDMX work is over. **Sequencing now answers one question: does this serve the ≈Sept 18 invite?** ⚠ **Every citation of a project still names its id** — BVSC Mexico City is `cf780353-448d-4b15-a054-973f577b215c`, the US Tour is `57874c69-06b6-41b1-91d8-6a00e5255110` — and duplicate `projects.name` is never "fixed" by a uniqueness constraint.

---

## ▶ NOW

**Version history is real end to end and two production deploys carry it.** All twenty destructive commit points take a backup first and refuse the gesture if it fails (`c446326`), the History screen lists a production's Project Versions and names a manual one (`96efd11`), and the hourly timer has run unattended since 17:00 UTC on the 11th.

⚠ **What it cannot yet do is give a version back — "Open as new production" renders disabled, and the fork is a migration.** ⚠ **And the sharing surface is a gate item with no scoping, no design pass and no Docket row of its own**, for a cohort of sixteen leads *plus their teams*.

## ⏭ NEXT — the next three sessions

1. **Scope the sharing surface.** It gates the invite, nothing about it is settled, and it is Arch's before it is anyone's to build.
2. **Give a version back** — the fork migration, then the screen that calls it. ⚠ **Open proposal, Daniel's ruling: the fork may not need to make the invite.** The cohort's job is to import a show, print the paperwork and export it back to v1; a version they cannot yet restore is still a version, and a lost show can be restored by hand in the meantime. Deferring it buys back the largest build item in the gate.
3. **Make a full-size v1 show import on the first try, or say why** — APPLY-TIMEOUT.

**⚠ Yours, and the first is a hard gate you cannot ship past.**

- **Beta terms in force before a single outsider touches v2** — your own 2026-08-15 rule. Writing Prompt session, this week.
- **The invite note** and the one-page cohort brief; **CAND-4 folds in here**. Then tell the sixteen.
- **A cable label print on real stock**, and the 5167 sheet with it.
- **Start the LICDB parallel session** from its opener.
- **Carried:** the two postponed browser gates, the Tail Panel reprint, three ignore lines in the code repo.

---

## 🏗 THE SEQUENCE — the road, in order, and the order is the point

*Coarse by design: a line names several units at once. Individual units, their state and their gate membership live in THE DOCKET.*

- **≈2026-09-18 — PRIVATE BETA.** Sixteen leads plus their teams, 30–40 people. Closing the gate needs **the sharing surface**, **version history's fork**, and **APPLY-TIMEOUT** from this seat — plus four that are Daniel's: **beta terms in force**, the invite note, a cable label print on real stock, and the READY check. ⚠ **Terms before ANY third-party access, paid or unpaid (Daniel, 2026-08-15).**
- **The four weeks after — fix what the cohort finds.** **AUTH-RESETPAGE is the first unit after the invite**, not before it. **AUTH-REFRESH-HANG** and the **pre-beta friction pair** (CABLEDEL-LATENCY, INSPECTOR-ARM) in week one. **ENTITLE-V1** scoped and built.
- **Target 2026-10-15, floating — V1-HOLDER BETA.** Free with an active v1 license, gated on beta terms and ENTITLE-V1. **The announcement to the v1 list IS this drop — no tease.**
- **~November — LICENSING.** v2 checkout, and an attorney review of the subscription agreement **before the first charge** (LEGAL-SEP; scoping the week of Oct 5).
- **RELEASE — $149.** v1 included on request and none sold à la carte; v1 Personal holders free to the end of their year; v1 Production holders free during the beta, ~$100 after.
- **Stop condition unchanged: paid beta by ~March 2027.** Everything above lands before it.
- **Behind the road, released by trigger and not by date:** the two fail-open controls, FIELD-CONTRACT leg 3b, BATCH-HOUSEKEEPING and `duplicate_item_v1`. ⚠ **HELD under the 2026-09-11 rule that process findings do not outrank product work — and every HELD row now carries a named release trigger and a review date, so held never means forgotten.**

---
