# PowerShell Profile Integration for Terminal Discord Presence
# Add this script to your PowerShell profile ($PROFILE)

function Update-DiscordTerminalState {
    try {
        $tempDir = [System.IO.Path]::GetTempPath()
        $stateFile = [System.IO.Path]::Combine($tempDir, "discord_terminal_state.json")

        $shellName = if ($PSVersionTable.PSEdition -eq "Core") { "PowerShell Core" } else { "PowerShell" }
        $userContext = ""

        if ($env:SSH_TTY -or $env:SSH_CONNECTION) {
            $userContext = "$($env:USERNAME)@$($env:COMPUTERNAME):"
        }

        $currentCwd = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation.Path
        $payload = @{
            shell = $shellName
            cwd = $currentCwd
            user = $userContext
            timestamp = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
        } | ConvertTo-Json -Compress

        [System.IO.File]::WriteAllText($stateFile, $payload, [System.Text.Encoding]::UTF8)
    } catch {
        # Silent ignore
    }
}

# Immediately update state on profile initialization
Update-DiscordTerminalState

# Hook into PowerShell prompt
if (Test-Path Function:\prompt) {
    $OldPrompt = $function:prompt
    function prompt {
        Update-DiscordTerminalState
        & $OldPrompt
    }
} else {
    function prompt {
        Update-DiscordTerminalState
        "PS $($ExecutionContext.SessionState.Path.CurrentFileSystemLocation.Path)> "
    }
}
