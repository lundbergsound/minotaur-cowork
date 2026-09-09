# ⚠ The parity fixture's `num_labels` data is GONE, and three governing documents still assert it

*Cowork-Arch, 2026-09-08, measured live from this seat while preparing the FINDPARITY-UNTYPED sweep. **This is the one measurement this seat can take that CC cannot** — HARNESS-RLS-CORPUS makes `Cable Parity Fixture` invisible to any harness CC drives. Read-only; nothing was written.*

## 1 · The claim of record

`Minotaur_v2_Session_Log.md`, state-of-play, and the Aug-31 entry, and Roadmap v4.16's lineage row:

> **THE `equip.xlsx` RE-IMPORT IS DONE AND VERIFIED — EQUIP-LABELS-2's PAYOFF IS REALISED.** `Cable Parity Fixture` reads **150 twos / 57 ones / 1,161 zeros — 357 stickers**, the acceptance predicted before the measurement was taken. … `labels_done` still reads 57 — the frozen failure preserved exactly as ruled, **with 150 rows carrying a count and no flag.**

## 2 · What the database holds now

`Cable Parity Fixture` — `dbf56057-0447-41a9-81b1-a8842a83b958`:

| Measure | Recorded | Live, 2026-09-08 |
|---|---:|---:|
| `num_labels = 2` | 150 | **0** |
| `num_labels = 1` | 57 | **0** |
| `num_labels > 0`, **any type, all 2,783 rows** | 207 | **0** |
| `labels_done = true` | 57 | **57** ✓ |
| generic rows | 1,368 | **1,335** |

⚠ **`labels_done` still reads exactly 57, which is what confirms this is the right project and the right population** — the frozen boolean captured the 57 ones and failed on the 150 twos, exactly as HASH-FREEZE-LABELS ruled. **The flag survived; the integer did not.**

## 3 · When — a single bulk write, and it is NOT today's gate residue

`updated_at` clusters on the project:

| Timestamp (UTC) | Type | Rows | `labels_done` true |
|---|---|---:|---:|
| **2026-09-01 13:03** | generic | **1,329** | 57 |
| 2026-08-27 19:20 | cable / tail / box | 1,118 / 190 / 134 | 0 |
| 2026-09-08 11:28–11:30 | generic | 4 | 0 |
| 2026-09-08 15:12 / 15:15 | generic / cable | 2 / 1 | 0 |

**One bulk write on 2026-09-01 at 13:03 UTC (09:03 EDT) touched 1,329 of the 1,335 generic rows.** Today's writes are seven rows total — that is the gate residue the Session Log already records as harmless, and it is not this.

⚠ **The CAUSE IS NOT MEASURED and is not asserted here.** 2026-09-01 is the CHANGEALL-FOUNDSET session — its migration is `20260901043028` (04:30 UTC) and its rehearsals, negative controls and guard runs were that day. A bulk write carrying `num_labels: 0` across the found set fits the timestamp and the shape, and **that is a lead, not a finding.** It wants one look at what ran at 13:03, not a hypothesis written down as a cause.

## 4 · What this does and does not mean

**It does NOT mean the product is broken.** EQUIP-LABELS-2's code is intact and independently pinned: `labelsHashFreeze.test.ts` guards the frozen fourteen, and the integer column and its RPC arm are covered by the suite. **No shipped behaviour is implicated by this measurement.**

**It DOES mean:**

1. ⚠ **The corpus can no longer demonstrate the unit.** "300 stickers come back" was an acceptance run against this fixture. Re-running it today returns nothing. Daniel's re-import took about two minutes and would restore it.
2. ⚠ **Three governing documents state a corpus fact that is no longer true** — the Session Log's state-of-play bullet, its Aug-31 entry, and Roadmap v4.16's lineage row. The entries are immutable history and stand; **the state-of-play bullet is the live one and is now wrong.**
3. **The Labels find field cannot be swept on this project.** It is one of the 25 FINDPARITY-UNTYPED fields, and the fixture has no non-zero value to search for.
4. ⚠ **This is CORPUSBOUND-AUDIT's exact shape, one turn further on.** That row asks how many dispositions rest on a corpus scan. This one asks something sharper: **a conclusion can rest on corpus state that later CHANGES, and nothing notices.** A measured fact about live data is true at a timestamp, and the governing documents record neither the timestamp nor a way to re-check.

## 5 · ⚠ THE LIVE SHOWS ARE UNAFFECTED — checked, not assumed

| Project | generic rows | `num_labels > 0` | `labels_done` |
|---|---:|---:|---:|
| `Buena Vista Social Club US Tour` (`57874c69…`) | 1,059 | **113** (4 twos, 109 ones) | 109 |
| `Buena Vista Social Club` — **Mexico City, the driver** (`cf780353…`) | 292 | **20** (1 two, 19 ones) | 19 |

**Both carry their counts. Nothing on a live production is missing.** This is confined to the test fixture.

## 6 · Recommended

- **Do not re-import to "fix" it before the cause is looked at** — the 13:03 write is the only evidence of what happened, and a re-import overwrites the scene.
- Correct the Session Log's state-of-play bullet at the next close, with the date the figure was true.
- Register the general shape: **a corpus measurement in a governing document carries the date it was taken, or it will be read as current forever.**
