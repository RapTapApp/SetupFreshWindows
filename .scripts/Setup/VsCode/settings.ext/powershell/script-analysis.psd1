@{
    Severity = @(
        'Error',
        'Warning',
        'ParseError',
        'Information'
    )



    Rules    = @{

        #region -- OTBS --

        #region --[ OTBS ] PSAlignAssignmentStatement => Warning --
        PSAlignAssignmentStatement                     = @{
            <#
                Title:
                Align assignment statement

                Description:
                Line up assignment statements such that the assignment operator are aligned.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AlignAssignmentStatement.md
            #>
            Enable         = $true
            CheckHashtable = $true
        }
        #endregion -- OTBS = PSAlignAssignmentStatement => Warning --

        #region --[ OTBS ] PSPlaceCloseBrace => Warning --
        PSPlaceCloseBrace                              = @{
            <#
                Title:
                Place close braces

                Description:
                Close brace should be on a new line by itself.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/PlaceCloseBrace.md
            #>
            Enable             = $true
            IgnoreOneLineBlock = $true
            NewLineAfter       = $false
            NoEmptyLineBefore  = $false
        }
        #endregion -- OTBS = PSPlaceCloseBrace => Warning --

        #region --[ OTBS ] PSPlaceOpenBrace => Warning --
        PSPlaceOpenBrace                               = @{
            <#
                Title:
                Place open braces consistently

                Description:
                Place open braces either on the same line as the preceding expression or on a new line.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/PlaceOpenBrace.md
            #>
            Enable             = $true
            IgnoreOneLineBlock = $true
            NewLineAfter       = $true
            OnSameLine         = $true
        }
        #endregion -- OTBS = PSPlaceOpenBrace => Warning --

        #region --[ OTBS ] PSUseConsistentIndentation => Warning --
        PSUseConsistentIndentation                     = @{
            <#
                Title:
                Use consistent indentation

                Description:
                Each statement block should have a consistent indenation.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseConsistentIndentation.md
            #>
            Enable              = $true
            IndentationSize     = 4
            Kind                = 'Space'
            PipelineIndentation = 'IncreaseIndentationForFirstPipeline'
        }
        #endregion -- OTBS = PSUseConsistentIndentation => Warning --

        #region --[ OTBS ] PSUseConsistentWhitespace => Warning --
        PSUseConsistentWhitespace                      = @{
            <#
                Title:
                Use whitespaces

                Description:
                Check for whitespace between keyword and open paren/curly, around assigment operator ('='), around arithmetic
                operators and after separators (',' and ';')

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseConsistentWhitespace.md
            #>
            Enable                                  = $true
            CheckInnerBrace                         = $true
            CheckOpenBrace                          = $true
            CheckOpenParen                          = $true
            CheckOperator                           = $false
            CheckParameter                          = $false
            CheckPipe                               = $true
            CheckPipeForRedundantWhitespace         = $true
            CheckSeparator                          = $true
            IgnoreAssignmentOperatorInsideHashTable = $false
        }
        #endregion -- OTBS = PSUseConsistentWhitespace => Warning --

        #region --[ OTBS ] PSUseCorrectCasing => Information --
        PSUseCorrectCasing                             = @{
            <#
                Title:
                Use exact casing of cmdlet/function/parameter name.

                Description:
                For better readability and consistency, use the exact casing of the cmdlet/function/parameter.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseCorrectCasing.md
            #>
            Enable = $true
        }
        #endregion -- OTBS = PSUseCorrectCasing => Information --

        #endregion -- OTBS --



        #region -- PS --

        #region --[ PS ] PSAvoidAssignmentToAutomaticVariable => Warning --
        PSAvoidAssignmentToAutomaticVariable           = @{
            <#
                Title:
                Changing automtic variables might have undesired side effects

                Description:
                This automatic variables is built into PowerShell and readonly.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidAssignmentToAutomaticVariable.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidAssignmentToAutomaticVariable => Warning --

        #region --[ PS ] PSAvoidDefaultValueForMandatoryParameter => Warning --
        PSAvoidDefaultValueForMandatoryParameter       = @{
            <#
                Title:
                Avoid Default Value For Mandatory Parameter

                Description:
                Mandatory parameter should not be initialized with a default value in the param block because this value will
                be ignored.. To fix a violation of this rule, please avoid initializing a value for the mandatory parameter in
                the param block.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidDefaultValueForMandatoryParameter.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidDefaultValueForMandatoryParameter => Warning --

        #region --[ PS ] PSAvoidDefaultValueSwitchParameter => Warning --
        PSAvoidDefaultValueSwitchParameter             = @{
            <#
                Title:
                Switch Parameters Should Not Default To True

                Description:
                Switch parameter should not default to true.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidDefaultValueSwitchParameter.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidDefaultValueSwitchParameter => Warning --

        #region --[ PS ] PSAvoidGlobalAliases => Warning --
        PSAvoidGlobalAliases                           = @{
            <#
                Title:
                Avoid global aliases.

                Description:
                Checks that global aliases are not used. Global aliases are strongly discouraged as they overwrite desired
                aliases with name conflicts.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidGlobalAliases.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidGlobalAliases => Warning --

        #region --[ PS ] PSAvoidGlobalFunctions => Warning --
        PSAvoidGlobalFunctions                         = @{
            <#
                Title:
                Avoid global functiosn and aliases

                Description:
                Checks that global functions and aliases are not used. Global functions are strongly discouraged as they can
                cause errors across different systems.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidGlobalFunctions.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidGlobalFunctions => Warning --

        #region --[ PS ] PSAvoidGlobalVars => Warning --
        PSAvoidGlobalVars                              = @{
            <#
                Title:
                No Global Variables

                Description:
                Checks that global variables are not used. Global variables are strongly discouraged as they can cause errors
                across different systems.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidGlobalVars.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidGlobalVars => Warning --

        #region --[ PS ] PSAvoidInvokingEmptyMembers => Warning --
        PSAvoidInvokingEmptyMembers                    = @{
            <#
                Title:
                Avoid Invoking Empty Members

                Description:
                Invoking non-constant members would cause potential bugs. Please double check the syntax to make sure members
                invoked are non-constant.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidInvokingEmptyMembers.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidInvokingEmptyMembers => Warning --

        #region --[ PS ] PSAvoidLongLines => Warning --
        PSAvoidLongLines                               = @{
            <#
                Title:
                Avoid long lines

                Description:
                Line lengths should be less than the configured maximum

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidLongLines.md
            #>
            Enable            = $false
            MaximumLineLength = 120
        }
        #endregion -- PS = PSAvoidLongLines => Warning --

        #region --[ PS ] PSAvoidMultipleTypeAttributes => Warning --
        PSAvoidMultipleTypeAttributes                  = @{
            <#
                Title:
                Avoid multiple type specifiers on parameters

                Description:
                Prameter should not have more than one type specifier.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidMultipleTypeAttributes.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidMultipleTypeAttributes => Warning --

        #region --[ PS ] PSAvoidNullOrEmptyHelpMessageAttribute => Warning --
        PSAvoidNullOrEmptyHelpMessageAttribute         = @{
            <#
                Title:
                Avoid using null or empty HelpMessage parameter attribute.

                Description:
                Setting the HelpMessage attribute to an empty string or null value causes PowerShell interpreter to throw an
                error while executing the corresponding function.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidNullOrEmptyHelpMessageAttribute.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidNullOrEmptyHelpMessageAttribute => Warning --

        #region --[ PS ] PSAvoidOverwritingBuiltInCmdlets => Warning --
        PSAvoidOverwritingBuiltInCmdlets               = @{
            <#
                Title:
                Avoid overwriting built in cmdlets

                Description:
                Do not overwrite the definition of a cmdlet that is included with PowerShell

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidOverwritingBuiltInCmdlets.md
            #>
            Enable            = $false
            PowerShellVersion = @('core-6.1.0-linux', 'core-6.1.0-windows')
        }
        #endregion -- PS = PSAvoidOverwritingBuiltInCmdlets => Warning --

        #region --[ PS ] PSAvoidSemicolonsAsLineTerminators => Warning --
        PSAvoidSemicolonsAsLineTerminators             = @{
            <#
                Title:
                Avoid semicolons as line terminators

                Description:
                Line should not end with a semicolon

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidSemicolonsAsLineTerminators.md
            #>
            Enable = $false
        }
        #endregion -- PS = PSAvoidSemicolonsAsLineTerminators => Warning --

        #region --[ PS ] PSAvoidShouldContinueWithoutForce => Warning --
        PSAvoidShouldContinueWithoutForce              = @{
            <#
                Title:
                Avoid Using ShouldContinue Without Boolean Force Parameter

                Description:
                Functions that use ShouldContinue should have a boolean force parameter to allow user to bypass it.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidShouldContinueWithoutForce.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidShouldContinueWithoutForce => Warning --

        #region --[ PS ] PSAvoidTrailingWhitespace => Information --
        PSAvoidTrailingWhitespace                      = @{
            <#
                Title:
                Avoid trailing whitespace

                Description:
                Each line should have no trailing whitespace.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidTrailingWhitespace.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidTrailingWhitespace => Information --

        #region --[ PS ] PSAvoidUsingBrokenHashAlgorithms => Warning --
        PSAvoidUsingBrokenHashAlgorithms               = @{
            <#
                Title:
                Avoid Using Broken Hash Algorithms

                Description:
                Avoid using the broken algorithms MD5 or SHA-1.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidUsingBrokenHashAlgorithms.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidUsingBrokenHashAlgorithms => Warning --

        #region --[ PS ] PSAvoidUsingCmdletAliases => Warning --
        PSAvoidUsingCmdletAliases                      = @{
            <#
                Title:
                Avoid Using Cmdlet Aliases or omitting the 'Get-' prefix.

                Description:
                An alias is an alternate name or nickname for a cmdlet or for a command element, such as a function, script,
                file, or executable file. An implicit alias is also the omission of the 'Get-' prefix for commands with this
                prefix. But when writing scripts that will potentially need to be maintained over time, either by the original
                author or another Windows PowerShell scripter, please consider using full cmdlet name instead of alias. Aliases
                can introduce these problems, readability, understandability and availability.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidUsingCmdletAliases.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidUsingCmdletAliases => Warning --

        #region --[ PS ] PSAvoidUsingComputerNameHardcoded => Error --
        PSAvoidUsingComputerNameHardcoded              = @{
            <#
                Title:
                Avoid Using ComputerName Hardcoded

                Description:
                The ComputerName parameter of a cmdlet should not be hardcoded as this will expose sensitive information about
                the system.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidUsingComputerNameHardcoded.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidUsingComputerNameHardcoded => Error --

        #region --[ PS ] PSAvoidUsingConvertToSecureStringWithPlainText => Error --
        PSAvoidUsingConvertToSecureStringWithPlainText = @{
            <#
                Title:
                Avoid Using SecureString With Plain Text

                Description:
                Using ConvertTo-SecureString with plain text will expose secure information.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidUsingConvertToSecureStringWithPlainText.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidUsingConvertToSecureStringWithPlainText => Error --

        #region --[ PS ] PSAvoidUsingDeprecatedManifestFields => Warning --
        PSAvoidUsingDeprecatedManifestFields           = @{
            <#
                Title:
                Avoid Using Deprecated Manifest Fields

                Description:
                "ModuleToProcess" is obsolete in the latest PowerShell version. Please update with the latest field
                "RootModule" in manifest files to avoid PowerShell version inconsistency.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidUsingDeprecatedManifestFields.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidUsingDeprecatedManifestFields => Warning --

        #region --[ PS ] PSAvoidUsingDoubleQuotesForConstantString => Information --
        PSAvoidUsingDoubleQuotesForConstantString      = @{
            <#
                Title:
                Avoid using double quotes if the string is constant.

                Description:
                Use single quotes if the string is constant.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidUsingDoubleQuotesForConstantString.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidUsingDoubleQuotesForConstantString => Information --

        #region --[ PS ] PSAvoidUsingEmptyCatchBlock => Warning --
        PSAvoidUsingEmptyCatchBlock                    = @{
            <#
                Title:
                Avoid Using Empty Catch Block

                Description:
                Empty catch blocks are considered poor design decisions because if an error occurs in the try block, this error
                is simply swallowed and not acted upon. While this does not inherently lead to bad things. It can and this
                should be avoided if possible. To fix a violation of this rule, using Write-Error or throw statements in catch
                blocks.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidUsingEmptyCatchBlock.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidUsingEmptyCatchBlock => Warning --

        #region --[ PS ] PSAvoidUsingInvokeExpression => Warning --
        PSAvoidUsingInvokeExpression                   = @{
            <#
                Title:
                Avoid Using Invoke-Expression

                Description:
                The Invoke-Expression cmdlet evaluates or runs a specified string as a command and returns the results of the
                expression or command. It can be extraordinarily powerful so it is not that you want to never use it but you
                need to be very careful about using it. In particular, you are probably on safe ground if the data only comes
                from the program itself. If you include any data provided from the user - you need to protect yourself from
                Code Injection. To fix a violation of this rule, please remove Invoke-Expression from script and find other
                options instead.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidUsingInvokeExpression.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidUsingInvokeExpression => Warning --

        #region --[ PS ] PSAvoidUsingPlainTextForPassword => Warning --
        PSAvoidUsingPlainTextForPassword               = @{
            <#
                Title:
                Avoid Using Plain Text For Password Parameter

                Description:
                Password parameters that take in plaintext will expose passwords and compromise the security of your system.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidUsingPlainTextForPassword.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidUsingPlainTextForPassword => Warning --

        #region --[ PS ] PSAvoidUsingPositionalParameters => Information --
        PSAvoidUsingPositionalParameters               = @{
            <#
                Title:
                Avoid Using Positional Parameters

                Description:
                Readability and clarity should be the goal of any script we expect to maintain over time. When calling a
                command that takes parameters, where possible consider using name parameters as opposed to positional
                parameters. To fix a violation of this rule, please use named parameters instead of positional parameters when
                calling a command.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidUsingPositionalParameters.md
            #>
            Enable           = $true
            CommandAllowList = 'az'
        }
        #endregion -- PS = PSAvoidUsingPositionalParameters => Information --

        #region --[ PS ] PSAvoidUsingUsernameAndPasswordParams => Error --
        PSAvoidUsingUsernameAndPasswordParams          = @{
            <#
                Title:
                Avoid Using Username and Password Parameters

                Description:
                Functions should take in a Credential parameter of type PSCredential (with a Credential transformation
                attribute defined after it in PowerShell 4.0 or earlier) or set the Password parameter to type SecureString.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidUsingUsernameAndPasswordParams.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidUsingUsernameAndPasswordParams => Error --

        #region --[ PS ] PSAvoidUsingWMICmdlet => Warning --
        PSAvoidUsingWMICmdlet                          = @{
            <#
                Title:
                Avoid Using Get-WMIObject, Remove-WMIObject, Invoke-WmiMethod, Register-WmiEvent, Set-WmiInstance

                Description:
                Deprecated. Starting in Windows PowerShell 3.0, these cmdlets have been superseded by CIM cmdlets.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidUsingWMICmdlet.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidUsingWMICmdlet => Warning --

        #region --[ PS ] PSAvoidUsingWriteHost => Warning --
        PSAvoidUsingWriteHost                          = @{
            <#
                Title:
                Avoid Using Write-Host

                Description:
                Avoid using the Write-Host cmdlet. Instead, use Write-Output, Write-Verbose, or Write-Information. Because
                Write-Host is host-specific, its implementation might vary unpredictably. Also, prior to PowerShell 5.0,
                Write-Host did not write to a stream, so users cannot suppress it, capture its value, or redirect it.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/AvoidUsingWriteHost.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSAvoidUsingWriteHost => Warning --

        #region --[ PS ] PSMisleadingBacktick => Warning --
        PSMisleadingBacktick                           = @{
            <#
                Title:
                Misleading Backtick

                Description:
                Ending a line with an escaped whitepsace character is misleading. A trailing backtick is usually used for line
                continuation. Users typically don't intend to end a line with escaped whitespace.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/MisleadingBacktick.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSMisleadingBacktick => Warning --

        #region --[ PS ] PSMissingModuleManifestField => Warning --
        PSMissingModuleManifestField                   = @{
            <#
                Title:
                Module Manifest Fields

                Description:
                Some fields of the module manifest (such as ModuleVersion) are required.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/MissingModuleManifestField.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSMissingModuleManifestField => Warning --

        #region --[ PS ] PSPossibleIncorrectComparisonWithNull => Warning --
        PSPossibleIncorrectComparisonWithNull          = @{
            <#
                Title:
                Null Comparison

                Description:
                Checks that $null is on the left side of any equaltiy comparisons (eq, ne, ceq, cne, ieq, ine). When there is
                an array on the left side of a null equality comparison, PowerShell will check for a $null IN the array rather
                than if the array is null. If the two sides of the comaprision are switched this is fixed. Therefore, $null
                should always be on the left side of equality comparisons just in case.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/PossibleIncorrectComparisonWithNull.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSPossibleIncorrectComparisonWithNull => Warning --

        #region --[ PS ] PSPossibleIncorrectUsageOfAssignmentOperator => Information --
        PSPossibleIncorrectUsageOfAssignmentOperator   = @{
            <#
                Title:
                '=' is not an assignment operator. Did you mean the equality operator '-eq'?

                Description:
                '=' or '==' are not comparison operators in the PowerShell language and rarely needed inside conditional
                statements.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/PossibleIncorrectUsageOfAssignmentOperator.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSPossibleIncorrectUsageOfAssignmentOperator => Information --

        #region --[ PS ] PSPossibleIncorrectUsageOfRedirectionOperator => Warning --
        PSPossibleIncorrectUsageOfRedirectionOperator  = @{
            <#
                Title:
                '>' is not a comparison operator. Use  '-gt' (greater than) or '-ge' (greater or equal).

                Description:
                When switching between different languages it is easy to forget that '>' does not mean 'great than' in
                PowerShell.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/PossibleIncorrectUsageOfRedirectionOperator.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSPossibleIncorrectUsageOfRedirectionOperator => Warning --

        #region --[ PS ] PSProvideCommentHelp => Information --
        PSProvideCommentHelp                           = @{
            <#
                Title:
                Basic Comment Help

                Description:
                Checks that all cmdlets have a help comment. This rule only checks existence. It does not check the content of
                the comment.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/ProvideCommentHelp.md
            #>
            Enable                  = $true
            BlockComment            = $true
            ExportedOnly            = $true
            Placement               = 'Before'
            VSCodeSnippetCorrection = $false
        }
        #endregion -- PS = PSProvideCommentHelp => Information --

        #region --[ PS ] PSReservedCmdletChar => Warning --
        PSReservedCmdletChar                           = @{
            <#
                Title:
                Reserved Cmdlet Chars

                Description:
                Checks for reserved characters in cmdlet names. These characters usually cause a parsing error. Otherwise they
                will generally cause runtime errors.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/ReservedCmdletChar.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSReservedCmdletChar => Warning --

        #region --[ PS ] PSReservedParams => Warning --
        PSReservedParams                               = @{
            <#
                Title:
                Reserved Parameters

                Description:
                Checks for reserved parameters in function definitions. If these parameters are defined by the user, an error
                generally occurs.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/ReservedParams.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSReservedParams => Warning --

        #region --[ PS ] PSReviewUnusedParameter => Warning --
        PSReviewUnusedParameter                        = @{
            <#
                Title:
                ReviewUnusedParameter

                Description:
                Ensure all parameters are used within the same script, scriptblock, or function where they are declared.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/ReviewUnusedParameter.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSReviewUnusedParameter => Warning --

        #region --[ PS ] PSShouldProcess => Warning --
        PSShouldProcess                                = @{
            <#
                Title:
                Should Process

                Description:
                Checks that if the SupportsShouldProcess is present, the function calls ShouldProcess/ShouldContinue and vice
                versa. Scripts with one or the other but not both will generally run into an error or unexpected behavior.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/ShouldProcess.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSShouldProcess => Warning --

        #region --[ PS ] PSUseApprovedVerbs => Warning --
        PSUseApprovedVerbs                             = @{
            <#
                Title:
                Cmdlet Verbs

                Description:
                Checks that all defined cmdlets use approved verbs. This is in line with PowerShell's best practices.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseApprovedVerbs.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseApprovedVerbs => Warning --

        #region --[ PS ] PSUseBOMForUnicodeEncodedFile => Warning --
        PSUseBOMForUnicodeEncodedFile                  = @{
            <#
                Title:
                Use BOM encoding for non-ASCII files

                Description:
                For a file encoded with a format other than ASCII, ensure BOM is present to ensure that any application
                consuming this file can interpret it correctly.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseBOMForUnicodeEncodedFile.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseBOMForUnicodeEncodedFile => Warning --

        #region --[ PS ] PSUseCmdletCorrectly => Warning --
        PSUseCmdletCorrectly                           = @{
            <#
                Title:
                Use Cmdlet Correctly

                Description:
                Cmdlet should be called with the mandatory parameters.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseCmdletCorrectly.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseCmdletCorrectly => Warning --

        #region --[ PS ] PSUseCompatibleCmdlets => Warning --
        PSUseCompatibleCmdlets                         = @{
            <#
                Title:
                Use compatible cmdlets

                Description:
                Use cmdlets compatible with the given PowerShell version and edition and operating system

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseCompatibleCmdlets.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseCompatibleCmdlets => Warning --

        #region --[ PS ] PSUseCompatibleCommands => Warning --
        PSUseCompatibleCommands                        = @{
            <#
                Title:
                Use compatible commands

                Description:
                Use commands compatible with the given PowerShell version and operating system

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseCompatibleCommands.md
            #>
            Enable         = $false
            IgnoreCommands = ''
            ProfileDirPath = ''
            TargetProfiles = @('win-8_x64_10.0.17763.0_7.0.0_x64_3.1.2_core', 'win-4_x64_10.0.18362.0_7.0.0_x64_3.1.2_core', 'ubuntu_x64_18.04_7.0.0_x64_3.1.2_core')
        }
        #endregion -- PS = PSUseCompatibleCommands => Warning --

        #region --[ PS ] PSUseCompatibleSyntax => Error --
        PSUseCompatibleSyntax                          = @{
            <#
                Title:
                Use compatible syntax

                Description:
                Use script syntax compatible with the given PowerShell versions

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseCompatibleSyntax.md
            #>
            Enable         = $true
            TargetVersions = '7.0'
        }
        #endregion -- PS = PSUseCompatibleSyntax => Error --

        #region --[ PS ] PSUseCompatibleTypes => Warning --
        PSUseCompatibleTypes                           = @{
            <#
                Title:
                Use compatible types

                Description:
                Use types compatible with the given PowerShell version and operating system

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseCompatibleTypes.md
            #>
            Enable         = $false
            IgnoreTypes    = ''
            ProfileDirPath = ''
            TargetProfiles = @('win-8_x64_10.0.17763.0_7.0.0_x64_3.1.2_core', 'win-4_x64_10.0.18362.0_7.0.0_x64_3.1.2_core', 'ubuntu_x64_18.04_7.0.0_x64_3.1.2_core')
        }
        #endregion -- PS = PSUseCompatibleTypes => Warning --

        #region --[ PS ] PSUseDeclaredVarsMoreThanAssignments => Warning --
        PSUseDeclaredVarsMoreThanAssignments           = @{
            <#
                Title:
                Extra Variables

                Description:
                Ensure declared variables are used elsewhere in the script and not just during assignment.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseDeclaredVarsMoreThanAssignments.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseDeclaredVarsMoreThanAssignments => Warning --

        #region --[ PS ] PSUseLiteralInitializerForHashtable => Warning --
        PSUseLiteralInitializerForHashtable            = @{
            <#
                Title:
                Create hashtables with literal initializers

                Description:
                Use literal initializer, @{}, for creating a hashtable as they are case-insensitive by default

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseLiteralInitializerForHashtable.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseLiteralInitializerForHashtable => Warning --

        #region --[ PS ] PSUseOutputTypeCorrectly => Information --
        PSUseOutputTypeCorrectly                       = @{
            <#
                Title:
                Use OutputType Correctly

                Description:
                The return types of a cmdlet should be declared using the OutputType attribute.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseOutputTypeCorrectly.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseOutputTypeCorrectly => Information --

        #region --[ PS ] PSUseProcessBlockForPipelineCommand => Warning --
        PSUseProcessBlockForPipelineCommand            = @{
            <#
                Title:
                Use process block for command that accepts input from pipeline.

                Description:
                If a command parameter takes its value from the pipeline, the command must use a process block to bind the
                input objects from the pipeline to that parameter.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseProcessBlockForPipelineCommand.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseProcessBlockForPipelineCommand => Warning --

        #region --[ PS ] PSUsePSCredentialType => Warning --
        PSUsePSCredentialType                          = @{
            <#
                Title:
                Use PSCredential type.

                Description:
                For PowerShell 4.0 and earlier, a parameter named Credential with type PSCredential must have a credential
                transformation attribute defined after the PSCredential type attribute.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UsePSCredentialType.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUsePSCredentialType => Warning --

        #region --[ PS ] PSUseShouldProcessForStateChangingFunctions => Warning --
        PSUseShouldProcessForStateChangingFunctions    = @{
            <#
                Title:
                Use ShouldProcess For State Changing Functions

                Description:
                Functions that have verbs like New, Start, Stop, Set, Reset, Restart that change system state should support
                'ShouldProcess'.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseShouldProcessForStateChangingFunctions.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseShouldProcessForStateChangingFunctions => Warning --

        #region --[ PS ] PSUseSingularNouns => Warning --
        PSUseSingularNouns                             = @{
            <#
                Title:
                Cmdlet Singular Noun

                Description:
                Cmdlet should use singular instead of plural nouns.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseSingularNouns.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseSingularNouns => Warning --

        #region --[ PS ] PSUseSupportsShouldProcess => Warning --
        PSUseSupportsShouldProcess                     = @{
            <#
                Title:
                Use SupportsShouldProcess

                Description:
                Commands typically provide Confirm and Whatif parameters to give more control on its execution in an
                interactive environment. In PowerShell, a command can use a SupportsShouldProcess attribute to provide this
                capability. Hence, manual addition of these parameters to a command is discouraged. If a commands need Confirm
                and Whatif parameters, then it should support ShouldProcess.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseSupportsShouldProcess.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseSupportsShouldProcess => Warning --

        #region --[ PS ] PSUseToExportFieldsInManifest => Warning --
        PSUseToExportFieldsInManifest                  = @{
            <#
                Title:
                Use the *ToExport module manifest fields.

                Description:
                In a module manifest, AliasesToExport, CmdletsToExport, FunctionsToExport and VariablesToExport fields should
                not use wildcards or $null in their entries. During module auto-discovery, if any of these entries are missing
                or $null or wildcard, PowerShell does some potentially expensive work to analyze the rest of the module.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseToExportFieldsInManifest.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseToExportFieldsInManifest => Warning --

        #region --[ PS ] PSUseUsingScopeModifierInNewRunspaces => Warning --
        PSUseUsingScopeModifierInNewRunspaces          = @{
            <#
                Title:
                Use 'Using:' scope modifier in RunSpace ScriptBlocks

                Description:
                If a ScriptBlock is intended to be run as a new RunSpace, variables inside it should use 'Using:' scope
                modifier, or be initialized within the ScriptBlock.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseUsingScopeModifierInNewRunspaces.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseUsingScopeModifierInNewRunspaces => Warning --

        #region --[ PS ] PSUseUTF8EncodingForHelpFile => Warning --
        PSUseUTF8EncodingForHelpFile                   = @{
            <#
                Title:
                Use UTF8 Encoding For Help File

                Description:
                PowerShell help file needs to use UTF8 Encoding.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/UseUTF8EncodingForHelpFile.md
            #>
            Enable = $true
        }
        #endregion -- PS = PSUseUTF8EncodingForHelpFile => Warning --

        #endregion -- PS --



        #region -- PSDSC --

        #region --[ PSDSC ] PSDSCDscExamplesPresent => Information --
        PSDSCDscExamplesPresent                        = @{
            <#
                Title:
                DSC examples are present

                Description:
                Every DSC resource module should contain folder "Examples" with sample configurations for every resource.
                Sample configurations should have resource name they are demonstrating in the title.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/DSCDscExamplesPresent.md
            #>
            Enable = $true
        }
        #endregion -- PSDSC = PSDSCDscExamplesPresent => Information --

        #region --[ PSDSC ] PSDSCDscTestsPresent => Information --
        PSDSCDscTestsPresent                           = @{
            <#
                Title:
                Dsc tests are present

                Description:
                Every DSC resource module should contain folder "Tests" with tests for every resource. Test scripts should have
                resource name they are testing in the file name.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/DSCDscTestsPresent.md
            #>
            Enable = $true
        }
        #endregion -- PSDSC = PSDSCDscTestsPresent => Information --

        #region --[ PSDSC ] PSDSCReturnCorrectTypesForDSCFunctions => Information --
        PSDSCReturnCorrectTypesForDSCFunctions         = @{
            <#
                Title:
                Return Correct Types For DSC Functions

                Description:
                Set function in DSC class and Set-TargetResource in DSC resource must not return anything. Get function in DSC
                class must return an instance of the DSC class and Get-TargetResource function in DSC resource must return a
                hashtable. Test function in DSC class and Get-TargetResource function in DSC resource must return a boolean.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/DSCReturnCorrectTypesForDSCFunctions.md
            #>
            Enable = $true
        }
        #endregion -- PSDSC = PSDSCReturnCorrectTypesForDSCFunctions => Information --

        #region --[ PSDSC ] PSDSCStandardDSCFunctionsInResource => Error --
        PSDSCStandardDSCFunctionsInResource            = @{
            <#
                Title:
                Use Standard Get/Set/Test TargetResource functions in DSC Resource 

                Description:
                DSC Resource must implement Get, Set and Test-TargetResource functions. DSC Class must implement Get, Set and
                Test functions.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/DSCStandardDSCFunctionsInResource.md
            #>
            Enable = $true
        }
        #endregion -- PSDSC = PSDSCStandardDSCFunctionsInResource => Error --

        #region --[ PSDSC ] PSDSCUseIdenticalMandatoryParametersForDSC => Error --
        PSDSCUseIdenticalMandatoryParametersForDSC     = @{
            <#
                Title:
                Use identical mandatory parameters for DSC Get/Test/Set TargetResource functions

                Description:
                The Get/Test/Set TargetResource functions of DSC resource must have the same mandatory parameters.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/DSCUseIdenticalMandatoryParametersForDSC.md
            #>
            Enable = $true
        }
        #endregion -- PSDSC = PSDSCUseIdenticalMandatoryParametersForDSC => Error --

        #region --[ PSDSC ] PSDSCUseIdenticalParametersForDSC => Error --
        PSDSCUseIdenticalParametersForDSC              = @{
            <#
                Title:
                Use Identical Parameters For DSC Test and Set Functions

                Description:
                The Test and Set-TargetResource functions of DSC Resource must have the same parameters.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/DSCUseIdenticalParametersForDSC.md
            #>
            Enable = $true
        }
        #endregion -- PSDSC = PSDSCUseIdenticalParametersForDSC => Error --

        #region --[ PSDSC ] PSDSCUseVerboseMessageInDSCResource => Information --
        PSDSCUseVerboseMessageInDSCResource            = @{
            <#
                Title:
                Use verbose message in DSC resource

                Description:
                It is a best practice to emit informative, verbose messages in DSC resource functions. This helps in debugging
                issues when a DSC configuration is executed.

                Docs:
                https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/DSCUseVerboseMessageInDSCResource.md
            #>
            Enable = $true
        }
        #endregion -- PSDSC = PSDSCUseVerboseMessageInDSCResource => Information --

        #endregion -- PSDSC --

    }
}
