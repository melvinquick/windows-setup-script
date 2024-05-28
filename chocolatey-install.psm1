function Install-Chocolatey {
    # Check if Chocolatey is installed already
    Write-Host "`nChecking to see if Chocolatey is installed..."

    if (Test-Path -Path "C:\ProgramData\chocolatey\choco.exe") {
        Write-Host "Chocolatey is already installed."
    }

    else {
        Write-Host "Chocolatey was not installed. Downloading and installing now..."
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) | Out-Null
        Write-Host "Chocolatey has been installed."
    }
}
