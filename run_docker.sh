#!/bin/bash

run_docker(){
    docker run -ti --rm \
    -v /home/johannes.wiesner/work/repos/csp_neurodocker/testing/code:/home/csp/code  \
    -v /home/johannes.wiesner/work/repos/csp_neurodocker/testing/data:/home/csp/data \
    -v /home/johannes.wiesner/work/repos/csp_neurodocker/testing//cache:/home/csp/cache \
    -v /home/johannes.wiesner/work/repos/csp_neurodocker/testing//output:/home/csp/output \
    -p 8888:8888 \
    workshop_cimh:test
}

run_docker
