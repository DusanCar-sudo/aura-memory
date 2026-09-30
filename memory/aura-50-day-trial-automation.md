---
name: aura-50-day-trial-automation
description: "How the aura-50-day-trial headless runs are wired — one code path, Persistent=true timer trap, the real Archimedes backend"
metadata: 
  node_type: memory
  type: project
  originSessionId: d95458b3-ba10-4e85-afa1-48b3c52bbc7b
  modified: 2026-09-05T06:58:44.323Z
---

The aura-50-day-trial (~/aura-50-day-trial, branch `master`) runs all
benchmarks through ONE code path: `~/.local/bin/aura-trial-run.sh <session>
<tier-list> <label>` — it does RAM preflight (needs ~6.5GB; session 10003 was
OOM-killed 2026-08-28), starts LM Studio + warm-loads the model, and scrubs
secrets via `scripts/scrub_secrets.py` before any commit.

**Why:** session 10002's recorded transcript shipped a live DEEPSEEK_API_KEY
(model ran `cat ~/.aura/telegram.env`) and GitHub blocked the push for 9 days.

**How to apply:**
- The benchmark's real Archimedes backend is LM Studio `ibm/granite-4-h-tiny`
  @ localhost:1234 (per Aura_Benchmark/.aura.json) — the README's claim of
  `gemma-archimedes-gen2` via Ollama is known drift; the gen2 fine-tunes live
  in local Ollama :11434 only.
- `aura-daily-trial.timer` (06:00, Persistent=true) fires IMMEDIATELY on
  `enable --now` if never previously active — it treats all past 06:00 slots
  as missed. Expect an instant (usually preflight-aborted) run when enabling.
- Sessions auto-number max+1 from Aura_Benchmark/results/, so aborted runs
  silently reuse their number.
- After benchmark runs, unload LM Studio models (`lms unload --all`) — the
  7B model eats ~4.2GB of the laptop's 12GB and starves everything else.

Related: [[aura-md-convention]], [[aura-surface-confusion]]

**Status 2026-09-13:** Dusan turned the morning rounds OFF (aura-daily-trial, -a, -b timers disabled) — too heavy on this 12 GB laptop; re-enable on Aura OS only when asked. Aura_Benchmark now lives on bigdata (/mnt/bigdata/Aura_Benchmark), DATA1 path is a symlink.
