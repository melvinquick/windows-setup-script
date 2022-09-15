# =============================================
# VARIABLES
# =============================================

# URLs
$configUrl = "https://github.com/cquick00/ConfigFiles.git"

# System Directories
$dotConfigDir = "~\.config"
$desktopDir = "~\Desktop"
$documentDir = "~\Documents"
$downloadDir = "~\Downloads"
$localAppDataDir = "~\AppData\Local"

# Miscellaneous
$isInstalled = $false
$userInput = ""


# =============================================
# INTRODUCTION
# =============================================

Write-Host "`n=============================================" -ForegroundColor Green
Write-Host "INTRODUCTION" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green

# Main
Write-Host "`nDISCLAIMER: NEVER RUN SCRIPTS YOU FIND ON THE INTERNET BEFORE FIRST READING THROUGH THEM!`n" -ForegroundColor Red
Write-Host "Welcome to your new Windows Setup Script!" -ForegroundColor Green
Write-Host "`nThis script downloads and installs programs, moves my configs for various programs to their correct locations, and a few other things."
Write-Host "Please read through the script BEFORE executing it to make sure it doesn't do anything you don't want it to!"
$userInput = Read-Host "Would you like to run the setup? (y/n)"

if ($userInput.ToLower() -eq "y") {

    # Set working directory for script
    Write-Host "`nSetting the working directory for the script."
    Set-Location $downloadDir


    # =============================================
    # CHOCOLATEY
    # =============================================

    Write-Host "`n=============================================" -ForegroundColor Green
    Write-Host "CHOCOLATEY" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    # Check if Chocolatey is installed already
    Write-Host "`nChecking to see if Chocolatey is installed.`n"

    if (choco -v) {
        $isInstalled = $true
    }

    if ($isInstalled -eq $false) {
        Write-Host "`nChocolatey was not installed. Downloading and installing now.`n"

        # Install
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) | Out-Null
    }

    # Install Caskaydia Cove Nerd Font
    choco install cascadia-code-nerd-font


    # =============================================
    # WINGET
    # =============================================

    Write-Host "`n=============================================" -ForegroundColor Green
    Write-Host "WINGET" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    # Check if Winget is installed already and install it if not (I took this section from Chris Titus Tech's WinUtil located here: https://github.com/ChrisTitusTech/winutil/blob/main/winutil.ps1), so shoutout to him!
    if (((((Get-ComputerInfo).OSName.IndexOf("LTSC")) -ne -1) -or ((Get-ComputerInfo).OSName.IndexOf("Server") -ne -1)) -and (((Get-ComputerInfo).WindowsVersion) -ge "1809")) {
        #Checks if Windows edition is LTSC/Server 2019+
        #Manually Installing Winget
        Write-Host "Running Alternative Installer for LTSC/Server Editions"

        #Download Needed Files
        Write-Host "Downloading Needed Files..."
        Start-BitsTransfer -Source "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" -Destination "./Microsoft.VCLibs.x64.14.00.Desktop.appx"
        Start-BitsTransfer -Source "https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -Destination "./Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
        Start-BitsTransfer -Source "https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/b0a0692da1034339b76dce1c298a1e42_License1.xml" -Destination "./b0a0692da1034339b76dce1c298a1e42_License1.xml"

        #Installing Packages
        Write-Host "Installing Packages..."
        Add-AppxProvisionedPackage -Online -PackagePath ".\Microsoft.VCLibs.x64.14.00.Desktop.appx" -SkipLicense
        Add-AppxProvisionedPackage -Online -PackagePath ".\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -LicensePath ".\b0a0692da1034339b76dce1c298a1e42_License1.xml"
        Write-Host "winget Installed (Reboot might be required before winget will work)"

        #Sleep for 5 seconds to maximize chance that winget will work without reboot
        Write-Host "Pausing for 5 seconds to maximize chance that winget will work without reboot"
        Start-Sleep -s 5

        #Removing no longer needed Files
        Write-Host "Removing no longer needed Files..."
        Remove-Item -Path ".\Microsoft.VCLibs.x64.14.00.Desktop.appx" -Force
        Remove-Item -Path ".\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -Force
        Remove-Item -Path ".\b0a0692da1034339b76dce1c298a1e42_License1.xml" -Force
        Write-Host "Removed Files that are no longer needed"
    }
    elseif (((Get-ComputerInfo).WindowsVersion) -lt "1809") {
        #Checks if Windows Version is too old for winget
        Write-Host "Winget is not supported on this version of Windows (Pre-1809)"
    }
    else {
        #Installing Winget from the Microsoft Store
        Write-Host "`nWinget not found, installing it now."
        Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
        $nid = (Get-Process AppInstaller).Id
        Wait-Process -Id $nid
        Start-Sleep -s 5
        Write-Host "Winget Installed"
    }

    # Install programs
    Write-Host "Now installing programs via Winget.`n"
    winget install -e --id 7zip.7zip
    winget install -e --id Amazon.Games
    winget install -e --id Lexikos.AutoHotkey
    winget install -e --id BraveSoftware.BraveBrowser
    winget install -e --id Discord.Discord
    winget install -e --id ElectronicArts.EADesktop
    winget install -e --id File-New-Project.EarTrumpet
    winget install -e --id EpicGames.EpicGamesLauncher
    winget install -e --id GIMP.GIMP
    winget install -e --id Git.Git
    winget install -e --id GitHub.GitHubDesktop
    winget install -e --id Google.Drive
    winget install -e --id Inkscape.Inkscape
    winget install -e --id Joplin.Joplin
    winget install -e --id KDE.Kdenlive
    winget install -e --id GuinpinSoft.MakeMKV
    winget install -e --id JeffreyPfau.mGBA
    winget install -e --id dangeredwolf.ModernDeck
    winget install -e --id Microsoft.PowerShell
    winget install -e --id Python.Python.3
    winget install -e --id Starship.Starship
    winget install -e --id Valve.Steam
    winget install -e --id Streamlabs.Streamlabs
    winget install -e --id Ubisoft.Connect
    winget install -e --id VideoLAN.VLC
    winget install -e --id Microsoft.VisualStudioCode


    # =============================================
    # SCOOP
    # =============================================

    Write-Host "`n=============================================" -ForegroundColor Green
    Write-Host "SCOOP" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    # Check if Scoop is installed already
    Write-Host "`nChecking to see if Scoop is installed.`n"
    $isInstalled = $false

    if (scoop -v) {
        $isInstalled = $true
    }

    if ($isInstalled -eq $false) {
        Write-Host "`nScoop was not installed. Downloading and installing now.`n"

        # Install
        Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"
        Write-Host "`nScoop is now installed.`n"
    }

    # Install 7zip and Git for bucket adding
    scoop install 7zip git

    # Add buckets
    Write-Host "`nNow adding buckets and installing programs via Scoop.`n"
    scoop bucket add main
    scoop bucket add extras

    # Install programs
    scoop install ghostwriter hugo nano neofetch


    # =============================================
    # CONFIGS
    # =============================================

    Write-Host "`n=============================================" -ForegroundColor Green
    Write-Host "CONFIGS" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    # Git clone repo
    Write-Host "`nDownloading the config files from GitHub.`n"
    git clone $configUrl

    # Directories
    $configDir = "$downloadDir\ConfigFiles"

    # Destinations
    $powershellConfigDest = "$documentDir\PowerShell"
    $wingetConfigDest = "$localAppDataDir\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState"

    # Check for PowerShell Config Directory
    Write-Host "`nChecking for the PowerShell Config Directory and creating it if it doesn't exist."
    $powershellConfigDestExists = Test-Path -Path $powershellConfigDest

    if ($powershellConfigDestExists -eq $false) {
        New-Item -Path $powershellConfigDest -ItemType Directory
    }
    
    # Configs
    $powershellBannerConfig = "$configDir\PowerShell\banner.txt"
    $powershellJsonConfig = "$configDir\PowerShell\powershell.config.json"
    $powershellProfileConfig = "$configDir\PowerShell\Microsoft.PowerShell_profile.ps1"
    $starshipConfig = "$configDir\Starship\starship.toml"
    $wingetConfig = "$configDir\Winget\settings.json"

    # Move files to correct location
    Write-Host "`nMoving config files to their correct locations."
    Copy-Item $powershellBannerConfig -Destination $powershellConfigDest
    Copy-Item $powershellJsonConfig -Destination $powershellConfigDest
    Copy-Item $powershellProfileConfig -Destination $powershellConfigDest
    Copy-Item $starshipConfig -Destination $dotConfigDir
    Copy-Item $wingetConfig -Destination $wingetConfigDest


    # =============================================
    # CLEANUP
    # =============================================

    Write-Host "`n=============================================" -ForegroundColor Green
    Write-Host "CLEANUP" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    # Delete desktop icons
    Write-Host "`nDeleting Desktop Icons that were created from program installs."
    Get-ChildItem $desktopDir | Remove-Item -Force -Recurse

    # Clear the recycle bin
    Write-Host "Emptying the Recycle Bin."
    Clear-RecycleBin -Force

    # =============================================
    # NOTES
    # =============================================

    Write-Host "`n=============================================" -ForegroundColor Green
    Write-Host "NOTES" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    # Tell user to change install the font and make it their default font in PowerShell"
    Write-Host "`nPlease change your default font in PowerShell to CaskaydiaCove Nerd Font."

}

elseif ($userInput.ToLower() -eq "n") {
    Write-Host "`nYou decided to not run the script. No Problem! If you'd like to use it at a later date, just run it again!" -ForegroundColor Red
}

else {
    Write-Host "`nInvalid input. Starting the script over again!`n" -ForegroundColor Yellow
    .\"WindowsSetupScript.ps1"
}
