<#
.SYNOPSIS
    modules.ps1 - Module installer for first use of PowerShell
.DESCRIPTION
    modules - Module installer for first use of PowerShell
.NOTES
    File Name   : modules.ps1
    Author      : Stacey Adams (stacey.belle.rose@gmail.com)
#>

# PsGet
if (-not (Get-Module -ListAvailable -Name PsGet)) {
	(New-Object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | Invoke-Expression
	Import-Module PsGet
}

# using PsGet, install the following modules
if (-not (Get-Module -ListAvailable -Name out-diff)) {
	Install-Module out-diff
}
if (-not (Get-Module -ListAvailable -Name posh-git)) {
	Install-Module posh-git
}
if (-not (Get-Module -ListAvailable -Name PSColor)) {
	Install-Module PSColor
}
if (-not (Get-Module -ListAvailable -Name PSCustomDrives)) {
	Install-Module PSCustomDrives
}
if (-not (Get-Module -ListAvailable -Name PSGnuwin32)) {
	Install-Module PSGnuwin32
}
if (-not (Get-Module -ListAvailable -Name PsGoogle)) {
	Install-Module PsGoogle
}
if (-not (Get-Module -ListAvailable -Name PSReadLine)) {
	Install-Module PSReadLine
}
if (-not (Get-Module -ListAvailable -Name PsUrl)) {
	Install-Module PsUrl
}

# set up PSCustomDrives - add standard folder
$text = "prj	C:\home\projects"
$text | Add-Content "$Env:USERPROFILE\psdrives.txt"

# set up PSCustomDrives - edit file using favorite installed editor
$editor = ""
if ("C:\Program Files\Notepad++\notepad++.exe") {
	$editor = "C:\Program Files\Notepad++\notepad++.exe"
} elseif ("C:\Program Files (x86)\Notepad++\notepad++.exe") {
	$editor = "C:\Program Files (x86)\Notepad++\notepad++.exe"
} elseif ("C:\Program Files\Vim\vim80\vim.exe") {
	$editor = "C:\Program Files\Vim\vim80\vim.exe"
} elseif ("C:\Program Files (x86)\Vim\vim80\vim.exe") {
	$editor = "C:\Program Files (x86)\Vim\vim80\vim.exe"
} else {
	$editor = "notepad"
}
Invoke-Expression "& `"$editor`" $Env:USERPROFILE\psdrives.txt"
