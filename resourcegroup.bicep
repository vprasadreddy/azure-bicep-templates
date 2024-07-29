//SCOPE
targetScope = 'subscription'

//PARAMETERS WITH DEFAULT VALUE
//param resourceGroupName string = 'dev-rg'

//PARAMETERS
@description('Name of the Resource Group')
param resourceGroupName string
@description('Location of the Resource Group')
param location string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: location
}
