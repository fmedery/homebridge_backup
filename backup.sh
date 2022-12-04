#!/bin/bash

#
# This script requires the "jq" package to be installed.
# Linux: apt-get install jq
# macOS: brew install jq
#

set -e -x


if ! which jq
then
    echo  "jq is missing"
    exit 1
fi

URI_HOST="http://homebridge.local:8581"
BACKUP_FILE_PATH="$(pwd)"


BACKUP_FILE_NAME="backup-$(date '+%Y-%m-%d').tar.gz"

ACCESS_TOKEN=$(curl --silent --location \
    --request POST ${URI_HOST}'/api/auth/login' \
    --header 'Content-Type: application/json' \
    --data-binary './access.json' | jq -r .access_token)

echo $ACCESS_TOKEN

# # Download Backup
curl --silent --location \
    --request GET "${URI_HOST}"'/api/backup/download' \
  -H "Authorization: bearer $ACCESS_TOKEN" \
  -o ${BACKUP_FILE_PATH}/${BACKUP_FILE_NAME}.tgz
