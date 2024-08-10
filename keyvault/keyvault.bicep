//SCOPE
targetScope = 'resourceGroup'

//PARAMETERS
//KEY VAULT PARAMETERS
param keyVaultName string
param location string = resourceGroup().location
param tags object
param keyVaultSkuName string
param keyVaultSkuFamily string
param keyVaultSoftDeleteRetentionInDays int
param keyVaultEnableRbacAuthorization bool

//Key Vault
module keyvault '../modules/keyvault.bicep' = {
  name: keyVaultName
  params: {
    name: keyVaultName
    location: location
    tags: tags
    skuName: keyVaultSkuName
    skuFamily: keyVaultSkuFamily
    softDeleteRetentionInDays: keyVaultSoftDeleteRetentionInDays
    enableRbacAuthorization: keyVaultEnableRbacAuthorization
  }
}
