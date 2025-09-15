#Requires -Version 7.3
#Requires -RunAsAdministrator

param()



$InformationPreference = 'Continue'



# Setup PS:Repository
Write-Information "`nSetup: PS:Repository..."

Set-PSRepository -Name 'PSGallery' -InstallationPolicy 'Trusted'



# Setup PS:Modules
Write-Information "`nSetup: PS:Modules..."

$PSModules = @{
    'Az'               = @{}
    'ImportExcel'      = @{}
    'Pester'           = @{ Force = $true; SkipPublisherCheck = $true }
    'posh-git'         = @{}
    'PSReadLine'       = @{ Force = $true }
    'PSScriptAnalyzer' = @{ Force = $true }
    'Terminal-Icons'   = @{}
}



# Install PS:Modules
Write-Information "`nInstalling PS:Modules..."

$PSModules.GetEnumerator() | ForEach-Object {

    # Install PS:Module
    Write-Information " - $($PSItem.Name)"

    if (-not $(Get-InstalledModule -Name $PSItem.Name -ErrorAction Ignore)) {

        $ModOpt = @{
            Name               = $PSItem.Name
            Scope              = 'AllUsers'
            Force              = [bool] $PSItem.Value.Force
            SkipPublisherCheck = [bool] $PSItem.Value.SkipPublisherCheck
        }

        Install-Module @ModOpt

    } else {

        $ModOpt = @{
            Name  = $PSItem.Name
            Scope = 'AllUsers'
            Force = [bool] $PSItem.Value.Force
        }

        Update-Module @ModOpt
    }
}

Write-Information ''



# Setup PS:Profile I/O-dirs
Write-Information "`nSetup: PS:Profile I/O-dirs..."

$SourceDir = Join-Path -Path $PSScriptRoot -ChildPath 'Pwsh'
$TargetDir = Join-Path -Path $([System.Environment]::GetFolderPath('MyDocuments')) -ChildPath 'PowerShell'

if (-not $(Test-Path -Path $TargetDir -PathType 'Container')) {
    mkdir $TargetDir | Out-Null
}



# Copy PS:Profile files
Write-Information "`nCopying PS:Profile files..."

Get-ChildItem -Path $SourceDir -File | ForEach-Object {

    # Copy PS:Profile file
    Write-Information " - $($PSItem.Name)"

    $PSItem | Copy-Item -Destination $TargetDir -Container -Force
}



# Done!
Write-Information "`n[DONE]"
