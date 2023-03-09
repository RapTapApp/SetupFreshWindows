#Requires -Version 7.3

param()

$InformationPreference = 'Continue'



# Copy Terminal: settings.json
Write-Information 'Copying Terminal: settings.json...'

$SourceSettingsJson = Join-Path -Path $PSScriptRoot -ChildPath 'Terminal\settings.json'
$TargetSettingsJson = Join-Path -Path $env:LOCALAPPDATA -ChildPath 'Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json'

Copy-Item -Path $SourceSettingsJson -Destination $TargetSettingsJson -Force



# Done!
Write-Information "`n[DONE]"
