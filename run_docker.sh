#!/bin/bash

run_docker(){
    docker run -ti --rm \
    -v /home/johannes.wiesner/work/repos/workshop_cimh/workshop/courses/nipype/code:/code  \
    -v /home/johannes.wiesner/work/repos/workshop_cimh/workshop/courses/nipype/data:/data \
    -v /home/johannes.wiesner/work/repos/workshop_cimh/workshop/courses/nipype/cache:/cache \
    -v /home/johannes.wiesner/work/repos/workshop_cimh/workshop/courses/nipype/output:/output \
    -p 8888:8888 \
    workshop_cimh:test
}

run_docker
