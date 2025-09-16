#Requires -Version 7.3
#Requires -RunAsAdministrator

param(
    [string] $GitUserName = 'Cees van Berkel',
    [string] $GitEmail = 'Cees@RapTapApp.com',
    [string] $GitGpgKeyId
)



$InformationPreference = 'Continue'



# Setup git
Write-Information 'Setup: git...'

git config --system init.defaultbranch 'main'
git config --system core.longpaths true

if ($GitUserName) {
    git config --global user.name $GitUserName
}

if ($GitEmail) {
    git config --global user.email $GitEmail
}

# See: https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits
if ($GitGpgKeyId) {

    git config --global user.signingkey $GitGpgKeyId

    git config --global --unset gpg.format
    git config --global gpg.program 'C:\Program Files (x86)\GnuPG\bin\gpg.exe'

    git config --global commit.gpgsign true
    git config --global tag.gpgSign true
}

# Done!
Write-Information "`n[DONE]"
