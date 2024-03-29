// Generated by CoffeeScript 1.6.3
(function() {
  var exports;

  exports = {
    schedulesIndex: {
      name: "schedulesIndex",
      description: "Shows the list of existing schedules",
      inputs: {
        required: [],
        optional: ["startDate", "endDate"]
      },
      authenticated: true,
      outputExample: {},
      version: 1.0,
      run: function(api, connection, next) {
        var filter;
        filter = {};
        if (connection.params.startDate) {
          filter.startDateTime = orm.gte(connection.params.startDate);
        }
        if (connection.params.endDate) {
          filter.endDateTime = orm.lte(connection.params.endDate);
        }
        return api.schedules.find(filter, function(err, schedules) {
          connection.error = error;
          connection.response = {
            schedules: schedules
          };
          return next(connection, false);
        });
      }
    },
    schedulesCreate: {
      name: "schedulesCreate",
      description: "Adds a new schedule",
      inputs: {
        required: ["startDate", "endDate"],
        optional: []
      },
      authenticated: true,
      outputExample: {},
      version: 1.0,
      run: function(api, connection, next) {
        return api.schedules.create({
          startDateTime: connection.params.startDate,
          endDateTime: connection.params.endDate
        }, function(err, schedule) {
          connection.error = error;
          connection.response = {
            schedule: schedule
          };
          return next(connection, false);
        });
      }
    },
    scheduleShow: {
      name: "scheduleShow",
      description: "Shows an existing schedule",
      inputs: {
        required: ["id"],
        optional: []
      },
      authenticated: true,
      outputExample: {},
      version: 1.0,
      run: function(api, connection, next) {
        return api.schedules.get(connection.params.id, function(err, schedule) {
          connection.error = error;
          connection.response = {
            schedule: schedule
          };
          return next(connection, false);
        });
      }
    },
    scheduleUpdate: {
      name: "scheduleUpdate",
      description: "Edits an existing schedule of a site",
      inputs: {
        required: ["id"],
        optional: ["startDate", "endDate"]
      },
      authenticated: true,
      outputExample: {},
      version: 1.0,
      run: function(api, connection, next) {
        return api.schedules.get(connection.params.id, function(err, schedule) {
          if (err) {
            connection.error = error;
            return next(connection, false);
          } else {
            return schedule.save({
              startDateTime: connection.params.startDate,
              endDateTime: connection.params.endDate
            }, function(err) {
              connection.error = error;
              connection.response = {
                schedule: schedule
              };
              return next(connection, false);
            });
          }
        });
      }
    },
    scheduleDestroy: {
      name: "scheduleDestroy",
      description: "Removes an existing schedule",
      inputs: {
        required: ["id"],
        optional: []
      },
      authenticated: true,
      outputExample: {},
      version: 1.0,
      run: function(api, connection, next) {
        return api.schedules.get(connection.params.id, function(err, schedule) {
          if (err) {
            connection.error = error;
            return next(connection, false);
          } else {
            return schedule.remove(function(err) {
              connection.error = error;
              connection.response = {
                message: "removed successfully"
              };
              return next(connection, false);
            });
          }
        });
      }
    }
  };

  module.exports = exports;

}).call(this);
