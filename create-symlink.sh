#!/bin/bash
# Version 1.0
#
# REQUIREMENTS:
# Folder should be the full module name
# If environment variable $BLITZMAX is set it is used for the
# path otherwise the script uses $HOME/BlitzMax

# SET UP THE MODULE FOLDER
if [[ -z "${BLITZMAX}" ]]; then
  MODPATH="$HOME/BlitzMax/mod"
else
  MODPATH="${BLITZMAX}/mod"
fi

# Extract current folder name
FOLDER=$PWD
#shopt -s extglob       # enable +(...) glob syntax
FOLDER=${FOLDER%%+(/)}  # trim however many trailing slashes exist
SYMLINK=${FOLDER:-/}   # correct for dirname=/ case
DIRNAME=${FOLDER##*/}   # remove everything before the last / that still remains
DIRNAME=${DIRNAME:-/}   # correct for dirname=/ case
printf 'Module: %s\n' "$DIRNAME"
#DIRNAME=${result}

# Split directory name using the "dot"
IFS='.'; MODNAME=($DIRNAME); unset IFS;
MODFOLDER="$MODPATH/${MODNAME[0]}.mod/${MODNAME[1]}.mod"
#echo ${MODNAME[0]} DOT ${MODNAME[1]} 
echo "Path:   ${MODFOLDER}"

# CREATE SYMLINK
if [[ -z "${MODNAME[1]}" ]]; then
    echo 'Current folder is not a module name (does not contain a ".")'
else
    # Create module folder
    FOLDER=$MODPATH/${MODNAME[0]}.mod/
    if [ ! -d "$FOLDER" ]; then
        mkdir $FOLDER
    fi

    # Create symlink to module
    ln -sf $SYMLINK/ ${MODFOLDER}
    echo "Module '$DIRNAME' symlink created or updated"
fi




