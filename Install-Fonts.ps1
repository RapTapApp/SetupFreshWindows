$script:InformationPreference = 'Continue'



function Install-LatestReleasedFonts {

    Initialize-Script
    
    Push-Location $script:TargetDir
    try {
        Install-LatestReleasedFontsFrom 'JetBrains/JetBrainsMono'
        Install-LatestReleasedFontsFrom 'tonsky/FiraCode'
        Install-LatestReleasedFontsFrom 'ryanoasis/nerd-fonts' -Patterns @(
            'CascadiaCode.zip', 'FantasqueSansMono.zip', 'FiraCode.zip', 'Hasklig.zip', 
            'Inconsolata.zip', 'Iosevka.zip', 'JetBrainsMono.zip', 'Monoid.zip', 'VictorMono.zip'
        )
    }
    finally {
        Pop-Location
    }
}



function Initialize-Script {

    # Setup github authentication
    gh auth status --hostname 'github.com'
    if ($LASTEXITCODE) {
        gh auth login
    }
    
    
    
    # Setup font installer
    $script:FontInstaller = $(New-Object -ComObject Shell.Application).Namespace(
        $([System.Environment+SpecialFolder]::Fonts)
    )
    
    # Setup installed-fonts
    $script:InstalledFonts = [System.Collections.Generic.HashSet[string]]::new()
    @("$Env:USERPROFILE\AppData\Local\Microsoft\Windows\Fonts", "C:\Windows\fonts") |
        Get-ChildItem -Filter '*.ttf' -Recurse -File | 
        ForEach-Object {
            $(Get-FileHash $PSItem.FullName).Hash
        } |
        ForEach-Object {
            [void] $script:InstalledFonts.Add($PSItem)
        }
    
    
    
    # Setup target folder
    $script:TargetDir = Join-Path -Path $($env:TEMP ?? $PSScriptRoot) -ChildPath '.fonts'
    if ($(Test-Path -Path $TargetDir -PathType 'Container')) {
        Remove-Item -Path $TargetDir -Force -Recurse
    }
    
    mkdir $TargetDir | Out-Null
}



function Install-LatestReleasedFontsFrom ([string] $OwnerRepoPath, [string[]] $Patterns) {

    if (-not $Patterns) {
        $Patterns = @('*.zip')
    }

    $Patterns = $Patterns | Where-Object { $PSItem } | ForEach-Object { 
        Write-Output '--pattern' 
        Write-Output $PSItem
    }

    Write-Information "Downloading fonts from repo: $OwnerRepoPath..."
    gh release download --repo "$OwnerRepoPath" $Patterns --dir "$OwnerRepoPath"

    Push-Location $OwnerRepoPath
    try {
        Get-ChildItem -Path "." -Filter '*.zip' | 
            Expand-Archive -DestinationPath "." -Force -PassThru |
            Where-Object { 
                -not $PSItem.PSIsContainer -and $PSItem.Extension -eq '.ttf'
            } |
            Where-Object {
                $FileHash = $(Get-FileHash $PSItem.FullName).Hash
                -not $script:InstalledFonts.Contains($FileHash)
            } | 
            ForEach-Object {
                Write-Information $(" - Installing: " + $PSItem.Name)
                $FontInstaller.CopyHere($PSItem.FullName)

                [void] $script:InstalledFonts.Add($FileHash)
            }
    }
    finally {
        Pop-Location
    }
}



Install-LatestReleasedFonts
