@echo off
:: CMD Prompt Hook Integration for Terminal Discord Presence
:: Usage: set PROMPT=$G$S & call scripts\cmd_prompt.cmd

powershell -NoProfile -ExecutionPolicy Bypass -Command "$cwd = (Get-Location).Path.Replace('\','/'); $user = if ($env:SSH_TTY) { \"$($env:USERNAME)@$($env:COMPUTERNAME):\" } else { '' }; $data = @{ shell='CMD'; cwd=$cwd; user=$user; timestamp=[DateTimeOffset]::UtcNow.ToUnixTimeSeconds() }; $json = $data | ConvertTo-Json -Compress; $path = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), 'discord_terminal_state.json'); [System.IO.File]::WriteAllText($path, $json)" >nul 2>&1
