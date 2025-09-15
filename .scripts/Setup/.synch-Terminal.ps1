#Requires -Version 7.3

param()

$InformationPreference = 'Continue'
Set-Location $PSScriptRoot



# Synch settings: Terminal
Write-Information "`nSync settings: Terminal..."

Get-ChildItem "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -File |
    Copy-Item -Destination '.\Terminal\settings.json' -Force
