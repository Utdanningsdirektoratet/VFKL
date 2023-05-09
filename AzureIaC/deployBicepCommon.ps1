az account set --name "Udir-vfkl"
az group create --name "rg-vfkl-common" --location "norwayeast"
az deployment group create --template-file ./main-common.bicep --parameters './parameters.common.json' --resource-group rg-vfkl-common --output yamlc
