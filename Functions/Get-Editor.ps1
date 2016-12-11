function Get-Editor {
	$path = Resolve-Path (Join-Path (Join-Path "$env:PROGRAMW6432*" "Notepad++") "notepad++.exe")

	if($path.Path) {
		return $path.Path
	}

	<#
	$path = Resolve-Path (Join-Path (Join-Path (Join-Path "$env:PROGRAMW6432*" "Vim*") "vim*") "vim.exe")
	if($path.Path) {
		return $path.Path
	}
	#>
	
	$path = Join-Path $env:windir "\system32\notepad.exe"
	if(Test-Path $path) {
		return $path
	}
	
	return $null
}

$editor = Get-Editor
Set-Alias edit "$editor"
Set-Alias np "$editor"
