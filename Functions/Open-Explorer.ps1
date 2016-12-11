function Open-Explorer {
<#
.Synopsis
    Open an explorer window to the current directory.
.Description
    Open an explorer window to the current directory.
#>
	[CmdletBinding()]param (
		[Parameter(Position = 0)]
		$Location = '.'
	)

	explorer.exe $Location
}

Set-Alias w Open-Explorer
