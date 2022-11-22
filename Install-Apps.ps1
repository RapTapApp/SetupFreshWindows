#Requires -Version 7.3
#Requires -RunAsAdministrator

param([switch] $NZXT)


# Uninstall bloatware-apps
winget uninstall 'Clipchamp'
winget uninstall 'Films & TV'
winget uninstall 'LogiBolt'
winget uninstall 'Microsoft News'
winget uninstall 'Microsoft Solitaire Collection'
winget uninstall 'Microsoft Sticky Notes'
winget uninstall 'OneNote for Windows 10'
winget uninstall 'Paint'
winget uninstall 'Skype'
winget uninstall 'Windows Media Player'



# Revert stupid context menu @ File Explorer
reg.exe add 'HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32' /f /ve



# Install apps
winget install '7zip.7zip'
winget install 'Git.Git'
winget install 'GitHub.cli'
winget install 'Google.Chrome'
winget install 'JanDeDobbeleer.OhMyPosh'
winget install 'JGraph.Draw'
winget install 'KirillOsenkov.MSBuildStructuredLogViewer'
winget install 'Microsoft.AzureCLI'
Winget install 'Microsoft.Bicep'
winget install 'Microsoft.PowerToys'
winget install 'Microsoft.VisualStudioCode' -i
winget install 'Microsoft.WindowsTerminal.Preview'
winget install 'VideoLAN.VLC'
winget install 'Windows Performance Analyzer (Preview)'

if ($NZXT.IsPresent) {
    winget install 'NZXT.CAM'
}



# Setup git
git config --system init.defaultbranch 'main'

git config --global user.name 'Cees van Berkel'
git config --global user.email 'cees@raptapapp.com'



# Install bicep into az.cli
az bicep install && az bicep upgrade
