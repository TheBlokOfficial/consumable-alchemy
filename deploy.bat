@echo off
rem Copies the mod into the game's mods folder (wrapper for deploy.ps1).
rem Usage: deploy.bat ["<path to The Witcher 3>"]

if "%~1"=="" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0deploy.ps1"
) else (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0deploy.ps1" -GameDir "%~1"
)

if errorlevel 1 (
    echo.
    echo Deploy FAILED.
)
pause
