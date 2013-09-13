// Generated by CoffeeScript 1.6.3
(function() {
  var QrCode;

  QrCode = require('qrcode');

  exports.qrcode_helper = function(api, next) {
    var _this = this;
    return {
      generate: function(qrdata, callback) {
        var correction, error, max, size;
        if (!qrdata) {
          error = new Error("Data cannot be empty");
          error.statusCode = 400;
          if (callback) {
            callback(error, void 0);
            return false;
          } else {
            throw error;
          }
        }
        size = qrdata.length;
        max = api.configData.qr_max_size || 2953;
        if (size > max) {
          error = new Error("Data length is higher than maximum allowed size");
          error.statusCode = 400;
          if (callback) {
            callback(error, void 0);
            return false;
          } else {
            throw error;
          }
        }
        correction = void 0;
        if (size < 1273) {
          correction = "max";
        } else if (size < 1663) {
          correction = "high";
        } else if (size < 2331) {
          correction = "medium";
        } else if (size < 2953) {
          correction = "minimum";
        }
        QrCode.draw(qrdata, correction, function(error, canvas) {
          if (error) {
            if (callback) {
              callback(error, void 0);
              return false;
            } else {
              throw error;
            }
            return false;
          }
          canvas.toBuffer(callback);
          return true;
        });
        return true;
      }
    };
  };

  modules.exports = exports;

}).call(this);
