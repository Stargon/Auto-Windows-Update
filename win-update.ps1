#Requires -RunAsAdministrator
if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
    Get-Package -Name PSWindowsUpdate
    Update-Module -Name PSWindowsUpdate
} 
else {
    Install-PackageProvider -Name NuGet -Force
    Install-Module -Name PSWindowsUpdate -Force
}
Get-Package -Name PSWindowsUpdate
Get-WindowsUpdate
#Add-WUServiceManager -MicrosoftUpdate -AcceptAll
#Install-WindowsUpdate -MicrosoftUpdate -AcceptAll