#!/bin/bash
# This file is part of VPL for Moodle - http://vpl.dis.ulpgc.es/
# Script for JavaScript language using NodeJs
# Copyright (C) 2014 Juan Carlos Rodríguez-del-Pino
# License http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
# Author Juan Carlos Rodríguez-del-Pino <jcrodriguez@dis.ulpgc.es>

# @vpl_script_description Using nodejs with the first file
# load common script and check programs
. common_script.sh
check_program nodejs
if [ "$1" == "version" ] ; then
	echo "#!/bin/bash" > vpl_execution
	echo "nodejs -v" >> vpl_execution
	chmod +x vpl_execution
	exit
fi
get_first_source_file js

# ---------------------------------------------------------------------
STRJS=$(cat << EOF
let _cin_ = require("fs").readFileSync(0).toString().split("\n");let input = () => _cin_.length === 0 ? "" : _cin_.shift();let write = (text, end="\n") => process.stdout.write("" + text + end);
EOF
)

export STRJS

perl -i.bak -pe 's/IMPORT_IO/$ENV{"STRJS"}/g' $FIRST_SOURCE_FILE

# ---------------------------------------------------------------------

cat common_script.sh > vpl_execution
echo "nodejs \"$FIRST_SOURCE_FILE\" \$@" >> vpl_execution
chmod +x vpl_execution
