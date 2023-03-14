#Requires -Version 7.3
#Requires -RunAsAdministrator

param()

$InformationPreference = 'Continue'



# Install docker
Write-Information 'Installing docker...'

winget install --id 'Docker.DockerDesktop' --exact --ignore-security-hash --dependency-source --accept-source-agreements --accept-package-agreements --silent



# Done!
Write-Information "`n[DONE]"
