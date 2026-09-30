---
name: aura-desktop-tauri
description: Goal behind :auraweb — a standalone Rust/Tauri desktop app for Linux and Windows; src-tauri exists but nothing builds or ships it
metadata: 
  node_type: memory
  type: project
  originSessionId: fd3d5ff5-ebe7-481e-ba1f-e807453aeb74
  modified: 2026-09-28T12:11:12.141Z
---

**Dusan's stated goal (2026-09-28): `:auraweb` exists as the stepping stone to a standalone
Rust desktop app for Linux and Windows.** The web client is the UI; Tauri is the shell.

State of `src-tauri/` in aura-code master as of 2026-09-28:
- Tauri **v2**, crate `aura-code-app`, product "Aura Code", id `com.auracode.desktop`.
- `src/pty.rs` — a real native terminal via `portable-pty` (spawn/write/resize/kill), so the
  integrated terminal is Rust, not a round-trip through the server.
- `src/main.rs` `get_auth_token` — reads `AURA_SERVER_TOKEN`/`AURA_TOKEN`, then
  `~/.aura/active_token` (written by `aura serve` for exactly this), then `server-token`.
  So the desktop app pairs itself; no pasting `?token=`.
- Frontend is the same `web/` React bundle (`frontendDist: ../dist/web`).

**Nothing builds it.** Zero references to tauri in `.github/workflows/`. `packaging/`
(deb, rpm, Inno Setup `aura.iss`) all package the **Node CLI**, not the Rust app —
`release-windows.yml` bundles a Node runtime and ships `aura.cmd`. Classic
"built but never deployed".

Blockers found for a real Linux+Windows bundle:
1. `src-tauri/icons/icon.ico` and `icon.icns` are **0 bytes** — with `bundle.targets: "all"`
   the Windows bundle cannot succeed. Hard blocker.
2. The three PNG icons are the identical 86,351-byte file; 32x32 is not actually 32x32.
3. `devUrl` is `http://localhost:5173` but `web/vite.config.ts` serves on **5273** —
   `tauri dev` would open a blank window.
4. Version skew: tauri.conf.json and Cargo.toml say 0.17.0, package.json is 0.18.0.
5. `app.security.csp` is `null`, on a window that renders model markdown.
6. `src-tauri/target/` is committed — 3,399 artifact files, most of the repo's ~240 MB.

**How to apply:** the fix is icons + devUrl + a workflow that runs `tauri build` on
ubuntu-latest and windows-latest and attaches .deb/.AppImage/.msi to the release.
Do it in a worktree off `dusancar/master` — see [[aura-code-git-topology]].
See [[auraweb-command.md]] for the command itself.
