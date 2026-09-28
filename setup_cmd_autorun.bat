@echo off
title Auto-Setup CMD Hook (AutoRun)
echo Registering CMD Prompt Hook in Windows Registry...

set "SCRIPT_DIR=%~dp0"
set "CMD_HOOK=%SCRIPT_DIR%scripts\cmd_prompt.cmd"

reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "\"%CMD_HOOK%\"" /f

if %ERRORLEVEL% EQU 0 (
    echo [SUCCESS] CMD Hook registered successfully!
    echo Every CMD window will now automatically sync current directory and context with Discord.
) else (
    echo [ERROR] Failed to set registry value.
)

pause
