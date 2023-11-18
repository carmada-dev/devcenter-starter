// import * as tools from 'tools.bicep'
targetScope = 'resourceGroup'

param config object
param devCenterName string

var environmentTypes = items(contains(config, 'environmentTypes') ? config.environmentTypes : {})

resource devCenter 'Microsoft.DevCenter/devcenters@2023-10-01-preview' existing = {
  name: devCenterName
}

resource environmentType 'Microsoft.DevCenter/devcenters/environmentTypes@2022-09-01-preview' = [for item in environmentTypes: {
  name: item.key
  parent: devCenter
  tags: contains(item.value, 'tags') ? item.value.tags : {}
}]
