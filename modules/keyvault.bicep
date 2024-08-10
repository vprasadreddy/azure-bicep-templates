//PARAMETERS
param name string
param location string
param tags object
@description('The SKU of the vault to be created.')
@allowed([
  'standard'
  'premium'
])
param skuName string
param skuFamily string
param softDeleteRetentionInDays int
param enableRbacAuthorization bool

resource keyvault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    accessPolicies: []
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableRbacAuthorization: enableRbacAuthorization
    createMode: 'default'
    enableSoftDelete: true
    softDeleteRetentionInDays: softDeleteRetentionInDays
    sku: {
      name: skuName
      family: skuFamily
    }
    tenantId: subscription().tenantId
  }
}
