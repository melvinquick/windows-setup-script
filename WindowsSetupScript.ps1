# =============================================
# VARIABLES
# =============================================
#region
# URLs
$confUrl = "https://github.com/cquick00/ConfigFiles.git"

# App Install Lists
$chocolateyApps = @("cascadia-code-nerd-font")
$wingetApps = @("7zip.7zip", "Alacritty.Alacritty", "Amazon.Games", "Lexikos.AutoHotkey", "Balena.Etcher", "Brave.Brave", "Discord.Discord", "ElectronicArts.EADesktop", "File-New-Project.EarTrumpet", "EpicGames.EpicGamesLauncher", "GIMP.GIMP", "Git.Git", "GitHub.GitHubDesktop", "Google.Drive", "Inkscape.Inkscape", "Joplin.Joplin", "KDE.Kdenlive", "GuinpinSoft.MakeMKV", "JeffreyPfau.mGBA", "Microsoft.VCRedist.2015+.x64", "Microsoft.VCRedist.2015+.x86", "dangeredwolf.ModernDeck", "winget install -e --id OpenJS.NodeJS", "Microsoft.PowerShell", "Python.Python.3", "Rustlang.Rustup", "Starship.Starship", "Valve.Steam", "Streamlabs.Streamlabs", "VideoLAN.VLC", "Microsoft.VisualStudioCode")
$scoopApps = @("ghostwriter", "hugo", "nano", "neofetch", "sysinternals", "tldr")
$scoopBaseApps = @("7zip", "git")
$scoopBuckets = @("extras")
$psModules = @("PSWindowsUpdate")

# System/User Directories
$appDataDir = "~\AppData"
$confDir = "~\Downloads\ConfigFiles"
$desktopDir = "~\Desktop"
$documentDir = "~\Documents"
$dotConfDir = "~\.config"
$downloadDir = "~\Downloads"
$localAppDataDir = "~\AppData\Local"
$publicDesktopDir = "C:\Users\Public\Desktop"
$tempDir = "~\AppData\Local\Temp"

# App Directories
$betterDiscordDir = "$appDataDir\BetterDiscord"
$scoopDir = "~\scoop"

# Config Destinations
$alacrittyConfDest = "$appDataDir\Alacritty"
$betterDiscordPluginDest = "$betterDiscordDir\plugins"
$betterDiscordThemeDest = "$betterDiscordDir\themes"
$ghostwriterThemeDest = "$scoopDir\apps\ghostwriter\current\data\themes"
$powershellConfDest = "$documentDir\PowerShell"
$wingetConfDest = "$localAppDataDir\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState"

# Configs
$alacrittyConf = "$confDir\Alacritty\alacritty.yml"
$alacrittyDraculaThemeConf = "$confDir\Alacritty\dracula.yml"
$betterDiscordBdfdbPlugin = "$confDir\BetterDiscord\Plugins\0BDFDB.plugin.js"
$betterDiscordDraculaThemeConf = "$confDir\BetterDiscord\Themes\Dracula.theme.css"
$betterDiscordSpellCheckPlugin = "$confDir\BetterDiscord\Plugins\SpellCheck.plugin.js"
$ghostwriterThemeConf = "$confDir\Ghostwriter\Dracula.json"
$powershellBannerKingKairos = "$confDir\PowerShell\kingkairos.txt"
$powershellJsonConf = "$confDir\PowerShell\powershell.config.json"
$powershellProfileConf = "$confDir\PowerShell\Microsoft.PowerShell_profile.ps1"
$starshipConf = "$confDir\Starship\starship.toml"
$wingetConf = "$confDir\Winget\settings.json"

# Miscellaneous
$userInput = ""
$sleepTime = 5
#endRegion

# =============================================
# FUNCTIONS
# =============================================
#region
# Chocolatey
function Install-Chocolatey {
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) | Out-Null
    Write-Host "Chocolatey has been installed."
}

# Winget (I took this section from Chris Titus Tech's WinUtil located here: https://github.com/ChrisTitusTech/winutil/blob/main/winutil.ps1) and modified it VERY slightly, so shoutout to him!)
function Install-Winget {
    # Gets the computer's information
    $ComputerInfo = Get-ComputerInfo

    # Gets the Windows Edition
    if ($ComputerInfo.OSName) {
        $OSName = $ComputerInfo.OSName
    }

    else {
        $OSName = $ComputerInfo.WindowsProductName
    }

    # Determines how to go about installing Winget based on the Windows Edition found
    if (((($OSName.IndexOf("LTSC")) -ne -1) -or ($OSName.IndexOf("Server") -ne -1)) -and (($ComputerInfo.WindowsVersion) -ge "1809")) {
        
        Write-Host "Running Alternative Installer for LTSC/Server Editions.."

        # Switching to winget-install from PSGallery from asheroto
        # Source: https://github.com/asheroto/winget-installer
        
        Start-Process powershell.exe -Verb RunAs -ArgumentList "-command irm https://raw.githubusercontent.com/asheroto/winget-installer/master/winget-install.ps1 | iex | Out-Host" -WindowStyle Normal
        
    }

    elseif (((Get-ComputerInfo).WindowsVersion) -lt "1809") {
        # Checks if Windows Version is too old for winget
        Write-Host "Winget is not supported on this version of Windows (Pre-1809)."
    }

    else {
        # Installing Winget from the Microsoft Store
        Write-Host "Winget not found, installing it now..."
        Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
        $nid = (Get-Process AppInstaller).Id
        Wait-Process -Id $nid
        Write-Host "Winget Installed."
    }
}

# Scoop
function Install-Scoop {
    Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"    
}
#endRegion

# =============================================
# INTRODUCTION
# =============================================
#region
Write-Host "`n=============================================" -ForegroundColor Green
Write-Host "INTRODUCTION" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green

# Let user know that running scripts they find online can be dangerous and that they should proceed with caution
Write-Host "`nDISCLAIMER: NEVER RUN SCRIPTS YOU FIND ON THE INTERNET BEFORE FIRST READING THROUGH THEM!" -ForegroundColor Red
Write-Host "`nWelcome to your new Windows Setup Script!" -ForegroundColor Green
Write-Host "`nThis script downloads and installs programs, moves my configs for various programs to their correct locations, and a few other things."
Write-Host "Please read through the script BEFORE executing it to make sure it doesn't do anything you don't want it to!"
$userInput = Read-Host "Would you like to run the setup? (y/n)"
#endRegion

# =============================================
# MAIN
# =============================================
#region
Write-Host "`n=============================================" -ForegroundColor Green
Write-Host "MAIN" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green

if ($userInput.ToLower() -eq "y") {

    # Set working directory for script
    Write-Host "`nSetting the working directory for the script."
    Set-Location $downloadDir

    # =============================================
    # CHOCOLATEY
    # =============================================
    #region  
    Write-Host "`n=============================================" -ForegroundColor Green
    Write-Host "CHOCOLATEY" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    # Check if Chocolatey is installed already
    Write-Host "`nChecking to see if Chocolatey is installed..."

    if (Test-Path -Path "C:\ProgramData\chocolatey\choco.exe") {
        Write-Host "Chocolatey is already installed."
    }

    else {
        Write-Host "Chocolatey was not installed. Downloading and installing now..."
        Install-Chocolatey
    }

    # Install Apps with Chocolatey
    foreach ($chocolateyApp in $chocolateyApps) {
        choco install $chocolateyApp --yes --acceptlicense
    }
    #endRegion   

    # =============================================
    # WINGET
    # =============================================
    #region  
    Write-Host "`n=============================================" -ForegroundColor Green
    Write-Host "WINGET" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    # Check if Winget is installed already and install it if not
    Write-Host "`nChecking if Winget is Installed..."

    if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe) {
        # Checks if Winget executable exists and if the Windows Version is 1809 or higher
        Write-Host "Winget Already Installed."
    }
    else {
        Install-Winget
        Start-Sleep -Seconds $sleepTime
    }

    Write-Host "Installing programs via Winget..."

    # Install apps with Winget
    foreach ($wingetApp in $wingetApps) {
        winget install -e --id $wingetApp --silent --accept-package-agreements --accept-source-agreements
    }
    #endRegion

    # =============================================
    # SCOOP
    # =============================================
    #region
    Write-Host "`n=============================================" -ForegroundColor Green
    Write-Host "SCOOP" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    # Check if Scoop is installed already
    Write-Host "`nChecking to see if Scoop is installed..."

    if (Test-Path -Path "$scoopDir\apps\scoop\current\bin\scoop.ps1") {
        Write-Host "Scoop is already installed."
    }

    else {
        Write-Host "Scoop was not installed. Downloading and installing now..."
        Install-Scoop
    }

    # Install base apps for Scoop
    foreach ($scoopBaseApp in $scoopBaseApps) {
        scoop install $scoopBaseApp
    }

    # Add buckets for Scoop Apps you want to install
    foreach ($scoopBucket in $scoopBuckets) {
        scoop bucket add $scoopBucket
    }

    # Install apps with Scoop
    foreach ($scoopApp in $scoopApps) {
        scoop install $scoopApp
    }
    #endRegion

    # =============================================
    # CONFIGS
    # =============================================
    #region
    Write-Host "`n=============================================" -ForegroundColor Green
    Write-Host "CONFIGS" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    # Git clone repo
    Write-Host "`nDownloading the config files from GitHub..."
    git clone $confUrl --quiet

    # Check for Alacritty Config Directory
    Write-Host "`nChecking for the Alacritty Config Directory and creating it if it doesn't exist..."
    if ((Test-Path -Path $alacrittyConfDest) -eq $false) {
        New-Item -Path $alacrittyConfDest -ItemType Directory | Out-Null
    }

    # Check for BetterDiscord Plugin Directory
    Write-Host "Checking for the BetterDiscord Plugin Directory and creating it if it doesn't exist..."
    if ((Test-Path -Path $betterDiscordPluginDest) -eq $false) {
        New-Item -Path $betterDiscordPluginDest -ItemType Directory | Out-Null
    }

    # Check for BetterDiscord Theme Directory
    Write-Host "Checking for the BetterDiscord Theme Directory and creating it if it doesn't exist..."
    if ((Test-Path -Path $betterDiscordThemeDest) -eq $false) {
        New-Item -Path $betterDiscordThemeDest -ItemType Directory | Out-Null
    }

    # Check for Ghostwriter Config Directory
    Write-Host "Checking for the Ghostwriter Theme Directory and creating it if it doesn't exist..."
    if ((Test-Path -Path $ghostwriterThemeDest) -eq $false) {
        New-Item -Path $ghostwriterThemeDest -ItemType Directory | Out-Null
    }

    # Check for PowerShell Config Directory
    Write-Host "Checking for the PowerShell Config Directory and creating it if it doesn't exist..."
    if ((Test-Path -Path $powershellConfDest) -eq $false) {
        New-Item -Path $powershellConfDest -ItemType Directory | Out-Null
    }

    # Check for Winget Config Directory
    Write-Host "Checking for the Winget Config Directory and creating it if it doesn't exist..."
    if ((Test-Path -Path $wingetConfDest) -eq $false) {
        New-Item -Path $wingetConfDest -ItemType Directory | Out-Null
    }

    # Move files to correct location
    Write-Host "`nMoving config files to their correct locations..."
    Copy-Item $alacrittyConf -Destination $alacrittyConfDest
    Copy-Item $alacrittyDraculaThemeConf -Destination $alacrittyConfDest
    Copy-Item $betterDiscordBdfdbPlugin -Destination $betterDiscordPluginDest
    Copy-Item $betterDiscordDraculaThemeConf -Destination $betterDiscordThemeDest
    Copy-Item $betterDiscordSpellCheckPlugin -Destination $betterDiscordPluginDest
    Copy-Item $ghostwriterThemeConf -Destination $ghostwriterThemeDest
    Copy-Item $powershellBannerKingKairos -Destination $powershellConfDest
    Copy-Item $powershellJsonConf -Destination $powershellConfDest
    Copy-Item $powershellProfileConf -Destination $powershellConfDest
    Copy-Item $starshipConf -Destination $dotConfDir
    Copy-Item $wingetConf -Destination $wingetConfDest
    #endRegion

    # =============================================
    # POWERSHELL MODULES
    # =============================================
    #region
    Write-Host "`n=============================================" -ForegroundColor Green
    Write-Host "PowerShell Modules" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    # Set PSGallery as Trusted Repository
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

    # Install PowerShell Modules
    foreach ($psModule in $psModules) {
        Install-Module $psModule
    }
    #endRegion

    # =============================================
    # CLEANUP
    # =============================================
    #region
    Write-Host "`n=============================================" -ForegroundColor Green
    Write-Host "CLEANUP" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    # Delete desktop icons
    Write-Host "`nDeleting Desktop Icons that were created from program installs..."
    Get-ChildItem $desktopDir | Remove-Item -Force -Recurse
    Get-ChildItem $publicDesktopDir | Remove-Item -Force -Recurse

    # Delete temp folder files that were created during the process of running this script
    Write-Host "Deleting temp files that were created in the process of running this script..."
    Get-ChildItem $tempDir | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

    # Clear the recycle bin
    Write-Host "Emptying the Recycle Bin..."
    Clear-RecycleBin -Force
    #endRegion
}

elseif ($userInput.ToLower() -eq "n") {
    Write-Host "`nYou decided to not run the script. No Problem! If you'd like to use it at a later date, just run it again!" -ForegroundColor Red
}

else {
    Write-Host "`nInvalid input. Starting the script over again!`n" -ForegroundColor Yellow
    .\"WindowsSetupScript.ps1"
}
#endRegion
