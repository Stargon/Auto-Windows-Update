#Requires -RunAsAdministrator
# Script will run, without prompting, Windows Update and install any updates 
# found.

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
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll