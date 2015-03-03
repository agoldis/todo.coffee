define(
  [
    'backbone'
    'underscore'
    'views/item'
  ]
  (Backbone, _, ItemView) ->
    Backbone.View.extend
      tagName: 'ul'
      initialize: () ->
        @collection.on('add', @addItem, @)
        @collection.on('remove', @removeItem, @)
        @itemViews = []
      addItem: (item) ->
        newView = new ItemView {model: item}
        @itemViews.push newView
        @$el.append newView.render().el
      removeItem: (item) ->
        i = _.indexOf(@itemViews, item)
        @itemViews.splice(i,1)
      render: () ->
        @$el.html ''
        @$el.append view.render().el for view in @itemViews
        @
)