#Requires -Version 7.3

param()

$InformationPreference = 'Continue'



# Write file-explorer registry-settings
Write-Information "`nWriting file-explorer registry-settings..."

$RegPath = 'Microsoft.PowerShell.Core\Registry::HKEY_CLASSES_ROOT\Directory\shell\VSCode'
if ($(Test-Path $RegPath)) {
    Remove-Item $RegPath -Force -Recurse
}

mkdir $RegPath -Force | Set-Location
New-ItemProperty -Path '.' -PropertyType 'ExpandString' -Name '(default)' -Value 'Open w&ith Code' | Out-Null
New-ItemProperty -Path '.' -PropertyType 'ExpandString' -Name 'Icon' -Value '%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe' | Out-Null

mkdir "$RegPath\command" -Force | Set-Location
New-ItemProperty -Path '.' -PropertyType 'ExpandString' -Name '(default)' -Value '"%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" "%V"' | Out-Null



# Copy vscode-settings.json
Write-Information "`nCopying vscode-settings.json..."

Set-Location $PSScriptRoot

$SourceSettingsJson = "$(Join-Path -Path $PSScriptRoot -ChildPath 'VsCode\settings.json')"
$TargetSettingsJson = "$(Join-Path -Path $env:APPDATA -ChildPath 'Code\User\settings.json')"

Copy-Item -Path $SourceSettingsJson -Destination $TargetSettingsJson -Force



# Copy vscode-extensions dir
Write-Information "`nCopying vscode-extensions dir..."

$SourceSettingsExtDir = "$(Join-Path -Path $PSScriptRoot -ChildPath 'VsCode\settings.ext\*.*')"
$TargetSettingsExtDir = "~\.vscode\settings.ext')"

if ($(Test-Path $TargetSettingsExtDir)) {
    Remove-Item $TargetSettingsExtDir -Recurse -Force | Out-Null
}

mkdir $TargetSettingsExtDir | Out-Null

Copy-Item -Path $SourceSettingsExtDir -Recurse -Destination $TargetSettingsExtDir -Container -Force



# Setup vscode-extensions
Write-Information "`nSetup: vscode-extensions..."

$TargetExts = @(
    # git
    'donjayamanne.githistory',
    'mhutchie.git-graph',

    # data
    'GrapeCity.gc-excelviewer',
    'redhat.vscode-xml',
    'redhat.vscode-yaml',

    # (dev)container
    'ms-azuretools.vscode-docker',
    'ms-vscode-remote.vscode-remote-extensionpack',
    # Installs extensions
    # - ms-vscode-remote.remote-ssh
    # - ms-vscode.remote-server
    # - ms-vscode-remote.remote-containers
    # - ms-vscode-remote.remote-wsl'

    # azure dev-ops pipeline intellisense
    'ms-azure-devops.azure-pipelines'

    # powershell + code coverage
    'ms-vscode.powershell'
    'ryanluker.vscode-coverage-gutters'

    # terraform
    'hashicorp.terraform'
)



# Install vscode-extensions
Write-Information "`nInstalling vscode-extensions..."

$TargetExts | ForEach-Object {

    # Install vscode-extension
    Write-Information " - $PSItem"

    code --install-extension $PSItem
}



# Done!
Write-Information "`n[DONE]"
