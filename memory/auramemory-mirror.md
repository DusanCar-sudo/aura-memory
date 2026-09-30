---
name: auramemory-mirror
description: C:\AuraMemory\memory is a mirror of the Claude memory dir; refresh it by copying every file over when memories change
metadata: 
  node_type: memory
  type: project
  originSessionId: 77bf5413-3234-4d78-adad-ce76409c1bb2
  modified: 2026-09-26T07:00:34.451Z
---

Dusan keeps a second copy of the memory tree at `C:\AuraMemory\memory`, outside
`~/.claude`. It is a plain mirror of
`C:\Users\dusan\.claude\projects\C--Users-dusan\memory\` (same filenames,
`MEMORY.md` included) that Aura and other tools read from, so it goes stale as
soon as new memories are written here.

**Why:** the mirror sits outside the Claude config tree, so it survives
reinstalls/profile moves and is readable by Aura without knowing Claude's
project-hashed path — but nothing syncs it automatically.

**How to apply:** when Dusan says to paste/replace the files there, or after
writing memories that Aura needs, copy the whole source dir over the mirror
with `Copy-Item -Force` (overwrite, do not merge) and delete mirror files that
no longer exist in the source. First refresh done 2026-09-26, which added
[[user_profile]], [[project_vega_workflow]], [[reference_vega_materials]] and
the Vega no-AI rule that the Sep 24 mirror was missing. Related:
[[solution-md-rule]], [[full-autonomy]].
