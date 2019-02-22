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
mvn package -DskipTest ${MAVEN_ARGS}
echo "Copying artifacts to ../build "
mkdir -p ../build/app/lib
mkdir -p ../build/app/META-INF

cp -r target/dependency/BOOT-INF/lib ../build/app/lib
cp -r target/dependency/META-INF ../build/app/META-INF
cp -r target/dependency/BOOT-INF/classes ../build/app
cp Dockerfile.concourse ../build/Dockerfile

