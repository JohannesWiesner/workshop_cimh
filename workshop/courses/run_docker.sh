#!/bin/bash

# halt, if script produces an error
set -e

################################################################################################
# Run the CIMH docker container ################################################################
################################################################################################

# We can make this function a little bit more smart by using ${PWD}. This allows us
# to place the /courses folder whereever we want without having to manually define the mount
# directories on the host. ${PWD} is short for PathtoWorkingDirectory so it will get you
# the absolut path to the location from which this script is being executed. We also include
# an if-else statement that first detects the operating system and then uses
# winpty rocker run if the user is on Windows (as we expect users on windows to run this
# script from Git Bash. Only with winpty docker run [...] Git Bash is able to run an interactive
# container (see here https://stackoverflow.com/a/55972277/8792159).
# It's also important that we write /${PWD} and not ${PWD}. See here:
# https://github.com/docker-archive/toolbox/issues/673#issuecomment-479374041
run_docker(){
    if [[ "$OSTYPE" == "msys" ]]; then
        winpty docker run -ti --rm \
        -v /${PWD}/nipype/code:/code  \
        -v /${PWD}/nipype/data:/data \
        -v /${PWD}/nipype/cache:/cache \
        -v /${PWD}/nipype/output:/output \
        -p 8888:8888 \
        johanneswiesner/workshop_cimh:2023.07.14
    else
        docker run -ti --rm \
        -v ${PWD}/nipype/code:/code  \
        -v ${PWD}/nipype/data:/data \
        -v ${PWD}/nipype/cache:/cache \
        -v ${PWD}/nipype/output:/output \
        -p 8888:8888 \
        johanneswiesner/workshop_cimh:2023.07.14
    fi
}

run_docker
