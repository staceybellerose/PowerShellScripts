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
	if (Test-Path $Env:ANDROID_HOME + "\adb.exe") {
		return $Env:ANDROID_HOME + "\adb.exe"
	}
	$defaultAdbPathInStudio = $Env:LOCALAPPDATA + "\Android\sdk\platform-tools\adb.exe"
	if (Test-Path $defaultAdbPathInStudio) {
		return $defaultAdbPathInStudio
	}
	$defaultSdkPath = $Env:PROGRAMFILES + "\Android\android-sdk\platform-tools\adb.exe"
	if (Test-Path $defaultSdkPath) {
		return $defaultSdkPath
	}
	$myStandardInstallPath = "C:\home\bin\android-sdk\platform-tools\adb.exe"
	if (Test-Path $myStandardInstallPath) {
		return $myStandardInstallPath
	}
	$myAlternateInstallPath = "C:\home\bin\android-sdk-windows\platform-tools\adb.exe"
	if (Test-Path $myAlternateInstallPath) {
		return $myAlternateInstallPath
	}
	return ""
}
