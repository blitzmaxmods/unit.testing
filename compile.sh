#!/bin/bash
# VERSION: 2.0
# Copy this into your module folder
# Module folder name must match the module name

# Extract module name from current folder name
FOLDER=$PWD
FOLDER=${FOLDER%%+(/)} # trim however many trailing slashes exist
FOLDER=${FOLDER##*/}   # remove everything before the last / that still remains
MODULE=${FOLDER:-/}    # correct for dirname=/ case

# Clean up old compile results
find . -name "*.a" -type f -delete
find . -name "*.i" -type f -delete
find . -name "*.o" -type f -delete
find . -name "*.s" -type f -delete

echo
echo MODULE REBUILD
echo ======================================================================
echo $MODULE
echo

# Set Blitzmax folder using environment OR default $HOME/BlitzMax
if [[ -z "${BLITZMAX}" ]]; then
  BLITZPATH="$HOME/BlitzMax/bin"
else
  BLITZPATH="${BLITZMAX}/bin"
fi

$BLITZPATH/bmk makemods -a $MODULE
#$BLITZPATH/bmk makemods -a -h $MODULE

echo
read -rp "Press enter to close ..." n1 key
exit

