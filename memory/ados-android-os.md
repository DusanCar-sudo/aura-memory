---
name: ados-android-os
description: "Aura adOS (Agent Driven OS) for Android on Redmi Note 12 Pro 4G: crDroid 12 sweet2 + NikGApps + KernelSU module; unlock in progress since 2026-09-23"
metadata:
  node_type: memory
  type: project
  originSessionId: cc274643-c8ba-470c-9bd7-3524d79bf7e6
  modified: 2026-09-23T15:37:03.718Z
---

On 2026-09-23 Dusan named the Android OS **"Aura adOS"** (Aura Agent Driven Operating System), the sibling of the desktop Aura adOS. He said: go ahead and unlock, **keep Google Play** (GApps, not microG), and find ways to integrate Aura.

**Project home:** /mnt/bigdata/aura-ados-android/.
- README.md holds the plan, the runbook with D/A owners, the pre-wipe checklist and the Aura integration tiers.
- flash/fetch.sh downloads and verifies the ROM, GApps and recovery.

**Phone:**
- `sweet_k6a_eea_global`; crDroid calls it `sweet2`.
- Firmware V816.0.37.0.THGEUXM, the newest EEA build, so no firmware flash is needed.
- Timezone Asia/Ho_Chi_Minh.
- NXP NFC.

**Base:** official crDroid 12.12 sweet2 (Android 16), NikGApps crdroid-official A16, the crDroid recovery.img, and KernelSU in the kernel. Known problems:
- 1080p60/YouTube frame drops
- GCam video recording
- NFC may be greyed out
- Erste bank and Wallet need Play Integrity.

**Unlock:**
- Xiaomi Community app, Global region, apply at 00:00 Beijing (23:00 VN).
- Then Mi Unlock status on mobile data.
- 72h wait, sometimes 168h.
- Then `miunlock` (installed via uv) in fastboot. Dusan logs in himself; never store his password.

**Backup (complete, 22 GB, verified against the phone):** /mnt/bigdata/phone-backup/redmi-note12pro-2026-09-23/ holds sdcard/, APKs, props, settings and package lists. SMS/contacts export and `run-as` of app data were denied by the permission classifier, so Dusan does those himself.

**Checklist page:** https://claude.ai/artifact/R3rWYofeseQJGRxZDbQS5q (private).
- Dusan's ticks are in db `checks/<id>` as {done, at}; the `apply` tick starts the 72h clock.
- Claude's steps are in `agent/status` ({backup, miunlock, files, rom, flash, module} → {state: done|running|later, note}); only the owner can write it.
- Read `checks` with ArtifactData before any unlock or flash, and update `agent/status` as steps finish.

**How to apply:**
- Never run the unlock or flash before Dusan confirms the in-app backups (authenticators, Keet phrase, chats).
- The unlock wipes the phone.
- Remove the Google account before unlocking (FRP).

Related: [[adosaura-launcher]], [[aura-os-project]], [[api-key-owner-responsibility]].
