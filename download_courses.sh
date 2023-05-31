 #!/bin/bash

#####################################################################################################################################
# Download the CIMH workshop repository but only keep the courses subfolder (because users need to see the other stuff)
######################################################################################################################################

curl -kLSs https://github.com/JohannesWiesner/workshop_cimh/archive/master.tar.gz | tar xz --wildcards '*courses*' --strip-components=2

