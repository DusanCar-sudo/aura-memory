---
name: atr-web-chrome
description: Running the Agent Trace Recorder desktop UI as a web page in Chrome
metadata: 
  node_type: memory
  type: project
  originSessionId: dbeb4b4a-167b-4ec6-a1fb-cce437f8d482
  modified: 2026-09-30T06:40:33.501Z
---

ATR (Agent Trace Recorder, the Vega recorder) is an Electron app: React UI in
`app.asar` + local Flask backend on `127.0.0.1:5328` + `pywinauto` OS recording.
The UI is NOT served over HTTP by the app (Electron loads it from file://).

**To run it in Chrome** (set up 2026-09-30, lives at `C:\Users\dusan\ATR-Web`):
extracted the React UI from app.asar, added `main_window\electron-shim.js` stubbing
`window.electron` (loaded via a `<script>` in index.html — must be a file, CSP blocks
inline), served `renderer` with `python -m http.server 8770`, opened
`http://localhost:8770/main_window/index.html`. Works because the UI uses HTTP `fetch`
to :5328 (CSP already allows it; backend runs flask-cors).

Launcher `launch-atr-web.ps1` + Start Menu shortcut "Agent Trace Recorder (Chrome)".
Full details + update-after-ATR-upgrade steps in `C:\Users\dusan\ATR-Web\README.md`.

Browser limits: native file-picker returns empty, global hotkeys don't fire (use
on-screen buttons), window min/max + updater inert. Desktop app must be running for the
:5328 backend. This is infra help, allowed under the Vega rules — no task content touched.
Related: [[reference-vega-materials]], [[project-vega-workflow]], [[vega-llm-restriction]].
