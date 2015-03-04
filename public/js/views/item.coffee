define(
  [
    'mr'
    'text!templates/item.html'
  ]
  (Mr, itemTpl) ->
    Mr.ItemView.extend
      tagName: 'li'
      template: _.template itemTpl
      ui:
        toggle: '.toggle'
      events: 'click @ui.toggle' : 'toggleCompleted'
      modelEvents:
        'change': 'render'
        'destroy': 'remove'
      toggleCompleted: ->
        @model.set('completed',!@model.get 'completed')
        @model.save {'completed': @model.get 'completed'}
      onRender: ->
        @$el.toggleClass('hidden', @model.get 'isHidden')
)