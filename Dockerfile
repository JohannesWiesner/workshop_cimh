FROM ubuntu:22.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
     unzip xorg wget curl acl \
 && apt-get clean \
 && rm -rf \
     /tmp/hsperfdata* \
     /var/*/apt/*/partial \
     /var/lib/apt/lists/* \
     /var/log/apt/term*

# Install MATLAB MCR in /opt/mcr/
ENV MATLAB_VERSION R2019b
ENV MCR_VERSION v97
ENV MCR_UPDATE 9
RUN mkdir /opt/mcr_install \
 && mkdir /opt/mcr \
 && wget --progress=bar:force -P /opt/mcr_install https://ssd.mathworks.com/supportfiles/downloads/${MATLAB_VERSION}/Release/${MCR_UPDATE}/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_${MATLAB_VERSION}_Update_${MCR_UPDATE}_glnxa64.zip \
 && unzip -q /opt/mcr_install/MATLAB_Runtime_${MATLAB_VERSION}_Update_${MCR_UPDATE}_glnxa64.zip -d /opt/mcr_install \
 && /opt/mcr_install/install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent \
 && rm -rf /opt/mcr_install /tmp/*

# Install SPM Standalone in /opt/spm12/
ENV SPM_VERSION 12
ENV SPM_REVISION r7771
ENV LD_LIBRARY_PATH /opt/mcr/${MCR_VERSION}/runtime/glnxa64:/opt/mcr/${MCR_VERSION}/bin/glnxa64:/opt/mcr/${MCR_VERSION}/sys/os/glnxa64:/opt/mcr/${MCR_VERSION}/sys/opengl/lib/glnxa64:/opt/mcr/${MCR_VERSION}/extern/bin/glnxa64
ENV MCR_INHIBIT_CTF_LOCK 1
ENV SPM_HTML_BROWSER 0
# Running SPM once with "function exit" tests the succesfull installation *and*
# extracts the ctf archive which is necessary if singularity is going to be
# used later on, because singularity containers are read-only.
# Also, set +x on the entrypoint for non-root container invocations
RUN wget --no-check-certificate --progress=bar:force -P /opt https://www.fil.ion.ucl.ac.uk/spm/download/restricted/utopia/spm12/spm${SPM_VERSION}_${SPM_REVISION}_Linux_${MATLAB_VERSION}.zip \
 && unzip -q /opt/spm${SPM_VERSION}_${SPM_REVISION}_Linux_${MATLAB_VERSION}.zip -d /opt \
 && rm -f /opt/spm${SPM_VERSION}_${SPM_REVISION}_Linux_${MATLAB_VERSION}.zip \
 && /opt/spm${SPM_VERSION}/spm${SPM_VERSION} function exit \
 && chmod +x /opt/spm${SPM_VERSION}/spm${SPM_VERSION}

# Add conda installation derived from Neurodocker
COPY ["workshop.yml", \
      "/tmp/"]
ENV CONDA_DIR="/opt/miniconda-latest" \
    PATH="/opt/miniconda-latest/bin:$PATH"
RUN export PATH="/opt/miniconda-latest/bin:$PATH" \
    && echo "Downloading Miniconda installer ..." \
    && conda_installer="/tmp/miniconda.sh" \
    && curl -fsSL -o "$conda_installer" https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash "$conda_installer" -b -p /opt/miniconda-latest \
    && rm -f "$conda_installer" \
    && conda update -yq -nbase conda \
    # Prefer packages in conda-forge
    && conda config --system --prepend channels conda-forge \
    # Packages in lower-priority channels not considered if a package with the same
    # name exists in a higher priority channel. Can dramatically speed up installations.
    # Conda recommends this as a default
    # https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-channels.html
    && conda config --set channel_priority strict \
    && conda config --system --set auto_update_conda false \
    && conda config --system --set show_channel_urls true \
    # Enable `conda activate`
    && conda init bash \
    && conda env create  --name csp --file /tmp/workshop.yml \
    # Clean up
    && sync && conda clean --all --yes && sync \
    && rm -rf ~/.cache/pip/*
RUN test "$(getent passwd csp)" \
    || useradd --no-user-group --create-home --shell /bin/bash csp

# set global variables for SPM and Matlab
ENV SPMMCRCMD="/opt/spm12/run_spm12.sh /opt/mcr/v97 script"
ENV MATLABCMD="/opt/mcr/v97/toolbox/matlab"
ENV FORCE_SPMMCR="1"

# INSTALL FSL
# Setup Workdir
RUN mkdir /opt/fsl_install
WORKDIR   /opt/fsl_install

# Download fsl files
RUN wget https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py

# Modify order of channels in python env
RUN python3 fslinstaller.py  -d /usr/local/fsl

# RM src
WORKDIR /
RUN rm -rf /usr/local/fsl/src
RUN rm -rf /opt/fsl_install

# Setup FSL ENV
ENV FSLDIR=/usr/local/fsl
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/fsl/bin
ENV LD_LIBRARY_PATH=/usr/local/fsl/lib
ENV FSLOUTPUTTYPE=NIFTI_GZ
RUN . $FSLDIR/etc/fslconf/fsl.sh

# Install ANTS
ENV ANTSPATH="/opt/ants-2.4.1/" \
    PATH="/opt/ants-2.4.1:$PATH"
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           ca-certificates \
           curl \
           unzip \
    && rm -rf /var/lib/apt/lists/* \
    && echo "Downloading ANTs ..." \
    && curl -fsSL -o ants.zip https://github.com/ANTsX/ANTs/releases/download/v2.4.1/ants-2.4.1-centos7-X64-gcc.zip \
    && unzip ants.zip -d /opt \
    && mv /opt/ants-2.4.1/bin/* /opt/ants-2.4.1 \
    && rm ants.zip

# create directories and set user settings
RUN mkdir /code
RUN mkdir /data
RUN mkdir /cache
RUN mkdir /output
RUN mkdir ~root/.jupyter && echo c.NotebookApp.ip = \"0.0.0.0\" > ~root/.jupyter/jupyter_notebook_config.py
RUN echo c.NotebookApp.allow_root=True >> ~root/.jupyter/jupyter_notebook_config.py
RUN echo source activate csp >> ~root/.bashrc
WORKDIR /code
COPY ["setfacl.sh","/tmp"]
CMD ["/tmp/setfacl.sh"]
