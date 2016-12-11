<#
.Synopsis
    Microsoft.PowerShell_profile.ps1 - My PowerShell profile
.Description
    Microsoft.PowerShell_profile - Customizes the PowerShell console
.Notes
    File Name   : Microsoft.PowerShell_profile.ps1
    Author      : Stacey Adams (stacey.belle.rose@gmail.com)
#>

. $PSScriptRoot\LoadFunctions.ps1

. $PSScriptRoot\LoadAliases.ps1

. $PSScriptRoot\LoadModules.ps1

. $PSScriptRoot\PoshGitProfile.ps1

. $PSScriptRoot\PsAndroid.ps1

. $PSScriptRoot\LoadStartup.ps1

# Initialization

Set-Location C:\home\projects

Reset-Shell
Set-KeyHandlers
Retain-CommandHistory
Create-TempDrives
Get-VersionInfo
Get-DiskInfo
Remove-StartupFunctions
Remove-Item -Path Function:\Remove-StartupFunctions
