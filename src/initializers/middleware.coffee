exports.middleware = (api, next) ->

  authenticationMiddleware = (connection, actionTemplate, next) ->
    if actionTemplate.authenticated == true
      next connection, true # for now we do nothing, but in the future it should validate users as below
      #api.users.authenticate connection.params.userName, connection.params.password, (error, match) =>
      #  if match == true
      #    next connection, true
      #  else
      #    connection.error = "Authentication Failed.  userName and password required"
      #    next connection, false
    else
      next connection, true

  api.actions.preProcessors.push authenticationMiddleware

  next()

module.exports = exports
