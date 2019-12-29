#!/bin/sh

BASE=/home/shawn/Projects/desktop_backup/env
RELEASE_URL=https://api.github.com/repos/sashley29/Desktop/releases/latest
RELEASE_FILE=desktop_backup.tar

if [ -d "$BASE" ]
then
	cd $BASE

	curl -s $RELEASE_URL | grep browser_download_url | cut -d '"' -f 4 | wget -qi -

	if [ -f "$RELEASE_FILE" ]
	then
		echo "$RELEASE_FILE downloaded successfully...installing"
		tar --overwrite -xvf $RELEASE_FILE
		rm -f $RELEASE_FILE
		echo "Install successful"
		exit 0
	else
		echo "$RELEASE_FILE not downloaded"
		exit 1
	fi
else
	echo "$BASE does not exist... can't do anything."
	exit 1
fi


