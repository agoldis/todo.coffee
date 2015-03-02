define(
  [
    'backbone'
    'views/app'
  ]
  (Backbone,AppView) ->
    Backbone.Router.extend
      routes:
        '' : 'start'
      initialize: () ->
        Backbone.history.start {pushState: true}
      start: () ->
        app = new AppView {el: '#app'}
        app.render()
)