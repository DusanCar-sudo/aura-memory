---
name: aura-surface-confusion
description: "Dusan's repos mix website/repo-page/app in one git tree; agents keep editing the wrong surface, which is the recurring failure mode"
metadata: 
  node_type: memory
  type: project
  originSessionId: 8096a5ca-7cf5-4e91-8939-b72725949746
  modified: 2026-07-29T14:17:19.665Z
---

The recurring failure across Dusan's repos: a single git tree holds several
public "surfaces" that agents conflate. In `enables`, `index.html` is the
website (enables.vercel.app) while `README.md` is the GitHub repo page — so
"put this image in the repo" is ambiguous, and Aura put a screenshot on the
landing page instead of the README.

Cost of one instance (2026-07-29): 100 turns, 126 tool calls, 2.54M tokens,
and Dusan repeating himself 7 times. Commits `b19c84d6` (wrong) →
`d3852451` + `5b9d08b6` (undo).

Worst offenders:
- `lean-progress-iq` — 8 HTML files, only `index.html` is live; the other 7
  (`1index.html`, `ind34ex.html`, `milutinindex.html`, …) are dead drafts
  still publicly reachable because `cleanUrls` is on.
- `aura-pulse` / `ruby-diamond-client` — `index.html` is a Tauri **app shell**,
  not a website. The Aura Pulse website is a *separate repo*
  (`aura-pulse-website`).
- `aura-code` — the website is `site/` only (`vercel.json` sets
  `outputDirectory`); stray root-level HTML is served to nobody.

**Why:** Dusan's frustration here is about being misunderstood repeatedly, not
about code quality. Getting the surface right matters more than elegance.

**How to apply:** Before editing any image, copy, or layout in his repos, name
which surface the request means and say which file you changed — never just
"done". If two surfaces could match, ask one short question. This is what the
[[aura-md-convention]] files encode.
