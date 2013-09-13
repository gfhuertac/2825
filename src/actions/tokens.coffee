exports =
    
  tokensIndex :
    name: "tokensIndex"
    description: "Shows the list of existing tokens"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.tokens.find (error, tokens) ->
        connection.error = error
        connection.response = { tokens }
        next(connection, false)

  tokensCreate : 
    name: "tokensCreate"
    description: "Adds a new token"
    inputs:
      required: ["tokenType"]
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.tokens.create {
        tokenType: connection.params.tokenType
        data: api.configData.generator()
      }, (error, token) ->
        connection.error = error
        connection.response = { token }
        next(connection, false)
    
  tokenShow : 
    name: "tokenShow"
    description: "Shows an existing token"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.tokens.get connection.params.id, (error, token) ->
        connection.error = error
        connection.response = { token }
        next(connection, false)
    
  tokenUpdate : 
    name: "tokenUpdate"
    description: "Edits an existing token of a site"
    inputs:
      required: []
      optional: ["tokenType"]
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.tokens.get connection.params.id, (error, token) ->
        if error
          connection.error = error        
          next(connection, false)
        else
          token.save {
            tokenType: connection.params.type
            data: api.configData.generator()
          }, (error) ->
            connection.error = error
            connection.response = { token }
            next(connection, false)
        
  tokenDestroy : 
    name: "tokenDestroy"
    description: "Removes an existing token"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.tokens.get connection.params.id, (error, token) ->
        if error
          connection.error = error        
          next(connection, false)
        else
          token.remove (error) ->
            connection.error = error
            connection.response = { message: "removed successfully" }
            next(connection, false)

module.exports = exports
