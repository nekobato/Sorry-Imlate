# Environment

process.env.NODE_ENV = 'test'

# Dependencies

fs = require 'fs'
path = require 'path'
assert = require 'assert'
request = require 'supertest'
{app} = require '../config/app.coffee'

describe 'coah', ->

  it 'sohuld be index', (done) ->
    request(app).get('/').expect(200).end done

