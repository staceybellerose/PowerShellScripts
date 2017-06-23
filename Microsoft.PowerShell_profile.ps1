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
Get-ChildItem $functions | ForEach-Object { . $_.FullName }

# Load local modules in the current folder
$modules = Join-Path $here "*.psm1"
Get-ChildItem $modules | ForEach-Object { Import-Module $_.FullName }

# Load private functions
$private = Join-Path $here "Private.ps1"
if (Test-Path $private) {
	Get-ChildItem $private | ForEach-Object { . $_.FullName }
}

. $PSScriptRoot\LoadAliases.ps1
. $PSScriptRoot\LoadModules.ps1
. $PSScriptRoot\PoshGitProfile.ps1

Set-Location C:\home\projects

Set-PSReadlineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Chord DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Chord Ctrl+q -Function DeleteCharOrExit

Initialize-Shell
Save-CommandHistory
Get-VersionInfo
Get-DiskInfo

if (Test-Admin) {
	Update-Help -Module * -ErrorAction SilentlyContinue
}
