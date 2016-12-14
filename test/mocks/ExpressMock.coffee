StaticMock = require './StaticMock'
AppMock = require './AppMock'

class ExpressMock
    constructor: () ->
        @express.static = @createStatic

    express: () ->
        new AppMock

    createStatic: (path) ->
        new StaticMock path

module.exports = ExpressMock
