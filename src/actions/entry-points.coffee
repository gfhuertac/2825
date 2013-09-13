exports = 

  entryPointsIndex :
    name: "entryPointsIndex"
    description: "Shows the list of existing entry points"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.entryPoints.find {site_id : connection.params.siteid}, (error, entrypoints) ->
        connection.error = error
        connection.response = { entrypoints }
        next(connection, false)

  entryPointsCreate : 
    name: "entryPointsCreate"
    description: "Adds a new entry point"
    inputs:
      required: ["name"]
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.entryPoints.create {
        name: connection.params.name
        description: connection.params.name
        site_id: connection.params.siteid
      }, (error, entrypoint) ->
        connection.error = error
        connection.response = { entrypoint }
        next(connection, false)
    
  entryPointShow : 
    name: "entryPointShow"
    description: "Shows an existing entry point"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.entryPoints.get connection.params.id, (error, entrypoint) ->
        connection.error = error
        connection.response = { entrypoint }
        next(connection, false)
    
  entryPointUpdate : 
    name: "entryPointUpdate"
    description: "Edits an existing entry point of a site"
    inputs:
      required: ["name"]
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.entryPoints.get connection.params.id, (error, entrypoint) ->
        if error
          connection.error = error
          next(connection, false)
        else
          entrypoint.save {
            name: connection.params.name
            description: connection.params.description
            entryrequest_id: connection.params.entryrequestid
            site_id: connection.params.siteid
          }, (error) ->
            connection.error = error
            connection.response = { entrypoint }
            next(connection, false)
      
  entryPointsDestroy :
    name: "entryPointsDestroy"
    description: "Removes an existing entry point"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.entryPoints.get connection.params.id, (error, entrypoint) ->
        if error
          connection.error = error
          next(connection, false)
        else
          entrypoint.remove (error) ->
            connection.error = error
            connection.response = { message: "removed successfully" }
            next(connection, false)

module.exports = exports
