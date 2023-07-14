# Define a workflow that iterates over two subjects and then:
# 1.) Skullstrip (using FSL BET)
# 2.) Normalize (use ANTS): https://miykael.github.io/nipype_tutorial/notebooks/example_normalize.html#Normalization-with-ANTs
# Use https://nipype.readthedocs.io/en/latest/api/generated/nipype.interfaces.ants.html#registrationsynquick otherwise it will take too long!

#t1_image = '/home/johannes.wiesner/work/repos/workshop_cimh/workshop/courses/nipype/data/anatomical.nii'
#import nipype.interfaces.fsl as fsl
#mybet = fsl.BET(in_file=t1_image, out_file='bar.nii')
#result = mybet.run()

from nipype.interfaces.utility import Function,IdentityInterface, Rename
from nipype.interfaces.io import BIDSDataGrabber
from nipype import Workflow, Node

data_dir = '/home/johannes.wiesner/work/repos/workshop_cimh/workshop/courses/nipype/data/bids_dataset/'
cache_dir = '/home/johannes.wiesner/work/repos/workshop_cimh/workshop/courses/nipype/cache/'

# create a node that iterates over the subject(s)
subject_iterator = Node(IdentityInterface(fields=["subject_id"]),name="subject_iterator")
subject_iterator.iterables = [("subject_id",['01','02'])]

# create a Node that takes in a BIDS-Dataset and returns data for one subject
data_grabber = Node(BIDSDataGrabber(base_dir=data_dir,raise_on_empty=False),name='data_grabber')

# define workflow
wf = Workflow(name='anatomical_workflow',base_dir=cache_dir)
wf.connect(subject_iterator,'subject_id',data_grabber,'subject')
wf.run()