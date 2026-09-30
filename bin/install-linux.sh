#!/usr/bin/env bash
# One-shot installer for the Linux (Aura OS) half of the shared memory.
# Run once:  bash ~/memhub/bin/install-linux.sh
set -uo pipefail
REPO="https://github.com/DusanCar-sudo/aura-memory.git"
HUB="$HOME/memhub"

# 1. get the hub
if [ ! -d "$HUB/.git" ]; then
  echo "== cloning shared memory to $HUB"
  git clone -q "$REPO" "$HUB" || { echo "clone failed"; exit 1; }
fi
chmod +x "$HUB/bin/"*.sh

# 2. every Claude Code project memory dir becomes the shared store
mkdir -p "$HOME/.claude/projects"
link_claude() {
  local d="$1"
  [ -L "$d" ] && return 0
  if [ -d "$d" ]; then
    # keep anything that was only in this project's private store
    cp -n "$d"/*.md "$HUB/memory/" 2>/dev/null
    mv "$d" "$d.bak.$(date +%s)"
  fi
  mkdir -p "$(dirname "$d")"
  ln -s "$HUB/memory" "$d"
  echo "== claude: $d -> $HUB/memory"
}
shopt -s nullglob
for p in "$HOME"/.claude/projects/*/; do link_claude "${p}memory"; done
link_claude "$HOME/.claude/projects/-home-$USER/memory"
shopt -u nullglob

# 3. memsync on PATH
mkdir -p "$HOME/.local/bin"
ln -sf "$HUB/bin/memsync.sh" "$HOME/.local/bin/memsync"
echo "== memsync installed to ~/.local/bin/memsync"

# 4. first sync (writes ~/.aura/memory/default.json and ~/.codex/AGENTS.md)
"$HUB/bin/memsync.sh"

# 5. keep it fresh: user timer every 15 min + at login
mkdir -p "$HOME/.config/systemd/user"
cat > "$HOME/.config/systemd/user/memsync.service" <<UNIT
[Unit]
Description=Sync shared agent memory
After=network-online.target

[Service]
Type=oneshot
Environment=MEMSYNC_QUIET=1
ExecStart=$HUB/bin/memsync.sh
UNIT
cat > "$HOME/.config/systemd/user/memsync.timer" <<UNIT
[Unit]
Description=Sync shared agent memory every 15 minutes

[Timer]
OnStartupSec=1min
OnUnitActiveSec=15min
Persistent=true

[Install]
WantedBy=timers.target
UNIT
systemctl --user daemon-reload
systemctl --user enable --now memsync.timer
echo "== timer enabled (systemctl --user status memsync.timer)"
echo
echo "Done. All three agents on Linux now read and write $HUB/memory."
