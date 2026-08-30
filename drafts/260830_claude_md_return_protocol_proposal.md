# PROPOSAL — `CLAUDE.md`, two amendments

*Arch, 2026-08-30. **A proposal until Daniel confirms.** Neither edit is applied.
Both are `CLAUDE.md` edits, so they batch into one small docs unit **after** the
cell-and-row commit lands — adding `CLAUDE.md` to the tree now would break the
staged commit's expected 12-line `git status --short`.*

---

## 1 · WHY THE 30-SECOND / 10-LINE TRIGGER WOULD NOT HOLD

Daniel's diagnosis is right and the current rule is the reason. **The proposed
trigger is the wrong instrument for it**, for three reasons worth stating before
the alternative:

- **CC cannot check elapsed time against an artifact.** It is self-reported, and
  this project's own governance finding (O-12) is that *rules checked at
  discrete events against artifacts hold; continuous properties have no
  checkpoint and do not survive a long session.* A 30-second rule is a
  continuous property. It would be honoured early and forgotten by hour three,
  which is exactly the failure being complained about.
- **Ten lines fires on almost everything.** A `git status --short` on this unit
  is 13 lines. A single `vitest` tail is five. The rule would produce dozens of
  near-empty files per session, and a `from-cc/` folder nobody can find anything
  in is worse for Arch than scrollback.
- **It fires on read-only recon** where nothing happened worth recording.

**The real defect is not duration. It is that CC hands control back with the
result living only in terminal scrollback — so Daniel becomes the transport
layer, retyping or screenshotting CC's own output back to Arch.** That happened
twice today: the gate failure reached this seat as a photograph of a terminal.

And the current text names the right moment then immediately takes it back:

> At each natural stopping point — end of a coherent unit of work, **before
> returning control to Daniel**, or when a hard-stop item fires…

> One file per stopping point, not one per edit. **Don't create a handoff file
> for a single trivial change inside a larger in-progress task — batch it into
> the next natural checkpoint.**

"Natural stopping point" and "coherent unit" are judgment calls, and the second
rule is a standing escape hatch from the first. **The fix is to make the trigger
an event CC cannot fail to notice, and to remove the hatch by changing what gets
batched — the FILE, not the writing.**

Daniel's own words are kept verbatim as the rule's second half, because they are
the part that makes it cheap: *it doesn't need to summarize handoffs — handoffs
are for Arch.*

---

## 2 · AMENDMENT A — the Return Handoff File Protocol's trigger

### Replace the opening paragraph

**FROM:**

```
At each natural stopping point — end of a coherent unit of work, before
returning control to Daniel, or when a hard-stop item fires — write a
structured summary to a file rather than relying on terminal scrollback.
```

**TO:**

```
**The trigger is RETURNING CONTROL. It is an event, not a judgment.** Every
time you stop and wait for Daniel — for a confirm phrase, a ruling, a print, a
decision, a re-run, anything at all — the unit's return file is brought current
FIRST, before you write a word in the terminal.

**And the last line of your terminal message is that file's path, alone**
(Daniel, 2026-08-30). Do not restate the return in the terminal and do not
summarise it: the return is for Arch, the path is for Daniel. A terminal
message that carries the findings and no path has recreated the defect this
rule exists to close.

The reason, carried with the rule because a bare rule gets rationalised past:
**the terminal is not the record.** A measurement, a verdict, a count or a
state change that exists only in scrollback when you stop is lost — and Daniel
becomes the transport layer, retyping or photographing your own output back to
Arch. That has happened twice in one day.

The ONE exception: you stop to ask a clarifying question **before any work has
been done**. Nothing has happened, so there is nothing to record. Work already
done is never covered by this exception.
```

### Replace the second bullet under `Rules:`

**FROM:**

```
- One file per stopping point, not one per edit. Don't create a handoff
  file for a single trivial change inside a larger in-progress task —
  batch it into the next natural checkpoint.
```

**TO:**

```
- **ONE FILE PER UNIT, APPENDED — not one per stop.** What gets batched is the
  FILE, never the writing. A checkpoint, an amendment or a re-run inside a live
  unit appends a new dated section to that unit's existing return file and
  leaves every prior section untouched; it does not open a new one. A new file
  is opened only by a new inbound handoff. This is what
  `260830-1420_cable-pass4-cell-and-row.md` already does across CP1, AMENDMENT
  1 and AMENDMENT 2, and it is the pattern, not an exception.
- A focused return answering one narrow inbound handoff may be written as its
  own file **provided its content is also folded into the unit's file in the
  same step**, and it says so in its own first paragraph.
```

---

## 3 · AMENDMENT B — the capture-flake registry, entry (2)

Owed from today's gate and independently reported by CC. **Third sighting, third
frame/theme combination.**

**FROM** (registry entry 2, and the leg-6 note near line 412 that already
widened it once):

```
(2) 04-library-dark theme-race: a whole-frame, dark-only diff from the
async theme re-sync — clean on re-run.
```

**TO:**

```
(2) **theme-race whole-frame diff** — the async theme re-sync, clean on re-run.
**Widened TWICE, and the second widening is the important one.** Originally
`04-library-dark`; widened at leg 6 to "a dark frame, not frame 04" when it
fired on `06-settings-dark` (1451200 px, max Δ207, bbox 0,93–1599,999); widened
again 2026-08-30 when it fired on `06-settings-`**`light`** at **the identical
pixel count and the identical bounding box** (1451200 px, bbox 0,93–1599,999,
max Δ248). **It is NOT dark-only and it is not frame-specific. The invariant
across all three sightings is the pixel count and the bbox — not the frame, not
the half.** Read it as *either half of any frame*. Δ varies; 1451200 px at bbox
0,93–1599,999 is the signature.

**Settled by import graph on 2026-08-30, and this is how the next one should be
settled too:** a re-run tells you whether it recurs; the import graph tells you
whether the frame could ever have seen the change, and it gives the same answer
either way. Zero of that unit's eight changed modules were reachable from
`06-settings`, against a control of 8 of 8 from the route that does use them.
**Two runs is the limit** (lesson entry 6).

**This entry is PROSE and masks nothing. It never becomes a
`screenshots/diff-exceptions.json` site.** DIFF-EXC-BOUND is owed before any
Δ>1 site is admitted there, a whole-frame diff is not the Δ1 sub-pixel wander
that registry exists for, and masking 1.79% of a frame would blind the gate to a
real regression on that page permanently.
```

---

## 4 · WHAT THIS DOES NOT CHANGE

The four sections, the fidelity bar, the Raw Output Rule, the SED LEDGER, the
COMMIT BLOCK rules, the hard-stop reporting rule ("surface it in one plain line
and wait" — still both the terminal flag *and* the file), and the rule that CC
never reads a prior return back into its own context unless Daniel points at it
by name. All unchanged.

---

## 5 · THE ONE JUDGMENT DANIEL SHOULD MAKE

Amendment A makes the return file current at **every** stop, including short
ones. That is the point, and it has a cost: a unit with six checkpoints gets six
appended sections, and the file grows. `260830-1420_cable-pass4-cell-and-row.md`
is already ~1,400 lines and it is one unit.

**Arch's read: that cost is worth paying**, because the alternative is what
happened today — the record living in a photograph. If the length becomes the
problem, the fix is a short DONE section at the top of each append with the
detail below it, not a return that goes unwritten.
