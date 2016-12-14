class ResponseMock
    constructor: () ->
        @renders = []

    render: (name) ->
        @renders.push name

module.exports = ResponseMock
