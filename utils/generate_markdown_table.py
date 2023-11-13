#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
This is a little helper script that let's you convert a .json array to a
markdown table.'

@author: johannes
"""

import json
import pandas as pd
import os

###############################################################################
## User Settings 
###############################################################################

# define input file
input_file = './lecturers.json'

# define a dictionary that holds favicon links to columns. if a person's dictionary
# contains any of those keys it wil be replaced by an favicon with a hyperlink
# that points to the persons weppage
favicon_dict = {'zi':"https://www.zi-mannheim.de/favicon.ico",
                'linkedin':"https://www.linkedin.com/favicon.ico",
                "researchgate":"https://www.researchgate.net/favicon.ico",
                "orcid":"https://orcid.org/favicon.ico",
                "github":"https://github.com/favicon.ico"}

# define which colum content should be html re-formatted to visualize the 
# picture that the link points to
picture_links = ['picture']

# define if the json array should be sorted first using an key of choice
sort_by = 'last_name'

# define which columns should be merged under a new column and how the content 
# of the old columns should be separated in the new cells
merge_links = {'links':['zi','linkedin','researchgate','orcid','github']}
merge_names = {'name':['first_name','last_name']}

# cosmetics: decide over order of columns
column_order = ['picture','name','links']

# decide if you want to rename columns
rename_columns = {'name':'Name','picture':'','interests':'Interests','links':'Links'}

###############################################################################
## Run
###############################################################################

# read in input
with open(input_file) as fp:
    json_array = json.load(fp)
    
# sort array by key of choice
json_array = sorted(json_array, key=lambda d: d[sort_by]) 


# replace columns of choice with an html code that holds the favicon image
# and a hyperlink
for array_dict in json_array:
    for key,icon in favicon_dict.items():
        if key in array_dict.keys():
            array_dict[key] = f"<a href={array_dict[key]}> <img height=16 width=16 src={favicon_dict[key]}> </a>"
            
# add picture links
for array_dict in json_array:
    for key in picture_links:
        if key in array_dict.keys() and array_dict[key] != None:
            array_dict[key] = f"<img width=100 src='{array_dict[key]}'>"

# define a function that can do the merging
def merge_json_fields(json_array,merge_dict,separator):

    for array_dict in json_array:
        for new_key,old_keys in merge_dict.items():
            
            new_strings = []
            
            for old_key in old_keys:
                if old_key in array_dict.keys():
                
                    new_strings.append(array_dict[old_key])
                    del array_dict[old_key]
        
            new_strings = separator.join(new_strings)
            array_dict[new_key] = new_strings


# now summarize the old keys under a new key
merge_json_fields(json_array,merge_dict=merge_links,separator=' <br /> ')
merge_json_fields(json_array,merge_dict=merge_names,separator=' ')
        
# create dataframe from array
df = pd.DataFrame(json_array)

# reorder columns
df = df[column_order]

# rename columns
df = df.rename(columns=rename_columns)

# replace NaN values with space-character
df = df.fillna('')

# save the markdown table to a .txt file
filename = os.path.splitext(input_file)[0]

with open(f"{filename}_output.txt", 'w') as f:
    print(df.to_markdown(index=False),file=f)