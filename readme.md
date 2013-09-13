# General

  This Application targets the Cloudspokes challenge described [here](http://www.cloudspokes.com/challenges/2660).
  It utilizes [CoffeeScript](http://coffeescript.org/), a language that compiles into Javascript.
  The Application provides basic CRUD functionality and OAuth2 authentication. It is using [node](http://nodejs.org/) 
  with [restify](http://mcavage.me/node-restify/) and can be easily deployed to [heroku](http://heroku.com).

   [orm2](https://github.com/dresende/node-orm2) is used for database transactions, 
   [restify-oauth2](https://github.com/domenic/restify-oauth2) provides basic OAuth2 functionality.
   [aws-sdk](https://github.com/aws/aws-sdk-js), the official nodejs SDK from Amazon, is used to access their services.
   [qrcode](https://github.com/soldair/node-qrcode) provides the QR coding functionality.

  If you prefer Javascript over CoffeeScript you can use it aswell.
  You could for example create a new route "/foo" and create a corresponding "foo-controller.js" in the controllers directory.

   You can find a demo video of the application [here](http://screencast.com/t/40VBwpFz5ij5) 
    and a video explaining the basic architecture [here](http://screencast.com/t/gK19wn3a).
    postman.json provides some sample requests for 
    [Postman](https://chrome.google.com/webstore/detail/postman-rest-client/fdmmgilgnpjigdojojpjoooidkmcomcm?hl=en).
    A demo version of the application has been [pushed to heroku](http://evening-anchorage-1209.herokuapp.com/), 
    the demo version will wipe the database on each restart.
    src/demos/qrcode.html provides a sample for the QR code generation

  When using Postman, the following VARS should exist
  1. {{Version}} ==> defines the API version
  1. {{URL}} ==> base url
  1. {{Token}} ==> oauth token

# Configuration

  All Configuration is bundled in a single file, namely src/config.coffee.
  This list will explain the various options.

*   **equire_accept_version** if set to true the HTTP client is forced to deliver the "Accept-Version" header
*   **server_name** the server name as it is provided to restify
*   **token_url** the path where clients can request a token
*   **auth_realm** the WWW-Authenticate realm send to the clients
*   **generator** default password/token generator
*   **qr_max_size** the max size for the data used to generate a QR code
*   **cache_qrcodes** if true then cache the results in the database
*   **database** all settings related directly to the postgres database

    *   **user** the name of the database user
    *   **password** the password of the given user
    *   **host** the database server
    *   **port** port to use
    *   **override_url** this can be set to ignore all above values and use a prepared url to connect, especially useful for heroku
    *   **reset_tables** this will reset all required tables (tables are dropped and created afterwards), can be used to initialize the database
* **s3** all settings related directly to the amazon s3 storage service
  * *username** the name of the s3 user
  * **access_key_id** the given access key id for the s3 user
  * **secret_access_key** the secret access key for the s3 user
  * **bucket_name** the name of the bucket to upload the objects to
  * **use_private_urls** if true then objects will be private and a temporal URL to access them will be generated
  * **urls_expire_after** if using private URLs, this value defined the lifetime of the objects (in seconds)
      
  * To obtain your Amazon credentials:
    * Go to the service page
    * Hover over "My Account", and click on "Security Credentials"
    * Scroll to the "Access credentials" section
    * Your access key is listed under "Access Key ID"
    * Click the "Show" link under "Secret Access Key" to show your secret access key

# Versioning and Routing

  This application is using restify and thus supports [route versioning](http://mcavage.me/node-restify/#Routing). 
  The server will report the version of the requested route in each response (see "Version" header). The client should supply an "Accept-Version" header.
  The version number must comply with [semver](http://semver.org/) syntax.

  All routes are specified in routes.coffe, each route defines a hashmap with a correspondig controller (a requireJS module), 
  a version (defaults to 1.0.0) and handlers for at least one HTTP verb.
  Take a look at the routes.coffe file for examples.

# Local Deployment

1. Ensure you have coffescript installed.  If you do not, run command: sudo npm install -g coffee-script
1. If desired, compile the app to javascript if you would like with the command: coffee --compile --output lib/ src/ where lib is the target to compile to
1. Install node dependencies: npm install
1. Update the config.coffee file pointing to your local copy of postgres (Or the heroku-hosted instance, if available)
1. To run the app with coffescript simply: coffee src/app.coffee
1. Alternately, you can use foreman: foreman start

# Heroku Deployment

  Heroku deployment requires adding a postgres database first, and updating a single app config.  Depending on your database you need to adjust the database connection settings in the config file, see [heroku devcenter](https://devcenter.heroku.com/articles/nodejs#using-a-postgresql-database) for details.

  For the QR code image generation, the deployment to Heroku also needs to use a custom BUILDPACK that provides the cairo package, used to draw the QR canvas.  Local deployment may require installing Cairo and some dependencies. 
   More info here: [node-canvas instructions](https://github.com/LearnBoost/node-canvas/wiki/_pages)

### Typical Deployment Procedure

1.  git clone git@github.com:cloudspokes/brivolabs-pi.git
2.  cd brivolabs-pi
3.  heroku apps:create pi-api-**$YOURNAME**
4. heroku config:add BUILDPACK_URL=git://github.com/mojodna/heroku-buildpack-nodejs.git#cairo
4.  heroku addons:add heroku-postgresql:dev
5.  heroku config
6.  update src/config.coffee: set database.override_url property with the correct “color” of postgres URL from heroku config (if different!)
7.  git commit -a -m “updated database URL”
8.  heroku config:set RESET_TABLES=true
9.  git push heroku master
10.  hit: http://pi-api-**$YOURNAME**.herokuapp.com/
11.  heroku config:unset RESET_TABLES
12.  done!
