$debug = $false

# Welcome the user.
$displayName = (Get-LocalUser -Name $env:USERNAME).FullName
Write-Host "Welcome $displayName!"
Write-Host "This script will guide you through the process of cloning the Age of Pirates repository."

Write-Host "1. Checking if git is installed..."
Write-Host " "

# If git is not installed, tell the user and then ask if they want to be redirected to git-scm.com to download it.
if ((-not (Get-Command git -ErrorAction SilentlyContinue)) -or ($debug)) {
    Write-Host "Git is not installed. Would you like to download it now? (Y/N)"
    $choice = Read-Host "Your choice"
    if ($choice -eq "Y") {
        Start-Process "https://git-scm.com/download/win"
    }

    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

Write-Host "Git is installed."
Write-Host " "

Write-Host "2. Checking if git lfs is installed..."
Write-Host " "

# If git lfs is not installed, tell the user and then ask if they want to be redirected to git-lfs.github.com to download it.
if ((-not (Get-Command git-lfs -ErrorAction SilentlyContinue)) -or ($debug)) {
    Write-Host "Git LFS is not installed. Would you like to download it now? (Y/N)"
    $choice = Read-Host "Your choice"
    if ($choice -eq "Y") {
        Start-Process "https://git-lfs.github.com/"
    }

    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

Write-Host "Git LFS is installed."
Write-Host " "

Write-Host "3. Now we are going to clone the repository."
Write-Host " "

$scriptFolder = Get-Location

while ($true) {
    # Ask for the folder where the repository is going to be cloned (e.g. C:\Users\username\Documents\GitHub)
    # By default, the repository will be cloned to the same folder as the script.
    $repositoryFolder = Read-Host "Where would you like to clone the repository? (Default: $scriptFolder)"
    if ($repositoryFolder -eq "") {
        $repositoryFolder = $scriptFolder
    }
    # Ask for the repository's folder name (e.g. git-init)
    $defaultRepositoryName = "age-of-pirates"
    $repositoryName = Read-Host "What would you like to name the repository? (Default: $defaultRepositoryName)"
    if ($repositoryName -eq "") {
        $repositoryName = $defaultRepositoryName
    }
    # Tell the user if the path is invalid.
    if (-not (Test-Path $repositoryFolder)) {
        Write-Host "The path is invalid. Please try again."
        continue
    }
    # Tell the user if something already exists at the path, and ask if they want to proceed anyway.
    if (Test-Path $repositoryFolder\$repositoryName) {
        Write-Host "Something already exists at $repositoryFolder\$repositoryName"
        Write-Host "What do you want to do?"
        Write-Host "1 - Proceed anyway."
        Write-Host "2 - Choose a different path."
        Write-Host "3 - Exit."
        $choice = Read-Host "Your choice"
        if ($choice -eq "1") {
            # Do nothing.
        }
        elseif ($choice -eq "2") {
            continue
        }
        else {
            Write-Host "Press any key to exit..."
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            exit
        }
    }
    # Verify what's been entered.
    Write-Host "The repository will be cloned to $repositoryFolder\$repositoryName"
    Write-Host "Is this correct? (Y/N)"
    $choice = Read-Host "Your choice"
    if ($choice -eq "Y") {
        break
    }
}

Write-Host " "
Write-Host "Cloning the repository..."
Write-Host " "

# Clone the repository.
git clone https://github.com/ageofpirates/age-of-pirates.git

Write-Host " "
Write-Host "Repository cloned."
Write-Host " "

Write-Host "4. Setting up the repository..."
Write-Host " "

# Change the working directory to the repository's folder.
Set-Location $repositoryFolder\$repositoryName

# Ask whether to use global user.name and user.email or to set them for this repository only.
Write-Host "Would you like to use global user.name and user.email, or do you want to set different ones for this repository?"
$gitUserName = git config --global user.name
$gitUserEmail = git config --global user.email
Write-Host "1 - Use global user.name and user.email (currently $gitUserName and $gitUserEmail)"
Write-Host "2 - Set different ones for this repository."
$choice = Read-Host "Your choice"

if ($choice -eq "1") {
    # Do nothing.
}
else {
    # Ask for the user.name and user.email.
    $userName = Read-Host "Enter the user.name you want to use for this repository."
    $userEmail = Read-Host "Enter the user.email you want to use for this repository."

    # Set the user.name and user.email for this repository only.
    git config user.name "$userName"
    git config user.email "$userEmail"
}

# Initialize git lfs.
git lfs install
git lfs pull

Write-Host " "
Write-Host "The repository has been successfully set up."
Write-Host " "

# Check if VS Code is installed. If it is, ask if the user wants to open the repository in VS Code.
if ((Get-Command code -ErrorAction SilentlyContinue) -and ($debug -eq $false)) {
    Write-Host "Would you like to open the repository in VS Code? (Y/N)"
    $choice = Read-Host "Your choice"
    if ($choice -eq "Y") {
        code .
    }
}

# Ask if the user wants to open the repository in File Explorer.
Write-Host "Would you like to open the repository in File Explorer? (Y/N)"
$choice = Read-Host "Your choice"
if ($choice -eq "Y") {
    explorer .
}

# Congratulate the user on successfully cloning the repository.
Write-Host "Congratulations! You have successfully cloned the repository!"
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
