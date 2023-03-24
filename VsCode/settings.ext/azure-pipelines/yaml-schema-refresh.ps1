$TargetFile = "$(Join-Path $PSScriptRoot -ChildPath 'yaml-schema.json')"

if ($(Test-Path $TargetFile)) {
    Remove-Item $TargetFile -Force
}

# invokes devops rest call: get /_apis/distributedtask/yamlschema
#
# --organization https://dev.azure.com/myOrg
az devops invoke --detect true --area distributedtask --resource yamlschema |
    Out-File $TargetFile
