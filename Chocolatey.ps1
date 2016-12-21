<#
REQUIRED: Node.js and PowerShell 2+ must be installed first, then chocolatey

# Install Chocolatey from PowerShell 2:
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Chocolatey from PowerShell 3+:
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression

PowerShell 4 is needed for some bugfixes, before powershell 5 is installed
#>
Write-Host "Please review this script before running it!"
exit # this script MUST NOT be run without reviewing it!

# PowerShell

if ($PSVersionTable.PSVersion.Major <= 4) {
	choco upgrade -y powershell4
}
choco upgrade -y powershell

# Frameworks
choco upgrade -y dotnet4.6.2

# Utilities

choco upgrade -y 7zip
choco upgrade -y 7zip.commandline
choco upgrade -y chocolateygui
choco upgrade -y eraser
choco upgrade -y defraggler
choco upgrade -y --allow-empty-checksums glaryutilities-free
choco upgrade -y zipinst
if ([System.Environment]::OSVersion.Version -ge "6.2") {
	# PC is Windows 8 or above
	choco upgrade -y classic-shell
}

# Development Tools

choco upgrade -y notepadplusplus.install
choco upgrade -y vim
choco upgrade -y sourcetree
choco upgrade -y diffmerge
choco upgrade -y kdiff3
choco upgrade -y winmerge
choco upgrade -y visualstudiocode
choco upgrade -y vscode-powershell
choco upgrade -y git --installargs "'/D=C:\home\bin\git'"
choco upgrade -y tortoisegit
#If necessary for client work
#choco upgrade -y svn
#choco upgrade -y tortoisesvn

# Documents

choco upgrade -y libreoffice
choco upgrade -y foxitreader
choco upgrade -y pdfcreator
choco upgrade -y word.viewer
choco upgrade -y excel.viewer
choco upgrade -y powerpoint.viewer
choco upgrade -y fileformatconverters

# Network Tools

choco upgrade -y filezilla
choco upgrade -y winscp
choco upgrade -y curl
choco upgrade -y wget

# Security

choco upgrade -y keepass
choco upgrade -y ccleaner

# Images

choco upgrade -y --allow-empty-checksums paint.net
choco upgrade -y gimp
choco upgrade -y inkscape
choco upgrade -y imagemagick

# Media

choco upgrade -y audacity
choco upgrade -y audacity-lame
choco upgrade -y vlc
choco upgrade -y infrarecorder
choco upgrade -y greenshot

# Cloud

choco upgrade -y googledrive
choco upgrade -y dropbox

# Other

choco upgrade -y googleearth

#The following installers have issues
#choco upgrade -y libreoffice-help

refreshenv
