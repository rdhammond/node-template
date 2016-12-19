class Server
    constructor: (express) ->
        @app = @createApp(express)

    createApp: (express) ->
        app = express()
        app.set 'views', './views'
        app.set 'view engine', 'pug'
        app.use express.static('./public')
        app

    addRouter: (router) ->
        router.setup @app
        
    run: (config, cb) ->
        @app.listen config.port, () =>
            @port = config.port
            cb this

module.exports = Server
