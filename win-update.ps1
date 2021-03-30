#Requires -RunAsAdministrator
# Script will run, without prompting, Windows Update and install any updates 
# found.

# Specify available params:
#   - restart: restart the computer after the updates are installed
#   - kb: string of kb values to pass to the script
#   - time: restart the computer after x amount of hours, must be used with restart
param(
    [Parameter(Mandatory = $false)][switch]$restart,
    [string[]]$kb,
    [string]$time
)

# Check if PSWindowsUpdate exists, update if it is
if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
    Write-Host "Update module if available..."
    Update-Module -Name PSWindowsUpdate
} 
else {
    Install-PackageProvider -Name NuGet -Force
    Install-Module -Name PSWindowsUpdate -Force
}
Get-Package -Name PSWindowsUpdate

# Begin picking up updates and download them
Write-Host "`r`nUpdating..."
Download-WindowsUpdate -MicrosoftUpdate -AcceptAll

# Based on given command-line args, restart the computer
if ($restart) {
    # Restart flag specified, check $time if delay is specified
    if ($time) {
        # 1 hour = 3600 seconds
        if ($kb) {
            Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot -KBArticleID $kb
            Write-Host "`r`nWait before rebooting..."
            Start-Sleep -Seconds ([decimal]$time * 3600)
            Write-Host "`r`nRebooting..."
            Restart-Computer
        }
        else {
            Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot
            Write-Host "`r`nWait before rebooting..."
            Start-Sleep -Seconds ([decimal]$time * 3600)
            Write-Host "`r`nRebooting..."
            Restart-Computer
        }
    }
    elseif ($kb) {
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -KBArticleID $kb
    }
    else {
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll
    }
}
else {
    # No restart flag specified
    if ($kb) {
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot -KBArticleID $kb
    }
    else {
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot
    }
}