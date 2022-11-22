# Import default PS:Modules
Import-Module -Name 'PSReadLine'
Import-Module -Name 'posh-git'
Import-Module -Name 'Terminal-Icons'



# Init PS:Settings
$global:PSNativeCommandArgumentPassing = 'Standard'

Set-PSReadLineOption -PredictionSource 'History'
Set-PSReadLineOption -PredictionViewStyle 'ListView'

$env:POSH_GIT_ENABLED = $true
oh-my-posh init pwsh --config "$PSScriptRoot\oh-my-posh.omp.json" | Invoke-Expression



# Add PS:Parameter completion => gh (github.cli)
gh completion --shell powershell | Out-String | Invoke-Expression



# Add PS:Parameter completion => dotnet
Register-ArgumentCompleter -Native -CommandName 'dotnet' -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}



# Add PS:Parameter completion => winget
Register-ArgumentCompleter -Native -CommandName 'winget' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    winget complete --word="$wordToComplete" --commandline "$commandAst" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}
