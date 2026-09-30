---
name: auraweb-command
description: "`:auraweb` in the Aura Code REPL (and the `webaura` binary) spawn `aura serve` as a child and open the React web client"
metadata: 
  node_type: memory
  type: project
  originSessionId: fd3d5ff5-ebe7-481e-ba1f-e807453aeb74
  modified: 2026-09-28T11:21:08.074Z
---

In aura-code (github.com/DusanCar-sudo/aura-code, read from `master` 2026-09-28):

- **`:auraweb`** is a REPL command — `src/cli/repl-web-command.ts`. Shipped in **0.17.6 (2026-08-30)**.
  Listed in `:help` under "The web client" and in the command palette (`src/cli/command-palette.ts`,
  category Session). Takes args: `:auraweb --port 8080`. Aliases that all work:
  `:auraweb`, `:webaura`, `:web` and the `/` forms. Prints "Starting the web client…",
  then "Web client ready — <url>" and opens the browser. Run again while it's up and it
  reports/reopens the existing URL instead of racing for the port.
- **`webaura`** is a separate global binary (`package.json` bin → `dist/cli/webaura.js`),
  named so it can't be mistaken for `aura` (which would drop you into the TUI).
  Flags: `--port 8080`, `--no-open` (its own, not forwarded); everything else passes to `aura serve`.
- Both go through `src/cli/web-launcher.ts`, which **spawns `aura serve` as a child** —
  `cli/index.ts` self-executes on import, so importing serve would run the whole CLI twice.
  The URL is scraped out of the child's stdout (`/?token=…`), never reconstructed.
  The child dies with the REPL on purpose, so no orphan port + live session token.
- Server is `src/server/index.ts`. **Default port 7337.** URL is `http://<host>:7337/?token=<token>`;
  the token is new on every start, so `aura url --port 7337 --open` reprints the live one.
  `aura serve --lan` / `--tailscale` expose it to phones over TLS; API-key changes are allowed
  on loopback but refused once it's on a network unless `--allow-api-keys`.
- The client itself is `web/` — React 18 + Vite, WebSocket protocol in `web/src/lib/protocol.ts`,
  hand-written CSS from the CLI diamond palette, 7 locales incl. RTL, Tauri-wrappable.
  `npm run build:web`, `npm run dev:web`. Note `web/README.md` says the dev proxy is
  `:5273 -> :4317` — stale, the server's default is 7337.

**Why:** Dusan asked what `:auraweb` was and no memory had it; this is the CLI-side answer.

**How to apply:** it is NOT the Puter web client ([[aura-chat-puter-project]]) — different thing,
different repo. See [[aura-code-git-topology]] before pushing anything to this repo.
