fs = require('fs')
cluster = require('cluster')

configData = {}

#########################
## General Information ##
#########################

configData.general =
  # General action hero configuration
  apiVersion: "1.0.0"
  serverName: "Pi API OAuth2 Server DEV"
  serverToken: "change-me"                                        ## A unique token to your application which servers will use to authenticate to eachother
  welcomeMessage : "Hello! Welcome to the brivolabs api"          ## The welcome message seen by TCP and webSocket clients upon connection
  flatFileDirectory: __dirname + "/public/"                       ## The directory which will be the root for the /public route
  flatFileNotFoundMessage: "Sorry, that file is not found :("     ## The body message to acompany 404 (file not found) errors regading flat files
  serverErrorMessage: "The server experienced an internal error"  ## The message to acompany 500 errors (internal server errors)
  defaultChatRoom: "brivolabs"                                    ## the chatRoom that TCP and webSocket clients are joined to when the connect
  defaultLimit: 100                                               ## defaultLimit & defaultOffset are useful for limiting the length of response lists. 
  defaultOffset: 0 
  workers : 5                                                     ## The number of internal "workers" (timers) this node will have.
  developmentMode: true                                           ## watch for changes in actions and tasks, and reload/restart them on the fly
  pidFileDirectory: process.cwd() + "/pids/"                      ## the location of the directory to keep pidfiles
  simultaneousActions: 5                                          ## how many pending actions can a single connection be working on
  # From now on we can configure vars specific to our app
  require_accept_version: true
  generator: -> Math.random().toString(36).slice(2) + Math.random().toString(36).slice(2)
  qr_max_size: 150
  cache_qrcodes: true # if true then cache the results
  database:
    user: "cory"
    port: "5432"
    password: "hotcool"
    host: "localhost"
    name: "brivolabs_api_dev"
    override_url:  process.env.HEROKU_POSTGRESQL_NAVY_URL
    reset_tables: process.env.RESET_TABLES
  s3:
    username: "cs-dev"
    access_key_id: "AKIAIB5ZGDYW6F4JQ4HA"
    secret_access_key: "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"
    bucket_name: "brivolabs-qrcodes"
    use_private_urls: false # if true then only signed URLs are provided to users
    urls_expire_after: 3600 # if using private URLs, then those URLs will expired after this amount of seconds

#############
## logging ##
#############

configData.logger =
  transports: []

## console logger
if cluster.isMaster 
  configData.logger.transports.push (api, winston) ->
    return new winston.transports.Console
      colorize: true
      level: "debug" 
      timestamp: api.utils.sqlDateTime

## file logger
try
  fs.mkdirSync "./log"
catch e
  if e.code != "EEXIST"
    console.log e
    process.exit()

configData.logger.transports.push (api, winston) ->
  return new winston.transports.File
    filename: './log/' + api.pids.title + '.log'
    level: "info"
    timestamp: true

###########
## Redis ##
###########

configData.redis =
  fake: true
  host: "127.0.0.1"
  port: 6379
  password: null
  options: null
  DB: 0

##########
## FAYE ##
##########

configData.faye = 
  mount: "/faye"
  timeout: 45
  ping: null

#############
## SERVERS ##
#############

configData.servers =
  "web" :
    secure: false                       ## HTTP or HTTPS?
    serverOptions: {}                   ## passed to https.createServer if secure=ture. Should contain SSL certificates
    port: 80                            ## Port or Socket
    bindIP: "0.0.0.0"                   ## which IP to listen on (use 0.0.0.0 for all)
    httpHeaders : {}                    ## Any additional headers you want actionHero to respond with
    urlPathForActions : ""              ## route which actions will be served from; secondary route against this route will be treated as actions, IE: /api/?action=test == /api/test/
    urlPathForFiles : "public"          ## route which static files will be served from; path (relitive to your project root) to server static content from
    rootEndpointType : ""               ## when visiting the root URL, should visitors see "api" or "file"? visitors can always visit /api and /public as normal
    directoryFileType : "index.html"    ## the default filetype to server when a user requests a directory
    flatFileCacheDuration : 60          ## the header which will be returend for all flat file served from /public; defiend in seconds
    fingerprintOptions :                ## settings for determining the id of an http(s) requset (browser-fingerprint)
      cookieKey: "sessionID"
      toSetCookie: true
      onlyStaticElements: false
    formOptions:                        ## options to be applied to incomming file uplaods.  more options and details at https:##github.com/felixge/node-formidable
      uploadDir: "/tmp"
      keepExtensions: false
      maxFieldsSize: 1024 * 1024 * 100
    returnErrorCodes: false             ## when enabled, returnErrorCodes will modify the response header for http(s) clients if connection.error is not null.  You can also set connection.responseHttpCode to specify a code per request.

##################################

exports.configData = configData;

