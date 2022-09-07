# Variables
$downloadDir = "~\Downloads"
$isInstalled = $false
$scriptDir = "$downloadDir\WindowsSetupScript-main\WindowsSetupScript-main"
$scriptPartTwo = "WindowsSetupScriptPart2.ps1"
$userInput = ""
$wingetInstaller = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
$wingetUrl = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"


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


    ########## WINGET ##########
    Write-Host "`n########## WINGET ##########" -ForegroundColor Green

    # Check if Winget is installed already
    Write-Host "Checking to see if Winget is installed."

    if (winget -v) {

        $isInstalled = $true

    }

    if ($isInstalled -eq $false) {

        Write-Host "Winget was not installed. Downloading and installing now."

        # Download
        Invoke-WebRequest -Uri $wingetUrl -OutFile $wingetInstaller 

        # Install
        Import-Module -Name Appx -UseWindowsPowerShell
        Add-AppxPackage -Path $wingetInstaller

    }

    
    ########## NEXT SCRIPT ##########
    Set-Location $scriptDir
    Powershell $scriptPartTwo

}

elseif ($userInput.ToLower() -eq "n") {
    Write-Host "`nYou decided to not run the script. No Problem! If you'd like to use it at a later date, just run it again!" -ForegroundColor Red
}

else {
    Write-Host "`nInvalid input. Starting the script over again!`n" -ForegroundColor Yellow
    .\"WindowsSetupScript.ps1"
}
