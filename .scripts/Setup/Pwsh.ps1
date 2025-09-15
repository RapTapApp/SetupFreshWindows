#Requires -Version 7.3
#Requires -RunAsAdministrator

param()



$InformationPreference = 'Continue'



# Setup PS:Repository
Write-Information "`nSetup: PS:Repository..."

Set-PSRepository -Name 'PSGallery' -InstallationPolicy 'Trusted'



# Setup PS:Modules
Write-Information "`nSetup: PS:Modules..."

$PSModules = [ordered] @{
    # By Microsoft
    'Az'               = @{ AllowClobber = $true; Force = $false }
    'PSReadLine'       = @{}
    'PSScriptAnalyzer' = @{}

    # For oh-my-posh
    'Terminal-Icons'   = @{}

    # For Excel I/O
    'ImportExcel'      = @{}

    # For PS development
    'Assert'           = @{}
    'Pester'           = @{ SkipPublisherCheck = $true }
    'Profiler'         = @{}
}



# Install PS:Modules
Write-Information "`nInstalling PS:Modules..."

$PSModules.GetEnumerator() | ForEach-Object {

    # Install PS:Module
    Write-Information "`n - $($PSItem.Name)"

    $InstallArgs = @{
        Force              = [bool] ($PSItem.Value.Force ?? $true)
        AllowClobber       = [bool] ($PSItem.Value.AllowClobber ?? $false)
        SkipPublisherCheck = [bool] ($PSItem.Value.SkipPublisherCheck ?? $false)
    }

    Install-Module $PSItem.Name -Scope 'AllUsers' @InstallArgs
}

Write-Information ''



# Update Help of PS:Modules
Write-Information "`nUpdating Help of PS:Modules..."

Update-Help -Force -Scope AllUsers -UICulture en-US -ErrorAction Continue

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
