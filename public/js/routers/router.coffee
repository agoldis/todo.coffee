define(
  [
    'mr'
    'views/app'
  ]
  (Mr,AppView) ->
    Mr.AppRouter.extend
      routes:
        '' : 'start'
      initialize: () ->
        Backbone.history.start {pushState: true}
      start: () ->
        app = new AppView {el: '#app'}
        app.render()
)