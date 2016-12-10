<#
.SYNOPSIS
    LoadAliases.ps1 - Alias loader
.DESCRIPTION
    LoadAliases - Define some aliases for use.
.NOTES
    File Name   : LoadAliases.ps1
    Author      : Stacey Adams (stacey.belle.rose@gmail.com)
#>

if (Test-Path "C:\Program Files\Notepad++") {
	Set-Alias np "C:\Program Files\Notepad++\notepad++.exe"
} elseif (Test-Path "C:\Program Files (x86)\Notepad++") {
	Set-Alias np "C:\Program Files (x86)\Notepad++\notepad++.exe"
}

Set-Alias gdi Get-DiskInfo
Set-Alias reboot Restart-Computer
Set-Alias shutdown Stop-Computer
