# Cowork commit — what Daniel pastes, 2026-09-10

**Repo:** `~/Developer/Minotaur-Cowork` (the documents repo — **not** the code repo, so this is not a deploy and nothing ships).

**What is in it:** the close package for the four-unit session — Roadmap **v4.25** (which retires v4.24), the Ledger's **tenth append**, the Session Log taken to **10 entries** (which trips the rollover for next session), and the six working drafts that carry findings out of the gitignored CC handoffs.

```
cd ~/Developer/Minotaur-Cowork
git add Minotaur_v2_Roadmap_v4_25.md Minotaur_v2_Ledger_v1_0.md Minotaur_v2_Session_Log.md drafts/
git commit -m "docs: four units and four deploys closed - Roadmap v4.25 (retires v4.24), Ledger tenth append, Session Log to 10 with the rollover now due; the visual gate closes reliably for the first time at five consecutive 28/28, the dark-mode cluster was never in the palette anyone had audited and its root cause was a comment written here two units ago, the find sweep discharged 25 of 25, and three Arch errors share one shape - an instrument that inherited a prior claim's parameters instead of measuring which surface renders the thing"
git push
```

**After it pushes, nothing else is owed on this repo.** The code repo is already at `dce1b72` with origin identical.
