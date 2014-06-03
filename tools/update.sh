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
    echo "Merging shared dependencies"
    mv hybrid/dependencies/salesforcemobilesdk-shared/dependencies/* hybrid/dependencies/
    echo "Cleaning up salesforcemobilesdk-shared"
    mkdir tmplibs; mv hybrid/dependencies/salesforcemobilesdk-shared/libs/*.js tmplibs/
    mkdir tmptest; mv hybrid/dependencies/salesforcemobilesdk-shared/test/Mock*.js tmptest/
    rm -rf hybrid/dependencies/salesforcemobilesdk-shared
    mkdir hybrid/dependencies/salesforcemobilesdk-shared
    mv tmplibs hybrid/dependencies/salesforcemobilesdk-shared/libs
    mv tmptest hybrid/dependencies/salesforcemobilesdk-shared/test
fi
