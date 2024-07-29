//PARAMETERS
param tags object
param appServicePlanName string
param appServicePlanSkuName string
// param appServicePlanSkuName object = {
//   name: ''
//   tier: ''
//   size: ''
//   family: ''
//   capacity: 1
// }

param location string = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  sku: {
    name: appServicePlanSkuName
  }
  properties: {
    perSiteScaling: false
    maximumElasticWorkerCount: 1
    isSpot: false
    //reserved should be true for Linux App Service Plan
    reserved: true
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
  }
  kind: 'linux'
}

output serverFarmId string = appServicePlan.id
