param location string = resourceGroup().location

@secure()
param repositoryToken string

resource app 'Microsoft.Web/staticSites@2022-09-01' = {
  name: 'unstoppablemango-az-swa-demo'
  location: location
  sku: {
    name: 'Free'
    tier: 'Free'
  }
  properties: {
    branch: 'main'
    repositoryUrl: 'https://github.com/UnstoppableMango/az-swa-demo'
    repositoryToken: repositoryToken
    buildProperties: {
      appLocation: 'app'
      appArtifactLocation: 'build'
    }
  }
}
