#Requires -Version 7.3
#Requires -RunAsAdministrator

param()

$InformationPreference = 'Continue'



# Setup bloatware-apps
Write-Information "`nSetup: bloatware-apps..."

$BloatWare = [ordered] @{

    # Microsoft
    '(Microsoft) 3D Viewer'                = 'Microsoft.Microsoft3DViewer_8wekyb3d8bbwe'
    '(Microsoft) Clipchamp - Video Editor' = '9P1J8S7CCWWT'
    '(Microsoft) Cortana'                  = 'Microsoft.549981C3F5F10_8wekyb3d8bbwe'
    '(Microsoft) Films & TV'               = '9WZDNCRFJ3P2'
    '(Microsoft) Mail and Calendar'        = 'microsoft.windowscommunicationsapps_8wekyb3d8bbwe'
    '(Microsoft) Mixed Reality Portal'     = 'Microsoft.MixedReality.Portal_8wekyb3d8bbwe'
    '(Microsoft) Movies & TV'              = 'Microsoft.ZuneVideo_8wekyb3d8bbwe'
    '(Microsoft) MSN Weather'              = 'Microsoft.BingWeather_8wekyb3d8bbwe'
    '(Microsoft) OneNote for Windows 10'   = 'Microsoft.Office.OneNote_8wekyb3d8bbwe'
    '(Microsoft) Paint 3D'                 = 'Microsoft.MSPaint_8wekyb3d8bbwe'
    '(Microsoft) Paint'                    = '9PCFS5B6T72H'
    '(Microsoft) Phone Link'               = 'Microsoft.YourPhone_8wekyb3d8bbwe'
    '(Microsoft) Solitaire & Casual Games' = 'Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe'
    '(Microsoft) Skype'                    = '9WZDNCRFJ364'

    # Microsoft
    'Microsoft News'                       = '9WZDNCRFHVFW'
    'Microsoft Pay'                        = 'Microsoft.Wallet_8wekyb3d8bbwe'
    'Microsoft People'                     = 'Microsoft.People_8wekyb3d8bbwe'
    'Microsoft Photos'                     = 'Microsoft.Windows.Photos_8wekyb3d8bbwe'
    'Microsoft Skype'                      = 'Microsoft.Skype'
    'Microsoft Solitaire Collection'       = '9wzdncrfhwd2'
    'Microsoft Sticky Notes'               = '9NBLGGH4QGHW'
    'Microsoft Tips'                       = 'Microsoft.Getstarted_8wekyb3d8bbwe'

    # Microsoft Windows
    'Windows Maps'                         = 'Microsoft.WindowsMaps_8wekyb3d8bbwe'
    'Windows Media Player'                 = '9WZDNCRFJ3PT'
    'Windows Voice Recorder'               = 'Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe'

    # Microsoft Xbox
    'Xbox Console Companion'               = 'Microsoft.XboxApp_8wekyb3d8bbwe'
    'Xbox Game Bar Plugin'                 = 'Microsoft.XboxGameOverlay_8wekyb3d8bbwe'
    'Xbox Game Bar'                        = 'Microsoft.XboxGamingOverlay_8wekyb3d8bbwe'
    'Xbox Game Speech Window'              = 'Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe'
    'Xbox Identity Provider'               = 'Microsoft.XboxIdentityProvider_8wekyb3d8bbwe'
    'Xbox TCUI'                            = 'Microsoft.Xbox.TCUI_8wekyb3d8bbwe'

    # 3th party
    'Disney+'                              = 'Disney.37853FC22B2CE_6rarf9sa4v8jt'
    'Logitech - Bolt'                      = 'Logitech.LogiBolt'
    'Spotify Music'                        = 'SpotifyAB.SpotifyMusic_zpdnekdrzrea0'
    'Ubuntu'                               = 'CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc'
}



# Uninstall bloat-ware
Write-Information "`nUninstalling bloat-ware..."

$BloatWare.GetEnumerator() | ForEach-Object {

    # Uninstall bloat-ware
    Write-Information " - $($PSItem.Key)"

    winget uninstall --id $PSItem.Value --exact --purge --accept-source-agreements --silent --disable-interactivity | Out-Null
}



# Done!
Write-Information "`n[DONE]"
