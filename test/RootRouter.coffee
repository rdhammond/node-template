expect = require 'expect.js'
RootRouter = require '../lib/RootRouter'
AppMock = require './mocks/AppMock'
ResponseMock = require './mocks/ResponseMock'

describe 'RootRouter', () ->
    describe '#indexGet(req, res)', () ->
        it 'should call render() with index view', (done) ->
            res = new ResponseMock
            router = new RootRouter
            router.indexGet {}, res
            expect(res.renders).to.contain 'index.pug'
            done()

    describe '#setup(app)', () ->
        it 'should call get() to set up index view', (done) ->
            app = new AppMock
            router = new RootRouter
            router.setup app
            expect(app.gets['/']).to.not.equal null
            expect(app.gets['/']).to.be router.indexGet
            done()
