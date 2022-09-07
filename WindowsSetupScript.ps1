# Variables
$caskaydiaDir = ""
$caskaydiaUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip"
$caskaydiaZipDir = "CascadiaCode.zip"
$configDir = "$downloadDir\ConfigFiles"
$configUrl = "https://github.com/cquick00/ConfigFiles.git"
$desktopDir = "~\Desktop"
$documentDir = "~\Documents"
$downloadDir = "~\Downloads"
$fontExists = $false
$fontName = ""
$fonts = Get-ChildItem $caskaydiaDir | Where-Object -Property Name -Like "*Windows Compatible*"
$fontsDir = (New-Object -ComObject Shell.Application).Namespace(0x14)
$isInstalled = $false
$localAppDataDir = "~\AppData\Local"
$powershellConfig = "$configDir\PowerShell\powershell.config.json"
$powershellConfigDir = "~\Documents\PowerShell"
$powershellConfigDirExists = $false
$powershellProfileConfig = "$configDir\PowerShell\Microsoft.PowerShell_profile.ps1"
$scriptDir = "$downloadDir\WindowsSetupScript-main\WindowsSetupScript-main"
$starshipConfig = "$configDir\Starship\starship.toml"
$starshipConfigDir = "~\.config"
$userInput = ""
$wingetConfig = "$configDir\Winget\settings.json"
$wingetConfigDir = "$localAppDataDir\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState"


########## INTRODUCTION ##########

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


    ########## CHOCOLATEY ##########
    Write-Host "`n########## CHOCOLATEY ##########" -ForegroundColor Green

    # Check if Chocolatey is installed already
    Write-Host "Checking to see if Chocolatey is installed."

    if (choco -v) {
        $isInstalled = $true
    }

    if ($isInstalled -eq $false) {
        Write-Host "Chocolatey was not installed. Downloading and installing now."

        # Install
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) | Out-Null
    }


    ########## WINGET ##########
    Write-Host "`n########## WINGET ##########" -ForegroundColor Green

    # Check if Winget is installed already
    Write-Host "Checking to see if Winget is installed."
    $isInstalled = $false

    if (winget -v) {
        $isInstalled = $true
    }

    if ($isInstalled -eq $false) {
        Write-Host "Winget was not installed. Downloading and installing now."

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
            Write-Host "Winget not found, installing it now."
            Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
            $nid = (Get-Process AppInstaller).Id
            Wait-Process -Id $nid
            Write-Host "Winget Installed"
        }
        refreshenv
    }

    # Install programs
    Write-Host "Winget is now installed."
    Write-Host "Now installing programs via Winget."
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


    ########## SCOOP ##########
    Write-Host "`n########## SCOOP ##########" -ForegroundColor Green

    # Check if Scoop is installed already
    Write-Host "Checking to see if Scoop is installed."
    $isInstalled = $false

    if (scoop -v) {
        $isInstalled = $true
    }

    if ($isInstalled -eq $false) {
        Write-Host "Scoop was not installed. Downloading and installing now."

        # Install
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
        Invoke-RestMethod get.scoop.sh | Invoke-Expression -RunAsAdmin
    }

    # Refresh PowerShell so that Git works for adding buckets to Scoop
    Write-Host "Refreshing the environment so that Git is available for the Scoop Section."
    refreshenv

    # Add buckets
    Write-Host "Scoop is now installed."
    Write-Host "Now adding buckets and installing programs via Scoop."
    scoop bucket add main
    scoop bucket add extras

    # Install programs
    scoop install ghostwriter hugo nano neofetch


    ########## CONFIGS ##########
    Write-Host "`n########## CONFIGS ##########" -ForegroundColor Green

    # Git clone repo
    Write-Host "Downloading the config files from GitHub."
    git clone $configUrl

    # Check for PowerShell Config Directory
    Write-Host "Checking for the PowerShell Config Directory and creating it if it doesn't exist."
    $powershellConfigDirExists = Test-Path -Path $powershellConfigDir

    if ($powershellConfigDirExists -eq $false) {
        New-Item -Name PowerShell -Path $documentDir -ItemType Directory
    }
    

    # Move files to correct location
    Write-Host "Moving config files to their correct locations."
    Copy-Item $powershellProfileConfig -Destination $powershellConfigDir
    Copy-Item $powershellConfig -Destination $powershellConfigDir
    Copy-Item $starshipConfig -Destination $starshipConfigDir
    Copy-Item $wingetConfig -Destination $wingetConfigDir


    ########## FONT ##########
    Write-Host "`n########## FONT ##########" -ForegroundColor Green

    # Download Caskaydia Cove NF
    Write-Host "Downloading, extracting, and installing the Caskaydia Cove Font from Nerd Fonts."
    Invoke-WebRequest -Uri $caskaydiaUrl -OutFile $caskaydiaZipDir
    $caskaydiaDir = "$downloadDir\CascadiaCode"

    # Extract Caskaydia Cove NF
    Expand-Archive -Path $caskaydiaZipDir -DestinationPath $caskaydiaDir

    # Install all Windows Compatible versions in the downloaded folder
    foreach ($font in $fonts) {
        $fontName = $font.Name
        $fontExists = Test-Path -Path $fontsDir\$fontName

        if ($fontExists -eq $false) {
            Get-ChildItem $font | ForEach-Object { $fontsDir.CopyHere($_.FullName) }
        }
    }


    ##### CLEANUP #####
    Write-Host "`n########## CLEANUP ##########" -ForegroundColor Green

    # Delete desktop icons
    Get-ChildItem $desktopDir -Exclude $scriptDir | Remove-Item -Force -Recurse

    # Delete downloads
    Get-ChildItem $downloadDir | Remove-Item -Force -Recurse

    # Clear the recycle bin
    Clear-RecycleBin -Force

    ##### NOTES #####

    # Tell User to change their default font in PowerShell to Caskaydia Cove NF
    Write-Host "As it is currently not possible to set this with a PowerShell Command, please change your default font in PowerShell to Caskaydia Cove NF."

}

elseif ($userInput.ToLower() -eq "n") {
    Write-Host "`nYou decided to not run the script. No Problem! If you'd like to use it at a later date, just run it again!" -ForegroundColor Red
}

else {
    Write-Host "`nInvalid input. Starting the script over again!`n" -ForegroundColor Yellow
    .\"WindowsSetupScript.ps1"
}
