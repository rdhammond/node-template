class FileStreamer
    constructor: (@fs) ->

    getSize: (path, cb) ->
        @fs.stat path, (err, stats) ->
            cb err, stats.size
            
    getChunkStream: (path, start, size) ->
        options = {}
        options.start = start if start > 0
        options.end = (options.start ? 0) + size - 1 if size > 0

        @fs.createReadStream path, options

module.exports = FileStreamer
