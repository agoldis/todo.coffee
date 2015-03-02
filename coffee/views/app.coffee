define(
  [
    'backbone'
    'underscore'
    'collections/list'
    'views/list'
    'views/controller'
    'text!templates/layout.html'
  ]
  (Backbone,_, TodoCollection, ListView, ControllerView, layoutTpl) ->
    Backbone.View.extend {
      template: _.template layoutTpl
      initialize: () ->
        @collection = new TodoCollection()
        @ctrlView = new ControllerView {collection: @collection}
        @listView = new ListView {collection: @collection}
      render: () ->
        @$el.html(@template())
        $('#app-ctrl').html @ctrlView.render().el
        $("#app-items-list").html @listView.render().el
        @collection.fetch()
        @
    }
)
