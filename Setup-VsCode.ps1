#Requires -Version 7.3

param()

$InformationPreference = 'Continue'



# Copy vscode-settings.json
Write-Information "`nCopying vscode-settings.json..."

$SourceSettingsJson = "$(Join-Path -Path $PSScriptRoot -ChildPath 'VsCode\settings.json')"
$TargetSettingsJson = "$(Join-Path -Path $env:APPDATA -ChildPath 'Code\User\settings.json')"

Copy-Item -Path $SourceSettingsJson -Destination $TargetSettingsJson -Force



# Copy vscode-extensions dir
Write-Information "`nCopying vscode-extensions dir..."

$SourceSettingsExtDir = "$(Join-Path -Path $PSScriptRoot -ChildPath 'VsCode\settings.ext')\*.*"
$TargetSettingsExtDir = "$(Join-Path -Path $env:USERPROFILE -ChildPath '.vscode\settings.ext')"

Copy-Item -Path $SourceSettingsExtDir -Recurse -Destination $TargetSettingsExtDir -Container -Force



# Setup vscode-extensions
Write-Information "`nSetup: vscode-extensions..."

$TargetExts = @(
    'AzurePolicy.azurepolicyextension'
    'bencoleman.armview'
    'bierner.markdown-mermaid'
    'eamodio.gitlens'
    'formulahendry.dotnet-test-explorer'
    'GrapeCity.gc-excelviewer'
    'hashicorp.terraform'
    'IBM.output-colorizer'
    'ionutvmi.path-autocomplete'
    'jock.svg'
    'ms-azure-devops.azure-pipelines'
    'ms-azuretools.vscode-azureappservice'
    'ms-azuretools.vscode-azurefunctions'
    'ms-azuretools.vscode-azureresourcegroups'
    'ms-azuretools.vscode-azurestorage'
    'ms-azuretools.vscode-azureterraform'
    'ms-azuretools.vscode-azurevirtualmachines'
    'ms-azuretools.vscode-bicep'
    'ms-azuretools.vscode-cosmosdb'
    'ms-azuretools.vscode-docker'
    'ms-dotnettools.csharp'
    'ms-dotnettools.vscode-dotnet-runtime'
    'ms-kubernetes-tools.vscode-kubernetes-tools'
    'ms-toolsai.jupyter'
    'ms-toolsai.jupyter-keymap'
    'ms-toolsai.jupyter-renderers'
    'ms-vscode-remote.remote-containers'
    'ms-vscode-remote.remote-ssh'
    'ms-vscode-remote.remote-ssh-edit'
    'ms-vscode-remote.remote-wsl'
    'ms-vscode-remote.vscode-remote-extensionpack'
    'ms-vscode.azure-account'
    'ms-vscode.azurecli'
    'ms-vscode.powershell'
    'ms-vscode.powershell-preview'
    'ms-vscode.remote-repositories'
    'ms-vscode.vscode-node-azure-pack'
    'ms-vsliveshare.vsliveshare'
    'ms-vsliveshare.vsliveshare-audio'
    'ms-vsliveshare.vsliveshare-pack'
    'msazurermtools.azurerm-vscode-tools'
    'oderwat.indent-rainbow'
    'redhat.vscode-xml'
    'redhat.vscode-yaml'
    'ryanluker.vscode-coverage-gutters'
    'softwaredotcom.swdc-vscode'
    'tfsec.tfsec'
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
