---
name: aura-md-convention
description: "AURA.md is the house agent-rules file across Dusan's repos; Aura reads only it, root-only, hard-truncated at 2000 chars"
metadata: 
  node_type: memory
  type: project
  originSessionId: 8096a5ca-7cf5-4e91-8939-b72725949746
  modified: 2026-07-29T14:17:09.626Z
---

`AURA.md` at the repo root is the standing-rules convention across all of
Dusan's repos — not `CLAUDE.md`, not `AGENTS.md`. On 2026-07-29 all 12 public
repos got one, and `CLAUDE.md` was deleted from `enables` and `agentmesh` to
consolidate.

Hard technical constraints, verified in the installed `aura-code` package at
`dist/agent/context.js:52`:

```js
auraRules: readTruncated(root, ['AURA.md'], 2000, 'AURA.md'),
```

- Aura loads **only** `AURA.md`, **only** from the repo root. No subdirectory
  lookup, no `CLAUDE.md`/`AGENTS.md` fallback.
- Content is **silently truncated at 2000 characters** (`slice(0, 2000)`).
  Anything past that is dropped with a `[...truncated]` marker. Keep every
  `AURA.md` under 2000 chars or the tail is dead weight.
- It is injected into the system prompt under the heading
  `### Aura Standing Rules`.

House format (from `aura-code/AURA.md`): `# Aura Standing Rules` H1, `## Topic`
sections, hard-wrapped prose paragraphs (~65 cols), imperative and firm —
"violations should be flagged as bugs, not treated as style preferences".
Prose, not tables.

**Why:** Dusan asked for this explicitly after a `CLAUDE.md` sitting in
`enables` turned out never to have been read by Aura at all.

**How to apply:** When adding project rules for Dusan, write `AURA.md`, check
`wc -c` is under 2000, and match the prose format. See
[[aura-surface-confusion]] for what these files exist to prevent.
