//PARAMETERS
param webAppName string
param location string
param tags object
param serverFarmId string
param appInsightsInstrumentationKey string
param appInsightsprimaryConnectionString string
@allowed([
  'DOTNETCORE|8.0'
  'PYTHON|3.12'
  'JAVA|17-java17"'
  'NODE|20-lts'
  'NODE|18-lts'
])
param linuxFxVersion string

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
      linuxFxVersion: linuxFxVersion
      // vnetRouteAllEnabled: true
    }
    // virtualNetworkSubnetId: vNetSubnetId      
  }
}

// resource webSiteConfig 'Microsoft.Web/sites/config@2022-03-01' = {
//   parent: webSite
//   name: 'web'
//   properties: {
//     javaVersion: '1.8'
//     javaContainer: 'TOMCAT'
//     javaContainerVersion: '9.0'
//   }
// }

output webappurl string = demoWebsite.properties.defaultHostName
