exports = 
    
  sitesIndex :
    name: "sitesIndex"
    description: "Shows the list of existing sites"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.sites.find (error, sites) ->
        connection.error = error
        connection.response = { sites }
        next(connection, false)

  sitesCreate : 
    name: "sitesCreate"
    description: "Adds a new site"
    inputs:
      required: ["name"]
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.sites.create {
        name: connection.params.name
      }, (error, site) ->
        connection.error = error
        connection.response = { site }
        next(connection, false)
    
  siteShow : 
    name: "siteShow"
    description: "Shows an existing site"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.sites.get connection.params.id, (error, site) ->
        connection.error = error
        connection.response = { site }
        next(connection, false)
    
  siteUpdate : 
    name: "siteUpdate"
    description: "Edits an existing site of a site"
    inputs:
      required: []
      optional: ["name"]
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.sites.get connection.params.id, (error, site) ->
        if error
          connection.error = error
          next(connection, false)
        else
          site.save {
            name: connection.params.name
          }, (error) ->
            connection.error = error
            connection.response = { site }
            next(connection, false)
        
  sitesDestroy : 
    name: "sitesDestroy"
    description: "Removes an existing site"
    inputs:
      required: []
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.sites.get connection.params.id, (error, site) ->
        if error
          connection.error = error        
          next(connection, false)
        else
          site.remove (error) ->
            connection.error = error
            connection.response = { message: "removed successfully" }
            next(connection, false)

module.exports = exports
