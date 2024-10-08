# * Imports
Import-Module "$PSScriptRoot\app-install-helpers\chocolatey-install.psm1"
Import-Module "$PSScriptRoot\app-install-helpers\winget-install.psm1"
Import-Module "$PSScriptRoot\app-install-helpers\scoop-install.psm1"
Import-Module "$PSScriptRoot\app-install-helpers\python-poetry.ps1"

# * Variables

# URLs
$conf_url = "https://github.com/melvinquick/windows-config-files.git"

# App Install Lists
$chocolatey_apps = Get-Content -Path "$PSScriptRoot\app-install-lists\chocolatey-apps-list.txt"
$scoop_apps = Get-Content -Path "$PSScriptRoot\app-install-lists\scoop-apps-list.txt"
$winget_apps = Get-Content -Path "$PSScriptRoot\app-install-lists\winget-apps-list.txt"

# System/User Directories
$conf_dir = "$HOME\Downloads\windows-config-files\home"
$working_dir = "$HOME\Downloads"

# * Introduction

Write-Host "# --- Introduction --- #" -ForegroundColor Green

# Let user know that running scripts they find online can be dangerous and that they should proceed with caution
Write-Host "`nDISCLAIMER: NEVER RUN SCRIPTS YOU FIND ON THE INTERNET BEFORE FIRST READING THROUGH THEM!" -ForegroundColor Red
Write-Host "`nWelcome to your new Windows Setup Script!" -ForegroundColor Green
Write-Host "`nThis script downloads and installs programs, moves my configs for various programs to their correct locations, and a few other things."
Write-Host "Please read through the script BEFORE executing it to make sure it doesn't do anything you don't want it to!"
$user_input = Read-Host "Would you like to run the setup? (y/n)"

# * Main

Write-Host "`n# --- Main --- #" -ForegroundColor Green

if ($user_input.ToLower() -eq "y") {

    # Set working directory for script
    Write-Host "`nSetting the working directory for the script."
    Set-Location -Path $working_dir

    # * Poetry
    Write-Host "`n# --- Poetry --- #" -ForegroundColor Green
    Install-Poetry

    # * Chocolatey
    Write-Host "`n# --- Chocolatey --- #" -ForegroundColor Green
    Install-Chocolatey
    Write-Host "Installing programs via Chocolatey..."

    # Install apps with Chocolatey
    foreach ($chocolatey_app in $chocolatey_apps) {
        choco install $chocolatey_app -y
    }  

    # * Winget
    Write-Host "`n# --- Winget --- #" -ForegroundColor Green
    Install-Winget
    Write-Host "Installing programs via Winget..."

    # Install apps with Winget
    foreach ($winget_app in $winget_apps) {
        winget install -e --id $winget_app --silent --accept-package-agreements --accept-source-agreements
    }

    # * Scoop
    Write-Host "`n# --- Scoop --- #" -ForegroundColor Green
    Install-Scoop

    Write-Host "Installing extra Buckets for Scoop..."

    # Install apps with Scoop
    foreach ($scoop_bucket in $scoop_buckets) {
        scoop bucket add $scoop_bucket
    }

    Write-Host "Installing programs via Scoop..."

    # Install apps with Scoop
    foreach ($scoop_app in $scoop_apps) {
        scoop install $scoop_app
    }

    # * Configs

    Write-Host "`n# --- Configs --- #" -ForegroundColor Green

    # Git clone repo
    Write-Host "`nDownloading the config files from GitHub..."
    git clone $conf_url --quiet

    # Copy all configs to their correct locations
    Write-Host "`nMoving all config files to their correct locations..."

    # Set location to the correct directory and get the file paths for each config
    Set-Location -Path $conf_dir
    $base_path = Resolve-Path .
    $file_paths = Get-ChildItem -LiteralPath $conf_dir -File -Recurse | ForEach-Object { (Join-Path ((Split-Path $_.FullName -Parent) -replace "^\\", "") $_.Name) -replace ("^{0}\\?" -f [regex]::Escape($base_path)), "" }

    # Move each config to the correct location
    foreach ($file in $file_paths) {
        $destination = "$HOME\$file"
        if ((Test-Path -Path $destination) -eq $false) {
            New-Item -Path $destination -Force
        }
        Copy-Item -Path $file -Destination $destination -Force
    }

    # * Cleanup

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

}

elseif ($user_input.ToLower() -eq "n") {
    Write-Host "`nYou decided to not run the script. No Problem! If you'd like to use it at a later date, just run it again!" -ForegroundColor Red
}

else {
    Write-Host "`nInvalid input. Starting the script over again!`n" -ForegroundColor Yellow
    .\"windows-setup-script.ps1"
}
