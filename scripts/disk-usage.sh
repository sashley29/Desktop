#!/bin/sh

df -Ph | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5,$1,$6 }' | while read output;
do
  max=75%
  echo $output
  used=$(echo $output | awk '{print $1}')
  partition=$(echo $output | awk '{print $2}')
  filepath=$(echo $output | awk '{print $3}')

  if [ ${used%?} -ge ${max%?} ] 
  then
  	echo "The partition \"$partition\" on $(hostname) at $filepath has used $used at $(date)"
	exit 1
  fi
done

