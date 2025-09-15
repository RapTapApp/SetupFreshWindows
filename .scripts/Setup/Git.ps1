#Requires -Version 7.3
#Requires -RunAsAdministrator

param(
    [string] $Email = 'cees@raptapapp.com'
)



$InformationPreference = 'Continue'



# Setup git
Write-Information 'Setup: git...'

git config --system init.defaultbranch 'main'
git config --system core.longpaths true

git config --global user.name 'Cees van Berkel'
git config --global user.email $Email



# Done!
Write-Information "`n[DONE]"
