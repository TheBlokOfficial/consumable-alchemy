# Copies the mod into the game's mods folder (replaces the previous copy).
# Usage: powershell -ExecutionPolicy Bypass -File deploy.ps1 [-GameDir "<path to The Witcher 3>"]
param(
    [string]$GameDir = "D:\gry\steam\steamapps\common\the witcher 3"
)

$ErrorActionPreference = "Stop"
$modName = "modConsumableAlchemy"
$source  = Join-Path $PSScriptRoot "src\$modName"
$modsDir = Join-Path $GameDir "mods"
$target  = Join-Path $modsDir $modName

if (-not (Test-Path (Join-Path $GameDir "bin\x64_dx12\witcher3.exe")) -and -not (Test-Path (Join-Path $GameDir "bin\x64\witcher3.exe"))) {
    throw "The Witcher 3 not found in: $GameDir"
}

New-Item -ItemType Directory -Force -Path $modsDir | Out-Null
if (Test-Path $target) { Remove-Item -Recurse -Force $target }
Copy-Item -Recurse $source $target

Write-Host "Deployed to $target"
