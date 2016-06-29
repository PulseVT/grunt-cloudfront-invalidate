# grunt-cloudfront-invalidation

> A Grunt task for cloudfront invalidation with ability of tracking invalidation progress

## Getting Started
This plugin requires Grunt `~0.4.5`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-cloudfront-invalidation --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-cloudfront-invalidation');
```

## The "cloudfront_invalidation" task

### Overview
In your project's Gruntfile, add a section named `cloudfront_invalidation` to the data object passed into `grunt.initConfig()`.

```js
grunt.initConfig({
  cloudfront_invalidation: {
    options: {
      // Task-specific options go here.
    },
    your_target: {
      // Target-specific file lists and/or options go here.
    },
  },
});
```

### Options

#### options.credentials
Type: `Object`
Required: true

Credentials for your cloudfront cloudfront distribution.

Should contain fields:

- accessKeyId
- secretAccessKey
- distributionId

#### options.invalidations
Type: `Array`
Required: true

Only target-specific option. List of files that should be invalidated.

#### options.invalidationCheckInterval
Type: `Number`
Required: false
Default: 10000

Timeout is milliseconds to check the invalidation status

#### options.onInvalidationComplete
Type: `Function`
Required: false

Callback called when invalidation is successfully finished.
*Note!* Not specifying this option tells task not to track invalidation status and finish right after it was created.

#### options.onError
Type: `Function`
Required: false

Callback called when error during invalidation creation or getting occures

#### options.onSuccess
Type: `Function`
Required: false

Callback called when invalidation is created