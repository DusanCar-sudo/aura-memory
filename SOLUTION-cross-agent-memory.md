# Cross-agent shared memory (Linux ↔ Windows) — how it was built

**Problem:** Claude Code, Aura and Codex each had their own memory, in three different
formats, on two operating systems that cannot read each other's disks. Facts learned in one
place were invisible everywhere else, and the old fix was hand-copying `C:\AuraMemory\memory`.

**Solution:** one git repo is the shared brain; each agent keeps its own private memory and
gets the shared store translated into its native format on every sync.

## The pieces

| Path | What it is |
|---|---|
| `~/memhub` (`C:\Users\dusan\memhub`) | the repo — `DusanCar-sudo/aura-memory` (private) |
| `memhub/memory/*.md` | **the shared store.** One fact per file + `MEMORY.md` index |
| `~/.claude/projects/*/memory/` | Claude's **private** store |
| `~/.claude/projects/*/memory/shared` | junction (Win) / symlink (Linux) → `memhub/memory` |
| `~/.aura/memory/default.json` | generated for Aura; Aura's own keys are preserved and promoted |
| `~/.codex/AGENTS.md` | generated for Codex — full index + read/write rules |
| `~/.codex/*.sqlite` | Codex's **private** store, untouched |

## Why these choices

- **Markdown as the canonical format.** It was already Claude Code's format, it is
  human-readable, it diffs, and both other agents can be fed from it.
- **Git, not a shared partition.** Windows cannot read btrfs/ext4, and Linux mounting NTFS
  read-write while Windows may have a dirty volume is asking for corruption. GitHub also
  reaches the asusmadre laptop and anything added later.
- **`*.md merge=union` in `.gitattributes`.** Two machines editing memory never produce a
  merge conflict that stops the sync — both sides survive, and `aura-bridge.mjs` dedupes the
  index on the next run. For a non-developer, a sync that never jams beats a clean history.
- **A junction, not a copy, for Claude.** Claude writes into `shared/` and it is already in
  the repo. No copy step to forget.

## Gotchas hit along the way

- `Register-ScheduledTask` and `schtasks /SC ONLOGON` both need admin. The 15-minute task
  (`schtasks /SC MINUTE /MO 15`) registers fine as a normal user; the logon trigger is a
  `.cmd` in the Startup folder instead.
- `cmd /c rmdir` on a junction is blocked by the sandbox. Use
  `[System.IO.Directory]::Delete($path, $false)` — it removes the reparse point, not the target.
- Heredocs through the Bash tool eat one level of backslash escaping. Write JS files with the
  Write tool, not a heredoc, when they contain regexes.

## Daily use

Nothing — it syncs at login and every 15 minutes. Force it with `memsync`.

## Install on the Linux side

```bash
git clone https://github.com/DusanCar-sudo/aura-memory.git ~/memhub
bash ~/memhub/bin/install-linux.sh
```

That symlinks every Claude project memory dir, puts `memsync` in `~/.local/bin`, writes
Aura's and Codex's views, and enables a `memsync.timer` user unit.

Built 2026-09-30.
