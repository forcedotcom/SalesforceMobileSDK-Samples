#!/bin/bash

# Run update if you want to refresh dependencies
# We check-in dependencies/ because we don't want to require consumer of the repo to run npm install or grunt

if [ ! -d "tools" ]
then
    echo "You must run this tool from the root directory of your repo clone"
else
    echo "Updating dependencies"
    cd tools
    npm install .
    grunt
    cd ..
fi
