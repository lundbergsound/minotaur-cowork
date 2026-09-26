# CHANGEALL-REFUSAL — return

⚠ **CP5.2: YES — the EQUIPMENT list has the `Nutes` fallback.** An unmatched name in the Category band editor
(`Nutes`) then Change All offers *"Would you like to replace the "Category" field of these 5 records with
"11.0 Consoles"?"*, the STORED category, on BOTH ⌥⇧\ and the toolbar button (browser-reproduced on a seeded
throwaway). Source: `captureEquipDraftRow`, `EquipmentListClient.tsx:2556-2558`,
`patched = opt ? { ...row, category_name: opt.label } : row // unmatched → stored (revert)`. Not fixed, as
instructed. Method and Model are NOT affected there: method is free text and auto-creates (CHANGEALL-METHODNEW,
ruled), model is free text (694). Quantity has the same shape by reading (`:2544`, NaN → stored) but its input is
`type=number` and would not accept typed letters, so I could not drive it; only a blank draft reaches it.

Base `3809860` = `origin/main` (read from the ref files). Tier line present (`claude-opus-5`); Session FRESH, run
in a fresh session. No migration, no SQL write (execute_sql SELECT-only, twice). Frozen layer untouched. **Every
line citation in the handoff was read at source at `3809860` and matches** (`:4329-4331`, `:4718-4726`, `:3291`,
`:3345`, `:3647`, `:3823`, `:2556`, `:3479`, `:4389`, `:3379`, `:3521-3532`, `cableChangeAll.ts:126-128`,
`cableLength.test.ts:62-64`, the four sibling buttons, `EquipmentListClient.tsx:3264`,
`EquipmentLibraryClient.tsx:542`). Only one claim failed on measurement, and it's a behaviour rather than a
citation: CP1 assumes the dialog would show on Enter. It never did (see DONE).

## DONE

**CP1: the refusal is a dialog.** Both call sites (the inspector's own commit and the Change All capture's
`refuse`) now open the cable list's existing single-OK refusal dialog. **They share `snapshotRefusal`, measured
rather than assumed:** the snapshot refusal is only set after Yes in the Change All dialog or a bulk-delete
confirm, and this refusal only from a field commit or a Change All press with no dialog open, so the two can't be
on screen together. A new `refuseInDialog(message, returnTo)` sets it; OK and Escape both go through
`dismissRefusal`, which sends focus back to the refused field and its record: inspector fields through the panel's
focus request, row fields (Model, Length) through the K-2 pair. `actionError` stays for failed writes only.
Wording unchanged (`unmatchedNameMessage`).

⚠ **What the handoff didn't know: on Enter, the dialog opened and closed itself on the same keystroke.** That
fits Daniel's *"fail - nothing happens, it reverts"*. Measured before any fix: Enter on `Nutes` → no dialog
ever visible, focus back in Method with "Rental" selected. Cause: the refusal is set inside the Enter keydown;
React renders the dialog **and runs its `useEffect`** in that same dispatch, and the effect adds a `window`
keydown listener. `window` comes later on the event's path, so that listener hears the same Enter, confirms, and
closes the dialog. Snapshot refusals never showed this because they open after an `await`. **Fix, in
`ConfirmDialog`: a dialog ignores key events created before it opened** (`e.timeStamp < openedAt`). That's a
change to a shared component. It only drops keystrokes that already existed before the dialog did, so none of
them can have been meant for it.

⚠ **The same defect, worse, in `NewCableTypeDialog` (fixed; outside the handoff's letter, disclosed).** Enter on
an unknown Model is ruled (CP-2) to open the New Cable Type dialog. Measured: the dialog **SAVED on the Enter that
opened it**. A cable type `NoSuchType` was created and assigned to the cable, no dialog was seen, and the DB
changed. That's a silent write in production today, from `NewCableTypeDialog.tsx`, which is byte-identical to
HEAD. Same one-line guard. With it, Enter shows the dialog, Escape cancels, and nothing is written. I fixed it
because CP1 names "model … Enter in the field", and without the guard that path creates data instead of showing
anything. Revert is one line if Arch disagrees.

**Model on Enter is NOT a refusal. I bounced that part of CP1.** The handoff asks all four fields to refuse on
Enter. Model's Enter path is ruled to open New Cable Type (`handleCommitModel`, CP-2: *"it opens the New Cable Type
dialog"*), and I left that alone. Model refuses on the Change All path (⌥⇧|), as colour/category/method do. The
**toolbar-click** path on Model also raises New Cable Type (`AutocompleteInput`'s document-level outside-click
commits the cell first), and no "replace … records" dialog follows. Measured, DB unchanged.

**CP4: a bad length refuses.** `captureCableDraftRow`'s length arm: `invalid → return refuse('length')`, text
*"fifty" isn't a length.* (`invalidLengthMessage`, beside `unmatchedNameMessage`). **The single-edit path
(`handleCommitLength`) DID silently revert** (`if (parsed.kind === 'invalid') return // revert-only, no write`),
so I changed it as the handoff allows: it now opens the same dialog and sets the refused flag, so a toolbar press
that committed the cell first can't then offer the stored length. Measured for `fifty`, `-5` (Tab) and Enter /
click / ⌥⇧|. OK returns to the Length cell showing `50`, selected.

**CP3: Change All greys with nothing current.** `disabled={!changeAllArmed || !currentRowId}`, the sibling
expression (the test checks all four siblings carry it). Measured: after a no-match find, rows 0, current none,
panel disabled, **Change All disabled**; a press can't land. ⌥⇧| is not gated, same as every sibling's chord.
**Equipment (`EquipmentListClient.tsx:3264`) and library (`EquipmentLibraryClient.tsx:542`): both
`disabled={!changeAllArmed}`, with the same arm-once latch** (`:2349-2350`, `:114`/`:692`). Reported, not changed.

**CP2: the screenshot.** `docs/reference/evidence/equipment/changeall_refusal_gate_05_category_subband.png`, light
theme (it matches the adopted `03-equipment-list-method-light` baseline's chrome), Method sort, seeded throwaway,
the first category sub-band circled in red with the tag *"← the category line (click its name to edit)"*. The
throwaway's trim colour is lavender, so on JOY the band takes JOY's own trim hue. **On-screen text, top to
bottom:**
- the line directly ABOVE: **`Rental`**, the method band (dark bar, white text)
- **the band: `11.0 Consoles`**, the paler full-width line under it
- the line directly BELOW: **`1   CL5`**, the model line (quantity then model), followed by the item row
  `1   FOH console … Rental`

The full stack in the shot is `Rental` › `11.0 Consoles` › `CL5` › `FOH console` › `12.0 Microphones` › `SM58` ›
`Spare vocal mic` / `Vocal mic` › `Purchase` › `11.0 Consoles` › `QL1` › `Monitor console` › `12.0 Microphones` ›
`Beta 91A` › `Kick mic`. So in Method sort the category line is the **one right under each method name**, and each
method has one per category.

**CP5.1: Tab after the scope dialog. Focus is DROPPED to `<body>`, not moved.** Reproduced on a throwaway:
equipment list, Method sort, method band `Rental` → typed `Purchase` + Enter → *"There are 3 items with method
"Rental". Which items should be updated?"* [All 3 Items] [Just This One ↵] → Just This One → `activeElement` =
BODY. Tab → the **Category filter** input (`(Any)`, y=143), a second Tab → the Method filter. Those are "the top
menus". The dialog closes in `resolveConfirm`, `EquipmentListClient.tsx:2022-2029` (`setConfirmState(null)`),
rendered at `:3303-3310`. Its focused button unmounts and nothing puts focus back. Stopped there for the Docket.

## FILES CHANGED

CLAUDE.md
docs/reference/verhist-guard-census.md
docs/reference/evidence/equipment/changeall_refusal_gate_05_category_subband.png
src/components/cable/CableListClient.tsx
src/components/cable/NewCableTypeDialog.tsx
src/components/ui/ConfirmDialog.tsx
src/lib/cable/cableChangeAll.ts
src/lib/cable/cableChangeAllRefusal.test.ts
src/lib/cable/cableUnmatchedName.test.ts

## OPEN QUESTIONS

1. **`NewCableTypeDialog` guard: keep it?** It goes beyond the handoff's letter (see DONE). My recommendation is
   to keep it: without it, Enter on an unknown model silently creates and assigns a cable type in production.
2. **Model on Enter.** I kept the ruled New Cable Type dialog and did not build CP1's refusal on that one path
   (Parity: CP-2 is a ruling; CP1 did not cite a reversal). If Daniel wants Enter on an unknown model to refuse
   rather than offer creation, that's his ruling.
3. **Residual on the TAB path (not fixed):** Tab out of an inspector field holding `Nutes` shows the dialog, but the
   panel's own Tab-advance (a `requestAnimationFrame` focus) lands AFTER the dialog focuses OK, so the caret sits
   in **Group behind the dialog** until OK. Enter/Escape still dismiss and return to Method; only typed characters
   would land in Group. The general fix is a focus trap in `ConfirmDialog`. I didn't add one because other
   surfaces focus behind an open dialog on purpose (e.g. Make Patch "interrupts from wherever focus then sits").
4. **A coarse grep finds 28 more files with an unguarded `window` keydown listener that also name a dialog**
   (census in RAW OUTPUT; some are list-level chord handlers, not dialogs). New Box was measured clean (Enter on an
   unmatched box shows its dialog; nothing created). The rest are unmeasured. Any dialog opened synchronously from
   Enter/Escape has the defect. Registered in CLAUDE.md as DIALOG-OPENING-KEY.
5. **For the Docket:** CP5.2 (the equipment Category `Nutes` fallback), CP5.1 (focus drop at `:2022`), and the
   equipment/library Change All latch. All three are carried in CLAUDE.md's "Open, carried" list.
6. **`docs/reference/evidence/equipment/` is an untracked folder**: the four `s4auto_*` files there have never
   been committed. The COMMIT BLOCK stages only this unit's PNG, by explicit filename (plain ASCII, so the
   directory-staging workaround isn't needed). Whether to commit the other four is Daniel's call.
7. **Gate step 5 for Arch to write:** the category line is the pale full-width line directly under a method name,
   with the model line (`quantity  model`) directly under it. I can't read JOY (HARNESS-RLS-CORPUS), so JOY's own
   names aren't quoted here. The shot's texts are the throwaway's.

## RAW OUTPUT

### Pre-open
```
[vercel-preopen] production deployments for minotaur-v2 (newest first):
  LATEST  READY      3809860 [main]  14m ago
          READY      d25d366 [main]  2d ago
          READY      d12b80d [main]  2d ago
[vercel-preopen] LATEST is READY — pre-open OK
exit=0
```

### Suite — `npx vitest run` (final tree)
```
 RUN  v4.1.10 /Users/Daniel/Developer/Minotaur


 Test Files  210 passed (210)
      Tests  3876 passed (3876)
   Start at  18:29:17
   Duration  8.53s (transform 7.28s, setup 0ms, import 13.84s, tests 12.38s, environment 13ms)
```
The run before it had one failure, `src/lib/verhist/guardCensus.test.ts > … matches the census data AND the live line
numbers`. The doc's three Cable List rows still carried pre-unit line numbers (3595/3276/3318 → live 3643/3318/3360),
because my edits shifted the file. Updated in `docs/reference/verhist-guard-census.md` with the Edit tool; the test
now passes.

### Typecheck — `npx tsc --noEmit -p .`
```
TSC_EXIT=0
```
(no output lines)

### Lint — `npx eslint .`
```
LINT_EXIT=0
✖ 265 problems (0 errors, 265 warnings)
  0 errors and 13 warnings potentially fixable with the `--fix` option.
```
265 = `3809860`'s count. A first run read 266; the one addition was mine (`captureCableDraftRow`'s deps missing
`refuseInDialog`, a stable identity) and I added it to the deps.

### Frozen — `node scripts/frozen-gate.mjs` (final tree)
```
PASS  updateItem  (src/components/equipment/EquipmentListClient.tsx vs be0769de, 1125 chars)
PASS  save-error-flash rule  (src/app/globals.css vs be0769de, 81 chars)
PASS  @keyframes save-error-flash  (src/app/globals.css vs be0769de, 126 chars)
frozen exit=0
```

### Dependency gate — `git diff HEAD -- package.json package-lock.json | wc -l`
```
       0
```

### Guarded-code grep (added diff lines + the new untracked test file)
```
added-line matches: 0
```
(a first pass that also counted context lines hit 2: the unchanged `import_apply` rows of the census doc)

### Deletion controls: 9, all RED, all restored byte-identical
Source controls (Edit tool mutate → run → Edit tool restore), result lines verbatim:
```
C1 dialog OK back to `() => setSnapshotRefusal(null)`:
     × the client renders that dialog from the refusal state, with OK and Escape both dismissing 4ms
      Tests  1 failed | 12 passed (13)
C2 inspector refusal back to setActionError:
     × the inspector’s own commit refuses too — the toolbar press never reaches the capture 4ms
     × path 1 — the inspector’s own commit (Enter, Tab, or a toolbar press that committed it) refuses through the dialog 5ms
      Tests  2 failed | 24 passed (26)
C3 capture refusal back to setActionError:
     × the refusal sets the flag, tells the operator, and closes the editor so the text reverts 4ms
     × path 2 — the Change All capture refuses through the dialog, returning to the row cell or the inspector field 4ms
      Tests  2 failed | 24 passed (26)
C4 focus return removed (inspector branch):
     × OK returns focus to the refused field — inspector fields and row fields each through their own seam 4ms
      Tests  1 failed | 12 passed (13)
C5 CP3 back to disabled={!changeAllArmed}:
     × disables on no current cable, not only before the first focus 4ms
      Tests  1 failed | 12 passed (13)
C6 CP4 capture arm removed:
     × the Change All capture refuses an invalid length 4ms
      Tests  1 failed | 12 passed (13)
C7 CP4 single edit back to `return`:
     × the single edit refuses too — it used to revert in silence 5ms
      Tests  1 failed | 12 passed (13)
RESTORED byte-identical 6dd38ac8e5148decdef3fa3d81dec795
```
C8 + C9: both "opening keystroke" guards removed together, suite AND browser:
```
     × ConfirmDialog.tsx ignores key events created before it opened 3ms
     × NewCableTypeDialog.tsx ignores key events created before it opened 1ms
⎯⎯⎯⎯⎯⎯⎯ Failed Tests 2 ⎯⎯⎯⎯⎯⎯⎯
      Tests  2 failed | 13 passed (15)
== insp:enter:method:Nutes
  insp.method/enter: refusal dialog = "NONE"; buttons = []; red span = NONE
  insp.method/enter: DB unchanged = true
== row:enter:model:NoSuchType
  row.model/enter: New Cable Type dialog present = false
  row.model/enter: refusal dialog = "NONE"; buttons = []; red span = NONE
  row.model/enter: DB unchanged = false BEFORE ["C1|Rental|11.0 Consoles|red|null|50ft","C2|Rental|11.0 Consoles|red|null|50ft","C3|Rental|11.0 Consoles|red|null|50ft"] AFTER ["C1|Rental|11.0 Consoles|red|null|50ft","C2|Rental|11.0 Consoles|red|NoSuchType|50ft","C3|Rental|11.0 Consoles|red|null|50ft"]
== row:enter:length:fifty
  row.length/enter: New Cable Type dialog present = false
  row.length/enter: refusal dialog = "NONE"; buttons = []; red span = NONE
  row.length/enter: DB unchanged = true
ALL THREE RESTORED byte-identical
```
(The mutation reproduced both defects in the browser exactly as first measured before any fix: no dialog on Enter,
and `NoSuchType` silently created and stored on C2.)

### Browser smoke: seeded throwaway `ZZCR throwaway …`, `next dev` on :3000, final tree
```
== insp:enter:method:Nutes
  insp.method/enter: refusal dialog = "There's no method called \"Nutes\"."; buttons = ["OK ↵"]; red span = NONE
  insp.method/enter: focus while dialog open = BUTTON value=""
  insp.method/enter: after OK: dialog = "NONE"; focus = INPUT insp=method value="Rental" sel=0-6; field shows = "Rental"; current = C2
  insp.method/enter: after typing "Z": focus = INPUT insp=method value="Z" sel=1-1
  insp.method/enter: a "replace … of these records" dialog appeared at any point = false
  insp.method/enter: DB unchanged = true
== insp:click:method:Nutes
  insp.method/click: refusal dialog = "There's no method called \"Nutes\"."; buttons = ["OK ↵"]; red span = NONE
  insp.method/click: focus while dialog open = BUTTON value=""
  insp.method/click: after OK: dialog = "NONE"; focus = INPUT insp=method value="Rental" sel=0-6; field shows = "Rental"; current = C2
  insp.method/click: after typing "Z": focus = INPUT insp=method value="Z" sel=1-1
  insp.method/click: a "replace … of these records" dialog appeared at any point = false
  insp.method/click: DB unchanged = true
== row:key:model:NoSuchType
  row.model/key: New Cable Type dialog present = false
  row.model/key: refusal dialog = "There's no model called \"NoSuchType\"."; buttons = ["OK ↵"]; red span = NONE
  row.model/key: focus while dialog open = BUTTON value=""
  row.model/key: after OK: dialog = "NONE"; focus = INPUT row-field=model row=c601f58d value="" sel=0-0; field shows = ""; current = C2
  row.model/key: after typing "Z": focus = INPUT row-field=model row=c601f58d value="Z" sel=1-1
  row.model/key: a "replace … of these records" dialog appeared = false
  row.model/key: DB unchanged = true
== row:click:length:fifty
  row.length/click: New Cable Type dialog present = false
  row.length/click: refusal dialog = "\"fifty\" isn't a length."; buttons = ["OK ↵"]; red span = NONE
  row.length/click: focus while dialog open = BUTTON value=""
  row.length/click: after OK: dialog = "NONE"; focus = INPUT row-field=length row=c601f58d value="50" sel=0-2; field shows = "50"; current = C2
  row.length/click: after typing "Z": focus = INPUT row-field=length row=c601f58d value="Z" sel=1-1
  row.length/click: a "replace … of these records" dialog appeared = false
  row.length/click: DB unchanged = true
== row:enter:model:NoSuchType
  row.model/enter: New Cable Type dialog present = true
  row.model/enter: dialogs on screen = "New Cable Type: NoSuchType || This is a new cable type. Add its defaults below — all fields are optional, and you may edit them later. || ENDS & LINES || LABELS || SPECIFICATIONS || TAILS || (if blank, new tails use the project's default method)"
  row.model/enter: after Escape: dialogs = "NONE"; focus = INPUT row-field=model row=e7ac340a value="" sel=0-0
  row.model/enter: a "replace … of these records" dialog appeared = false
  row.model/enter: DB unchanged = true
== findnone
  armed, before find: {"rows":3,"current":"C1","changeAllDisabled":false,"methodField":"LIVE"}
  after a find with no results: {"rows":0,"current":"none","changeAllDisabled":true,"methodField":"disabled"}
  press: locator.click: Timeout 1500ms exceeded.
  dialog after press: "NONE"
```
(`press: … Timeout` is Playwright refusing to click a disabled button, which is the intended result.) Earlier runs
on the same tree logic, also green: Enter/Tab/click/⌥⇧| × method/category/colour; OK dismissed by click, Enter and
Escape; length via Enter, Tab (`-5`), ⌥⇧|; model via toolbar click (New Cable Type raised, no replace dialog, DB
unchanged); a matched method (`Purchase`) and a valid length (`25m`) still reach *"Would you like to replace …"*.
The Tab path's caret-behind-the-dialog is OQ3:
```
  insp.method/tab: refusal dialog = "There's no method called \"Nutes\"."; buttons = ["OK ↵"]; red span = NONE
  insp.method/tab: focus while dialog open = INPUT insp=group value="" sel=0-0
  insp.method/tab: after OK: dialog = "NONE"; focus = INPUT insp=method value="Rental" sel=0-6; field shows = "Rental"; current = C2
```

### CP5 measurements (same throwaway)
```
== eqcat:key:Nutes
  band before: "11.0 Consoles"
  eqcat/key: dialog = "Would you like to replace the \"Category\" field of these 5 records with \"11.0 Consoles\"?"
  eqcat/key: DB unchanged = true
== eqcat:click:Nutes
  band before: "11.0 Consoles"
  eqcat/click: dialog = "Would you like to replace the \"Category\" field of these 5 records with \"11.0 Consoles\"?"
  eqcat/click: DB unchanged = true
== eqqty:key:abc
  CASE THREW locator.fill: Error: Cannot type text into input[type=number]
== eqtab:just
  method band: "Rental"
  prompt: "There are 3 items with method \"Rental\". Which items should be updated?" buttons: ["All 3 Items","Just This One ↵"]
  focus while prompt open: BUTTON  text="" placeholder="" at y=513 x=844 label="All 3 ItemsJust This One ↵"
  focus after answering: BODY
  focus after Tab: INPUT  text="" placeholder="(Any)" at y=143 x=72 label="(Any)(No Category)(Has Category)11.0 Con"
  focus after 2nd Tab: INPUT  text="" placeholder="(Any)" at y=143 x=227 label="(Any)(No Method)(Has Method)RentalPurcha"
== boxenter
  boxenter: New Box dialog on screen = true; dialogs = "New Box || Create box “Sam I am” and put this record in it. Type and number are optional — you can fill them in later on the Box List."
  boxenter: boxes before=0 after=0; cables=["C1:-","C2:-","C3:-"]
```
(each eqcat dialog was answered **No**, which writes the stored category back to the one active record: a no-op)

### CP2 texts (the capture's own DOM read)
```
 "band": { "text": "11.0 Consoles", "rect": [ 0, 255, 1600, 28 ] },
 "above": { "kind": "band (method_name)", "text": "Rental", "y": 227 },
 "below": { "kind": "model band", "text": "1 CL5 1 FOH console Rental — 0 ✓ ✓ ✓ ✓", "y": 283 },
 "allSubBands": [ "11.0 Consoles", "12.0 Microphones", "11.0 Consoles", "12.0 Microphones" ],
 "outerBands": [ "Rental", "Purchase" ]
```

### Unguarded window-keydown census (coarse grep, for OQ4)
```
src/components/boxes/BoxListClient.tsx src/components/boxes/BoxTypesAdminClient.tsx src/components/boxes/NewBoxDialog.tsx src/components/boxes/NewBoxTypeDialog.tsx src/components/cable/AddCablesToGroupDialog.tsx src/components/cable/BulkCableDeleteDialog.tsx src/components/cable/BundleListClient.tsx src/components/cable/CableDeleteDialog.tsx src/components/cable/CableListClient.tsx src/components/cable/DeleteBundleDialog.tsx src/components/cable/DuplicateBundleDialog.tsx src/components/cable/DuplicateChildrenDialog.tsx src/components/cable/EditLinksDialog.tsx src/components/cable/RenameCableCopyDialog.tsx src/components/cable/UpdateBundleDialog.tsx src/components/dashboard/DeleteProjectDialog.tsx src/components/dashboard/ShareProjectDialog.tsx src/components/equipment/AddToListDialog.tsx src/components/equipment/CategoriesAdminClient.tsx src/components/equipment/EquipmentLibraryClient.tsx src/components/equipment/EquipmentListClient.tsx src/components/equipment/MergeMethodsDialog.tsx src/components/equipment/MethodsAdminClient.tsx src/components/equipment/OverSplitDialog.tsx src/components/equipment/PreviousRevisionsClient.tsx src/components/equipment/SplitDialog.tsx src/components/line/LineListClient.tsx src/components/tail/TailListClient.tsx
```

### Visual gate: `node --env-file=.env.local scripts/visual-capture.mjs --gate > /tmp/cr-visual.txt` (GATE-NOGREP; fired by a load poller at 4.30, no `--force-load`; :3000 was MY `next dev` of this tree, checked empty first)
```
[visual-capture] mode gate; port :3000; 1-minute load average 4.30 (ceiling 5.00)
[visual-capture] reusing existing dev server on :3000 — verified Next dev, middleware matcher matches src/middleware.ts
[visual-capture] logging in…
[visual-capture] stored theme_preference at run start: dark
[visual-capture] finding fixture project "Visual Gate Fixture"…
[visual-capture] using project 0d308b93-fc26-4389-b00f-c35e2170c7ee
[visual-capture] fixture sort pinned to category at run start
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/01-project-menu-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/02-equipment-list-category-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/03-equipment-list-method-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/04-library-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/05-gcm-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/06-settings-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/07-print-revision-stamp-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/08-find-active-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/09-box-list-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/10-box-detail-panel-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/11-box-nesting-error-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/12-box-type-plus-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/13-boxes-menu-tab-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/14-box-types-admin-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/01-project-menu-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/02-equipment-list-category-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/03-equipment-list-method-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/04-library-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/05-gcm-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/06-settings-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/07-print-revision-stamp-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/08-find-active-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/09-box-list-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/10-box-detail-panel-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/11-box-nesting-error-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/12-box-type-plus-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/13-boxes-menu-tab-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/14-box-types-admin-dark.png
[visual-capture] done — 28 captures written.
[visual-capture] theme_preference restored to 'dark'

[visual-capture] GATE REPORT
[visual-capture] served from :3000
[visual-capture] load average at run start: 4.30 (ceiling 5.00)
[visual-capture] judged at channel threshold 24, pixel threshold ZERO (0.0000% — any judged pixel moves the frame); measured lines are zero-tolerance (Δ>=1)
[visual-capture] diff-exception registry: 5 site(s) armed, 32 px excluded this run across 2 frame(s) (zero-tolerance aggregates only — the judged verdict is never masked)
[visual-capture] ----------------------------------------------------------------------
[visual-capture] PASS  01-project-menu-light        0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  02-equipment-list-category-light 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: 0 px unexcluded (excluded 16 px: subpixel-wander/topbar-theme-toggle-glyph×16)
[visual-capture] PASS  03-equipment-list-method-light 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: 0 px unexcluded (excluded 16 px: subpixel-wander/topbar-theme-toggle-glyph×16)
[visual-capture] PASS  04-library-light             0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  05-gcm-light                 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  06-settings-light            0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  07-print-revision-stamp-light 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  08-find-active-light         0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  09-box-list-light            0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  10-box-detail-panel-light    0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  11-box-nesting-error-light   0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  12-box-type-plus-light       0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  13-boxes-menu-tab-light      0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  14-box-types-admin-light     0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  01-project-menu-dark         0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  02-equipment-list-category-dark 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  03-equipment-list-method-dark 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  04-library-dark              0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  05-gcm-dark                  0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  06-settings-dark             0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  07-print-revision-stamp-dark 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  08-find-active-dark          0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  09-box-list-dark             0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  10-box-detail-panel-dark     0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  11-box-nesting-error-dark    0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  12-box-type-plus-dark        0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  13-boxes-menu-tab-dark       0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  14-box-types-admin-dark      0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] ----------------------------------------------------------------------
[visual-capture] 28/28 surfaces passed
[visual-capture] gate PASSED — all surfaces match baseline
[visual-capture] full report written to /Users/Daniel/Developer/Minotaur/screenshots/gate/gate-report-2026-09-24T22-35-46-707Z.txt
```
No baseline event fired, as the handoff expected (a dialog renders nothing at rest). The 16 px on 02/03-light are the
registry's Δ1 topbar-glyph wander site, excluded from the ch0 aggregate only; the judged count is 0 on every frame.
Per GATE-THEMEGLYPH this is one green run, not a claim that the glyph question is settled.

### Build: `npm run build` (after stopping my dev server; :3000 and :3100 both empty, so no one else's `.next` was replaced)
```
> minotaur-v2@0.1.0 build
> next build

▲ Next.js 16.3.3 (Turbopack)
- Environments: .env.local
✓ Running next.config.js took 8ms

⚠ The "middleware" file convention is deprecated. Please use "proxy" instead.

  To migrate automatically, run:
  npx @next/codemod@canary middleware-to-proxy .

  Learn more: https://nextjs.org/docs/messages/middleware-to-proxy
  Creating an optimized production build ...
✓ Compiled successfully in 2.8s
  Running TypeScript ...
  Finished TypeScript in 2.4s ...
  Collecting page data using 9 workers ...
  Generating static pages using 9 workers (0/14) ...
  Generating static pages using 9 workers (3/14) 
  Generating static pages using 9 workers (6/14) 
  Generating static pages using 9 workers (10/14) 
✓ Generating static pages using 9 workers (14/14) in 182ms
  Finalizing page optimization ...

Route (app)
┌ ○ /
├ ○ /_not-found
├ ○ /account/password
├ ƒ /api/waitlist
├ ƒ /auth/callback
├ ƒ /auth/confirm
├ ƒ /auth/confirm/verify
├ ƒ /auth/forgot
├ ○ /auth/login
├ ○ /auth/signup
├ ○ /beta-terms
├ ƒ /dashboard
├ ƒ /dashboard/new
├ ƒ /project/[projectId]
├ ƒ /project/[projectId]/boxes
├ ƒ /project/[projectId]/boxes/print-contents
├ ƒ /project/[projectId]/boxes/print-labels
├ ƒ /project/[projectId]/boxes/print-list
├ ƒ /project/[projectId]/boxes/types
├ ƒ /project/[projectId]/cable
├ ƒ /project/[projectId]/cable/bundles
├ ƒ /project/[projectId]/cable/lines
├ ƒ /project/[projectId]/cable/print-balun-labels
├ ƒ /project/[projectId]/cable/print-bundle-labels
├ ƒ /project/[projectId]/cable/print-bundle-sheets
├ ƒ /project/[projectId]/cable/print-bundle-summary
├ ƒ /project/[projectId]/cable/print-checklist
├ ƒ /project/[projectId]/cable/print-folder-labels
├ ƒ /project/[projectId]/cable/print-labels
├ ƒ /project/[projectId]/cable/print-line-list
├ ƒ /project/[projectId]/cable/print-steck-labels
├ ƒ /project/[projectId]/cable/print-tail-block-labels
├ ƒ /project/[projectId]/cable/print-tail-checklist
├ ƒ /project/[projectId]/cable/print-tail-folder-labels
├ ƒ /project/[projectId]/cable/print-tail-line-labels
├ ƒ /project/[projectId]/cable/print-tail-panel-labels
├ ƒ /project/[projectId]/cable/tails
├ ƒ /project/[projectId]/cable/types
├ ƒ /project/[projectId]/cover-letter
├ ƒ /project/[projectId]/equipment
├ ƒ /project/[projectId]/equipment/library
├ ƒ /project/[projectId]/equipment/methods
├ ƒ /project/[projectId]/equipment/print
├ ƒ /project/[projectId]/equipment/print-device-patch
├ ƒ /project/[projectId]/equipment/print-group-parts
├ ƒ /project/[projectId]/equipment/print-labels
├ ƒ /project/[projectId]/history
├ ƒ /project/[projectId]/import
├ ƒ /project/[projectId]/revisions
└ ƒ /project/[projectId]/settings


ƒ Proxy (Middleware)

○  (Static)   prerendered as static content
ƒ  (Dynamic)  server-rendered on demand
BUILD_EXIT=0
```
No warnings beyond MIDDLEWARE-PROXY, which is registered. `.next` now holds this tree's build; **restart `:3100`
before the browser gate**, as the handoff says.

### Throwaway census (script, then SELECT-only execute_sql)
```
cleaned 1 census projects by name: 0
[{"zzcr_projects":0,"zzca_projects":0,"nosuchtype_cable_types":0,"orphan_items":0}]
```
(`cable_types.project_id` is `ON DELETE CASCADE`, read from information_schema, so the one `NoSuchType` the
pre-fix measurement created went with its throwaway project; the census confirms it.)

## SED LEDGER

**Entry 1: one bash-mediated repo write (the PNG).** No `sed`/`perl`/`gawk`/`ruby` in-place edit ran.
1. Verbatim command:
   `cp /private/tmp/claude-501/-Users-Daniel-Developer-Minotaur/222cace5-1366-4362-bdb6-5f52a5156595/scratchpad/cp2_category_subband.png docs/reference/evidence/equipment/changeall_refusal_gate_05_category_subband.png`
2. Intent: place CP2's screenshot where the handoff asked. A bash write because a PNG can't go through the Edit
   or Write tool (text only). It's a single file, but the single-file rule's Edit-tool alternative doesn't exist
   for binary content.
3. Scope: a NEW untracked binary; `git diff --stat` does not list untracked files. Immediately after:
   ```
    src/components/cable/CableListClient.tsx    | 81 ++++++++++++++++++++++++-----
    src/components/cable/NewCableTypeDialog.tsx |  8 +++
    src/components/ui/ConfirmDialog.tsx         |  9 ++++
    src/lib/cable/cableChangeAll.ts             | 16 +++++-
    src/lib/cable/cableUnmatchedName.test.ts    | 11 ++--
    5 files changed, 106 insertions(+), 19 deletions(-)
   ```
   and the folder listing: `changeall_refusal_gate_05_category_subband.png` 115076 bytes, beside the four untouched
   `s4auto_*` files (sizes and Aug 21 mtimes unchanged).
4. Frozen assertion: not a frozen-layer file. Frozen gate IMMEDIATELY after:
   ```
   PASS  updateItem  (src/components/equipment/EquipmentListClient.tsx vs be0769de, 1125 chars)
   PASS  save-error-flash rule  (src/app/globals.css vs be0769de, 81 chars)
   PASS  @keyframes save-error-flash  (src/app/globals.css vs be0769de, 126 chars)
   frozen exit=0
   ```

## COMMIT BLOCK

0. ⚠ **BROWSER GATE: OWED by Daniel, not run.** Restart `:3100` first. Cable Parity Fixture, steps 1–4 as the
   handoff wrote them, plus step 5 (the category line) once Arch writes it from CP2's shot. Two notes on the
   steps, from measurement: in step 1 the field shows the stored value **selected** after OK, so the next
   keystroke replaces it. Worth adding a step: **Model box, type `NoSuchType`, press Enter → the New Cable Type
   dialog appears and stays up; Escape → nothing created** (today it silently creates one). Please tell me the
   result in the terminal before the phrase (GATE-REPORTING).
1. `git add CLAUDE.md docs/reference/verhist-guard-census.md docs/reference/evidence/equipment/changeall_refusal_gate_05_category_subband.png src/components/cable/CableListClient.tsx src/components/cable/NewCableTypeDialog.tsx src/components/ui/ConfirmDialog.tsx src/lib/cable/cableChangeAll.ts src/lib/cable/cableChangeAllRefusal.test.ts src/lib/cable/cableUnmatchedName.test.ts`
2. `git status --short`. Expected: 9 staged lines, 7 beginning `M ` and 2 beginning `A `
   (`…changeall_refusal_gate_05_category_subband.png`, `…cableChangeAllRefusal.test.ts`), plus the untracked
   `?? "Claude outputs/"` and `?? docs/reference/evidence/equipment/` (the four older `s4auto_*` files stay out).
3. `git commit -m "CHANGEALL-REFUSAL: a refused Change All says so in a dialog; Change All greys with nothing found; a bad length refuses" -m "The unmatched-name and invalid-length refusals open the cable list's single-OK refusal dialog and OK returns focus to the field. A dialog no longer answers the keystroke that opened it (ConfirmDialog, NewCableTypeDialog): on Enter the refusal closed itself unseen, and New Cable Type saved a type unseen. Change All disables with no current cable. The single-edit length path refuses instead of reverting in silence."`
4. `git push`

---

# ROUND 2 — ADDENDUM `260924-1846_changeall-refusal_ADDENDUM.md` (CP6, the equipment Category fallback), 2026-09-24 ~19:05

Session CONTINUE, as the addendum says. **This round's COMMIT BLOCK supersedes the one above** (the unit is now
13 files, not 9).

## DONE

**CP6: an unmatched category name on the EQUIPMENT list refuses.** Built as ruled (Daniel: *"fold it in"*):

- **The Change All capture** (`captureEquipDraftRow`'s category arm): a non-blank draft that matches no category
  now closes the editor, sets `changeAllRefusedRef`, opens the refusal and returns `null`. `requestChangeAll`
  reads and clears that flag **first**. The flag is needed because, to the shared invoker, `null` means "no
  in-flight edit, use the stored row", and the stored row is exactly the fallback being refused. D2 below shows
  that without the flag, the refusal and the stored-value replace dialog open **together**. ⌥⇧\ and the toolbar
  button both reach this capture, because the equipment button carries the BOXNULL-TOOLBAR mark, so no
  outside-click commit runs first.
- **The single-edit path, measured, then fixed as item 4 allows.** Both category editors (category sort's band
  and MMM-CAT's sub-band in Method/Box/Group sort) ended their commit with `if (!matchedOption) return`. `Nutes`
  plus Enter, Tab or a click away closed the editor in silence and showed the old name again: the same "reverts
  in silence" as length. Both now refuse through the same dialog. Enter and Tab also consume a
  `categoryRefusedRef`, so a refused commit doesn't also advance to the next band or into Quantity. A blank
  commit is unchanged (a silent no-op), because CP6 rules on names, not emptied boxes.
- **The dialog is the equipment list's existing one** (`snapshotRefusal`, `:3294-3300` at `3809860`), shared on the
  same measured reasoning as the cable list. Its two setters (`:2598` Change All guard, `:2867` delete guard) both
  run after an `await` behind a confirm, and this refusal only runs from an editor commit or a Change All press
  with no dialog open.
- **OK / Enter / Escape** go through `dismissRefusal`, which re-activates the band's target record and reopens
  **the editor it came from** through the existing `pendingBandFocusRef` seam (`kind: 'category'`, focus +
  select + scroll). Measured on every path: *after OK: focus = INPUT OUTER-BAND / SUB-BAND value="11.0 Consoles"
  sel=0-13*, and the next keystroke replaces it. The band key is carried from the editor that refused (the
  capture reads it off the input's own `[data-category-band]` marker), so the outer band and the sub-band each
  get back their own.
- **Wording, and the seam:** importing `src/lib/cable/cableChangeAll.ts` into the equipment list would be the
  wrong seam, since that file is the cable surface's pure module, keyed on cable field names. **The sentence moved
  to `noSuchNameMessage(fieldLabel, typed)` in `src/lib/changeAllInvoke.ts`**, the cross-surface pure Change All
  module both lists already import. The cable `unmatchedNameMessage(field, typed)` is now a typed wrapper over
  it, so every cable call site and test is unchanged (a test pins that it says exactly what it said before). The
  equipment list calls it with `EQUIP_CHANGE_ALL_FIELD_LABELS.category_name` (`'Category'`). The text:
  *There's no category called "Nutes".*
- **A matched name is unchanged** (measured): ⌥⇧\ with `12.0 Microphones` still asks *"Would you like to replace
  the "Category" field of these 5 records with "12.0 Microphones"?"*, and Enter with it still cascades
  (FOH console → 12.0 Microphones, no prompt, since it has no model siblings).

**Two test/doc follow-ons, both mechanical:** MMM-CAT's call-site test pinned the literal
`if (!matchedOption) return` on the sub-band. It now pins `if (!matchedOption) {` plus the refusal, and says why.
The VERHIST census doc's two Equipment List line numbers moved (2573 → 2632, 2855 → 2914) and were updated with
the Edit tool. The guardCensus test failed until then.

**A smoke-script slip, disclosed:** one run of my scratchpad script assumed Category sort, but sort persists per
project and the throwaway was still in Method sort. So `Nutes` and `12.0 Microphones` went into **method** band
editors, where a new name is ruled to create a method (CHANGEALL-METHODNEW). Two methods were created **on the
throwaway only**. That was the script, not the app. The script now clicks the sort it means; the throwaway was
reseeded and the cases re-run clean. Census below shows 0 left.

## FILES CHANGED (the whole unit, 13)

CLAUDE.md
docs/reference/verhist-guard-census.md
docs/reference/evidence/equipment/changeall_refusal_gate_05_category_subband.png
src/components/cable/CableListClient.tsx
src/components/cable/NewCableTypeDialog.tsx
src/components/equipment/EquipmentListClient.tsx
src/components/ui/ConfirmDialog.tsx
src/lib/cable/cableChangeAll.ts
src/lib/cable/cableChangeAllRefusal.test.ts
src/lib/cable/cableUnmatchedName.test.ts
src/lib/changeAllInvoke.ts
src/lib/equipment/equipCategoryRefusal.test.ts
src/lib/equipment/mmmCatSubBand.callSites.test.ts

## OPEN QUESTIONS

1. **A BLANK category draft + Change All still offers the stored category**, and a blank commit on a category
   editor is still a silent no-op. I left both alone as instructed: CP6 rules on a typed name. It's the same
   fallback shape as Quantity's NaN arm (item 6 of the addendum), so it belongs on that Docket row.
2. **Click-away path: while the refusal is open, focus sits on BODY, not on OK.** The click that blurred the editor
   lands after the dialog focused OK. Enter/Escape still dismiss (window listener), and OK/Escape reopen the
   editor. Same family as round 1's OQ3, so I registered it rather than fixing it.
3. **D5 (the advance consume) shows RED in the suite but not in the browser's end state.** Without it, the next
   band's editor opens behind the dialog, and OK then reopens the refused one anyway. I kept it because it stops an
   editor opening behind a modal. Say if you'd rather not carry it.
4. Arch's answers to round 1's OQs are taken as given: NewCableTypeDialog guard kept, Model-on-Enter bounce
   accepted, the Tab residual and the DIALOG-OPENING-KEY census registered, and the four `s4auto_*` files stay out.

## RAW OUTPUT (round 2)

### Suite: `npx vitest run` (final tree)
```

 Test Files  211 passed (211)
      Tests  3888 passed (3888)
   Start at  19:02:01
   Duration  7.73s (transform 6.24s, setup 0ms, import 12.40s, tests 11.52s, environment 13ms)

SUITE_EXIT=0
```
(the first post-CP6 run had exactly these two failures, both addressed in DONE:)
```
     × ⚠ its generated block matches the census data AND the live line numbers 64ms
     × set-existing-only by the selected option’s id, and a pristine commit is a silent no-op 5ms
 FAIL  src/lib/equipment/mmmCatSubBand.callSites.test.ts > MMM-CAT — the category sub-band is an edit surface, scoped to itself > set-existing-only by the selected option’s id, and a pristine commit is a silent no-op
 FAIL  src/lib/verhist/guardCensus.test.ts > docs/reference/verhist-guard-census.md is the same census > ⚠ its generated block matches the census data AND the live line numbers
 Test Files  2 failed | 209 passed (211)
      Tests  2 failed | 3886 passed (3888)
```

### Typecheck / lint / frozen / dependency / guarded grep (final tree)
```
TSC_EXIT=0
LINT_EXIT=0
✖ 265 problems (0 errors, 265 warnings)
  0 errors and 13 warnings potentially fixable with the `--fix` option.

PASS  updateItem  (src/components/equipment/EquipmentListClient.tsx vs be0769de, 1125 chars)
PASS  save-error-flash rule  (src/app/globals.css vs be0769de, 81 chars)
PASS  @keyframes save-error-flash  (src/app/globals.css vs be0769de, 126 chars)
frozen exit=0
       0
added-line matches: 0
```
(`0` = `git diff HEAD -- package.json package-lock.json | wc -l`; the guarded grep now also reads the new
`equipCategoryRefusal.test.ts`)

### CP6 deletion controls: 7, all RED, all restored byte-identical (`eea64aafbc5aeabea40ce8dc0ca8ca58`)
```
D1 capture refusal disabled (`if (false && …)`):
     × an unmatched, non-blank draft refuses, closes the editor and returns null — never the stored row 4ms
      Tests  1 failed | 32 passed (33)
  browser:
  eqref.category.outer/key: band "11.0 Consoles"; dialog = "Would you like to replace the \"Category\" field of these 5 records with \"11.0 Consoles\"?"; buttons = ["No","Yes ↵"]; focus while open = BUTTON value=""
  eqref.method.sub/click: band "12.0 Microphones"; dialog = "Would you like to replace the \"Category\" field of these 5 records with \"12.0 Microphones\"?"; buttons = ["No","Yes ↵"]; focus while open = BUTTON value=""
D2 requestChangeAll's flag read removed:
     × requestChangeAll reads and clears the refusal FIRST, so no dialog opens over the stored row 5ms
      Tests  1 failed | 11 passed (12)
  browser:
  eqref.category.outer/key: band "11.0 Consoles"; dialog = "There's no category called \"Nutes\". || Would you like to replace the \"Category\" field of these 5 records with \"11.0 Consoles\"?"; buttons = ["OK ↵","No","Yes ↵"]; focus while open = BUTTON value=""
D3 category-sort band's commit refusal removed:
     × the category-sort band refuses before it could cascade 6ms
      Tests  1 failed | 11 passed (12)
  browser:
  eqref.category.outer/enter: band "11.0 Consoles"; dialog = "NONE"; buttons = []; focus while open = INPUT OUTER-BAND value="12.0 Microphones" sel=0-16
D4 sub-band's commit refusal removed:
     × set-existing-only by the selected option’s id, and a pristine commit is a silent no-op 6ms
     × MMM-CAT’s sub-band refuses before it could cascade 6ms
      Tests  2 failed | 31 passed (33)
D5 outer band Enter-advance consume removed:
     × a refused commit does not also advance — Enter and Tab consume the flag on both editors 5ms
      Tests  1 failed | 11 passed (12)
  browser (end state after OK identical, see OQ3):
  eqref.category.outer/enter: after OK: dialog = "NONE"; focus = INPUT OUTER-BAND value="11.0 Consoles" sel=0-13
D6 + D7 focus seam removed from dismissRefusal, and the dialog wired back to setSnapshotRefusal(null):
     × the snapshot-refusal dialog is the one it opens, and both its buttons dismiss through dismissRefusal 4ms
     × OK reopens that category editor on its record, selected, through the band-focus seam 2ms
      Tests  2 failed | 10 passed (12)
  browser:
  eqref.category.outer/key: after OK: dialog = "NONE"; focus = BODY
RESTORED byte-identical eea64aafbc5aeabea40ce8dc0ca8ca58
 Test Files  59 passed (59)
      Tests  788 passed (788)
```
(D3's browser line: with the refusal gone, Enter closed the band in silence and advanced into the NEXT band's
editor, `12.0 Microphones`. That's the defect as it was.)

### CP6 browser smoke: fresh throwaway, `next dev` on :3000, final tree
```
== eqref:category:outer:key:Nutes
  eqref.category.outer/key: band "11.0 Consoles"; dialog = "There's no category called \"Nutes\"."; buttons = ["OK ↵"]; focus while open = BUTTON value=""
  eqref.category.outer/key: after OK: dialog = "NONE"; focus = INPUT OUTER-BAND value="11.0 Consoles" sel=0-13
  eqref.category.outer/key: after typing "Z": focus = INPUT OUTER-BAND value="Z" sel=1-1
  eqref.category.outer/key: replace dialog appeared = false; DB unchanged = true
== eqref:category:outer:click:Nutes
  eqref.category.outer/click: band "11.0 Consoles"; dialog = "There's no category called \"Nutes\"."; buttons = ["OK ↵"]; focus while open = BUTTON value=""
  eqref.category.outer/click: after OK: dialog = "NONE"; focus = INPUT OUTER-BAND value="11.0 Consoles" sel=0-13
  eqref.category.outer/click: after typing "Z": focus = INPUT OUTER-BAND value="Z" sel=1-1
  eqref.category.outer/click: replace dialog appeared = false; DB unchanged = true
== eqref:category:outer:enter:Nutes
  eqref.category.outer/enter: band "11.0 Consoles"; dialog = "There's no category called \"Nutes\"."; buttons = ["OK ↵"]; focus while open = BUTTON value=""
  eqref.category.outer/enter: after OK: dialog = "NONE"; focus = INPUT OUTER-BAND value="11.0 Consoles" sel=0-13
  eqref.category.outer/enter: after typing "Z": focus = INPUT OUTER-BAND value="Z" sel=1-1
  eqref.category.outer/enter: replace dialog appeared = false; DB unchanged = true
== eqref:category:outer:tab:Nutes
  eqref.category.outer/tab: band "11.0 Consoles"; dialog = "There's no category called \"Nutes\"."; buttons = ["OK ↵"]; focus while open = BUTTON value=""
  eqref.category.outer/tab: after OK: dialog = "NONE"; focus = INPUT OUTER-BAND value="11.0 Consoles" sel=0-13
  eqref.category.outer/tab: after typing "Z": focus = INPUT OUTER-BAND value="Z" sel=1-1
  eqref.category.outer/tab: replace dialog appeared = false; DB unchanged = true
== eqref:category:outer:away:Nutes
  eqref.category.outer/away: band "11.0 Consoles"; dialog = "There's no category called \"Nutes\"."; buttons = ["OK ↵"]; focus while open = BODY
  eqref.category.outer/away: after OK: dialog = "NONE"; focus = INPUT OUTER-BAND value="11.0 Consoles" sel=0-13
  eqref.category.outer/away: after typing "Z": focus = INPUT OUTER-BAND value="Z" sel=1-1
  eqref.category.outer/away: replace dialog appeared = false; DB unchanged = true
== eqref:method:sub:key:Nutes
  eqref.method.sub/key: band "11.0 Consoles"; dialog = "There's no category called \"Nutes\"."; buttons = ["OK ↵"]; focus while open = BUTTON value=""
  eqref.method.sub/key: after OK: dialog = "NONE"; focus = INPUT SUB-BAND value="11.0 Consoles" sel=0-13
  eqref.method.sub/key: after typing "Z": focus = INPUT SUB-BAND value="Z" sel=1-1
  eqref.method.sub/key: replace dialog appeared = false; DB unchanged = true
== eqref:method:sub:click:Nutes
  eqref.method.sub/click: band "11.0 Consoles"; dialog = "There's no category called \"Nutes\"."; buttons = ["OK ↵"]; focus while open = BUTTON value=""
  eqref.method.sub/click: after OK: dialog = "NONE"; focus = INPUT SUB-BAND value="11.0 Consoles" sel=0-13
  eqref.method.sub/click: after typing "Z": focus = INPUT SUB-BAND value="Z" sel=1-1
  eqref.method.sub/click: replace dialog appeared = false; DB unchanged = true
== eqref:method:sub:enter:Nutes
  eqref.method.sub/enter: band "11.0 Consoles"; dialog = "There's no category called \"Nutes\"."; buttons = ["OK ↵"]; focus while open = BUTTON value=""
  eqref.method.sub/enter: after OK: dialog = "NONE"; focus = INPUT SUB-BAND value="11.0 Consoles" sel=0-13
  eqref.method.sub/enter: after typing "Z": focus = INPUT SUB-BAND value="Z" sel=1-1
  eqref.method.sub/enter: replace dialog appeared = false; DB unchanged = true
== eqref:method:sub:tab:Nutes:Enter
  eqref.method.sub/tab: band "11.0 Consoles"; dialog = "There's no category called \"Nutes\"."; buttons = ["OK ↵"]; focus while open = BUTTON value=""
  eqref.method.sub/tab: after Enter: dialog = "NONE"; focus = INPUT SUB-BAND value="11.0 Consoles" sel=0-13
  eqref.method.sub/tab: after typing "Z": focus = INPUT SUB-BAND value="Z" sel=1-1
  eqref.method.sub/tab: replace dialog appeared = false; DB unchanged = true
== eqref:method:sub:away:Nutes:Escape
  eqref.method.sub/away: band "11.0 Consoles"; dialog = "There's no category called \"Nutes\"."; buttons = ["OK ↵"]; focus while open = BODY
  eqref.method.sub/away: after Escape: dialog = "NONE"; focus = INPUT SUB-BAND value="11.0 Consoles" sel=0-13
  eqref.method.sub/away: after typing "Z": focus = INPUT SUB-BAND value="Z" sel=1-1
  eqref.method.sub/away: replace dialog appeared = false; DB unchanged = true
== insp:enter:category:Nope
  insp.category/enter: refusal dialog = "There's no category called \"Nope\"."; buttons = ["OK ↵"]; red span = NONE
  insp.category/enter: focus while dialog open = BUTTON value=""
  insp.category/enter: after OK: dialog = "NONE"; focus = INPUT insp=category value="11.0 Consoles" sel=0-13; field shows = "11.0 Consoles"; current = C2
  insp.category/enter: after typing "Z": focus = INPUT insp=category value="Z" sel=1-1
  insp.category/enter: a "replace … of these records" dialog appeared at any point = false
  insp.category/enter: DB unchanged = true
== insp:key:method:Nutes
  insp.method/key: refusal dialog = "There's no method called \"Nutes\"."; buttons = ["OK ↵"]; red span = NONE
  insp.method/key: focus while dialog open = BUTTON value=""
  insp.method/key: after OK: dialog = "NONE"; focus = INPUT insp=method value="Rental" sel=0-6; field shows = "Rental"; current = C2
  insp.method/key: after typing "Z": focus = INPUT insp=method value="Z" sel=1-1
  insp.method/key: a "replace … of these records" dialog appeared at any point = false
  insp.method/key: DB unchanged = true
== eqgood:enter
  eqgood/enter: dialog = "NONE"; buttons = []
  eqgood/enter: DB ["cab A||Rental|11.0 Consoles|q1","cab B||Rental|11.0 Consoles|q1","cab C||Rental|11.0 Consoles|q1","FOH console|CL5|Rental|12.0 Microphones|q1","Kick mic|Beta 91A|Purchase|12.0 Microphones|q1","Monitor console|QL1|Purchase|11.0 Consoles|q1","Spare vocal mic|SM58|Rental|12.0 Microphones|q1","Vocal mic|SM58|Rental|12.0 Microphones|q1"]
cleaned 1 census projects by name: 0
```
The matched-name Change All (previous throwaway, same tree logic):
```
== eqgood:key
  eqgood/key: dialog = "Would you like to replace the \"Category\" field of these 5 records with \"12.0 Microphones\"?"; buttons = ["No","Yes ↵"]
```

### Throwaway census (script, then SELECT-only execute_sql)
```
cleaned 1 census projects by name: 0
[{"zzcr_projects":0,"orphan_methods":0,"orphan_items":0}]
```

### Visual gate: poller fired at load 4.32; `> /tmp/cr-visual.txt` (GATE-NOGREP); :3000 = my `next dev` (pid 13944, `next-server (v16.3.3)`)
```
[visual-capture] mode gate; port :3000; 1-minute load average 4.32 (ceiling 5.00)
[visual-capture] reusing existing dev server on :3000 — verified Next dev, middleware matcher matches src/middleware.ts
[visual-capture] logging in…
[visual-capture] stored theme_preference at run start: dark
[visual-capture] finding fixture project "Visual Gate Fixture"…
[visual-capture] using project 0d308b93-fc26-4389-b00f-c35e2170c7ee
[visual-capture] fixture sort pinned to category at run start
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/01-project-menu-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/02-equipment-list-category-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/03-equipment-list-method-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/04-library-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/05-gcm-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/06-settings-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/07-print-revision-stamp-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/08-find-active-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/09-box-list-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/10-box-detail-panel-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/11-box-nesting-error-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/12-box-type-plus-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/13-boxes-menu-tab-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/14-box-types-admin-light.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/01-project-menu-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/02-equipment-list-category-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/03-equipment-list-method-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/04-library-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/05-gcm-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/06-settings-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/07-print-revision-stamp-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/08-find-active-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/09-box-list-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/10-box-detail-panel-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/11-box-nesting-error-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/12-box-type-plus-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/13-boxes-menu-tab-dark.png
[visual-capture] captured /Users/Daniel/Developer/Minotaur/screenshots/gate/14-box-types-admin-dark.png
[visual-capture] done — 28 captures written.
[visual-capture] theme_preference restored to 'dark'

[visual-capture] GATE REPORT
[visual-capture] served from :3000
[visual-capture] load average at run start: 4.32 (ceiling 5.00)
[visual-capture] judged at channel threshold 24, pixel threshold ZERO (0.0000% — any judged pixel moves the frame); measured lines are zero-tolerance (Δ>=1)
[visual-capture] diff-exception registry: 5 site(s) armed, 32 px excluded this run across 2 frame(s) (zero-tolerance aggregates only — the judged verdict is never masked)
[visual-capture] ----------------------------------------------------------------------
[visual-capture] PASS  01-project-menu-light        0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  02-equipment-list-category-light 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: 0 px unexcluded (excluded 16 px: subpixel-wander/topbar-theme-toggle-glyph×16)
[visual-capture] PASS  03-equipment-list-method-light 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: 0 px unexcluded (excluded 16 px: subpixel-wander/topbar-theme-toggle-glyph×16)
[visual-capture] PASS  04-library-light             0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  05-gcm-light                 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  06-settings-light            0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  07-print-revision-stamp-light 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  08-find-active-light         0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  09-box-list-light            0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  10-box-detail-panel-light    0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  11-box-nesting-error-light   0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  12-box-type-plus-light       0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  13-boxes-menu-tab-light      0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  14-box-types-admin-light     0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  01-project-menu-dark         0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  02-equipment-list-category-dark 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  03-equipment-list-method-dark 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  04-library-dark              0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  05-gcm-dark                  0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  06-settings-dark             0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  07-print-revision-stamp-dark 0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  08-find-active-dark          0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  09-box-list-dark             0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  10-box-detail-panel-dark     0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  11-box-nesting-error-dark    0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  12-box-type-plus-dark        0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  13-boxes-menu-tab-dark       0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] PASS  14-box-types-admin-dark      0/1600000 px (0.0000%) <= threshold 0.0000%
[visual-capture]       measured @ch0: byte-clean (0 px)
[visual-capture] ----------------------------------------------------------------------
[visual-capture] 28/28 surfaces passed
[visual-capture] gate PASSED — all surfaces match baseline
[visual-capture] full report written to /Users/Daniel/Developer/Minotaur/screenshots/gate/gate-report-2026-09-24T23-03-34-751Z.txt
GATE_EXIT=0
```
No baseline event, as expected. Same shape as round 1's run: 02/03-light each have 16 px excluded at ch0 by the
registry's Δ1 topbar-glyph wander site, and the judged count is 0 everywhere.

### Build: `npm run build` (after stopping my dev server; :3000 and :3100 both empty)
```

> minotaur-v2@0.1.0 build
> next build

▲ Next.js 16.3.3 (Turbopack)
- Environments: .env.local
✓ Running next.config.js took 7ms

⚠ The "middleware" file convention is deprecated. Please use "proxy" instead.

  To migrate automatically, run:
  npx @next/codemod@canary middleware-to-proxy .

  Learn more: https://nextjs.org/docs/messages/middleware-to-proxy
  Creating an optimized production build ...
✓ Compiled successfully in 2.9s
  Running TypeScript ...
  Finished TypeScript in 6.0s ...
  Collecting page data using 9 workers ...
  Generating static pages using 9 workers (0/14) ...
  Generating static pages using 9 workers (3/14) 
  Generating static pages using 9 workers (6/14) 
  Generating static pages using 9 workers (10/14) 
✓ Generating static pages using 9 workers (14/14) in 204ms
  Finalizing page optimization ...

Route (app)
┌ ○ /
├ ○ /_not-found
├ ○ /account/password
├ ƒ /api/waitlist
├ ƒ /auth/callback
├ ƒ /auth/confirm
├ ƒ /auth/confirm/verify
├ ƒ /auth/forgot
├ ○ /auth/login
├ ○ /auth/signup
├ ○ /beta-terms
├ ƒ /dashboard
├ ƒ /dashboard/new
├ ƒ /project/[projectId]
├ ƒ /project/[projectId]/boxes
├ ƒ /project/[projectId]/boxes/print-contents
├ ƒ /project/[projectId]/boxes/print-labels
├ ƒ /project/[projectId]/boxes/print-list
├ ƒ /project/[projectId]/boxes/types
├ ƒ /project/[projectId]/cable
├ ƒ /project/[projectId]/cable/bundles
├ ƒ /project/[projectId]/cable/lines
├ ƒ /project/[projectId]/cable/print-balun-labels
├ ƒ /project/[projectId]/cable/print-bundle-labels
├ ƒ /project/[projectId]/cable/print-bundle-sheets
├ ƒ /project/[projectId]/cable/print-bundle-summary
├ ƒ /project/[projectId]/cable/print-checklist
├ ƒ /project/[projectId]/cable/print-folder-labels
├ ƒ /project/[projectId]/cable/print-labels
├ ƒ /project/[projectId]/cable/print-line-list
├ ƒ /project/[projectId]/cable/print-steck-labels
├ ƒ /project/[projectId]/cable/print-tail-block-labels
├ ƒ /project/[projectId]/cable/print-tail-checklist
├ ƒ /project/[projectId]/cable/print-tail-folder-labels
├ ƒ /project/[projectId]/cable/print-tail-line-labels
├ ƒ /project/[projectId]/cable/print-tail-panel-labels
├ ƒ /project/[projectId]/cable/tails
├ ƒ /project/[projectId]/cable/types
├ ƒ /project/[projectId]/cover-letter
├ ƒ /project/[projectId]/equipment
├ ƒ /project/[projectId]/equipment/library
├ ƒ /project/[projectId]/equipment/methods
├ ƒ /project/[projectId]/equipment/print
├ ƒ /project/[projectId]/equipment/print-device-patch
├ ƒ /project/[projectId]/equipment/print-group-parts
├ ƒ /project/[projectId]/equipment/print-labels
├ ƒ /project/[projectId]/history
├ ƒ /project/[projectId]/import
├ ƒ /project/[projectId]/revisions
└ ƒ /project/[projectId]/settings


ƒ Proxy (Middleware)

○  (Static)   prerendered as static content
ƒ  (Dynamic)  server-rendered on demand
BUILD_EXIT=0
```
`.next` now holds this tree's build; **restart `:3100` before the browser gate.**

## SED LEDGER (round 2)

No in-place stream edit and no other bash-mediated repo write this round. Every repo change went through the Edit
or Write tool; the PNG from round 1 is unchanged (entry 1 above still covers it).

## COMMIT BLOCK (supersedes round 1's)

0. ⚠ **BROWSER GATE: OWED by Daniel, not run.** Restart `:3100` first. Steps 1–5 on the Cable Parity Fixture,
   steps 6–9 on JOY, exactly as the ADDENDUM writes them. Please report the result here in the terminal
   before the phrase (GATE-REPORTING).
1. `git add CLAUDE.md docs/reference/verhist-guard-census.md docs/reference/evidence/equipment/changeall_refusal_gate_05_category_subband.png src/components/cable/CableListClient.tsx src/components/cable/NewCableTypeDialog.tsx src/components/equipment/EquipmentListClient.tsx src/components/ui/ConfirmDialog.tsx src/lib/cable/cableChangeAll.ts src/lib/cable/cableChangeAllRefusal.test.ts src/lib/cable/cableUnmatchedName.test.ts src/lib/changeAllInvoke.ts src/lib/equipment/equipCategoryRefusal.test.ts src/lib/equipment/mmmCatSubBand.callSites.test.ts`
2. `git status --short`. Expected: 13 staged lines, 10 beginning `M ` and 3 beginning `A `
   (`…changeall_refusal_gate_05_category_subband.png`, `…cableChangeAllRefusal.test.ts`,
   `…equipCategoryRefusal.test.ts`), plus the untracked `?? "Claude outputs/"` and
   `?? docs/reference/evidence/equipment/` (the four `s4auto_*` files stay out, per Arch).
3. `git commit -m "CHANGEALL-REFUSAL: a refused Change All says so in a dialog; Change All greys with nothing found; a bad length refuses" -m "The unmatched-name and invalid-length refusals open each list's single-OK refusal dialog, and OK returns focus to the field. The equipment list's category (band editor and MMM-CAT sub-band) refuses the same way instead of offering the stored value. A dialog no longer answers the keystroke that opened it (ConfirmDialog, NewCableTypeDialog): on Enter the refusal closed itself unseen, and New Cable Type saved a type unseen. Change All disables with no current cable. The single-edit length and category paths refuse instead of reverting in silence."`
4. `git push`
