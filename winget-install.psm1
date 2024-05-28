function Install-Winget {

    # Check if Winget is installed already and install it if not
    Write-Host "`nChecking if Winget is Installed..."

    if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe) {
        Write-Host "Winget is already Installed."
    }
    else {
        Write-Host "Winget was not installed. Downloading and installing now..."

        # Get the computer's information
        $computer_info = Get-ComputerInfo

        # Get the Windows Edition
        if ($computer_info.os_name) {
            $os_name = $computer_info.os_name
        }

        else {
            $os_name = $computer_info.WindowsProductName
        }

        # Determines how to go about installing Winget based on the Windows Edition found
        if (((($os_name.IndexOf("LTSC")) -ne -1) -or ($os_name.IndexOf("Server") -ne -1)) -and (($computer_info.WindowsVersion) -ge "1809")) {
            
            Write-Host "Running Alternative Installer for LTSC/Server Editions.."

            # Switching to winget-install from PSGallery from asheroto
            # Source: https://github.com/asheroto/winget-installer
            
            Start-Process powershell.exe -Verb RunAs -ArgumentList "-command irm https://raw.githubusercontent.com/asheroto/winget-installer/master/winget-install.ps1 | iex | Out-Host" -WindowStyle Normal
            
        }

        elseif ((($computer_info).WindowsVersion) -lt "1809") {
            # Checks if Windows Version is too old for winget
            Write-Host "Winget is not supported on this version of Windows (Pre-1809)."
        }

        else {
            # Installing Winget from the Microsoft Store
            Write-Host "Winget not found, installing it now..."
            Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
            $nid = (Get-Process AppInstaller).Id
            Wait-Process -Id $nid
            Write-Host "Winget has been installed."
        }

        Start-Sleep -Seconds 5
    }
}