<#
.Synopsis
    Microsoft.PowerShell_profile.ps1 - My PowerShell profile
.Description
    Microsoft.PowerShell_profile - Customizes the PowerShell console
.Notes
    File Name   : Microsoft.PowerShell_profile.ps1
    Author      : Stacey Adams (stacey.belle.rose@gmail.com)
#>

# Load functions in the Functions folder
$here = Split-Path $PROFILE
$functions = Join-Path $here "Functions"
Get-ChildItem $functions | %{ . $_.FullName }

# Load local modules in the current folder
$modules = Join-Path $here "*.psm1"
Get-ChildItem $modules | %{ Import-Module $_.FullName }

. $PSScriptRoot\LoadAliases.ps1
. $PSScriptRoot\LoadModules.ps1
. $PSScriptRoot\PoshGitProfile.ps1

Set-Location C:\home\projects

Reset-Shell
Set-KeyHandlers
Retain-CommandHistory
Get-VersionInfo
Get-DiskInfo
