 #!/bin/bash

echo "Downloading data for CIMH neuroimaging workshop"

#####################################################################################################################################
# Download the CIMH workshop repository but only keep the courses subfolder (because users don't need the other folders)
######################################################################################################################################

# FIXME: Must be a more elegant way to do the following
curl -kLSs https://github.com/JohannesWiesner/workshop_cimh/archive/master.tar.gz | tar xz --wildcards '*courses*' --strip-components=2 --exclude="*.md" && mv courses workshop_cimh && find workshop_cimh -type d -empty -delete

#####################################################################################################################################
# Download two data files from public available AWS-buckets (one anatomical and one functional image), and place them inside
# the nipype/data folder. Then unzip the two because neuroimaging software like SPM can't handle zipped files.
######################################################################################################################################

curl --create-dirs https://s3.amazonaws.com/openneuro.org/ds004302/sub-02/anat/sub-02_T1w.nii.gz?versionId=93eQ.AwPcMeccJAT3sO9otYv4A_WH3Bj -o workshop_cimh/nipype/data/single_files/anatomical.nii.gz
curl --create-dirs https://s3.amazonaws.com/openneuro.org/ds004302/sub-02/func/sub-02_task-speech_bold.nii.gz?versionId=fhx4kutoEiWzbik8u7lC0eqKKFkJ61HK -o workshop_cimh/nipype/data/single_files/functional.nii.gz
gunzip workshop_cimh/nipype/data/single_files/functional.nii.gz
gunzip workshop_cimh/nipype/data/single_files/anatomical.nii.gz

#####################################################################################################################################
# Download SPM-auditory dataset
######################################################################################################################################

curl --create-dirs  https://raw.githubusercontent.com/JohannesWiesner/workshop_cimh/master/data/auditory_events.tsv -o workshop_cimh/nipype/data/single_files/auditory_events.tsv
curl --create-dirs  https://raw.githubusercontent.com/JohannesWiesner/workshop_cimh/master/data/auditory_fmri_img.nii.gz -o workshop_cimh/nipype/data/single_files/auditory_fmri_img.nii.gz
gunzip workshop_cimh/nipype/data/single_files/auditory_fmri_img.nii.gz

#####################################################################################################################################
# Download anatomical files of two subjects as a BIDS-dataset
#####################################################################################################################################

# FIXME: This downloads the same file that is already downloaded above.
curl --create-dirs https://s3.amazonaws.com/openneuro.org/ds004302/sub-02/anat/sub-02_T1w.nii.gz?versionId=93eQ.AwPcMeccJAT3sO9otYv4A_WH3Bj -o workshop_cimh/nipype/data/bids_dataset/sub-01/anat/sub-01_T1w.nii.gz
curl --create-dirs https://s3.amazonaws.com/openneuro.org/ds004302/sub-03/anat/sub-03_T1w.nii.gz?versionId=RKr.CFPKjWlVqEKzxeoKydGzNksffsaM -o workshop_cimh/nipype/data/bids_dataset/sub-02/anat/sub-02_T1w.nii.gz
curl --create-dirs https://s3.amazonaws.com/openneuro.org/ds000248/dataset_description.json?versionId=E0KqvPi7LzpXRXQ0Gcv0CcEMEWV_IN_W -o workshop_cimh/nipype/data/bids_dataset/dataset_description.json

#####################################################################################################################################
# Download MNI Template
#####################################################################################################################################

# TODO: Should a smarter way than doing cd + rename file to mni_template.nii.gz
cd workshop_cimh/nipype/data/single_files
curl -kLSs https://files.osf.io/v1/resources/fvuh8/providers/osfstorage/580705089ad5a101f17944a9 | tar xz --wildcards '*1mm_T1.nii.gz' --strip-components=1

echo "Finished downloading data for CIMH neuroimaging workshop"

#####################################################################################################################################
# Download docker image
#####################################################################################################################################

echo "Pulling Docker image"
docker pull johanneswiesner/workshop_cimh:2023.07.14
