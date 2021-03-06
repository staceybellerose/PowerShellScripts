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
Split-Path $PROFILE | Join-Path -ChildPath "Functions" | Get-ChildItem | ForEach-Object { . $_.FullName }

# Load private functions
Split-Path $PROFILE | Join-Path -ChildPath "Private.ps1" | ForEach-Object { . $_ }

# Load MyModules
Split-Path $PROFILE | Join-Path -ChildPath "MyModules" | Get-ChildItem | ForEach-Object { Import-Module $_.Name }

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
