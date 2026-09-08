# CDMX sprint notes — Arch triage, read against the codebase

*Daniel's notes from running the CDMX list, 2026-09-07. **All queued behind sending the CDMX list; none is critical.** Read at source while CC held the repo, so this seat wrote nothing to `Minotaur/` — reads only (the one-writer backstop). Every file:line below was checked in this session.*

**Questions for Daniel are marked ❓. Everything else is a reading, not a ruling.**

---

## A · ONE FINDING EXPLAINS TWO OF THE NOTES, AND THE FIX ALREADY EXISTS

**⚠ THE EQUIPMENT SURFACE IS THE ONLY LIST IN THE APP WHOSE AUTOCOMPLETE DOES NOT PORTAL.**

`AutocompleteInput.tsx` has two rendering branches. The `portalDropdown` branch renders the menu into `document.body`, `position: fixed`, computes its geometry from the input's rect, **flips upward when there is no room below** and clamps `maxHeight` to the space available (`:314-332`, `:640-645`). The fallback branch is `absolute z-20 top-full left-0 max-h-56` (`:658`) — no flip, no viewport awareness.

**Measured: `portalDropdown` is passed on tail, line, cable, bundle, box, cable-type and inspector surfaces — 24 call sites — and on ZERO equipment ones.** `EquipmentItemRow.tsx:745` (Method) and `:805` (Box), and the `EquipmentListClient` toolbar and filter sites at `:2808`, `:2860`, `:3315`, `:3457`, all take the fallback.

The component's own comment block (`:142-157`) says the portal exists **for exactly this** — being clipped by an overflow-scroll ancestor or covered by a bottom-anchored panel.

- **"auto fill is cut off by bottom of screen"** — this, directly.
- It is the **FIELD-CONTRACT shape** one more time: *equipment is the surface that missed a wiring every other surface has.* That is the third instance this project has recorded (the steck field, `num_labels`, now this).

❓ **This looks like a one-prop change with a proven mechanism behind it. Do you want it pulled out of the housekeeping batch and run early, or does it wait with the rest?**

---

## B · FOCUS, FIELDS AND KEYS — the FIELD-CONTRACT family

**These belong to FIELD-CONTRACT** (ruled: all five list surfaces, every editable cell, plus the Find vocabulary), which is already sequenced after the CDMX patches. They are not new units; they are FIELD-CONTRACT's acceptance criteria arriving from real use.

| note | what I found at source |
|---|---|
| **Duplicating from the Model field should land back in Model** | ⚠ **The mechanism is already built and should be working.** `EquipmentListClient.tsx:1284-1298` captures the focused field BEFORE blur, awaits the in-flight commit, duplicates, then `setRowFocusRequest({ rowId: cloneId, field })`. So this is not missing — it is **failing for the Model field specifically**. The likely cause is banked in FIELD-CONTRACT already: *"`captureFocusedField` and `captureInFlightDraft` read DIFFERENT attribute sets"* and *"`data-equip-field` is overloaded across four unrelated concerns."* Model is rendered by a different branch from the other cells (`EquipmentItemRow.tsx:495`, `:902` — *"Model editing moved to the model row"*). **A test that duplicates from every editable cell and asserts the landing field would catch this class rather than this instance.** |
| **Changing a category on the last row: no scroll, Tab did not reach it, Enter did nothing** | The row re-sorts out from under the commit and focus is lost to `document.body`. Three separate wirings — keep the record, scroll it into view, restore the field — and FIELD-CONTRACT's registry is where they get asserted rather than remembered. ⚠ **OPEN AND OWED AT THE UNIT (Daniel, 2026-09-07: *"I don't know — ask again when we get to this unit"*).** The question is whether the list was sorted BY CATEGORY when the change was made — that decides whether this is one defect with the category-band note below or two. **Written down rather than left to a future session's judgement: ASK IT, do not infer it from the code.** Reproducing it is one gesture on the last row of a long list. |
| **⌘J out of a find should leave the current record and field focused and scrolled** | Same family: an operation that changes the found set drops focus. |
| **Category band not editable unless sorted by category — perhaps only "Uncategorized"** | Registered as **BOXBAND-DOCTRINE**'s neighbour on the equipment side. ⚠ **OPEN AND OWED AT THE UNIT (Daniel, 2026-09-07: *"I don't know — ask again when we get to this unit"*).** The question is whether it reproduces on a NAMED category or only on `Uncategorized`. **A sort-dependent editor and a band with no row to write to are different defects with different fixes, and the artifact cannot tell them apart — only the gesture can. ASK IT.** |
| **Split dialog from Description should open with the description text selected** | Small and self-contained. The row cells already have a select-on-entry idiom (`handleSelectOnEntryFocus`, `EquipmentItemRow.tsx:813`) to copy rather than invent. |

---

## C · FIND

| note | reading |
|---|---|
| **Live count during find mode** | New affordance, no v1 pedigree either way — v1 shows its count only after the find runs. ❓ **Is this a v1 behaviour you want reproduced, or a v2 improvement?** The answer sets its pedigree: (b) or (a). ⚠ And a live count means counting against the database on every keystroke — it wants a debounce and a cheap `count` query, not a full fetch. |
| **Deleting a find field and refilling does not clear the find; editing characters in the find panel should update the find** | ⚠ **This is a real defect rather than a preference** — the panel's state and the executed find disagree, which is the class that makes an operator distrust the tool. Pairs with FIELD-CONTRACT's Find half (*"presence in the FIND vocabulary"*). |

---

## D · DARK MODE — one cluster, one file

**Every one of these lives in `src/theme/hcTheme.ts`'s `buildHCEquipPalette(trimHex, 'dark')`**, which derives the whole palette from the project's trim colour by hue with hand-set saturation/lightness pairs (`ch(hue, sat, light)`). That is good news: it is one file, one function, and the values are already named.

| note | the token I believe it is |
|---|---|
| Category/method **filter labels** hard to read | `filterText: ch(hue, 14, 72)` — and Daniel is right that it is worth auditing the class: `textDim`, `muted`, `sortInactiveTxt` and `filterText` all sit in the 36–72 lightness band. |
| **Project / theatre text** hard to read | `headerText: ch(hue, 22, 84)` in the equip palette; `NORDIC.headerText '#4a8ca8'` on the shell |
| **Category drop-down** text | `selInputText` / `filterInputText: ch(hue, 10, 82)` |
| **Orange default button** | not derived from `hue` — a fixed accent, so it does not follow the trim and is the one that will need its own pairing. **CONTRAST-PAIR already ruled the mechanism** (*"`minotaurColors.ts` ALREADY pairs each colour with readable text … the fix needs a hex→text pairing plus a luminance fallback"*) — this is that ruling arriving on a second surface |
| **Find bar stays light after a find completes** | ⚠ **A missed theme wiring rather than a colour value** — a component still on light tokens. Different fix from the rest of this cluster |
| **Add Criteria / New Request blue buttons**, **× beside Omit** | contrast + hit-target |

**Three ideas for dark-mode readability, as asked — offered as options, not a recommendation, since this is your eye and not a measurement:**

1. **Raise saturation on the two "you are here" surfaces and nothing else.** `rowSelected` is `ch(hue, 20, 16)` and `groupBorderBottom` `ch(hue, 28, 26)`. Taking the selected row and the category band to roughly `ch(hue, 34, 20)` makes position readable at a glance in a dark room **without touching body text**, which is where contrast changes usually go wrong. This is your own suggestion and I think it is the strongest of the three.
2. **Put a floor under dim text.** Every muted token — `filterText 72`, `textDim`, `muted 36`, `sortInactiveTxt 72` — gets a minimum lightness, enforced by a helper rather than by editing values one at a time, so the next token added inherits it. This is the "audit the whole database for text using this dark colour" you asked for, made structural.
3. **Pair the accent with its text the way `minotaurColors.ts` already does.** CONTRAST-PAIR measured that **eight of fourteen palette colours want black text** and that the real fix is a hex→text pairing with a luminance fallback. The orange button is the same defect on the theme's own accent. **Doing 3 discharges part of CONTRAST-PAIR rather than adding work.**

⚠ **All three are gate-frame territory.** The equipment list and the project menu are captured frames, so this is a **declared baseline event** — CC measures which frames move; Arch does not predict.

❓ **Do you want dark mode as ONE unit (all of D together, one baseline event, one gate round), or the find-bar wiring pulled out as a defect and the rest kept as a design pass?** I lean one unit: they share a file and a baseline event, and splitting them means two gate rounds for one file.

---

## E · CHROME

| note | reading |
|---|---|
| **Tab title `Minotaur: Show Name`** | `src/app/layout.tsx:10` sets `title: { template: '%s — Minotaur', default: 'Minotaur Sound System Database' }`, and its own comment warns that a page title renders as `X — Minotaur` unless declared `absolute`. So this is a **template inversion plus a per-project title**, and the project name has to reach the metadata — a server `generateMetadata` with a fetch, or set client-side. ✅ **ANSWERED (Daniel, 2026-09-07): `Minotaur: Buena Vista Social Club // Equipment List`** — he offered it as *"maybe?"*, so the shape is his and the separator is open to a better one.

⚠ **ARCH'S READING, NAMED SO IT IS CORRECTED IN ONE WORD RATHER THAN DISCOVERED:** the third part is the **SCREEN**, not the print document's list band — `// Equipment List`, `// Cable List`, `// Boxes`, `// Print` — so the pattern is **`Minotaur: <Project> // <Screen>`** and it applies to every project page, not only this one. That generalises without a second decision and it is what makes the tab useful with eight of them open. **If he meant the print list name (`Main List`), that is a one-word correction.** |
| **Add project / theatre to the header** | Pairs with the dark-mode readability note on the same text. Do them together |
| **Model field cuts off on the right when the window is narrow** | Not a `text-overflow` rule — `EquipmentItemRow.tsx` sets **no `textOverflow` anywhere** — so it is a flex/width constraint, and *"it doesn't need to cut off"* is the useful half: there is room. Wants measuring at a narrow width before it is designed. ⚠ **KKK-PASS (narrow-window responsive) is already docketed after Sprint 4** — this may be that unit's first real finding rather than its own item |

---

## F · PERFORMANCE

**"Duplicate is slow" — measured at source, and the cause is not mysterious.** `duplicateItem` (`EquipmentListClient.tsx:1196-1231`) makes **three sequential round trips**: `SELECT *` the source row → `INSERT … .select('id')` → `SELECT *` from `v_equipment_list` for the new id. The ⌥⇧D handler adds a fourth wait before them, awaiting `lastCommitRef` so the copy cannot race an in-flight update — **that one is load-bearing and stays** (it fixed a real race, recon 260717-2217).

**So: four serialised hops where one would do.** The shape to copy already exists — CHANGEALL-FOUNDSET built four `SECURITY INVOKER` RPCs through one helper for exactly this reason. A `duplicate_item_v1` returning the view row in a single call collapses three hops into one.

⚠ **That is a MIGRATION — Trigger B, Arch's, rehearsal-first, Daniel confirms before the apply.** It is not a housekeeping item, and it should not ride a UI batch.

✅ **ANSWERED (Daniel, 2026-09-07): *"It's not very long, but it's noticeable compared to other things, so it should get faster."*** That is consistent with the four-hop latency and rules out anything pathological — **no diagnostic measurement is owed before the design.** The RPC is the right fix and the win is real but modest, so it rides a migration window rather than jumping the queue.

---

## SEQUENCING — what I would propose, for your ruling

1. **EQUIP-LIST-PARITY closes** (in flight).
2. **ROADMAP-REFACTOR, carrying the `CLAUDE.md` size work as its first item.** ⚠ **The fence is at 3 characters of headroom. No build unit can write its first finding until this is done.**
3. **FIELD-CONTRACT** — already ruled, already sequenced, and section B above is its acceptance criteria arriving from real use.
4. **The dark-mode unit** (section D), one declared baseline event.
5. **BATCH-HOUSEKEEPING** — the chrome items, the split-dialog selection, the autocomplete portal if it is not pulled early.
6. **`duplicate_item_v1`** with the next migration window, not before.

❓ **Does that order match what the show needs, or does something here have to come sooner?** *(Outstanding.)*
