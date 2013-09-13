exports =
  
  credentialsIndex :
    name: "credentialsIndex"
    description: "Shows the list of existing credentials"
    inputs:
      required: []
      optional: ["userId"]
    authenticated: false
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      if connection.params.userId
        api.users.get connection.params.userId, (error, user) ->
          credentials = user.getCredentials()
          connection.error = error
          connection.response = { credentials }
          next(connection, false)
      else
        api.credentials.find (error, credentials) ->
          connection.error = error
          connection.response = { credentials }
          next(connection, false)
    
  credentialsCreate : 
    name: "credentialsCreate"
    description: "Adds a new credential"
    inputs:
      required: ["userId","value"]
      optional: []
    authenticated: false
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.credentials.create {
        user_id: connections.params.usersId
        value: connections.params.value
      }, (error, credential) ->
        connection.error = error
        connection.response = { credential }
        next(connection, false)

module.exports = exports
