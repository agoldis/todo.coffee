define(
  [
    'mr'
    'underscore'
    'text!templates/status.html'
  ]
  (Mr, _, statusTpl) ->
    Mr.ItemView.extend
      template: _.template statusTpl
      ui:
        showIncompleted: '#show-incompleted'
        showCompleted: '#show-completed'
        showAll: '#show-all'
      events:
        'click @ui.showIncompleted': 'onShowIncompleted'
        'click @ui.showCompleted': 'onShowCompleted'
        'click @ui.showAll': 'onShowAll'
      onShowIncompleted: ->
        @model.set('show', false)
        @model.set('highlight', @ui.showIncompleted.selector)
      onShowCompleted: ->
        @model.set("show", true)
        @model.set('highlight', @ui.showCompleted.selector)
      onShowAll: ->
        @model.set("show", null)
        @model.set('highlight', @ui.showAll.selector)
      initialize: () ->
        @model = new Backbone.Model()
        @model.set(
          'show': null
          'highlight': @ui.showAll
        )
      modelEvents: ->
        'change': @filterCollection
      collectionEvents: ->
        'add':  'render'
        'remove': 'render'
        'change:completed': 'filterCollection'
      serializeData: () ->
        overall = @collection.length
        completed = @collection.where({completed: true}).length
        incompleted = overall - completed
        {
          overall: overall
          completed: completed
          incompleted: incompleted
        }
      filterCollection: () ->
        word = @model.get 'show'
        @collection.each  (item) ->
          if word is null then item.set('isHidden',false) else item.set('isHidden', (item.get('completed') isnt word))
        @render()
      onRender: () ->
        $(@model.get('highlight')).addClass('btn-info active')
        @delegateEvents()
)