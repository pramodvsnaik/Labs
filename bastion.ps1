$resource_group = "rg-bastion-ind-demo"
$location = "centralIndia"
$subnet_bastion_name = "AzureBastionSubnet"
$vnet_name = "vnet-bastion-ind-demo"
$subnet_app_name = "subnet-bastion-ind-demo"


# Create Resource Group
az group create --name $resource_group --location $location

# Create Virtual Network
az network vnet create `
    --name $vnet_name `
    --resource-group $resource_group `
    --location $location `
    --address-prefix '10.0.0.0/24' `
    --subnet-name $subnet_bastion_name `
    --subnet-prefix '10.0.0.0/25'

az network vnet subnet create `
    --name $subnet_app_name `
    --resource-group $resource_group `
    --vnet-name $vnet_name `
    --address-prefix '10.0.0.128/25'

# Create Public IP for Bastion
az network public-ip create `
    --resource-group $resource_group `
    --name "pip-bastion-ind" `
    --allocation-method Static

az network bastion create `
    --name "bastion-ind-demo" `
    --public-ip-address "pip-bastion-ind" `
    --resource-group $resource_group `
    --vnet-name $vnet_name `
    --location $location `
    --sku Standard

az vm create `
    --resource-group $resource_group `
    --name "vm-bastion-ind" `
    --image "Win2022Datacenter" `
    --admin-username "azureuser" `
    --admin-password "Password" `
    --size "Standard_D2as_v4" `
    --vnet-name $vnet_name `
    --subnet $subnet_app_name



# az group delete `
#  --name $resource_group `
#  --yes
