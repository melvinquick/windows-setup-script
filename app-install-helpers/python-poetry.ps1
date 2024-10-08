function Install-Poetry {
    # Check if Poetry is installed already
    Write-Host "`nChecking to see if Poetry is installed..."

    if (Test-Path -Path "$HOME\AppData\Roaming\Python\Scripts\poetry.exe") {
        Write-Host "Poetry is already installed."
    }

    else {
        Write-Host "Poetry was not installed. Downloading and installing now..."
        (Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py - | Out-Null
        [Environment]::SetEnvironmentVariable("Path", "$env:Path;C:\Users\charlie\AppData\Roaming\Python\Scripts", "Machine")
        Write-Host "Poetry has been installed."
    }
}
