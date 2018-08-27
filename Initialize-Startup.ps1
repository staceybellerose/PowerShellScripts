param (
	[Bool] $FirstRun = $FALSE
)

if (-not (Test-Admin)) {
	Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    exit
}

if (-not $FirstRun) {
	exit
}

$ShortcutPath = "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Startup\Task Manager.lnk"
$Target = "$Env:SystemRoot\system32\taskmgr.exe"

if (!(Test-Path -Path $ShortcutPath)) {
    New-Shortcut -Path $ShortcutPath -TargetPath $Target -Description "Task Manager" -WindowStyle 7 -Icon "$Target, 0"
}
