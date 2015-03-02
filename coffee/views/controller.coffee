define(
  [
    'backbone',
    'underscore',
    'models/item',
    'views/status',
    'constants',
    'text!templates/control.html'
  ]
  (Backbone,_,ItemModel,StatusView,constants,controlTpl) ->
    Backbone.View.extend
      template: _.template controlTpl
      events:
        'click #item-add': 'addItem'
        'click #clear-completed': 'removeCompleted'
        'click #complete-all': 'completeAll'
        'keypress #item-title-input': 'addOnEnter'
      initialize: () ->
        @createNewItem()
        @statusView = new StatusView {collection: @collection}
      addOnEnter: (e) ->
        @$('#item-title-input').parent().removeClass('has-error')
        @addItem() if e.which is constants.ENTER_KEY
      addItem: () ->
        @newItem.set(
          'title'
          @$("item-title-input").val().trim()
        )
        if @newItem.isValid()
          @collection.add @newItem
          @newItem.save()
          @createNewItem()
      createNewItem: () ->
        @stopListening(@newItem,'invalid') if @newItem
        @newItem = new ItemModel()
        @listenTo(@newItem,'invalid',@render)
        @$('#item-title-input').val('')
      removeCompleted: () ->
        completed = @collection.where {completed:true}
        completed.map (item) ->
          item.destroy()
      completeAll: () ->
        @collection.map (item) ->
          item.set('completed', true)
          item.save()
      render: () ->
        error_msg =
          if @newItem.validationError then @newItem.validationError else false
        @$el.html(@template {error: error_msg} )
        @$el.find('#app-status').html @.statusView.render().el
        @
)