#Requires -RunAsAdministrator



# Setup PS:Repository
Set-PSRepository -Name 'PSGallery' -InstallationPolicy 'Trusted'



# Install PS:Modules
Install-Module -Scope 'AllUsers' -Name 'Az'
Install-Module -Scope 'AllUsers' -Name 'ImportExcel'
Install-Module -Scope 'AllUsers' -Name 'Pester' -Force -SkipPublisherCheck
Install-Module -Scope 'AllUsers' -Name 'posh-git'
Install-Module -Scope 'AllUsers' -Name 'PSReadLine' -Force
Install-Module -Scope 'AllUsers' -Name 'PSScriptAnalyzer' -Force
Install-Module -Scope 'AllUsers' -Name 'Terminal-Icons'



# Install PS:Config
$SourceDir = Join-Path -Path $PSScriptRoot -ChildPath 'Pwsh'
$TargetDir = Join-Path -Path $([System.Environment]::GetFolderPath('MyDocuments')) -ChildPath 'PowerShell'

if (-not $(Test-Path -Path $TargetDir -PathType 'Container')) {
    mkdir $TargetDir | Out-Null
}

Get-ChildItem -Path $SourceDir -File |
    Copy-Item -Destination $TargetDir -Container -Force
