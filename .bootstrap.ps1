#Requires -Version 5.1
#Requires -RunAsAdministrator

param()



# Load logging functions
. "$PSScriptRoot\.bootstrap\.logging.ps1"



#region function Invoke-BootstrapScriptFile ([string] $ScriptFileName)
function Invoke-BootstrapScriptFile ([string] $ScriptFileName) {

    Write-LoggingWhenStarted "Resolving script file: $ScriptFileName"
    try {
        $ScriptFile = Resolve-Path "$PSScriptRoot\.bootstrap\$ScriptFileName"

        Write-LoggingWhenCompleted '[DONE]'

    } catch {

        Write-LoggingWhenFailed $PSItem
        exit -1
    }



    Write-LoggingWhenStarted 'Invoking script file: '

    $InvokedScript = @{
        Output    = $(cmd /c "powershell.exe -File `"$ScriptFile`" -NoLogo -NoProfile -ExecutionPolicy Unrestricted" | Out-String).Trim()
        ExitCode  = $LASTEXITCODE
        HasFailed = $LASTEXITCODE -ne 0
    }

    if ($InvokedScript.HasFailed) {

        Write-LoggingWhenFailed $InvokedScript.Output -ExitCode $InvokedScript.ExitCode
        exit $InvokedScript.ExitCode

    } else {

        Write-LoggingWhenCompleted '[DONE]'
        Write-Host "[CONSOLE-OUTPUT]`n$($InvokedScript.Output)`n`n"
    }
}
#endregion



# Invoke bootstrap scripts
Invoke-BootstrapScriptFile 'Install-WinGet.ps1'
Invoke-BootstrapScriptFile 'Install-Pwsh.ps1'
