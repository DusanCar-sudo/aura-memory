---
name: coastline-drive-game
description: "Android open-world driving game project (Southwest Florida style) at ~/Projects/coastline-drive; Unity 6 + URP, Blender 5.2 flatpak pipeline, Redmi 15C perf target"
metadata: 
  node_type: memory
  type: project
  originSessionId: 2ea18896-7fba-4c13-9e62-467d0a97d6d1
  modified: 2026-09-06T09:27:05.926Z
---

Open-world driving/roleplay Android game, working title "Coastline Drive", repo at
`/home/dusan/Projects/coastline-drive` (own git repo, started 2026-09-06).
Reference game: Roblox *Southwest Florida* (user may share a Facebook group for research).

Decisions locked 2026-09-06: Unity 6.3 LTS + URP; milestone 1 = small open map before garage depth;
vehicle art = semi-realistic mid-poly with mandatory LODs. Target device Xiaomi Redmi 15C 4G
(Helio G81 Ultra, Mali-G52 MC2, 720x1600) -> 30 fps locked, budgets in docs/PERFORMANCE_BUDGET.md.

**Why:** the user wants a Roblox-like open world with a coastline house + garage where cars and
e-bikes are tuned (suspension, racing vs drift, paint, decals). User will supply vehicle specs/references
for Blender modelling.

**How to apply:** Unity Hub 3.21.1 + Unity 6000.3.23f1 (Android toolchain) installed at
/run/media/dusan/DATA1/Unity/Hub/Editor/6000.3.23f1 on DATA1 NVMe partition, NOT the SD card
(slow); personal licence activation still needs the user. Blender via flatpak `org.blender.Blender`, which needs absolute paths. Vehicle naming/material conventions live in
docs/BLENDER_PIPELINE.md; scripts in blender/scripts (template, check, export) are verified working.
Next steps: grey-box map per docs/MAP_PLAN.md; user sends vehicle list.
