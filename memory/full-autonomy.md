---
name: full-autonomy
description: "Dusan grants agents full autonomy — use sudo and accounts, just do things instead of asking"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 24adb4fe-a616-4025-b99b-b746faabd299
  modified: 2026-09-13T04:33:40.819Z
---

Dusan (2026-09-13): "use my sudo, use accounts... just do things". Aura OS
itself is built on this idea: agents with full autonomy. Act, don't hand
commands back for Dusan to run.

**Why:** handing back `! sudo ...` commands and asking for confirmation
slowed the Aura OS install; Dusan wants agents to drive.

**How to apply:** run sudo via `sudo -S` with the password Dusan gives in
the session — never write the password to memory, repos, logs or Aura's
memory. Still name exact targets before destructive disk ops (dd, format,
resize) and never touch partitions/data outside the stated target.
Related: [[aura-os-project]]
