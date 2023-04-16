#!/bin/bash

cd /home/ubuntu/

#Create mysql backup file
timestamp=$(date +"%Y%m%d%H%M%S")

filename=MySql-Backup-$timestamp.sql

sudo mysqldump -u "root" -p"admin" --all-databases > ./backups/$filename

echo "Created backup file $filename "


#Upload to S3
sudo aws s3 cp ./backups/$filename s3://db-backup-files-mysql
