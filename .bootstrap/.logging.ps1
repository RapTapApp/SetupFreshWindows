#Requires -Version 5.1

param()



$ProgressPreference = 'Ignore'

$PSDefaultParameterValues = @{
    'Write-Host:BackgroundColor' = [System.Console]::BackgroundColor
}

$FgLoggedWhen = @{
    Started   = [System.Console]::ForegroundColor
    Completed = [System.ConsoleColor]::Green
    Failed    = [System.ConsoleColor]::Red
}

function Write-LoggingWhenStarted ([string] $Logged) {
    Write-Host "`n$Logged => " -NoNewline -ForegroundColor $FgLoggedWhen.Started
}

function Write-LoggingWhenCompleted ([string] $Logged) {
    Write-Host $Logged -ForegroundColor $FgLoggedWhen.Completed
}

function Write-LoggingWhenFailed ([string] $LoggedError) {
    Write-Host "[FAILED]`n`n[ERROR]`n$LoggedError" -ForegroundColor $FgLoggedWhen.Failed
}

function Write-LoggingWhenFailed ([string] $ConsoleOutput, [int] $ExitCode) {
    Write-Host "[FAILED]`n`n[CONSOLE-OUTPUT]`n$ConsoleOutput`n`n[EXIT-CODE: $ExitCode]" -ForegroundColor $FgLoggedWhen.Failed
}
