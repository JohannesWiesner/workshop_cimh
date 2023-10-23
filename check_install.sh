#!/usr/bin/env bash

# Script to run after following all install instructions to make sure that
# everything was installed correctly!
#
# Usage:
#
#     $ bash check_install.sh
#
# The script will try and print out any missing programs to the screen with
# brief instructions on how to install them. If everything is installed
# correctly you will see a message printed to screen notifying you of this.
#

missing=

function check_installed() {
    func=${1}
    hash ${func} 2> /dev/null || {
        printf "Missing software program: ${func}. "
        printf "Check installation instructions\n"
        missing=true
    }
}

function get_os() {
    UNAME=$( $( command -v uname) -a | tr '[:upper:]' '[:lower:]' )

    if echo "${UNAME}" | grep -q "microsoft"; then
        printf "windows\n"
    elif echo "${UNAME}" | grep -q "darwin"; then
        printf "darwin\n"
    elif echo "${UNAME}" | grep -q "linux"; then
        printf "linux\n"
    else
        printf "unknown\n"
    fi
}


curr_os=$( get_os )

# if this script is run from Windows Git Bash (should equal to "msys") we have to put 'winpty'
# before docker command
if [ "${curr_os}" != "windows" ]; then
    alias docker='winpty docker'
fi

# check basic installations
check_installed git
check_installed docker

# congratulations, you did it!
if [ -z ${missing} ]; then
    printf "Everything seems to be installed correctly! "
    printf "Congratulations, you're all ready for the course!\n"
fi

exit 0
