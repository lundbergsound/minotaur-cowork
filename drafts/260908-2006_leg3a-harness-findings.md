# The visual-capture harness — two defects, and the flake register's corrections

*Cowork-Arch, 2026-09-08. **Carried verbatim out of `handoffs/from-cc/260908-1400_field-contract-leg3a.md`, which is GITIGNORED — the git index holds ZERO handoff files, so everything below dies with the working tree unless it lives here.** CC named these "for whoever holds H3's docket" and correctly did not write them itself: they are outside a field-contract unit's scope. Arch verified both mechanisms by reading `scripts/visual-capture.mjs` at its post-fix state.*

## 1 · ⚠ THE ONE THAT MATTERS: A FAILED GATE RUN POISONS THE NEXT ONE

**This is not a flake. It is an undeclared dependency between runs, and it masquerades as a rendering regression on the surface most units touch.**

**Mechanism, measured.** Frames 02/03 photograph the equipment list in Category sort, then in Method sort, then restore Category. The restore was fire-and-forget **on both sides**: the click's failure swallowed by `.catch(() => {})`, and the write it triggers — `changeSortMode`'s un-awaited `void supabase.from('projects').update({ equipment_sort_mode })` (DEV2-R2 / Leg 0) — never awaited, with a `page.goto` on the very next line. **If the run died first, or the navigation beat the write, the FIXTURE PROJECT STAYED IN METHOD SORT and the next run compared method-sorted frames against category-sorted baselines.**

**Observed, not theorised.** A run that fail-harded on the dark pass left the fixture in Method. The following run returned:

| Frame | Diff | Detail |
|---|---|---|
| `02-equipment-list-category-light` | **28.8040%** | 680,325 px @ch0, max Δ255, bbox `0,144–1599,760` |
| `02-equipment-list-category-dark` | **18.4499%** | same bbox |
| `08-find-active-light` | **6.9411%** | bbox `0,144–1599,442` |

**Every frame showing the equipment list body, and only those.** The diff PNG showed method band labels (`Owned`, `Purchase`, `No Method`) over the baseline's category bands (`4.0 Microphones`, `13.0 Cable`, `Uncategorized`), and the sort pill highlight moved.

⚠ **AND IT SELF-HEALS, WHICH IS WHY IT HAS NEVER BEEN CAUGHT.** When the next run completes, *its* restore lands. CC first proposed "the fixture is polluted right now" and **the database refuted it** — `equipment_sort_mode` reads `category` by the time anyone looks. **The hypothesis was right about the mechanism and wrong about the tense.** Recorded that way deliberately: the wrong version is the one a later session re-derives from the same evidence.

⚠ **THE REAL DANGER IS THE FALSE POSITIVE.** A 28.8% diff on the equipment list, with band labels visibly changed, reads as a genuine sort-order regression — **which is exactly what an unwary session would "fix" in the product code.**

**Fixed 2026-09-08 (Daniel authorised mid-run):** a `waitForResponse` on the `projects` PATCH is armed BEFORE the click and awaited after it; a timeout resolves null rather than throwing, because failing the gate over a slow restore would be worse than the leak. **Arch verified this at source.**

⚠ **The same fire-and-forget shape is used by the print-options and find staging. This may not be the only persisted setting that leaks. NOT audited.**

## 2 · Flake (3) — diagnosed, and both prior explanations are wrong

The "Method sort button not found" fail-hard. **Reproduced three times on 2026-09-08**, cold and warm, at loads 4.06–4.68.

⚠ **The warm run kills two theories at once:** with the route pre-compiled the page answered in **1,784 ms and the run failed anyway.** So it is neither compile time nor the register's "dev-server AGE" — both are merely ways to be slow.

**The mechanism is that the harness waits ZERO.** `capture()` does no waiting, `goto` resolves on `load`, the equipment page is a client loader rendering null until its queries resolve, and `locator().count()` does not auto-wait. **The equipment-list route was the only staged surface in the harness with no bounded wait for its own content** — frames 01, 07, 08, 09, 10, 11, 12 and 14 all already carry one.

**Fixed in the same authorised change:** `waitForSelector('[data-equip-row]', { timeout: 15_000 })`, on a marker the list already emits. **Arch verified this at source, and verified that the fixture-by-name lookup was NOT touched — PROJECT-NAME-NOT-UNIQUE is intact.**

⚠ **Cost before the fix: five gate runs in one day.**

## 3 · Register amendments owed to `docs/reference/visual-capture-harness.md`

**Not written into the repo — the leg-3a tree is uncommitted and adding a fourteenth file to a staged unit is how scope creeps.** They belong to H3 or to whatever unit next touches the harness doc.

1. ⚠ **Flake (3) is NOT light-only** — one run fail-harded on the DARK pass. *This is the second time a flake entry has needed exactly this correction; flake (2) needed it twice.*
2. **Flake (3)'s "dev-server age" trigger is superseded** by §2's mechanism. Keep the entry — "restart the server first" is not wrong, it is treating a symptom.
3. ⚠ **Flake (5) is NOT light-only either** — `04-library-dark` failed at flake (5)'s exact bbox `0,48–1599,996`.
4. ⚠ **`05-gcm-light` is a FIRST SIGHTING** of the same paint-race class — 252,007 px @ch0, max Δ248, bbox `0,48–1599,351` — **and is unregistered.**
5. **FIND-PARITY's `04-library-light` entry is NOT owed after all.** The leg-2 fence said its run-1 failure was a new signature needing a register entry. **It is flake (5), already registered** — "captured before the library loader paints, blank below the topbar, ~6.9% diff, clean on re-run" against FIND-PARITY's measured 6.8973%, bbox `0,48–1599,996`, clean on re-run. **CAPFLAKE-LIBLIGHT can be closed as a duplicate rather than carried.**

## 4 · The standing rules CC earned, already lifted into `CLAUDE.md`

Recorded here too, because §3's whole point is that a rule living in one place has a deletion date on it.

- **SCAN-COMMENTS.** A source-scanning guard asserted `toContain('data-find-field')` — and **passed with the guarded branch DELETED**, because the branch's own comment names that attribute four times. ⚠ **The better the comment, the more reliably it disabled the guard.** Fixed with a `codeOnly()` helper stripping `//` lines. *Third shape of SCAN-NONZERO.* Corollary: **test the guard, do not read it.**
- **A declaration is not a call site.** A guard counted five call sites where four exist: `function captureFocusedField(): T` contains the literal `captureFocusedField()`. *The other shape of A SELECTOR IS NOT AN EMISSION.*
- **AN ORIGIN, NOT A KEY, DISCRIMINATES OVERLAPPING VOCABULARIES.** `method_name`, `box_name` and `group_label` are BOTH band keys and row keys, so no key test can tell a band editor from a row cell. The capture had to carry where it came from.

⚠ **Two of five new guards PASSED THEIR FIRST DELETION CONTROL.** Both were instrument bugs, both found because every guard got a control. *A control that passes is not a control* — recurring, and caught this time.
