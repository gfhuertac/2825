exports =
  
  clientsIndex :
    name: "clientsIndex"
    description: "Shows the list of existing clients"
    inputs:
      required: []
      optional: []
    authenticated: false
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.clients.find (error, clients) ->
        connection.error = error
        connection.response = { clients }
        next(connection, false)
    
  clientsCreate : 
    name: "clientsCreate"
    description: "Adds a new client"
    inputs:
      required: ["name"]
      optional: ["redirectURL"]
    authenticated: false
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.clients.create {
        name: connection.params.name
        redirectURL: connection.params.redirectURL
      }, (error, client) ->
        connection.error = error
        connection.response = { client }
        next(connection, false)

module.exports = exports
