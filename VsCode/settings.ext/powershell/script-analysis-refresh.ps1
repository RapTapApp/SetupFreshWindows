using namespace Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic
using namespace System.IO
using namespace System.Management.Automation
using namespace System.Text



$ErrorActionPreference = [ActionPreference]::Stop
$ProgressPreference = [ActionPreference]::Ignore

Set-Location $PSScriptRoot



$__Pssa_Module = @{
    Name           = 'PSScriptAnalyzer'
    MinimumVersion = '1.20.0'
}

Find-Module @__Pssa_Module |
    Where-Object Version -GT $__Pssa_Module.MinimumVersion |
    ForEach-Object {
        $__Pssa_Module.MinimumVersion = $PSItem.Version
    }

if (-not $(Get-InstalledModule @__Pssa_Module -ErrorAction Ignore)) {
    Install-Module @__Pssa_Module -Scope AllUsers | Out-Null
}

Import-Module @__Pssa_Module -Force



$script:__Settings_SourceFile = "$(Resolve-Path 'script-analysis.psd1')"



$script:__This_RepoDir = $(
    for ($__Dir = $PSScriptRoot; $__Dir; $__Dir = Split-Path $__Dir -Parent) {
        if ($(Test-Path "$__Dir\.git")) {
            Write-Output $__Dir
        }
    }
) ?? "$(Resolve-Path '../../../../')"

$script:__Root_RepoDir = "$(Split-Path $__This_RepoDir -Parent)"

$script:__Pssa_RepoDir = "$(Join-Path $__Root_RepoDir -ChildPath $__Pssa_Module.Name)"



if (-not $(Test-Path $__Pssa_RepoDir -PathType 'Container')) {
    try {
        Push-Location $__Root_RepoDir

        git clone 'https://github.com/PowerShell/PSScriptAnalyzer.git'
    } finally {
        Pop-Location
    }
} else {
    try {
        Push-Location $__Pssa_RepoDir

        git fetch
        git pull
    } finally {
        Pop-Location
    }
}



$script:__Settings = Import-PowerShellDataFile -LiteralPath $__Settings_SourceFile



function Export-RuleSettingsFile {

    $__Settings_Script = "$(Get-ScriptAnalyzerRule | Format-AllRuleConfig)" -replace "`r", ''

    Set-Content -LiteralPath $__Settings_SourceFile -Value $__Settings_Script -Encoding utf8NoBOM

    $__Settings_Script = Invoke-Formatter -ScriptDefinition $__Settings_Script -Settings $__Settings_SourceFile

    Set-Content -LiteralPath $__Settings_SourceFile -Value $__Settings_Script -Encoding utf8NoBOM
}



function Format-AllRuleConfig {

    $OTBS = @(
        'PSAlignAssignmentStatement',
        'PSPlaceCloseBrace',
        'PSPlaceOpenBrace',
        'PSUseConsistentIndentation',
        'PSUseConsistentWhitespace',
        'PSUseCorrectCasing'
    )



    $AllRules = @($input) |
        Select-Object '*', @{
            n = 'Index'
            e = { ($PSItem.RuleName -in $OTBS) ? 'OTBS' : $PSItem.SourceName }
        } |
        Group-Object 'Index' -AsHashTable


    $AllRulesScript = $(
        $AllRules.GetEnumerator() |
            Sort-Object Key |
            ForEach-Object {
                $__Index = $PSItem.Key
                $__Rules = "$(
                    @($PSItem.Value) | Sort-Object RuleName | Format-RuleConfig | Join-String -Separator "`n"
                )"

                return @"
            `#region -- $__Index --

$__Rules
            `#endregion -- $__Index --

"@
            } |
            Join-String -Separator "`n`n`n"
    )

    return @"
@{
    Severity = @(
        'Error',
        'Warning',
        'ParseError',
        'Information'
    )



    Rules    = @{

$AllRulesScript
    }
}
"@
}



function Format-RuleConfig {

    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string] $Index,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string] $Severity,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string] $RuleName,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string] $CommonName,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string] $Description,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Type] $ImplementingType
    )

    begin {
        function Get-DocUri ($RuleName) {

            $__Rule = $($RuleName -match '^(PS)(?<Rule>.*)$' ?
                $Matches.Rule :
                $RuleName
            )

            $__Path = "docs/Rules/$__Rule.md"

            if ($(Test-Path "$__Pssa_RepoDir/$__Path" -PathType Leaf)) {
                return "https://github.com/PowerShell/PSScriptAnalyzer/blob/master/$__Path"
            } else {
                Write-Error "Did not find rule documentation for rule: $__Rule" -ea Continue
                return '[unknown]'
            }
        }
    }

    process {
        return @"
        `#region --[ $Index ] $RuleName => $Severity --
        $RuleName = @{
            <`#
                Title:
                $CommonName

                Description:
$(@($Description) | Write-WordWrapped -Indent 16 -MaxWidth 128 | Join-String -Separator "`n")

                Docs:
                $(Get-DocUri $RuleName)
            `#>
$(
    Get-RuleConfig -RuleName $RuleName -RuleType $ImplementingType | Join-String -Separator "`n"
)
        }
        `#endregion -- $Index = $RuleName => $Severity --

"@
    }
}



function Get-RuleConfig([string] $RuleName, [Type] $RuleType) {

    $__ConfigProps = [ordered] @{
        Enable = '$true'
    }

    foreach ($__RuleProp in @($RuleType.GetProperties() | Sort-Object Name)) {
        $__PropName = $__RuleProp.Name

        foreach ($__ConfigAttribute in $__RuleProp.GetCustomAttributes($true)) {

            if ($__ConfigAttribute.GetType() -eq $([ConfigurableRulePropertyAttribute]) ) {
                $__PropValue = Get-RuleConfigPropValue -RuleName $RuleName -PropName $__PropName -AttrValue $__ConfigAttribute.DefaultValue

                if ($__ConfigProps.Contains($__PropName)) {
                    $__ConfigProps[$__PropName] = $__PropValue

                } else {
                    $__ConfigProps.Add($__PropName, $__PropValue)
                }
            }
        }
    }

    $__ConfigProps.GetEnumerator() | ForEach-Object {
        '{0} = {1}' -f $PSItem.Name, $PSItem.Value
    }
}



function Get-RuleConfigPropValue([string] $RuleName, [string] $PropName, [string] $AttrValue) {

    $__Found = $script:__Settings.Rules.$RuleName.$PropName

    return Format-RuleConfigPropValue $($__Found ?? $AttrValue)
}



function Format-RuleConfigPropValue($PropValue) {

    if (@($PropValue).Count -gt 1) {
        return $(
            $PropValue |
                ForEach-Object { Format-RuleConfigPropValue $PSItem } |
                Join-String -OutputPrefix '@(' -Separator ', ' -OutputSuffix ')'
        )
    }

    if ([string]::IsNullOrEmpty($PropValue)) {
        return "''"
    }

    if ('true' -eq "$PropValue") {
        return '$true'
    }

    if ('false' -eq "$PropValue") {
        return '$false'
    }

    if ("$PropValue" -imatch '^\d+$') {
        return $PropValue
    }

    return "'$PropValue'"
}

function Write-WordWrapped {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string[]]$Text,

        [Parameter()]
        [int] $MaxWidth = $Host.UI.RawUI.BufferSize.Width,

        [Parameter()]
        [int] $Indent = 0
    )

    begin {
        if ($Indent -lt 0) {
            throw [ArgumentOutOfRangeException]::new('Indent')
        }
        if ($MaxWidth -lt $Indent) {
            throw [ArgumentOutOfRangeException]::new('MaxWidth')
        }

        $__Output = [StringBuilder]::new()



        function Write-Line () {
            if ($__Output.Length) {

                Write-Output $__Output.ToString()
                [void] $__Output.Clear()
            }
        }

        function Test-AddWord ([string] $Word) {
            ($__Output.Length -eq 0) -or
            ($__Output.Length + $Word.Length + 1) -lt $MaxWidth
        }

        function Add-Word ([string] $Word) {
            if ($__Output.Length) {
                [void] $__Output.Append(' ')

            } elseif ($Indent) {
                [void] $__Output.Append(' ', $Indent)
            }

            [void] $__Output.Append($Word)
        }

        function Receive-Paragraph ([string] $Paragraph) {
            if ($Paragraph) {
                foreach ($__Line in @($Paragraph -split '\r?\n')) {
                    Receive-Line $__Line
                }
            }

            Write-Line
        }

        function Receive-Line ([string] $Line) {
            if ($Line) {
                foreach ($__Word in @($Line -split '\s+')) {
                    Receive-Word $__Word
                }
            }

            Write-Line
        }

        function Receive-Word ([string] $Word) {
            if ($__Word) {
                if (-not $(Test-AddWord $__Word)) {
                    Write-Line
                }

                Add-Word $__Word
            }
        }
    }

    process {
        foreach ($__Paragraph in @($Text)) {
            Receive-Paragraph $__Paragraph
        }
    }

    end {
        Write-Line
    }
}


Export-RuleSettingsFile
