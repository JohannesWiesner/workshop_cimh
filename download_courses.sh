 #!/bin/bash

#####################################################################################################################################
# Download the CIMH workshop repository but only keep the courses subfolder (because users need to see the other stuff)
######################################################################################################################################

curl -kLSs https://github.com/JohannesWiesner/workshop_cimh/archive/master.tar.gz | tar xz --wildcards '*courses*' --strip-components=2

#####################################################################################################################################
# Download two data files from public available AWS-buckets (one anatomical and one functional image), and place them inside
# the nipype/data folder. Then unzip the two because neuroimaging software like SPM can't handle zipped files.
######################################################################################################################################

curl --create-dirs https://s3.amazonaws.com/openneuro.org/ds004302/sub-02/anat/sub-02_T1w.nii.gz?versionId=93eQ.AwPcMeccJAT3sO9otYv4A_WH3Bj -o courses/nipype/data/functional.nii.gz
curl --create-dirs https://s3.amazonaws.com/openneuro.org/ds004302/sub-02/func/sub-02_task-speech_bold.nii.gz?versionId=fhx4kutoEiWzbik8u7lC0eqKKFkJ61HK -o courses/nipype/data/anatomical.nii.gz
gunzip courses/nipype/data/functional.nii.gz
gunzip courses/nipype/data/anatomical.nii.gz

