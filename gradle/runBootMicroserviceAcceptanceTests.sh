#!/bin/bash -x

function dumpCurrentMicroInfraSpringVersionToFile {

    ./gradlew -q currentVersion | grep "Project version" | sed s/Project\ version\:\ //g > ~/.microInfraSpringCurrentVersion.txt
    cat ~/.microInfraSpringCurrentVersion.txt
    #TODO: Disable it
    echo -n "0.8.4" > ~/.microInfraSpringCurrentVersion.txt
    cat ~/.microInfraSpringCurrentVersion.txt
}

function cloneAndDoBuild {

    echo Checking out and building $1 with micro-infra-spring `cat ~/.microInfraSpringCurrentVersion.txt`

    git clone https://github.com/4finance/"$1".git
    cd "$1"
    #copy Gradle cache to not download dependencies again
    cp -r ../.gradle/ .
    echo "microInfraSpringVersion="`cat ~/.microInfraSpringCurrentVersion.txt` >> gradle.properties
    cat gradle.properties
    ./gradlew check
    cd ..
}


set -e
dumpCurrentMicroInfraSpringVersionToFile
cloneAndDoBuild boot-microservice
#cloneAndDoBuild boot-microservice-gui
