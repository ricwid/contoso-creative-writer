param apimName string
param applicationInsightsResourceId string

resource logger 'Microsoft.ApiManagement/service/loggers@2022-08-01' = {
  name: '${apimName}/applicationinsights'
  properties: {
    loggerType: 'applicationInsights'
    resourceId: applicationInsightsResourceId
  }
}

resource diagnostic 'Microsoft.ApiManagement/service/diagnostics@2022-08-01' = {
  name: '${apimName}/applicationinsights'
  properties: {
    loggerId: logger.name
    alwaysLog: 'allErrors'
    sampling: {
      samplingType: 'fixed'
      percentage: 100
    }
    frontend: {
      request: { headers: ['*'], body: { bytes: 512 } }
      response: { headers: ['*'], body: { bytes: 512 } }
    }
    backend: {
      request: { headers: ['*'], body: { bytes: 512 } }
      response: { headers: ['*'], body: { bytes: 512 } }
    }
  }
}
