#Requires -Version 7.3

param()

$InformationPreference = 'Continue'



# Install bicep extention
Write-Information "`nSetup az-cli: Installing bicep extention..."

az bicep install && az bicep upgrade



# Done!
Write-Information "`n[DONE]"
