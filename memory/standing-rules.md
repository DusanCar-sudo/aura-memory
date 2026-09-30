---
name: standing-rules
description: Key standing rules: (1) AURA.md is the house agent-rules file (root-only, silently truncated at 2000 chars, prose not tables). (2) solution-md-rule: after solvi
metadata:
  type: project
---

Key standing rules: (1) AURA.md is the house agent-rules file (root-only, silently truncated at 2000 chars, prose not tables). (2) solution-md-rule: after solving any nontrivial problem write /mnt/bigdata/solutions/YYYY-MM-DD-short-slug.md with Problem/Root cause/Fix/Verified. (3) app-list-rule: every new Aura OS app gets a .desktop entry in ~/.local/share/applications/ + repo copy, always. (4) no-wtype-on-live-session: never inject synthetic keys into Dusan's live sway session; test TUIs in a pty harness. (5) shared-vm-no-pkill-by-name: in the Aura OS test VM never pkill/pgrep by name; scope to own PIDs. (6) vm-screenshot-privacy: pause screenshots when Dusan is on sign-in/account pages. (7) full-autonomy: act, don't hand back commands. (8) api-key-owner-responsibility: key is owner's responsibility, per-user ~/.aura/.env (600), no encryption layers. (9) aura-os-repo-topology: /mnt/bigdata/aura-os-work is canonical for GitHub; /mnt/data/aura-os is a divergent mirror, never push from it. (10) auramemory-mirror: C:\AuraMemory\memory mirrors the Claude memory dir; refresh wholesale when memories change.
