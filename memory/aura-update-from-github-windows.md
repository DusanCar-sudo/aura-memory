---
name: aura-update-from-github-windows
description: How to update the aura (aura-code) CLI from GitHub instead of npm on Windows
metadata: 
  node_type: memory
  type: project
  originSessionId: dbeb4b4a-167b-4ec6-a1fb-cce437f8d482
  modified: 2026-09-30T06:59:31.474Z
---

On Windows, `aura` = the global npm package **aura-code** (bin at
`C:\Users\dusan\AppData\Roaming\npm\aura.ps1`; repo
`github.com/DusanCar-sudo/aura-code`; a diverged local clone lives at
`C:\Users\dusan\OneDrive\Documents\aura-code`).

**To update from GitHub, not npm** (done 2026-09-30):
1. `git` is installed but not on PATH — use `C:\Program Files\Git\cmd\git.exe`.
2. Fresh-clone the repo (`--depth 1`), `npm install`, `npm run build`, then **`npm pack`**
   and `npm install -g <the .tgz>`. Build = `tsc && vite build` (+postbuild copies assets).
3. **Why not `npm i -g git+https://...`:** package.json has NO `prepare` script and `dist/`
   isn't committed, so a direct git install ships unbuilt source and the `aura` bin
   (`dist/cli/index.js`) is missing → broken. Must build first.
4. **Why pack, not `npm install -g .`:** installing the folder directly makes npm LINK the
   global package to that folder — deleting the temp build dir then wipes global `dist/`
   ("Cannot find module dist/cli/index.js"). `npm pack` + install the tarball = real copy.
   node-pty ships prebuilds (incl. win32-x64) so its blocked install-script warning is fine.

Automated: `aura-update` (PowerShell profile function → `C:\Users\dusan\Scripts\update-aura-from-github.ps1`).
Needs ExecutionPolicy CurrentUser = RemoteSigned (set 2026-09-30) or .ps1 shims/profile won't run.

Note: GitHub HEAD was **behind** npm at the time (0.18.0 vs published 0.19.1) — installing
from GitHub lowers the version string even though it's the source of truth Dusan wants.
Clone with `GIT_LFS_SKIP_SMUDGE=1`; build didn't need the LFS blobs.
Related: [[aura-code-git-topology]], [[aura-code-git]] (auramemory), [[github-warehouse]].
