# Windows Setup Script

## Purpose

This is a script for setting up Windows to how I like it on a fresh install. The installed programs list is fluid and changes as I decide I want to use new things or no longer use old things. I also am constantly adding in / taking out new config/theme/plugin files for certain applications (ie. Alacritty, PowerShell, etc.).

## Instructions

- Download the script as a zip file and save it to your downloads folder
- Open PowerShell as an admin user and run these commands in this order:
  - Expand-Archive -Path $HOME\Downloads\windows-setup-script-main.zip -DestinationPath $HOME\Downloads
  - Set-Location -Path "$HOME\Downloads\windows-setup-script-main"
  - Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
  - .\windows-setup-script.ps1

### Optional

- Once the script is done, you can then delete anything remaining in your Downloads folder as it's no longer needed.
- A restart is recommended, but not necessary.

## Notes

- This script is in a usable state on Windows 10 and Windows 11.
- Once the script is running after the initial "Y/y" user input at the beginning, the user shouldn't need to do any more inputs.
- If you'd like to use this script, fork it, or anything else, please do; however, I am NOT responsible for anything breaking on your system.

## Coming Soon :construction:

- Nothing for now!

## Completed :white_check_mark:

- Installs Chocolatey, Winget, and Scoop
- Installs apps that I like having on a new install
- Grabs [my configs](https://github.com/cquick00/windows-config-files) and moves them to the correct location
- Cleans up the temp folder and user and public desktop folders to remove installed app shortcuts and other junk
