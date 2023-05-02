#!/bin/bash

run_docker(){
    docker run -ti --rm \
    -v /home/johannes.wiesner/work/repos/csp_neurodocker/testing/code:/code  \
    -v /home/johannes.wiesner/work/repos/csp_neurodocker/testing/data:/data \
    -v /home/johannes.wiesner/work/repos/csp_neurodocker/testing//cache:/cache \
    -v /home/johannes.wiesner/work/repos/csp_neurodocker/testing//output:/output \
    -p 8888:8888 \
    workshop_cimh:test
}

run_docker
