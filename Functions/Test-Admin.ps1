function Test-Admin {
<#
.Synopsis
	Determine if the current shell has Admin role.
.Description
	Determine if the current shell has Admin role.
#>
	# Get the ID and security principal of the current user account
	$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
	$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

	# Get the security principal for the Administrator role
	$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator

	return $myWindowsPrincipal.IsInRole($adminRole)
}
