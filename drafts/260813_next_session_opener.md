Open as Cowork-Arch on Minotaur v2.
READ FIRST, in order:
  1. Architecture Prompt v29 — unless v30 is installed, in which case v30
  2. Roadmap v3.9 (WHOLE)
  3. Minotaur_v2_Session_Log.md — entry 7 is the last session
  4. handoffs/parallel/ — the HARNESS design block + Arch Prompt v30 + cover
     note, IF the parallel claude.ai session has returned. Read them before
     anything else technical.
  5. handoffs/from-cc/260813-1750_s4-3-leg3-b4-amend1.md — B4's closer. The
     leg-3 cascade specs are in 260812-1630 §NOT BUILT.
STATE: S4-3 leg 3 — B4 CLOSED at 8461c2a, pushed, production READY. Suite
1495/99 · frozen 3/3 vs be0769de · visual 26/26 @ 0.0000% · migration ledger
49. Tree clean apart from the generated next-env.d.ts (GIT-CFG, never
committed). No CC session open. A parallel claude.ai Arch session was opened
on HARNESS + Arch Prompt v30 and may or may not have returned.
FIRST ACTIONS:
  1. Verify HEAD/origin/production at 8461c2a.
  2. The parallel session's return, BEFORE scoping anything. HARNESS changes
     how every declared baseline event is run and the cascades will move
     frames, so scoping leg 3 first and re-scoping after is wasted work. If
     v30 is ready, install it before the session's technical work rather than
     mid-flight. If nothing has landed, say so in one line and proceed.
THEN: leg 3 continues — the two cascades, with B1 and B5 riding.
  - P4 Packed, including wiring the row Packed checkbox live. Carry R-43: the
    cascade is SILENT both directions, recurses DOWN (DDR §2.6, Set Box
    Packed), and is a gesture-time write, NOT a continuously enforced
    invariant — a nested box can legitimately sit unpacked under a packed
    parent, and v1 evidence shows exactly that.
  - P5 "things not in boxes". v1's dialog is verbatim in the box catalog:
    "Some bundles aren't in boxes. Would you like to add them? The Change All
    button at the top of the page might be helpful with this." Show Me /
    Ignore, Ignore default-highlighted, fires on ENTERING the Bundle List
    with boxless bundles present.
  - B1 — box find/icons/trim. The Box List has NO find engine at all; that
    absence may be the real divergence. Citation: CableListClient toolbar +
    FindPanel. B1 also carries the Stack/panel disposition below.
  - B5 — Type autocomplete audit. AUDIT AND REPORT ONLY, change nothing:
    AC-ENTER is deferred to after private-beta start, and a B5 that "fixes"
    Enter semantics ships half a deferred unit. Also reports whether AMEND-4's
    hover-clears rule intersects (bbb)/(eee).
ALSO CARRY:
  - AC-HANDLED is NO LONGER a trivial pass. Its fix has a named dependent:
    every wrapper-level Tab seam app-wide, and now the box panel's Enter seam,
    rely on handledRef being stuck to avoid double-committing. Un-inerting it
    makes commit→blur→fallback a live double-write path, so the pass must
    re-verify every seam it re-activates.
  - The post-private-beta box cluster is FIVE rows of one shape and none of
    them are built inside leg 3: TYPE-HOLD (Trigger B, SEAT-MIG authorized,
    TH-R1/R2/R3 already ruled) · PANEL-NAV · AC-ENTER · BOX-DUP ·
    BUNDLE-HOLD. Scope them as a group when the window opens.
  - Stack in the footer panel is UNRULED — asked three times. Arch's proposal
    is to drop all five identity fields from the panel on R-C's own reasoning
    (the row now owns them); the alternative is adding Stack for symmetry.
    Rides B1 either way.
  - DIALOG-BLANK rides B5 or leg 3's next touch.
  - LAT carries the COLD-START framing, not "the create path is slow" — the
    numbers are measured and in the 260813-1750 return.
  - Print is CLOSED. MMM-CAT never ran; the 0216 handoff is stale, re-issue
    fresh on scheduling — band machinery is warm now.
  - SHARE design is RULED (four roles); RLS delta + ADM-1 REV-B waits for
    build-prep — do not reopen.
  - Standing correction, now with five instances: read the surface before
    writing the instruction that constrains it. Its sibling: a declared
    event's scope is measured, not reasoned.
OWED BY ME: COWORK-REV confirm · the Stack/panel ruling · EVID-LAND frames ·
ZERO-CLEAR (JOY, Vape!) · PROJ-CLEAN (the Amend2/FIX1 test projects on the
dashboard) · TOK-VC rotation · R8 drill before September.
