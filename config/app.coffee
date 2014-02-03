# Dependency

fs = require 'fs'
path = require 'path'
http = require 'http'
debug = require('debug')('coah')
express = require 'express'
mongoose = require 'mongoose'
direquire = require 'direquire'

# Database

if process.env.MONGO
  mongoose.connect process.env.MONGO
  debug "mongo connect to #{process.env.MONGO}"

# Application

app = exports.app = express()
app.disable 'x-powerd-by'
app.set 'events', direquire path.resolve 'events'
app.set 'models', direquire path.resolve 'models'
app.set 'helper', direquire path.resolve 'helper'
app.set 'views', path.resolve 'views'
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger 'dev' unless process.env.NODE_ENV is 'test'
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use app.router
if process.env.NODE_ENV is 'development'
  app.use express.static path.resolve 'dist'
  app.use (req, res) ->
    express.static(path.resolve './')(req, res) if /^\/assets\//.test req.url
  app.use express.errorHandler()
else
  app.use express.static path.resolve 'public'

if process.env.NODE_ENV isnt 'production'
  debug "using error handler"

# Server

server = exports.server = http.createServer app

# Routes

route = require path.resolve 'config', 'routes'

route.http app

