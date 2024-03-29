// Generated by CoffeeScript 1.6.3
(function() {
  exports.middleware = function(api, next) {
    var authenticationMiddleware;
    authenticationMiddleware = function(connection, actionTemplate, next) {
      if (actionTemplate.authenticated === true) {
        return next(connection, true);
      } else {
        return next(connection, true);
      }
    };
    api.actions.preProcessors.push(authenticationMiddleware);
    return next();
  };

  module.exports = exports;

}).call(this);
