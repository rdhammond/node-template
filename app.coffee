
RootRouter = require './lib/RootRouter'
rootRouter = new RootRouter

express = require 'express'
Server = require './lib/Server'
server = new Server express
server.addRouter rootRouter

# Start app
#
config = require './config'
server.run config, (server) ->
    console.log "Listening on port #{server.port}"
