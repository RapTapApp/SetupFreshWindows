# Setup I/O Files
$SourceSettingsJson = Join-Path -Path $PSScriptRoot -ChildPath 'Terminal\settings.json'
$TargetSettingsJson = Join-Path -Path $env:LOCALAPPDATA -ChildPath 'Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json'



# Copy Terminal: settings.json
Copy-Item -Path $SourceSettingsJson -Destination $TargetSettingsJson -Force
