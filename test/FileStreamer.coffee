expect = require 'expect.js'
FsMock = require './mocks/FsMock'
FileStreamer = require '../lib/FileStreamer'

runStream = (contents, start, size, cb) ->
    buffers = []
    fs = new FsMock contents
    streamer = new FileStreamer fs

    stream = streamer.getChunkStream 'dummy.txt', start, size
    stream.on 'data', (buffer) -> buffers.push buffer
    stream.on 'end', () ->
        data = (Buffer.concat buffers).toString()
        cb data

describe 'FileStreamer', () ->
    describe '#constructor', () ->
        it 'should set fs as expected', (done) ->
            fs = {}
            streamer = new FileStreamer fs
            (expect streamer.fs).to.equal fs
            done()

    describe '#getSize', () ->
        it 'should return proper file size', (done) ->
            fs = new FsMock 'this is a test'
            streamer = new FileStreamer fs
            size = streamer.getSize 'dummy.txt', (err, size) ->
                (expect err).to.not.be.ok()
                (expect size).to.equal fs.contents.length
                done()

    describe '#getChunkStream', (done) ->
        it 'should get entire file if no start/size specified', (done) ->
            runStream 'this is a test', null, null, (data) ->
                (expect data).to.equal 'this is a test'
                done()

        it 'should default start to 0 if not specified', (done) ->
            runStream 'this is a test', null, 4, (data) ->
                (expect data).to.equal 'this'
                done()

        it 'should default start to 0 if negative', (done) ->
            runStream 'this is a test', -1, 4, (data) ->
                (expect data).to.equal 'this'
                done()

        it 'should default start to 0 if NaN', (done) ->
            runStream 'this is a test', 'abc', 4, (data) ->
                (expect data).to.equal 'this'
                done()

        it 'should default size to rest of file if not specified', (done) ->
            runStream 'this is a test', 6, null, (data) ->
                (expect data).to.equal 's a test'
                done()

        it 'should default size to rest of file if negative', (done) ->
            runStream 'this is a test', 6, -1, (data) ->
                (expect data).to.equal 's a test'
                done()

        it 'should default size to rest of file if NaN', (done) ->
            runStream 'this is a test', 6, 'abc', (data) ->
                (expect data).to.equal 's a test'
                done()

        it 'should read sub-chunk if start and size specified', (done) ->
            runStream 'this is a test', 4, 5, (data) ->
                (expect data).to.equal ' is a'
                done()
