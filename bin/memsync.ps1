# memsync — pull every agent's memory into one shared store, then sync it with GitHub.
# Windows half. Safe to run as often as you like.
$ErrorActionPreference = 'Stop'
$Hub = Split-Path -Parent $PSScriptRoot
$Mem = Join-Path $Hub 'memory'
$Aura = Join-Path $env:USERPROFILE '.aura\memory'
$Agents = Join-Path $env:USERPROFILE '.codex\AGENTS.md'
$Git = if (Test-Path 'C:\Program Files\Git\bin\git.exe') { 'C:\Program Files\Git\bin\git.exe' } else { 'git' }

function Say($m) { if (-not $env:MEMSYNC_QUIET) { Write-Host "memsync: $m" } }

Set-Location $Hub

# 1. fold Aura's own memory in, push the whole store back out to Aura + Codex
node (Join-Path $PSScriptRoot 'aura-bridge.mjs') $Mem $Aura $Agents | ForEach-Object { Say $_ }

# 2. commit anything new locally
& $Git add -A 2>&1 | Out-Null
if (& $Git status --porcelain) {
  & $Git commit -q -m "memory: sync from windows $(Get-Date -Format 'yyyy-MM-dd HH:mm')" 2>&1 | Out-Null
  Say 'committed local changes'
}

# 3. exchange with GitHub (union merge — never blocks on a conflict)
$hasRemote = (& $Git remote) -contains 'origin'
if ($hasRemote) {
  & $Git fetch -q origin 2>&1 | Out-Null
  $remoteHas = & $Git ls-remote --heads origin main
  if ($remoteHas) {
    & $Git merge -q --no-edit -X union origin/main 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { & $Git merge --abort 2>&1 | Out-Null; Say 'merge skipped (manual check needed)' }
  }
  & $Git push -q -u origin main 2>&1 | Out-Null
  if ($LASTEXITCODE -eq 0) { Say 'synced with github' } else { Say 'push failed (offline?) — local store is still correct' }
}

# 4. re-run the bridge so anything that arrived from the other machine reaches Aura + Codex
node (Join-Path $PSScriptRoot 'aura-bridge.mjs') $Mem $Aura $Agents | Out-Null
Say 'done'
