ReadableMock = require './ReadableMock'

class FsMock
    constructor: (@contents, @err) ->

    stat: (path, cb) ->
        cb @err, { size: @contents.length }

    createReadStream: (path, options) ->
        new ReadableMock @contents, options, @err

module.exports = FsMock
