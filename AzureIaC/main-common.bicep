param acr object
param location string = resourceGroup().location

var acrName = '${acr.name}'

module acReg 'modules/azureContainerRegistry.bicep' = {
  name: acrName
  params: {
    acrName: acrName
    acrSku: acr.sku
    location: location
  }

}
