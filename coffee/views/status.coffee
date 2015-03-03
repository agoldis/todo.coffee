define(
  [
    'backbone'
    'underscore'
    'text!templates/status.html'
  ]
  (Backbone, _, statusTpl) ->
    Backbone.View.extend
      template: _.template statusTpl
      events:
        'click #show-incompleted': () ->
          @model.set('show','incompleted')
        'click #show-completed': () ->
          @model.set("show", "completed")
        'click #show-all': () ->
          @model.set("show", "all")
      initialize: () ->
        @model = new Backbone.Model()
        @model.set("show", "all")
        @listenTo(@model, "change", @filterCollection)
        @listenTo(@collection, 'add', @renderCounters)
        @listenTo(@collection, 'remove', @renderCounters)
        @listenTo(@collection, 'change:completed', @filterCollection)
      getStatus: () ->
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
          if word is 'all'
            item.set('isHidden',false)
          else if word is 'completed'
            item.set('isHidden', not item.get 'completed')
          else
            item.set('isHidden', item.get 'completed')
        @render()
      renderCounters: () ->
        status = @getStatus()
        @$el.find('[data-count=completed]').html(status.completed)
        @$el.find('[data-count=incompleted]').html(status.incompleted)
        @$el.find('[data-count=overall]').html(status.overall)
      render: () ->
        @$el.html @template()
        @renderCounters()
        @$el.find 'button'
        .end()
        .removeClass 'active btn-info'
        .find("#show-#{@model.get 'show'}")
        .addClass 'active btn-info'
        @delegateEvents()
        @
)