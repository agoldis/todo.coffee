define(
  [
    'backbone'
  ]
  (Backbone) ->
    Backbone.Model.extend
      defaults:
        isHidden: false
        title: ''
        completed: false
      idAttribute: '_id'
      validate: (attrs) ->
        'Title cannot be empty' if attrs.title is ''
      toJSON: () ->
        _.pick(@attributes,'title','completed')
)