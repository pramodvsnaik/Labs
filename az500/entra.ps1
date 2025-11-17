### Create user in entra ID'

$DomainName=$(az ad signed-in-user show --query 'userPrincipalName').Split('@')[1].trim('"')
Write-Host "Current Domain Name: $DomainName"
az ad user create --display-name "Dylan Williams" --password "Pa$$word" --user-principal-name Dylan@$DomainName



Write-Host "List users:"
az ad user list -o json | jq -r '.[].userPrincipalName'


#create group
Write-Host "Create group 'ITAdmins'"
az ad group create --display-name "ITAdmins" --mail-nickname "ITAdmins"

az ad group member add --group "Service Desk" --member-id $OBJECTID