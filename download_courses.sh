 #!/bin/bash

echo "Downloading data for CIMH neuroimaging workshop"

#####################################################################################################################################
# Download the CIMH workshop repository but only keep the courses subfolder (because users need to see the other stuff)
######################################################################################################################################

curl -kLSs https://github.com/JohannesWiesner/workshop_cimh/archive/master.tar.gz | tar xz --wildcards '*courses*' --strip-components=2

#####################################################################################################################################
# Download two data files from public available AWS-buckets (one anatomical and one functional image), and place them inside
# the nipype/data folder. Then unzip the two because neuroimaging software like SPM can't handle zipped files.
######################################################################################################################################

curl --create-dirs https://s3.amazonaws.com/openneuro.org/ds004302/sub-02/anat/sub-02_T1w.nii.gz?versionId=93eQ.AwPcMeccJAT3sO9otYv4A_WH3Bj -o courses/nipype/data/single_files/functional.nii.gz
curl --create-dirs https://s3.amazonaws.com/openneuro.org/ds004302/sub-02/func/sub-02_task-speech_bold.nii.gz?versionId=fhx4kutoEiWzbik8u7lC0eqKKFkJ61HK -o courses/nipype/data/single_files/anatomical.nii.gz
gunzip courses/nipype/data/single_files/functional.nii.gz
gunzip courses/nipype/data/single_files/anatomical.nii.gz

#####################################################################################################################################
# Download anatomical files of two subjects as a BIDS-dataset
######################################################################################################################################

curl --create-dirs https://s3.amazonaws.com/openneuro.org/ds004302/sub-02/anat/sub-02_T1w.nii.gz?versionId=93eQ.AwPcMeccJAT3sO9otYv4A_WH3Bj -o courses/nipype/data/bids_dataset/sub-01/anat/sub-01_T1w.nii.gz
curl --create-dirs https://s3.amazonaws.com/openneuro.org/ds004302/sub-03/anat/sub-03_T1w.nii.gz?versionId=RKr.CFPKjWlVqEKzxeoKydGzNksffsaM -o courses/nipype/data/bids_dataset/sub-02/anat/sub-02_T1w.nii.gz
curl --create-dirs https://s3.amazonaws.com/openneuro.org/ds000248/dataset_description.json?versionId=E0KqvPi7LzpXRXQ0Gcv0CcEMEWV_IN_W -o courses/nipype/data/bids_dataset/dataset_description.json

echo "Finished downloading data for CIMH neuroimaging workshop"
