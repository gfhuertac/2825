exports =
    
  schedulesIndex :
    name: "schedulesIndex"
    description: "Shows the list of existing schedules"
    inputs:
      required: []
      optional: ["startDate", "endDate"]
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      filter = {}
      if connection.params.startDate
        filter.startDateTime = orm.gte(connection.params.startDate)
      if connection.params.endDate
        filter.endDateTime = orm.lte(connection.params.endDate)
      api.schedules.find filter, (err, schedules) ->
        connection.error = error
        connection.response = { schedules }
        next(connection, false)
  
  schedulesCreate : 
    name: "schedulesCreate"
    description: "Adds a new schedule"
    inputs:
      required: ["startDate", "endDate"]
      optional: [] #["name"]
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.schedules.create {
        #name: connection.params.name
        startDateTime: connection.params.startDate
        endDateTime: connection.params.endDate
      }, (err, schedule) ->
        connection.error = error
        connection.response = { schedule }
        next(connection, false)
    
  scheduleShow : 
    name: "scheduleShow"
    description: "Shows an existing schedule"
    inputs:
      required: ["id"]
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.schedules.get connection.params.id, (err, schedule) ->
        connection.error = error
        connection.response = { schedule }
        next(connection, false)
    
  scheduleUpdate : 
    name: "scheduleUpdate"
    description: "Edits an existing schedule of a site"
    inputs:
      required: ["id"]
      optional: ["startDate", "endDate"] #"name", 
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.schedules.get connection.params.id, (err, schedule) ->
        if err
          connection.error = error
          next(connection, false)
        else
          schedule.save {
            #name: connection.params.name
            startDateTime: connection.params.startDate
            endDateTime: connection.params.endDate
          }, (err) ->
            connection.error = error
            connection.response = { schedule }
            next(connection, false)
      
  scheduleDestroy : 
    name: "scheduleDestroy"
    description: "Removes an existing schedule"
    inputs:
      required: ["id"]
      optional: []
    authenticated: true
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.schedules.get connection.params.id, (err, schedule) ->
        if err
          connection.error = error
          next(connection, false)
        else
          schedule.remove (err) ->
            connection.error = error
            connection.response = { message: "removed successfully" }
            next(connection, false)

module.exports = exports
