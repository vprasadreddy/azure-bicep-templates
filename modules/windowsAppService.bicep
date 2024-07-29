//PARAMETERS
param webAppName string
param location string
param tags object
param serverFarmId string
param appInsightsInstrumentationKey string
param appInsightsprimaryConnectionString string

resource demoWebsite 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName
  location: location
  tags: tags
  properties: {
    httpsOnly: true
    reserved: false
    serverFarmId: serverFarmId
    siteConfig: {
      minTlsVersion: '1.2'
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsightsInstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsightsprimaryConnectionString
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~3'
        }
        {
          name: 'XDT_MicrosoftApplicationInsights_Mode'
          value: 'default'
        }
      ]
      alwaysOn: true
      // vnetRouteAllEnabled: true
    }
    // virtualNetworkSubnetId: vNetSubnetId      
  }
}

output webappurl string = demoWebsite.properties.defaultHostName
