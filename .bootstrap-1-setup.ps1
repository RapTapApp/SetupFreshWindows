#Requires -Version 5.1
#Requires -RunAsAdministrator

param()

$InformationPreference = 'Continue'



# Boot: Setup: winget
Write-Information "`n[BOOT] Setup: winget..."

cmd /c 'winget settings --enable InstallerHashOverride'



# Boot: Install pwsh
Write-Information "`n[BOOT] Installing pwsh..."

cmd /c 'winget install --id Microsoft.PowerShell --exact'



# Done!
Write-Information "`n[DONE]"
