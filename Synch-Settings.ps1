#Requires -Version 7.3
#Requires -RunAsAdministrator

param()

$InformationPreference = 'Continue'



# Setup target-apps
Write-Information "`nSync: VS-code..."



Copy-Item '~\AppData\Roaming\Code\User\settings.json'
