---
name: coastline-drive-location
description: Coastline Drive repo actually lives at /mnt/bigdata/coastline-drive (shared between dual boots); ~/Projects/coastline-drive no longer exists
metadata: 
  node_type: memory
  type: project
  originSessionId: 87977263-0fe7-40e4-954e-0521102da998
  modified: 2026-09-16T17:40:21.180Z
---

The [[coastline-drive-game]] repo is at **/mnt/bigdata/coastline-drive** (mounted second
drive, shared between the two dual-boot OSes). There is only ONE game repo —
`/mnt/bigdata/coastline-drive-assets` is a raw asset warehouse (zips/rars, not a repo),
and `~/Pictures/3d` holds duplicate download packs. Don't "sync" them; extract needed
packs into `coastline-drive-assets/incoming` and import via
`tools/import_model_cars.sh` (needs Blender — **installed on this OS half now**, at
/usr/bin/blender, verified 2026-09-21; `unrar` and `7z` are there too for the packs).

Related: [[aura-surface-confusion]], [[coastline-drive-game]]
