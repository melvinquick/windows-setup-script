# WindowsSetupScript

## Purpose

This is a script for setting up Windows to how I like it on a fresh install.

## Instructions / Notes

- Download it as a zip file and save it wherever you want (your downloads folder should be fine)
- Set-Location -Path "~\Downloads"
- Open PowerShell as a normal user and run Expand-Archive Downloads\WindowsSetupScript-main.zip
- Set-Location -Path "WindowsSetupScript-main\WindowsSetupScript-main"
- .\WindowsSetupScript.ps1
  - If you get an error, run this command: Unblock-File -Path .\WindowsSetupScript.ps1
  - Then run the script again using .\WindowsSetupScript.ps1

## To-Do List

- Caskaydia Cove Font :construction:

  - Get all Windows Compatible Sets of Caskaydia Cove Nerd Font installed :white_check_mark:
  - Set default font in PowerShell to Caskaydia Cove Nerd Font :x:

- PowerShell :white_check_mark:

  - Add check for PowerShell Config Directory Path and create it if it doesn't exist
  - Add call to refresh PowerShell instance after installing git so that the Scoop Buckets can be added properly
  - Add exit command at end to get out of nested PowerShell

- Scoop :white_check_mark:

  - Add a check to see if scoop is installed already

- Winget :white_check_mark:

  - Add a check to see if Winget is installed already

- Information For User :white_check_mark:

  - Add Write-Host commands for each new section so that the user knows where they're at in the script
