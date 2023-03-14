#Requires -Version 7.3
#Requires -RunAsAdministrator

param()

$InformationPreference = 'Continue'



# Install WSL2
Write-Information "`nInstalling WSL2..."

wsl --install



# Setup WSL2: Steps from docs @ https://docs.docker.com/desktop/windows/wsl/

# Setup WSL2: Step: 1
Write-Information "`n 1. Enable the Windows Subsystem for Linux..."

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart



# Setup WSL2: Step: 2
Write-Information "`n 2. Check requirements for running WSL 2..."

$CurWinVer = [version] $(
    (& cmd /c 'ver') |
        Where-Object { $_ -match '(\d+)\.(\d+)\.(\d+)\.(\d+)' } |
        ForEach-Object { $Matches.0 }
)

$MinWinVer = [version] '10.0.18362' # Windows 10, version 1903

if ($CurWinVer -lt $MinWinVer) {
    throw "Current windows version [$CurWinVer] does not meet the minimum required windows version! [$MinWinVer]"
}



# Setup WSL2: Step: 3
Write-Information "`n 3. Enable Virtual Machine feature..."

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart



# Setup WSL2: Step: 4
Write-Information "`n 4. Installing the Linux kernel update package..."

curl https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -o wsl_update_x64.msi

& .\wsl_update_x64.msi



# Setup WSL2: Step: 5
Write-Information "`n 5. Setting WSL 2 as your default version..."

wsl --set-default-version 2



# Install Ubuntu (latests distro)
Write-Information "`nInstalling Ubuntu..."

winget install --id 'Canonical.Ubuntu.2204' --exact --ignore-security-hash --dependency-source --accept-source-agreements --accept-package-agreements --silent



# Done!
Write-Information "`n[DONE]"
