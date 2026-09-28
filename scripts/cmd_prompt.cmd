@echo off
:: CMD Prompt Hook Integration for Terminal Discord Presence
:: Native CMD batch script without spawning external processes

set "STATE_FILE=%TEMP%\discord_terminal_state.json"
set "SAFE_CWD=%CD:\=/%"

if defined SSH_TTY (
    set "USER_CTX=%USERNAME%@%COMPUTERNAME%:"
) else if defined SSH_CONNECTION (
    set "USER_CTX=%USERNAME%@%COMPUTERNAME%:"
) else (
    set "USER_CTX="
)

echo {"shell": "CMD", "cwd": "%SAFE_CWD%", "user": "%USER_CTX%", "timestamp": %TIME:~0,2%%TIME:~3,2%%TIME:~6,2%}> "%STATE_FILE%" 2>nul
