#Requires -Version 7.3
#Requires -RunAsAdministrator

param(
    [switch] $UninstallTargetBefore
)

$InformationPreference = 'Continue'



# Setup target-apps
Write-Information 'Setup: target-apps...'

$TargetApps = [ordered] @{

    '(Microsoft) Azure cli'                  = 'Microsoft.AzureCLI'
    '(Microsoft) Bicep'                      = 'Microsoft.Bicep'
    '(Microsoft) Power toys'                 = 'Microsoft.PowerToys'
    '(Microsoft) VS code'                    = 'Microsoft.VisualStudioCode'
    '(Microsoft) Windows terminal (Preview)' = 'Microsoft.WindowsTerminal.Preview'

    'MS build - Structured log viewer'       = 'KirillOsenkov.MSBuildStructuredLogViewer'
    'Windows Performance Analyzer (Preview)' = '9N58QRW40DFW'

    '7-zip'                                  = '7zip.7zip'
    'Git'                                    = 'Git.Git'
    'Github cli'                             = 'GitHub.cli'
    'Google - Chrome'                        = 'Google.Chrome'
    'JGraph - Draw.io'                       = 'JGraph.Draw'
    'Oh my posh'                             = 'JanDeDobbeleer.OhMyPosh'
    'NZXT - CAM'                             = 'NZXT.CAM'
    'VideoLAN - VLC'                         = 'VideoLAN - VLC'
}

if (-not $NZXT.IsPresent) {
    $TargetApps.Remove('NZXT - CAM')
}

if (-not $VLC.IsPresent) {
    $TargetApps.Remove('VideoLAN - VLC')
}



# Install target-apps
Write-Information "`nInstalling target-apps..."

$TargetApps.GetEnumerator() | ForEach-Object {

    Write-Information "`n - $($PSItem.Key)"



    if ($UninstallTargetBefore.IsPresent) {

        # Uninstall target-app
        Write-Verbose ' Uninstalling...' -Verbose

        winget uninstall --id $PSItem.Value --exact --purge --accept-source-agreements --silent --disable-interactivity | Out-Null



        # Install target-app
        Write-Verbose '   Installing...' -Verbose
    }

    winget install --id $PSItem.Value --exact --ignore-security-hash --dependency-source --accept-source-agreements --accept-package-agreements --silent
}



# Done!
Write-Information "`n[DONE]"
