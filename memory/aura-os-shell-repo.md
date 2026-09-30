---
name: aura-os-shell-repo
description: "adOS settings UI lives in ~/Projects/aura-os-shell on the desktop; built there, deployed to the laptop"
metadata: 
  node_type: memory
  type: project
  originSessionId: 908f02b4-a80f-4b90-bad2-b103a995ca58
  modified: 2026-09-16T04:49:37.748Z
---

The Aura adOS system menus (Bluetooth, Wi-Fi, audio, screens, keyboard, themes,
F1–F12 key map) are developed in `~/Projects/aura-os-shell` on the Ubuntu
desktop, started 2026-09-16. The desktop runs KDE, not sway — so nothing there
can be tested under a real compositor; it ships to the adOS laptop via
`install.sh` (a symlink farm, so `git pull` is a full update). `HANDOFF.md` in
that repo is written for the laptop's Claude Code session.

Design law for it: one vertical list, one column, `[ ON ]`/`[ OFF ]` state on
the left, only the selected row lit. Never drop Dusan into an interactive
prompt like `bluetoothctl>` — connecting headphones must be one pick. Palette
is the adOS key art: near-black with magenta/cyan neon, plus a paper light
variant.

**Why:** Dusan could not connect Bluetooth headphones because it required
typing in a terminal REPL; the whole project exists to remove that class of
problem. See [[aura-os-project]] and [[aura-surface-confusion]].
