require.config({
    baseUrl: "js",
    paths: {
        'jquery' : 'vendors/jquery',
        'underscore' : 'vendors/underscore',
        'backbone' : 'vendors/backbone',
        'text' : 'vendors/text',
        'templates' : '../templates'
    },
    shim: {
        'backbone' : {
            deps: ['underscore', 'jquery'],
            exports: 'Backbone'
        },
        'underscore' : {
            exports: '_'
        }
    }
});
require([
        'jquery',
        'routers/router'
    ],
    function ($,Router) {
        $(function () {
            new Router()
        }());
    }
);