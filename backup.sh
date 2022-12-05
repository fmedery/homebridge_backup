#!/bin/bash

set -e

URI_HOST="http://homebridge.local:8581"
BACKUP_FILE_PATH="$(pwd)/backups"


BACKUP_FILE_NAME="backup-$(date '+%Y-%m-%d').tar.gz"

ACCESS_TOKEN=$(curl --silent --location \
    --request POST ${URI_HOST}'/api/auth/login' \
    --header 'Content-Type: application/json' \
    --data-binary '@./access.json' | jq -r .access_token)

# Download Backup
curl --silent --location \
    --request GET "${URI_HOST}"'/api/backup/download' \
    -H "Authorization: bearer $ACCESS_TOKEN" \
    -o ${BACKUP_FILE_PATH}/${BACKUP_FILE_NAME}.tgz
