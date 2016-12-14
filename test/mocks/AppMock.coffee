StaticMock = require './StaticMock'

class AppMock
    constructor: () ->
        @uses = []
        @uses.statics = []
        @sets = {}
        @gets = {}

    set: (name, value) ->
        @sets[name] = value

    use: (value) ->
        if value instanceof StaticMock
            @uses.statics.push value.path
        else
            @uses.push value

    listen: (port, cb) ->
        @listenPort = port
        cb this

    get: (path, cb) ->
        @gets[path] = cb

module.exports = AppMock
