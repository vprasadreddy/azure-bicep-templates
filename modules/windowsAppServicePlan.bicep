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
    //reserved should be false for Windows App Service Plan
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
  }
  kind: 'app'
}

output serverFarmId string = appServicePlan.id
