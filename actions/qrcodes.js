// Generated by CoffeeScript 1.6.3
(function() {
  var crypto, exports, generate;

  crypto = require('crypto');

  generate = function(api, data, filename, callback) {
    var _this = this;
    api.qrcode_helper.generate(data, function(error, buf) {
      var params;
      if (error) {
        callback(error, void 0);
        return false;
      }
      params = {
        Bucket: api.configData.s3.bucket_name,
        Key: filename,
        Body: buf,
        ContentLength: buf.length,
        Metadata: {
          Content: data
        }
      };
      api.aws_helper.upload(params, callback);
      return true;
    });
    return true;
  };

  exports = {
    qrCodeShow: {
      name: "qrCodeShow",
      description: "Creates and shows a qr code",
      inputs: {
        required: ["qrdata"],
        optional: []
      },
      authenticated: false,
      outputExample: {},
      version: 1.0,
      run: function(api, connection, next) {
        var callback, error, hcode, qrdata,
          _this = this;
        qrdata = connection.params.qrdata;
        if (!qrdata) {
          error = new Error("Data cannot be empty");
          error.statusCode = 400;
          connection.error = error;
          next(connection, false);
          return false;
        }
        hcode = "" + crypto.createHash('md5').update(qrdata).digest('hex');
        callback = function(error, url) {
          var ttl, validity;
          if (error) {
            api.log(error('error'));
            connection.error = error;
            next(connection, false);
            return false;
          }
          validity = 0;
          ttl = api.configData.s3.urls_expire_after || 900;
          if (api.configData.s3.use_private_urls) {
            validity = (new Date()) + ttl * 1000;
          }
          api.qrcodes.create({
            hcode: hcode,
            qrdata: qrdata,
            location: url,
            until: validity
          }, function(error) {
            if (error) {
              api.log(error('error'));
              return false;
            }
          });
          connection.response = {
            location: url
          };
          return next(connection, false);
        };
        try {
          if (api.configData.cache_qrcodes) {
            api.qrcodes.find({
              hcode: hcode
            }, 1, function(error, qrcodes) {
              var url, validity;
              if (qrcodes && qrcodes.length === 1) {
                validity = qrcodes[0].until;
                if (validity === 0 || validity < (new Date()).getTime()) {
                  url = qrcodes[0].location;
                  connection.response = {
                    location: url
                  };
                  next(connection, false);
                  return;
                }
              }
              return generate(api, qrdata, hcode + ".png", callback);
            });
          } else {
            generate(api, qrdata, hcode + ".png", callback);
          }
        } catch (_error) {
          error = _error;
          api.log(error('error'));
          connection.error = error;
          next(connection, false);
          return false;
        }
        return true;
      }
    }
  };

  module.exports = exports;

}).call(this);