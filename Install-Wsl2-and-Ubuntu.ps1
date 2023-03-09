#Requires -RunAsAdministrator



# Install WSL2
wsl --install

# From docs @ https://docs.docker.com/desktop/windows/wsl/
# Install Dockers: Step 1 = Enable the Windows Subsystem for Linux
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Install Dockers: Step 2 = Check requirements for running WSL 2
# Use winver to verify

# Install Dockers: Step 3 = Enable Virtual Machine feature
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Install Dockers: Step 4 = Download the Linux kernel update package & Run installer
curl https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -o wsl_update_x64.msi
& wsl_update_x64.msi

# Install Dockers: Step 5 = Set WSL 2 as your default version
wsl --set-default-version 2

# Install Ubuntu (latests distro)
