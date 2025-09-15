#Requires -Version 7.3
#Requires -RunAsAdministrator

param()



$InformationPreference = 'Continue'



# Win 11: Revert stupid context menu @ File Explorer
Write-Information 'Win 11: Reverting stupid context menu @ File Explorer...'

reg.exe add 'HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32' /f /ve



# Done!
Write-Information "`n[DONE]"
