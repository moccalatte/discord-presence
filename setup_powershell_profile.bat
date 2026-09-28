@echo off
title Auto-Setup PowerShell Profile
echo Appending Terminal Discord Presence hook to PowerShell profile...

set "SCRIPT_DIR=%~dp0"
set "PS_PROFILE_SCRIPT=%SCRIPT_DIR%scripts\profile.ps1"

powershell -NoProfile -Command "if (!(Test-Path $PROFILE)) { New-Item -Type File -Path $PROFILE -Force | Out-Null }; Add-Content -Path $PROFILE -Value (Get-Content '%PS_PROFILE_SCRIPT%')"

if %ERRORLEVEL% EQU 0 (
    echo [SUCCESS] PowerShell profile updated!
    echo Every PowerShell session will now automatically sync current directory and context with Discord.
) else (
    echo [ERROR] Failed to update PowerShell profile.
)

pause
