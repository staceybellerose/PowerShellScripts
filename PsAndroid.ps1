<#
.Synopsis
    PsAndroid.ps1 - Helpful functions for Android development
.Description
    Helpful functions for Android development
.Notes
    File Name   : PsAndroid.ps1
    Author      : Stacey Adams (stacey.belle.rose@gmail.com)
#>

# TODO turn this into a module

function Start-AndroidApp([String] $Location = ".") {
<#
.Synopsis
    Start the Android app in the provided folder.
.Description
    Start the Android app located in the provided folder.
#>
	Push-Location $Location
	$adb = Find-Adb
	if ($adb -eq "") {
		Write-Error "Unable to locate ADB."
	}

	if (Test-Path("AndroidManifest.xml")) {
		[System.Xml.XmlDocument] $xd = New-Object System.Xml.XmlDocument
		$file = Resolve-Path("AndroidManifest.xml")
		$xd.load($file)
	} else {
		Write-Error "Android manifest file not found. Please check your directory."
		Exit
	}

	$manifest = $xd.selectSingleNode("/manifest")
	$package = $manifest.getAttribute("package")
	if ($package -eq "") {
		Write-Error "No package name found in Android manifest. Please review the file."
		Exit
	}

	$activityName = ""
	$activityList = $xd.selectNodes("/manifest/application/activity")
	$firstActivity = $activityList.item(0)
	if ($firstActivity -eq "") {
		Write-Error "No activities found in Android manifest. Please review the file."
		exit
	}

	foreach ($activity in $activityList) {
		# check each activity for a "main" action intent-filter
		$testActivityName = $activity.getAttribute("android:name")
		$intentList = $activity.selectNodes("intent-filter/action")
		foreach ($intent in $intentList) {
			$name = $intent.getAttribute("android:name")
			if ($name -eq "android.intent.action.MAIN") {
				$activityName = $testActivityName
				break
			}
		}
		if ($activityName -ne "") {
			# we found an activity in the above foreach loop; stop looking
			break
		}
	}

	if ($activityName -eq "") {
		# we didn't find one, use the first one as default
		Write-Warning "No primary activity found in Android manifest. Defaulting to first activity listed in application."
		$activityName = $firstActivity
	}

	Write-Verbose "Found package: $package"
	Write-Verbose "Found activity: $activityName"
	Write-Verbose "Starting activity via adb. Please wait..."
	& $adb shell am start -a android.intent.action.MAIN -n $package/$activityName
	Pop-Location
}

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