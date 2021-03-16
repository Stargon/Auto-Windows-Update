#Requires -RunAsAdministrator
# Script will run, without prompting, Windows Update and install any updates 
# found.

# Specify available params:
#   - restart: restart the computer after the updates are installed
#   - kb: string of kb values to pass to the script
param(
    [Parameter(Mandatory = $false)][switch]$restart,
    [string[]]$kb
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

# Begin picking up updates and install them
Write-Host "`r`nUpdating..."
Download-WindowsUpdate -MicrosoftUpdate -AcceptAll
if ($restart) {
    if ($kb) {
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -KBArticleID $kb
    }
    else {
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll
    }
}
else {
    if ($kb) {
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot -KBArticleID $kb
    }
    else {
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot
    }
}