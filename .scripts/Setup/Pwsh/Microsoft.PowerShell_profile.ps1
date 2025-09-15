# Import default PS:Modules
Import-Module -Name 'PSReadLine'
Import-Module -Name 'Terminal-Icons'



# Setup $PSStyle
$PSStyle.Formatting.FormatAccent = $PSStyle.Foreground.BrightGreen
$PSStyle.Formatting.TableHeader = $PSStyle.Foreground.Green
$PSStyle.Formatting.Warning = $PSStyle.Foreground.FromRgb(0xc6, 0x8b, 0x73)
$PSStyle.Formatting.Verbose = $PSStyle.Foreground.BrightBlue
$PSStyle.Formatting.Debug = $PSStyle.Foreground.Blue



# Setup PSReadLine
Set-PSReadLineOption -PredictionSource 'History'
Set-PSReadLineOption -PredictionViewStyle 'ListView'



# Setup oh-my-posh
oh-my-posh init pwsh --config "$PSScriptRoot\nordtron.omp.json" | Invoke-Expression



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



#region Invoke MsBuild
function Invoke-MsBuild {

    [CmdletBinding()]
    param (
        [Parameter()]
        $Path,

        [Parameter()]
        [string[]] $Target = @('Build'),

        [Parameter()]
        [string] $Configuration = 'Release',

        [Parameter()]
        [string] $Platform = 'Any CPU',

        [Parameter()]
        [System.Collections.IDictionary] $Property,

        [Parameter()]
        $OutDir = 'c:\dev\.out\',

        [Parameter()]
        $LogDir = 'c:\dev\.out\',

        [switch] $Clean,
        [switch] $Rebuild,
        [switch] $Restore
    )

    try {
        #region Verify & Resolve paths
        function local:ResolveFile ($ArgPath, [switch] $ThrowWhenNotExists) {
            if (-not $ArgPath) {
                return ''

            } elseif (-not $(Test-Path $ArgPath -PathType Leaf)) {
                if ($ThrowWhenNotExists) {
                    throw "Could not find file: $ArgPath"
                }
                return ''

            } else {
                return $(Resolve-Path $ArgPath).Path
            }
        }

        function local:ResolveDir ($ArgPath, [switch] $MkdirWhenNotExists) {
            if (-not $ArgPath) {
                return ''

            } elseif (-not $(Test-Path $ArgPath -PathType Container)) {
                if ($MkdirWhenNotExists) {
                    mkdir $ArgPath | Out-Null

                } else {
                    return ''
                }

            }

            return "$(Resolve-Path $ArgPath)\"
        }

        $Path = local:ResolveFile $Path
        if (-not $Path) {
            $Found = @(Get-ChildItem -Include '*.sln', '*.*proj' -File -Recurse)
            if ($Found.Count -ne 1) {
                throw 'Could not find single project or solution file!'

            } else {
                $Path = $Found[0].FullName
            }
        }

        $OutDir = local:ResolveDir $OutDir -MkdirWhenNotExists
        $LogDir = local:ResolveDir $LogDir -MkdirWhenNotExists
        #endregion Verify & Resolve paths



        # $RelDir = "$(Resolve-Path $(Split-Path $Path -Parent) -Relative)".Substring(2)

        $OutName = 'D{0:yyyy-MM-dd}-T{0:HH.mm.ss}-{1}' -f $(Get-Date), $PathName
        $OutDir = Join-Path $OutDir -ChildPath $Configuration -AdditionalChildPath $OutName
        $OutDir = local:ResolveDir $OutDir -MkdirWhenNotExists

        if ($LogDir) {
            $LogFile = Join-Path $LogDir -ChildPath "$OutName.binlog"
        }



        #region Init: $Target
        if (-not $Target) {
            $Target = @()
        }

        if ($Clean) {
            $Target += 'Clean'
        }

        if ($Rebuild) {
            $Target -= 'Build'
            $Target += 'Rebuild'
        }
        #endregion Init: $Target

        #region Init: $Property
        if (-not $Property) {
            $Property = [ordered] @{}
        }

        if ($Configuration) {
            $Property.Configuration = $Configuration
        }

        if ($Platform) {
            $Property.Platform = $Platform
        }

        if ($OutDir) {
            $Property.OutDir = $OutDir
        }
        #endregion

        #region Init: $BuildArg
        $BuildArgs = [System.Collections.Generic.List[[string]]]::new()

        function local:AddBuildArg ([string] $BuildArg) {
            [void]$BuildArgs.Add($BuildArg)
        }

        local:AddBuildArg $Path
        local:AddBuildArg "-target:$Target"

        if ($Property.Count) {
            foreach ($Prop in $Property.GetEnumerator()) {
                local:AddBuildArg $('-property:{0}={1}' -f $Prop.Key, $Prop.Value)
            }
        }

        if ($Restore) {
            local:AddBuildArg '-restore:true'
        }

        if ($LogFile) {
            local:AddBuildArg "-binaryLogger:LogFile=$LogFile"
        }
        #endregion Init: $BuildArg

        Write-Information "$($PSStyle.Foreground.BrightWhite + $PSStyle.Bold + 'Invoking MsBuild with:' + $PSStyle.BoldOff)"
        foreach ($Current in $BuildArgs) {
            Write-Information "$($PSStyle.Foreground.White + $PSStyle.Italic + $Current + $PSStyle.ItalicOff)"
        }
        Write-Information ''

        msbuild $BuildArgs

        if ($LASTEXITCODE) {
            throw "MsBuild exited with $LASTEXITCODE!"
        }

    } catch {
        $PSCmdlet.ThrowTerminatingError($PSItem)
    }
}
#endregion Invoke MsBuild
