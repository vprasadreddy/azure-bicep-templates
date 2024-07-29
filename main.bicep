//SCOPE
targetScope = 'resourceGroup'

//PARAMETERS
param webAppName string
param location string = resourceGroup().location
param tags object
param appServicePlanSkuName string
param linuxFxVersion string

//VARIABLES
var appServicePlanName = '${webAppName}-asp'
var appInsightsName = '${webAppName}-app-insights'

//AZURE APP INSIGHTS
module webAppInsights './modules/appInsights.bicep' = {
  name: appInsightsName
  params: {
    appInsightsName: appInsightsName
    tags: tags
    location: location
    // appInsightsWorkspaceResourceId: logAnalyticsWorkspaceId
  }
}

//WINDOWS APP SERVICE PLAN
// module webAppWindowsAppServicePlan './modules/windowsAppServicePlan.bicep' = {
//   name: appServicePlanName
//   params: {
//     tags : tags
//     appServicePlanName: appServicePlanName
//     appServicePlanSkuName : appServicePlanSkuName
//   }
// }

//WINDOWS WEBAPP
// module windowsWebapp './modules/windowsAppService.bicep' = {
//   name: webAppName
//   params: {
//     webAppName : webAppName
//     location: location
//     tags : tags
//     serverFarmId : webAppWindowsAppServicePlan.outputs.serverFarmId
//     appInsightsInstrumentationKey : webAppInsights.outputs.appInsightsInstrumentationKey
//     appInsightsprimaryConnectionString : webAppInsights.outputs.appInsightsPrimaryConnectionString
//   }
// }

//LINUX APP SERVICE PLAN
module linuxAppServicePlan './modules/linuxAppServicePlan.bicep' = {
  name: appServicePlanName
  params: {
    tags: tags
    appServicePlanName: appServicePlanName
    appServicePlanSkuName: appServicePlanSkuName
  }
}

//LINUX WEBAPP
module linuxWebApp './modules/linuxAppService.bicep' = {
  name: webAppName
  params: {
    webAppName: webAppName
    location: location
    tags: tags
    serverFarmId: linuxAppServicePlan.outputs.serverFarmId
    appInsightsInstrumentationKey: webAppInsights.outputs.appInsightsInstrumentationKey
    appInsightsprimaryConnectionString: webAppInsights.outputs.appInsightsPrimaryConnectionString
    linuxFxVersion: linuxFxVersion
  }
}

// output windowsWebAppUrl string = windowsWebapp.outputs.webappurl
output linuxWebAppUrl string = linuxWebApp.outputs.webappurl
