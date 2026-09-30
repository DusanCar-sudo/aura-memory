---
name: api-key-owner-responsibility
description: "Aura OS motto — the API key is the owner's responsibility; per-user only, no extra protection layers beyond sane file permissions"
metadata: 
  node_type: memory
  type: project
  originSessionId: 4f3cc225-c13f-458f-88a0-9f909eac876e
  modified: 2026-09-17T13:15:11.743Z
---

Dusan's rule for Aura OS (2026-09-17): "API key is the responsibility of the owner. This is our motto."

Installer design agreed the same day: during install, optionally ask Base URL + Model ID + API key (generic OpenAI-compatible) so Aura comes preinstalled and can set up the system on first boot; Skip just continues. The key belongs only to the user who entered it — stored in that user's ~/.aura/.env (600), never system-wide, other users added later don't get it and get their own optional Connect Aura step.

**Why:** Aura must be native on Aura OS (Dusan had to install Aura by hand on Aura OS — shouldn't happen), and key security is the owner's job, not the OS's.

**How to apply:** Don't build key encryption, keyrings or admin-proof storage; don't lecture about key safety. Just per-user file, not in logs/ISO/snapshots. Related: [[aura-os-project]]
