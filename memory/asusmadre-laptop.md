---
name: asusmadre-laptop
description: "Dusan's mother's laptop \"asusmadre\" — Windows, reachable over Tailscale; old WSL node is dead"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 24adb4fe-a616-4025-b99b-b746faabd299
  modified: 2026-09-13T13:14:45.481Z
---

asusmadre = Dusan's mother's ASUS laptop, runs a free (Chinese) agent Dusan
is trying out. Reach it over Tailscale (tailnet leanproiq@gmail.com):
- `asusmadre-1` 100.92.138.46 — Windows, OpenSSH server on port 22 (live).
- `asusmadre` 100.65.83.119 — old WSL2 node, offline since 2026-08-09.
My key: `~/.ssh/asusmadre_ed25519` (made 2026-09-13); Dusan adds the .pub
to Windows `administrators_authorized_keys` and tells me the username.

**How to apply:** `ssh -i ~/.ssh/asusmadre_ed25519 <user>@100.92.138.46`.
Don't guess usernames/passwords there. Don't wire that agent into
aura-os-mcp on the main laptop (its provider would see desktop data) —
use the VM or a read-only tool set if Dusan wants to try it.
