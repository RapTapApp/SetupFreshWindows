#Requires -Version 7.3
#Requires -RunAsAdministrator

param()

$InformationPreference = 'Continue'



function Install-LatestReleasedFonts {

    # Install fonts
    Write-Information "`nInstalling latest released fonts..."

    Initialize-Script

    Push-Location $script:TargetDir
    try {
        Install-LatestReleasedFontsFrom 'JetBrains/JetBrainsMono'
        Install-LatestReleasedFontsFrom 'tonsky/FiraCode'
        Install-LatestReleasedFontsFrom 'ryanoasis/nerd-fonts' -Patterns @(
            'CascadiaCode.zip', 'FantasqueSansMono.zip', 'FiraCode.zip', 'Hasklig.zip',
            'Inconsolata.zip', 'Iosevka.zip', 'JetBrainsMono.zip', 'Monoid.zip', 'VictorMono.zip'
        )
    } finally {
        Pop-Location
    }

    # Done!
    Write-Information "`n[DONE]"
}



function Initialize-Script {

    # Setup github authentication
    Write-Information "`nSetup: github authentication..."

    gh auth status --hostname 'github.com'
    if ($LASTEXITCODE) {
        gh auth login
    }



    # Setup font installer
    Write-Information "`nSetup: font installer..."

    $script:FontInstaller = $(New-Object -ComObject Shell.Application).Namespace(
        $([System.Environment+SpecialFolder]::Fonts)
    )



    # Setup installed-font-hashes
    Write-Information "`nSetup: installed-font-hashes..."

    $script:InstalledFontHashes = [System.Collections.Generic.HashSet[string]]::new()

    @("$Env:USERPROFILE\AppData\Local\Microsoft\Windows\Fonts", 'C:\Windows\fonts') |
        Get-ChildItem -Filter '*.ttf' -Recurse -File |
        ForEach-Object {
            $(Get-FileHash $PSItem.FullName).Hash
        } |
        ForEach-Object {
            [void] $script:InstalledFontHashes.Add($PSItem)
        }



    # Setup target folder
    Write-Information "`nSetup: target folder..."

    $script:TargetDir = Join-Path -Path $($env:TEMP ?? $PSScriptRoot) -ChildPath '.fonts'

    if ($(Test-Path -Path $TargetDir -PathType 'Container')) {
        Remove-Item -Path $TargetDir -Force -Recurse
    }

    mkdir $TargetDir | Out-Null
}



function Install-LatestReleasedFontsFrom ([string] $OwnerRepoPath, [string[]] $Patterns) {

    # Download fonts from repo
    Write-Information "`n * Downloading latest released fonts from repo: $OwnerRepoPath..."

    if (-not $Patterns) {
        $Patterns = @('*.zip')
    }

    $PatArgs = $Patterns | Where-Object { $PSItem } | ForEach-Object {
        Write-Output @('--pattern', $PSItem)
    }

    gh release download --repo "$OwnerRepoPath" $PatArgs --dir "$OwnerRepoPath"



    Push-Location $OwnerRepoPath
    try {
        # Get new font files
        Write-Information '   Getting new fonts...'

        $NewFonts = @(
            Get-ChildItem -Path '.' -Filter '*.zip' |
                Expand-Archive -DestinationPath '.' -Force -PassThru |
                Where-Object {
                    # Is font file
                    -not $PSItem.PSIsContainer -and $PSItem.Extension -eq '.ttf'
                } |
                Where-Object {
                    # Is font (hash) not (yet) installed
                    $FontHash = $(Get-FileHash $PSItem.FullName).Hash

                    -not $script:InstalledFontHashes.Contains($FontHash)
                }
        )



        if ($NewFonts) {
            # Install new fonts
            Write-Information '   Installing new fonts...'

            $NewFonts | ForEach-Object {

                # Install new font file
                Write-Information $('    - ' + $PSItem.Name)

                $FontInstaller.CopyHere($PSItem.FullName)

                [void] $script:InstalledFontHashes.Add($FontHash)
            }

            Write-Information ''
        }
    } finally {
        Pop-Location
    }
}



Install-LatestReleasedFonts
