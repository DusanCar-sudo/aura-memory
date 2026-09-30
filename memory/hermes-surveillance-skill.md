---
name: hermes-surveillance-skill
description: "Hermes surveillance skill — webcam to Telegram every N min, controlled by surstart/surstop"
metadata: 
  node_type: memory
  type: project
  originSessionId: 8ec0e1ff-18e9-489f-b6fb-852cfad953a5
  modified: 2026-09-29T08:52:23.142Z
---

Built 2026-09-29. Hermes skill at
`C:\Users\dusan\AppData\Local\hermes\skills\surveillance\` that captures the
Integrated Camera and sends the photo to Dusan's Telegram bot **@Herme_duxbot**
(chat 8519031951) on an interval.

- Engine: `scripts\surveil.py` (subcommands: once / start --interval N / stop / status / _loop).
- Words **surstart** (default 10 min), **surstop**; also `surstart.cmd` / `surstop.cmd`
  and Start Menu "Surveillance Start/Stop" shortcuts.
- Loop runs detached via `C:\Python314\pythonw.exe`; PID + state under
  `HERMES_HOME\surveillance\`. Camera released between shots. Captures pruned after 7 days.
- Webcam via `opencv-python-headless` (cv2 5.0.0) in `C:\Python314`; DSHOW backend works.
- Telegram token read at runtime from `HERMES_HOME\.env` (TELEGRAM_BOT_TOKEN +
  TELEGRAM_HOME_CHANNEL) — never hardcoded in the skill.

**Why:** home monitoring on his own machine/camera/bot. Verified end to end
(once, start, status, stop all confirmed; photos delivered).

**How to apply:** to change cadence, `surstart <minutes>`. Related:
[[google-account-roles]], [[hermes-python-ownership-fix]]. Uses HERMES_HOME =
`C:\Users\dusan\AppData\Local\hermes`, not ~/.hermes.
