# AUTH-FRONTDOOR — CC handoff

Tier: 3
Session: FRESH

**Unit: AUTH-FRONTDOOR — four checkpoints, one commit.** Everything a cohort
member touches before they are signed in. No migration, no mail, nothing
applied, no dependency change.

**Follows TERMS-ACCEPT, `1f82072`** = `origin/main`, live. Refs read from
`.git/refs/heads/main` and `.git/refs/remotes/origin/main` at the open,
2026-09-14; no lock files. **Every line number below was measured at that
commit on 2026-09-14** — the AUTH-POLISH pre-draft's numbers were taken before
two commits and are superseded by these.

---

## Step 1 — the run fence (FENCE-COUNTS)

Replace the body of `## Current run fence` in `CLAUDE.md` (`:1474`) with this
unit's fence. The retired TERMS-ACCEPT body goes into the Ledger append
verbatim, not into the bin. **Re-measure every count at your open rather than
copying the ones below** — they are TERMS-ACCEPT's, recorded so you can see
what moved: migrations **64, none added** · suite **3,310 tests across 170 test
files** · frozen **3/3 vs `be0769de`** · visual **28/28, no baseline event**.

---

## CP1 — OTPLEN-MISMATCH, the code half

**The defect, as measured at Daniel's 2026-09-14 gate:** the emailed recovery
code arrives as **eight digits**. `src/lib/auth/resetFlow.ts:80` declares
`export const OTP_LENGTH = 6`, and `normalizeCode` at `:83-86` builds
`^\d{6}$` from it and returns `null` on anything else. The only call site is
`src/components/auth/ForgotPasswordForm.tsx:80`, which takes that `null` and
shows `codeFormat` **without ever calling the auth host**. The typed-code path
has never worked on this project.

**Why it is the front door and not a nicety:** that code is the fallback for a
link a corporate mail scanner burned. AUTH-LINKCLICK (`3416650`) stopped the
scanner spending the token on a GET; it did not give the operator a second way
in when a link fails for any other reason. Today a failed link means no way in
at all.

**The change:** the page stops pre-judging a length the auth host owns.
`normalizeCode` strips whitespace and accepts **any run of 6 to 10 digits**,
returning `null` only for something that is not a plain digit string. The host
is the judge of whether the code is right; `verifyCodeMessage` (`:115-119`)
already maps its refusal onto a plain sentence.

- Keep the `OTP_LENGTH` export only if something still reads it; if nothing
  does after this change, delete it rather than leave a constant that lies.
- `src/lib/auth/resetFlow.test.ts:65-73` pins the six-digit behaviour. Rewrite
  that block: a six-digit code still passes, an eight-digit code now passes,
  and the rejection cases stay rejections. **Report the before and after of
  that describe block in the return.**

⚠ **DO NOT touch the four copy strings that say six digits** —
`src/lib/auth/resetCopy.ts:50`, `:61`, `:65`, `:69`. The ruled fix for the
mismatch is Daniel setting the dashboard's email OTP length to 6
(AUTH-DASHBOARD), which makes that copy true. This checkpoint makes the page
survive the mismatch either way; it does not decide it. If you think a copy
change is needed, say so in OPEN QUESTIONS and change nothing.

## CP2 — the five ruled sentences become pedigree (a)

`src/lib/auth/resetCopy.ts` is 105 lines and is the single home for every
operator-facing string on this flow. Its header docblock (`:1-24`) declares
**all of it pedigree (c)** — *"None of these sentences has been ruled"* — which
has been false for five of them since 2026-09-13.

The five, by key and line: `signInFailed` (`:38-39`), `signInTooMany` (`:40`),
`confirmSubtitle` (`:43`), `confirmIntro` (`:44`), `confirmButton` (`:45`).

**The work is pedigree, not text.** The sentences in the file should already BE
the ruled ones, so your first act is to prove that rather than assume it:
**quote each of the five verbatim out of the file into the return** and compare
against the ruling as recorded in the Ledger's eighteenth append §2. **A
mismatch is reported, never silently reconciled.**

Then rewrite the header docblock so it no longer claims none has been ruled,
and give each of the five a comment citing the 2026-09-13 ruling by ID.
`appName` keeps (b); the three `terms*` keys keep (a); **the remaining strings
keep (c) and the header must still say so.**

## CP3 — `brand-400` link text readable in dark mode

The theme-aware token already exists and is already pinned: `--brand-link` is
`#4f52e7` (brand-600) in light at `src/app/globals.css:98` and `#a5bbfd`
(brand-300) in dark at `:138`; `src/lib/themeTokenPairs.test.ts:72` carries it
in `PAIRED` and `:132` pins the light value. **No new colour.**

The six sites still on the 2.42:1 `text-brand-400 hover:text-brand-300` pair,
measured 2026-09-14:

| File | Line |
|---|---|
| `src/components/auth/authFormClasses.ts` | 64 — `AUTH_LINK` |
| `src/app/auth/login/page.tsx` | 99, 108 |
| `src/app/auth/signup/page.tsx` | 41 |
| `src/app/page.tsx` | 75, 83 |

**The change:** `AUTH_LINK` becomes
`text-[color:var(--brand-link)] hover:underline`, and the five inline sites use
`AUTH_LINK` instead of repeating the string. ⚠ **`src/app/page.tsx:75` and
`:83` carry an extra `text-sm`** — those two become `` `${AUTH_LINK} text-sm` ``,
not a bare swap. Underline replaces the hover-colour shift because a
colour-only hover on a token that flips theme has to be measured twice.

**Existing consumers are safe, and this is why:** `AUTH_LINK` is read today at
`src/app/beta-terms/page.tsx:26`, `src/app/account/password/page.tsx:99` and
`:114`, and `src/components/auth/ForgotPasswordForm.tsx:152` and `:161`. Three
tests pin those call sites — `src/lib/auth/resetSurface.test.ts:155`, `:173`,
`:188` and `src/lib/legal/betaTerms.test.ts:130` — and **every one of them pins
the identifier `AUTH_LINK`, not its value.** Changing what the constant holds
moves none of them. Confirm that by running them, and say so.

⚠ **Out of scope, deliberately:** the ~25 `focus:border-brand-400` sites across
dialogs and list clients. Those are borders on a focused input, not link text,
and nothing has ruled on them. Touching them turns this into a sweep.

## CP4 — the sign-in page's two inputs on live steps

`src/app/auth/login/page.tsx` — the email input at `:50-59` and the password
input at `:65-74` both carry `border border-surface-600` (`:55`, `:70`) and
`placeholder-surface-500` (`:56`, `:71`). The `surface` scale in
`tailwind.config.js` defines 0/50/100/200/300/800/900/950 and nothing between,
so all four emit no CSS and inherit.

`AUTH_INPUT` at `src/components/auth/authFormClasses.ts:36-38` already encodes
the repair the new screens use: `border-surface-300`, no placeholder. **Both
inputs adopt `AUTH_INPUT`.**

⚠ **This deletes the two placeholders** — `you@example.com` (`:58`) and
`••••••••` (`:73`) — on the one screen every cohort member will see.
**DANIEL'S WORD IS OWED ON THAT AND THIS CHECKPOINT DOES NOT RUN WITHOUT IT.**
If the pointer you were given does not carry his answer, build CP1–CP3, stop,
and say so.

⚠ **THE TEST THAT BREAKS IS THE ONE THAT MATTERS.**
`src/lib/auth/resetSurface.test.ts:68-70` asserts the login page's dead steps
are exactly `['border-surface-600', 'placeholder-surface-500',
'border-surface-600', 'placeholder-surface-500']`. That assertion is the
**positive control** for the whole dead-step scanner (SCAN-NONZERO, stated at
`:11-14`): it is what proves the scanner can see a dead class at all, and every
absence check in that file leans on it. Repairing the login page empties it —
so the control must **move to a file that still carries a dead step** before
the login assertion becomes `[]`. DEADCLASS-SURFACE records 101 remaining
sites; pick one, cite it by file and line in the return, and leave the rest
alone. **Emptying the assertion without relocating the control is the defect
this unit must not ship.**

This closes the four dead classes on that page, so DEADCLASS-SURFACE's sign-in
clause retires.

---

## Gates — the standard set, all five

`npm test` · `npm run type-check` · `node scripts/frozen-gate.mjs` ·
`npm run build` · `npm run test:visual`

**Visual: no baseline event is expected, and that is measured, not predicted.**
`scripts/visual-capture.mjs` captures fourteen frames — `01-project-menu`
(`:710`) through `14-box-types-admin` (`:1074`) — in two themes, which is the
28. Every one of them is a signed-in screen. **No frame captures
`/auth/login`, `/auth/confirm`, `/auth/forgot` or `/account/password`.** If a
frame moves, stop and report it rather than accepting it.

**Raw Output Rule.** Reproduce the complete raw output verbatim — into this
unit's return file's RAW OUTPUT section. Do not summarize, paraphrase, or
describe it. Show every line.

## What is NOT in this unit

CONFIRMBTN-FLIP · CABLEDEL-FAILMSG · CHANGEALL-NAALIAS · the blank-box
link fan-out · BOXBAND-DUPKEY · CATCOUNT-COLUMN. They remain AUTH-POLISH's.
This unit is the front door only, on Daniel's instruction 2026-09-14. **Do not
widen it.**

## Return condition

Build, run all five gates, write the return file, and **stop before the commit
phrase.** Daniel's browser gate comes first: the sign-in page in both themes
with the links and both inputs; the confirm page's three sentences; a reset
email requested and the typed code entered from a real message.

The commit is his phrase, `COMMIT APPROVED: AUTH-FRONTDOOR`, and the push that
follows it is a production deploy.
