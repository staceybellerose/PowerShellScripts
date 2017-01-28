function Get-VersionInfo {
<#
.Synopsis
	Gets PowerShell version information.
.Description
	Gets PowerShell version information and displays it.
#>
	$Version = "" + $PSVersionTable.PSVersion.Major + "." + $PSVersionTable.PSVersion.Minor
	Write-Output "Windows PowerShell, Version $Version"
}
