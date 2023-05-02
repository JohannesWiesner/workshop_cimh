#!/bin/bash

# sets access control list on folders inside docker container. Allow other users to have full permissions
setfacl -Rdm o::rwx /code && setfacl -Rdm o::rwx /data && setfacl -Rdm o::rwx /cache && setfacl -Rdm o::rwx /output
