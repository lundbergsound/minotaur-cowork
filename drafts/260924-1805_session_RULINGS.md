# Session rulings — 2026-09-24 evening main line (staged for the close)

- DEFAULTS Q1 (260922-1857_defaults_RETURN.md §7): **Path B** — a *Defaults* show and a Publish button. Daniel, 2026-09-24: "B"
- DEFAULTS Q3: **Replace** — Publish makes the shelf exactly what is in *Defaults*, confirmation naming the counts. Daniel, 2026-09-24: "replace"
- DEFAULTS Q4: **Equipment Library stays ticked** on the new-show screen. Daniel, 2026-09-24: "ticked"
- DEFAULTS Q6: **Daniel writes the new-show switch descriptions.** His text, 2026-09-24, verbatim (italic lines as he typed them; their role is being confirmed):

      Categories
      <i>What is it?</i>
      Includes Daniel's default categories for equipment, e.g., 1.0 Consoles, 2.0 Speakers, 13.0 Cable, etc.

      Methods
      <i>Where do you get it?</i>
      Includes Daniel's default methods, e.g., Rent-Main, Rent-Cable, etc.

      Equipment Library
      Includes all of the equipment Daniel and his colleagues have used on shows for the past 10 years, from microphones to consoles to speakers to adapter cables. Makes filling in your production's equipment list faster.

      Default Cable and Tail Types
      Includes common cables, (XLR, Ethercon, Edison, Powercon) and multicable common in New York shops. You can start these defaults and edit them to suit your needs.

      Default Box Types
      Includes the racks and roadcases common in New York Shops
  - Confirmed 2026-09-24: the italic lines are on-screen text, in italics, "like v1" — evidence: Daniel's screenshot of v1's *Welcome to Minotaur.* new-project dialog (italic *What is it?* / *Where do you get it?* under Default Categories / Default Methods). Two copy fixes approved ("two fixes approved"): Cable and Tail Types → "Includes common cables (XLR, Ethercon, Edison, Powercon) and multicable found in New York shops. You can start with these defaults and edit them to suit your needs." · Box Types → "Includes the racks and roadcases common in New York shops."
  - Evidence filed: `~/Minotaur_v1_exports/layouts/260924-1815_v1_layout_welcome-new-project-defaults.png` (v1 Welcome dialog; Include/Ignore pairs; header names "the Daniel's Defaults folder" as v1's import route).
- BUNDLE-CLONE-EXT R1 + R2 (260922-1502_bundle-clone-ext_RETURN.md): **Clone and Ext join the Bundle List row strip, with the cable list's shortcuts (⌥⇧G Clone, ⌥⇧X Ext).** Daniel, 2026-09-24: "same strip with keyboard shortcuts". Evidence: his v1 Bundle List screenshot — row strip `- Delete · + Duplicate · + Clone · + Ext` — filed `~/Minotaur_v1_exports/layouts/260924-1835_v1_layout_bundle-list-clone-ext-strip.png`.
- BUNDLE-CLONE-EXT R3: **v1 — a cloned bundle's mults arrive with no tails and no lines** (Duplicate is the path that brings children). Daniel, 2026-09-24: "v1"
- (R4 asked 2026-09-24 ~18:30, answer pending — paused for the CHANGEALL-REFUSAL mid-run findings)
- CHANGEALL-REFUSAL CP5.2 → **fold the equipment Category `Nutes` fallback into this unit**. Daniel, 2026-09-24: "fold it in". Addendum `260924-1846_changeall-refusal_ADDENDUM.md`.
- CHANGEALL-REFUSAL round 2 returned 19:05, all gates green (suite 3888/211, tsc 0, lint 265, frozen 3/3, visual 28/28 no event, build 0, census 0, 7 CP6 controls RED). Arch on round-2 OQs: (1) blank category → stored-value Change All joins the Quantity-NaN Docket row; (2) click-away focus-on-BODY joins the Tab-residual / DIALOG-OPENING-KEY row; (3) D5 advance-consume kept.
- 2026-09-26 — Daniel's CHANGEALL-REFUSAL gate (verbatim in `260926-1146_changeall-refusal_COMMIT.md`): steps 1–3 reject the refusal dialogs ("this isn't v1 behavior and I didn't approve this. Adding a method called Nutes should make that a method that appears in GCM"; the length dialog "not useful … should be understandable"); 4–6 pass; 7–9 not run ("I'm not changing data on JOY"). Direction: "no more amendments to this … finish committing this without asking a follow up question". ⚠ Arch error owned: the method refusal was Arch's own pedigree-(c) proposal (260923-1120 §1), carried as settled for two handoffs; Daniel's CHANGEALL-NEWMETHOD open question ("should typing a new method CREATE it") was never put to him first. Gate steps must never write to JOY.
