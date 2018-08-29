##
## Screensaver management functions
##

function Enable-Screensaver {
<#
.Synopsis
	Enable the screensaver
.Description
	Use caffeine to enable the screensaver, if it has been installed
#>
	which caffeine 2>&1 | out-null
	if ($LastExitCode -eq 0) {
		$caffeine = Get-Process caffeine -ErrorAction SilentlyContinue
		if (!($caffeine))
		{
			Write-Verbose "Starting caffeine.exe"
			caffeine
		}
		caffeine -appoff
	} else {
		Write-Error "Cannot enable screensaver: unable to find caffeine.exe in PATH"
	}
}

function Disable-Screensaver {
<#
.Synopsis
	Disable the screensaver
.Description
	Use caffeine to disable the screensaver, if it has been installed
#>
	which caffeine 2>&1 | out-null
	if ($LastExitCode -eq 0) {
		$caffeine = Get-Process caffeine -ErrorAction SilentlyContinue
		if (!($caffeine))
		{
			Write-Verbose "Starting caffeine.exe"
			caffeine
		}
		caffeine -appon
	} else {
		Write-Error "Cannot disable screensaver: unable to find caffeine.exe in PATH"
	}
}
