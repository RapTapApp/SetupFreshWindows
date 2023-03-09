# Copy vscode: settings.json
$SourceSettingsJson = "$(Join-Path -Path $PSScriptRoot -ChildPath 'VsCode\settings.json')"
$TargetSettingsJson = "$(Join-Path -Path $env:APPDATA -ChildPath 'Code\User\settings.json')"

Copy-Item -Path $SourceSettingsJson -Destination $TargetSettingsJson -Force

# Copy vscode: extensions dir
$SourceSettingsExtDir = "$(Join-Path -Path $PSScriptRoot -ChildPath 'VsCode\settings.ext')\*.*"
$TargetSettingsExtDir = "$(Join-Path -Path $env:USERPROFILE -ChildPath '.vscode\settings.ext')"

Copy-Item -Path $SourceSettingsExtDir -Recurse -Destination $TargetSettingsExtDir -Container -Force



# Install vscode: extensions
code --install-extension 'AzurePolicy.azurepolicyextension'
code --install-extension 'bencoleman.armview'
code --install-extension 'bierner.markdown-mermaid'
code --install-extension 'eamodio.gitlens'
code --install-extension 'formulahendry.dotnet-test-explorer'
code --install-extension 'GrapeCity.gc-excelviewer'
code --install-extension 'hashicorp.terraform'
code --install-extension 'IBM.output-colorizer'
code --install-extension 'ionutvmi.path-autocomplete'
code --install-extension 'jock.svg'
code --install-extension 'ms-azure-devops.azure-pipelines'
code --install-extension 'ms-azuretools.vscode-azureappservice'
code --install-extension 'ms-azuretools.vscode-azurefunctions'
code --install-extension 'ms-azuretools.vscode-azureresourcegroups'
code --install-extension 'ms-azuretools.vscode-azurestorage'
code --install-extension 'ms-azuretools.vscode-azureterraform'
code --install-extension 'ms-azuretools.vscode-azurevirtualmachines'
code --install-extension 'ms-azuretools.vscode-bicep'
code --install-extension 'ms-azuretools.vscode-cosmosdb'
code --install-extension 'ms-azuretools.vscode-docker'
code --install-extension 'ms-dotnettools.csharp'
code --install-extension 'ms-dotnettools.vscode-dotnet-runtime'
code --install-extension 'ms-kubernetes-tools.vscode-kubernetes-tools'
code --install-extension 'ms-toolsai.jupyter'
code --install-extension 'ms-toolsai.jupyter-keymap'
code --install-extension 'ms-toolsai.jupyter-renderers'
code --install-extension 'ms-vscode-remote.remote-containers'
code --install-extension 'ms-vscode-remote.remote-ssh'
code --install-extension 'ms-vscode-remote.remote-ssh-edit'
code --install-extension 'ms-vscode-remote.remote-wsl'
code --install-extension 'ms-vscode-remote.vscode-remote-extensionpack'
code --install-extension 'ms-vscode.azure-account'
code --install-extension 'ms-vscode.azurecli'
code --install-extension 'ms-vscode.powershell'
code --install-extension 'ms-vscode.powershell-preview'
code --install-extension 'ms-vscode.remote-repositories'
code --install-extension 'ms-vscode.vscode-node-azure-pack'
code --install-extension 'ms-vsliveshare.vsliveshare'
code --install-extension 'ms-vsliveshare.vsliveshare-audio'
code --install-extension 'ms-vsliveshare.vsliveshare-pack'
code --install-extension 'msazurermtools.azurerm-vscode-tools'
code --install-extension 'oderwat.indent-rainbow'
code --install-extension 'redhat.vscode-xml'
code --install-extension 'redhat.vscode-yaml'
code --install-extension 'ryanluker.vscode-coverage-gutters'
code --install-extension 'softwaredotcom.swdc-vscode'
code --install-extension 'tfsec.tfsec'
