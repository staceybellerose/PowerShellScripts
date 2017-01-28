function Get-SessionArch {
<#
.Synopsis
    Returns the current architecture flag.
.Description
    Returns the architecture flag for the current session as a string.
#>
	if ([System.IntPtr]::Size -eq 8) {
		return "x64"
	} else {
		return "x86"
	}
}
