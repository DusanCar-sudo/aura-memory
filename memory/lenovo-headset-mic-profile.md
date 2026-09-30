---
name: lenovo-headset-mic-profile
description: Lenovo BT headset mic only works in HFP profile; in A2DP Aura hears the room via laptop mic
metadata: 
  node_type: memory
  type: project
  originSessionId: 0ac5ffe3-83db-403b-bb9d-ffcfaf88b347
  modified: 2026-09-22T09:27:35.162Z
---

Lenovo Wireless Stereo Headset (bluez_card.50_1B_6A_8A_10_F9) in a2dp-sink profile has 0 sources, so voice input falls back to the laptop's built-in `Mic1` and picks up the room (Dusan's mother) instead. Cost of the fix: playback drops to 16 kHz mono call quality.

**Durable fix (2026-09-22, verified):** pin the source — `printf 'bluez_input.50:1B:6A:8A:10:F9\n' > ~/.config/aura-mic/source`. `aura-mic`'s `pick_source` returns that immediately, the capture stream then pulls the card to `headset-head-unit` on its own.

**Do NOT rely on `pactl set-card-profile ... headset-head-unit` alone** — wireplumber flips it back to `a2dp-sink` within a second whenever nothing is capturing from the BT input. There is a chicken-and-egg: `pick_source` only accepts `bluez_input` if the profile is *already* headset/hfp/hsp (else it deliberately falls back to `Mic1`), and wireplumber only moves to HFP once something is capturing from BT. Neither side ever starts. The source file breaks the loop.

**Why:** Dusan asked "switch aura mic to lenovo mic" = the headset; the laptop is also Lenovo, so don't pick the built-in mic. He later confirmed the headset mic "works really good" after the pin.
**How to apply:** If Aura hears background voices, check `~/.config/aura-mic/source` and the card's Active Profile. Also: `aura-mic stop` transcribes and *types into the focused window* — kill `pw-record` directly if you need to switch sources without emitting text. Related: [[bt-audio-obs-transport-drop]]
