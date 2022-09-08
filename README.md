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

## To-Do List

- Caskaydia Cove Font Install :x:
  - Currently unable to get the font installed via PowerShell, so I've left instructions at the end of the script for the user to do it themselves!
- Chocolatey :white_check_mark:
- Configs :white_check_mark:
- Information For User :white_check_mark:
- PowerShell :white_check_mark:
- Scoop :white_check_mark:
