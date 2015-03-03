define(
  [
    'backbone'
    'text!templates/item.html'
  ]
  (Backbone, itemTpl) ->
    Backbone.View.extend
      tagName: 'li'
      template: _.template itemTpl
      events: 'click .toggle' : 'toggleCompleted'
      initialize:  ->
        @listenTo(@model,'change', @render)
        @listenTo(@model, 'destroy', @remove)
      toggleCompleted: ->
        @model.set('completed',!@model.get 'completed')
        @model.save {'completed': @model.get 'completed'}
      render: ->
        @$el.html( @template @model.attributes)
        @$el.toggleClass('hidden', @model.get 'isHidden')
        @
)