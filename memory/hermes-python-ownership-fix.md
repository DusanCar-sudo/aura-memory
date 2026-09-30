---
name: hermes-python-ownership-fix
description: "Hermes's bundled python threw \"Permission denied\" because four files were owned by another principal; fixed 2026-09-29 with takeown+icacls"
metadata: 
  node_type: memory
  type: project
  originSessionId: 8ec0e1ff-18e9-489f-b6fb-852cfad953a5
  modified: 2026-09-29T07:43:38.888Z
---

Hermes (`C:\Users\dusan\AppData\Local\hermes`) could not run Python at all — its shell
resolved `python` to `tools\cua-driver-0.21.0-win32-x64\python` and got `Permission denied`.
Cause: that folder's ACL grants only SYSTEM, Administrators and `OWNER RIGHTS` — no ACE for
dusan — and `python.exe`, `python3.exe`, `python3.14.exe`, `python314.dll` were owned by a
different principal, so dusan had zero rights (couldn't even read their ACL).

Fixed 2026-09-29 by elevated `takeown /r` + `icacls /grant "dusan:(OI)(CI)F" /T` over the
whole hermes tree (242,784 files). Full write-up: `C:\Users\dusan\hermes-python-permission-denied-fix.md`.

**Why:** if Hermes updates or reinstalls its tools, the same ownership drift can return and
will look like "python is broken" again.

**How to apply:** don't believe "the interpreter is broken" — check `cmd /c dir /q` for the
owner first. Note `icacls /T` at this scale takes ~7 min and makes folders transiently report
*Access denied* / *File Not Found* mid-run; wait for "Successfully processed" before judging.
Real fallback interpreter on this box is `C:\Python314\python.exe`. Google Workspace skill
still needs its own OAuth client_secret.json — see [[reference_vega_materials]] style notes
in the write-up.
