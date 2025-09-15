#Requires -Version 7.3
#Requires -RunAsAdministrator

param()



$InformationPreference = 'Continue'
Set-Location $PSScriptRoot



# Setup all
Write-Information "`nSetup..."

. .\Setup\Az-cli.ps1
. .\Setup\Git.ps1
. .\Setup\Pwsh.ps1
. .\Setup\Terminal.ps1
. .\Setup\VsCode.ps1
. .\Setup\Windows.ps1



# Done!
Write-Information "`n[DONE]"
