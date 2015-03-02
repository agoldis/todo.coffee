define(['backbone','underscore','views/item'], function (Backbone,_,ItemView) {
    return Backbone.View.extend({
        tagName: 'ul',
        initialize: function () {
            this.collection.on('add', this.addItem, this);
            this.collection.on('remove', this.removeItem, this);
            this.itemViews = []
        },
        addItem: function (item) {
            var newView = new ItemView({model: item});
            this.itemViews.push(newView);
            this.$el.append(newView.render().el);
        },
        removeItem: function (item) {
            var i = _.indexOf(this.itemViews,item);
            this.itemViews.splice(i,1);
        },
        render: function () {
            this.$el.html('');
            this.itemViews.forEach(function (itemView) {
                this.$el.append(itemView.render().el);
            }, this);
            return this;
        }
    });

});