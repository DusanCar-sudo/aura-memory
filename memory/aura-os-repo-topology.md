---
name: aura-os-repo-topology
description: Where Aura OS lives and which clone pushes to GitHub — aura-os-work is canonical; /mnt/data/aura-os is a divergent mirror, never push from it
metadata:
  type: project
---

Aura OS git topology (set 2026-09-17):
- **Canonical clone:** `/mnt/bigdata/aura-os-work`, remote `github` → github.com/DusanCar-sudo/aura-os (private). GitHub main fast-forwards from here. gh CLI is logged in as DusanCar-sudo.
- **Divergent mirror:** `/mnt/data/aura-os` tracks the same GitHub repo but with rewritten ("mirror") commit hashes — pushing from it would conflict. Treat it as read-only reference.
- **`/mnt/bigdata/aura-os-shell`** (settings menus, calendar): own repo github.com/DusanCar-sudo/aura-os-shell (private), pushed 2026-09-17.
- Root-owned `/usr/local/bin` scripts can't be updated without sudo; deploy user tools via `~/.local/bin` symlinks + absolute paths in sway/waybar configs (see [[aura-os-roadmap-tools]]).
- Multiple agent sessions edit these trees concurrently and clobber uncommitted work (happened twice 2026-09-16/17, the logo script and a keybinding). Commit early.
