# --- Variables --- #
#region
# URLs
$conf_url = "https://github.com/cquick00/windows-config-files.git"

# App Install Lists
$chocolatey_apps = @("cascadia-code-nerd-font")
$ps_modules = @("PSWindowsUpdate", "PSWordCloud")
$scoop_apps_base = @("7zip", "git")
$scoop_apps_main = @("android-messages", "ghostwriter", "nano", "neofetch", "sysinternals")
$scoop_buckets = @("extras")
$winget_apps = @("7zip.7zip", "Alacritty.Alacritty", "Amazon.Games", "BleachBit.BleachBit", "Discord.Discord", "ElectronicArts.EADesktop", "File-New-Project.EarTrumpet", "Elgato.4KCaptureUtility", "EpicGames.EpicGamesLauncher", "Epilogue.EpilogueOperator", "GIMP.GIMP", "Git.Git", "GitHub.GitHubDesktop", "Google.Drive", "Inkscape.Inkscape", "KDE.Kdenlive", "GuinpinSoft.MakeMKV", "JeffreyPfau.mGBA", "Microsoft.VCRedist.2015+.x64", "Microsoft.VCRedist.2015+.x86", "Mozilla.Firefox", "mRemoteNG.mRemoteNG", "Microsoft.PowerShell", "Python.Python.3.11", "qBittorrent.qBittorrent", "RevoUninstaller.RevoUninstaller", "NickeManarin.ScreenToGif", "Starship.Starship", "Valve.Steam", "Ubisoft.Connect", "VideoLAN.VLC", "NexusMods.Vortex", "Microsoft.VisualStudioCode", "WinSCP.WinSCP")

# System/User Directories
$conf_dir = "$HOME\Downloads\windows-config-files\home"
$working_dir = "$HOME\Downloads"

# Miscellaneous
$user_input = ""
$sleep_time = 5
#endRegion

# --- Functions --- #
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
    $computer_info = Get-computer_info

    # Gets the Windows Edition
    if ($computer_info.os_name) {
        $os_name = $computer_info.os_name
    }

    else {
        $os_name = $computer_info.WindowsProductName
    }

    # Determines how to go about installing Winget based on the Windows Edition found
    if (((($os_name.IndexOf("LTSC")) -ne -1) -or ($os_name.IndexOf("Server") -ne -1)) -and (($computer_info.WindowsVersion) -ge "1809")) {
        
        Write-Host "Running Alternative Installer for LTSC/Server Editions.."

        # Switching to winget-install from PSGallery from asheroto
        # Source: https://github.com/asheroto/winget-installer
        
        Start-Process powershell.exe -Verb RunAs -ArgumentList "-command irm https://raw.githubusercontent.com/asheroto/winget-installer/master/winget-install.ps1 | iex | Out-Host" -WindowStyle Normal
        
    }

    elseif (((Get-computer_info).WindowsVersion) -lt "1809") {
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

# --- Introduction --- #
#region
Write-Host "# --- Introduction --- #" -ForegroundColor Green

# Let user know that running scripts they find online can be dangerous and that they should proceed with caution
Write-Host "`nDISCLAIMER: NEVER RUN SCRIPTS YOU FIND ON THE INTERNET BEFORE FIRST READING THROUGH THEM!" -ForegroundColor Red
Write-Host "`nWelcome to your new Windows Setup Script!" -ForegroundColor Green
Write-Host "`nThis script downloads and installs programs, moves my configs for various programs to their correct locations, and a few other things."
Write-Host "Please read through the script BEFORE executing it to make sure it doesn't do anything you don't want it to!"
$user_input = Read-Host "Would you like to run the setup? (y/n)"
#endRegion

# --- Main --- #
#region
Write-Host "`n# --- Main --- #" -ForegroundColor Green

if ($user_input.ToLower() -eq "y") {

    # Set working directory for script
    Write-Host "`nSetting the working directory for the script."
    Set-Location -Path $working_dir

    # --- Chocolatey --- #
    #region  
    Write-Host "`n# --- Chocolatey --- #" -ForegroundColor Green

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
    foreach ($chocolatey_app in $chocolatey_apps) {
        choco install $chocolatey_app --yes --acceptlicense
    }
    #endRegion   

    # --- Winget --- #
    #region  
    Write-Host "`n# --- Winget --- #" -ForegroundColor Green

    # Check if Winget is installed already and install it if not
    Write-Host "`nChecking if Winget is Installed..."

    if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe) {
        # Checks if Winget executable exists and if the Windows Version is 1809 or higher
        Write-Host "Winget Already Installed."
    }
    else {
        Install-Winget
        Start-Sleep -Seconds $sleep_time
    }

    Write-Host "Installing programs via Winget..."

    # Install apps with Winget
    foreach ($winget_app in $winget_apps) {
        winget install -e --id $winget_app --silent --accept-package-agreements --accept-source-agreements
    }
    #endRegion

    # --- Scoop --- #
    #region
    Write-Host "`n# --- Scoop --- #" -ForegroundColor Green

    # Check if Scoop is installed already
    Write-Host "`nChecking to see if Scoop is installed..."

    if (Test-Path -Path "$HOME\scoop\apps\scoop\current\bin\scoop.ps1") {
        Write-Host "Scoop is already installed."
    }

    else {
        Write-Host "Scoop was not installed. Downloading and installing now..."
        Install-Scoop
    }

    # Install base apps for Scoop
    foreach ($scoop_app in $scoop_apps_base) {
        scoop install $scoop_base_app
    }

    # Add buckets for Scoop Apps you want to install
    foreach ($scoop_bucket in $scoop_buckets) {
        scoop bucket add $scoop_bucket
    }

    # Install apps with Scoop
    foreach ($scoop_app in $scoop_apps_main) {
        scoop install $scoop_app
    }
    #endRegion

    # --- Configs --- #
    #region
    Write-Host "`n# --- Configs --- #" -ForegroundColor Green

    # Git clone repo
    Write-Host "`nDownloading the config files from GitHub..."
    git clone $conf_url --quiet

    # Copy all configs to their correct locations
    Write-Host "`nMoving all config files to their correct locations..."

    # Set location to the correct directory and get the file paths for each config
    Set-Location -Path $conf_dir
    $base_path = Resolve-Path .
    $file_paths = Get-ChildItem -LiteralPath $conf_dir -File -Recurse | ForEach-Object { (Join-Path ((Split-Path $_.FullName -Parent) -replace "^\\","") $_.Name) -replace ("^{0}\\?" -f [regex]::Escape($base_path)), "" }

    # Move each config to the correct location
    foreach($file in $file_paths){
        $destination = "$HOME\$file"
        if ((Test-Path -Path $destination) -eq $false) {
            New-Item -Path $destination -Force
        }
        Copy-Item -Path $file -Destination $destination -Force
    }
    #endRegion

    # --- PowerShell Modules --- #
    #region
    Write-Host "`n# --- PowerShell Modules --- #" -ForegroundColor Green

    # Set the directory back to the working directory
    Set-Location -Path $working_dir

    # Set PSGallery as Trusted Repository
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

    # Install PowerShell Modules
    foreach ($psModule in $ps_modules) {
        Install-Module $psModule
    }
    #endRegion

    # --- Cleanup --- #
    #region
    Write-Host "`n# --- Cleanup --- #" -ForegroundColor Green

    # Delete desktop icons and temp folder files that were created during the process of running this script
    Write-Host "`nDeleting Desktop Icons and Temp Files that were created from program installs..."
    Get-ChildItem -Path "$HOME\Desktop" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    Get-ChildItem -Path "C:\Users\Public\Desktop" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    Get-ChildItem -Path "$HOME\AppData\Local\Temp" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    Get-ChildItem -Path $working_dir | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

    # Clear the recycle bin
    Write-Host "Emptying the Recycle Bin..."
    Clear-RecycleBin -Force
    #endRegion
}

elseif ($user_input.ToLower() -eq "n") {
    Write-Host "`nYou decided to not run the script. No Problem! If you'd like to use it at a later date, just run it again!" -ForegroundColor Red
}

else {
    Write-Host "`nInvalid input. Starting the script over again!`n" -ForegroundColor Yellow
    .\"windows-setup-script.ps1"
}
#endRegion
