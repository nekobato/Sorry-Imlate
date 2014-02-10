# Dependency

fs = require 'fs'
path = require 'path'
http = require 'http'
express = require 'express'
mongoose = require 'mongoose'

# settings
pkg = require path.resolve 'package.json'
process.env.PORT or= 3000
process.env.NODE_ENV or= 'development'

# Database

if process.env.MONGO
  mongoose.connect process.env.MONGO
  debug "mongo connect to #{process.env.MONGO}"

# Application

app = exports.app = express()
app.disable 'x-powerd-by'
app.set 'models', require path.resolve 'models'
app.set 'views', path.resolve 'views'
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger 'dev' unless process.env.NODE_ENV is 'test'
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use app.router
app.use express.static path.resolve 'public'

# Server

server = exports.server = http.createServer app
server.env = require './env'
server.listen process.env.PORT, ->
  console.log "#{pkg.name} listening"
  console.log "  on port #{process.env.PORT}"
  console.log "  with mode #{process.env.NODE_ENV}"
  console.log "   ##{process.pid}"

# Routes

route = require path.resolve 'config', 'routes'

route.http app

