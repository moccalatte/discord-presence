@echo off
title Uninstall Terminal Discord Presence Autostart
echo Removing Terminal Discord Presence from Windows Startup...

set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "SHORTCUT_PATH=%STARTUP_FOLDER%\TerminalDiscordRPC.lnk"

if exist "%SHORTCUT_PATH%" (
    del "%SHORTCUT_PATH%"
    echo [SUCCESS] Autostart shortcut successfully removed!
) else (
    echo [INFO] Shortcut was not found in Startup folder.
)

pause
