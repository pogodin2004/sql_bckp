#!/bin/bash

USR=""
PWD=""
BACKUP_DIR=""
DAY="" 
 
databases=`mysql --user=$USR --password=$PWD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`
 
for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        mysqldump --force --opt --user=$USR --password=$PWD --databases $db > $BACKUP_DIR/`date +%Y%m%d`.$db.sql
        gzip $BACKUP_DIR/`date +%Y%m%d`.$db.sql
    fi
done

#du -h $BACKUP_DIR | tail -n1
#find $BACKUP_DIR -type -f -mtime +$DAY -exec rm -f {}
