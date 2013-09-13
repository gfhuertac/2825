exports =
    
  identitiesIndex :
    name: "identitiesIndex"
    description: "Shows the list of existing identities"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.Identity.find (error, identities) ->
        connection.error = error
        connection.response = { identities }
        next(connection, false)
    
  identitiesCreate : 
    name: "identitiesCreate"
    description: "Adds a new identity"
    inputs:
      required: ["firstName", "lastName", "email"]
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.Identity.create {
        firstName: connection.params.firstName
        lastName: connection.params.lastName
        email: connection.params.email
      }, (error, identity) ->
        connection.error = error
        connection.response = { identity }
        next(connection, false)
    
  identityShow : 
    name: "identityShow"
    description: "Shows an existing identity"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.Identity.get connection.params.id, (error, identity) ->
        connection.error = error
        connection.response = { identity }
        next(connection, false)
    
  identityUpdate : 
    name: "identityUpdate"
    description: "Edits an existing identity of a site"
    inputs:
      required: []
      optional: ["firstName", "lastName", "email"]
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.Identity.get connection.params.id, (error, identity) ->
        if error
          connection.error = error
          next(connection, false)
        else
          identity.save {
            firstName: connection.params.firstName
            lastName: connection.params.lastName
            email: connection.params.email
          }, (error) ->
            connection.error = error
            connection.response = { identity }
            next(connection, false)
      
  identityDestroy : 
    name: "identityDestroy"
    description: "Removes an existing identity"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.Identity.get connection.params.id, (error, identity) ->
        if error
          connection.error = error
          next(connection, false)
        else
          identity.remove (error) ->
            connection.error = error
            connection.response = { message: "removed successfully" }
            next(connection, false)

module.exports = exports
