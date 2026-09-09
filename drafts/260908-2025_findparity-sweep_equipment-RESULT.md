# FINDPARITY-UNTYPED — the sweep, run 1: EQUIPMENT PASSES 5 of 5

*Cowork-Arch, 2026-09-08. Run from this seat through the Cowork browser pane against **production** (`https://minotaur.app`, HEAD `1276cc4` — the tree FIND-PARITY shipped), signed in as Daniel, on `Cable Parity Fixture` (`dbf56057-0447-41a9-81b1-a8842a83b958`). **Read-only: finds only, nothing typed into a cell, nothing committed.** BROWSER-NOPRINT holds — this pane does the behavioural half of a gate and cannot do the printed half.*

## 1 · Method — an EXPECTED COUNT, not "did anything come back"

The registered hazard is that a wrong accessor returns an **empty** find, which an operator reads as missing data. A ">0 rows" check would catch that, but it cannot catch an accessor that returns the wrong rows.

**So every needle was priced at the database first**, then typed into the Find panel, and the app's `Found (N)` was compared to the SQL count. **A pass here is an exact match, not a non-empty result.**

## 2 · Result — 5 of 5, every count exact

| Field | Criterion | Expected (SQL) | App returned | |
|---|---|---:|---:|:--|
| **Starred** | contains `Yes` | 2 | **2** | ✅ |
| **Drawn** | contains `Yes` | 115 | **115** | ✅ |
| **Packed** | contains `Yes` | 843 | **843** | ✅ |
| **Labels** | is blank | 1,335 | **1,335** | ✅ |
| **Override** | is blank | 1,335 | **1,335** | ✅ |

**Labels and Override were tested by ABSENCE, deliberately.** Both are zero/false on every row of this project, so no positive needle exists — but `labelCountText(0)` and `flagFace(false)` both render BLANK, so `is blank` must return the whole list. **It returned exactly 1,335, which is the accessor working**: a broken accessor returning `undefined` would also have matched `is blank` — so this is corroborated by the three positive tests above it, which a broken accessor could not have passed.

**The registry reaches the UI.** The Find field dropdown carries all sixteen equipment fields, the five new ones included: `num_labels · sort_override · starred · drawn · packed`. **The static contract test proved the four structures agree; this proves the agreement is live in the browser.**

⚠ **Free corroboration of the other finding.** The list's own control reads **`Delete All (1335)`** — the app agrees with the database at 1,335 generic rows, against the **1,368** three governing documents record. See `drafts/260908-2015_fixture-numlabels-gone_measurement.md`.

## 3 · NOT RUN — cable (7) and boxes (13)

**The cable list's Find panel would not open under automation.** Three attempts: a ref-resolved click, a coordinate click on the `🔍 FIND` control, and a re-read after each. The page is otherwise fully interactive and the inspector renders its seven fields. **Stopped rather than pixel-hunting.** ⚠ **This is NOT a product finding** — a human click has not been tried, and the equipment panel opened first time by the same method. Assume the automation, not the app, until a person tries it.

**Boxes were not reached.**

**Also unrunnable on this project, whoever runs it:** eight of the 25 have no data here — cable `ETA` and `Private Notes`; box `Actual Weight`, `Add'l Weight`, `Add'l Cost`, `Label Notes`, `Private Notes`; equipment `Override` (tested by absence above). **Cable's ETA and Private Notes can be tested by `is blank` the same way; the five box fields cannot be tested either way here and want a different production.**

## 4 · Priced needles for the remaining runs — measured, reuse them

**CABLE list** (1,121 rows):

| Field | Criterion | Expect |
|---|---|---:|
| Color | contains `yellow` | 99 |
| Category | contains `3.0 Wireless` | 6 |
| Method | contains `Rent-Main` | 8 |
| Group | contains `Turkey` | ⚠ 1 by stored value — **the accessor reads the EFFECTIVE group, so a bundled cable finds by its bundle's group and the live number may legitimately exceed 1. Treat >0 as the pass and read the rows.** |
| Public Notes | contains `Pin 1` | 6 |
| Private Notes | is blank | 1,121 |
| ETA | is blank | 1,121 |

**BOX list** (134 rows) — needles: Number `615` · Big Labels `2` · Small Labels `2` · Color `Yellow` · Return Notes `Returned 1/23` · Public Notes `or WRK-4432` · Category `14.4 Load-In Supplies` · Method `Rent-Rehearsal`. **Price each at the database before running, as above.**

## 5 · What this does and does not discharge

**FINDPARITY-UNTYPED is NOT discharged.** 5 of 25 fields are proven live. **But the shape most likely to be systematically wrong — the flag face, where the cell draws a `✓` and the find matches the word `Yes` — is now proven on three independent flags with exact counts.** That was the least-confident part of the ruling.
