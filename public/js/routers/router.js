define(['backbone','views/app'], function (Backbone,AppView) {
    return Backbone.Router.extend({
        routes: {
            '': 'start'
        },
        initialize: function () {
            Backbone.history.start({pushState: true});
        },
        start: function () {
            console.log("Started routing")
            var app = new AppView({el: '#app'});
            app.render();
        }
    })
});