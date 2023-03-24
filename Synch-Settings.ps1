#Requires -Version 7.3
#Requires -RunAsAdministrator

param()

$InformationPreference = 'Continue'
Set-Location $PSScriptRoot



# Setup target-apps
Write-Information "`nSync: VS-code..."

Get-ChildItem "$env:APPDATA\Code\User\settings.json" -File |
    Copy-Item -Destination '.\VsCode\settings.json' -Force
