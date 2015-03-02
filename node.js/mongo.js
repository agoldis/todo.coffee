var util = require('util')
var mng = require('mongoose')
var EventEmitter = require('events').EventEmitter;

var DB = function (connectionString) {

	var schema = function () {
		var s = new mng.Schema({
			title: String,
			completed: Boolean
		})
		return s
	}
	var obj = this; // to use in callbacks

	this.createItems = function (items, callback) {
		this.TodoItemModel.create(items, function(err,items) {
			if (err) console.error(err)
			callback(items)
		});

	}

	this.getItems = function(callback) {
		this.TodoItemModel.find({}, function (err, res) {
			if (err) console.error(err);
			callback(res);
		})
	}

	this.setItem = function (id,item,callback) {
		if (item._id) delete item._id;
		this.TodoItemModel.findOneAndUpdate({ '_id': id}, item, function(err,item) {
			// TODO: what if item do not exist
			callback()
		})
	}

	this.deleteItem = function (id,callback) {
		this.TodoItemModel.findOneAndRemove({'_id': id}, function () {
			console.log('Removed item %s', id)
			callback()
		})
	}

	mng.connect(connectionString);

	var connection = mng.connection;
	connection.on('error', function () {
		console.error('Error connecting to ' + connectionString)
	})

	connection.once('open', function () {
 		console.log('Successfully connected to DB ' + connectionString)
		obj.TodoItemModel = mng.model('TodoItem',schema())
		obj.emit('connected')
	})
}
util.inherits(DB,EventEmitter)
module.exports = DB;