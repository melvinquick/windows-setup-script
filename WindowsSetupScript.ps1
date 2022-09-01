# Variables
$userInput = ""
$downloadDir = "~\Downloads"
$desktopDir = "~\Desktop"
$wingetUrl = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
$wingetInstaller = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
$configUrl = "https://github.com/cquick00/ConfigFiles.git"
$configDir = "$downloadDir\ConfigFiles"
$powershellProfileConfig = "$configDir\PowerShell\Microsoft.PowerShell_profile.ps1"
$powershellConfig = "$configDir\PowerShell\powershell.config.json"
$powershellConfigDir = "~\Documents\PowerShell"
$starshipConfig = "$configDir\Starship\starship.toml"
$starshipConfigDir = "~\.config"
$wingetConfig = "$configDir\Winget\settings.json"
$wingetConfigDir = "%LOCALAPPDATA%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState"


########## WELCOME MESSAGE AND INTRODUCTION ##########

# Main
Write-Host "`nDISCLAIMER: NEVER RUN SCRIPTS YOU FIND ON THE INTERNET BEFORE FIRST READING THROUGH THEM!`n" -ForegroundColor Red
Write-Host "Welcome to your new Windows Setup Script!" -ForegroundColor Green
Write-Host "`nThis script downloads and installs programs, moves my configs for various programs to their correct locations, and a few other things."
Write-Host "Please read through the script BEFORE executing it to make sure it doesn't do anything you don't want it to!"
$userInput = Read-Host "Would you like to run the setup? (y/n)"

if ($userInput.ToLower() -eq "y") {

    # Set working directory for script
    Set-Location $downloadDir


    ########## WINGET ##########

    # Download
    Invoke-WebRequest -Uri $wingetUrl -OutFile $wingetInstaller 

    # Install
    Import-Module -Name Appx -UseWindowsPowerShell
    Add-AppxPackage -Path $wingetInstaller

    # Install programs
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

    # Install
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod get.scoop.sh | Invoke-Expression

    # Add buckets
    scoop bucket add main
    scoop bucket add extras

    # Install programs
    scoop install ghostwriter hugo nano neofetch


    ########## CONFIGS ##########

    # Git clone repo
    git clone $configUrl
    

    # Move files to correct location
    Copy-Item $powershellProfileConfig -Destination $powershellConfigDir
    Copy-Item $powershellConfig -Destination $powershellConfigDir
    Copy-Item $starshipConfig -Destination $starshipConfigDir
    Copy-Item $wingetConfig -Destination $wingetConfigDir


    ##### CLEANUP #####

    # Delete desktop icons
    Get-ChildItem $desktopDir | Remove-Item -Force -Recurse

    # Delete downloads
    Get-ChildItem $downloadDir | Remove-Item -Force -Recurse

}

elseif ($userInput.ToLower() -eq "n") {
    Write-Host "`nYou decided to not run the script. No Problem! If you'd like to use it at a later date, just run it again!" -ForegroundColor Red
}

else {
    Write-Host "`nInvalid input. Starting the script over again!`n" -ForegroundColor Yellow
    .\"WindowsSetupScript.ps1"
}
