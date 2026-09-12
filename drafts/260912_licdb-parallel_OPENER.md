# Parallel opener — LICDB, the v1 licensing database

Written 2026-09-12 08:41 EDT by the Cowork-Arch **main line**, which owns the close. Spun off **before** the main line's own work, per Daniel's 2026-09-12 ruling.

**Seat:** a **General Advisor** session with Gmail — not Arch, not CC. It reads mail and two spreadsheets and writes one workbook.

**Roadmap of record:** `Minotaur_v2_Roadmap_v4_31.md`. The row is **LICDB**, ▶ ACTIVE. It gates **ENTITLE-V1** and the **v1-holder beta** (target 2026-10-15, floating), not the private beta.

---

## Boundaries — these are what make a parallel safe

- **No CC handoffs.** This session issues none.
- **No migrations, no schema, no repo commits.** Daniel commits.
- **No edits to the Roadmap, the Ledger, the Session Log, the Brief or any prompt.** The main line owns every one of them; two sessions editing the Roadmap is the one way this pattern fails.
- **Writes only inside `reference/v1-licensing/`.** Nowhere else.
- **Reads only, in Gmail.** Never send, label, or modify mail.

## Not to be re-litigated — ruled and closed

- The **sixteen private-beta leads** are chosen (Strat, 2026-09-11). This session flags *additional* candidates; it does not re-rank the sixteen.
- **v1 Personal holders** get v2 for the rest of their year; **v1 Production holders** free during the beta, ~$100 after; **v2 Individual $149** at release. Pricing is Strat's and is settled.
- **v1-holder beta is gated on beta terms and ENTITLE-V1**, and the announcement to the v1 list **is** the drop — no tease.
- The **workbook shape below is ruled.** Four sheets plus the README section. Do not redesign it.

## Expected return

- The workbook at `reference/v1-licensing/v1_Licensing_Database_2026-09-DD.xlsx`.
- The README section appended in place at `reference/v1-licensing/README.md`.
- A short return at `handoffs/parallel/260912_licdb_RETURN.md` — counts in plain English first, detail second, and the three or four questions only Daniel can answer.
- ⚠ **The known one:** the pre-2022 price-to-type mapping (79 / 44 / 399 / 199 / 349). Only Daniel knows which was which — it is **flagged for his confirmation, never asserted.**

---

## Paste block — carried VERBATIM from `drafts/260911-1350_licensing-db-parallel_OPENER.md` (Strat, 2026-09-11)

```
Follow General_Advisor_Prompt_v6. Read Minotaur_v1_Serial_Cipher.md from project knowledge — it is the decoder.

Connect ~/Developer/Minotaur-Cowork. The inputs are in reference/v1-licensing/:
  - README.md (read first — it says what each column means and what is missing)
  - v1_User_Database_people_2026-09-11.xlsx      774 serials, no emails, no license type
  - v1_User_Database_sales-to-shows_2026-09-11.xlsx   121 sales, stops June 2022

GOAL: one workbook, reference/v1-licensing/v1_Licensing_Database_2026-09-DD.xlsx, that answers for every person who has ever held a Minotaur v1 serial: who they are, how to reach them, what kind of license they hold, whether it is active today, and what they have paid. It is the v2 entitlement list and the segmentation for the October announcement, so it has to be right, not impressive.

SOURCES, in order:
  1. The two exports (the spine). Decode every serial with the cipher and confirm it agrees with the Date and Computer ID columns; report any that do not.
  2. Gmail, sent mail, both addresses (daniel@lundbergsound.com and daniel@daniellundberg.com): every message containing "serial good through". Each carries recipient email, name, send date and the serial — decode it and join to the spine on computer ID (fall back to serial, then name).
  3. Gmail, from:invoicing@messaging.squareup.com: invoice number, payer, amount, created/paid/overdue, date. Amount maps to license type ($107.79 = $99 Personal + NY tax; $499 commercial production; older price points 79/44/399/199/349 are in the 2019–22 ledger — infer the mapping and flag it for Daniel to confirm rather than asserting it).
  4. Thread context for type and status: "Minotaur Download" = trial start; .edu addresses and "student" = educational; "renew" = renewal; Pace / DePaul / Penn State / CCM etc. = institutional seats.

RULES:
  - Gmail pages are 50 threads max. Paginate every query until nextPageToken is empty and RECORD the page count and thread count per query in the README. A result estimate is not a count. An unexhausted result set is not a finding.
  - Reads only. Never send, label, or modify mail.
  - Separate what you found from what you inferred. A license type read off a Square amount is found; one guessed from a name is inferred, and the row says so.
  - Do not trim, "fix", or normalise names or computer IDs in the spine — join on them as they are and report mismatches.
  - Keep everything in the connected folder. Customer names, emails and machine IDs go nowhere else.

OUTPUT — one workbook, four sheets:
  People    one row per person: name · emails (all seen) · organisation · first seen · latest expiry · license type · status (active / expired / trial-only) · total paid · number of serials · notes
  Serials   one row per serial: computer ID · serial · expiry (decoded) · person · issued date (from mail) · recipient email · source
  Payments  one row per payment: date · payer · amount · type inferred · invoice # · source (ledger / Square)
  Unmatched anything that did not join, with why

Plus a short README section: queries run, pages exhausted, counts by source, the rows you could not resolve, and the three or four questions only Daniel can answer.

ONE MORE COLUMN on the People sheet: "beta candidate" — flag anyone who (a) has renewed in two or more separate years, or (b) holds or bought a Production license, or (c) wrote an unprompted feature request, bug report, or workflow question. Exclude students. Daniel is choosing a private-beta cohort and these are the signals; the sixteen already chosen are Tracey, Crystal, Friedel, Pickens, ONeal, Ford, Poppleton, Myler, Wang, Deyo, Tippett, Hsieh, Schloegel, Meadows, Sweetser, Palumbo. Also list every non-student holder of a free or comped serial — Daniel asked who they are.

When done, stop. Do not commit. Tell Daniel the file is in reference/v1-licensing/ and what the counts are, in plain English, before the detail.
```
