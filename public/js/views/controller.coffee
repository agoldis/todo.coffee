define(
  [
    'mr'
    'underscore'
    'views/status'
    'views/form'
    'models/item'
    'text!templates/control.html'
  ]
  (Mr, _, StatusView, FormView, ItemModel, controlTpl) ->
    Mr.LayoutView.extend
      template: _.template controlTpl
      regions:
        form: '#app-form'
        status: '#app-status'
      onShow: () ->
        @showChildView('form', new FormView(
          collection: @collection
          model: new ItemModel
        ))
        @showChildView('status', new StatusView(
          collection: @collection
        ))
)