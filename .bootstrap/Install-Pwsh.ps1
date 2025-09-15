#Requires -Version 5.1
#Requires -RunAsAdministrator

param()



# Load logging functions
. "$PSScriptRoot\.logging.ps1"



# Is pwsh installed?
Write-LoggingWhenStarted 'Is pwsh installed?'

cmd /c 'winget.exe list --id Microsoft.PowerShell --exact' | Out-Null
if ($LASTEXITCODE -eq 0) {

    Write-LoggingWhenCompleted '[YES]'
    exit 0

} else {

    Write-LoggingWhenCompleted '[NO]'
}



# Installing pwsh
Write-LoggingWhenStarted 'Installing pwsh'

$Install = @{
    Output       = cmd /c 'winget.exe install --id Microsoft.PowerShell --exact' | Out-String
    ExitCode     = $LASTEXITCODE
    HasCompleted = $LASTEXITCODE -eq 0
}

if ($Install.HasCompleted) {

    Write-LoggingWhenCompleted '[DONE]'
    exit 0

} else {

    Write-LoggingWhenFailed $Install.Output -ExitCode $Install.ExitCode
    exit $Install.ExitCode
}
