import tarfile
import os
import sys
import datetime
import socket

from Publisher import publish_desktop_message
from google.cloud import storage

SOURCEFOLDER_PATH = sys.argv[1]
ARCHIVE_PATH = sys.argv[2]
BUCKET = "sashley29_desktop_backup"
INCLUDE_FILES = ['Desktop']

def upload_blob(bucket_name, source_file_name, destination_blob_name):
    """Uploads a file to GCP bucket."""
    storage_client = storage.Client()
    bucket = storage_client.get_bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)

    try:
    	blob.upload_from_filename(source_file_name)
    except Exception as e:
    	publish_desktop_message("Could not upload backup file: \nError: " + e)

    
def filter_function(tarinfo):
	print('File name {}'.format(tarinfo.name))
	if tarinfo.name in INCLUDE_FILES:
		print('File {} included in archive...'.format(tarinfo.name))
		return tarinfo
	else:
		return None

def create_archive(sourcefolder, archivefilepath):
	
	#archive and compress with gzip
	with tarfile.open( archivefilepath, "w:gz" ) as tar:
		for dirName, subdirList, fileList in os.walk(sourcefolder):
			for subdirName in subdirList:
				if subdirName in INCLUDE_FILES:
					dirPath = os.path.join(dirName, subdirName)
					print('Compressing {}'.format(dirPath))
					tar.add(dirPath)
					print('Added {} to tar file'.format(subdirName))
	

#time format example: 20Nov2016_102345
current_time = datetime.datetime.now().strftime("%d%b%Y_%H%M%S")
computer_name = socket.gethostname()
archive_filename = "backup_" + computer_name + "_" + current_time + ".tgz"
archive_filepath = ARCHIVE_PATH + "/" + archive_filename

create_archive(SOURCEFOLDER_PATH, archive_filepath)

if os.path.getsize(archive_filepath) > 0:
	upload_blob(BUCKET, archive_filepath, archive_filename)
	publish_desktop_message("Backup completed successfully for " + archive_filename)
	os.remove(archive_filepath)
else:
	print('File {} was not compressed successfully.'.format(archive_filepath))
