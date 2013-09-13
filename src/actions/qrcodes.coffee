crypto = require 'crypto'

generate = (api, data, filename, callback) ->
  # QR code generation
  api.qrcode_helper.generate data, (error, buf) => 
    if error # there was an error creating the QR code
      callback error, undefined
      return false
    
    # then we create the params for the object
    params = 
      Bucket: api.configData.s3.bucket_name,
      Key: filename,
      Body: buf
      ContentLength: buf.length
      Metadata:
        Content: data
        
    # AWS S3 upload
    api.aws_helper.upload params, callback
    true
  true

# Module used as a controller for QR codes
exports = 

  qrCodeShow :
    name: "qrCodeShow"
    description: "Creates and shows a qr code"
    inputs:
      required: ["qrdata"]
      optional: []
    authenticated: false
    outputExample: {}
    version: 1.0
    # Method used to create a new QR code.
    # req must contain a variable called data containing string that will be used for the QR code
    run: (api, connection, next) ->
      qrdata = connection.params.qrdata
      # Check that data exists in the request
      unless qrdata
        error = new Error("Data cannot be empty")
        error.statusCode = 400
        connection.error = error
        next(connection, false)
        return false
      # create hash to identify the data
      hcode = "" + crypto.createHash('md5').update(qrdata).digest('hex')
      # callback usef to return the data
      callback = (error, url) => 
        if error # there was an error uploading the object
          api.log error 'error'
          connection.error = error
          next(connection, false)
          return false
        validity = 0
        ttl = api.configData.s3.urls_expire_after || 900
        if api.configData.s3.use_private_urls
          validity = (new Date()) + ttl * 1000
        api.qrcodes.create {
          hcode: hcode
          qrdata: qrdata
          location: url
          until: validity
        }, (error) ->
          if error
            api.log error 'error'
            return false
        connection.response = { location: url }
        next(connection, false)
      try
        if api.configData.cache_qrcodes
          api.qrcodes.find {hcode: hcode}, 1, (error, qrcodes) =>
            if qrcodes && qrcodes.length == 1
              validity = qrcodes[0].until
              if validity == 0 || validity < (new Date()).getTime()
                url = qrcodes[0].location
                connection.response = { location: url }
                next(connection, false)
                return
            generate api, qrdata, hcode + ".png", callback
        else
          generate api, qrdata, hcode + ".png", callback
      catch error
        api.log error 'error'
        connection.error = error
        next(connection, false)
        return false
      true

module.exports = exports
