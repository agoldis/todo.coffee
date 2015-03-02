define(['backbone','models/item'], function (Backbone, ItemModel) {

    return Backbone.Collection.extend({
            model: ItemModel,
            url: 'collections/todoitems'
        });
});