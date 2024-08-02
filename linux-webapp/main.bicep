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
module appInsights '../modules/appInsights.bicep' = {
  name: appInsightsName
  params: {
    appInsightsName: appInsightsName
    tags: tags
    location: location
    // appInsightsWorkspaceResourceId: logAnalyticsWorkspaceId
  }
}

//LINUX APP SERVICE PLAN
module linuxAppServicePlan '../modules/linuxAppServicePlan.bicep' = {
  name: appServicePlanName
  params: {
    tags: tags
    appServicePlanName: appServicePlanName
    appServicePlanSkuName: appServicePlanSkuName
  }
}

//LINUX WEBAPP
module linuxWebApp '../modules/linuxAppService.bicep' = {
  name: webAppName
  params: {
    webAppName: webAppName
    location: location
    tags: tags
    serverFarmId: linuxAppServicePlan.outputs.serverFarmId
    appInsightsInstrumentationKey: appInsights.outputs.appInsightsInstrumentationKey
    appInsightsprimaryConnectionString: appInsights.outputs.appInsightsPrimaryConnectionString
    linuxFxVersion: linuxFxVersion
  }
}

output linuxWebAppUrl string = linuxWebApp.outputs.webappurl
