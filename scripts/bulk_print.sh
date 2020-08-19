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

#set shell line separator variable to newlines only --- handles file names with whitespace
OIFS="$IFS"
IFS=$'\n'

for FILE in `find $PRINT_DIR -type f`
do 
	echo "Sending file $FILE to printer."
	lp -o ColorModel=KGray -d HP-Photosmart-6510 $FILE
done

IFS="$OIFS"

