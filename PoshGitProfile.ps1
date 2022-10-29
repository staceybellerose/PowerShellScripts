Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

function Limit-Path([string] $path) {
  $loc = $path.Replace($HOME, '~')
  # remove prefix for UNC paths
  $loc = $loc -replace '^[^:]+::', ''
  # make path shorter like tabs in Vim,
  # handle paths starting with \\ and . correctly
  return ($loc -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2')
}

# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
	# using Write-Host in prompts is expected, so don't show code analysis error for it
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "")]
	param()
	$origLastExitCode = $LASTEXITCODE
	$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
	$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
	$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
	if ($myWindowsPrincipal.IsInRole($adminRole)) {
		$Host.UI.RawUI.WindowTitle = "Windows PowerShell (Administrator) @ " + $(Get-Location)
	} else {
		$Host.UI.RawUI.WindowTitle = "Windows PowerShell @ " + $(Get-Location)
	}
	$cyan = [ConsoleColor]::Cyan

	Write-Host "$([char]0x0A7) " -Foreground $cyan -NoNewLine
	Write-Host (Limit-Path (Get-Location).Path) -Foreground $cyan -NoNewLine

	Write-VcsStatus

	$LASTEXITCODE = $origLastExitCode
	return "> "
}

Pop-Location
