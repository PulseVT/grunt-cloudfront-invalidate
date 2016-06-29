# grunt-cloudfront-invalidate

> A Grunt task for cloudfront invalidation

## Getting Started
This plugin requires Grunt `~0.4.5`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-cloudfront-invalidate --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-cloudfront-invalidate');
```

## The "cloudfront_invalidate" task

### Overview
In your project's Gruntfile, add a section named `cloudfront_invalidate` to the data object passed into `grunt.initConfig()`.

```js
grunt.initConfig({
  cloudfront_invalidate: {
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

#### options.onError
Type: `Function`
Required: false

#### options.onSuccess
Type: `Function`
Required: false

#### options.onInvalidationComplete
Type: `Function`
Required: false