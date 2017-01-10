<#
REQUIRED: Node.js and PowerShell 2+ must be installed first, then chocolatey

# Install Chocolatey from PowerShell 2:
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Chocolatey from PowerShell 3+:
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression

PowerShell 4 is needed for some bugfixes, before powershell 5 is installed
#>
param (
	[Bool] $FirstRun = $FALSE
)

if (-not (Test-Admin)) {
	Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    exit
}

if ($PSVersionTable.PSVersion.Major -lt 5) {
	Write-Warning "Please update PowerShell to at least version 5.0 before using chocolatey"
	exit
}

if (-not $FirstRun) {
	# Simply upgrade all the choco-installed apps
	choco upgrade all
	exit
}

# Install the following apps via chocolatey

# Frameworks

choco install dotnet4.6.2

# Utilities

choco install 7zip
choco install 7zip.commandline
choco install chocolateygui
choco install eraser
choco install defraggler
choco install --allow-empty-checksums glaryutilities-free
choco install zipinst
choco install win32diskimager
if ([System.Environment]::OSVersion.Version -ge "6.2") {
	# PC is Windows 8 or above
	choco install classic-shell
}

# Development Tools

choco install notepadplusplus.install
choco install vim
choco install sourcetree
choco install diffmerge
choco install kdiff3
choco install winmerge
choco install visualstudiocode
choco install vscode-powershell
choco install git --installargs "'/D=C:\home\bin\git'"
choco install tortoisegit
choco install keyboard-layout-creator
#If necessary for client work
#choco install svn
#choco install tortoisesvn

# Documents

choco install libreoffice
choco install foxitreader
choco install pdfcreator
choco install word.viewer
choco install excel.viewer
choco install powerpoint.viewer
choco install fileformatconverters

# Network Tools

choco install filezilla
choco install winscp
choco install curl
choco install uTorrent
choco install wget

# Security

choco install keepass
choco install ccleaner

# Images

choco install --allow-empty-checksums paint.net
choco install gimp
choco install inkscape
choco install imagemagick

# Media

choco install audacity
choco install audacity-lame
choco install vlc
choco install infrarecorder
choco install greenshot

# Cloud

choco install googledrive
choco install dropbox

# Other

choco install googleearth

#The following installer has issues
#choco install libreoffice-help

refreshenv
