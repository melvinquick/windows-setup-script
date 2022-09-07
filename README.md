# WindowsSetupScript

## Purpose

This is a script for setting up Windows to how I like it on a fresh install.

## Instructions / Notes

- Download it as a zip file and save it wherever you want (your downloads folder should be fine)
- Set-Location -Path "~\Downloads"
- Open PowerShell as a normal user and run Expand-Archive Downloads\WindowsSetupScript-main.zip
- Set-Location -Path "WindowsSetupScript-main\WindowsSetupScript-main"
- .\WindowsSetupScript.ps1
  - If you get an error, run this command: Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
  - Then run the script again using .\WindowsSetupScript.ps1

## To-Do List

- Caskaydia Cove Font :construction:

  - Get all Windows Compatible Sets of Caskaydia Cove Nerd Font installed :white_check_mark:
  - Set default font in PowerShell to Caskaydia Cove Nerd Font :x:

- PowerShell :construction:

  - Add check for PowerShell Config Directory Path and create it if it doesn't exist :white_check_mark:
  - Add a way to refresh the environment when needed for Winget and Git pickup :x:
  - Add exit command at end to get out of nested PowerShell :white_check_mark:

- Scoop :white_check_mark:

  - Add a check to see if scoop is installed already

- Winget :white_check_mark:

  - Add a check to see if Winget is installed already

- Information For User :construction:

  - Add Write-Host commands for each new section so that the user knows where they're at in the script
  - Suppress output of useless information (i.e. winget saying that it's not recognized juct because I ran winget -v to check to see if it was installed or not)
