---
name: adosaura-launcher
description: "adosaura = Dusan's Aura-OS-styled Android launcher at \"/home/dusan/android launcher adosaura\" for Redmi Note 12 Pro 4G"
metadata:
  node_type: memory
  type: project
  originSessionId: cc274643-c8ba-470c-9bd7-3524d79bf7e6
  modified: 2026-09-23T16:14:57.230Z
---

adosaura is an Android home-screen launcher (Kotlin/Compose, package dev.aura.adosaura) that mimics Aura OS: text-only tiles, monospace, themes copied from Aura OS. Path has spaces: `/home/dusan/android launcher adosaura`. Git repo (branch main), public at github.com/DusanCar-sudo/adosaura since 2026-09-23 (origin); old patch scripts moved to gitignored archive/.

Target phone: Redmi Note 12 Pro 4G (sweet, HyperOS 1.0 / Android 13), adb serial 147e73080013. Toolchain: `source ~/android-toolchain/env.sh`; deploy via `scripts/deploy.sh`. docs/RESUME.md is the handoff doc. Config lives on phone in /sdcard/adosaura/ (apps.conf, layout.conf).

**Why:** an earlier agent session left ~70 one-off patch_*.py scripts (now in archive/); they are not part of the build.
HyperOS blocks `pm grant` and `input keyevent` over adb unless "USB debugging (Security settings)" is on — runtime permissions (e.g. location) must be granted on the phone.

As of 2026-09-23 23:25 the phone runs 6b88adc: glow frames, edge swipes, and the install-label fix. Enabling the edge accessibility service over adb is refused (WRITE_SECURE_SETTINGS is blocked by the Security-settings toggle), so Dusan switched it on by hand (done 2026-09-23, service bound, both strips up). Pushed through 6b88adc (visible accent line on the strips).

**How to apply:** read docs/RESUME.md first; edit Kotlin directly rather than adding more patch scripts. Related: [[aura-os-project]], [[github-warehouse]].
