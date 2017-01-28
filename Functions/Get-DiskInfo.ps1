function Get-DiskInfo {
<#
.Synopsis
    Gets disk information.
.Description
    Gets disk information about all currently mounted physical disks,
	and displays it as an easy-to-read table.
#>
	$LogicalDisk = [System.Collections.ArrayList]@()
	Get-CimInstance -Class Win32_LogicalDisk -Filter "DriveType='3'" | ForEach-Object {
		$LogicalDisk.Add(@($_ | Select-Object @{n="Name";e={$_.Caption}},
		@{n="Volume Label";e={$_.VolumeName}},
		@{n="Size (Gb)";e={"{0:N2}" -f ($_.Size/1GB)}},
		@{n="Used (Gb)";e={"{0:N2}" -f (($_.Size/1GB) - ($_.FreeSpace/1GB))}},
		@{n="Free (Gb)";e={"{0:N2}" -f ($_.FreeSpace/1GB)}},
		@{n="Free (%)";e={if($_.Size) {"{0:N2}" -f (($_.FreeSpace/1GB) / ($_.Size/1GB) * 100 )} else {"NAN"} }})) | Out-Null
	}
	Write-Output $LogicalDisk | Format-Table -AutoSize | Out-String
}

Set-Alias gdi Get-DiskInfo
