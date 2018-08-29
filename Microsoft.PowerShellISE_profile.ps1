<#
.Synopsis
    Microsoft.PowerShellISE_profile.ps1 - My PowerShell ISE profile
.Description
    Microsoft.PowerShellISE_profile - Customizes the PowerShell ISE console
.Notes
    File Name   : Microsoft.PowerShellISE_profile.ps1
    Author      : Stacey Adams (stacey.belle.rose@gmail.com)
#>

# Load functions in the Functions folder
Split-Path $PROFILE | Join-Path -ChildPath "Functions" | Get-ChildItem | ForEach-Object { . $_.FullName }

# Load private functions
Split-Path $PROFILE | Join-Path -ChildPath "Private.ps1" | ForEach-Object { . $_ }

# Load MyModules
Split-Path $PROFILE | Join-Path -ChildPath "MyModules" | Get-ChildItem | ForEach-Object { Import-Module $_.Name }

. $PSScriptRoot\LoadAliases.ps1
. $PSScriptRoot\PoshGitProfile.ps1

Set-PSReadlineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Chord DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Chord Ctrl+q -Function DeleteCharOrExit

Save-CommandHistory
