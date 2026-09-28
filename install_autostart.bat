@echo off
title Install Terminal Discord Presence Autostart
echo Installing Terminal Discord Presence to Windows Startup...

set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "SHORTCUT_PATH=%STARTUP_FOLDER%\TerminalDiscordRPC.lnk"
set "SCRIPT_DIR=%~dp0"
set "VBS_PATH=%SCRIPT_DIR%runner.vbs"

powershell -NoProfile -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SHORTCUT_PATH%'); $s.TargetPath = 'wscript.exe'; $s.Arguments = '\"%VBS_PATH%\"'; $s.WorkingDirectory = '%SCRIPT_DIR%'; $s.Save()"

if exist "%SHORTCUT_PATH%" (
    echo [SUCCESS] Autostart shortcut successfully created in Startup folder!
    echo Script directory: %SCRIPT_DIR%
) else (
    echo [ERROR] Failed to create shortcut.
)

pause
