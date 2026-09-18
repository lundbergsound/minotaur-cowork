# NEXT-UPGRADE — Next.js 16.2.6 → 16.3.3, for the security advisories

Tier: 3
Model: claude-opus-5
Session: FRESH

*Arch, Cowork main line, 2026-09-18 13:57 ET. Read HEAD from `.git/refs` at open (BATCH-HOUSEKEEPING was
committing as this was written; expect `316b761` or its successor = `origin/main`). Migration ledger **78**.
**Ruled by Daniel 2026-09-18: "upgrade Next"**, on BATCH-HOUSEKEEPING's OPEN QUESTION 3 (npm audit at
install: `next` 16.2.6 carries two critical advisories — GHSA-2xp9-vwfh-vxw4, GHSA-p293-qw3h-jr36 — and
highs including GHSA-6gpp-xcg3-4w24, a middleware/proxy bypass; fixes in 16.2.11 / 16.3.3).*

**⚠ Every answer you need is in this file. There is no blank for anyone to fill in.**

## §0 · HARD STOPS

1. **This unit ships alone.** It changes the runtime under every page. No other source change rides it,
   except §3's migration file, which is not code.
2. **No migrations, no SQL writes.** MAILGATE holds.
3. **Expected gate: 28/28, no baseline event.** A moved frame is a finding to diagnose and report, **never a
   baseline to write** in this unit. Stop and return if any frame moves.
4. **The frozen layer must stay 3/3.** If the upgrade forces a change inside it, stop.
5. Raw Output Rule, every command whose output matters: *"Reproduce the complete raw output verbatim — into
   the handoff file's RAW OUTPUT section if the project uses one, otherwise inline. Do not summarize,
   paraphrase, or describe it. Show every line."*
6. **GATE-NOGREP.** Commit only on Daniel's `COMMIT APPROVED: <first words of the subject>`, after his
   browser gate on the deployed-equivalent build. The push is a production deploy.

## §1 · CP0 — before

- Quote `npm audit --omit=dev` (full) and `npm audit` summary counts into RAW OUTPUT.
- Quote the installed `next`, `eslint-config-next`, `react`, `react-dom` versions.

## §2 · CP1 — the upgrade

1. `next` → **exactly `16.3.3`**; `eslint-config-next` → exactly the same version (the repo pins exactly).
   Touch `react`/`react-dom` only if 16.3.3's peer range requires it, and say so.
2. Read the 16.2.x → 16.3 upgrade notes for anything affecting this app's surface: **`src/middleware.ts`**
   (auth), `next.config.js` (the build-stamp `env` block landed in `b07eef5`), `next/font/local` (Urbanist),
   route handlers, and the Turbopack build. Quote what applies; ignore what does not.
3. If a deprecation warning appears at build (e.g. middleware → proxy naming), **report it; do not migrate
   the file in this unit** unless the build fails without it.
4. `npm audit --omit=dev` after. **Success condition: zero critical, zero high in the production audit**, or
   each remaining one named with why it cannot be fixed at 16.3.3.

## §3 · Migration 78's file of record — crosses now

Arch applied migration **78** at 17:15Z while BATCH-HOUSEKEEPING was live (ONE-WRITER-HOLDS), so its file
was staged in `Minotaur-Cowork/drafts/20260918171501_methods_palette_strays_to_shared_palette.sql`.
Copy it **unedited** to `supabase/migrations/`. Verify: the body below the comment header has md5
**`878186d0d5cf741c702ca7cb31a2f245`** (= `schema_migrations.statements`). Quote the check. If it differs, stop.

## §4 · Gates

Full suite · `tsc --noEmit` · `npm run build` (Turbopack, as production) · `npm run lint` exit 0 · frozen 3/3 ·
visual 28/28 · dependency gate: the diff is `package.json` + lock only, and name every package whose
resolved version moved. **Plus a signed-out smoke on a production build (`next start`):** a signed-out
request to a project page redirects to sign-in; a signed-in session reaches the dashboard, opens a show and
reaches its print preview. That is the middleware path the high advisory is about.

## §5 · Close

Replace the run fence in `CLAUDE.md` with this unit. Return to `handoffs/from-cc/` as DONE / FILES CHANGED /
OPEN QUESTIONS / RAW OUTPUT with a COMMIT BLOCK (`git add` by filename). Proposed subject:
`NEXT-UPGRADE: next 16.3.3 for the security advisories`.

**Daniel's browser gate, BEFORE the phrase, on the local production build you point him to:** sign out and
back in; open a show; print its equipment list. **After the push**, one glance at minotaur.app: the footer
shows the new build stamp and sign-in still works.
