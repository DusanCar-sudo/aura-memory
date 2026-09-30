---
name: vega-llm-restriction
description: Project Vega (SuperAnnotate annotation work) contractually bans closed-source LLMs incl. Claude — only infra/tooling help is in-bounds
metadata: 
  node_type: memory
  type: project
  originSessionId: 262359f5-b95d-4dd2-bfc1-f6e5e4194f12
  modified: 2026-09-04T08:20:23.648Z
---

Dusan does paid annotation work on **Project Vega** (SuperAnnotate / SME Careers): recording 300+ step computer-use trajectories with the **Agent Trace Recorder** app + OBS Studio. Manual: `/home/dusan/Downloads/projectvega_manual.pdf`.

The manual states twice (Workflow Guide + Recording Tool Guide) that closed-source LLMs — **explicitly including Claude** — are prohibited for project work; violations mean unpaid work and removal from the project. Permitted AI for fake/dummy content: permissively-licensed models only (Nemotron, Mistral/LeChat, DeepSeek).

**Why:** The deliverable is human-interaction training data; LLM-authored content contaminates it and breaches the contract Dusan signed.

**How to apply:** Help only with machine/tooling support — Agent Trace Recorder + OBS troubleshooting (OBS WebSocket port 4455, app backend port 5328, Linux log `~/.config/Agent Trace Recorder/runtime/logs/runtime.log`), privacy pre-flight, capture verification. Never write/edit Task Descriptions, Sub-Tasks, annotations, importance notes, dummy data, or anything that becomes part of a submitted item or drives on-screen actions.
