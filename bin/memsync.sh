#!/usr/bin/env bash
# memsync — pull every agent's memory into one shared store, then sync it with GitHub.
# Linux half. Safe to run as often as you like.
set -uo pipefail
HUB="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MEM="$HUB/memory"
AURA="$HOME/.aura/memory"
AGENTS="$HOME/.codex/AGENTS.md"

say() { [ -n "${MEMSYNC_QUIET:-}" ] || echo "memsync: $*"; }

cd "$HUB" || exit 1

# 1. fold Aura's own memory in, push the whole store back out to Aura + Codex
node "$HUB/bin/aura-bridge.mjs" "$MEM" "$AURA" "$AGENTS" | while read -r l; do say "$l"; done

# 2. commit anything new locally
git add -A >/dev/null 2>&1
if [ -n "$(git status --porcelain)" ]; then
  git commit -q -m "memory: sync from linux $(date '+%Y-%m-%d %H:%M')" >/dev/null 2>&1
  say "committed local changes"
fi

# 3. exchange with GitHub (union merge — never blocks on a conflict)
if git remote | grep -qx origin; then
  git fetch -q origin >/dev/null 2>&1
  if git ls-remote --heads origin main | grep -q main; then
    if ! git merge -q --no-edit -X union origin/main >/dev/null 2>&1; then
      git merge --abort >/dev/null 2>&1
      say "merge skipped (manual check needed)"
    fi
  fi
  if git push -q -u origin main >/dev/null 2>&1; then
    say "synced with github"
  else
    say "push failed (offline?) — local store is still correct"
  fi
fi

# 4. re-run the bridge so anything that arrived from the other machine reaches Aura + Codex
node "$HUB/bin/aura-bridge.mjs" "$MEM" "$AURA" "$AGENTS" >/dev/null 2>&1
say "done"
