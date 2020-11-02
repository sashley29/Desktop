#!/bin/sh

if [ ! -n "$1" ]
then
	echo "No base directory parameter passed.  Cannot run program. "
	exit 1
else
	BASE=$1
fi

export GOOGLE_APPLICATION_CREDENTIALS=$BASE/secrets/Playground-15ed10c8f21e.json
INSTALL_SCRIPT=$BASE/scripts/install.sh
DISK_SCRIPT=$BASE/scripts/disk-usage.sh

if [ -d "$BASE/working" ]
then
	find $BASE/working -type f -mtime +2 -exec rm -f {} \;
else
	ln -s /home/shawn/Backup $BASE/working
fi

$DISK_SCRIPT
diskcheck=$(echo $?)

if [ $diskcheck -gt 0 ]
then
	echo "Not enough disk space to run backup."
	exit 1
fi

$INSTALL_SCRIPT $BASE

if [ ! -d "$BASE/secrets" ]
then
	echo "No credentials found... cannot run program. "
	exit 1
fi

if [ -f $BASE/src/DesktopBackup.py ]
then
	python3 $BASE/src/DesktopBackup.py /home $BASE/working
else
	echo "DesktopBackup program not found."
	exit 1
fi

