import re,sys
s=open('Minotaur_v2_Roadmap_v4_50.md').read()
top=open('drafts/260926-close/top.md').read()
i=s.index('## 🏗 THE SEQUENCE')
s=top+s[i:]
def rep_row(rowid, new):
    global s
    m=re.search(r'^\| \*\*'+re.escape(rowid)+r'\*\*.*\n', s, re.M)
    assert m, rowid
    s=s[:m.start()]+new+s[m.end():]
def del_row(rowid):
    rep_row(rowid,'')
rep_row('CHANGEALL-REFUSAL',
"| **METHOD-CREATE-CABLE** | ⚠ **Rejected at the gate, live in `cef0949`.** On the cable list, a method name that doesn't exist brings up *\"There's no method called…\"*. Daniel, 2026-09-26: *\"this isn't v1 behavior and I didn't approve this. Adding a method called Nutes should make that a method that appears in GCM.\"* Typing a new method creates it (Enter and Change All alike), as the equipment list already does (CHANGEALL-METHODNEW). | **CC** · needs nothing. First bundle |\n"
"| **TAB-AFTER-SCOPE** | After the equipment list's *\"just this one or all\"* question, Tab jumps to the filter bar instead of the next cell (Daniel, 2026-09-24). Measured: focus is dropped when the question closes. Put it back where it was. | **CC** · needs nothing. First bundle |\n"
"| **MMM-CAT-GATE** | The category line under each method (shipped `3809860`) and the equipment Category refusal (`cef0949`) have never been checked by Daniel. Gate on a test show he is willing to change — **never JOY**. | **Daniel** · rides the first bundle's gate |\n"
"| **LENGTH-WORDS** | ⚠ **Rejected at the gate, live in `cef0949`.** A length the app can't read brings up *\"\\\"fifty\\\" isn't a length.\"* Daniel: *\"Fifty is a length, it's just not a number string. If we want the user to do something, the dialog should be understandable.\"* | **Daniel** words it · then **CC** |\n")
rep_row('LIBRARY-DELETE', "| **LIBRARY-DELETE** | Delete a library row, and Delete All in the Equipment Library, with a button and a shortcut. A member who imports the shared library cannot remove any of it today. Every version already carries the library (*\"library should be in version history\"*, 2026-09-22), but nothing can be restored from a version yet (VERHIST-RESTORE). **Keep Will Pickens updated.** | **CC** · needs Daniel's word: can delete ship before restore exists? |\n")
rep_row('SEED-DEFAULTS', "| **SEED-DEFAULTS** + **DEFAULTS-ADMIN** | A new show comes with your library, methods, categories, cable types and box types, curated in an ordinary show called *Defaults* and pushed with a Publish button. **Ruled 2026-09-23/24:** copied at creation, never linked · Path B · Publish replaces · Equipment Library ticked by default · your five switch descriptions (Ledger). One migration (global box types). The build asks you for each set's content. **Keep Will Pickens updated.** | **Arch** rehearses, after REGISTRY-REST's admin check · **Daniel** Trigger B and the sets · then **CC** |\n")
rep_row('BUNDLE-CLONE-EXT', "| **BUNDLE-CLONE-EXT** | Clone a bundle and extend a bundle — the restored **D-2b**. No migration (measured). **Ruled 2026-09-24:** Clone and Ext in the row strip with ⌥⇧G and ⌥⇧X; a cloned bundle's mults arrive empty, as v1. **R4–R8 wait**, and one ten-minute v1 errand (Add Extension, three dialogs). **Keep Will Pickens updated.** | **Daniel**: five rulings and the frames · then **CC** |\n")
rep_row('MMM-CAT', '')
for r in ['CHANGEALL-EMPTYFIND','TAB-AFTER-SCOPE','LENGTH-FALLBACK','METHOD-CREATE','INSPECTOR-ARM','PARALLEL-CLOCK-STAMP']:
    del_row(r)
m=re.search(r'^\| \*\*SORTBAND-CLICKZONE\*\*.*\n', s, re.M)
s=s[:m.start()]+("| **EQUIP-FALLBACK-REST** | Three leftovers of the same shape on the equipment list: a blank category then Change All still offers the stored category; Quantity's unreadable-number arm does the same (unreachable by typing today); and the equipment and library Change All buttons stay lit once armed. | The next equipment-list unit |\n"
"| **DIALOG-FOCUS** | While a refusal is up, the caret can sit in another box behind it (Tab out of a cable field) or nowhere (click away on the equipment band); typed letters could land behind the dialog. | The next dialog work |\n"
"| **DIALOG-OPENING-KEY** | 28 files carry the keyboard listener that let a dialog answer the key that opened it; two are fixed, one measured clean, the rest unmeasured (census in `CLAUDE.md`). | The next unit that touches any of them |\n")+s[m.start():]
m=re.search(r'^\| \*\*SESSION-SHAPE\*\*.*\n', s, re.M)
s=s[:m.end()]+("| **PROPOSAL-ASKS-FIRST** | A behaviour Arch proposes — anything the user will see that is neither Daniel's ruling nor v1 evidence — is put to Daniel in plain words before it goes into a handoff. He does not meet it for the first time at the gate. |\n"
"| **JOY-READ-ONLY** | Daniel does not change data on JOY (2026-09-26). JOY is for reading and printing; any gate step that writes uses a throwaway, the Cable Parity Fixture or a test-account show. |\n")+s[m.end():]
i=s.rindex('\n*Roadmap v4.50')
s=s[:i]+"\n*Roadmap v4.51 · 2026-09-26 · retires v4.50. Written under Architecture Prompt v39. NOW + NEXT + THE SEQUENCE ≤ 8,000 characters is the only hard cap. Code `cef0949` live. Migration ledger **83**, unchanged — no migration this session; `supabase/migrations/` holds 22 files, 72–83 all with a file of record. Suite 3,888 / 211; frozen 3/3; visual 28/28 with no event; lint exit 0 (265 warnings). **One deploy: CHANGEALL-REFUSAL `cef0949`.** ⚠ **Two of its refusals were rejected by Daniel at the gate and are first in line.***\n"
open('Minotaur_v2_Roadmap_v4_51.md','w').write(s)
a=s.index('## ▶ NOW'); b=s.index('## 📌 THE DOCKET')
print('NOW+NEXT+SEQ chars:', len(s[a:b]), 'total', len(s))
