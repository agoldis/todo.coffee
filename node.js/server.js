// reference the http module so we can create a webserver
var express= require("express");
var bodyParser = require("body-parser");
var path = require("path");
var logger = require("morgan");
var db = require("./mongo.js")


var m = new db(process.env.MONGO_CONNECTION)

var app = express()
app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))

console.log(__dirname);
app.use(express.static(__dirname + '/../public'));

app.param('collectionName', function (req,res,next,collectionName) {
	m.getItems(function (items) {
		req.collection = items
		next()
	})
})

app.get('/collections/:collectionName', function (req, res) {res.send(req.collection)})


app.post('/collections/:collectionName', function (req, res) {
	console.log("Received new data for collection '%s'", req.params.collectionName)
	m.createItems(req.body, function (items) {
		res.send(items);	
	})
})

app.put('/collections/:collectionName/:itemid', function (req,res) {
	console.log("Updating item %s from collection '%s'", req.params.itemid, req.params.collectionName)
	m.setItem(req.params.itemid, req.body, function () {
		res.send(req.body)
	})
})

app.delete('/collections/:collectionName/:itemid', function (req,res) {
	console.log("Deleting item %s from collection '%s'", req.params.itemid , req.params.collectionName)
	m.deleteItem(req.params.itemid, function () { 
			res.send(req.params.itemid)
	})
})


// connect to Mongo and then launch HTTP server

m.once('connected', function () {
	console.log("Creating HTTP server on %s port %s",process.env.IP ,process.env.PORT);
	app.listen(process.env.PORT);
})
