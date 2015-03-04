define(
  [
    'mr'
    'underscore'
    'models/item'
    'constants'
    'text!templates/form.html'
  ]
  (Mr, _, ItemModel, constants, formTpl) ->
    Mr.ItemView.extend
      template: _.template formTpl
      ui:
        form: '.form-group'
        input: '#item-title-input'
        add: '#item-add'
        clear: '#clear-completed'
        completeAll: '#complete-all'
      modelEvents:
        'invalid': 'onInvalid'
      events:
        'click @ui.add': 'addItem'
        'click @ui.clear': 'removeCompleted'
        'click @ui.completeAll': 'completeAll'
        'keypress @ui.input': 'addOnEnter'
      addOnEnter: (e) ->
        @ui.form.removeClass('has-error')
        @addItem() if e.which is constants.ENTER_KEY
      addItem: () ->
        @model.set('title',@ui.input.val().trim())
        if @model.isValid()
          @collection.add @model
          @model.save()
          @createNewItem()
      createNewItem: () ->
        console.log 'created new item'
        @stopListening(@model,'invalid')
        @model = new ItemModel()
        @listenTo(@model,'invalid',@onInvalid)
        @ui.input.val('')
      removeCompleted: () ->
        completed = @collection.where {completed:true}
        completed.map (item) ->
          item.destroy()
      completeAll: () ->
        @collection.map (item) ->
          item.set('completed', true)
          item.save()
      onInvalid: ->
        @ui.form.addClass 'has-error'
)