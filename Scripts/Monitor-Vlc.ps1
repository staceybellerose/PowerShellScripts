#Requires -Modules ManageScreensaver
<#
.Synopsis
	Monitor the process list for VLC.
.Description
	Monitor the process list for VLC and enable/disable the screensaver as appropriate.
#>
do {
	$vlc = Get-Process vlc -ErrorAction SilentlyContinue
	if ($vlc) {
		Disable-Screensaver
		Write-Verbose "Screensaver disabled"
	} else {
		Enable-Screensaver
		Write-Verbose "Screensaver enabled"
	}
	Start-Sleep 1
} while ($true)