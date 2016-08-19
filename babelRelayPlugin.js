var babelRelayPlugin = require('babel-relay-plugin');
var schema = require('./app/frontend/javascripts/relay/data/schema.json');

module.exports = babelRelayPlugin(schema.data);
