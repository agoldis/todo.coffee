#!/bin/bash

for i in `find coffee/ -name "*.coffee"`
do
	dir=`dirname $i | awk -F// '{ print $2 }'`
	/usr/local/bin/coffee --output public/js/$dir --compile $i
done
