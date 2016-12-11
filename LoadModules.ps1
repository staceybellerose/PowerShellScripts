<#
.SYNOPSIS
    LoadModules.ps1 - Module loader
.DESCRIPTION
    LoadModules - Module loader for third-party modules, installing them if necessary.
.NOTES
    File Name   : LoadModules.ps1
    Author      : Stacey Adams (stacey.belle.rose@gmail.com)
#>

# PsGet
if (-not (Get-Module -ListAvailable -Name PsGet)) {
	(New-Object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | Invoke-Expression
}
Import-Module PsGet

# using PsGet, install the following modules if necessary before loading them
if (-not (Get-Module -ListAvailable -Name out-diff)) {
	Install-Module out-diff
}
Import-Module out-diff

if (-not (Get-Module -ListAvailable -Name posh-git)) {
	Install-Module posh-git
}
Import-Module posh-git

if (-not (Get-Module -ListAvailable -Name PSColor)) {
	Install-Module PSColor
}
Import-Module PSColor

if (-not (Get-Module -ListAvailable -Name PSCustomDrives)) {
	Install-Module PSCustomDrives
}
Import-Module PSCustomDrives

if (-not (Get-Module -ListAvailable -Name PSGnuwin32)) {
	Install-Module PSGnuwin32
}
Import-Module PSGnuwin32

if (-not (Get-Module -ListAvailable -Name PsGoogle)) {
	Install-Module PsGoogle
}
Import-Module PsGoogle

if (-not (Get-Module -ListAvailable -Name PSReadLine)) {
	Install-Module PSReadLine
}
Import-Module PSReadLine

if (-not (Get-Module -ListAvailable -Name PsUrl)) {
	Install-Module PsUrl
}
Import-Module PsUrl

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# set up PSCustomDrives - add standard folder
if (-not (Test-Path "$Env:USERPROFILE\psdrives.txt")) {
	$text = "prj	C:\home\projects"
	$text | Add-Content "$Env:USERPROFILE\psdrives.txt"

	# set up PSCustomDrives - edit file using favorite installed editor
	$editor = Get-Editor
	Invoke-Expression "& `"$editor`" $Env:USERPROFILE\psdrives.txt"
}
