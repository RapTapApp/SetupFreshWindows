$TargetFile = "$(Join-Path $PSScriptRoot -ChildPath 'DOpipe-yaml.schema.json')"

if ($(Test-Path $TargetFile)) {
    Remove-Item $TargetFile -Force
}

# invokes devops rest call: get /_apis/distributedtask/yamlschema
az devops invoke --detect true --area distributedtask --resource yamlschema |
out-file $TargetFile
# --organization https://dev.azure.com/myOrg
