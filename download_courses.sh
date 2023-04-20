 #!/bin/bash

#####################################################################################################################################
# Download the CIMH workshop repository but only keep the courses subfolder (because users need to see the other stuff)
######################################################################################################################################

# Adapted from: https://stackoverflow.com/a/44109535/8792159, but use wget instead of curl https://unix.stackexchange.com/a/85195/540273
wget -qO- https://github.com/JohannesWiesner/workshop_cimh/archive/master.tar.gz | tar xz --wildcards '*courses*' --strip-components=2

