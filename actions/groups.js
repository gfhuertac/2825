// Generated by CoffeeScript 1.6.3
(function() {
  var exports;

  exports = {
    groupsIndex: {
      name: "groupsIndex",
      description: "Shows the list of existing groups",
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
            var groups;
            groups = user.getGroups();
            connection.error = error;
            connection.response = {
              groups: groups
            };
            return next(connection, false);
          });
        } else {
          return api.groups.find(function(error, groups) {
            connection.error = error;
            connection.response = {
              groups: groups
            };
            return next(connection, false);
          });
        }
      }
    },
    groupsCreate: {
      name: "groupsCreate",
      description: "Adds a new group",
      inputs: {
        required: ["userIds", "doorIds", "scheduleId"],
        optional: []
      },
      authenticated: false,
      outputExample: {},
      version: 1.0,
      run: function(api, connection, next) {
        return api.groups.create({
          schedule_id: scheduleId
        }, function(error, group) {
          var doors, users,
            _this = this;
          users = connections.params.usersIds.split(',');
          api.users.find({
            id: users
          }, function(error, userInstances) {
            return group.addUsers(userInstances);
          });
          doors = connections.params.doorIds.split(',');
          api.doors.find({
            id: doors
          }, function(error, doorInstances) {
            return group.addDoors(doorInstances);
          });
          connection.error = error;
          connection.response = {
            group: group
          };
          return next(connection, false);
        });
      }
    }
  };

  module.exports = exports;

}).call(this);
