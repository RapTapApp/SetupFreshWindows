#Requires -Version 7.3

param()

$InformationPreference = 'Continue'

Set-Location $PSScriptRoot



try {
    Push-Location 'PowerToys'

    $TargetDir = Join-Path -Path $env:LOCALAPPDATA -ChildPath 'Microsoft\PowerToys'



    # Copy PowerToys: config files
    Write-Information 'Copying PowerToys: config files...'

    Get-ChildItem -Filter '*.json' -File -Recurse | ForEach-Object {

        # Get source & targets
        $SourceRelPath = Resolve-Path $PSItem -Relative

        $TargetFile = Join-Path -Path $TargetDir -ChildPath $SourceRelPath
        $TargetFileDir = Split-Path $TargetFile -Parent



        if (-not $(Test-Path -Path $TargetFileDir -PathType 'Container')) {

            # Create config dir
            Write-Information " ! $(Split-Path $SourceRelPath -Parent)"

            mkdir $TargetFileDir | Out-Null
        }



        # Copy PowerToys: config file
        Write-Information " - $SourceRelPath"

        $PSItem | Copy-Item -Destination $TargetFile -Force
    }

} finally {
    Pop-Location
}



# Done!
Write-Information "`n[DONE]"
