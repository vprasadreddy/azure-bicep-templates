using './main.bicep'

param keyVaultName = ''
param tags = {}
param keyVaultSkuName = ''
param keyVaultSkuFamily = ''
param keyVaultSoftDeleteRetentionInDays = 0
param keyVaultEnableRbacAuthorization = false

