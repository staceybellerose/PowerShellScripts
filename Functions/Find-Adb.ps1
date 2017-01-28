function Find-Adb {
<#
.Synopsis
	Return the full path, if necessary, of the ADB executable.
.Description
	Return the full path, if necessary, of the ADB executable. If the executable is
	found on the path, just the command name will be returned. If not, the ANDROID_HOME
	environment variable will be checked. If still not found, default installation
	paths will be checked.
#>
	if (Get-Command "adb.exe" -ErrorAction SilentlyContinue) {
		return "adb.exe"
	}
	@(
		$Env:ANDROID_HOME + "\adb.exe",
		$Env:LOCALAPPDATA + "\Android\sdk\platform-tools\adb.exe",
		$Env:PROGRAMFILES + "\Android\android-sdk\platform-tools\adb.exe",
		"C:\home\bin\android-sdk\platform-tools\adb.exe",
		"C:\home\bin\android-sdk-windows\platform-tools\adb.exe"
	) | ForEach-Object {
		if (Test-Path -Path $_) {
			return $_
		}
	}
	return ""
}
