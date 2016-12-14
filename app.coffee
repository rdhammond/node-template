config = require './config'
Server = require './lib/Server'
RootRouter = require './lib/RootRouter'


# IOC init
#
ioc =
    express: require 'express'


# Router init
#
rootRouter = new RootRouter ioc


# Server init
#
server = new Server ioc
server.addRouter rootRouter

# Start app
#
server.run config, (server) ->
    console.log "Listening on port #{server.port}"
