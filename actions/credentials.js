// Generated by CoffeeScript 1.6.3
(function() {
  var exports;

  exports = {
    credentialsIndex: {
      name: "credentialsIndex",
      description: "Shows the list of existing credentials",
      inputs: {
        required: [],
        optional: ["userId"]
      },
      authenticated: false,
      outputExample: {},
      version: 1.0,
      run: function(api, connection, next) {
        if (connection.params.userId) {
          return api.users.get(connection.params.userId, function(error, user) {
            var credentials;
            credentials = user.getCredentials();
            connection.error = error;
            connection.response = {
              credentials: credentials
            };
            return next(connection, false);
          });
        } else {
          return api.credentials.find(function(error, credentials) {
            connection.error = error;
            connection.response = {
              credentials: credentials
            };
            return next(connection, false);
          });
        }
      }
    },
    credentialsCreate: {
      name: "credentialsCreate",
      description: "Adds a new credential",
      inputs: {
        required: ["userId", "value"],
        optional: []
      },
      authenticated: false,
      outputExample: {},
      version: 1.0,
      run: function(api, connection, next) {
        return api.credentials.create({
          user_id: connections.params.usersId,
          value: connections.params.value
        }, function(error, credential) {
          connection.error = error;
          connection.response = {
            credential: credential
          };
          return next(connection, false);
        });
      }
    }
  };

  module.exports = exports;

}).call(this);
