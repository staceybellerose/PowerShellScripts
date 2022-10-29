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

choco install dotnet4.7.1

# Utilities

choco install 7zip
choco install caffeine
choco install chocolateygui
choco install eraser
choco install etcher
choco install defraggler
choco install f.lux
choco install free42
choco install less
choco install powertoys
choco install ssinternals
choco install windirstat
choco install zipinst

choco install poweriso
choco install totalcommander

# Development Tools - Languages, Compilers, etc.

choco install cmake
choco install golang
choco install gradle
choco install jq
choco install maven
choco install nvm # this will manage node/npm installs
choco install python3
choco install pip
choco install ruby

# Development Tools - Editors/IDEs

choco install anaconda3
# choco install AndroidStudio
choco install intellijidea-community
choco install markdownpad2
choco install notepadplusplus
choco install Pycharm-community
choco install vim
choco install vscode
choco install vscode-powershell
choco install vscode-icons

# Development Tools - Statistical Processing

#choco install R.Project
#choco install R.Studio

# Development Tools - Source Control

choco install deepgit
choco install diffutils
choco install gh
choco install git
choco install git-fork
choco install git-lfs
choco install meld
choco install tortoisegit
choco install winmerge

#If necessary for client work
#choco install svn
#choco install tortoisesvn

# Development Tools - Cloud Deployment

choco install docker-cli
choco install docker-compose
choco install docker-desktop
choco install postman

# Development Tools - Database Management

choco install dbeaver
choco install mongodb
choco install mongodb-compass
choco install mysql
choco install mysql.workbench
choco install pgadmin4
choco install postgresql
choco install SQLite
choco install sqlite-studio.portable
choco install sqlitebrowser

# Development Tools - Command Line Terminals

choco install cmder
choco install hyper

# Documents

choco install foxitreader
choco install krita
choco install libreoffice-fresh
choco install lyx
choco install miktex
choco install pdfcreator
choco install projectlibre
choco install scribus

# Font Tools

choco install ampfontviewer
choco install babelmap
choco install babelpad

# Fonts

choco install anonymouspro
choco install bitstreamverafonts
choco install cascadiacode
choco install cascadiacodeitalic
choco install cascadiamono
choco install cascadiamonoitalic
choco install croscorefonts-font
choco install croscorefonts-caladea-font
choco install dejavufonts
choco install DroidFonts
choco install fantasque-sans.font
choco install hackfont
choco install inconsolata
choco install lato
choco install liberationfonts
choco install opensans
choco install oxygenmono
choco install roboto.font
choco install SourceCodePro
choco install --allow-empty-checksums ubuntu.font

# Networking/Internet

choco install curl
choco install filezilla
choco install Firefox
choco install putty
choco install Wget
choco install winscp
choco install yarn

# Security

choco install ccleaner
choco install ccenhancer
choco install keepass
choco install keepassxc

# Graphics

choco install ghostwriter
choco install gimp
choco install inkscape
choco install imagemagick
choco install --allow-empty-checksums paint.net

# Multimedia

choco install audacity
choco install audacity-ffmpeg
choco install audacity-lame
choco install ffmpeg
choco install spotify
choco install vlc
choco install youtube-dl

# Cloud

choco install box-drive
choco install dropbox
choco install googledrive
choco install megasync
choco install rclone

# Other

choco install gramps

Update-SessionEnvironment
