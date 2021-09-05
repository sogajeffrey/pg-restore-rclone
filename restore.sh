#!/bin/bash

set -e

echo "Restore Job started: $(date)"
RCLONE_CONF=/root/.config/rclone/rclone.conf

if [[ -z "${PGUSER}" ]]; then
  PGUSER=postgres
fi

if [[ -z "${PGPASSWORD}" ]]; then
  PGPASSWORD=postgres
fi

if [[ -z "${PGHOST}" ]]; then
  PGHOST=localhost
fi

if [[ -z "${PGPORT}" ]]; then
  PGPORT=5432
fi

if [[ -z "${RCLONE_REMOTE}" ]] || [[ -z "${RCLONE_PATH}" ]] || [[ -z "${BACKUP_VERSION}" ]]; then
  echo "RCLONE_REMOTE, RCLONE_PATH, and BACKUP_VERSION must be set"
  exit 1
fi

if [[ ! -f "$RCLONE_CONF" ]]; then
    echo "Please mount the /root folder which contains /root/.config/rclone/rclone.conf"
	exit 1
fi

rclone lsf ${RCLONE_REMOTE}:${RCLONE_PATH}/${BACKUP_VERSION}
file_exists=$?

if test $file_exists -eq 0
then 
  echo "Found ${BACKUP_VERSION} in ${RCLONE_PATH}...Downloading"
  rclone copy ${RCLONE_REMOTE}:${RCLONE_PATH}/${BACKUP_VERSION} /restore/${BACKUP_VERSION} -P
else
  echo "File not found...exiting"
  exit 1
fi

cd /restore

gzip -d ${BACKUP_VERSION} 

FILE=${BACKUP_VERSION%.*}

psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -f "$FILE" 

echo "Job finished: $(date)"
