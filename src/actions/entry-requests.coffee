exports =
  
  entryRequestsIndex :
    name: "entryRequestsIndex"
    description: "Shows the list of existing entry requests"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.entryRequests.find (error, entryrequests) ->
        connection.error = error
        connection.response = { entryrequests }
        next(connection, false)
    
  entryRequestsCreate : 
    name: "entryRequestsCreate"
    description: "Adds a new entry request"
    inputs:
      required: ["name"]
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.entryRequests.create {
        name: connection.params.name
        description: connection.params.name
      }, (error, entryrequest) ->
        connection.error = error
        connection.response = { entryrequest }
        next(connection, false)
    
  entryRequestShow : 
    name: "entryRequestShow"
    description: "Shows an existing entry request"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.entryRequests.get connection.params.id, (error, entryrequest) ->
        connection.error = error
        connection.response = { entryrequest }
        next(connection, false)
    
  entryRequestUpdate : 
    name: "entryRequestUpdate"
    description: "Edits an existing entry request of a site"
    inputs:
      required: ["name"]
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.entryRequests.get connection.params.id, (error, entryrequest) ->
        if error
          connection.error = error
          next(connection, false)
        else
          entryrequest.save {
            name: connection.params.name
            description: connection.params.description
          }, (error) ->
            connection.error = error
            connection.response = { entryrequest }
            next(connection, false)
      
  entryRequestsDestroy : 
    name: "entryRequestsDestroy"
    description: "Removes an existing entry request"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.entryRequests.get connection.params.id, (error, entryrequest) ->
        if error
          connection.error = error
          next(connection, false)
        else
          entryrequest.remove (error) ->
            connection.error = error
            connection.response = { message: "removed successfully" }
            next(connection, false)

module.exports = exports
