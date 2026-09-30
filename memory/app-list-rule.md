---
name: app-list-rule
description: Every app built for Aura OS must be added to the app list (fuzzel launcher .desktop entry) — always, without being asked
metadata:
  type: feedback
---

Every app we build for Aura OS goes into the app list: write a `.desktop` file in `~/.local/share/applications/` (the Super+D fuzzel launcher reads it) and a copy in the repo at `aura-os-work/config/applications/`.

**Why:** Dusan (2026-09-16), after the file manager and editor were built: "put both into app list. do that always". An app that can only be started by a command or a keybinding isn't reachable for normal users; see [[aura-os-roadmap-tools]].

**How to apply:** This is part of "done" for any new GUI or TUI app. TUIs launch through `aura-term --app-id=<name> -e <absolute path>`. Validate with `desktop-file-validate`.
