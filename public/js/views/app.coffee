define(
  [
    'mr'
    'underscore'
    'collections/list'
    'views/list'
    'views/controller'
    'models/item'
    'text!templates/layout.html'
  ]
  (Mr,_, TodoCollection, ListView, ControllerView, ItemModel,layoutTpl) ->
    Mr.LayoutView.extend {
      template: _.template layoutTpl
      regions:
        {
          controls: '#app-ctrl'
          list: '#app-items-list'
        }
      initialize: () ->
        @collection = new TodoCollection()
      onRender: () ->
        @showChildView('controls',new ControllerView {collection: @collection} )
        @showChildView('list',new ListView {collection: @collection} )
        @collection.fetch()
    }
)