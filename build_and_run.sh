#!/bin/bash

# halt, if script produces an error
set -e

build_docker() {
    docker build -t workshop_cimh:2023.07.14 .
}

run_docker(){
    docker run -ti --rm \
    -v ${PWD}/workshop/courses/nipype/code:/code  \
    -v ${PWD}/workshop/courses/nipype/data:/data \
    -v ${PWD}/workshop/courses/nipype/cache:/cache \
    -v ${PWD}/workshop/courses/nipype/output:/output \
    -p 8888:8888 \
    workshop_cimh:2023.07.14
}

build_docker && run_docker
