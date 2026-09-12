# MAILGATE — nothing mails the cohort without a standalone approval

**RULED (Daniel, 2026-09-12).** Installs into the Architecture Prompt, `CLAUDE.md` and the Roadmap at this close. Written here first because a rule carried only in chat has not propagated at all.

---

## The rule

**No session, script, unit or seat sends email to any address that is not Daniel's own, until Daniel has approved that send in a message whose ONLY content is that approval.**

- ⚠ **An approval buried among other asks is NOT consent and must never be read as consent.** Arch does not ask for a mail send in a message that also carries a handoff, a ruling request, a status report, or anything else. **One ask, one message, nothing else in it.** This is the WF-1a phrase's discipline applied to the one action that reaches strangers.
- **The ask names, before he answers:** the exact recipient list, the exact template, the exact trigger, and how many messages will be sent.
- **No standing approval, ever.** Approval covers one send. The next send asks again.
- **CC never sends mail and never provisions accounts** — it never calls the Auth-admin API and never reads `SUPABASE_SERVICE_ROLE_KEY`. Already a hard stop in the AUTH-RESETPAGE handoff.

## Measured state, 2026-09-12 — nothing has gone anywhere

Live introspection of `auth.users`:

| | |
|---|---|
| users | **12** |
| ever invited (`invited_at`) | **0** |
| recovery mail sent (`recovery_sent_at`) | **0** |
| confirmation sent | 12 — all at signup, before the door closed |
| newest user | 2026-08-14 |
| **last mail event of any kind** | **2026-08-14 23:02 UTC** |

⚠ **No invite has ever been issued from this project and no recovery mail has ever been sent.** The twelve confirmations are the original signups and all predate the 2026-08-15 closure.

## Why the app half cannot broadcast, and where the risk actually is

**`resetPasswordForEmail` is self-service by construction** — a person types their own address into the sign-in page and gets their own link. It has no list, no loop and no recipient Arch or CC chooses. **It cannot reach the cohort unless a cohort member goes to the site themselves.** Nothing in `src/` calls it today; AUTH-RESETPAGE adds the first call.

⚠ **The whole broadcast risk sits in the PROVISIONING script** — `inviteUserByEmail` over a list of addresses, with the service key. That is the only thing in this system capable of mailing sixteen people at once, it is Arch's and Daniel's, and it is what MAILGATE exists to govern.

## The mechanical guard on that script, built before it is ever pointed at a real address

Not a promise — a shape, and the script is written this way or it is not written:

1. **Dry run is the DEFAULT and the only behaviour without an explicit flag.** It prints the resolved recipient list and the template name and sends nothing.
2. **A hard-coded allowlist containing only Daniel's own addresses**, until he replaces it. An address outside it is refused, not warned about.
3. **The live run requires the flag AND a typed subject-bound phrase**, on the WF-1a model — a bare flag sends nothing.
4. **It prints what it will do and re-reads the count** before the first call, so a list that grew between the dry run and the live run stops it.
5. **It writes a record of every address mailed**, so the second run knows what the first one did.

**First live use is a send to Daniel's own address only, and he reads the mail before anyone else is on the list.**
