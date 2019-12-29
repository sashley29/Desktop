#!/bin/sh
export GOOGLE_APPLICATION_CREDENTIALS="/home/shawn/Projects/desktop_backup/env/secrets/Playground-15ed10c8f21e.json"
BASE=/home/shawn/Projects/desktop_backup/env
INSTALL_SCRIPT=$BASE/scripts/install.sh

$INSTALL_SCRIPT

if [ ! -d "$BASE/working" ]
then
	mkdir $BASE/working
fi

if [ -f $BASE/src/DesktopBackup.py ]
then
	python $BASE/src/DesktopBackup.py /home $BASE/working
else
	echo "DesktopBackup program not found."
	exit 1
fi

