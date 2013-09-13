orm = require 'orm'

exports.db = (api, next) ->
  # we extract the important part of the configuration here
  config = api.configData.database
  
  # database connection
  db = orm.connect config.override_url ? "postgres://#{config.user}:#{config.password}@#{config.host}:#{config.port}/#{config.name}"
  db.on 'connect', (err, db) ->
    throw err if err
    api.log 'connected to database', 'info'

  models = {}
  # method used to create the models at the DB
  # see the models definition below
  create = (name, options) ->
    throw "model #{name} already exists" if models[name]
    api.log "defining model: #{name}", 'info'
    models[name] = db.define name, options?.columns, options
   
    if config.reset_tables
      db.on 'connect', (err, db) ->
        api.log "creating table for model: #{name}", 'info'
        models[name].drop ->
          models[name].sync (err) ->
            throw err if err
  
    models[name]

  # models definition
  # each model can have the following attributes:
  # - columns (mandatory): the columns that constitute the model
  # - options: a set of options for the model, like autoFetch to retrive the assoc
  # - hooks: actions that are executed before/after an instance is created
  # - validations: a set of validations that are performed before sending the req to the db

  api.clients = create 'client',
    columns:
      name: String
      secret: String
      redirectURL: String
            
    hooks:
      # client secrets are generated automatically
      beforeCreate: (cb) ->
        @secret = api.configData.generator()
        cb()
              
    validations:
      name: [
        orm.enforce.unique(),
        orm.enforce.ranges.length(3, undefined)
      ]
      
  api.credentials = create 'credentials',
    columns:
      value: String
      
  api.doors = create 'doors',
    columns: {}
  
  api.entryPoints = create 'entry_points',
    columns:
      name: String

  api.entryRequests = create 'entry_requests',
    columns:
      name: String
  
  api.groups = create 'groups',
    columns: {}
  
  api.identities = create 'identities',
    columns:
      firstName: String
      lastName: String
      email: String

  api.qrcodes = create 'qrcodes',
    columns:
      hcode: String
      qrdata: String
      location: String
      until: Number
  
  api.schedules = create 'schedules',
    columns:
      #name: String
      startDateTime: Date
      endDateTime: Date

  api.sites = create 'sites',
    columns:
      name: String

  api.tokens = create 'tokens',
    columns:
      data: String
      tokenType: Number

  api.users = create 'users',
    columns:
      # we commented out the name and password fields since are no longer in use
      #name: String
      ## should not be stored as plaintext in production
      ## but rather as salted SHA-2 hash, use beforeSave hook
      #password: String
      externalId: String

  api.widgets = create 'widgets',
    columns:
      name: String
      description: String
      
  # Relationship among db objects
  api.credentials.hasOne 'user', api.users, required: true, {reverse: 'credentials'}
  api.groups.hasOne 'schedule', api.schedules, {}
  api.groups.hasMany 'doors', api.doors, {}
  api.groups.hasMany 'users', api.doors, {}, {reverse:'groups'}
  api.entryPoints.hasOne 'site', api.sites, required: true
  api.entryRequests.hasMany 'tokens', api.tokens, {}, {reverse:'entryRequests'}
  api.entryRequests.hasMany 'entryPoints', api.entryPoints, {}, {reverse:'entryRequests'}
  api.entryRequests.hasMany 'schedules', api.schedules, {}, {reverse:'entryRequests'}
  api.entryRequests.hasMany 'identities', api.identities, {}, {reverse:'entryRequests'}

  next()

modules.exports = exports
