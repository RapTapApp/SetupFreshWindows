#Requires -Version 5.1
#Requires -RunAsAdministrator

param()



# Load logging functions
. "$PSScriptRoot\.logging.ps1"



# Is WinGet installed?
Write-LoggingWhenStarted 'Is WinGet installed?'

cmd /c 'winget.exe -v' | Out-Null
if ($LASTEXITCODE -eq 0) {

    Write-LoggingWhenCompleted '[YES]'
    exit 0

} else {

    Write-LoggingWhenCompleted '[NO]'
}



# Installing WinGet...
Write-LoggingWhenStarted 'Installing WinGet'
try {
    Add-AppxPackage -RegisterByFamilyName -MainPackage 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe'

    Write-LoggingWhenCompleted '[DONE]'
    exit 0

} catch {

    Write-LoggingWhenFailed $PSItem
    exit -1
}
