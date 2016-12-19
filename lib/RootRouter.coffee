class RootRouter
    constructor: () ->
    
    indexGet: (req, res) ->
        res.render 'index.pug'

    setup: (app) ->
        app.get '/', @indexGet


module.exports = RootRouter
