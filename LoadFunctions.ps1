<#
.SYNOPSIS
    LoadFunctions.ps1 - Function loader
.DESCRIPTION
    LoadFunctions - Function loader for miscellaneous functions.
.NOTES
    File Name   : LoadFunctions.ps1
    Author      : Stacey Adams (stacey.belle.rose@gmail.com)
#>

function Get-Time {
<#
.Synopsis
    Gets the current time.
.Description
    Gets the current time as a string, using the Get-Date cmdlet.
#>
	return $(Get-Date | ForEach {$_.ToLongTimeString()})
}

function Reload-Profile {
<#
.Synopsis
    Run all the profile scripts.
.Description
    Run all the profile scripts in order to add any new functionality to the current PowerShell console.
#>
	@(
		$Profile.AllUsersAllHosts,
		$Profile.AllUsersCurrentHost,
		$Profile.CurrentUserAllHosts,
		$Profile.CurrentUserCurrentHost
	) | % {
		if(Test-Path $_) {
			Write-Verbose "Running $_"
			. $_
		}
	}    
}

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

function Reset-Shell {
<#
.Synopsis
	Reset the console window's buffer and size.
.Description
	Reset the console window's buffer and size to something appropriate.
#>
	$Shell=$Host.UI.RawUI
	$size=$Shell.BufferSize
	$size.width=120
	$size.height=5000
	$Shell.BufferSize=$size
	$size=$Shell.WindowSize
	$size.width=120
	$size.height=50
	$Shell.WindowSize=$size
	$Shell.CursorSize=25
	
	# Check to see if we are currently running "as Administrator"
	if (Test-Admin) {
		$Shell.BackgroundColor = "DarkRed"
	}
	
	Clear-Host
}

function Check-SessionArch {
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

function Get-DiskInfo {
<#
.Synopsis
    Gets disk information.
.Description
    Gets disk information about all currently mounted physical disks,
	and displays it as an easy-to-read table.
#>
	$LogicalDisk = @()
	Get-WmiObject Win32_LogicalDisk -filter "DriveType='3'" | % {
		$LogicalDisk += @($_ | Select @{n="Name";e={$_.Caption}},
		@{n="Volume Label";e={$_.VolumeName}},
		@{n="Size (Gb)";e={"{0:N2}" -f ($_.Size/1GB)}},
		@{n="Used (Gb)";e={"{0:N2}" -f (($_.Size/1GB) - ($_.FreeSpace/1GB))}},
		@{n="Free (Gb)";e={"{0:N2}" -f ($_.FreeSpace/1GB)}},
		@{n="Free (%)";e={if($_.Size) {"{0:N2}" -f (($_.FreeSpace/1GB) / ($_.Size/1GB) * 100 )} else {"NAN"} }})
	}
	$LogicalDisk | Format-Table -AutoSize | Out-String
}

function Get-VersionInfo {
<#
.Synopsis
	Gets PowerShell version information.
.Description
	Gets PowerShell version information and displays it.
#>
	$Version = "" + $PSVersionTable.PSVersion.Major + "." + $PSVersionTable.PSVersion.Minor
	Write-Host "Windows PowerShell, Version $Version"
}

function w {
<#
.Synopsis
    Open an explorer window to the current directory.
.Description
    Open an explorer window to the current directory.
#>
	explorer .
}
