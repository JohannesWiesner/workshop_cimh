#!/bin/bash

# halt, if script produces an error
set -e

yaml_file=workshop.yml

################################################################################################
# Function to create a Dockerfile ##############################################################
################################################################################################

generate_docker() {
    docker run -i --rm repronim/neurodocker:0.9.4 generate docker \
        --base-image neurodebian:stretch-non-free \
        --pkg-manager apt \
        --install opts="--quiet" \
            gcc \
            g++ \
            octave \
        --spm12 version=r7771 \
        --copy $yaml_file /tmp/ \
        --miniconda \
            version=latest \
            yaml_file=/tmp/$yaml_file \
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

################################################################################################
# Run functions as required ####################################################################
################################################################################################

generate_docker > Dockerfile
