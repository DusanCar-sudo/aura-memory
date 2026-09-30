---
name: aura-os-roadmap-tools
description: "Aura OS tool roadmap Dusan set 2026-09-16 — two-pane TUI file manager, Notepad-style TUI editor, clickable popups; and the recurring \"built but never deployed\" failure"
metadata: 
  node_type: memory
  type: project
  originSessionId: 1f0da35e-caee-4dd6-9ebc-1cdbfeb5af19
  modified: 2026-09-21T17:08:54.669Z
---

Roadmap Dusan asked to remember (2026-09-16):
1. **Two-pane TUI file explorer / file manager**, very lightweight. DONE
   and evolving: `bin/aura-os-files` (two-pane, committed 2026-09-22) plus
   `aura-os-files pane` + Super+G right-edge pane (deployed live,
   commit bc023ce8, task 009 part 4). `aura-files-rs` remains the
   full-window Rust manager; `bin/aura-files` (curses icons version) is
   still uncommitted work from another session.
2. **Our own lightweight TUI text editor that feels like Windows Notepad**: Ctrl+S/C/V/Z, mouse, a menu bar. A draft exists as `bin/aura-edit` (referenced by bin/aura-files) — check deploy state before claiming done.
3. **Clickable popups**: click opens, the popup stays open while the mouse moves, and a click outside closes it. Built Sep 15 as `aura-os-popup`, but it sits uncommitted in `/mnt/data/aura-os` and never reached production.

**Why:** Dusan's goal is that anyone can control Aura OS at a basic level without a terminal REPL; see [[build-motto]] and [[aura-os-shell-repo]].

**Recurring failure:** work gets built and even committed in one of three trees (`/mnt/bigdata/aura-os-work` = github DusanCar-sudo/aura-os, `/mnt/data/aura-os`, `/mnt/bigdata/aura-os-shell`) but never deployed to the live system. The live system uses `/usr/local/bin`, which is root-owned, plus `~/.config`. On 2026-09-16 the menus, the sidebar sysgraph/llmtest, and the calendar were deployed through `~/.local/bin` symlinks and absolute paths in waybar/sway, because sway/waybar PATH lacks `~/.local/bin`.

**How to apply:** Finishing a feature means it is running on the live laptop, confirmed with a screenshot, not merely built in a repo.
