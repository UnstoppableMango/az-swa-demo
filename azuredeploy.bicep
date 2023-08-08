param location string = resourceGroup().location

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'unstoppablemangosa'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }

  resource blobServices 'blobServices' = {
    name: 'default'

    resource container 'containers' = {
      name: '$web'
    }
  }
}

resource cdn 'Microsoft.Cdn/profiles@2023-05-01' = {
  name: 'unstoppablemango-cdn'
  location: location
  sku: {
    name: 'Standard_Microsoft'
  }

  resource endpoint 'endpoints' = {
    name: 'default'
    location: location
    properties: {
      isCompressionEnabled: true
      isHttpAllowed: false
      isHttpsAllowed: true
      queryStringCachingBehavior: 'IgnoreQueryString'
      origins: [
        {
          name: 'default'
          properties: {
            originHostHeader: replace(replace(storageAccount.properties.primaryEndpoints.web, 'https://', ''), '/', '')
            hostName: replace(replace(storageAccount.properties.primaryEndpoints.web, 'https://', ''), '/', '')
            enabled: true
          }
        }
      ]
      deliveryPolicy: {
        rules: [
          {
            name: 'Global'
            order: 0
            actions: [
              {
                name: 'ModifyResponseHeader'
                parameters: {
                  headerAction: 'Append'
                  headerName: 'Strict-Transport-Security'
                  typeName: 'DeliveryRuleHeaderActionParameters'
                  value: 'max-age=31536000'
                }
              }
              {
                name: 'ModifyResponseHeader'
                parameters: {
                  headerAction: 'Append'
                  headerName: 'X-XSS-Protection'
                  typeName: 'DeliveryRuleHeaderActionParameters'
                  value: '1; mode=block'
                }
              }
              {
                name: 'ModifyResponseHeader'
                parameters: {
                  headerAction: 'Append'
                  headerName: 'Referrer-Policy'
                  typeName: 'DeliveryRuleHeaderActionParameters'
                  value: 'strict-origin-when-cross-origin'
                }
              }
              {
                name: 'ModifyResponseHeader'
                parameters: {
                  headerAction: 'Append'
                  headerName: 'X-Frame-Options'
                  typeName: 'DeliveryRuleHeaderActionParameters'
                  value: 'DENY'
                }
              }
            ]
          }
        ]
      }
    }
  }
}
