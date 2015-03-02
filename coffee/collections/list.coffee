define(
  [
    'backbone'
    'models/item'
  ]
  (Backbone, ItemModel) ->
    Backbone.Collection.extend
      model: ItemModel
      url: 'collections/todoitems'
)