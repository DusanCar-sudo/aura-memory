---
name: bt-audio-obs-transport-drop
description: "On Dusan's box, OBS recordings suspend the Bluetooth audio transport (default sink) — sound dies until BT reconnect or wireplumber restart"
metadata: 
  node_type: memory
  type: project
  originSessionId: 262359f5-b95d-4dd2-bfc1-f6e5e4194f12
  modified: 2026-09-05T08:02:24.516Z
---

Dusan's default audio output is a Bluetooth headset (`Lenovo Wireless Stereo Headset`, `bluez_output.50:1B:6A:8A:10:F9`). After OBS Studio recording sessions (Vega work, [[vega-llm-restriction]]), the BT transport goes SUSPENDED and all sound dies even though the device shows Connected.

**Why:** OBS grabbing/releasing the BT monitor transport leaves it stuck suspended; PipeWire/WirePlumber don't recover it on their own. Recurred twice in one session (2026-09-04).

**How to apply:** Diagnose with `pactl list sinks short` (look for `SUSPENDED` on the bluez sink). Fix: `bluetoothctl connect 50:1B:6A:8A:10:F9` then a test tone `speaker-test -t wav -c 2 -l 1`; if still dead, `systemctl --user restart wireplumber pipewire pipewire-pulse`. Durable fix: wired output (`wpctl set-default`) during recording takes, and close OBS fully after recordings. Audio stack is PipeWire 1.6.x on KDE/Wayland.
