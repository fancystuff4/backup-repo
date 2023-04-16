#!/bin/bash
cd /home/ubuntu/backups
# Delete files older than  1 min +720 +0.5
find . -name "*.sql" -type f -mmin +720 -exec rm {} \;



BUCKET_NAME="db-backup-files-mysql"

# Set the time threshold in seconds
TIME_THRESHOLD=$((12 * 3600))  # 1 min in seconds 1 * 30

# Get a list of files in the S3 folder
file_list=$(aws s3 ls s3://$BUCKET_NAME --recursive | awk '{print $4}')

# Loop through the file list and delete files older than the time threshold
for file in $file_list; do

    mod_time=$(aws s3api head-object --bucket $BUCKET_NAME --key $file --query "LastModified" --output text | date -d "$(cat -)" +%s)


    file_age=$(( $(date +%s) - $mod_time ))

    if [ $file_age -gt $TIME_THRESHOLD ]; then
        aws s3 rm s3://$BUCKET_NAME/$file
        echo "Deleted file: $file"
    fi
done
