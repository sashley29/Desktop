#!/bin/sh
export GOOGLE_APPLICATION_CREDENTIALS="/home/shawn/Projects/desktop_backup/env/secrets/Playground-15ed10c8f21e.json"
BASE=/home/shawn/Projects/desktop_backup/env

python $BASE/DesktopBackup.py /home $BASE/working

