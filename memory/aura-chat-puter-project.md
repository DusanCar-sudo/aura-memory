---
name: aura-chat-puter-project
description: "Aura on Puter (site chat, shared-memory web client, Droid plan) at /mnt/bigdata/aura-chat; where it stopped 2026-09-18"
metadata: 
  node_type: memory
  type: project
  originSessionId: e4ada8bd-b76c-4255-b296-44ff3cbb25d0
  modified: 2026-09-18T08:56:53.630Z
---

/mnt/bigdata/aura-chat (local git, no remote yet):
- `aura-chat.js` + `aura-kb.js` (from `build-kb.sh`): "[?] ASK AURA" site chat, Puter user-pays,
  square Aura OS popup look. Live on leanproiq.com (see [[leanproiq-deploy]]) and aura-droid.vercel.app
  (old rounded version; redesign committed in the scratch clone but NOT pushed, also aura-pulse-website).
- `docs/SHARED-MEMORY.md`: approved Puter KV memory design (cloud/local split, deny filter incl. Imprint,
  chat summaries sync, public site chat has no memory).
- `web/`: full Aura client (chat + memory), published 2026-09-18 via web/publish.html to
  https://aura-ambitious-key-7005.puter.site — that looks like a Puter TEMP guest account; Dusan must
  "Save account" or republish under a real one.

**Next when resuming:** Dusan's memory test in the web client; check whether Puter KV is per-app
(it decides whether Aura Droid can share memory); then step A = Puter preset in Aura Droid
(OpenAI-compatible endpoint https://api.puter.com/puterai/openai/v1 + Puter auth token); also
the Aura OS installer "free with Puter" option and hosting Aura Droid on Puter's desktop.
Aura's default model on this machine is openrouter/openrouter/auto; ~/.aura.json adds a Puter provider.
