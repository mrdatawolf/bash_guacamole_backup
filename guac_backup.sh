#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

day=$(date '+%Y-%m-%d-%H%M')
hostname=$(hostname -s)
file="$hostname-$day"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}
send_email() {
    #mail -s "Backup Status" user@example.com <<< "$1"
}
backup() {
    log "Starting backup process"
    mkdir -p "$DEST/$file/tomcat" "$DEST/$file/database"
    cp -ra "$BACKUP_GUACAMOLE" "$DEST/$file/guacamole"
    cp -ra $BACKUP_TOMCAT "$DEST/$file/tomcat"
    log "Files backup completed"

    log "Starting MySQL backup"
    mysqldump -v -u root --password="$DB_PASSWORD" guacamole_db > "$DEST/$file/database/guacamole_db.sql"
    if [ $? -eq 0 ]; then
        log "MySQL database backup was successful"
        send_email "Backup completed successfully"
    else
        log "MySQL database backup failed"
        send_email "Backup failed"
    fi
}

backup
