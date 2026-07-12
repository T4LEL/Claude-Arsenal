# Sync toolkit agents and skills into ~/.claude so Claude Code picks them up.
# Run from anywhere; re-run after every edit in this repo.
# Validates frontmatter first (a bad name/description breaks discovery silently),
# then clean-replaces the synced copies and warns about installed-only leftovers
# it never deletes. Never edit the ~/.claude copies directly.
$ErrorActionPreference = "Stop"
$repo = $PSScriptRoot
$claudeDir = Join-Path $env:USERPROFILE ".claude"

# --- Validate ----------------------------------------------------------------
$targets = @(Get-ChildItem (Join-Path $repo "agents") -Filter *.md | ForEach-Object { @{ Path = $_.FullName; Expected = $_.BaseName; Kind = "agent" } })
foreach ($dir in Get-ChildItem (Join-Path $repo "skills") -Directory) {
    $skillMd = Join-Path $dir.FullName "SKILL.md"
    if (Test-Path $skillMd) { $targets += @{ Path = $skillMd; Expected = $dir.Name; Kind = "skill" } }
    else { Write-Output "VALIDATION FAILED: $($dir.FullName) has no SKILL.md"; exit 1 }
}

$problems = @()
$seenNames = @{}
foreach ($t in $targets) {
    $path = $t.Path
    $text = Get-Content $path -Raw
    if ($text -notmatch '(?s)^---\r?\n(.*?)\r?\n---') { $problems += "$path : missing YAML frontmatter"; continue }
    $fm = $Matches[1]
    if ($fm -notmatch '(?m)^name:\s*(\S.*)$') { $problems += "$path : frontmatter missing 'name'" }
    else {
        $name = $Matches[1].Trim()
        if ($name -ne $t.Expected) { $problems += "$path : name '$name' must match $($t.Kind) file/folder name '$($t.Expected)' - discovery breaks otherwise" }
        $key = "$($t.Kind)/$name"
        if ($seenNames.ContainsKey($key)) { $problems += "$path : duplicate $($t.Kind) name '$name' (also in $($seenNames[$key]))" }
        else { $seenNames[$key] = $path }
    }
    if ($fm -match '(?m)^description:\s*[>|]') { $problems += "$path : folded/multiline description not supported - keep it on one line" }
    elseif ($fm -notmatch '(?m)^description:\s*(\S.*)$') { $problems += "$path : frontmatter missing 'description'" }
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

# Warn about installed copies this sync never removes (renamed/deleted here, or personal files).
$repoAgentFiles = (Get-ChildItem (Join-Path $repo "agents") -Filter *.md).Name
$staleAgents = Get-ChildItem $agentsDst -Filter *.md | Where-Object { $_.Name -notin $repoAgentFiles }
if ($staleAgents) { Write-Output "WARNING: ~/.claude/agents has files not in this repo (personal or stale - sync never deletes): $(($staleAgents | ForEach-Object { $_.Name }) -join ', ')" }
$repoSkillDirs = (Get-ChildItem (Join-Path $repo "skills") -Directory).Name
$staleSkills = Get-ChildItem $skillsDst -Directory | Where-Object { $_.Name -notin $repoSkillDirs }
if ($staleSkills) { Write-Output "WARNING: ~/.claude/skills has directories not in this repo (personal or stale - sync never deletes): $(($staleSkills | ForEach-Object { $_.Name }) -join ', ')" }

$agentCount = (Get-ChildItem (Join-Path $repo "agents") -Filter *.md).Count
$skillCount = (Get-ChildItem (Join-Path $repo "skills") -Directory).Count
Write-Output "Validated and synced $agentCount agents and $skillCount skills (templates bundled into new-project) to $claudeDir"
Write-Output "Restart Claude Code (or start a new session) to pick up changes."
