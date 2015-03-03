require.config(
  baseUrl: 'js'
  paths:
    jquery: 'vendors/jquery'
    underscore : 'vendors/underscore'
    backbone : 'vendors/backbone'
    mr: 'vendors/backbone.marionette'
    text : 'vendors/text'
    templates : '../templates'
  shim:
    mr:
      deps: ['backbone']
      exports: 'Mr'
    backbone:
      deps: ['underscore', 'jquery']
      exports: 'Backbone'
    underscore:
      exports: '_'
)

require(
  ['jquery','routers/router']
  ($, Router) -> new Router()
)