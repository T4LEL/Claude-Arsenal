# Sync toolkit agents and skills into ~/.claude so Claude Code picks them up.
# Run from anywhere; re-run after every edit in this repo.
# Validates frontmatter first (a bad name/description breaks discovery silently),
# then clean-replaces the synced copies. Never edit the ~/.claude copies directly.
$ErrorActionPreference = "Stop"
$repo = $PSScriptRoot
$claudeDir = Join-Path $env:USERPROFILE ".claude"

# --- Validate ----------------------------------------------------------------
$targets = @(Get-ChildItem (Join-Path $repo "agents") -Filter *.md | ForEach-Object { $_.FullName })
foreach ($dir in Get-ChildItem (Join-Path $repo "skills") -Directory) {
    $skillMd = Join-Path $dir.FullName "SKILL.md"
    if (Test-Path $skillMd) { $targets += $skillMd }
    else { Write-Output "VALIDATION FAILED: $($dir.FullName) has no SKILL.md"; exit 1 }
}

$problems = @()
foreach ($path in $targets) {
    $text = Get-Content $path -Raw
    if ($text -notmatch '(?s)^---\r?\n(.*?)\r?\n---') { $problems += "$path : missing YAML frontmatter"; continue }
    $fm = $Matches[1]
    if ($fm -notmatch '(?m)^name:\s*\S') { $problems += "$path : frontmatter missing 'name'" }
    if ($fm -notmatch '(?m)^description:\s*(\S.*)$') { $problems += "$path : frontmatter missing 'description'" }
    elseif ($Matches[1].Trim().Length -gt 1024) { $problems += "$path : description over 1024 chars" }
}
if ($problems.Count -gt 0) {
    $problems | ForEach-Object { Write-Output "VALIDATION FAILED: $_" }
    exit 1
}

# --- Deploy ------------------------------------------------------------------
$agentsDst = Join-Path $claudeDir "agents"
$skillsDst = Join-Path $claudeDir "skills"
New-Item -ItemType Directory -Force $agentsDst | Out-Null
New-Item -ItemType Directory -Force $skillsDst | Out-Null

Copy-Item (Join-Path $repo "agents\*.md") $agentsDst -Force

Get-ChildItem (Join-Path $repo "skills") -Directory | ForEach-Object {
    $dst = Join-Path $skillsDst $_.Name
    if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }  # clean replace: no stale files
    Copy-Item $_.FullName $dst -Recurse
}

# Bundle templates into the deployed new-project skill so it is self-contained
# on any machine (the repo stays the source of truth for editing).
Copy-Item (Join-Path $repo "templates") (Join-Path $skillsDst "new-project\templates") -Recurse

$agentCount = (Get-ChildItem (Join-Path $repo "agents") -Filter *.md).Count
$skillCount = (Get-ChildItem (Join-Path $repo "skills") -Directory).Count
Write-Output "Validated and synced $agentCount agents and $skillCount skills (templates bundled into new-project) to $claudeDir"
Write-Output "Restart Claude Code (or start a new session) to pick up changes."
