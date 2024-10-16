#!/bin/bash
#######
#Author: Bhaskara sreenivasa sarma
# Date: 16-10-2024
# Automated back up script


helper(){
if [ $# -ne 1 ]; then
  echo "Please do provide sorce file to be used for backup in format ./backup.sh /home/ubuntu/source"
  exit 1
fi

if [ ! -d "$1" ]; then
  echo "source file does not exist: $1"
  exit 1
fi
}

helper "$@"

Dest=/home/ubuntu/backup_dest
if [ ! -d "$Dest" ]; then
            mkdir -p "$Dest"
                echo " Backup folder created at $Dest"
        else
                  echo "Backup folder already exists"
fi

source=$1

echo "Backup initiation from $source to $Dest"
rsync -av --progress "$source" "$Dest"


#Using the script to perform backup to s3 bucket
timestamp=$(date +'%Y%m%d')
filename="$Dest_$timestamp"
s3_bucket="s3://backup-cron/$filename"

echo "Uploading $source to $s3_bucket"
aws s3 cp "$source" "$s3_bucket"  --recursive

if [ $? -eq 0 ]; then
        echo "backup completed"
else
        echo "Backup upload failed."
        exit 1
fi
