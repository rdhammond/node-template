StaticMock = require './StaticMock'
AppMock = require './AppMock'

class ExpressMock
    constructor: () ->
        @called = no
        @express.static = @createStatic

    ###
    # Have to hard-bind here since we're simulating
    # an external function.
    ###
    express: () =>
        @called = yes
        new AppMock

    createStatic: (path) ->
        new StaticMock path

module.exports = ExpressMock
