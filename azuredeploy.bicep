param location string = resourceGroup().location
param prefix string = 'unstoppablemango'

@secure()
param repositoryToken string

param repositoryUrl string = 'https://github.com/UnstoppableMango/az-swa-demo'

resource app 'Microsoft.Web/staticSites@2022-09-01' = {
  name: '${prefix}-az-swa-demo'
  location: location
  sku: {
    tier: 'Free'
    name: 'Free'
  }
  properties: {
    repositoryUrl: repositoryUrl
    repositoryToken: repositoryToken
    branch: 'main'
    buildProperties: {
      appLocation: 'app'
      appArtifactLocation: 'build'
    }
  }
}
