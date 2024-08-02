//SCOPE
targetScope = 'resourceGroup'

//PARAMETERS
param webAppName string
param location string = resourceGroup().location
param tags object
param appServicePlanSkuName string

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

//WINDOWS APP SERVICE PLAN
module webAppWindowsAppServicePlan '../modules/windowsAppServicePlan.bicep' = {
  name: appServicePlanName
  params: {
    tags: tags
    appServicePlanName: appServicePlanName
    appServicePlanSkuName: appServicePlanSkuName
  }
}

//WINDOWS WEBAPP
module windowsWebapp '../modules/windowsAppService.bicep' = {
  name: webAppName
  params: {
    webAppName: webAppName
    location: location
    tags: tags
    serverFarmId: webAppWindowsAppServicePlan.outputs.serverFarmId
    appInsightsInstrumentationKey: appInsights.outputs.appInsightsInstrumentationKey
    appInsightsprimaryConnectionString: appInsights.outputs.appInsightsPrimaryConnectionString
  }
}

output windowsWebAppUrl string = windowsWebapp.outputs.webappurl
