#Requires -Version 7.3

param()

$InformationPreference = 'Continue'
Set-Location $PSScriptRoot



# Synch settings: VS-code
Write-Information "`nSync settings: VS-code..."

Get-ChildItem "$env:APPDATA\Code\User\settings.json" -File |
    Copy-Item -Destination '.\VsCode\settings.json' -Force
