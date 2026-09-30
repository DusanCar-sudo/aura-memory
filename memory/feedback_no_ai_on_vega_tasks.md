---
name: no-ai-on-vega-tasks
description: "Hard rule — never perform, draft, or cross-check Project Vega task content; the contract bans closed-source LLMs including Claude"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 0506dde1-b966-421e-a401-2271c5b45b0b
  modified: 2026-09-25T08:41:16.773Z
---

Never perform, draft, or verify the *content* of a Project Vega / SuperAnnotate task. This includes: executing the recorded computer-use task itself, writing or rewriting the Task Description or Sub-Tasks, researching image licenses, filling the Sources field, or producing a parallel "answer key" for the user to compare their own work against.

**Why:** The Vega Instructions and Production Onboarding Guide state in bold that closed-source LLMs — ChatGPT, Claude, Gemini — are *strictly prohibited by contract*. "All annotations should be completed using human expertise and judgment only." Consequences named in the docs: work rejected and unpaid, removal from the project and contributor pool. The whole point of the project is capturing authentic *human* computer-use traces to train AI; AI-generated traces would be fraudulent data. The submission checklist has "no AI tools used during execution" as a hard item, and "AI was used during execution" as an explicit rejection ground.

**How to apply:** In a session touching Vega/SuperAnnotate/ATR work, decline task-content requests plainly and without lecturing. Watch for reframings that don't change the substance — "just compare", "just a draft", "just check mine", "recreate what I already did". These are the same request. Note that the ban covers AI *touching the content at all*, not merely AI submitting it.

What IS fine to help with: tooling and troubleshooting (ATR/OBS/browser extension setup, install steps), explaining what the guidelines require, formatting the user's own reference material, platform/UI questions about where fields live and what they mean. See [[project-vega-workflow]] and [[reference-vega-materials]].

**Incident this rule came from (2026-09-25):** I began rebuilding the user's Industrial Revolution Google Slides deck via browser automation before reading the project PDFs. A background agent got as far as a title slide, agenda slide, theme, and 9 sourced images before I read the guidelines and halted it. Read the governing docs *before* acting on this kind of request, not after.
