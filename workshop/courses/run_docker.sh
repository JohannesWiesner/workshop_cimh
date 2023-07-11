#!/bin/bash

# halt, if script produces an error
set -e

################################################################################################
# Run the CIMH docker container ################################################################
################################################################################################

# We can make this function a little bit more smart by using ${PWD}. This allows us
# to place the /courses folder whereever we want without having to change the mounting
# directories. ${PWD} is short for PathtoWorkingDirectory so it will get you the absolut
# path to the location from which this script is being executed.
run_docker(){
    docker run -ti --rm \
    -v ${PWD}/nipype/code:/code  \
    -v ${PWD}/nipype/data:/data \
    -v ${PWD}/nipype/cache:/cache \
    -v ${PWD}/nipype/output:/output \
    -p 8888:8888 \
    workshop_cimh:test
}

run_docker
