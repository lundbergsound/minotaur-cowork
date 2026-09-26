import re
p='Minotaur_v2_Roadmap_v4_51.md'; s=open(p).read()
a=s.index('## ▶ NOW'); b=s.index('## 🏗 THE SEQUENCE')
top="""## ▶ NOW

**One deploy on 26 Sept, `cef0949`.** Change All can no longer overwrite a list with a value you never typed, and
Enter on an unknown cable model no longer creates a cable type behind your back. What's left of that work sits at
the bottom of the Docket.

**Rulings done 24 Sept:** the defaults, except what goes in each set, which the build asks you for · bundle clone
and extend, three of eight.

**Nothing is running.**

## ⏭ NEXT — the next three sessions

1. **Will's eight.** The first handoff: adding cable types, and library delete — which ships before any version
   restore exists, like every other delete today; say if not. Then the shortcut helper on its own. **While CC
   works:** side sessions design the library panel and take you through the bundle rulings, and the IP address and
   defaults changes are rehearsed with you.
2. **The rest of Will's eight** as each clears: IP address, defaults and their admin screen, the library panel,
   bundle clone and extend.
3. **The box family**, then cable splits.

**Yours:**

- **Five bundle rulings** (R4–R8) and **ten minutes in v1**: a bundle with a mult and a plain cable, Add Extension,
  photograph the three dialogs.
- **A second test account**, so anything about sharing can be measured · **tell Aaron** not to edit one show with
  someone else at the same time.
- The 5167 stock check plus a 5160 sheet · the Terms v1.1 diff and the privacy policy's two facts · a fresh v1
  export of BVSC US Tour · a fresh licensing export · the bug-report wording.

"""
s=s[:a]+top+s[b:]
def setrow(rid,new):
    global s
    m=re.search(r'^\| \*\*'+re.escape(rid)+r'\*\*.*\n', s, re.M); assert m, rid
    s=s[:m.start()]+new+s[m.end():]
def poprow(rid):
    global s
    m=re.search(r'^\| \*\*'+re.escape(rid)+r'\*\*.*\n', s, re.M); assert m, rid
    s=s[:m.start()]+s[m.end():]; return m.group(0)
setrow('STALE-WRITE',"| **STALE-WRITE** | Two people in one show can lose a write silently: the later write wins with no warning, and an edit to a row someone else deleted looks saved but isn't. Proposed cheap fix, ahead of LIVE-COLLAB: a write that changes no rows says so and refreshes. **Daniel tells Aaron Hanna in the meantime.** | **Daniel** rules · **Arch** designs · then **CC** |\n")
setrow('VERHIST-RESTORE',"| **VERHIST-RESTORE** | Nothing can be restored from a version today: \"Open as new production\" calls nothing and its database function does not exist. Carries the rule that a restore never empties the library, and Daniel's 2026-09-11 ruling that a restored copy carries the original's Equipment List Revisions (which no backup holds today, along with import history and the per-show feature switches). | **Arch** rehearses · **Daniel** Trigger B · then **CC** |\n")
s=s.replace("⚠ **Your printer prints about 3/64\" low, and v1 does the same on it** — try the other paper path before ruling anything.","Your printer prints about 3/64\" low, on v1 too — try the other paper path before ruling anything.")
s=s.replace(" ⚠ **Measured 2026-09-21: no cohort member has imported a v1 show** — five imports, all equipment-library spreadsheets only. **No print writes a row**, so the print legs must be asked about.","")
s=s.replace(" ⚠ **Corrected 2026-09-22: the library IS in the payload and always has been**; the fork half is now VERHIST-RESTORE. What is left here is the counter and the blob and gesture-class residue.","")
s=s.replace("What is left of version history: a counter that makes a silently incomplete backup impossible; \"open as new production\", a migration deferred past the invite; and the blob and gesture-class residue.","What is left of version history: a counter that makes a silently incomplete backup impossible, and the blob and gesture-class residue. The restore half is VERHIST-RESTORE.")
s=s.replace("| **Arch, then CC** · the counter needs nothing; the fork needs a rehearsal and your Trigger B |","| **Arch, then CC** · needs nothing |")
s=s.replace("⚠ **Superseded, pending the licence-management parallel's return** (opened 2026-09-20, not returned as of 2026-09-21): the admin surface;","Waits on the licence-management parallel (opened 2026-09-20): the admin surface;")
# CHANGEALL leftovers + doc fix to the bottom of ACTIVE
tail=[]
tail.append("| **METHOD-CREATE-CABLE** | On the cable list, typing a method that doesn't exist should create it, as v1 does; today it refuses (`cef0949`). Daniel, 2026-09-26: *\"Adding a method called Nutes should make that a method that appears in GCM.\"* The equipment list already creates. | **CC** · rides the next cable-list unit |\n"); poprow('METHOD-CREATE-CABLE')
tail.append("| **LENGTH-WORDS** | The message for a length the app can't read (*\"fifty\" isn't a length.*) doesn't say what to do. Daniel: *\"Fifty is a length, it's just not a number string. If we want the user to do something, the dialog should be understandable.\"* | **Daniel** words it · rides the next cable-list unit |\n"); poprow('LENGTH-WORDS')
r=poprow('TAB-AFTER-SCOPE'); tail.append(r.replace('later, or rides an equipment-list unit','rides the next equipment-list unit'))
tail.append("| **MMM-CAT-GATE** | Daniel has not yet checked the category line under each method, or the equipment list's Category refusal. On a test show he is willing to change, never JOY. | **Daniel** · rides the next equipment-list gate |\n"); poprow('MMM-CAT-GATE')
tail.append("| **LAYOUTS-DOC-JOIN** | The remaining-layouts design (§4.2) still says Device Patch matches a device to its equipment exactly; it ignores capitals (`d25d366`). Correct it there, in the Ledger, and in `devicePatch.ts`'s header comment. | **Arch** for the documents · **CC** for the comment · rides any unit |\n")
i=s.index('### ⏸ HELD'); j=s.rindex('\n', 0, s.rindex('|', 0, i))+1
# insert before the blank line preceding HELD: find end of ACTIVE table
k=s.rindex('|\n',0,i)+2
s=s[:k]+''.join(tail)+s[k:]
i=s.rindex('\n*Roadmap v4.5')
s=s[:i]+"\n*Roadmap v4.51 · 2026-09-26 · retires v4.50. Written under Architecture Prompt v39. NOW + NEXT + THE SEQUENCE ≤ 8,000 characters is the only hard cap. Code `cef0949` live. Migration ledger **83**, unchanged; `supabase/migrations/` holds 22 files, 72–83 all with a file of record. Suite 3,888 / 211; frozen 3/3; visual 28/28; lint exit 0 (265 warnings). One deploy: CHANGEALL-REFUSAL `cef0949`.*\n"
open(p,'w').write(s)
x=s.index('## ▶ NOW'); y=s.index('## 📌'); print('top chars',len(s[x:y]),'⚠ left:',s.count('⚠'))
