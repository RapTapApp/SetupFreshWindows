#Requires -Version 7.3
#Requires -RunAsAdministrator

param([switch] $Force)

$InformationPreference = 'Continue'



# Setup target-apps
Write-Information 'Setup: target-apps...'

$TargetApps = [ordered] @{

    '(Microsoft) Azure cli'                    = 'Microsoft.AzureCLI'
    '(Microsoft) Bicep'                        = 'Microsoft.Bicep'
    '(Microsoft) Power-toys'                   = 'Microsoft.PowerToys'
    '(Microsoft) VS-code'                      = 'Microsoft.VisualStudioCode'
    '(Microsoft) Windows Performance Analyzer' = '9N0W1B2BXGNZ'
    '(Microsoft) Windows Terminal'             = 'Microsoft.WindowsTerminal'

    'Sysinternals Suite'                       = '9P7KNL5RWT25'
    'MS build - Structured log viewer'         = 'KirillOsenkov.MSBuildStructuredLogViewer'

    '7-zip'                                    = '7zip.7zip'
    'Git'                                      = 'Git.Git'
    'Github cli'                               = 'GitHub.cli'
    'Gpg4win'                                  = 'GnuPG.Gpg4win'

    'Google - Chrome'                          = 'Google.Chrome'
    'JGraph - Draw.io'                         = 'JGraph.Draw'
    'Oh my posh'                               = 'JanDeDobbeleer.OhMyPosh'
    'VideoLAN - VLC'                           = 'VideoLAN.VLC'
}



# Install target-apps
Write-Information "`nInstalling target-apps..."

$TargetApps.GetEnumerator() | ForEach-Object {

    Write-Information "`n - $($PSItem.Key)"



    if ($Force.IsPresent) {

        # Uninstall target-app
        Write-Verbose ' Uninstalling...' -Verbose

        winget uninstall --id $PSItem.Value --exact --purge --accept-source-agreements --silent --disable-interactivity | Out-Null



        # Install target-app
        Write-Verbose '   Installing...' -Verbose
    }

    winget install --id $PSItem.Value --exact --dependency-source --accept-source-agreements --accept-package-agreements --silent
}



# Done!
Write-Information "`n[DONE]"
