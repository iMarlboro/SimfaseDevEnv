#!/bin/bash
#from http://lnmp.org

Backup_Home="/vagrant/src/backup/mysql"
MySQL_Dump="/usr/bin/mysqldump"


######~Set MySQL UserName and password~######
MYSQL_UserName='root'
MYSQL_PassWord='123456'
Backup_Name=db-$(date +"%Y%m%d%H%M%S").sql


if [ ! -f ${MySQL_Dump} ]; then  
    echo "mysqldump command not found.please check your setting."
    exit 1
fi

if [ ! -d ${Backup_Home} ]; then
    mkdir -p ${Backup_Home}
fi


echo "Backup Databases..."
${MySQL_Dump} --events --ignore-table=mysql.events  --all-databases -u$MYSQL_UserName -p$MYSQL_PassWord > ${Backup_Home}/${Backup_Name}

if [ -f ${Backup_Home}/${Backup_Name} ]
then
    cp ${Backup_Home}/${Backup_Name} ${Backup_Home}/latest.sql
fi

echo "complete."