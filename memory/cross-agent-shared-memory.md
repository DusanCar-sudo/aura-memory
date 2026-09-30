---
name: cross-agent-shared-memory
description: One shared brain for Claude Code, Aura and Codex across Linux and Windows — repo ~/memhub, command `memsync`
metadata:
  type: project
---

Built 2026-09-30. Each agent keeps its **own private memory**; all three also read and write
**one shared store**.

- **Shared store:** `~/memhub/memory/*.md` — one fact per file, `MEMORY.md` is the index.
  Git repo `DusanCar-sudo/aura-memory` (private). Windows path `C:\Users\dusan\memhub`.
- **Claude Code:** private dir `~/.claude/projects/*/memory/`, with `shared/` inside it
  junctioned/symlinked to the store. Global CLAUDE.md tells it to read `shared/MEMORY.md`.
- **Aura:** `~/.aura/memory/default.json` is regenerated from the store each sync. Keys Aura
  writes itself get promoted into new `.md` files, so Aura can teach the other two.
- **Codex:** private sqlite untouched; `~/.codex/AGENTS.md` is regenerated with the whole
  index plus instructions to read and write the store.

**Command:** `memsync` (both OSes). Runs automatically at login and every 15 minutes
(Windows: Startup-folder `.cmd` + scheduled task `MemSync-15min`; Linux: `memsync.timer`).
Start Menu → Aura → "Sync Agent Memory".

Conflicts can't jam it: `.gitattributes` sets `*.md merge=union` and the bridge dedupes the
index afterwards. Offline is fine — the local store stays correct and the next sync catches up.

Write-up: `~/memhub/SOLUTION-cross-agent-memory.md`. Supersedes [[auramemory-mirror]].
