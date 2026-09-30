---
name: shared-vm-no-pkill-by-name
description: "In the Aura OS test VM (shared with Aura's live session) never pkill/pgrep by process name; scope kills to own PIDs or test runtime dir"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 211d3e42-7320-45e6-a217-e94f5207774b
  modified: 2026-09-12T17:19:00.932Z
---

Never run `pkill -x foot` (or any pkill/killall by name) in the Aura OS VM
(`ssh -p 2222 dusan@localhost`). The VM runs Aura's real sway session at the
same time as my tests; on 2026-09-13 a `pkill -x foot` in a measurement
command killed ~4 foot windows in Aura's session. `pgrep -x NAME` also
silently counts her processes (it inflated a memory measurement to 140 MB).

**Why:** the VM is shared ([[aura-os-project]]); Aura works in it while I
test, and her windows use the same binaries as my tests.

**How to apply:** kill only PIDs I started (`$!`), or processes whose
`/proc/<pid>/environ` has my private `XDG_RUNTIME_DIR` — aura-os-term's
`tools/aura-term-test/hl.sh kill NAME...` does exactly that. Count memory
the same way. Run tests in the private headless sway, never the real one.
