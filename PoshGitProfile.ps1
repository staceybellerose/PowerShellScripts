Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

function shorten-path([string] $path) { 
   $loc = $path.Replace($HOME, '~') 
   # remove prefix for UNC paths 
   $loc = $loc -replace '^[^:]+::', '' 
   # make path shorter like tabs in Vim, 
   # handle paths starting with \\ and . correctly 
   return ($loc -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2') 
}

# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
	$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
	$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
	$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
	if ($myWindowsPrincipal.IsInRole($adminRole)) {
		$Host.UI.RawUI.WindowTitle = "Windows PowerShell (Administrator) @ " + $(Get-Location)
	} else {
		$Host.UI.RawUI.WindowTitle = "Windows PowerShell @ " + $(Get-Location)
	}
	$cdelim = [ConsoleColor]::DarkCyan
	$chost = [ConsoleColor]::Green
	$cloc = [ConsoleColor]::Cyan

	write-host "$([char]0x0A7) " -n -f $cloc
	#write-host '{' -n -f $cdelim
	#write-host (split-path (pwd) -Leaf) -n -f $cloc
	write-host (shorten-path (pwd).Path) -n -f $cloc 
	#write-host '}' -n -f $cdelim

	Write-VcsStatus

	$global:LASTEXITCODE = $realLASTEXITCODE
	return "> "
}

Pop-Location
