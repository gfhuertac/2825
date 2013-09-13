// Generated by CoffeeScript 1.6.3
(function() {
  var exports;

  exports = {
    usersIndex: {
      name: "usersIndex",
      description: "Shows the list of existing users",
      inputs: {
        required: [],
        optional: ["externalId"]
      },
      authenticated: false,
      outputExample: {},
      version: 1.0,
      run: function(api, connection, next) {
        var filter;
        filter = {};
        if (connection.params.externalId) {
          filter.externalId = connection.params.externalId;
        }
        return api.users.find(filter, function(error, users) {
          connection.error = error;
          connection.response = {
            users: users
          };
          return next(connection, false);
        });
      }
    },
    usersCreate: {
      name: "usersCreate",
      description: "Adds a new user",
      inputs: {
        required: ["externalId"],
        optional: []
      },
      authenticated: false,
      outputExample: {},
      version: 1.0,
      run: function(api, connection, next) {
        return api.users.create({
          externalId: connection.params.externalId
        }, function(error, user) {
          connection.error = error;
          connection.response = {
            user: user
          };
          return next(connection, false);
        });
      }
    }
  };

  module.exports = exports;

}).call(this);
