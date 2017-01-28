function Sync-Profile {
<#
.Synopsis
    Run all the profile scripts.
.Description
    Run all the profile scripts in order to add any new functionality to the current PowerShell console.
#>
	[CmdletBinding()]
	Param()
	@(
		$Profile.AllUsersAllHosts,
		$Profile.AllUsersCurrentHost,
		$Profile.CurrentUserAllHosts,
		$Profile.CurrentUserCurrentHost
	) | ForEach-Object {
		if(Test-Path $_) {
			Write-Verbose "Running $_"
			. $_
		}
	}    
}
