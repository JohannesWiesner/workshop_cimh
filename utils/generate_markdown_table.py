#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
This is a little helper script that let's you convert a .json array to a
markdown table.'

@author: johannes
"""

import json
import pandas as pd

# define a dictionary that holds favicon links to attributes
favicon_dict = {'ZI':"https://www.zi-mannheim.de/favicon.ico",
                'LinkedIn':"https://www.linkedin.com/favicon.ico",
                "ResearchGate":"https://www.researchgate.net/favicon.ico"}

# define which attributes should be formatted as picture links
picture_links = ['Picture']

# define which attributes should be summarized as a new attribute 
summarize = {'Links':['ZI','LinkedIn','ResearchGate']}

# read in input
with open('./input.json') as fp:
    persons = json.load(fp)

# add the favicons to the attributes
# for person in persons:
#     for attribute,icon in favicon_dict.items():
#         if attribute in person.keys():
#             person[attribute] = f"<img height=16 width=16 src={favicon_dict[attribute]}> {person[attribute]}"

for person in persons:
    for attribute,icon in favicon_dict.items():
        if attribute in person.keys():
            person[attribute] = f"<a href={person[attribute]}> <img height=16 width=16 src={favicon_dict[attribute]}> </a>"
            

# add picture links
for person in persons:
    for attribute in picture_links:
        if person[attribute] != None:
            person[attribute] = f"<img width=100 src='{person[attribute]}'>"

# now summarize the old attributes under a new attribute and define
# how the old attributes should be separated
separator = ' <br /> '
# separator = ' '

for person in persons:
    for new_attribute,old_attributes in summarize.items():
        
        new_strings = []
        
        for old_attribute in old_attributes:
            if old_attribute in person.keys():
            
                new_strings.append(person[old_attribute])
                del person[old_attribute]
    
        new_strings = separator.join(new_strings)
        person[new_attribute] = new_strings
        
        
# save the markdown table to a .txt file
df = pd.DataFrame(persons)

with open('output.txt', 'w') as f:
    print(df.to_markdown(index=False),file=f)