# Legal Brief Addendum — Admin, Support Access & Account Lifecycle
**Daniel Lundberg Sound Design LLC · Minotaur v2 · August 5, 2026 · Amended August 15, 2026 (Section F added; no other changes)**
**For the September 2026 attorney engagement (ToS, Privacy Policy, EULA, IP assignment).**
**Status: Daniel-confirmed Strat rulings, August 5, 2026; Section F Daniel-confirmed August 15, 2026. These are business-posture decisions for counsel to convert into binding language — not draft contract text.**

---

## Context for counsel

Minotaur v2 is a multi-user SaaS web application (Supabase/Postgres backend, Vercel frontend) for theatrical sound designers. Beta arc: private beta now (invited colleagues, manual provisioning) → open public beta October 2026 (free) → paid release January 2027. Sole operator today; a small per-hour support team is planned post-launch. The operator (Daniel Lundberg) is also a working sound designer in the same professional community as the user base — user trust in data privacy is a core commercial asset, and the postures below were chosen with that in mind.

---

## A. Support-access posture (privacy promise)

**Confirmed posture:** No administrative surface in the product exposes user project content to the operator or to future support staff. The admin panel shows account metadata only (identity, activity timestamps, project counts/sizes — never project content). When a user wants hands-on support, they share their project with a designated support account using the product's own project-sharing feature, in a read-only role, visible in their project's member list, revocable by the user at any time. Consent is per-incident and user-initiated; there is no standing support access.

**Honesty constraint for the Privacy Policy:** As database operator, the LLC retains technical ability to access stored data (service-role database credentials, backups). The Privacy Policy must therefore NOT claim "we cannot access your data." The truthful promise to draft: no product surface exposes user content to us, and we do not access user content except (1) when the user shares a project with the support account, (2) as necessary to operate, maintain, and secure the service, or (3) as required by law. Counsel to harden this language.

**Cross-product note:** This posture is intended as house policy across the LLC's products (Minotaur, Elephant Scribe, Arvo). Draft the operative language so it generalizes rather than being Minotaur-specific.

## B. Account lifecycle

**Disable:** Admin may disable an account (abuse, security). Disabled users see an explicit "account disabled — contact support" notice at login. All data is preserved; disable is reversible. Beta terms should reserve this right.

**Deletion:** Account deletion is a user right handled as a manual support-request process during beta ("email support; deleted within ~30 days"), not a self-serve control. On deletion, user content is genuinely destroyed from live systems, with a residual tail as automated backups age out. **Retention-window placeholder:** the exact backup retention period is being verified against the live Supabase backup/PITR configuration (an existing pre-August-25 engineering obligation); the verified number will be supplied to counsel before drafting. Deletion language should reference the verified window, not a guessed one.

**Shared-project ownership on owner deletion (question for counsel):** Projects can have invited collaborators. Confirmed beta policy: deleting an owner's account deletes the projects they own; collaborators lose access. This must be stated plainly in the beta terms. Post-beta, an ownership-transfer feature is contemplated but not committed. Counsel to advise whether the beta terms need anything beyond clear disclosure.

## C. Beta terms

Beta terms should cover: no warranties / as-is service; data-loss disclaimer with the export path noted as the user's safeguard; the disable right (B); the deletion process and shared-project consequence (B); the support-access posture (A); free-of-charge status during beta and the operator's right to change or discontinue the service; conversion expectations toward the January 2027 paid release.

## D. Privacy-regime scoping (question for counsel)

The LLC is a single-member LLC with revenue on a ~$20K/year trajectory and an expected user base in the low hundreds. Which privacy regimes actually bind at this scale (e.g., CCPA thresholds; GDPR only if EU users are served)? The Privacy Policy should meet real obligations and honor the promises in (A) and (B) without voluntarily assuming compliance regimes that do not apply. Some universities teaching the product may have students under 18 in unusual cases — flag whether any minor-related provision is needed for a free student tier.

## E. Items already in the September scope (unchanged, listed for completeness)

Retroactive IP assignment (Daniel → LLC, to 2015) · ToS · Privacy Policy · EULA/subscription agreement · Century Gothic webfont licensing · third-party security-review framing for the paid release.

## F. Pre-terms account exposure & attachment of terms (added August 15, 2026)

**Facts.** Public self-serve signup on minotaur.app was open from approximately July 17 to August 15, 2026, with email confirmation required and functioning. It was closed on August 15, 2026; the private-beta posture stated in the Context section (invited colleagues, manual provisioning) is now enforced in the product, and signup remains closed until public beta opens under terms (October target). During the open window, twelve accounts were created: two operator-owned (personal and test-harness); six unconfirmed automated signups that never signed in and hold no data (scheduled for deletion after the backup-restore drill); and four real individuals, all personally known to the operator, none invited. Combined third-party use totals roughly twenty minutes; stored third-party content totals roughly ten equipment/library rows across three projects; no third party imported a file, created a revision, or printed output. No terms of service, EULA, privacy policy, or beta terms governed the service during this window.

**Questions for counsel:**

1. **Attachment of terms to pre-terms accounts.** The proposed mechanism is click-through acceptance at next sign-in once the ToS and beta terms exist, applying to the four pre-existing accounts before any further use. Confirm this is sufficient, or advise the better mechanism.
2. **Notice obligations.** Whether the pre-terms window creates any obligation to the four individuals beyond the courtesy contact already made (the operator is contacting each personally, offering data deletion per §B). The operator's assessment is that no formal notice is owed given the scale and nature of the data; confirm.
3. **Disclosure of record.** A data-loss defect in the v1-import path was present in production during this window (fixed August 15, 2026; never triggered). It was not reachable by the third-party accounts — triggering it required importing a v1 file into a project already carrying cable/box records, which only operator-owned projects have. Stated for completeness so that representations about the exposure window are complete and accurate.

**Business posture (Daniel-confirmed August 15, 2026):** the standing rule going forward is that terms must exist before **any** third-party access, paid or unpaid — the original "before first paid commercial user" trigger is restated accordingly in the Product Brief. The four individuals are named beta-candidate contacts; their accounts remain live, with a standing intent to disable (per §B, kindly communicated) if substantive pre-terms use begins before the beta terms exist.

---

*End of addendum. Contact: Daniel Lundberg.*
