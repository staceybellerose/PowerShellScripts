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

# Add shortcuts to the start menu
$ShortcutPath = "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Startup\Task Manager.lnk"
$TaskManager = "$Env:SystemRoot\system32\taskmgr.exe"

if (!(Test-Path -Path $ShortcutPath)) {
    New-Shortcut -Path $ShortcutPath -TargetPath $TaskManager -Description "Task Manager" -WindowStyle 7 -Icon "$TaskManager, 0"
}

$ShortcutPath = "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Startup\Monitor-Vlc.lnk"
$MonitorVlc = Split-Path $PROFILE | Join-Path -ChildPath "Scripts" | Join-Path -ChildPath "Monitor-Vlc.cmd"

if (!(Test-Path -Path $ShortcutPath)) {
    New-Shortcut -Path $ShortcutPath -TargetPath $MonitorVlc -Description "Monitor VLC to manage screensaver" -WindowStyle 7 -Icon "$Env:SystemRoot\system32\shell32.dll, 25"
}

# Add MyModules to module path set
$mymodules = Split-Path $PROFILE | Join-Path -ChildPath "MyModules"
$CurrentValue = [Environment]::GetEnvironmentVariable("PSModulePath", "User")
[Environment]::SetEnvironmentVariable("PSModulePath", $CurrentValue + ";" + $mymodules, "User")
