# Variables
$downloadDir = "~\Downloads"
$scriptDir = "$downloadDir\WindowsSetupScript-main\WindowsSetupScript-main"
$scriptPartThree = "WindowsSetupScriptPart3.ps1"


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


########## NEXT SCRIPT ##########
Set-Location $scriptDir
PowerShell $scriptPartThree
