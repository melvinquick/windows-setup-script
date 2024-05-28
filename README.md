<p align="center"> <img src="/images/windows-setup-script-with-text.png" /> </p>

## Donations

[<img src="https://img.shields.io/badge/Sponsor-%E2%99%A5-gray?style=for-the-badge&logo=GitHub" alt="Static Badge" width="165" height="40">](https://github.com/sponsors/melvinquick) <a href="https://www.buymeacoffee.com/KingKairos" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-green.png" alt="Buy Me A Coffee" style="height: 40px !important;width: 165px !important;" ></a>

## Purpose

The goal of this script is to be the ultimate Windows Setup Tool... Not only for myself, but for anybody that would like to use it. The main idealogy is to be modular, fast, and good looking (as good as a terminal "UI" can look at least).

## Instructions

To run, open PowerShell as an admin user and copy/paste the following code block into it, then hit enter:

```
Invoke-WebRequest -Uri zip.windowssetupscript.com -OutFile $HOME\Downloads\windows-setup-script.zip
Expand-Archive -Path $HOME\Downloads\windows-setup-script.zip -DestinationPath $HOME\Downloads\windows-setup-script
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
Set-Location -Path $HOME\Downloads
  .\windows-setup-script\windows-setup-script-main\windows-setup-script.ps1
```

**Disclaimer:** This project is currently undergoing a full overhaul. As such, I am not responsible for anything being broken in the project currently, or breaking your current system. As always, PLEASE read the code yourself if you run into problems and open an issue if you can!

## Useful Information

- [Project Goals](https://github.com/users/melvinquick/projects/4/views/1)

