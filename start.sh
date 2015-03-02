#!/bin/bash
export IP=127.0.0.1
export PORT=8081
export MONGO_CONNECTION=mongodb://localhost/todo

# pid=`cat /tmp/node.pid`
# echo [Killing last instance of node with pid $pid]
# kill $pid

mongo=`which mongod`;
echo [Launching mongo...]
$mongo --config /usr/local/etc/mongod.conf &

echo [Launching Nodejs...]
node=`which node`;
cd node.js && npm install && cd ..
$node node.js/server.js 
# echo $! > /tmp/node.pid
# fg