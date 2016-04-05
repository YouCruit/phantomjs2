#!/bin/bash -e

if [ "x$PHANTOM_SCRIPT_URL" = "x" ]; then
	echo "phantomjs binary is located at /phantomjs2/bin/phantomjs"
	echo "just run 'phantomjs' (version `phantomjs -v`)"
else 
	wget -O phantom.js "$PHANTOM_SCRIPT_URL"
	phantomjs $PHANTOM_PARAMETERS phantom.js
fi

