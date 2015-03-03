define(
  [
    'mr'
    'text!templates/item.html'
  ]
  (Mr, itemTpl) ->
    Mr.ItemView.extend
      tagName: 'li'
      template: _.template itemTpl
      events: 'click .toggle' : 'toggleCompleted'
      initialize:  ->
        @listenTo(@model,'change', @render)
        @listenTo(@model, 'destroy', @remove)
      toggleCompleted: ->
        @model.set('completed',!@model.get 'completed')
        @model.save {'completed': @model.get 'completed'}
      onRender: ->
        @$el.toggleClass('hidden', @model.get 'isHidden')
)