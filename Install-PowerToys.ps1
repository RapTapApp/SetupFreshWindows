# Setup I/O Files
$SourceDir = Join-Path -Path $PSScriptRoot -ChildPath 'PowerToys'
$TargetDir = Join-Path -Path $env:LOCALAPPDATA -ChildPath 'Microsoft\PowerToys'



# Copy PowerToys: *.json settings
try {
    Push-Location $SourceDir

    Get-ChildItem -Filter '*.json' -File -Recurse | ForEach-Object {
        $TargetFile = Join-Path -Path $TargetDir -ChildPath $(Resolve-Path $PSItem -Relative)

        $TargetFileDir = Split-Path $TargetFile -Parent
        if (-not $(Test-Path -Path $TargetFileDir -PathType 'Container')) {
            mkdir $TargetFileDir | Out-Null
        }

        $PSItem | Copy-Item -Destination $TargetFile -Force
    }

} finally {
    Pop-Location
}
