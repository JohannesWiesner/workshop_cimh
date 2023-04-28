#!/bin/bash

###################################################################
## Generate a Dockerfile for CIMH Neuroimaging Workshop ###########
###################################################################

# halt, if script produces an error
set -e

generate_docker() {
    docker run -i --rm repronim/neurodocker:0.9.4 generate docker \
        --base-image neurodebian:stretch-non-free \
        --pkg-manager apt \
        --install opts="--quiet" \
            gcc \
            g++ \
            octave \
        --matlabmcr version=2017b \
        --cat12 version=r1933_R2017b \
        --copy workshop.yml /tmp/ \
        --miniconda \
            version=latest \
            yaml_file=/tmp/workshop.yml \
            env_name=csp \
        --user csp \
        --run 'mkdir /home/csp/code && chmod -R 777 /home/csp/code' \
        --run 'mkdir /home/csp/data && chmod -R 777 /home/csp/data' \
        --run 'mkdir /home/csp/cache && chmod -R 777 /home/csp/cache' \
        --run 'mkdir /home/csp/output && chmod -R 777 /home/csp/output' \
        --run 'mkdir /home/csp/.jupyter && echo c.NotebookApp.ip = \"0.0.0.0\" > home/csp/.jupyter/jupyter_notebook_config.py' \
        --workdir /home/csp/code \
        --run 'echo source activate csp >> /home/csp/.bashrc'
}

generate_docker > Dockerfile
