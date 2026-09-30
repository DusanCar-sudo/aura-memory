# Shared agent memory

One brain for **Claude Code**, **Aura** and **Codex**, on **both** Linux (Aura OS) and Windows.

The truth lives in `memory/` — one `.md` file per fact, plus `MEMORY.md` as the index.
Everything else is generated from it.

| Agent       | How it sees the store                                                    |
|-------------|--------------------------------------------------------------------------|
| Claude Code | `~/.claude/projects/*/memory` is a symlink/junction to `memory/` — writes land here directly |
| Codex       | `~/.codex/AGENTS.md` is regenerated with the full index + read/write rules |
| Aura        | `~/.aura/memory/default.json` is regenerated; new Aura keys become new `.md` files |

## Daily use

Nothing. It syncs itself every 15 minutes and at login.

To force it: `memsync`

## Install on the other machine

```bash
git clone https://github.com/DusanCar-sudo/aura-memory.git ~/memhub
bash ~/memhub/bin/install-linux.sh
```

## How it stays out of your way

- `.gitattributes` sets `*.md merge=union`, so two machines editing memory never produce a
  merge conflict — both versions survive and the index is deduped on the next sync.
- If the network is down, everything still works locally; the next sync catches up.
- Deleting a memory: delete the `.md` file and run `memsync`. The index line and the Aura
  key go with it.
