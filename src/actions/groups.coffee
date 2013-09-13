exports =
  
  groupsIndex :
    name: "groupsIndex"
    description: "Shows the list of existing groups"
    inputs:
      required: []
      optional: ["userId"]
    authenticated: false
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      if connection.params.userId
        api.users.get connection.params.userId, (error, user) ->
          groups = user.getGroups()
          connection.error = error
          connection.response = { groups }
          next(connection, false)
      else
        api.groups.find (error, groups) ->
          connection.error = error
          connection.response = { groups }
          next(connection, false)
    
  groupsCreate : 
    name: "groupsCreate"
    description: "Adds a new group"
    inputs:
      required: ["userIds","doorIds","scheduleId"]
      optional: []
    authenticated: false
    outputExample: {}
    version: 1.0
    run: (api, connection, next) ->
      api.groups.create {
        schedule_id: scheduleId
      }, (error, group) ->
        users = connections.params.usersIds.split(',')
        api.users.find {id:users}, (error, userInstances) =>
          group.addUsers userInstances
        doors = connections.params.doorIds.split(',')
        api.doors.find {id:doors}, (error, doorInstances) =>
          group.addDoors doorInstances
        connection.error = error
        connection.response = { group }
        next(connection, false)

module.exports = exports
