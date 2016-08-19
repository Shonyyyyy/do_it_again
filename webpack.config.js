var path = require('path');
var webpack = require('webpack');

var config = module.exports = {
  // the base path which will be used to resolve entry points
  context: __dirname,
  // the main entry point for our application's frontend JS
  entry: {
    core: './app/frontend/javascripts/core.es6.js',
    react_compiled: './app/frontend/javascripts/react_compiled.es6.jsx'
  }
};

config.output = {
  // this is our app/assets/javascripts directory, which is part of the Sprockets pipeline
  path: path.join(__dirname, 'app', 'assets', 'javascripts'),
  // the filename of the compiled bundle, e.g. app/assets/javascripts/bundle.js
  filename: '[name].js',
  // if the webpack code-splitting feature is enabled, this is the path it'll use to download bundles
  publicPath: '/assets',
  devtoolModuleFilenameTemplate: '[resourcePath]',
  devtoolFallbackModuleFilenameTemplate: '[resourcePath]?[hash]',
};

config.resolve = {
  // tell webpack which extensions to auto search when it resolves modules. With this,
  // you'll be able to do `require('./utils')` instead of `require('./utils.js')`
  extensions: ['','.coffee', '.js', '.jsx', 'es6.js', 'es6.jsx'],
  // by default, webpack will search in `web_modules` and `node_modules`. Because we're using
  // Bower, we want it to look in there too
  modulesDirectories: ['node_modules'],
};

config.module = {
  loaders: [
    {
      test: /\.coffee$/,
      loader: 'coffee-loader'
    },
    {
      test: /\.es6\.jsx$/,
      loader: 'babel',
      exclude: /node_modules/,
      query: {
        plugins: ['react-relay'],
        presets: ['es2015','react'],
      }
    },
    {
      test: /\.es6\.js$/,
      loader: 'babel',
      exclude: /node_modules/,
      query: {
        plugins: ['react-relay'],
        presets: ['es2015'],
      }
    },
  ],
};

config.plugins = [
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
  }),
];
