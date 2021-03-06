#!/bin/bash

if [ ! -n "$1" ]
then
	echo "No print directory parameter passed.  Cannot run program. "
	exit 1
else
	PRINT_DIR=$1
fi

if [ ! -d "$PRINT_DIR" ]
then
	echo "$PRINT_DIR does not exist... cannot run program. "
	exit 1
fi

if [ ! -d "$PRINT_DIR/archive" ]
then
	echo "Creating archive folder"
	mkdir $PRINT_DIR/archive
fi

read -p 'Are you sure you want to bulk print (y/n)? ' USER_ANSWER
if [ $USER_ANSWER = 'n' ]
then
	exit 1
fi

#set shell line separator variable to newlines only --- handles file names with whitespace
OIFS="$IFS"
IFS=$'\n'

#get files in print directory and sort by name
for FILE in `find $PRINT_DIR -maxdepth 1 -type f | sort`
do 
	echo "Sending file $FILE to printer."
	lp -o ColorModel=KGray -o number-up=1 -o fit-to-page -d ENVY-Pro-6400-series $FILE
	mv $FILE $PRINT_DIR/archive
done

IFS="$OIFS"

