expect = require 'expect.js'
Server = require '../lib/Server'
ExpressMock = require './mocks/ExpressMock'
RouterMock = require './mocks/RouterMock'

describe 'Server', () ->
    describe '#constructor(ioc)', () ->
        it 'should set @app through express', (done) ->
            server = new Server (new ExpressMock).express
            (expect server.app).to.be.ok()
            done()

    describe '#createApp()', () ->
        it 'should initialize @app via express()', (done) ->
            expressMock = new ExpressMock
            server = new Server expressMock.express
            (expect expressMock.called).to.be.ok()
            done()

        it 'should set views path', (done) ->
            server = new Server (new ExpressMock).express
            (expect server.app.sets.views).to.equal './views'
            done()

        it 'should set view engine to pug', (done) ->
            server = new Server (new ExpressMock).express
            (expect server.app.sets['view engine']).to.equal 'pug'
            done()

        it 'should add static path(s)', (done) ->
            server = new Server (new ExpressMock).express
            (expect server.app.uses.statics).to.contain './public'
            done()

    describe '#addRouter(router)', () ->
        it 'should call router\'s setup() function', (done) ->
            server = new Server (new ExpressMock).express
            router = new RouterMock
            server.addRouter router
            (expect router.app).to.not.be.null
            (expect router.app).to.equal server.app
            done()

    describe '#run(config, cb)', (done) ->
        # Our mocks will execute callbacks synchronously,
        # so the below should work just fine.
        #

        it 'should use callback with self', (done) ->
            server = new Server (new ExpressMock).express

            server.run {port:8080}, (_server) ->
                (expect _server).to.be server
                done()

        it 'should set port before callback', (done) ->
            server = new Server (new ExpressMock).express

            server.run {port:8080}, (_server) ->
                (expect server.port).to.equal 8080
                done()
