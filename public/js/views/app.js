define([
        'backbone',
        'underscore',
        'collections/list',
        'views/list',
        'views/controller',
        'text!templates/layout.html'
    ],
    function (Backbone,_, TodoCollection, ListView, ControllerView, layoutTpl) {
        return Backbone.View.extend({
            template: _.template(layoutTpl),
            initialize: function () {
                this.collection = new TodoCollection()
                this.ctrlView = new ControllerView({collection: this.collection});
                this.listView = new ListView({collection: this.collection});


            },
            render: function () {
                console.log('app render')
                this.$el.html(this.template());

                $('#app-ctrl').html(this.ctrlView.render().el);
                $("#app-items-list").html(this.listView.render().el);
                this.collection.fetch();
                return this;
            }
        });
    });