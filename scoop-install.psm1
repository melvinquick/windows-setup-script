function Install-Scoop {
        # Check if Scoop is installed already
        Write-Host "`nChecking to see if Scoop is installed..."

        if (Test-Path -Path "$HOME\scoop\apps\scoop\current\bin\scoop.ps1") {
            Write-Host "Scoop is already installed."
        }
    
        else {
            Write-Host "Scoop was not installed. Downloading and installing now..."
            Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"
            Write-Host "Scoop has been installed."
        } 
}