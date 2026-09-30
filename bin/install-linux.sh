#!/usr/bin/env bash
# One-shot installer for the Linux (Aura OS) half of the shared memory.
#   bash ~/memhub/bin/install-linux.sh
# Safe to re-run.
set -uo pipefail
REPO="https://github.com/DusanCar-sudo/aura-memory.git"
HUB="$HOME/memhub"

# ---- 1. the hub ----
if [ -d "$HUB/.git" ]; then
  echo "== hub already at $HUB, pulling"
  git -C "$HUB" pull -q --no-edit -X union || true
else
  echo "== cloning shared memory to $HUB"
  git clone -q "$REPO" "$HUB" || { echo "clone failed — is gh/git logged in?"; exit 1; }
fi
chmod +x "$HUB/bin/"*.sh

# ---- 2. Claude Code: keep a PRIVATE dir, put the shared store inside it as shared/ ----
PRIVATE_INDEX='<!-- Claude Code'"'"'s PRIVATE memory index for this machine. -->
<!-- The SHARED brain — also read and written by Aura and Codex, on Linux and Windows — is ./shared/ -->

**Shared memory: read `shared/MEMORY.md` first.** That index covers Dusan, his machines and
every project, and stays in sync with Aura and Codex across both operating systems.

Where to write a new memory:

- **`shared/`** — anything another agent would want: who Dusan is, machine layout, project
  state, standing rules, fixes that took real work. This is the default. After writing the
  file, add its line to `shared/MEMORY.md`.
- **here** — only notes that are meaningless outside Claude Code (a quirk of a Claude tool,
  a slash command, a hook). Add the line below.

Run `memsync` after writing to `shared/` so Aura, Codex and the Windows side get it.

## Private (Claude Code only)
'

wire_claude() {
  local d="$1"
  # an old full-dir symlink from the first version of this script: undo it
  if [ -L "$d" ]; then rm -f "$d"; fi
  if [ -d "$d" ] && [ ! -e "$d/shared" ]; then
    # first time: promote this project's existing memories into the shared store
    cp -n "$d"/*.md "$HUB/memory/" 2>/dev/null
    rm -f "$d"/*.md
  fi
  mkdir -p "$d"
  ln -sfn "$HUB/memory" "$d/shared"
  [ -s "$d/MEMORY.md" ] || printf '%s' "$PRIVATE_INDEX" > "$d/MEMORY.md"
  echo "== claude: $d (private) + shared -> $HUB/memory"
}

mkdir -p "$HOME/.claude/projects"
shopt -s nullglob
for p in "$HOME"/.claude/projects/*/; do wire_claude "${p%/}/memory"; done
shopt -u nullglob
# the project dir for $HOME itself, which may not exist yet
wire_claude "$HOME/.claude/projects/-home-$USER/memory"

# ---- 3. tell Claude about it globally ----
CLAUDE_MD="$HOME/.claude/CLAUDE.md"
if ! grep -q "Shared memory (Claude Code + Aura + Codex)" "$CLAUDE_MD" 2>/dev/null; then
  mkdir -p "$HOME/.claude"
  cat >> "$CLAUDE_MD" <<'MD'

# Shared memory (Claude Code + Aura + Codex)

Three agents share one brain. It lives in the git repo `memhub`
(Linux `~/memhub`, Windows `C:\Users\dusan\memhub`) and syncs itself every 15 minutes
and at login. Force a sync any time with the command `memsync`.

- **Shared store** — `memory/` in that repo. Reachable from here as `shared/` inside the
  memory directory. Its index is `shared/MEMORY.md`. **Read it.**
- **Private store** — the memory directory itself, for Claude-Code-only notes.

Write a new memory to `shared/` by default; keep it private only when it would be
meaningless to Aura or Codex. Same file format either way. Aura sees the shared store as
`~/.aura/memory/default.json`; Codex sees it as `~/.codex/AGENTS.md`. Both are generated —
never edit them by hand, edit the `.md` files.
MD
  echo "== added the shared-memory section to ~/.claude/CLAUDE.md"
fi

# ---- 4. memsync on PATH ----
mkdir -p "$HOME/.local/bin"
ln -sf "$HUB/bin/memsync.sh" "$HOME/.local/bin/memsync"
echo "== memsync -> ~/.local/bin/memsync"
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) echo "   NOTE: ~/.local/bin is not on your PATH — add it in ~/.bashrc" ;;
esac

# ---- 5. first sync: writes Aura's default.json and Codex's AGENTS.md ----
"$HUB/bin/memsync.sh"

# ---- 6. keep it fresh ----
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
cat > "$HOME/.config/systemd/user/memsync.timer" <<'UNIT'
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
echo "== timer on (systemctl --user list-timers memsync.timer)"

# ---- 7. launcher entry, per the app-list rule ----
mkdir -p "$HOME/.local/share/applications"
cat > "$HOME/.local/share/applications/memsync.desktop" <<DESK
[Desktop Entry]
Type=Application
Name=Sync Agent Memory
Comment=Sync the shared memory between Claude Code, Aura and Codex
Exec=$HUB/bin/memsync.sh
Terminal=true
Icon=folder-sync
Categories=Utility;
DESK
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null

echo
echo "Done. Claude Code, Aura and Codex on Aura OS now share $HUB/memory."
echo "Check it:  cat ~/memhub/memory/MEMORY.md"
