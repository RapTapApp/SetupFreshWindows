#Requires -Version 7.3
#Requires -RunAsAdministrator

param([switch] $Force)



$InformationPreference = 'Continue'
Set-Location $PSScriptRoot



# Invoke install scripts (in sequence)
. .\Install\Apps.ps1 -Force $Force.IsPresent

. .\Install\Wsl2-Ubuntu-Docker.ps1

. .\Install\Fonts.ps1 -Force $Force.IsPresent
