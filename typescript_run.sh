#!/bin/bash
# This file is part of VPL for Moodle - http://vpl.dis.ulpgc.es/
# Script for TypeScript language using NodeJs
# Copyright (C) 2018 Juan Carlos Rodríguez-del-Pino
# License http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
# Author Juan Carlos Rodríguez-del-Pino <jcrodriguez@dis.ulpgc.es>

# @vpl_script_description Using nodejs with the first file
# load common script and check programs
. common_script.sh
check_program tsc
check_program nodejs

if [ "$1" == "version" ] ; then
	echo "#!/bin/bash" > vpl_execution
	echo "tsc -v" >> vpl_execution
	chmod +x vpl_execution
	exit
fi
export TERM=dump
get_source_files ts

# ---------------------------------------------------------------------
get_first_source_file ts

STRTS=$(cat << EOF
let _cin_: string[] = require("fs").readFileSync(0).toString().split("\n");let input = () : string => _cin_.length === 0 ? "" : _cin_.shift()!;let write = (text: any, end:string="\n")=> process.stdout.write("" + text + end);
EOF
)

export STRTS
perl -i.bak -pe 's/IMPORT_IO/$ENV{"STRJS"}/g' $FIRST_SOURCE_FILE

# ---------------------------------------------------------------------


SAVEIFS=$IFS
IFS=$'\n'
for FILENAME in $SOURCE_FILES
do
	tsc "$FILENAME" | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g'
done
IFS=$SAVEIFS

get_first_source_file ts
FIRST_SOURCE_FILE="${FIRST_SOURCE_FILE%.*}.js"
cat common_script.sh > vpl_execution
echo "nodejs \"$FIRST_SOURCE_FILE\" \$@" >> vpl_execution
chmod +x vpl_execution
