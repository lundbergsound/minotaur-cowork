# Next session opener — Cowork-Arch, written 2026-09-11

*⚠ **This is 1,400 characters where the last one was 11,650, and that is the restructure working rather than a shortcut.** The old opener existed because the Roadmap could not be read; v4.28's **▶ NOW** and **⏭ NEXT** now say what it used to have to repeat. **If a future opener starts growing back past two screens, the Roadmap has re-bloated — fix the Roadmap, not the opener.***

---

## ⚠ WHAT DANIEL PASTES — nothing else is needed

```
Open the Minotaur Arch seat.

Read, in this order, from ~/Developer/Minotaur-Cowork/:
  1. Architecture_Prompt_v35.md
  2. Minotaur_v2_Roadmap_v4_28.md   <- NOW and NEXT say where we are
  3. Minotaur_v2_Session_Log.md     <- the header, then entry 5

NO ROLLOVER IS DUE — the log stands at 5 and it fires at 10.
NOTHING IS OWED from the last close: v4.28, Architecture Prompt v35, the
thirteenth Ledger append and the project-knowledge uploads are all installed.

THE UNIT IS VERHIST-TIMER. It is a MIGRATION: Trigger B, Arch's,
rehearsal-first, and I confirm explicitly before the apply. Branch-or-main
is my call.

⚠ ONE THING IS OWED FROM ME AND IT GATES THE UNIT: whether a version I name
and save deliberately can ever be deleted by the retention cleanup. Ask me
that first, in plain English, before designing anything.

Verify state from files first (never from memory, never from packed-refs),
run the production READY check with me, then design from LIVE INTROSPECTION
AT SOURCE. Tell me in plain English where we are before you propose anything.
```

---

## For the seat, not for Daniel

**The unit.** `pg_cron` (1.6.4, available, NOT installed) plus an hourly schedule for `snapshot_project_v1`, plus the retention delete — 48h hourly / 30d daily / weekly after, **a date-only delete on `project_snapshots` that NEVER touches `project_blobs`.**

**Three things measured this session that the design needs, all re-checkable:**

1. ⚠ **`pg_cron` runs as a superuser, so RLS does not apply and `auth.uid()` is NULL** — an automatic snapshot therefore has a null `created_by`. That is correct and must be deliberate rather than discovered.
2. **A snapshot is 0.58 MB stored and the function runs in ~570 ms against the 8-second budget.** Worst case for a production edited every hour for a year with all three tiers full is about **77 MB**; the database is at 41 MB of 8 GB.
3. ⚠ **Skip-if-unchanged already works and is proven** — the function returns NULL and writes nothing when the payload, library and identity-map hashes all match the newest snapshot. **The timer does not need to re-implement it.**

**Do not:** re-open any of VERHIST's seven rulings, or the 20-row threshold, or Delete All's exemption · build reference-counted expiry · expire a blob, ever · put the retention delete anywhere it can run inside a user request.

**Owed at Daniel's desk, unchanged:** AUTH-RESETPAGE (gates public beta on its own) · the auto-mode rider's Sprint 4 sunset, now carrying **CCSED-260911** as evidence · three ignore lines in the code repo · the two postponed browser gates · the 5167 sheet · the Tail Panel reprint · **CAND-4, overdue**.
