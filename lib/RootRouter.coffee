class RootRouter
    constructor: (ioc) ->
        ioc.RootRouter ?= RootRouter
    
    indexGet: (req, res) ->
        res.render 'index.pug'

    setup: (app) ->
        app.get '/', @indexGet


module.exports = RootRouter
