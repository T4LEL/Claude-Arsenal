# Sync toolkit agents and skills into ~/.claude so Claude Code picks them up.
# Run from anywhere; re-run after every edit in this repo.
$ErrorActionPreference = "Stop"
$repo = $PSScriptRoot
$claudeDir = Join-Path $env:USERPROFILE ".claude"

$agentsDst = Join-Path $claudeDir "agents"
$skillsDst = Join-Path $claudeDir "skills"
New-Item -ItemType Directory -Force $agentsDst | Out-Null
New-Item -ItemType Directory -Force $skillsDst | Out-Null

Copy-Item (Join-Path $repo "agents\*.md") $agentsDst -Force
Get-ChildItem (Join-Path $repo "skills") -Directory | ForEach-Object {
    Copy-Item $_.FullName $skillsDst -Recurse -Force
}

$agentCount = (Get-ChildItem (Join-Path $repo "agents") -Filter *.md).Count
$skillCount = (Get-ChildItem (Join-Path $repo "skills") -Directory).Count
Write-Output "Synced $agentCount agents and $skillCount skills to $claudeDir"
Write-Output "Restart Claude Code (or start a new session) to pick up changes."
