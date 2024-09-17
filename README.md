# bash_guacamole_backup
 script to backup a guacamole server

## .env file
#you need a file with the following format
DEST="/backup"
BACKUP_GUACAMOLE="/etc/guacamole/"
BACKUP_TOMCAT="/var/lib/tomcat9/webapps/ /var/lib/tomcat9/conf/server.xml"
LOGFILE="/backup/backup.log"
DB_PASSWORD="mysecurepassword"