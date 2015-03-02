define(['backbone','underscore','text!templates/status.html'], function (Backbone,_,statusTpl) {
    return Backbone.View.extend({
        template: _.template(statusTpl),
        events: {
            'click #show-incompleted': function () {
                this.model.set("show", "incompleted");
            },
            'click #show-completed': function () {
                this.model.set("show", "completed");
            },
            'click #show-all': function () {
                this.model.set("show", "all");
            }
        },
        initialize: function () {
            this.model = new Backbone.Model();
            this.model.set("show", "all");
            this.listenTo(this.model, "change", this.filterCollection);
            this.listenTo(this.collection, 'add', this.renderCounters);
            this.listenTo(this.collection, 'remove', this.renderCounters);
            this.listenTo(this.collection, 'change:completed', this.filterCollection);
        },
        getStatus: function () {
            var overall = this.collection.length;
            var completed = this.collection.where({completed: true}).length;
            var incompleted = overall - completed;
            return {
                'overall': overall,
                'completed': completed,
                'incompleted': incompleted
            };
        },
        filterCollection: function () {
            var word = this.model.get("show");
            this.collection.each(function (item) {
                if (word === "all") {
                    item.set('isHidden', false);
                }
                else if (word === "incompleted") {
                    item.set('isHidden', item.get("completed"))
                }
                else {
                    item.set('isHidden', !item.get("completed"))
                }
            });
            this.render();
        },
        renderCounters: function () {
            var status = this.getStatus();
            this.$el.find('[data-count=completed]').html(status.completed);
            this.$el.find('[data-count=incompleted]').html(status.incompleted);
            this.$el.find('[data-count=overall]').html(status.overall);
        },
        render: function () {
            console.log('status render')
            this.$el.html(this.template());
            this.renderCounters();
            this.$el.find("button")
                .end()
                .removeClass("active btn-info")
                .find("#show-" + this.model.get("show"))
                .addClass("active btn-info");
            this.delegateEvents();
            return this;
        }
    });
});