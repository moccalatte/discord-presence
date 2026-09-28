@echo off
:: CMD Prompt Hook Integration for Terminal Discord Presence
:: Usage: set PROMPT=$G$S & call scripts\cmd_prompt.cmd

for /f "tokens=*" %%a in ('powershell -NoProfile -Command "[System.IO.Path]::GetTempPath()"') do set "TEMP_DIR=%%a"

powershell -NoProfile -Command "$cwd = '%CD%'.Replace('\','/'); $data = @{ shell='CMD'; cwd=$cwd; timestamp=[DateTimeOffset]::UtcNow.ToUnixTimeSeconds() }; $json = $data | ConvertTo-Json -Compress; [System.IO.File]::WriteAllText('%TEMP%\discord_terminal_state.json', $json)" >nul 2>&1
