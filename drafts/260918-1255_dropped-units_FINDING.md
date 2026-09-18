# FINDING — six v1 feature areas silently dropped from the Roadmap at v4.28 (Arch, 2026-09-18 12:55 ET)

Daniel asked whether RF, circuits and walkies are on the Roadmap. **They are not, and nothing ruled them off.**
- Roadmap v4.27 (Sequence, "Post-beta" row): `BATCH-BOX · Maintenance · Spreadsheet Export · RF/Walkies/Circuits (BVSC-RF) · IAS Import · real-time collab · licensing ~Nov · PWA` — QUEUED.
- v4.28 onward: Maintenance, Spreadsheet Export, RF/Walkies/Circuits, IAS frequency import and real-time collaboration have **zero** mentions; PWA survives to v4.44 only inside "off the road" wording, now gone; Cover Letter gone by v4.45.
- Brief v1.2 §9–12 still names them in scope: "All other sections (Cable, RF, Boxes, Walkies, Print, Cover Letter, Bingo, Maintenance): Match FileMaker v1"; "RF/Comms (schema built, UI not yet): rf_devices, cast_members, walkie_channels, walkie_assignments, circuits".
- Live DB: all five RF/comms tables exist with RLS (SET-FORM covered their read policies today). Ledger: /rf was a live 404 (KEYR-RES, ⌥⇧R reserved until the RF unit exists); BVSC-RF = the only export carrying circuits / RF cast / RF gear / RF roles.
- Same failure shape as CABLE-SPLIT going invisible (Daniel, 2026-09-18). HELD-IS-NOT-FORGOTTEN / propagation: restore at this session's close, placement per Daniel.

## RULED — Daniel, 2026-09-18 ~13:00 ET
> "RF and walkies can come after public beta opens."
- Placement: after the public beta opens (mid-October, v1 owners). Arch assumption, stated to Daniel for correction: **circuits ride with RF and walkies** (same v1 RF/Comms section, same five-table schema), and **IAS frequency import** rides the RF unit.
- Maintenance, Spreadsheet Export, real-time collaboration and Cover Letter: restored at close to THE SEQUENCE/Docket after the RF/comms unit, pending Daniel's word on any of them.
- Close must also census the Brief's full v1 section list against the Roadmap so nothing else is missing (Cable, RF, Boxes, Walkies, Print, Cover Letter, Bingo, Maintenance).
