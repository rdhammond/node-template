class Server
    constructor: (ioc) ->
        ioc.Server ?= Server
        @ioc = ioc
        @app = @createApp()

    createApp: () ->
        app = @ioc.express()
        app.set 'views', './views'
        app.set 'view engine', 'pug'
        app.use @ioc.express.static('./public')
        app

    addRouter: (router) ->
        router.setup @app
        
    run: (config, cb) ->
        @app.listen config.port, () =>
            @port = config.port
            cb this


module.exports = Server
