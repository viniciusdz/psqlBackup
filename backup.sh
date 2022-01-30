#!/usr/bin/env bash
# 
# ---------------------------------------------------------------- #
# Script Name:   backup.sh 
# Description:   Backup Postgresql database and update.
# Site:          https://github.com/viniciusdz
# Linkedin:      https://www.linkedin.com/in/viniciusdz/
# Written by:    Vinicius Santana
# Maintenance:   Vinicius Santana
# ---------------------------------------------------------------- 


#--------------------------------------------------------------------
 # mkdir /var/backups/postgres/
#--------------------------------------------------------------------

USER="postgres"                             #postgres user
DB_NAME="postgres"                          #dadabase name
BKP_NAME="postgres"                         # backup Prefix         
BKP_DIR=/var/backups/postgres    #Backup Dir
FILE_TYPE=_backup.sql                #backup file type
FILE_NAME=`date +"%d%m%Y%H%M"`${FILE_TYPE} # FILE NAME
DAYS_KEEP=7                                  # DAYS TO KEEP BACKUP FILES
OUTPUT=${BKP_DIR}/${FILE_NAME}               # OUTPUT FILE DIR

# NOTIFICATIONS VARS

TOKEN="$YOUR_TELEGRAM_TOKEN" #YOUR TELEGRAM BOT TOKEN.
ID="$YOUR_CHAT_ID" #YOUR TELEGRAM CHAT ID 
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
H_NAME=`hostname`
 
# BACKUP JOB

set -o pipefail 
if ! pg_dump -U ${USER} ${DB_NAME} -F p -f ${OUTPUT}; then
	curl -s -X POST $URL -d chat_id=$ID -d text="Falied to realize postgres backup of "${H_NAME}
else
	curl -s -X POST $URL -d chat_id=$ID -d text="Postgress Backup of ".${H_NAME}" succssesfully done."
fi
 
# CLEAN BACKUPS 

find $BKP_DIR -maxdepth 1 -mtime +$DAYS_KEEP -name "*${FILE_TYPE}" -exec rm -rf '{}' ';'   # DELETE OLD BACKUPS

