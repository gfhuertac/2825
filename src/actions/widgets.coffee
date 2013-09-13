exports =
    
  widgetsIndex :
    name: "widgetsIndex"
    description: "Shows the list of existing widgets"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.widgets.find (error, widgets) ->
        connection.error = error
        connection.response = { widgets }
        next(connection, false)
  
  widgetsCreate : 
    name: "widgetsCreate"
    description: "Adds a new widget"
    inputs:
      required: ["name"]
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.widgets.create {
        name: connection.params.name
        description: connection.params.name
      }, (error, widget) ->
      connection.error = error
      connection.response = { widget }
      next(connection, false)
    
  widgetShow : 
    name: "widgetShow"
    description: "Shows an existing widget"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.widgets.get connection.params.id, (error, widget) ->
        connection.error = error
        connection.response = { widget }
        next(connection, false)
    
  widgetUpdate :
    name: "widgetUpdate"
    description: "Edits an existing widget of a site"
    inputs:
      required: []
      optional: ["name", "description"]
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.widgets.get connection.params.id, (error, widget) ->
        if error
          connection.error = error 
          next(connection, false)
        else
          widget.save {
            name: connection.params.name
            description: connection.params.description
          }, (error) ->
            connection.error = error
            connection.response = { widget }
            next(connection, false)
        
  widgetDestroy :
    name: "widgetDestroy"
    description: "Removes an existing widget"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.widgets.get connection.params.id, (error, widget) ->
        if error
          connection.error = error 
          next(connection, false)
        else
          widget.remove (error) ->
            connection.error = error
            connection.response = { message: "removed successfully" }
            next(connection, false)

module.exports = exports
