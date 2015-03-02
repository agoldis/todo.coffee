define(['backbone','text!templates/item.html'], function (Backbone, itemTpl) {
    return Backbone.View.extend({
        tagName: 'li',
        template: _.template(itemTpl),
        events: {
            'click .toggle': 'toggleCompleted'
        },
        initialize: function () {
            this.listenTo(this.model, 'change', this.render);
            this.listenTo(this.model, 'destroy', this.remove)
        },
        toggleCompleted: function () {
            this.model.set('completed', !this.model.get('completed'));
            this.model.save({completed: this.model.get('completed')});
        },
        render: function () {
            console.log('render model "%s" isHidden: %s', this.model.get('title'), this.model.get('isHidden'))
            this.$el.html(this.template(this.model.attributes));
            this.$el.toggleClass('hidden', this.model.get('isHidden'));
            return this;
        }
    });
});