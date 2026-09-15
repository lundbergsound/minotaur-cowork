# Session Docket deltas — 2026-09-15 Cowork-Arch main line

*Written mid-session so nothing here depends on this chat surviving
(SWEEPLINE-NOT-DURABLE). Every item below becomes a Roadmap row, a row
amendment, or a Ledger line in this session's close package. Nothing here is
installed.*

## CONTRAST-PASS — absorbs one more, with its cause measured

**SORTBAND-DARKGROUND (Daniel, 2026-09-15, at the BATCH-COHORT-1 browser gate):**
*"we need more group band contrast in dark mode."*

**Measured, not inferred.** The outer sort band's ground is computed from the
project colour at a fixed lightness per theme, in `src/theme/hcTheme.ts`:

| Theme | `groupBg` | gradient stops |
|---|---|---|
| dark (`:90`, `:94-95`) | `ch(hue, 14, 4.5)` — **4.5% lightness** | 9% → 7% |
| light (`:144`, `:148-149`) | `ch(hue, 28, 14)` — 14% lightness | 15% → 12% |

`.sort-band` (`globals.css:214-230`) was specified to **stay dark in both
themes** — Zite's group header verbatim. That reads as a strong band on a light
page and disappears on a dark one: at 4.5–9% lightness the band sits within a
few percent of the dark page ground, so it stops reading as a band at all.
Daniel's two dark screenshots show exactly that; the light pair show the band
working as designed.

**Consequences for how it is fixed:**
- The number to move is the **dark-theme band lightness**, in one file. No
  layout change, no per-surface work — every list surface reads the same tokens.
- This is **band separation from the page ground, not text on a ground**, so the
  target is a non-text boundary contrast, not a text ratio. Report APCA Lc for
  the band text separately (APCA-NOT-WCAG).
- ⚠ **It is a declared baseline event.** The band renders in the visual-gate
  frames, so any change to its lightness moves them and needs Daniel's
  authorisation in advance. That is the reason it belongs in CONTRAST-PASS,
  whose acceptance is already Daniel choosing one of five renderings, rather
  than as a quick tweak.

## AUTOCOMPLETE-NOPORTAL — the row's stated cause is FALSE; new cause measured

The row says the equipment autocompletes do not portal, six call sites. Measured
2026-09-15: **they do.** All six opted in at FIELD-CONTRACT leg 3a on 2026-09-08
(`AutocompleteInput.tsx:319-325` records it) and
`src/lib/autocompletePortalScope.test.ts` pins the census — 33 sites, 30
portalled, 3 registered exceptions.

**The real candidate, measured, and no screenshot was needed for it.** The three
un-portalled sites are the print-options filter row (`PrintEquipmentListClient.tsx:427`
Method, `:437` Category) and the revisions grid (`PreviousRevisionsClient.tsx:1017`).
They were excluded on the reasoning that neither has a clipping ancestor — and
that is the wrong test:
- the non-portal menu is `absolute` (`AutocompleteInput.tsx:666`), so it **does
  not extend the document's scroll height**; low on a long form it runs past the
  window edge with nothing to scroll to;
- the flip-upward geometry is gated on `portalDropdown`
  (`:328`, `if (!open || !portalDropdown) …`), so the sites denied the prop are
  also denied the thing that would save them.

This matches Daniel's own CDMX words — *"auto fill is cut off by bottom of
screen"* — which drove leg 3a. **Rides AUTH-POLISH**, not a reopened batch.
Jamie has no further screenshot and none is needed.

## New row — CABLE-CHANGEALL-METHODNULL

`CableListClient.tsx:3499-3508`. A cable Change All on Method resolves the typed
name and falls to `?? null`, so **a typed `0` or any unmatched name writes
`method_id: null` across the whole cable found set.** Same defect shape fixed on
the equipment side 2026-08-31 (CHANGEALL-METHODNEW), still live on cables, on a
surface 30–40 cohort members are about to use. Arch's recommendation: pull
forward into the next unit rather than wait behind the invite. Daniel's call.

## New row — METHOD-STRAYS

The create-on-any-unmatched-text path mints a permanent method from any typed
string. In live data: **four methods named `0`** (Cable Parity Fixture, BVSC US
Tour, BVSC, Versioning Test — all `is_system = false`, **0 items use any of
them**), and Daniel's own picker screenshot also shows `i` and `BVSC` as strays,
`i` being a single keystroke. Deprioritised by Daniel 2026-09-15 ("not important
right now"). Removal is a destructive write on real projects, so it is Arch's
hand on his confirm, never CC's.

## CATCOUNT-COLUMN — ruling owed, and the ask is now one word

CP5 stopped at the measurement, correctly. `categoryCounts` is **not** filtered
by `type`, deliberately, because it feeds the delete guard and a guard that errs
toward refusing is the ruled shape.

⚠ **The measurement that sharpens the question:** the **Methods tab's Items
column, which has been shipping and visible** (`MethodsAdminClient.tsx:589-590`),
is built from `fetchItemMethodIds` (`src/lib/queries/methods.ts:21-30`) and is
**also unfiltered by type**. So the sibling column already counts every type.
- **MATCH** (Arch's recommendation) → the Categories count means the same thing
  as the Methods count beside it, and the build is the column alone: no second
  read, no query change.
- **FILTER** → needs which type, and becomes a second filtered read beside the
  guard's, which stays unfiltered either way.

## BOXBAND-DUPKEY — closed at five sites, one edge case left open

Built at five sites, not the three Arch named. Registered, NOT built: the
category-sort pristine check compares `match.name === label`, so two *distinct*
category rows differing only in case and sharing a rank are now one band, and
picking the other spelling is a no-op. Needs duplicate case-variant category
rows in one project to reach.

## §2 linked-box — live proof deferred

Pinned by test at source; `gateLinked` is a component closure, so no live write
was driven. A browser proof on a linked cable pair **rides the next cable unit**;
Arch's call, not owed at this gate.

## APPLY-TIMEOUT — Phase 1 returned; Phase 2 held by Arch

Full size is ≈7,400 spine rows across thirteen tables + ≈3,100 identity-map rows
+ a 160 kB blob — small for a database, so nothing yet says it cannot fit in 8s.

1. **The import is ONE budget, not 59.** `import_apply_v1` holds 59 write
   statements, no loops, and the clock does not reset per statement — proved live
   with a two-step `DO` block under a 1,500 ms ceiling. **Chunking inside the
   procedure is eliminated as an option**; a split must cross an RPC boundary.
2. **The clean abort has one loose end.** The version-history snapshot is a
   separate, already-committed call ahead of the import, so a timed-out import
   leaves a backup row for a gesture that never happened. One row, not one per
   attempt.
3. ⚠ **PROPAGATION OWED.** `import_runs` logs from inside the same transaction,
   so a failed import erases its own log entry — all nineteen logged runs read
   "succeeded" — and its start and finish timestamps are always identical by
   construction. **There is no import timing history at all, so any measured
   import duration cited in any document did not come from that table.** Every
   document carrying such a figure must be found and corrected in the same
   package.
4. `import_apply_v1` carries **no function-level `statement_timeout`**, while two
   sibling functions in the same schema already carry `statement_timeout=5min`.
   The narrow option has precedent.
5. **New open question:** is there an HTTP/gateway ceiling shorter than 8s? If
   there is, raising the database ceiling accomplishes nothing. Unmeasured.
6. Confirmed unchanged: role ceilings (8s/8s/3s), ledger at 64, and BVSC Mexico's
   **823** orphan identity rows, exactly. NOT re-measured: the ~570 ms snapshot
   figure — carried forward unverified, do not cite it as this seat's.

**Arch's ruling, with its reason:** Phase 2 holds until migrations 65–69 are
applied. Those migrations rewrite RLS on 34 tables, and RLS predicates are
evaluated per row on every row an import writes, so measuring first would measure
a database about to stop existing. It also keeps a full-size import off the same
clock as an eighteen-table policy sweep.

## Fixture residue — clear before any parity round

Daniel's gate ran on the **Cable Parity Fixture**
(`dbf56057-0447-41a9-81b1-a8842a83b958`). Two equipment rows there now carry test
Group values (`truck 2`, later `taco`). Equipment groups do not feed the cable
parity prints, so nothing is invalidated, but the fixture should not carry test
data into a future round.

## Arch errors this session

1. Told CC there were **three** band sites; there were **five** — the category
   sub-band `Map` and the ⌥⇧I toggle's inline key were missed. A set asserted
   from a narrow search, the same shape as the four wrong claims of 2026-09-08.
2. Told CC the band bulk arm would **inherit** the method planner. At source it
   did not call it at all — it resolved inline and created.
3. The handoff's `Tier:` line named no model (WF-2). Flagged by CC, not blocking.
4. Passed the "filtered by `type`" wording through into the handoff without
   measuring the sibling column beside it, which is itself unfiltered — so CP5's
   question was sharper than the handoff made it.

## Rollover — installed this session

Oldest 8 entries → `session-log-archives/Session_Log_Archive_2026-09-15.md`;
newest 2 kept; header at 2 entries, rollover clear. Installed to project
knowledge. **Both files are uncommitted** and ride the close's command block.

---

# APPENDED — SHARE-MIGRATIONS 65–69, ALL APPLIED 2026-09-15

Migration ledger **64 → 69**. Each its own migration, its own Trigger B, its own
confirm from Daniel, each rehearsed under forced rollback with a residue check
before applying. ⚠ **The hard rule is DISCHARGED: non-owner rows in
`project_members` are now legal.** Table still holds 15 rows, all `owner`.

| # | Name | What landed |
|---|---|---|
| 65 | `share_revb_helpers` | `can_read_project` / `can_write_project` / `can_admin_project` — STABLE, SECURITY DEFINER, empty search_path, PUBLIC revoked, `authenticated` granted |
| 66 | `share_revb_cable_family` | 7 owner-only policies → 14 member-aware ones. **Closes VERHIST-TRUNCATE.** |
| 67 | `share_revb_sweep` | 38 policies over 18 tables refactored onto the helpers |
| 68 | `share_revb_settings_features_storage` | member-visible shows, admin-gated features, 4 storage policies, owner-column guard trigger |
| 69 | `share_revb_roster` | `admin` role legal, roster rules, `project_member_names()` |

## Corrections of record

1. ⚠ **66 and 67 are NOT both "opening up sharing."** Measured at source: the 18
   tables in 67 **already** read `project_members` — **40 policies** hand-rolled the
   same membership subquery, which is exactly the Roadmap's "forty subqueries" figure,
   now CONFIRMED. 67 is a refactor. **The cable family was the only owner-only set**,
   which is precisely why the cable-less backup defect lived there and nowhere else.
   Arch stated this wrongly to Daniel before measuring it.
2. **67 does carry one behaviour change:** read widens from (owner, editor) to **any
   accepted member**, which is what makes a viewer a viewer. Write stays
   (owner, editor) + admin.
3. **`is_project_owner(uuid)` already existed** (SECDEF, owner-only, no admin path) —
   69 depends on it and no migration in the set creates it. Verified from its live body.
4. **RLS on UPDATE is silent.** A member editing a show's settings affects zero rows
   and raises nothing. Reinforces **VIEWER-ROLE**'s D-1 (a control that would be
   refused must not be rendered); not a new row.
5. `projects` INSERT and DELETE policies were **not** touched by 68 — both stay
   owner-only. Deleting a show is not an admin's to do.

## ⚠ NEW ROW — RLS-HELPER-COST (gate item, before the invite)

**Measured settled, warm, 3 reps, <2% spread, no DDL in the transaction:**

| read, one show (US Tour) | before 67 | after 67 | factor |
|---|---|---|---|
| equipment list (2,591 rows) | 1.8–2.1 ms | **43.0–43.6 ms** | ~21× |
| equipment library (2,595 rows) | 6.1–6.6 ms | **47.8–48.3 ms** | ~8× |
| box details, one show (29 rows) | 15.4–18.2 ms | **453–458 ms** | ~28× |

**Cause:** the three helpers are `SECURITY DEFINER`, which **blocks inlining**, so
every row pays a function invocation instead of one flattened join. Both helper
branches are index-served (`project_members(project_id,user_id)` unique; `projects`
pkey), so indexes are not the fix. **Scales with row count** — the cohort will import
larger shows than the one measured.

⚠ **The obvious fix is RULED OUT, and 69 is why:** dropping `SECURITY DEFINER` would
let the helpers be inlined, but 69 puts policies on `project_members` itself, and an
invoker-rights helper reading that table under those policies would recurse. The
definer setting is what prevents it.

**Candidate not yet trusted:** a set-returning `my_readable_projects()` used as
`project_id in (select …)`. Measured no better — **but measured inside a DDL
transaction, so it proves nothing.** Needs its own settled round.

## ⚠ Two Arch method failures this session, both on measurement

6. **Measured inside a DDL transaction, twice, and nearly acted on it.** The first
   timing pass appeared to show a 28× regression on the box list and I was one step
   from amending a rehearsed migration on it. A settled instrument showed the
   as-designed and rewritten policies were indistinguishable. **GATE-SETTLE-BETWEEN
   exists for exactly this.** The rule now has a second citation.
7. **Applied 67 without first capturing the 38 original policy definitions**, so a
   rollback would have meant reconstruction rather than record. Recoverable —
   `supabase_migrations.schema_migrations` carries a `statements` array — but that was
   luck, not method. **Every future policy migration captures `pg_policies` for the
   affected tables into the return BEFORE the apply.**

## Probes of record (all green)

- **66:** non-member 0 / accepted editor sees all + writes / viewer reads but write
  DENIED / invited-but-unaccepted 0. Owner path on real data unchanged: 1,372 cable
  rows = truth.
- **68:** storage probe run against the **real** bucket object
  (`d031bbe3…/top_right`): non-member 0, member sees it, viewer INSERT DENIED, editor
  INSERT allowed. Owner-column guard proven **two-sided** — blocked with the trigger,
  succeeds without it. Editor and viewer both affect **0 rows** on a settings update;
  owner affects 1.
- **69:** owner seats admin/editor/viewer; **a second owner is refused outright**; the
  owner cannot demote or delete their own row (0 rows, by anyone); an admin cannot
  promote themselves or touch another admin (0 rows); non-owner self-leave works;
  `project_member_names` returns the roster to a member and **nothing to a
  non-member**; `profiles` gained no policy and stays self-only (WHOCOL-RLS holds).

## Still owed on the apply-time checklist

- **Types regen** — rides BATCH-HOUSEKEEPING. 65–69 changed no table shape (the role
  CHECK is not a type), so zero-diff expected; run it anyway.
- **A live member proof belongs to Daniel's browser gate when SHARE-ROSTER ships** —
  a real member on a real show, printing a letterhead. The rehearsal used the real
  object and the real policies; only the commit differed.

## ⚠ Project-knowledge hygiene — Daniel, 2026-09-15

Project knowledge carries **both** `claude/Minotaur_v2_Roadmap_v4_38.md` and
`claude/Minotaur_v2_Roadmap_v4_37.md`. The install rule requires a governing-doc
install to retire the superseded version **in the same step**; that did not happen.
**At this close: install the new Roadmap and delete every superseded Roadmap from
project knowledge.** v4.37 stays in the repo, which is where v4.38's own footer says
its pre-consolidation row text lives. Check the whole doc list for the same fault on
the Session Log, Brief, Architecture Prompt and Strategy Prompt while there.

---

## CATCOUNT-COLUMN — RULED, Daniel 2026-09-15

**"every record in a category, regardless of list."** So the Categories tab counts
every record carrying that category — equipment-list items, cables, tails and boxes
together — which is the same meaning the Methods tab's Items column already carries.

**Pedigree (a): Daniel's ruling 2026-09-15**, superseding the "filtered by `type`"
wording of 2026-09-13, which did not say which type and so could not be built.

**What this makes the build.** One column. `categoryCounts` is already computed
(`MethodsPageLoader.tsx:54-62`) and already passed into the Categories tab
(`GCMClient.tsx:69`) — it is simply never drawn. No second read, no query change, no
new interaction with the delete guard. Rides the next equipment unit.

**The delete guard stays unfiltered** — unchanged by this ruling, and it was never in
question. `fetchItemCategoryIds` keeps its deliberate no-`type`-filter and its comment.

**The measured precedent that decided it.** The Methods tab's Items column has been
shipping and visible while counting every kind of record. On BVSC US Tour
(`57874c69-06b6-41b1-91d8-6a00e5255110`), today:

| Method | Items column | of which on the equipment list |
|---|---|---|
| Rent-Cable | **1,508** | 158 |
| Buy-Perishable | 133 | 2 |
| Rent-Boxes | 30 | 3 |
| N/A - Labels Only | 25 | 1 |

Four of the ten methods on that show are mixed-type. So MATCH is not a new
convention — it is the one already on screen, never flagged.

⚠ **The known cost, recorded so nobody reads it as a defect later:** on a cable-heavy
show the Categories tab reads high against the equipment list — `13.0 Cable` counts
**1,480** where the equipment list shows **108**. That is the intended meaning, not a
bug. Any future session proposing to "fix" it back must cite this ruling first.

## ⏸ NEW HELD ROW — CATCOUNT-BREAKDOWN

A per-kind breakdown of the category count — equipment-list items, cables, tails and
boxes shown separately rather than as one total. **Daniel 2026-09-15: wanted, but much
later.** Release trigger: **after public beta** (satisfies HELD-IS-NOT-FORGOTTEN's
requirement for a named trigger). Widens the column and turns an admin tab into a
small report, which is why it is not riding the count itself.
