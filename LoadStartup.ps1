<#
.SYNOPSIS
    LoadStartup.ps1 - Function loader for startup.
.DESCRIPTION
    LoadStartup - Function loader for startup functions (those used when starting the console).
.NOTES
    File Name   : LoadStartup.ps1
    Author      : Stacey Adams (stacey.belle.rose@gmail.com)
#>

function Retain-CommandHistory {
<#
.Synopsis
    Save the current session's command history allowing it to be used in a future session.
.Description
    Set up a PowerShell.Exiting exent handler to save the current session's command history.
	This command history will be saved in a file named `.ps_history` located in the user's
	profile folder.
#>
	$global:MaximumHistoryCount = 4096

	$HistoryFilePath = Join-Path ([Environment]::GetFolderPath('UserProfile')) .ps_history
	Register-EngineEvent PowerShell.Exiting -Action {
		Get-History | Export-Clixml $HistoryFilePath
	} | Out-Null
	if (Test-Path $HistoryFilePath) {
		Import-Clixml $HistoryFilePath | Add-History
	}
}

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

function Create-TempDrives {
	$names = [Environment+SpecialFolder]::GetNames([Environment+SpecialFolder])
	foreach($name in $names)
	{
		if($path = [Environment]::GetFolderPath($name)){
			New-PSDrive -Name $name -PSProvider FileSystem -Root $path
		}
	}
}

function Remove-StartupFunctions {
	if (Test-Path Function:\Set-KeyHandlers) {
		Remove-Item -Path Function:\Set-KeyHandlers
	}
	if (Test-Path Function:\Retain-CommandHistory) {
		Remove-Item -Path Function:\Retain-CommandHistory
	}
	if (Test-Path Function:\Create-TempDrives) {
		Remove-Item -Path Function:\Create-TempDrives
	}
}
