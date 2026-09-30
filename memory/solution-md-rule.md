---
name: solution-md-rule
description: "Standing rule (2026-09-14): after solving any problem, write a markdown file documenting how it was solved"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: ffd5aa26-ac1f-4a73-af67-ae902ba04b23
  modified: 2026-09-22T08:48:17.594Z
---

Dusan (2026-09-14): "We are making new rule whatever you do when you solve
problem you will write md file how you did solve it ..for ever solution md
file" — every time a problem gets solved (a bug fix, a debugging session, an
install, a config fix), write a `.md` file describing what the problem was
and how it was resolved.

**Why:** Dusan wants a persistent, readable record of solutions across his
many projects (aura-os, aura-code, coastline-drive, edi, voice, aura-pulse,
powerboard, etc.) — not stated further, but fits the pattern of this session:
lots of real debugging (e.g. the aura-code localhost/IPv6 ECONNREFUSED bug)
that took real investigation and would otherwise leave no trace anywhere.

**How to apply:** After resolving a nontrivial problem, write a short .md
file: what broke, root cause, the fix, how it was verified. Skip this for
trivial one-line asks (e.g. "install vlc") — reserve it for things that took
real diagnosis or had a non-obvious cause.

**Location/naming (confirmed 2026-09-22):** one file per solution in
`/mnt/bigdata/solutions/`, named `YYYY-MM-DD-short-slug.md`, with sections
Problem / Root cause / Fix / Verified. Chosen because solutions span many
unrelated projects (aura-code, Aura OS packages, LM Studio, voice setup) so a
per-project docs/ dir would scatter them. Confirmed by the Aura OS repo's own
`docs/lessons-2026-09-16.md`, which says "Full write-ups live in
`/mnt/bigdata/solutions/`; this is the distilled list" — so the pairing is:
full write-up in `/mnt/bigdata/solutions/`, a short distilled list appended to
`<repo>/docs/lessons-YYYY-MM-DD.md` for Aura to learn from.
