define (['backbone'], function (Backbone) {
    return Backbone.Model.extend({
        defaults: {
            isHidden: false,
            title: '',
            completed: false
        },
        idAttribute: '_id',
        validate: function (attrs) {
            if (attrs.title === '')
                return "Title cannot be empty!"
        },
        toJSON: function () {
            /// filter out unneeded attributes
            return _.pick(this.attributes, 'title', 'completed');
        }
    });
});
