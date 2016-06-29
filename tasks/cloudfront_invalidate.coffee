AWS = require 'aws-sdk'
q = require 'q'
log4js = require 'log4js'

class Cloudfront
	constructor: (@options, @grunt) ->
		@logger = log4js.getLogger()

		AWS.config.update
			accessKeyId: @options.credentials.accessKeyId
			secretAccessKey: @options.credentials.secretAccessKey
		, yes

		@instance = new AWS.CloudFront


	##### public methods

	createInvalidation: (@done) =>
		params =
			DistributionId: @options.credentials.distributionId
			InvalidationBatch:
				Paths:
					Quantity: @options.invalidations.length
					Items: @options.invalidations
				CallerReference: Date.now().toString()

		@dateCreateInvalidationStart = new Date
		@instance.createInvalidation params, @_createInvalidationCallback


	##### private (inner) methods

	_createInvalidationCallback: (err, data) =>
		if err
			grunt.log.error err, err.stack
			@options.onError? err
			@done()
		else
			@options.onSuccess? data

			if @options.onInvalidationComplete
				@_checkInvalidation data.Invalidation.Id, (completedInvalidation) =>
					totalMS = (new Date).valueOf() - @dateCreateInvalidationStart.valueOf()
					mins = Math.floor totalMS / 60000
					secs = Math.floor (totalMS - mins * 60000) / 1000
					@logger.info "Time elapsed: #{mins}min #{secs}sec"

					@options.onInvalidationComplete completedInvalidation
					@done()
			else
				@done()

	_checkInvalidation: (id, successCallback) =>
		setTimeout =>
			@_getInvalidation(id).then (data) =>
				@logger.info "Invalidation status: #{data.Invalidation.Status}"
				unless data.Invalidation.Status is 'Completed'
					@_checkInvalidation id, successCallback
				else
					successCallback data
		, @options.invalidationCheckInterval or 10000

	_getInvalidation: (id) =>
		deferred = q.defer()

		params =
			DistributionId: @options.credentials.distributionId
			Id: id
		@instance.getInvalidation params, (err, data) =>
			if err
				console.log 'CLOUDFRONT INVALIDATION FETCH ERROR:'
				grunt.log.error err, err.stack
				@options.onError? err
				deferred.reject err
			else
				deferred.resolve data

		deferred.promise


module.exports = (grunt) ->

	grunt.registerMultiTask 'cloudfront_invalidate', ->
		cloudfront = new Cloudfront @options(), grunt
		cloudfront.createInvalidation @async()