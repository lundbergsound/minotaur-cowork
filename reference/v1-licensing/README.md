# v1 licensing — source exports

Two exports from the FileMaker **Minotaur User Database** (`Minotaur User Database.fmp12`), taken by Daniel on 2026-09-11 and filed here by the parallel Strat session. They are the spine of the v1 licensing database; the Gmail sweep (see `drafts/260911-1350_licensing-db-parallel_OPENER.md`) fills in what they lack.

## `v1_User_Database_people_2026-09-11.xlsx` — every serial ever issued

| Column | Meaning |
|---|---|
| Computer ID | 32-hex machine ID the serial is bound to |
| Serial | 54-char serial (see `Minotaur_v1_Serial_Cipher.md` — decodes to expiry + computer ID) |
| Date | Expiry date |
| Person | Name as entered in FileMaker — **no email column** |
| DateCheck / Computer ID Check | FileMaker's own decode of the serial, for verification |
| Note | Free text (extensions, show names, institution) — 136 rows carry one |

Measured at filing: **774 rows · 741 distinct names · 750 distinct computer IDs · expiries 2019-10-03 → 2029 (one 2100-08-28, effectively permanent) · 181 rows unexpired on 2026-09-11.** No license type, no email, no price.

## `v1_User_Database_sales-to-shows_2026-09-11.xlsx` — the sales ledger, and it STOPS in 2022

| Column | Meaning |
|---|---|
| Amount | Pre-tax price |
| Person / Show | One or the other is usually filled (105 with a person, 36 with a show) |
| Sale Date | |
| Tax / Total | |
| Grand Total / Sub Total / Tax Total | FileMaker summary fields, identical on every row — ignore |

Measured at filing: **121 sales · 2019-06-04 → 2022-06-14 · $19,490 pre-tax.** Price points seen: 79 (×47), 44 (×17), 399 (×17), 199 (×10), 349 (×8), 158, 88, 698, 0. ⚠ **Nothing after June 2022** — payments since then exist only as Square invoice emails (`invoicing@messaging.squareup.com`) in Gmail.

## What is NOT here and where it is

- **Emails** — only in Gmail: the "serial good through M/D/YY" sent messages (both `daniel@lundbergsound.com` and `daniel@daniellundberg.com`).
- **License type** — inferred from price (Square amount or the 2019–22 ledger), thread context (trial / student / renewal / institutional), and Note.
- **Payments after 2022-06** — Square emails only.

Customer names, machine IDs and serials are in these files. Whether this folder is committed to the (private) remote is Daniel's call; it is not in `.gitignore` as filed.
