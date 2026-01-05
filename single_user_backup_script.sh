#!/bin/bash

# Variables
USERNAME="username"
BACKUP_DIR="/backup/user-backups"
DATE=$(date +"%Y-%m-%d")
LOG_FILE="/var/log/user_backup.log"

mkdir -p ${BACKUP_DIR}

echo "Backup started for user ${USERNAME} on ${DATE}" >> ${LOG_FILE}

# Home directory backup
tar -czf ${BACKUP_DIR}/${USERNAME}_home_${DATE}.tar.gz /home/${USERNAME} \
>> ${LOG_FILE} 2>&1

# User account files
grep "^${USERNAME}:" /etc/passwd > ${BACKUP_DIR}/${USERNAME}_passwd_${DATE}.txt
grep "^${USERNAME}:" /etc/shadow > ${BACKUP_DIR}/${USERNAME}_shadow_${DATE}.txt
grep "^${USERNAME}:" /etc/group  > ${BACKUP_DIR}/${USERNAME}_group_${DATE}.txt

# Crontab backup
crontab -u ${USERNAME} -l > ${BACKUP_DIR}/${USERNAME}_crontab_${DATE}.txt 2>/dev/null

echo "Backup completed for user ${USERNAME}" >> ${LOG_FILE}
echo "--------------------------------------" >> ${LOG_FILE}