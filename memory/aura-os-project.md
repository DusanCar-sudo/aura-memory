---
name: aura-os-project
description: Aura OS (own OS on Arch+sway, built by Aura) at DATA1/aura-os is a double project — also the testbed for tuning Aura herself
metadata: 
  node_type: memory
  type: project
  originSessionId: 24adb4fe-a616-4025-b99b-b746faabd299
  modified: 2026-09-15T06:11:32.270Z
---

Aura OS repo now lives at `/mnt/data/aura-os` on the real install
(old `/run/media/dusan/DATA1/aura-os` path is gone since the 2026-09-14
bare-metal install). 2026-09-15: AURA.md rewritten with
ownership/identity + modules-and-debugging stance (1997/2000 chars).
pushed to PRIVATE github.com/DusanCar-sudo/aura-os (main). Before any
public release: tasks/ref/herdr.png is deleted but still in old history (rewrite needs force-push),
consider noreply email. Aura OS is PROPRIETARY (not MIT — Dusan said so)
and ships to users ONLY as a downloadable ISO; LICENSE +
THIRD-PARTY-NOTICES.md hold the GPL-source / foot-MIT obligations.
Idea (Dusan's words): "finally your own OS on your own laptop, running what
you need", "following instincts and trends". herdr/Omarchy were only used
to explain — keep both names OUT
of the repo. Arch + **sway** (Dusan chose sway over Hyprland), look: square corners,
tabs 1-5 renamable + per-tab color (tab only), spaces/agents sidebar,
<350 MB idle, must still run all his apps/games/multimedia.

**Why:** Dusan explicitly wants this as a double project — Claude writes
task briefs, Aura builds them, Claude watches how she works and turns
her stumbles into aura-code fixes.

**How to apply:**
- Loop is in METHOD.md: brief → Aura runs → `tools/aura-trace.py`
  → verify in VM myself → NOTES-aura-behaviour.md (tag brief/rules/aura)
  → fix → re-run same brief from snapshot.
- VM: `vm/run-vm.sh` (QEMU, no GL so `vm/vm-keys.py shot` works),
  ssh `-i ~/.ssh/aura_vm_ed25519 -p 2222 dusan@localhost`, NOPASSWD sudo
  in guest only. Ctrl+Alt+Q quits QEMU (Dusan hit it by accident).
  On this host (2026-09-15) qemu has NO gtk display and NO virtio-vga:
  run headless instead — `qemu-system-x86_64 ... -display none -device VGA`
  from vm/ (monitor.sock still works for vm-keys.py). vm-keys combos need
  QEMU key names: super is `meta_l-...` (NOT `super-`). Guest key
  re-authorized 2026-09-15 (typed via vm-keys into aura-term).
- Aura doesn't commit her own work (Dusan's rule); AURA.md near its
  2000-char cap — put new detail in task briefs.
- Real install (2026-09-13): was DUAL BOOT with Ubuntu 26.04. OBSOLETE since 2026-09-24:
  Kubuntu deleted, aura moving to new p6 — see [[disk-migration-2026-09-24]]. Aura goes in space cut from DATA1 (p3 → 190G):
  p8 1G XBOOTLDR /boot, p9 btrfs root; shared ESP p1 at /efi; systemd-boot
  menu lists Aura OS (default) + Ubuntu. p7 (/mnt/oldlinux) is really Kubuntu 26.04 (dracut initramfs, Plymouth). Its splash was switched to the aura-ados theme on 2026-09-24 at Dusan's request ([[aura-retro-design]]). PARTITIONED 2026-09-13 from Ubuntu:
  p3 DATA1 = 190G (fs 185G, UUID bb19ce2a… unchanged), p8 AURABOOT vfat
  XBOOTLDR 1G, p9 btrfs label "aura" UUID f8fe5ec6-7279-4b8d-b2fe-8161ab934e2a.
  Next = boot the Arch stick (sdb), checklist from step 14. Phone checklist artifact:
  claude.ai/code/artifact/0d3ba7db-ecd4-4385-9346-91593f6bd7ea
- Both memories live on bigdata p5 (never touched by the install):
  /mnt/bigdata/moved-from-system/home-dusan/{.claude/projects/-home-dusan/memory,.aura/memory}.
  Aura OS symlinks them (checklist step 26), so both OSes share one live memory.
  .env/keys are NOT linked — Dusan copies those by hand.
- Task order: 001 ✓ → 001b (sway+budget) → 003 desktop UI → 004 daily
  driver → 002 voice.

Related: [[aura-md-convention]], [[aura-surface-confusion]]

- 2026-09-13 ~22:15: Aura adOS installer ISO (build 3, d53ac2fe) written to the stick (sdb) and verified; Dusan rebooting to install for real. First boot copies aura-os from DATA1 and runs install/0*.sh; log /var/log/aura-os-firstboot.log. QEMU test: installer passes; first-boot 03/06 bugs fixed in d53ac2fe (not yet re-verified).

- 2026-09-13 23:00 first real try: stick booted, tiles came up, but amdgpu DMCUB error flood (linux-firmware-amdgpu 20260910-1 regression on Radeon 680M) buried the screen; Dusan gave up, nothing installed. Fix in 378d64d9: installer pins firmware 20260810-2 (IgnorePkg) + dmesg -n 1 + loglevel=3. Remove IgnorePkg once Arch ships fixed firmware. Ubuntu 7.0 kernel/firmware is unaffected.
- 2026-09-13 23:38 second stick try: DMCUB flood again (the live ISO boots its OWN firmware, so the IgnorePkg pin can't fix the live env); pv bar ran underneath but p9 still empty (16K). Earlier the same night Ubuntu hit global OOM (QEMU VM + Chrome + docker on 12 GB) and killed kwin. Proposed pivot: install Aura from running Ubuntu (arch bootstrap tarball → pacstrap into p9, git-clone configs, loader entry), no live stick. Dusan agreed → tools/install-from-ubuntu.sh (commit 9c87fad7, not pushed, not yet run); log /var/log/aura-install-from-ubuntu.log; bootstrap kept in /var/tmp/aura-bootstrap.
- 2026-09-14 00:45 install RAN OK (07 deferred: no uinput in chroot). Reboot went straight to Ubuntu: no NVRAM entry for systemd-boot (files fine on ESP/p8). Fix = efibootmgr --create "Aura OS" \EFI\systemd\systemd-bootx64.efi (script patched 26a6cd10). Ubuntu shim updates may push Ubuntu back first in BootOrder.
- **2026-09-24: root and the staged reset.**
  - The root btrfs UUID is eba3d0ec-f6e4-4a0a-b3b1-549563815893. It runs from subvolid 256 (`@`).
  - fstab and the UKI cmdline no longer pin `subvol=`, so boot follows the btrfs default subvolume.
  - Dusan ran `aura-os-reset 188/187/194` on 2026-09-22 at 20:23–20:24. Checked with sudo on 2026-09-24: `btrfs subvolume get-default /` = ID 256 (`@`), so **no reset is staged** and root changes persist across reboot.
  - Re-check if in doubt: `sudo btrfs subvolume get-default /`. Undo a staged one: `set-default 256 /`.
  - The UKI's vfat mtime is not meaningful: it says Sep 11 even though pacman rebuilt it on Sep 23. Read the image's `.uname` section instead.
- 2026-09-14 01:15 Aura OS BOOTS and works on the laptop. First boot had no DNS yet → snapper not installed (run 02-snapper by hand). Copied Ubuntu ~/.aura keys (25, merged; kept Aura's own XIAOMI) + .env/secrets/google_token/email.json into Aura. Commit e49b766d: key step in both installers, firstboot waits for DNS. From Ubuntu the Aura system journal is root-only; firstboot log + pacman.log are readable in @log.
