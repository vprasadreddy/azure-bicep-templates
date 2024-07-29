param tags object
param location string = resourceGroup().location
param appInsightsName string
// param appInsightsWorkspaceResourceId string

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    // WorkspaceResourceId: appInsightsWorkspaceResourceId
  }
}

output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey
output appInsightsPrimaryConnectionString string = appInsights.properties.ConnectionString
