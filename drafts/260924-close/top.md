# 🗺️ ROADMAP — Minotaur v2 (v4.50)

## ▶ NOW

**The paperwork is finished except the boxes.** Two deploys on 22 Sept, both checked by you on JOY:

- **Group Parts and Device Patch** (`d12b80d`) — the last two equipment printouts, each with its v1 find screen.
  Group Parts matched v1 line for line on JOY; Device Patch matched except for the things the import lost.
- **Device Patch's device matching** (`d25d366`) — v1 ignores capitals when it matches a device to a piece of
  equipment, and v2 didn't. Three of JOY's Galileos were printing twice, once without a model.

**One unit is built and NOT committed: CHANGEALL-MMMCAT.** The cable list opens on its first cable and follows its
found set; the four inspector fields grey out with the panel; the category band is editable in every sort; and a
method name that doesn't exist can no longer become a mass change. Your gate on 24 Sept passed six of seven steps.
The failure: the refusal is silent — the box reverts but says nothing. An addendum is written and waiting for CC
(`handoffs/to-cc/260924-1140_changeall-newmethod_ADDENDUM.md`); the commit follows your re-gate of that one step.

**Three side sessions returned**, and two of them made the work smaller: the equipment library is already in every
version (no database change needed), and bundle clone/extension needs no database change either. The third
recommends keeping your default content in an ordinary show called *Defaults* and pressing Publish, instead of
building five admin screens.

⚠ **Two people editing one show can lose work silently.** Measured 24 Sept: no live updates, the later write wins
with no warning, and an edit to a row someone else deleted is accepted on screen and never saved. Aaron Hanna is
already sharing shows.

## ⏭ NEXT — the next three sessions

1. **Finish and commit CHANGEALL-MMMCAT**, then **Will's eight** (your 22 Sept order, moved ahead of the boxes and
   cable splits). Three need nothing from anyone: deleting library rows, adding cables in Cable Types, the keyboard
   shortcut helper. The IP address field and the defaults need a database change I rehearse with you first.
2. **The box family** — box labels, Box List and Contents List to v1, now unblocked by your JOY prints. Then
   Paradise Square as the second check, because JOY has no small box labels and no box inside a box.
3. **Cable splits**, with its one open question: does a split's inherited end read through to the parent, or is it
   copied when the split is made?

**Yours — rulings first, then desk work:**

- **21 one-word rulings** wait in the three side-session returns: seven on defaults, eight on bundle clone and
  extension, and the library panel's. I'll bring them one screen at a time next session.
- **Tell Aaron** that two people shouldn't edit one show at the same time until the silent-loss fix ships.
- **Ten minutes in v1:** open a show whose bundle holds both a mult and a plain cable, press Add Extension, and
  photograph the three dialogs in order. Also: does the old `Minotaur v1 DDR.xml` still exist anywhere?
- **The 5167 stock check**, plus one 5160 sheet · **read the Terms v1.1 clause diff** and the privacy policy's two
  facts (Vercel's region, where the FileMaker licence file lives) · a fresh v1 export of BVSC US Tour · a fresh
  licensing export · the bug-report wording.

## 🏗 THE SEQUENCE — the road, in plain language

- **The private beta is open.** Twenty leads plus their teams, invited 19 Sept. **Done:** terms, front door, mail
  sender, sharing, the typeface, the import's time limit, the speed work, method colours, the support login, the
  security upgrade, the accounts, the invite, Jamie's notes request, and the whole equipment-side paperwork.
- **The paperwork, your priority, in your order.** ~~Print fixes · Line List and Bundle Summary · Small Cable
  Labels · Steck and Equipment labels · the equipment list's nine fixes · the three shop documents · Bundle and
  Tail Folder labels · Group Parts and Device Patch~~ (shipped) · **your 5167 check, plus a 5160 sheet** · the box
  family, then Paradise Square.
- **Then Will Pickens's eight**, moved ahead of the boxes and splits by your ruling of 22 Sept: deleting library
  rows · adding cables in Cable Types · the keyboard shortcut helper · the library panel · one IP address field
  that prints and exports · your default content and the screen you manage it from · cloning and extending a
  bundle. **Keep Will updated as each lands.**
- **Then cable splits**, a core v1 feature v2 cannot import a real show without.
- **Then A4.** Every printout and label sheet on A4 as well as US Letter, chosen per show. Before release.
- **Then Allocate**, then **RF, walkies and circuits** with the IAS frequency import, then **live editing by more
  than one person**, designed with working offline. **Keep Aaron updated on all three.**
- **The four weeks after the invite — fix what the cohort finds.** Jamie's contrast and type-size pass · a
  read-only role · a counter that makes an incomplete backup impossible · the terms gate · housekeeping · **the
  silent-loss fix** · and, if you rule it in, nothing lost on a bad connection.
- **Working without a connection** — nothing lost on a bad connection; then open and print your shows offline; then
  full offline editing, designed with live collaboration. **Keep Josh Richardson updated.**
- **Terms v1.1 and the privacy policy** — drafted; publish once you've adopted the wording and the rule that keeps
  Claude out of members' shows is installed.
- **The beta opens to v1 owners when two people have run each core workflow on a real production** — your bar,
  ruled 20 Sept. Mid-October is the forecast, not the gate. **No cohort member has yet imported a v1 show.**
- **Then Maintenance, Spreadsheet Export and Cover Letter**, then the bug report button.
- **November — money.** Checkout and subscriptions, attorney review first, New York's auto-renewal rules built in,
  a seat limit before the first payment.
- **At release — $199 a year**, named user, one session each. v1 on request.
- **Stop: a paid beta by ~March 2027.**
- **Off the road — released by an event, not a date:** a typeface with a two-storey `a` that also has the ohm sign ·
  controls that fail open · duplicating an item · an organisation tier · a monthly price · a per-kind category
  breakdown · the empty backup a new show's first import leaves · chunking the import · live results under the find
  fields · a per-printer print nudge.

---
