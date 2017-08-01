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
choco install zipinst
choco install win32diskimager
choco install x-lite
choco install virtuawin
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
# choco upgrade all doesn't allow for installargs
#choco install git --installargs "'/D=C:\home\bin\git'"
choco install git
choco install tortoisegit
choco install keyboard-layout-creator
choco install markdownpad2
choco install sqlitebrowser
choco install deepgit
choco install nodejs
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
choco install miktex
choco install lyx
choco install scribus
choco install projectlibre

# Font Tools

choco install babelmap
choco install babelpad
choco install winfontsview

# Fonts

choco install AnonymousPro
choco install dejavufonts
choco install DroidFonts
choco install Inconsolata
choco install --allow-empty-checksums lato
choco install RobotoFonts
choco install SourceCodePro
choco install --allow-empty-checksums ubuntu.font

# Networking

choco install Firefox
choco install skype
choco install filezilla
choco install winscp
choco install uTorrent
choco install wget
choco install teraterm
choco install terminals

# Security

choco install keepass
choco install ccleaner
choco install MicrosoftSecurityEssentials

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

choco install gramps
choco install googleearth

#The following installer has issues
#choco install libreoffice-help

Update-SessionEnvironment
