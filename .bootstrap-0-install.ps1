#Requires -Version 5.1
#Requires -RunAsAdministrator

param()

$InformationPreference = 'Continue'



# Boot: Install winget
Write-Information "`n[BOOT] Installing winget..."

Add-AppxPackage -RegisterByFamilyName -MainPackage 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe'



# Done!
Write-Information "`n[DONE]"
