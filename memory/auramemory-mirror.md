---
name: auramemory-mirror
description: SUPERSEDED — hand-copying C:\AuraMemory\memory is no longer needed; see cross-agent-shared-memory
metadata:
  type: project
---

**Superseded on 2026-09-30.** `C:\AuraMemory\memory` used to be a hand-refreshed copy of
Claude Code's memory dir, kept in step manually. That is dead.

The shared store is now the git repo `~/memhub` (`C:\Users\dusan\memhub`, GitHub
`DusanCar-sudo/aura-memory`), synced automatically. See [[cross-agent-shared-memory]].

`C:\AuraMemory` still holds the 2026-09-24 Windows-install artefacts (HANDOFF.md, the
sfdisk dump, Win11Debloat.ps1). Leave those; just stop treating `memory/` there as live.
