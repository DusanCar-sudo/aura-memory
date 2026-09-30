---
name: disk-migration-2026-09-24
description: Kubuntu deleted 2026-09-24; aura btrfs root moving from p9 to new p6 (149.4G) via btrfs replace; Windows 11 goes in the freed ~102G
metadata:
  type: project
---

2026-09-24: Dusan had Kubuntu (old p6+p7) deleted to make room for Windows 11.
His idea: move aura into that space, Windows takes aura's old slot.

UPDATE 13:15: p9 + p4 DELETED with Dusan's OK (GPT backup: /mnt/bigdata/ubuntu-root-backup/gpt-nvme0n1-2026-09-24-before-windows.sfdisk).
p3 DATA retyped to Linux filesystem so Windows ignores it. 102G free for Windows.
Dusan: Windows is only for ONE project; Aura stays the main system and the default boot.
After Windows installs: efibootmgr -o puts 0003 (Aura/systemd-boot) first.

UPDATE 12:40: rebooted, replace DONE (0 errs), resized to 149.4G, scrub clean;
aura now on p6. Old p9 btrfs superblock wiped. Waiting for Dusan's OK to delete p9 + p4
and to retype p3 (ext4 DATA marked Microsoft basic data → Windows offers to format it).

State at 11:50 (+07):
- DONE: Kubuntu + old Fedora /boot backed up to /mnt/bigdata/ubuntu-root-backup
  (home in /mnt/bigdata/ubuntu-home-backup). The aura-ados Plymouth splash + initrds
  are in /mnt/bigdata/aura-ados-splash-from-kubuntu. ESP copy is in ubuntu-root-backup/esp-2026-09-24.
  Fedora/Ubuntu ESP dirs, NVRAM entries and ubuntu.conf are removed; fstab lines are dropped
  (/etc/fstab.pre-kubuntu-removal).
- On-disk GPT: new p6 "aura-root" 1687083008s–2000408575s (149.4G). The kernel
  could not drop old p7: a detached ext4 superblock stayed alive with no visible
  holder. A REBOOT IS NEEDED before using p6. Do not write to that region before
  the reboot: the zombie ext4 could write into it.
- NEXT after reboot: wipefs -a /dev/nvme0n1p6 → btrfs replace start -f
  /dev/nvme0n1p9 /dev/nvme0n1p6 / → btrfs fi resize 1:max / → delete p9 + p4
  → ~102G unallocated for Windows. fsid eba3d0ec… is unchanged, so fstab/UKI need no edits.
- Plan/checklist: /mnt/bigdata/solutions/2026-09-24-ubuntu-out-windows-in.md

**Why:** The old aura-os-project note "keep Ubuntu (p6/p7) untouched" is obsolete now.
**How to apply:** check `lsblk` first. If p9 is gone and p6 is btrfs "aura", the move is done.
Related: [[aura-os-project]]

UPDATE 13:56: install checklist published at https://claude.ai/artifact/86MwdqdLQBcoHew5KtS3yT (copy at /mnt/bigdata/solutions/2026-09-24-windows-install-checklist.html). The current GPT is saved as ubuntu-root-backup/gpt-nvme0n1-2026-09-24-ready-for-windows.sfdisk. The older before-windows.sfdisk still has p4 and p9, so never restore it whole.
On "windows done":
- `efibootmgr -o` with 0003 Aura OS first.
- ESP \EFI\Boot\bootx64.efi is systemd-boot now. Windows Setup probably overwrites it, so check and restore it with `bootctl install --no-variables` or a copy.
- Confirm systemd-boot lists Windows Boot Manager.
