---
name: project-vega-workflow
description: "How Vega items flow from task design to upload, the known ATR DOM-capture bug, and the state of tasks 166/167 as of 2026-09-25"
metadata: 
  node_type: memory
  type: project
  originSessionId: 0506dde1-b966-421e-a401-2271c5b45b0b
  modified: 2026-09-25T08:41:49.567Z
---

**The four stages of an item:** design the task in SuperAnnotate (300+ steps, must match assigned Workflow Type + App Category) → record yourself doing it in Agent Trace Recorder while OBS captures screen → review the recording, map every step to a sub-task, tag important steps with notes → submit, fix AutoQA returns, respond to human QA comments. The Recording ID from ATR gets pasted into the item's Task details afterward; Sources holds the image/media URLs and licenses.

**Why this shapes advice:** AHT limits are real (a 30–50 min recording is expected to take under ~2.5 h total), and each item has a limited number of manual-QA returns before hard rejection — a re-record is expensive. Favor suggestions that get a clean capture on the first attempt over ones that risk a redo.

**The recurring failure everyone hits:** AutoQA returns items with *"Browser activity was detected, but html.jsonl is empty"* — the ATR browser extension captured no page snapshots. `html.jsonl` is JSON Lines, one page-snapshot record per line; it is what the "Browser DOM capture" checklist row reflects. Community-established fixes: set the extension's **Site access to "On all sites"** in `chrome://extensions` → Details; **refresh every tab** before recording (the extension can't read tabs restored from a previous session, or tabs granted access mid-recording); install it in the **exact browser profile and Windows user** being recorded; fully close all browsers if the task doesn't use one; and do a **30-second test recording first**, confirming the Browser DOM capture row is green before committing to a long take. Support's position is consistent: a recording that failed to capture browser data must be re-recorded, never manually approved.

**State as of 2026-09-25:** Task 166 is the Industrial Revolution Google Slides deck (13 slides, PDF to Desktop); recording `b1cd6202-a617-4c5b-b466-83312790b638` exists with 849 steps and the final PDF attached, but carries the amber DOM-capture warning — non-blocking, 0 blocking issues, so it was uploadable as-is. Task 167 is a Q3 expense analysis using TreeSize + Google Docs + Notepad. On the Vega item page the Task Description and Sub-Tasks were still the raw AI-generated draft, which the guide says never passes QA unrewritten, and Recording ID + Sources were unfilled — all of which are his to write.

**How to apply:** Use this to orient quickly in a new session, but verify current state before acting — recordings, item status, and which task is active change fast. And none of it licenses doing the work: [[no-ai-on-vega-tasks]].
