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
$scriptDir = "$downloadDir\WindowsSetupScript-main"
$starshipConfig = "$configDir\Starship\starship.toml"
$starshipConfigDir = "~\.config"
$wingetConfig = "$configDir\Winget\settings.json"
$wingetConfigDir = "$localAppDataDir\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState"


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
        Invoke-RestMethod get.scoop.sh | Invoke-Expression

    }

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

    # Delete desktop icons
    Get-ChildItem $desktopDir -Exclude $scriptDir | Remove-Item -Force -Recurse

    # Delete downloads
    Get-ChildItem $downloadDir | Remove-Item -Force -Recurse

    # Clear the recycle bin
    Clear-RecycleBin -Force

    ##### NOTES #####

    # Tell User to change their default font in PowerShell to Caskaydia Cove NF
    Write-Host "As it is currently not possible to set this with a PowerShell Command, please change your default font in PowerShell to Caskaydia Cove NF."
