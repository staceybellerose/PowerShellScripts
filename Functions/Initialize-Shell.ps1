function Initialize-Shell {
<#
.Synopsis
	Initialize the console window's buffer and size.
.Description
	Initialize the console window's buffer and size to something appropriate.
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
