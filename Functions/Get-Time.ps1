function Get-Time {
<#
.Synopsis
    Gets the current time.
.Description
    Gets the current time as a string, using the Get-Date cmdlet.
#>
	return $(Get-Date | ForEach {$_.ToLongTimeString()})
}
