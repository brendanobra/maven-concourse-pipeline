#!/bin/bash

# input folders:
# version : contains a file called number with the current version
# source-code : contains the source code

# output folders:
# build: contains the built jar

set -e

source ./pipeline/tasks/common.sh

VERSION=$(build_version "./version" "number" "./source-code" $BRANCH)
echo "Version to build: ${VERSION}"


cd source-code

echo "Setting maven with version to build"
mvn versions:set -DnewVersion=${VERSION}

echo "Building artifact ..."
mvn verify ${MAVEN_ARGS}

echo "Copying artifact to ../build "
ls -la .
ls -la target/
ls ..
ls ../build
cp target/*. ../build
cp Dockerfile ../build


ls -a ../build
