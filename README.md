# WindowsSetupScript

## Purpose

This is a script for setting up Windows to how I like it on a fresh install.

## Instructions

- Download the script as a zip file and save it wherever you want (your downloads folder should be fine)
- Open PowerShell as an admin user and run these commands in this order:
  - Set-Location -Path "~\Downloads"
  - Expand-Archive WindowsSetupScript-main.zip
  - Set-Location -Path "WindowsSetupScript-main\WindowsSetupScript-main"
  - Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
  - .\WindowsSetupScript.ps1

**Optional**

- Once you finish installing and setting the fonts, you can then delete everything in your Downloads folder as it's no longer needed.

## Notes

- This script is in a usable state on Windows 10 and is untested on Windows 11.
- This script is EXTREMELY loosely put together right now. Basically just enough to get it to work FOR ME.
  - If you'd like to use it, fork it, or anything else, please do; however, I am NOT responsible for anything breaking on your system.

## To-Do List

- Caskaydia Cove Font Install :x:
  - Currently unable to get the font installed via PowerShell, so I've left instructions at the end of the script for the user to do it themselves!
- Chocolatey :white_check_mark:
- Clean up script so that it's more organized and more formal :construction:
  - I have it in a barely functioning state right now and I'd love to clean it up!
- Configs :white_check_mark:
- Information For User :white_check_mark:
- PowerShell :white_check_mark:
- Scoop :white_check_mark:
- Windows 10 Compatibility :white_check_mark:
- Windows 11 Compatibility :construction:
