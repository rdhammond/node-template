scrubNumber = (num) ->
    if (not num?) or (isNaN num) or (num < 0)
        undefined
    else
        num

class ReadableMock
    constructor: (@contents, options, @err) ->
        @events = {}
        @start = scrubNumber (options?.start ? undefined)
        @end = scrubNumber (options?.end ? undefined)

    on: (name, cb) ->
        if name is 'data'
            @events.data = cb
            setImmediate () => @emulateReading()
        else if name is 'end'
            @events.end = cb
        else if name is 'error'
            @events.error = cb

    emulateReading: () ->
        return @events.error @err if @err?

        chunk = null

        if @start and @end
            chunk = @contents.substr @start, @end - @start + 1
        else if @start? and not @end?
            chunk = @contents.substr @start
        else if not @start? and @end?
            chunk = @contents.substr 0, @end + 1
        else
            chunk = @contents

        @events.data (Buffer.from chunk)
        @events.end()

module.exports = ReadableMock
