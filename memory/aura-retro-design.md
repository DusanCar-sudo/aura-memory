---
name: aura-retro-design
description: "Aura Code \"∞K\" retro identity (ZX Spectrum + synthwave, Blender renders) at ~/Projects/aura-retro-design; live on leanproiq.com (+ /ados), CLI banner, aura-term, READMEs, adOS boot splash"
metadata:
  node_type: memory
  type: project
  originSessionId: f810a800-23eb-4081-8743-603f808cdcf6
  modified: 2026-09-23T16:32:35.375Z
---

Aura Code retro-edition identity, built 2026-09-23 at `~/Projects/aura-retro-design/` (private GitHub repo DusanCar-sudo/aura-retro-design, branch main). DESIGN.md has a "Where it is used" table; read it first. Preview: https://claude.ai/artifact/94EwtJihhCHhFSdZuvwskF.

**Rolled out 2026-09-24** (all pushed):
- leanproiq.com homepage, via `site/build.py --home` ([[leanproiq-deploy]]).
- Aura Code CLI banner: `src/cli/diamond.ts`, f9260e5 on GitHub master; the installed /usr/lib/node_modules/aura-code has the swapped diamond.js.
- The aura-code README (lockup) and the aura-os README (the mark without CODE, on the `menus` branch).
- aura-term banner (`bin/aura-os-logo`); Ask Aura stripes (`term/aura-term-ask.c`).
- Solution notes: /mnt/bigdata/solutions/2026-09-2{3,4}-*retro*.md.

**Aura adOS (2026-09-24):**
- The adOS lockup: `glyphs.ados_lockup()`, `brand/aura-ados-lockup-*.svg`.
- The boot splash: `brand/make_splash.py` renders `renders/ados-splash.png`, 1280x720 with pure-black edges. It is copied to aura-os `assets/splash/aura-splash.png` (8579c174), and `install/08-boot.sh` bakes it into the UKI.
- The landing page at leanproiq.com/ados: `site/ados.src.html` + `build.py --ados DIR`.
- The homepage nav links to /ados.
- The Kubuntu boot splash (Plymouth): `brand/make_plymouth.py` + `brand/install-plymouth-ubuntu.sh` (937fc17). Installed on the laptop's Kubuntu (p7, /mnt/oldlinux): Lenovo BGRT logo + the breathing adOS lockup in place of kubuntu-logo. Initrd backups are in its /boot/pre-aura-ados/.
- Kubuntu is deleted now. Since 2026-09-24 Aura OS itself boots with that Plymouth theme
  (Lenovo BGRT + breathing adOS), and the UKI stub splash is removed. Old UKI:
  /boot/EFI/aura/pre-lenovo-splash.efi. The aura-os repo 08-boot.sh still bakes the stub splash.
  Write-up: /mnt/bigdata/solutions/2026-09-24-aura-os-lenovo-plymouth-splash.md

**Gotcha:** the terminal pixel mark is hand-kept twice, in `aura-os-logo` `mark=()` and `diamond.ts` `MARK_PIXELS`. Change both. The local aura-code learning-journey and the other session's theme refactor still have the old diamond.ts, so the merge will conflict there.

**Why:** Dusan asked for a fresh "Sinclair type" retro design, liked the logo, and then had it rolled out everywhere ("comit to leanproiq.com and other").

**How to apply:** geometry and colour live in `brand/glyphs.py`. Re-run `brand/make_svg.py`, then copy the SVGs into the repos' `assets/brand/`. Page source: `site/page.src.html` + `build.py` ([[aura-surface-confusion]]).
