define (
  [
    'backbone'
    'underscore'
    'views/item'
  ],
  (Backbone, _, ItemView) ->
    Backbone.View.extend
      tagName: 'ul'
      initialize: () ->
        @collection.on('add', @addItem, @)
        @collection.on('remove', @removeItem, @)
        @itemViews = []
      addItem: () ->
        newView = new ItemView {model: item}
        @itemView.push newView
        @$el.append newView.render().el
      removeItem: () ->
        i = _.indexOf(@itemViews, @)
        @itemViews.splice(i,1)
      render: () ->
        @$el.html ''
        @$el.append view.render().el for view in @itemViews
        @
)