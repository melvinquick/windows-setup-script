# WindowsSetupScript

## Purpose

This is a script for setting up Windows to how I like it on a fresh install.

## Instructions

- To install Winget you'll need to turn on .NET Framework 3.5, which includes .NET 2.0 and .NET 3.0
  - You can do this by typing Turn Windows features on or off into your search bar and launching the application
  - Then check the first box and hit ok
  - Select Let Windows Update download the files for you and wait for it to finish
- Download the script as a zip file and save it wherever you want (your downloads folder should be fine)
- Open PowerShell as an admin user and run these commands in this order:
  - Set-Location -Path "~\Downloads"
  - Expand-Archive WindowsSetupScript-main.zip
  - Set-Location -Path "WindowsSetupScript-main\WindowsSetupScript-main"
  - .\WindowsSetupScript.ps1
    - If you get an error, run this command:
      - Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
      - Then run the script again using .\WindowsSetupScript.ps1

## To-Do List

- Caskaydia Cove Font :construction:

  - Get all Windows Compatible Sets of Caskaydia Cove Nerd Font installed :white_check_mark:
  - Set default font in PowerShell to Caskaydia Cove Nerd Font :x:

- Chocolatey :white_check_mark:

  - Add section for installing Chocolatey

- PowerShell :construction:

  - Add check for PowerShell Config Directory Path and create it if it doesn't exist :white_check_mark:
  - Add a way to refresh the environment when needed for Winget and Git pickup :x:
  - Add exit command at end to get out of nested PowerShell :white_check_mark:

- Scoop :white_check_mark:

  - Add a check to see if scoop is installed already

- Winget :white_check_mark:

  - Add a check to see if Winget is installed already

- Information For User :construction:

  - Add Write-Host commands for each new section so that the user knows where they're at in the script :white_check_mark:
  - Suppress output of useless information (i.e. winget saying that it's not recognized juct because I ran winget -v to check to see if it was installed or not) :x:
