#Requires -RunAsAdministrator

param([switch] $NZXT)



winget install 'Microsoft.PowerShell'

Set-Location $PSScriptRoot

pwsh -NoProfile -File .\Install-Apps.ps1 -NZXT:$NZXT.IsPresent
pwsh -NoProfile -File .\Install-Dockers.ps1
pwsh -NoProfile -File .\Install-Fonts.ps1
pwsh -NoProfile -File .\Install-PowerToys.ps1
pwsh -NoProfile -File .\Install-Pwsh.ps1
pwsh -NoProfile -File .\Install-Terminal.ps1
pwsh -NoProfile -File .\Install-VsCode.ps1
