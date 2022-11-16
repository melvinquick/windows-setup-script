# WindowsSetupScript

## Purpose

This is a script for setting up Windows to how I like it on a fresh install. The installed programs list is fluid and changes as I decide I want to use new things or no longer use old things. I also am constantly adding in / taking out new config/theme/plugin files for certain applications (ie. BetterDiscord themes/plugins).

## Instructions

- Download the script as a zip file and save it wherever you want (your downloads folder should be fine)
- Open PowerShell as an admin user and run these commands in this order:
  - Set-Location -Path "~\Downloads"
  - Expand-Archive WindowsSetupScript-main.zip
  - Set-Location -Path "WindowsSetupScript-main\WindowsSetupScript-main"
  - Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
  - .\WindowsSetupScript.ps1
- Change default font in PowerShell to CaskaydiaCove Nerd Font

**Optional**

- Once the script is done, you can then delete anything remaining in your Downloads folder as it's no longer needed.
- A restart is recommended, but not necessary.

## Notes

- This script is in a usable state on Windows 10 and Windows 11.
  - This script just had a major refactoring and some things MAY or MAY NOT work.
- If you'd like to use this script, fork it, or anything else, please do; however, I am NOT responsible for anything breaking on your system.

## Coming Soon :construction:

- Clean up unneeded output

## Completed :white_check_mark:

- CaskaydiaCove Nerd Font Install
- Chocolatey
- Code refactoring
- Configs
- Information For User
- PowerShell
- Scoop
- Windows 10 Compatibility
- Windows 11 Compatibility
