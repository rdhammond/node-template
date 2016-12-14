expect = require 'expect.js'
Server = require '../lib/Server'
ExpressMock = require './mocks/ExpressMock'
RouterMock = require './mocks/RouterMock'

createIoc = () ->
    expressMock = new ExpressMock

    express:
        expressMock.express

describe 'Server', () ->
    describe '#constructor(ioc)', () ->
        it 'should register ioc after first call', (done) ->
            ioc = createIoc()
            new Server ioc
            expect(ioc.Server).to.be Server
            done()

        it 'should set ioc internally', (done) ->
            ioc = createIoc()
            server = new Server ioc
            expect(server.ioc).to.be ioc
            done()

        it 'should set @app', (done) ->
            server = new Server createIoc()
            expect(server.app).to.not.be null
            done()

    describe '#createApp()', () ->
        it 'should initialize @app via express()', (done) ->
            server = new Server createIoc()
            expect(server.app).to.not.equal null
            done()

        it 'should set views path', (done) ->
            server = new Server createIoc()
            expect(server.app.sets.views).to.equal './views'
            done()

        it 'should set view engine to pug', (done) ->
            server = new Server createIoc()
            expect(server.app.sets['view engine']).to.equal 'pug'
            done()

        it 'should add static path(s)', (done) ->
            server = new Server createIoc()
            expect(server.app.uses.statics).to.contain './public'
            done()

    describe '#addRouter(router)', () ->
        it 'should call router\'s setup() function', (done) ->
            ioc = createIoc()
            server = new Server ioc
            router = new RouterMock
            server.addRouter router
            expect(router.app).to.not.be.null
            expect(router.app).to.equal server.app
            done()

    describe '#run(config, cb)', (done) ->
        # Our mocks will execute callbacks synchronously,
        # so the below should work just fine.
        #

        it 'should use callback with self', (done) ->
            server = new Server createIoc()

            server.run {port:8080}, (_server) ->
                expect(_server).to.be server
                done()

        it 'should set port before callback', (done) ->
            server = new Server createIoc()

            server.run {port:8080}, (_server) ->
                expect(server.port).to.equal 8080
                done()
