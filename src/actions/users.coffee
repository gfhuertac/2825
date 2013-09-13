exports =
  
  usersIndex :
    name: "usersIndex"
    description: "Shows the list of existing users"
    inputs:
      required: []
      optional: ["externalId"]
    authenticated: false
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      filter = {}
      if connection.params.externalId
        filter.externalId = connection.params.externalId
      api.users.find filter, (error, users) ->
        connection.error = error
        connection.response = { users }
        next(connection, false)
    
  usersCreate : 
    name: "usersCreate"
    description: "Adds a new user"
    inputs:
      required: ["externalId"]
      optional: []
    authenticated: false
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.users.create {
        externalId: connection.params.externalId
        #name: connection.params.name
        #redirectURL: connection.params.redirectURL
      }, (error, user) ->
        connection.error = error
        connection.response = { user }
        next(connection, false)

module.exports = exports
