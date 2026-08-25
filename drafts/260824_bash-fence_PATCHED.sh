#!/bin/bash
# Blocks: git add -A/--all/., git commit -a/-am/--all variants, any embedded
# git push, anywhere in the command (composition-aware). Exit 2 = block with
# message. WF-1a (Aug 9, re-armed): plain `git commit` is unblocked for the
# commit pilot, but bulk staging (git add -A/--all/. and commit -a variants)
# STAYS fence-blocked, and git push STAYS blocked — both human-only.
CMD=$(jq -r '.tool_input.command // empty')
[[ -z "$CMD" ]] && exit 0

# --- FENCE-COMMITA (2026-08-24) ----------------------------------------------
# The git matchers below run against a QUOTE-STRIPPED copy of the command, not
# the raw one. Two defects made that necessary, both found by running the
# matcher against a battery rather than by reading it:
#
#   FALSE NEGATIVE (the serious one): the old pattern required the `a` to be
#   the LAST character of the flag cluster — `(-a|--all|-am)([[:space:]]|$)`.
#   So `git commit -av` and `git commit -avm "msg"` are REAL bulk-staging
#   commits that sailed straight through this fence from the day it was
#   written. The flag pattern is now `-[a-zA-Z]*a[a-zA-Z]*`, which catches an
#   `a` anywhere in a short-flag cluster.
#
#   FALSE POSITIVE: `-a` / `-am` / `--all` occurring inside the -m MESSAGE TEXT
#   tripped the matcher. It blocked the real 2-IMP-a commit, whose subject ends
#   "...unit 2-IMP-a — ...", even though staging had been done by explicit
#   filename. A quoted string is never a flag, so quoted spans are removed
#   before matching. This also stops `git commit -m "...; git push ..."` from
#   tripping the push matcher.
#
# Quote-stripping is applied ONLY to the three git matchers. The redirect, tee
# and stream-editor guards below keep the RAW command, because there the quoted
# text IS the thing being checked — a quoted redirect target must stay visible.
GITCMD=$(printf '%s' "$CMD" | sed -E 's/"[^"]*"/ /g; s/'"'"'[^'"'"']*'"'"'/ /g')

if echo "$GITCMD" | grep -Eq '(^|[;&|(][[:space:]]*)git[[:space:]]+add[[:space:]]+(-[a-zA-Z]*A[a-zA-Z]*|--all|\.)([[:space:]]|$)'; then
  echo "BLOCKED by fence: git add -A/--all/. is banned — stage by explicit filename." >&2; exit 2; fi
if echo "$GITCMD" | grep -Eq '(^|[;&|(][[:space:]]*)git[[:space:]]+commit([[:space:]]|$)' \
   && echo "$GITCMD" | grep -Eq '(^|[[:space:]])(-[a-zA-Z]*a[a-zA-Z]*|--all)([[:space:]]|$)'; then
  echo "BLOCKED by fence: git commit -a variants are banned — stage by name first." >&2; exit 2; fi
if echo "$GITCMD" | grep -Eq '(^|[;&|(][[:space:]]*)git[[:space:]]+push([[:space:]]|$)'; then
  echo "BLOCKED by fence: git push is human-only (Strat invariant 1)." >&2; exit 2; fi

# --- Read-only recon guards (2026-07-11 amendment) ---------------------------
# The heads below are pre-approved in settings.json allow. These guards keep
# them read-only: no filesystem writes, no exec vectors. Redirects/tee from
# these heads may target only /tmp, ~/Desktop (handoff convention), or
# /dev/null — bash redirects into the repo would bypass the frozen-check
# PostToolUse hook, which watches Edit/Write tools, not Bash.
RO_HEADS='(cat|grep|rg|ls|find|head|tail|wc|sort|diff|shasum|awk|echo|printf|file|stat)'

# find must stay read-only: no -delete / -exec / -ok family
if echo "$CMD" | grep -Eq '(^|[;&|(][[:space:]]*)find[[:space:]]' \
   && echo "$CMD" | grep -Eq '[[:space:]]-(delete|exec|execdir|ok|okdir)([[:space:]]|$)'; then
  echo "BLOCKED by fence: find with -delete/-exec/-ok is a write/exec vector — use explicit commands instead." >&2; exit 2; fi

# redirects (> or >>) from read-only heads: whitelist targets only
if echo "$CMD" | grep -Eq "(^|[;&|(][[:space:]]*)${RO_HEADS}[[:space:]]" \
   && echo "$CMD" | grep -Eq '>>?[[:space:]]*[^[:space:]]'; then
  TARGETS=$(echo "$CMD" | grep -oE '>>?[[:space:]]*[^[:space:];&|)]+' | sed -E 's/^>>?[[:space:]]*//')
  for t in $TARGETS; do
    case "$t" in
      /tmp/*|"$HOME"/Desktop/*|'~'/Desktop/*|/dev/null) ;;
      *) echo "BLOCKED by fence: redirect target '$t' — read-only commands may write only to /tmp, ~/Desktop, or /dev/null. Repo files go through the Edit tool." >&2; exit 2 ;;
    esac
  done
fi

# tee from read-only heads: same whitelist
if echo "$CMD" | grep -Eq "(^|[;&|(][[:space:]]*)${RO_HEADS}[[:space:]].*\|[[:space:]]*tee[[:space:]]"; then
  TT=$(echo "$CMD" | grep -oE '\|[[:space:]]*tee[[:space:]]+(-a[[:space:]]+)?[^[:space:];&|)]+' \
       | sed -E 's/^\|[[:space:]]*tee[[:space:]]+(-a[[:space:]]+)?//')
  for t in $TT; do
    case "$t" in
      /tmp/*|"$HOME"/Desktop/*|'~'/Desktop/*|/dev/null) ;;
      *) echo "BLOCKED by fence: tee target '$t' — read-only commands may write only to /tmp, ~/Desktop, or /dev/null." >&2; exit 2 ;;
    esac
  done
fi

# In-place stream editors (sed -i / perl -i / gawk -i) — 2026-07-23 amendment:
# permitted generally under the CLAUDE.md Sed Disclosure Rule, but NEVER against
# frozen-layer files. Bash writes bypass the PostToolUse frozen-check hook
# (it watches Edit/Write tools), so the fence holds this line: frozen files
# change only via the Edit tool, where the frozen gate sees them.
FROZEN_FILES='(EquipmentListClient\.tsx|EquipmentItemRow\.tsx|globals\.css)'
if echo "$CMD" | grep -Eq '(^|[;&|(][[:space:]]*)(sed|perl|gawk)[[:space:]]+([^;|&]*[[:space:]])?-[a-zA-Z]*i' \
   && echo "$CMD" | grep -Eq "$FROZEN_FILES"; then
  echo "BLOCKED by fence: in-place stream edit targeting a frozen-layer file — frozen files change only via the Edit tool under the frozen gate." >&2; exit 2; fi

exit 0
