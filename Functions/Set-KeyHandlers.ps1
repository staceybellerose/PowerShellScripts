function Set-KeyHandlers {
<#
.Synopsis
    Set Key Handlers for PsReadLine.
.Description
    Set Key Handlers for PsReadLine.
#>
	Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
	Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
	Set-PSReadlineKeyHandler -Key Ctrl+q -Function DeleteCharOrExit
}

function Remove-StartupFunctions {
	if (Test-Path Function:\Set-KeyHandlers) {
		Remove-Item -Path Function:\Set-KeyHandlers
	}
	if (Test-Path Function:\Retain-CommandHistory) {
		Remove-Item -Path Function:\Retain-CommandHistory
	}
}
