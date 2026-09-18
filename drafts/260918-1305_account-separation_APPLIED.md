# ACCOUNT SEPARATION — ruled by Daniel, applied by Arch, 2026-09-18 ~13:05 ET

Daniel: "I want to separate my test account from real shows. Buena Vista Social Club Ciudad de México, Matchbook Festival, and Vape! stay with daniel@daniellundberg.com … henceforth, test shows move to daniel+test01@daniellundberg.com." On BVSC US Tour: "it's a real show, but I think it's out of sync with v1. It'd be best to delete it, then remake it with a new v1 import under daniel@". "others approved".

Rehearsed under forced rollback (0 licences point at any of the six; daniel@ then sees exactly his three; test01 sees 3,465 items / 2,339 library rows on the moved three), then applied as one atomic block with count guards:
- **DELETED** (FK cascade, all 25 project tables): BVSC US Tour `57874c69…` (2,591 items, 4 snapshots, 5 import runs) · Foo `39eb06f4…` · CC's proof project `08e76e42…` (and its failed-import row `56f6e6b3…`).
- **MOVED to daniel+test01** (`9f16ae29…`), ids unchanged so every citation survives: Cable Parity Fixture `dbf56057…` · Matched Pair Fixture `912892ad…` · Versioning Test `87ccc246…`. `guard_projects_owner_column` disabled and re-enabled inside the same transaction; test01's prior editor row on CPF removed; owner member rows moved.
- Result: daniel@ = BVSC (CDMX) · Matchbook Festival · Vape!. test01 = CPF · JOY · JOY Import 2 · MPF · Versioning Test. daniel+pt = Visual Gate Fixture.

Consequences to propagate at close:
- ⚠ **No non-owner member exists on any fixture now.** SET-FORM's and migration 75's "real non-owner editor on CPF" identity is gone; re-create one (a second test account as member) when a non-owner measurement is next needed.
- ⚠ **Every Ledger/Roadmap figure measured on the US Tour (`57874c69`, 2,591 rows) now names a deleted project.** The numbers stand as history; nothing may re-measure against that id. CABLE-SPLIT's 3 parentless split_end rows on it are gone (R7's cleanup: 4 left, all on CPF).
- BVSC US Tour re-import under daniel@ is Daniel's: needs a fresh v1 export. ~2,600 items ≈ 50 s at the measured rate, inside 90 s. It will again write parentless `split_end` values until CABLE-SPLIT R7 lands.
- Printing CPF with the top-left logo now needs the test01 login.
- ✅ BUILD-STAMP format RULED by Daniel 2026-09-18 ~13:10 ET, on production: "v 9/18/26 · b07eef5 is good." Pedigree (c) → (a).
